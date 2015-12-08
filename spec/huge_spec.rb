describe "humongous tree" do
  1200.times do
    case rand(3)
    when 0
      it "IS OK" do
      end
    when 1
      it "IS PENDING"
    when 2
      it "IS FAILING" do
        raise "NO"
      end
    end

    it "is sometimes fail sometimes pending" do
    end
  end
end
