module 0xeaa8fa15ffe040dcf3e5d0d2611826953e7951269086d2e87a343c8c8b242ec9::memez_stable_config {
    struct StableConfig has copy, drop, store {
        target_quote_liquidity: u64,
        liquidity_provision: 0xec50242b14f7ffdc37fb91ade8490cdce2f876e7e9c3c3d7d7d98e944397d8f2::bps::BPS,
        meme_sale_amount: 0xec50242b14f7ffdc37fb91ade8490cdce2f876e7e9c3c3d7d7d98e944397d8f2::bps::BPS,
        total_supply: u64,
    }

    fun assert_values(arg0: vector<u64>) {
        assert!(0x1::vector::length<u64>(&arg0) == 4, 16);
        assert!(*0x1::vector::borrow<u64>(&arg0, 0) != 0, 13906834419156516863);
        assert!(*0x1::vector::borrow<u64>(&arg0, 1) != 0, 13906834423451484159);
        assert!(*0x1::vector::borrow<u64>(&arg0, 2) != 0, 13906834427746451455);
        assert!(*0x1::vector::borrow<u64>(&arg0, 3) != 0, 13906834432041418751);
    }

    public(friend) fun liquidity_provision(arg0: &StableConfig) : u64 {
        0xec50242b14f7ffdc37fb91ade8490cdce2f876e7e9c3c3d7d7d98e944397d8f2::bps::calc(arg0.liquidity_provision, arg0.total_supply)
    }

    public(friend) fun meme_sale_amount(arg0: &StableConfig) : u64 {
        0xec50242b14f7ffdc37fb91ade8490cdce2f876e7e9c3c3d7d7d98e944397d8f2::bps::calc(arg0.meme_sale_amount, arg0.total_supply)
    }

    public fun new(arg0: vector<u64>) : StableConfig {
        assert_values(arg0);
        StableConfig{
            target_quote_liquidity : *0x1::vector::borrow<u64>(&arg0, 0),
            liquidity_provision    : 0xec50242b14f7ffdc37fb91ade8490cdce2f876e7e9c3c3d7d7d98e944397d8f2::bps::new(*0x1::vector::borrow<u64>(&arg0, 1)),
            meme_sale_amount       : 0xec50242b14f7ffdc37fb91ade8490cdce2f876e7e9c3c3d7d7d98e944397d8f2::bps::new(*0x1::vector::borrow<u64>(&arg0, 2)),
            total_supply           : *0x1::vector::borrow<u64>(&arg0, 3),
        }
    }

    public(friend) fun target_quote_liquidity(arg0: &StableConfig) : u64 {
        arg0.target_quote_liquidity
    }

    public(friend) fun total_supply(arg0: &StableConfig) : u64 {
        arg0.total_supply
    }

    // decompiled from Move bytecode v6
}

