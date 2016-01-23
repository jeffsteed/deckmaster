module ApplicationHelper
  # returns the full title per page
  def full_title(page_title = '')
    base_title = "Decksmith"
    if page_title.empty?
      base_title
    else
      page_title + " | " + base_title
    end
  end
end
