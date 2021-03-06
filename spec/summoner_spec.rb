describe Vigor::Summoner, :vcr do
  before(:each) do
    Vigor.configure(ENV["API_KEY"])
  end

  it "can fetch masteries" do
    summoner = Vigor.summoner("semiel")
    pages = summoner.mastery_pages
    pages.length.should == 4

    summoner.current_mastery_page.name.should == "AP"

    first_page = pages.find{|p| p.name = "Mastery Page 1"}
    first_page.should_not be_current

    hardiness = first_page.find{|t| t.name = "Hardiness"}
    hardiness.id.should == 4233
  end

  it "can fetch runes" do
    summoner = Vigor.summoner("semiel")
    pages = summoner.rune_pages
    pages.length.should == 9

    current = summoner.current_rune_page
    current.name.should == "AP/MPen/Def (AP Carry)"
    current.should be_current

    slot_1 = current.find{|r| r.slot == 1}
    slot_1.id.should == 5273
  end

  it "will grab extra information when needed" do
    Vigor.configure(ENV["API_KEY"])
    player = Vigor.recent_games("23893133").first.fellow_players.first
    player.name.should == "DerpyFoo"
    player.profile_icon_id.should == 582
    player.team_id.should == 100
  end
end
