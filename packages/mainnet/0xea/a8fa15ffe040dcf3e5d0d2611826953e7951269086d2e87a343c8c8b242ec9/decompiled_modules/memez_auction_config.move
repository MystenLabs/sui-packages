module 0xeaa8fa15ffe040dcf3e5d0d2611826953e7951269086d2e87a343c8c8b242ec9::memez_auction_config {
    struct AuctionConfig has copy, drop, store {
        auction_duration: u64,
        target_quote_liquidity: u64,
        liquidity_provision: 0xec50242b14f7ffdc37fb91ade8490cdce2f876e7e9c3c3d7d7d98e944397d8f2::bps::BPS,
        seed_liquidity: 0xec50242b14f7ffdc37fb91ade8490cdce2f876e7e9c3c3d7d7d98e944397d8f2::bps::BPS,
        total_supply: u64,
    }

    fun assert_values(arg0: vector<u64>) {
        assert!(0x1::vector::length<u64>(&arg0) == 5, 16);
        assert!(*0x1::vector::borrow<u64>(&arg0, 0) != 0, 13906834453516255231);
        assert!(*0x1::vector::borrow<u64>(&arg0, 1) != 0, 13906834457811222527);
        assert!(*0x1::vector::borrow<u64>(&arg0, 2) != 0, 13906834462106189823);
        assert!(*0x1::vector::borrow<u64>(&arg0, 3) != 0, 13906834466401157119);
        assert!(*0x1::vector::borrow<u64>(&arg0, 4) != 0, 13906834470696124415);
    }

    public(friend) fun auction_duration(arg0: &AuctionConfig) : u64 {
        arg0.auction_duration
    }

    public(friend) fun liquidity_provision(arg0: &AuctionConfig) : u64 {
        0xec50242b14f7ffdc37fb91ade8490cdce2f876e7e9c3c3d7d7d98e944397d8f2::bps::calc(arg0.liquidity_provision, arg0.total_supply)
    }

    public fun new(arg0: vector<u64>) : AuctionConfig {
        assert_values(arg0);
        AuctionConfig{
            auction_duration       : *0x1::vector::borrow<u64>(&arg0, 0),
            target_quote_liquidity : *0x1::vector::borrow<u64>(&arg0, 1),
            liquidity_provision    : 0xec50242b14f7ffdc37fb91ade8490cdce2f876e7e9c3c3d7d7d98e944397d8f2::bps::new(*0x1::vector::borrow<u64>(&arg0, 2)),
            seed_liquidity         : 0xec50242b14f7ffdc37fb91ade8490cdce2f876e7e9c3c3d7d7d98e944397d8f2::bps::new(*0x1::vector::borrow<u64>(&arg0, 3)),
            total_supply           : *0x1::vector::borrow<u64>(&arg0, 4),
        }
    }

    public(friend) fun seed_liquidity(arg0: &AuctionConfig) : u64 {
        0x1::u64::max(0xec50242b14f7ffdc37fb91ade8490cdce2f876e7e9c3c3d7d7d98e944397d8f2::bps::calc(arg0.seed_liquidity, arg0.total_supply), 100)
    }

    public(friend) fun target_quote_liquidity(arg0: &AuctionConfig) : u64 {
        arg0.target_quote_liquidity
    }

    public(friend) fun total_supply(arg0: &AuctionConfig) : u64 {
        arg0.total_supply
    }

    // decompiled from Move bytecode v6
}

