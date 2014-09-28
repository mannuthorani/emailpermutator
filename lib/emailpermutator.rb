require 'json'

class EmailPermutator
  def initialize(input, namefield, presetdomain, chosendomain, urlfield, formattype)
    @input = JSON.parse(input)
    @namefield = namefield
    @urlfield = urlfield
    @presetdomain = presetdomain
    @chosendomain = chosendomain
    @emaillist = Array.new
    @formattype = formattype
  end

  # Get emails of all formats
  def genemails
    nametrack = Array.new

    @input.each do |i|
      # Parse domain
      if @presetdomain == false
        domain = parseurl(i[@urlfield])
      else
        domain = @chosendomain
      end

      if i[@namefield] && domain
        name = parsename(i[@namefield])
        
        # Check if combination already exists
        if name && domain
          namedomain = name[0] + name[1] + domain
          if !(nametrack.include? namedomain)
            nametrack.push(namedomain)

            # To-Do for next build
            # if @formattype == "all"
            #   itememails = tryallformats(name, domain)
            # else
            #   itememails = tryoneformat(name, domain, @formattype)
            # end

            itememails = tryallformats(name, domain)

            i["emails"] = itememails
          end
        end
      end
    end
  end

  # Get emails in all formats
  def tryallformats(name, domain)
    itememails = Array.new
    fn = name[0]
    ln = name[1]

    # Generate emails                                                                                                     
    itememails.push(fn + "@" + domain)
    itememails.push(ln + "@" + domain)
    itememails.push(fn + ln + "@" + domain)
    itememails.push(fn + "." + ln + "@" + domain)
    itememails.push(fi + ln + "@" + domain)
    itememails.push(fi + "." + ln + "@" + domain)
    itememails.push(fn + li + "@" + domain)
    itememails.push(fn + "." + li + "@" + domain)
    itememails.push(fi + li + "@" + domain)
    itememails.push(fi + "." + li + "@" + domain)
    itememails.push(ln + fn + "@" + domain)
    itememails.push(ln + "." + fn + "@" + domain)
    itememails.push(ln + fi + "@" + domain)
    itememails.push(ln + "." + fi + "@" + domain)
    itememails.push(li + fn + "@" + domain)
    itememails.push(li + "." + fn + "@" + domain)
    itememails.push(li + fi + "@" + domain)
    itememails.push(li + "." + fi + "@" + domain)
    itememails.push(fi + mi + ln + "@" + domain)
    itememails.push(fi + mi + "." + ln + "@" + domain)
    itememails.push(fn + mi + ln + "@" + domain)
    itememails.push(fn + "." + mi + "." + ln + "@" + domain)
    itememails.push(fn + mn + ln + "@" + domain)
    itememails.push(fn + "." + mn + "." + ln + "@" + domain)
    itememails.push(fn + "-" + ln + "@" + domain)
    itememails.push(fi + "-" + ln + "@" + domain)
    itememails.push(fn + "-" + li + "@" + domain)
    itememails.push(fi + "-" + li + "@" + domain)
    itememails.push(ln + "-" + fn + "@" + domain)
    itememails.push(ln + "-" + fi + "@" + domain)
    itememails.push(li + "-" + fn + "@" + domain)
    itememails.push(li + "-" + fi + "@" + domain)
    itememails.push(fi + mi + "-" + ln + "@" + domain)
    itememails.push(fn + "-" + mi + "-" + ln + "@" + domain)
    itememails.push(fn + "-" + mn + "-" + ln + "@" + domain)
    itememails.push(fn + "_" + ln + "@" + domain)
    itememails.push(fi + "_" + ln + "@" + domain)
    itememails.push(fn + "_" + li + "@" + domain)
    itememails.push(fi + "_" + li + "@" + domain)
    itememails.push(ln + "_" + fn + "@" + domain)
    itememails.push(ln + "_" + fi + "@" + domain)
    itememails.push(li + "_" + fn + "@" + domain)
    itememails.push(li + "_" + fi + "@" + domain)
    itememails.push(fi + mi + "_" + ln + "@" + domain)
    itememails.push(fn + "_" + mi + "_" + ln + "@" + domain)
    itememails.push(fn + "_" + mn + "_" + ln + "@" + domain)
    itememails.each do |e|
      @emaillist.push(e)
    end

    return itememails
  end

  # Parse url to get just the domain
  def parseurl(url)
    parsed = url.gsub("http://", "").gsub("www.", "")
    split = parsed.split("/")
    if split[0]
      return split[0]
    end
  end

  # Gets first and last name and removes certain characters
  def parsename(name)
    splitn = name.split(" ")
    first = splitn.first.gsub("'", "").gsub("-", "").gsub(".", "")
    last = splitn.last.gsub("'", "").gsub("-", "").gsub(".", "")
    narray = [first.downcase, last.downcase]
    return narray
  end

  # Get list of just emails
  def emaillist
    return JSON.pretty_generate(@emaillist)
  end

  # Get JSON with emails appended
  def jsonwithemails
    return JSON.pretty_generate(@input)
  end
end
