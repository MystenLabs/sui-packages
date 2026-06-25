module 0xacb076e99b227bdb98685ee3537b9e89e79bff6cdaf8318e4afefdad7ba69c45::funding_index {
    struct FundingState has copy, drop, store {
        global_funding_index: u128,
        global_funding_index_is_negative: bool,
        short_borrow_index: u128,
        last_update_timestamp_ms: u64,
    }

    struct FundingRegistry has key {
        id: 0x2::object::UID,
        states: 0x2::table::Table<vector<u8>, FundingState>,
    }

    struct FundingIndexUpdated has copy, drop {
        symbol: vector<u8>,
        global_funding_index: u128,
        global_funding_index_is_negative: bool,
        short_borrow_index: u128,
        dt_seconds: u64,
        timestamp_ms: u64,
    }

    struct FundingIndexUpdatedV2 has copy, drop {
        symbol: vector<u8>,
        premium_rate_bps: u64,
        premium_rate_is_negative: bool,
        inventory_rate_bps: u64,
        inventory_rate_is_negative: bool,
        borrow_rate_bps: u64,
        global_funding_index: u128,
        global_funding_index_is_negative: bool,
        short_borrow_index: u128,
        dt_seconds: u64,
        timestamp_ms: u64,
        keeper: address,
    }

    struct MarketFundingInitialized has copy, drop {
        symbol: vector<u8>,
        timestamp_ms: u64,
    }

    fun add_signed_u128(arg0: u128, arg1: bool, arg2: u128, arg3: bool) : (u128, bool) {
        if (arg1 == arg3) {
            (arg0 + arg2, arg1)
        } else if (arg0 > arg2) {
            (arg0 - arg2, arg1)
        } else if (arg2 > arg0) {
            (arg2 - arg0, arg3)
        } else {
            (0, false)
        }
    }

    fun add_signed_u64(arg0: u64, arg1: bool, arg2: u64, arg3: bool) : (u64, bool) {
        if (arg1 == arg3) {
            (arg0 + arg2, arg1)
        } else if (arg0 > arg2) {
            (arg0 - arg2, arg1)
        } else if (arg2 > arg0) {
            (arg2 - arg0, arg3)
        } else {
            (0, false)
        }
    }

    public fun admin_update_indices(arg0: &0xacb076e99b227bdb98685ee3537b9e89e79bff6cdaf8318e4afefdad7ba69c45::admin_config::AdminCap, arg1: &mut FundingRegistry, arg2: vector<u8>, arg3: u64, arg4: bool, arg5: u64, arg6: bool, arg7: u64, arg8: &0x2::clock::Clock) {
        abort 2
    }

    public fun admin_update_indices_v3(arg0: &0xacb076e99b227bdb98685ee3537b9e89e79bff6cdaf8318e4afefdad7ba69c45::admin_config::AdminCap, arg1: &0xacb076e99b227bdb98685ee3537b9e89e79bff6cdaf8318e4afefdad7ba69c45::admin_config::RiskParams, arg2: &mut FundingRegistry, arg3: vector<u8>, arg4: u64, arg5: bool, arg6: u64, arg7: bool, arg8: u64, arg9: &0x2::clock::Clock, arg10: &mut 0x2::tx_context::TxContext) {
        assert_total_rate_within_cap(arg1, arg4, arg5, arg6, arg7, arg8);
        update_indices_internal(arg2, arg3, arg4, arg5, arg6, arg7, arg8, arg9, 0x2::tx_context::sender(arg10), true);
    }

    fun assert_total_rate_within_cap(arg0: &0xacb076e99b227bdb98685ee3537b9e89e79bff6cdaf8318e4afefdad7ba69c45::admin_config::RiskParams, arg1: u64, arg2: bool, arg3: u64, arg4: bool, arg5: u64) {
        let (v0, _) = add_signed_u64(arg1, arg2, arg3, arg4);
        assert!((v0 as u128) + (arg5 as u128) <= (0xacb076e99b227bdb98685ee3537b9e89e79bff6cdaf8318e4afefdad7ba69c45::admin_config::max_total_funding_rate_bps(arg0) as u128), 3);
    }

    public fun borrow_funding_state(arg0: &FundingRegistry, arg1: vector<u8>) : &FundingState {
        assert!(0x2::table::contains<vector<u8>, FundingState>(&arg0.states, arg1), 0);
        0x2::table::borrow<vector<u8>, FundingState>(&arg0.states, arg1)
    }

    fun compute_delta(arg0: u64, arg1: u64) : u128 {
        (arg0 as u128) * (arg1 as u128) * 1000000000000000000 / 31536000 * 10000
    }

    public fun funding_state_exists(arg0: &FundingRegistry, arg1: vector<u8>) : bool {
        0x2::table::contains<vector<u8>, FundingState>(&arg0.states, arg1)
    }

    fun init(arg0: &mut 0x2::tx_context::TxContext) {
        let v0 = FundingRegistry{
            id     : 0x2::object::new(arg0),
            states : 0x2::table::new<vector<u8>, FundingState>(arg0),
        };
        0x2::transfer::share_object<FundingRegistry>(v0);
    }

    public fun init_market_funding(arg0: &0xacb076e99b227bdb98685ee3537b9e89e79bff6cdaf8318e4afefdad7ba69c45::admin_config::AdminCap, arg1: &mut FundingRegistry, arg2: vector<u8>, arg3: &0x2::clock::Clock) {
        assert!(!0x2::table::contains<vector<u8>, FundingState>(&arg1.states, arg2), 1);
        let v0 = 0x2::clock::timestamp_ms(arg3);
        let v1 = FundingState{
            global_funding_index             : 0,
            global_funding_index_is_negative : false,
            short_borrow_index               : 0,
            last_update_timestamp_ms         : v0,
        };
        0x2::table::add<vector<u8>, FundingState>(&mut arg1.states, arg2, v1);
        let v2 = MarketFundingInitialized{
            symbol       : arg2,
            timestamp_ms : v0,
        };
        0x2::event::emit<MarketFundingInitialized>(v2);
    }

    public fun state_global_funding_index(arg0: &FundingState) : u128 {
        arg0.global_funding_index
    }

    public fun state_global_funding_index_is_negative(arg0: &FundingState) : bool {
        arg0.global_funding_index_is_negative
    }

    public fun state_last_update_timestamp_ms(arg0: &FundingState) : u64 {
        arg0.last_update_timestamp_ms
    }

    public fun state_short_borrow_index(arg0: &FundingState) : u128 {
        arg0.short_borrow_index
    }

    public(friend) fun update_indices(arg0: &mut FundingRegistry, arg1: vector<u8>, arg2: u64, arg3: bool, arg4: u64, arg5: bool, arg6: u64, arg7: &0x2::clock::Clock) {
        update_indices_internal(arg0, arg1, arg2, arg3, arg4, arg5, arg6, arg7, @0x0, false);
    }

    fun update_indices_internal(arg0: &mut FundingRegistry, arg1: vector<u8>, arg2: u64, arg3: bool, arg4: u64, arg5: bool, arg6: u64, arg7: &0x2::clock::Clock, arg8: address, arg9: bool) {
        assert!(0x2::table::contains<vector<u8>, FundingState>(&arg0.states, arg1), 0);
        let v0 = 0x2::table::borrow_mut<vector<u8>, FundingState>(&mut arg0.states, arg1);
        let v1 = 0x2::clock::timestamp_ms(arg7);
        if (v1 <= v0.last_update_timestamp_ms) {
            return
        };
        let v2 = (v1 - v0.last_update_timestamp_ms) / 1000;
        if (v2 == 0) {
            v0.last_update_timestamp_ms = v1;
            return
        };
        let (v3, v4) = add_signed_u64(arg2, arg3, arg4, arg5);
        if (v3 > 0) {
            let (v5, v6) = add_signed_u128(v0.global_funding_index, v0.global_funding_index_is_negative, compute_delta(v2, v3), v4);
            v0.global_funding_index = v5;
            v0.global_funding_index_is_negative = v6;
        };
        if (arg6 > 0) {
            v0.short_borrow_index = v0.short_borrow_index + compute_delta(v2, arg6);
        };
        v0.last_update_timestamp_ms = v1;
        if (arg9) {
            let v7 = FundingIndexUpdatedV2{
                symbol                           : arg1,
                premium_rate_bps                 : arg2,
                premium_rate_is_negative         : arg3,
                inventory_rate_bps               : arg4,
                inventory_rate_is_negative       : arg5,
                borrow_rate_bps                  : arg6,
                global_funding_index             : v0.global_funding_index,
                global_funding_index_is_negative : v0.global_funding_index_is_negative,
                short_borrow_index               : v0.short_borrow_index,
                dt_seconds                       : v2,
                timestamp_ms                     : v1,
                keeper                           : arg8,
            };
            0x2::event::emit<FundingIndexUpdatedV2>(v7);
        } else {
            let v8 = FundingIndexUpdated{
                symbol                           : arg1,
                global_funding_index             : v0.global_funding_index,
                global_funding_index_is_negative : v0.global_funding_index_is_negative,
                short_borrow_index               : v0.short_borrow_index,
                dt_seconds                       : v2,
                timestamp_ms                     : v1,
            };
            0x2::event::emit<FundingIndexUpdated>(v8);
        };
    }

    public(friend) fun update_indices_v3(arg0: &0xacb076e99b227bdb98685ee3537b9e89e79bff6cdaf8318e4afefdad7ba69c45::admin_config::RiskParams, arg1: &mut FundingRegistry, arg2: vector<u8>, arg3: u64, arg4: bool, arg5: u64, arg6: bool, arg7: u64, arg8: address, arg9: &0x2::clock::Clock) {
        assert_total_rate_within_cap(arg0, arg3, arg4, arg5, arg6, arg7);
        update_indices_internal(arg1, arg2, arg3, arg4, arg5, arg6, arg7, arg9, arg8, true);
    }

    // decompiled from Move bytecode v7
}

