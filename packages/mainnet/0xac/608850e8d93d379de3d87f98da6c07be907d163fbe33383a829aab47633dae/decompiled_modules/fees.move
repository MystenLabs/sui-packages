module 0xac608850e8d93d379de3d87f98da6c07be907d163fbe33383a829aab47633dae::fees {
    struct FeeConfig has store {
        sui_mint_fee_bps: u64,
        staked_sui_mint_fee_bps: u64,
        redeem_fee_bps: u64,
        staked_sui_redeem_fee_bps: u64,
        spread_fee_bps: u64,
        flash_stake_fee_bps: u64,
        custom_redeem_fee_bps: u64,
        redeem_fee_distribution_component_bps: u64,
        extra_fields: 0x2::bag::Bag,
    }

    struct FeeConfigBuilder {
        fields: 0x2::bag::Bag,
    }

    struct FeeChangeEvent has copy, drop {
        typename: 0x1::type_name::TypeName,
        sui_mint_fee_bps: u64,
        staked_sui_mint_fee_bps: u64,
        redeem_fee_bps: u64,
        staked_sui_redeem_fee_bps: u64,
        spread_fee_bps: u64,
        flash_stake_fee_bps: u64,
        custom_redeem_fee_bps: u64,
        redeem_fee_distribution_component_bps: u64,
    }

    public(friend) fun calculate_distribution_component_fee(arg0: &FeeConfig, arg1: u64) : u64 {
        if (arg0.redeem_fee_distribution_component_bps == 0) {
            return 0
        };
        ((((arg1 as u128) * (arg0.redeem_fee_distribution_component_bps as u128) + 9999) / 10000) as u64)
    }

    public(friend) fun calculate_flash_stake_fee(arg0: &FeeConfig, arg1: u64) : u64 {
        if (arg0.flash_stake_fee_bps == 0) {
            return 0
        };
        ((((arg1 as u128) * (arg0.flash_stake_fee_bps as u128) + 9999) / 10000) as u64)
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
            sui_mint_fee_bps                      : _,
            staked_sui_mint_fee_bps               : _,
            redeem_fee_bps                        : _,
            staked_sui_redeem_fee_bps             : _,
            spread_fee_bps                        : _,
            flash_stake_fee_bps                   : _,
            custom_redeem_fee_bps                 : _,
            redeem_fee_distribution_component_bps : _,
            extra_fields                          : v8,
        } = arg0;
        0x2::bag::destroy_empty(v8);
    }

    public(friend) fun emit_fee_change_event<T0>(arg0: &FeeConfig) {
        let v0 = FeeChangeEvent{
            typename                              : 0x1::type_name::get<T0>(),
            sui_mint_fee_bps                      : arg0.sui_mint_fee_bps,
            staked_sui_mint_fee_bps               : arg0.staked_sui_mint_fee_bps,
            redeem_fee_bps                        : arg0.redeem_fee_bps,
            staked_sui_redeem_fee_bps             : arg0.staked_sui_redeem_fee_bps,
            spread_fee_bps                        : arg0.spread_fee_bps,
            flash_stake_fee_bps                   : arg0.flash_stake_fee_bps,
            custom_redeem_fee_bps                 : arg0.custom_redeem_fee_bps,
            redeem_fee_distribution_component_bps : arg0.redeem_fee_distribution_component_bps,
        };
        0xac608850e8d93d379de3d87f98da6c07be907d163fbe33383a829aab47633dae::events::emit_event<FeeChangeEvent>(v0);
    }

    public fun flash_stake_fee_bps(arg0: &FeeConfig) : u64 {
        arg0.flash_stake_fee_bps
    }

    public fun new_builder(arg0: &mut 0x2::tx_context::TxContext) : FeeConfigBuilder {
        FeeConfigBuilder{fields: 0x2::bag::new(arg0)}
    }

    public fun redeem_fee_bps(arg0: &FeeConfig) : u64 {
        arg0.redeem_fee_bps
    }

    public fun redeem_fee_distribution_component_bps(arg0: &FeeConfig) : u64 {
        arg0.redeem_fee_distribution_component_bps
    }

    public fun set_custom_redeem_fee_bps(arg0: FeeConfigBuilder, arg1: u64) : FeeConfigBuilder {
        0x2::bag::add<vector<u8>, u64>(&mut arg0.fields, b"custom_redeem_fee_bps", arg1);
        arg0
    }

    public fun set_flash_stake_fee_bps(arg0: FeeConfigBuilder, arg1: u64) : FeeConfigBuilder {
        0x2::bag::add<vector<u8>, u64>(&mut arg0.fields, b"flash_stake_fee_bps", arg1);
        arg0
    }

    public fun set_redeem_fee_bps(arg0: FeeConfigBuilder, arg1: u64) : FeeConfigBuilder {
        0x2::bag::add<vector<u8>, u64>(&mut arg0.fields, b"redeem_fee_bps", arg1);
        arg0
    }

    public fun set_redeem_fee_distribution_component_bps(arg0: FeeConfigBuilder, arg1: u64) : FeeConfigBuilder {
        0x2::bag::add<vector<u8>, u64>(&mut arg0.fields, b"redeem_fee_distribution_component_bps", arg1);
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
        let v6 = if (0x2::bag::contains<vector<u8>>(&v0, b"flash_stake_fee_bps")) {
            0x2::bag::remove<vector<u8>, u64>(&mut v0, b"flash_stake_fee_bps")
        } else {
            0
        };
        let v7 = if (0x2::bag::contains<vector<u8>>(&v0, b"redeem_fee_distribution_component_bps")) {
            0x2::bag::remove<vector<u8>, u64>(&mut v0, b"redeem_fee_distribution_component_bps")
        } else {
            0
        };
        let v8 = if (0x2::bag::contains<vector<u8>>(&v0, b"custom_redeem_fee_bps")) {
            0x2::bag::remove<vector<u8>, u64>(&mut v0, b"custom_redeem_fee_bps")
        } else {
            0
        };
        let v9 = FeeConfig{
            sui_mint_fee_bps                      : v1,
            staked_sui_mint_fee_bps               : v2,
            redeem_fee_bps                        : v3,
            staked_sui_redeem_fee_bps             : v4,
            spread_fee_bps                        : v5,
            flash_stake_fee_bps                   : v6,
            custom_redeem_fee_bps                 : v8,
            redeem_fee_distribution_component_bps : v7,
            extra_fields                          : v0,
        };
        validate_fees(&v9);
        v9
    }

    fun validate_fees(arg0: &FeeConfig) {
        assert!(arg0.sui_mint_fee_bps <= 1000, 0);
        assert!(arg0.staked_sui_mint_fee_bps <= 1000, 0);
        assert!(arg0.redeem_fee_bps <= 500, 0);
        assert!(arg0.staked_sui_redeem_fee_bps <= 1000, 0);
        assert!(arg0.spread_fee_bps <= 1000, 0);
        assert!(arg0.flash_stake_fee_bps <= 1000, 0);
        assert!(arg0.redeem_fee_distribution_component_bps <= 10000, 0);
        assert!(arg0.custom_redeem_fee_bps <= 1000, 0);
    }

    // decompiled from Move bytecode v6
}

