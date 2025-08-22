module 0x779829966a2e8642c310bed79e6ba603e5acd3c31b25d7d4511e2c9303d6e3ef::memez_pump_config {
    struct PumpConfig has copy, drop, store {
        burn_tax: u64,
        virtual_liquidity: u64,
        target_quote_liquidity: u64,
        liquidity_provision: 0xec50242b14f7ffdc37fb91ade8490cdce2f876e7e9c3c3d7d7d98e944397d8f2::bps::BPS,
        total_supply: u64,
    }

    fun assert_values(arg0: vector<u64>) {
        assert!(0x1::vector::length<u64>(&arg0) == 5, 16);
        assert!(*0x1::vector::borrow<u64>(&arg0, 1) != 0, 13906834453516255231);
        assert!(*0x1::vector::borrow<u64>(&arg0, 2) != 0, 13906834457811222527);
        assert!(*0x1::vector::borrow<u64>(&arg0, 0) <= 6000, 24);
        assert!(*0x1::vector::borrow<u64>(&arg0, 4) != 0, 13906834470696124415);
    }

    public(friend) fun burn_tax(arg0: &PumpConfig) : u64 {
        arg0.burn_tax
    }

    public(friend) fun liquidity_provision(arg0: &PumpConfig) : u64 {
        0xec50242b14f7ffdc37fb91ade8490cdce2f876e7e9c3c3d7d7d98e944397d8f2::bps::calc(arg0.liquidity_provision, arg0.total_supply)
    }

    public fun new(arg0: vector<u64>) : PumpConfig {
        assert_values(arg0);
        PumpConfig{
            burn_tax               : *0x1::vector::borrow<u64>(&arg0, 0),
            virtual_liquidity      : *0x1::vector::borrow<u64>(&arg0, 1),
            target_quote_liquidity : *0x1::vector::borrow<u64>(&arg0, 2),
            liquidity_provision    : 0xec50242b14f7ffdc37fb91ade8490cdce2f876e7e9c3c3d7d7d98e944397d8f2::bps::new(*0x1::vector::borrow<u64>(&arg0, 3)),
            total_supply           : *0x1::vector::borrow<u64>(&arg0, 4),
        }
    }

    public(friend) fun target_quote_liquidity(arg0: &PumpConfig) : u64 {
        arg0.target_quote_liquidity
    }

    public(friend) fun total_supply(arg0: &PumpConfig) : u64 {
        arg0.total_supply
    }

    public(friend) fun virtual_liquidity(arg0: &PumpConfig) : u64 {
        arg0.virtual_liquidity
    }

    // decompiled from Move bytecode v6
}

