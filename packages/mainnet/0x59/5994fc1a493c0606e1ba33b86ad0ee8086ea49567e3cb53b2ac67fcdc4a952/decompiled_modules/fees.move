module 0xcfbcad8e0444ca85ad7ee28054585d12a7487bdbd83569ded988ca13441bf16e::fees {
    struct FeeConfig has store {
        sui_mint_fee_bps: u64,
        staked_sui_mint_fee_bps: u64,
        redeem_fee_bps: u64,
        staked_sui_redeem_fee_bps: u64,
        spread_fee_bps: u64,
        custom_redeem_fee_bps: u64,
        extra_fields: 0x2::bag::Bag,
    }

    struct FeeConfigBuilder {
        fields: 0x2::bag::Bag,
    }

    public(friend) fun calculate_mint_fee(arg0: &FeeConfig, arg1: u64) : u64 {
        if (arg0.sui_mint_fee_bps == 0) {
            return 0
        };
        ((((arg1 as u128) * (arg0.sui_mint_fee_bps as u128) + 9999) / 10000) as u64)
    }

    public(friend) fun calculate_redeem_fee(arg0: &FeeConfig, arg1: u64) : u64 {
        if (arg0.redeem_fee_bps == 0) {
            return 0
        };
        ((((arg1 as u128) * (arg0.redeem_fee_bps as u128) + 9999) / 10000) as u64)
    }

    public fun custom_redeem_fee_bps(arg0: &FeeConfig) : u64 {
        arg0.custom_redeem_fee_bps
    }

    public fun destroy(arg0: FeeConfig) {
        let FeeConfig {
            sui_mint_fee_bps          : _,
            staked_sui_mint_fee_bps   : _,
            redeem_fee_bps            : _,
            staked_sui_redeem_fee_bps : _,
            spread_fee_bps            : _,
            custom_redeem_fee_bps     : _,
            extra_fields              : v6,
        } = arg0;
        0x2::bag::destroy_empty(v6);
    }

    public fun new_builder(arg0: &mut 0x2::tx_context::TxContext) : FeeConfigBuilder {
        FeeConfigBuilder{fields: 0x2::bag::new(arg0)}
    }

    public fun redeem_fee_bps(arg0: &FeeConfig) : u64 {
        arg0.redeem_fee_bps
    }

    public fun set_custom_redeem_fee_bps(arg0: FeeConfigBuilder, arg1: u64) : FeeConfigBuilder {
        0x2::bag::add<vector<u8>, u64>(&mut arg0.fields, b"custom_redeem_fee_bps", arg1);
        arg0
    }

    public fun set_redeem_fee_bps(arg0: FeeConfigBuilder, arg1: u64) : FeeConfigBuilder {
        0x2::bag::add<vector<u8>, u64>(&mut arg0.fields, b"redeem_fee_bps", arg1);
        arg0
    }

    public fun set_spread_fee_bps(arg0: FeeConfigBuilder, arg1: u64) : FeeConfigBuilder {
        0x2::bag::add<vector<u8>, u64>(&mut arg0.fields, b"spread_fee_bps", arg1);
        arg0
    }

    public fun set_staked_sui_mint_fee_bps(arg0: FeeConfigBuilder, arg1: u64) : FeeConfigBuilder {
        0x2::bag::add<vector<u8>, u64>(&mut arg0.fields, b"staked_sui_mint_fee_bps", arg1);
        arg0
    }

    public fun set_staked_sui_redeem_fee_bps(arg0: FeeConfigBuilder, arg1: u64) : FeeConfigBuilder {
        0x2::bag::add<vector<u8>, u64>(&mut arg0.fields, b"staked_sui_redeem_fee_bps", arg1);
        arg0
    }

    public fun set_sui_mint_fee_bps(arg0: FeeConfigBuilder, arg1: u64) : FeeConfigBuilder {
        0x2::bag::add<vector<u8>, u64>(&mut arg0.fields, b"sui_mint_fee_bps", arg1);
        arg0
    }

    public fun spread_fee_bps(arg0: &FeeConfig) : u64 {
        arg0.spread_fee_bps
    }

    public fun staked_sui_mint_fee_bps(arg0: &FeeConfig) : u64 {
        arg0.staked_sui_mint_fee_bps
    }

    public fun staked_sui_redeem_fee_bps(arg0: &FeeConfig) : u64 {
        arg0.staked_sui_redeem_fee_bps
    }

    public fun sui_mint_fee_bps(arg0: &FeeConfig) : u64 {
        arg0.sui_mint_fee_bps
    }

    public fun to_fee_config(arg0: FeeConfigBuilder) : FeeConfig {
        let FeeConfigBuilder { fields: v0 } = arg0;
        let v1 = if (0x2::bag::contains<vector<u8>>(&v0, b"sui_mint_fee_bps")) {
            0x2::bag::remove<vector<u8>, u64>(&mut v0, b"sui_mint_fee_bps")
        } else {
            0
        };
        let v2 = if (0x2::bag::contains<vector<u8>>(&v0, b"staked_sui_mint_fee_bps")) {
            0x2::bag::remove<vector<u8>, u64>(&mut v0, b"staked_sui_mint_fee_bps")
        } else {
            0
        };
        let v3 = if (0x2::bag::contains<vector<u8>>(&v0, b"redeem_fee_bps")) {
            0x2::bag::remove<vector<u8>, u64>(&mut v0, b"redeem_fee_bps")
        } else {
            0
        };
        let v4 = if (0x2::bag::contains<vector<u8>>(&v0, b"staked_sui_redeem_fee_bps")) {
            0x2::bag::remove<vector<u8>, u64>(&mut v0, b"staked_sui_redeem_fee_bps")
        } else {
            0
        };
        let v5 = if (0x2::bag::contains<vector<u8>>(&v0, b"spread_fee_bps")) {
            0x2::bag::remove<vector<u8>, u64>(&mut v0, b"spread_fee_bps")
        } else {
            0
        };
        let v6 = if (0x2::bag::contains<vector<u8>>(&v0, b"custom_redeem_fee_bps")) {
            0x2::bag::remove<vector<u8>, u64>(&mut v0, b"custom_redeem_fee_bps")
        } else {
            0
        };
        let v7 = FeeConfig{
            sui_mint_fee_bps          : v1,
            staked_sui_mint_fee_bps   : v2,
            redeem_fee_bps            : v3,
            staked_sui_redeem_fee_bps : v4,
            spread_fee_bps            : v5,
            custom_redeem_fee_bps     : v6,
            extra_fields              : v0,
        };
        validate_fees(&v7);
        v7
    }

    fun validate_fees(arg0: &FeeConfig) {
        assert!(arg0.sui_mint_fee_bps <= 10000, 0);
        assert!(arg0.staked_sui_mint_fee_bps <= 10000, 0);
        assert!(arg0.redeem_fee_bps <= 500, 0);
        assert!(arg0.staked_sui_redeem_fee_bps <= 10000, 0);
        assert!(arg0.spread_fee_bps <= 10000, 0);
        assert!(arg0.custom_redeem_fee_bps <= 10000, 0);
    }

    // decompiled from Move bytecode v6
}

