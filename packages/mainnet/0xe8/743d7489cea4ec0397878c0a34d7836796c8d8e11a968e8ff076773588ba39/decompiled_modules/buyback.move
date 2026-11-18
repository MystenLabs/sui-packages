module 0x96a8523e464fdb6c1bb267404621cf47fcd3234d168b724b660995a420b439e3::buyback {
    struct BuybackConfigured has copy, drop {
        curve_id: 0x2::object::ID,
        buyback_bps: u64,
        burn: bool,
        min_out_bps: u64,
        deadline_ms: u64,
        threshold_mist: u64,
    }

    struct BuybackExecuted has copy, drop {
        curve_id: 0x2::object::ID,
        sui_spent: u64,
        tokens_bought: u64,
        burned: bool,
        tip: u64,
    }

    struct BuybackSweptExpired has copy, drop {
        curve_id: 0x2::object::ID,
        sui_swept: u64,
    }

    fun assert_cooldown_elapsed<T0>(arg0: &0x96a8523e464fdb6c1bb267404621cf47fcd3234d168b724b660995a420b439e3::curve::Curve<T0>, arg1: u64) {
        assert!(arg1 >= 0x96a8523e464fdb6c1bb267404621cf47fcd3234d168b724b660995a420b439e3::curve::last_buyback_ms<T0>(arg0) + 600000, 13855888285891428367);
    }

    fun assert_live_and_unpaused<T0>(arg0: &0x96a8523e464fdb6c1bb267404621cf47fcd3234d168b724b660995a420b439e3::curve::Curve<T0>) {
        0x96a8523e464fdb6c1bb267404621cf47fcd3234d168b724b660995a420b439e3::curve::assert_curve_version<T0>(arg0);
        assert!(!0x96a8523e464fdb6c1bb267404621cf47fcd3234d168b724b660995a420b439e3::curve::graduated<T0>(arg0), 13836185011750961153);
        assert!(!0x96a8523e464fdb6c1bb267404621cf47fcd3234d168b724b660995a420b439e3::curve::paused<T0>(arg0), 13842940415487115267);
    }

    public fun execute_buyback<T0>(arg0: &mut 0x96a8523e464fdb6c1bb267404621cf47fcd3234d168b724b660995a420b439e3::curve::Curve<T0>, arg1: &0x2::clock::Clock, arg2: &mut 0x2::tx_context::TxContext) : 0x2::coin::Coin<0x2::sui::SUI> {
        assert_live_and_unpaused<T0>(arg0);
        assert!(0x96a8523e464fdb6c1bb267404621cf47fcd3234d168b724b660995a420b439e3::curve::buyback_deadline_ms<T0>(arg0) == 0 || 0x2::clock::timestamp_ms(arg1) <= 0x96a8523e464fdb6c1bb267404621cf47fcd3234d168b724b660995a420b439e3::curve::buyback_deadline_ms<T0>(arg0), 13854762016617136139);
        let v0 = 0x96a8523e464fdb6c1bb267404621cf47fcd3234d168b724b660995a420b439e3::curve::buyback_fees_pending<T0>(arg0);
        assert!(v0 > 0, 13846036305223745543);
        let v1 = 0x2::clock::timestamp_ms(arg1);
        assert_cooldown_elapsed<T0>(arg0, v1);
        let v2 = 0x96a8523e464fdb6c1bb267404621cf47fcd3234d168b724b660995a420b439e3::curve::buyback_min_out_bps<T0>(arg0);
        assert!(v2 >= 0x96a8523e464fdb6c1bb267404621cf47fcd3234d168b724b660995a420b439e3::curve::min_buyback_min_out_bps() && v2 < 0x96a8523e464fdb6c1bb267404621cf47fcd3234d168b724b660995a420b439e3::constants::bps_denominator(), 13857013880855855123);
        let v3 = v0 * 25 / 0x96a8523e464fdb6c1bb267404621cf47fcd3234d168b724b660995a420b439e3::constants::bps_denominator();
        let v4 = v0 - v3;
        let v5 = (v2 as u128);
        let v6 = (0x96a8523e464fdb6c1bb267404621cf47fcd3234d168b724b660995a420b439e3::curve::effective_sui_reserve<T0>(arg0) as u128) * ((0x96a8523e464fdb6c1bb267404621cf47fcd3234d168b724b660995a420b439e3::constants::bps_denominator() as u128) - v5) / v5;
        let v7 = if ((v4 as u128) > v6) {
            (v6 as u64)
        } else {
            v4
        };
        let v8 = 0x96a8523e464fdb6c1bb267404621cf47fcd3234d168b724b660995a420b439e3::curve::quote_buyback<T0>(arg0, v7);
        assert!(v8 > 0, 13846036429777797127);
        0x96a8523e464fdb6c1bb267404621cf47fcd3234d168b724b660995a420b439e3::curve::stamp_buyback_executed<T0>(arg0, v1);
        if (0x96a8523e464fdb6c1bb267404621cf47fcd3234d168b724b660995a420b439e3::curve::buyback_burn<T0>(arg0)) {
            0x96a8523e464fdb6c1bb267404621cf47fcd3234d168b724b660995a420b439e3::curve::burn_balance<T0>(arg0, 0x96a8523e464fdb6c1bb267404621cf47fcd3234d168b724b660995a420b439e3::curve::buyback_swap<T0>(arg0, 0x96a8523e464fdb6c1bb267404621cf47fcd3234d168b724b660995a420b439e3::curve::take_buyback_fees<T0>(arg0, v7)), arg2);
        } else {
            0x96a8523e464fdb6c1bb267404621cf47fcd3234d168b724b660995a420b439e3::curve::distribute_to_payouts<T0, T0>(arg0, 0x2::coin::from_balance<T0>(0x96a8523e464fdb6c1bb267404621cf47fcd3234d168b724b660995a420b439e3::curve::buyback_swap<T0>(arg0, 0x96a8523e464fdb6c1bb267404621cf47fcd3234d168b724b660995a420b439e3::curve::take_buyback_fees<T0>(arg0, v7)), arg2), arg2);
        };
        let v9 = BuybackExecuted{
            curve_id      : 0x2::object::id<0x96a8523e464fdb6c1bb267404621cf47fcd3234d168b724b660995a420b439e3::curve::Curve<T0>>(arg0),
            sui_spent     : v7,
            tokens_bought : v8,
            burned        : 0x96a8523e464fdb6c1bb267404621cf47fcd3234d168b724b660995a420b439e3::curve::buyback_burn<T0>(arg0),
            tip           : v3,
        };
        0x2::event::emit<BuybackExecuted>(v9);
        0x96a8523e464fdb6c1bb267404621cf47fcd3234d168b724b660995a420b439e3::curve::graduate_if_drained<T0>(arg0, arg1, arg2);
        0x2::coin::from_balance<0x2::sui::SUI>(0x96a8523e464fdb6c1bb267404621cf47fcd3234d168b724b660995a420b439e3::curve::take_buyback_fees<T0>(arg0, v3), arg2)
    }

    public fun set_buyback_config<T0>(arg0: &0x96a8523e464fdb6c1bb267404621cf47fcd3234d168b724b660995a420b439e3::curve::CreatorCap, arg1: &mut 0x96a8523e464fdb6c1bb267404621cf47fcd3234d168b724b660995a420b439e3::curve::Curve<T0>, arg2: u64, arg3: bool, arg4: u64, arg5: u64, arg6: u64, arg7: &0x2::clock::Clock, arg8: &mut 0x2::tx_context::TxContext) {
        0x96a8523e464fdb6c1bb267404621cf47fcd3234d168b724b660995a420b439e3::curve::assert_curve_version<T0>(arg1);
        0x96a8523e464fdb6c1bb267404621cf47fcd3234d168b724b660995a420b439e3::curve::assert_active_creator<T0>(arg0, arg1);
        assert!(arg2 <= 0x96a8523e464fdb6c1bb267404621cf47fcd3234d168b724b660995a420b439e3::constants::bps_denominator(), 13845754576843833349);
        assert!(arg4 < 0x96a8523e464fdb6c1bb267404621cf47fcd3234d168b724b660995a420b439e3::constants::bps_denominator(), 13854480314007027721);
        assert!(arg6 == 0 || arg6 >= 1000000, 13856169185342652433);
        let v0 = if (arg4 == 0) {
            0x96a8523e464fdb6c1bb267404621cf47fcd3234d168b724b660995a420b439e3::curve::default_buyback_min_out_bps()
        } else {
            arg4
        };
        assert!(v0 >= 0x96a8523e464fdb6c1bb267404621cf47fcd3234d168b724b660995a420b439e3::curve::min_buyback_min_out_bps(), 13857013648927621139);
        assert!(arg5 == 0 || arg5 > 0x2::clock::timestamp_ms(arg7) + 600000, 13857295153969233941);
        0x96a8523e464fdb6c1bb267404621cf47fcd3234d168b724b660995a420b439e3::curve::stamp_creator_activity<T0>(arg1, arg7);
        0x96a8523e464fdb6c1bb267404621cf47fcd3234d168b724b660995a420b439e3::curve::store_buyback_config<T0>(arg1, arg2, arg3, v0, arg5, arg6);
        let v1 = BuybackConfigured{
            curve_id       : 0x2::object::id<0x96a8523e464fdb6c1bb267404621cf47fcd3234d168b724b660995a420b439e3::curve::Curve<T0>>(arg1),
            buyback_bps    : arg2,
            burn           : arg3,
            min_out_bps    : v0,
            deadline_ms    : arg5,
            threshold_mist : arg6,
        };
        0x2::event::emit<BuybackConfigured>(v1);
    }

    public fun sweep_expired_buyback<T0>(arg0: &mut 0x96a8523e464fdb6c1bb267404621cf47fcd3234d168b724b660995a420b439e3::curve::Curve<T0>, arg1: &0x2::clock::Clock, arg2: &mut 0x2::tx_context::TxContext) {
        assert_live_and_unpaused<T0>(arg0);
        let v0 = 0x2::clock::timestamp_ms(arg1);
        assert!(0x96a8523e464fdb6c1bb267404621cf47fcd3234d168b724b660995a420b439e3::curve::buyback_deadline_ms<T0>(arg0) != 0 && v0 > 0x96a8523e464fdb6c1bb267404621cf47fcd3234d168b724b660995a420b439e3::curve::buyback_deadline_ms<T0>(arg0), 13857577225945874445);
        let v1 = 0x96a8523e464fdb6c1bb267404621cf47fcd3234d168b724b660995a420b439e3::curve::buyback_fees_pending<T0>(arg0);
        assert!(v1 > 0, 13846036764785246215);
        assert_cooldown_elapsed<T0>(arg0, v0);
        0x96a8523e464fdb6c1bb267404621cf47fcd3234d168b724b660995a420b439e3::curve::stamp_buyback_executed<T0>(arg0, v0);
        let v2 = (((0x96a8523e464fdb6c1bb267404621cf47fcd3234d168b724b660995a420b439e3::curve::effective_sui_reserve<T0>(arg0) as u128) * (0x96a8523e464fdb6c1bb267404621cf47fcd3234d168b724b660995a420b439e3::curve::sweep_max_injection_bps() as u128) / (0x96a8523e464fdb6c1bb267404621cf47fcd3234d168b724b660995a420b439e3::constants::bps_denominator() as u128)) as u64);
        let v3 = if (v1 > v2) {
            v2
        } else {
            v1
        };
        0x96a8523e464fdb6c1bb267404621cf47fcd3234d168b724b660995a420b439e3::curve::inject_reserve<T0>(arg0, 0x96a8523e464fdb6c1bb267404621cf47fcd3234d168b724b660995a420b439e3::curve::take_buyback_fees<T0>(arg0, v3));
        let v4 = BuybackSweptExpired{
            curve_id  : 0x2::object::id<0x96a8523e464fdb6c1bb267404621cf47fcd3234d168b724b660995a420b439e3::curve::Curve<T0>>(arg0),
            sui_swept : v3,
        };
        0x2::event::emit<BuybackSweptExpired>(v4);
    }

    // decompiled from Move bytecode v7
}

