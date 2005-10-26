require 'rexml/document'

include REXML

document = Document.new( File.new("website.xml") )

def outputTop(f, page)
  title = page.attributes["title"].downcase
  f.puts "<!DOCTYPE HTML PUBLIC \"-//W3C//DTD HTML 4.01 Transitional//EN\""
  f.puts "\"http://www.w3.org/TR/html4/loose.dtd\">"
  f.puts "<html>"
  f.puts "<head>"
  f.puts "<title>QuickFix: Open Source FIX Engine</title>"
  f.puts "<meta http-equiv=\"Content-Type\" content=\"text/html; charset=iso-8859-1\">"
  f.puts "<link href=\"css/styleGuide.css\" rel=\"stylesheet\" type=\"text/css\">"
  f.puts "</head>"
  f.puts "<body>"
  f.puts "<table cellspacing=\"0\" cellpadding=\"0\" width=\"100%\">"
  f.puts "<tr>"
  f.puts "<td height=\"1\" class=\"bordercolor\" colspan=\"3\"><img src=\"img/blank.gif\" class=\"spacer\" alt=\"\"></td>"
  f.puts "</tr>"
  f.puts "<tr>"
  f.puts "<td width=\"1\" class=\"bordercolor\"><img src=\"img/blank.gif\" class=\"spacer\" alt=\"\"></td>"
  f.puts "<td>"
  f.puts "<table cellspacing=\"0\" cellpadding=\"0\" width=\"100%\">"
  f.puts "<tr>"
  f.puts "<td>"
  f.puts "<table cellpadding=\"0\" cellspacing=\"0\" border=\"0\" width=\"100%\">"
  f.puts "<tr>"
  f.puts "<td class=\"topheader\"><img src=\"img/grayDots.gif\" hspace=\"15\" vspace=\"3\" alt=\"\"></td>"
  f.puts "</tr>"
  f.puts "</table>"
  f.puts "</td>"
  f.puts "</tr>"
  f.puts "<tr>"
  f.puts "<td>"
  f.puts "<table cellpadding=\"0\" cellspacing=\"0\" border=\"0\" width=\"100%\" background=\"img/grid.gif\">"
  f.puts "<tr>"
  f.puts "<td><a href=\"index.html\"><img src=\"img/logo.gif\" alt=\"QuickFIX\"></a></td>"
  f.puts "<td align=\"right\"><img src=\"img/#{title}Title.gif\" alt=\"#{title}\"></td>"
  f.puts "</tr>"
  f.puts "</table>"
  f.puts "</td>"
  f.puts "</tr>"
end

def outputBottom(f)
f.puts "<tr>"
f.puts "</tr>"
f.puts "</table>"
f.puts "</td>"
f.puts "<td width=\"1\" class=\"bordercolor\"><img src=\"img/blank.gif\" class=\"spacer\" alt=\"\"></td>"
f.puts "</tr>"
f.puts "<tr>"
f.puts "<td height=\"1\" class=\"bordercolor\" colspan=\"3\"><img src=\"img/blank.gif\" class=\"spacer\" alt=\"\"></td>"
f.puts "</tr>"
f.puts "</table>"
f.puts "</body>"
f.puts "</html>"
end

def outputHeader(f, page, document)
  f.puts "<tr>"
  f.puts "<td class=\"navoff\">"
  f.puts "<table cellpadding=\"4\" cellspacing=\"0\" border=\"0\">"
  f.puts "<tr>"
  title = page.attributes["title"].downcase

  last = document.elements["/website/page[position()=last()]"]

  document.elements.each { |element|
    element.elements.each("page") { |page|
      pageTitle = page.attributes["title"].downcase
      if( pageTitle == title )
	f.puts "<td class=\"navon\"><a href=\"#{pageTitle}.html\"><img src=\"img/#{pageTitle}On.gif\" alt=\"#{pageTitle}\"></a></td>"
      else
	f.puts "<td class=\"navoff\"><a href=\"#{pageTitle}.html\"><img src=\"img/#{pageTitle}Off.gif\" alt=\"#{pageTitle}\"></a></td>"
      end
      if( page != last )
      then
	f.puts "<td><img src=\"img/navDots.gif\" alt=\"::\"></td>"
      end
    }
  }
  f.puts "</tr>"
  f.puts "</table>"
  f.puts "</td>"
  f.puts "</tr>"
end

def outputPage(f, page)
  page.elements.each("section") { |section|
    title = section.attributes["title"]
    if( title != nil )
      f.puts "<tr>"
      f.puts "<td align=\"right\"><img src=\"img/dots.gif\" width=\"52\" height=\"11\" hspace=\"5\" alt=\">>>>>\"></td>"
      f.puts "<td valign=\"top\" class=\"headertext\">#{title}</td>"
      f.puts "</tr>"
    end
    f.puts "<tr>"
    f.puts "<td>&nbsp;</td>"
    f.puts "<td class=\"bodytext\">"
    f.puts section.cdatas
    f.puts "<br/>"
    f.puts "</td>"
    f.puts "</tr>"
    f.puts "<tr>"
    f.puts "<td colspan=\"2\"></td>"
    f.puts "</tr>"
  }
end

