module 0x12cef1403b5eaf1d03b8c34e8902dc0abe4b5496ed7727e0f05b3e244e056fc3::buyback {
    struct BuybackConfigured has copy, drop {
        curve_id: 0x2::object::ID,
        buyback_bps: u64,
        burn: bool,
        min_out_bps: u64,
        deadline_ms: u64,
        threshold: u64,
    }

    struct BuybackExecuted has copy, drop {
        curve_id: 0x2::object::ID,
        quote_spent: u64,
        tokens_bought: u64,
        burned: bool,
        tip: u64,
    }

    struct BuybackSweptExpired has copy, drop {
        curve_id: 0x2::object::ID,
        quote_swept: u64,
    }

    fun assert_cooldown_elapsed<T0, T1>(arg0: &0x12cef1403b5eaf1d03b8c34e8902dc0abe4b5496ed7727e0f05b3e244e056fc3::curve::QuoteCurve<T0, T1>, arg1: u64) {
        assert!(arg1 >= 0x12cef1403b5eaf1d03b8c34e8902dc0abe4b5496ed7727e0f05b3e244e056fc3::curve::last_buyback_ms<T0, T1>(arg0) + 600000, 13855887813444894733);
    }

    fun assert_live_and_unpaused<T0, T1>(arg0: &0x12cef1403b5eaf1d03b8c34e8902dc0abe4b5496ed7727e0f05b3e244e056fc3::curve::QuoteCurve<T0, T1>) {
        0x12cef1403b5eaf1d03b8c34e8902dc0abe4b5496ed7727e0f05b3e244e056fc3::curve::assert_curve_version<T0, T1>(arg0);
        assert!(!0x12cef1403b5eaf1d03b8c34e8902dc0abe4b5496ed7727e0f05b3e244e056fc3::curve::graduated<T0, T1>(arg0), 13836184543599525889);
        assert!(!0x12cef1403b5eaf1d03b8c34e8902dc0abe4b5496ed7727e0f05b3e244e056fc3::curve::paused<T0, T1>(arg0), 13842939947335680003);
    }

    public fun execute_buyback<T0, T1>(arg0: &mut 0x12cef1403b5eaf1d03b8c34e8902dc0abe4b5496ed7727e0f05b3e244e056fc3::curve::QuoteCurve<T0, T1>, arg1: &0x2::clock::Clock, arg2: &mut 0x2::tx_context::TxContext) : 0x2::coin::Coin<T1> {
        assert_live_and_unpaused<T0, T1>(arg0);
        assert!(0x12cef1403b5eaf1d03b8c34e8902dc0abe4b5496ed7727e0f05b3e244e056fc3::curve::buyback_deadline_ms<T0, T1>(arg0) == 0 || 0x2::clock::timestamp_ms(arg1) <= 0x12cef1403b5eaf1d03b8c34e8902dc0abe4b5496ed7727e0f05b3e244e056fc3::curve::buyback_deadline_ms<T0, T1>(arg0), 13854761728854327307);
        let v0 = 0x12cef1403b5eaf1d03b8c34e8902dc0abe4b5496ed7727e0f05b3e244e056fc3::curve::buyback_fees_pending<T0, T1>(arg0);
        assert!(v0 > 0, 13846036017460936711);
        let v1 = 0x2::clock::timestamp_ms(arg1);
        assert_cooldown_elapsed<T0, T1>(arg0, v1);
        let v2 = 0x12cef1403b5eaf1d03b8c34e8902dc0abe4b5496ed7727e0f05b3e244e056fc3::curve::buyback_min_out_bps<T0, T1>(arg0);
        assert!(v2 >= 0x12cef1403b5eaf1d03b8c34e8902dc0abe4b5496ed7727e0f05b3e244e056fc3::curve::min_buyback_min_out_bps() && v2 < 0x12cef1403b5eaf1d03b8c34e8902dc0abe4b5496ed7727e0f05b3e244e056fc3::constants::bps_denominator(), 13857013558733045775);
        let v3 = (((v0 as u128) * (25 as u128) / (0x12cef1403b5eaf1d03b8c34e8902dc0abe4b5496ed7727e0f05b3e244e056fc3::constants::bps_denominator() as u128)) as u64);
        let v4 = v0 - v3;
        let v5 = (v2 as u128);
        let v6 = (0x12cef1403b5eaf1d03b8c34e8902dc0abe4b5496ed7727e0f05b3e244e056fc3::curve::effective_quote_reserve<T0, T1>(arg0) as u128) * ((0x12cef1403b5eaf1d03b8c34e8902dc0abe4b5496ed7727e0f05b3e244e056fc3::constants::bps_denominator() as u128) - v5) / v5;
        let v7 = if ((v4 as u128) > v6) {
            (v6 as u64)
        } else {
            v4
        };
        let v8 = 0x12cef1403b5eaf1d03b8c34e8902dc0abe4b5496ed7727e0f05b3e244e056fc3::curve::quote_buyback<T0, T1>(arg0, v7);
        assert!(v8 > 0, 13846036077590478855);
        0x12cef1403b5eaf1d03b8c34e8902dc0abe4b5496ed7727e0f05b3e244e056fc3::curve::stamp_buyback_executed<T0, T1>(arg0, v1);
        if (0x12cef1403b5eaf1d03b8c34e8902dc0abe4b5496ed7727e0f05b3e244e056fc3::curve::buyback_burn<T0, T1>(arg0)) {
            0x12cef1403b5eaf1d03b8c34e8902dc0abe4b5496ed7727e0f05b3e244e056fc3::curve::burn_balance<T0, T1>(arg0, 0x12cef1403b5eaf1d03b8c34e8902dc0abe4b5496ed7727e0f05b3e244e056fc3::curve::buyback_swap<T0, T1>(arg0, 0x12cef1403b5eaf1d03b8c34e8902dc0abe4b5496ed7727e0f05b3e244e056fc3::curve::take_buyback_fees<T0, T1>(arg0, v7)), arg2);
        } else {
            0x12cef1403b5eaf1d03b8c34e8902dc0abe4b5496ed7727e0f05b3e244e056fc3::curve::distribute_to_payouts<T0, T1, T0>(arg0, 0x2::coin::from_balance<T0>(0x12cef1403b5eaf1d03b8c34e8902dc0abe4b5496ed7727e0f05b3e244e056fc3::curve::buyback_swap<T0, T1>(arg0, 0x12cef1403b5eaf1d03b8c34e8902dc0abe4b5496ed7727e0f05b3e244e056fc3::curve::take_buyback_fees<T0, T1>(arg0, v7)), arg2), arg2);
        };
        let v9 = BuybackExecuted{
            curve_id      : 0x2::object::id<0x12cef1403b5eaf1d03b8c34e8902dc0abe4b5496ed7727e0f05b3e244e056fc3::curve::QuoteCurve<T0, T1>>(arg0),
            quote_spent   : v7,
            tokens_bought : v8,
            burned        : 0x12cef1403b5eaf1d03b8c34e8902dc0abe4b5496ed7727e0f05b3e244e056fc3::curve::buyback_burn<T0, T1>(arg0),
            tip           : v3,
        };
        0x2::event::emit<BuybackExecuted>(v9);
        0x12cef1403b5eaf1d03b8c34e8902dc0abe4b5496ed7727e0f05b3e244e056fc3::curve::graduate_if_ready<T0, T1>(arg0, arg1, arg2);
        0x2::coin::from_balance<T1>(0x12cef1403b5eaf1d03b8c34e8902dc0abe4b5496ed7727e0f05b3e244e056fc3::curve::take_buyback_fees<T0, T1>(arg0, v3), arg2)
    }

    public fun set_buyback_config<T0, T1>(arg0: &0x12cef1403b5eaf1d03b8c34e8902dc0abe4b5496ed7727e0f05b3e244e056fc3::curve::CreatorCap, arg1: &mut 0x12cef1403b5eaf1d03b8c34e8902dc0abe4b5496ed7727e0f05b3e244e056fc3::curve::QuoteCurve<T0, T1>, arg2: u64, arg3: bool, arg4: u64, arg5: u64, arg6: u64, arg7: &0x2::clock::Clock, arg8: &mut 0x2::tx_context::TxContext) {
        0x12cef1403b5eaf1d03b8c34e8902dc0abe4b5496ed7727e0f05b3e244e056fc3::curve::assert_curve_version<T0, T1>(arg1);
        0x12cef1403b5eaf1d03b8c34e8902dc0abe4b5496ed7727e0f05b3e244e056fc3::curve::assert_active_creator<T0, T1>(arg0, arg1);
        assert!(arg2 <= 0x12cef1403b5eaf1d03b8c34e8902dc0abe4b5496ed7727e0f05b3e244e056fc3::constants::bps_denominator(), 13845754405045141509);
        assert!(arg4 < 0x12cef1403b5eaf1d03b8c34e8902dc0abe4b5496ed7727e0f05b3e244e056fc3::constants::bps_denominator(), 13854480133618401289);
        let v0 = if (arg4 == 0) {
            0x12cef1403b5eaf1d03b8c34e8902dc0abe4b5496ed7727e0f05b3e244e056fc3::curve::default_buyback_min_out_bps()
        } else {
            arg4
        };
        assert!(v0 >= 0x12cef1403b5eaf1d03b8c34e8902dc0abe4b5496ed7727e0f05b3e244e056fc3::curve::min_buyback_min_out_bps(), 13857013416999125007);
        assert!(arg5 == 0 || arg5 > 0x2::clock::timestamp_ms(arg7) + 600000, 13857294904860868625);
        0x12cef1403b5eaf1d03b8c34e8902dc0abe4b5496ed7727e0f05b3e244e056fc3::curve::stamp_creator_activity<T0, T1>(arg1, arg7);
        0x12cef1403b5eaf1d03b8c34e8902dc0abe4b5496ed7727e0f05b3e244e056fc3::curve::store_buyback_config<T0, T1>(arg1, arg2, arg3, v0, arg5, arg6);
        let v1 = BuybackConfigured{
            curve_id    : 0x2::object::id<0x12cef1403b5eaf1d03b8c34e8902dc0abe4b5496ed7727e0f05b3e244e056fc3::curve::QuoteCurve<T0, T1>>(arg1),
            buyback_bps : arg2,
            burn        : arg3,
            min_out_bps : v0,
            deadline_ms : arg5,
            threshold   : arg6,
        };
        0x2::event::emit<BuybackConfigured>(v1);
    }

    public fun sweep_expired_buyback<T0, T1>(arg0: &mut 0x12cef1403b5eaf1d03b8c34e8902dc0abe4b5496ed7727e0f05b3e244e056fc3::curve::QuoteCurve<T0, T1>, arg1: &0x2::clock::Clock, arg2: &mut 0x2::tx_context::TxContext) {
        assert_live_and_unpaused<T0, T1>(arg0);
        let v0 = 0x2::clock::timestamp_ms(arg1);
        assert!(0x12cef1403b5eaf1d03b8c34e8902dc0abe4b5496ed7727e0f05b3e244e056fc3::curve::buyback_deadline_ms<T0, T1>(arg0) != 0 && v0 > 0x12cef1403b5eaf1d03b8c34e8902dc0abe4b5496ed7727e0f05b3e244e056fc3::curve::buyback_deadline_ms<T0, T1>(arg0), 13857576714845159443);
        let v1 = 0x12cef1403b5eaf1d03b8c34e8902dc0abe4b5496ed7727e0f05b3e244e056fc3::curve::buyback_fees_pending<T0, T1>(arg0);
        assert!(v1 > 0, 13846036249389170695);
        assert_cooldown_elapsed<T0, T1>(arg0, v0);
        0x12cef1403b5eaf1d03b8c34e8902dc0abe4b5496ed7727e0f05b3e244e056fc3::curve::stamp_buyback_executed<T0, T1>(arg0, v0);
        let v2 = (((0x12cef1403b5eaf1d03b8c34e8902dc0abe4b5496ed7727e0f05b3e244e056fc3::curve::effective_quote_reserve<T0, T1>(arg0) as u128) * (0x12cef1403b5eaf1d03b8c34e8902dc0abe4b5496ed7727e0f05b3e244e056fc3::curve::sweep_max_injection_bps() as u128) / (0x12cef1403b5eaf1d03b8c34e8902dc0abe4b5496ed7727e0f05b3e244e056fc3::constants::bps_denominator() as u128)) as u64);
        let v3 = if (v1 > v2) {
            v2
        } else {
            v1
        };
        0x12cef1403b5eaf1d03b8c34e8902dc0abe4b5496ed7727e0f05b3e244e056fc3::curve::inject_reserve<T0, T1>(arg0, 0x12cef1403b5eaf1d03b8c34e8902dc0abe4b5496ed7727e0f05b3e244e056fc3::curve::take_buyback_fees<T0, T1>(arg0, v3));
        let v4 = BuybackSweptExpired{
            curve_id    : 0x2::object::id<0x12cef1403b5eaf1d03b8c34e8902dc0abe4b5496ed7727e0f05b3e244e056fc3::curve::QuoteCurve<T0, T1>>(arg0),
            quote_swept : v3,
        };
        0x2::event::emit<BuybackSweptExpired>(v4);
    }

    // decompiled from Move bytecode v7
}