def outputStatic(f, static)
  title = static.attributes["title"].downcase
  f.puts "<table cellpadding=\"0\" cellspacing=\"0\" border=\"0\">"
  f.puts "<tr>"
  f.puts "<td class=\"calloutborder\" height=\"1\" colspan=\"3\"><img src=\"img/blank.gif\" class=\"spacer\" alt=\"\"></td>"
  f.puts "</tr>"
  f.puts "<tr>"
  f.puts "<td class=\"calloutborder\" width=\"1\"><img src=\"img/blank.gif\" class=\"spacer\" alt=\"\"></td>"
  f.puts "<td>"
  f.puts "<table cellpadding=\"0\" cellspacing=\"0\" border=\"0\" width=\"210\">"
  f.puts "<tr class=\"calloutcolor\" height=\"23\">"
  f.puts "<td align=\"left\"><img src=\"img/#{title}Callout.gif\" border=\"0\" alt=\"#{title}\" hspace=\"3\"></td>"
  f.puts "<td align=\"right\"><img src=\"img/arrows.gif\" border=\"0\" alt=\"\" hspace=\"3\"></td>"
  f.puts "</tr>"
  f.puts "<tr>"
  f.puts "<td colspan=\"2\" align=\"left\">"
  f.puts "<table cellpadding=\"3\" cellspacing=\"0\" border=\"0\">"
  f.puts "<tr>"
  f.puts "<td valign=\"top\"><img src=\"img/newsDots.gif\" alt=\"::\" border=\"0\" vspace=\"5\"></td>"
  f.puts "<td valign=\"top\" class=\"callouttext\">"
  f.puts static.cdatas
  f.puts "</td>"
  f.puts "</tr>"
  f.puts "</table>"
  f.puts "</td>"
  f.puts "</tr>"
  f.puts "</table>"
  f.puts "</td>"
  f.puts "<td class=\"calloutborder\" width=\"1\"><img src=\"img/blank.gif\" class=\"spacer\" alt=\"\"></td>"
  f.puts "</tr>"
  f.puts "<tr>"
  f.puts "<td class=\"calloutborder\" height=\"1\" colspan=\"3\"><img src=\"img/blank.gif\" class=\"spacer\" alt=\"\"></td>"
  f.puts "</tr>"
  f.puts "</table><br>"
end

document.elements.each { |element|
  element.elements.each("page") { |page|
    title = page.attributes["title"].downcase
    f = File.open("#{title}.html", "w+")
    outputTop(f, page)
    outputHeader(f, page, document)
    f.puts "<tr>"
    f.puts "<td width=\"100%\" bgcolor=\"#FFFFFF\">"
    f.puts "<table cellpadding=\"15\" cellspacing=\"0\" border=\"0\" width=\"100%\">"
    f.puts "<tr>"
    f.puts "<td align=\"left\" valign=\"top\"><br>"
    f.puts "<table cellpadding=\"0\" cellspacing=\"0\" border=\"0\" width=\"90%\">"
    outputPage(f, page)
    f.puts "</table>"
    f.puts "</td>"
    f.puts "<td align=\"right\" valign=\"top\"><br>"
    f.puts "<table cellpadding=\"0\" cellspacing=\"0\" border=\"0\">"
    element.elements.each("static") { |static|
      staticTitle = static.attributes["title"].downcase
      if( title != staticTitle ) then
	outputStatic(f, static)
      end
    }
    f.puts "<table>"
    f.puts "<tr>"
    f.puts "<td>"
    f.puts "<p align=\"center\" class=\"sidetext\">"
    f.puts "Source Code Hosted By"
    f.puts "</p>"
    f.puts "<a href=\"http://sourceforge.net\"><IMG src=\"http://sourceforge.net/sflogo.php?group_id=37535&amp;type=5\" width=\"210\" height=\"62\" border=\"0\" alt=\"SourceForge.net Logo\"></a>"
    f.puts "</td>"
    f.puts "</tr>"
    f.puts "<tr>"
    f.puts "<td>"
    f.puts "<p align=\"center\" class=\"sidetext\">"
    f.puts "Website Design By <a href=\"mailto:ABLewis@thoughtworks.com\">Anne B. Lewis</a> Of"
    f.puts "</p>"
    f.puts "<a href=\"http://www.thoughtworks.com\"><IMG src=\"img/thoughtworks.jpg\" width=\"210\" height=\"61\" border=\"0\" alt=\"ThoughtWorks Logo\"></a>"
    f.puts "</td>"
    f.puts "</tr>"
    if( title != "services" )
      f.puts "<td>"
      f.puts "<p align=\"center\" class=\"sidetext\">"
      f.puts "<a href=\"services.html\"/>Customer Support And Consulting By</a>"
      f.puts "</p>"
      f.puts "<a href=\"http://www.connamara.com\"><IMG src=\"img/connamara.gif\" width=\"210\" height=\"33\" border=\"0\" alt=\"Connamara Logo\"></a>"
      f.puts "</td>"
      f.puts "</tr>"
      f.puts "<tr>"
      f.puts "<td>"
      f.puts "<a href=\"http://www.macd.com\"><IMG src=\"img/macd.gif\" width=\"210\" height=\"60\" border=\"0\" alt=\"Macdonald Associates Logo\"></a>"
      f.puts "</td>"
    end
    f.puts "</tr>"
    f.puts "</tr>"
    f.puts "</table>"
    f.puts "</table>"
    f.puts "</td>"
    f.puts "</tr>"
    outputBottom(f)
  }
}