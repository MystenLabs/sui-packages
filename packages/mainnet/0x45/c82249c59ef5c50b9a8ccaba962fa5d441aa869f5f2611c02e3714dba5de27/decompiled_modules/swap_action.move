module 0x45c82249c59ef5c50b9a8ccaba962fa5d441aa869f5f2611c02e3714dba5de27::swap_action {
    struct SwapReceipt {
        intent_id: 0x2::object::ID,
        intent_owner: address,
        min_output: u64,
        oracle_expected: u64,
        surplus_share_bps: u16,
    }

    struct SurplusShared has copy, drop {
        intent_id: 0x2::object::ID,
        actual_output: u64,
        oracle_expected: u64,
        surplus: u64,
        executor_bonus: u64,
        surplus_share_bps: u16,
    }

    public fun begin_swap<T0>(arg0: &mut 0x45c82249c59ef5c50b9a8ccaba962fa5d441aa869f5f2611c02e3714dba5de27::intent::Intent<T0>, arg1: &0x45c82249c59ef5c50b9a8ccaba962fa5d441aa869f5f2611c02e3714dba5de27::config::ProtocolConfig, arg2: &0x8d97f1cd6ac663735be08d1d2b6d02a159e711586461306ce60a2b7a6a565a9e::price_info::PriceInfoObject, arg3: &0x8d97f1cd6ac663735be08d1d2b6d02a159e711586461306ce60a2b7a6a565a9e::price_info::PriceInfoObject, arg4: u64, arg5: &0x2::clock::Clock, arg6: &mut 0x2::tx_context::TxContext) : (0x2::coin::Coin<T0>, SwapReceipt) {
        let v0 = 0x1::vector::borrow<0x45c82249c59ef5c50b9a8ccaba962fa5d441aa869f5f2611c02e3714dba5de27::intent::ActionBlock>(0x45c82249c59ef5c50b9a8ccaba962fa5d441aa869f5f2611c02e3714dba5de27::intent::actions<T0>(arg0), 0);
        assert!(0x45c82249c59ef5c50b9a8ccaba962fa5d441aa869f5f2611c02e3714dba5de27::intent::action_block_type(v0) == 0, 200);
        let (v1, v2, v3) = deserialize_swap_params(0x45c82249c59ef5c50b9a8ccaba962fa5d441aa869f5f2611c02e3714dba5de27::intent::action_block_params(v0));
        let v4 = if (v2 > 0) {
            v2
        } else {
            0x45c82249c59ef5c50b9a8ccaba962fa5d441aa869f5f2611c02e3714dba5de27::config::max_oracle_freshness_ms(arg1)
        };
        check_oracle_freshness(arg2, v4, arg5);
        check_oracle_freshness(arg3, v4, arg5);
        let (v5, v6, v7) = 0x45c82249c59ef5c50b9a8ccaba962fa5d441aa869f5f2611c02e3714dba5de27::intent::execute_intent<T0>(arg0, arg1, arg4, arg5, arg6);
        let v8 = v5;
        0x2::transfer::public_transfer<0x2::coin::Coin<T0>>(v6, 0x2::tx_context::sender(arg6));
        0x2::transfer::public_transfer<0x2::coin::Coin<T0>>(v7, 0x45c82249c59ef5c50b9a8ccaba962fa5d441aa869f5f2611c02e3714dba5de27::config::treasury(arg1));
        let v9 = 0x2::coin::value<T0>(&v8);
        let v10 = if (v1 > 0) {
            v1
        } else {
            cross_rate_min_output(arg2, arg3, v9)
        };
        let v11 = SwapReceipt{
            intent_id         : 0x2::object::id<0x45c82249c59ef5c50b9a8ccaba962fa5d441aa869f5f2611c02e3714dba5de27::intent::Intent<T0>>(arg0),
            intent_owner      : 0x45c82249c59ef5c50b9a8ccaba962fa5d441aa869f5f2611c02e3714dba5de27::intent::owner<T0>(arg0),
            min_output        : v10,
            oracle_expected   : cross_rate_expected_output(arg2, arg3, v9),
            surplus_share_bps : v3,
        };
        (v8, v11)
    }

    public(friend) fun check_oracle_freshness(arg0: &0x8d97f1cd6ac663735be08d1d2b6d02a159e711586461306ce60a2b7a6a565a9e::price_info::PriceInfoObject, arg1: u64, arg2: &0x2::clock::Clock) {
        let v0 = 0x8d97f1cd6ac663735be08d1d2b6d02a159e711586461306ce60a2b7a6a565a9e::price_info::get_price_info_from_price_info_object(arg0);
        let v1 = 0x8d97f1cd6ac663735be08d1d2b6d02a159e711586461306ce60a2b7a6a565a9e::price_feed::get_price(0x8d97f1cd6ac663735be08d1d2b6d02a159e711586461306ce60a2b7a6a565a9e::price_info::get_price_feed(&v0));
        assert!(0x2::clock::timestamp_ms(arg2) / 1000 <= 0x8d97f1cd6ac663735be08d1d2b6d02a159e711586461306ce60a2b7a6a565a9e::price::get_timestamp(&v1) + arg1 / 1000, 202);
    }

    public(friend) fun cross_rate_expected_output(arg0: &0x8d97f1cd6ac663735be08d1d2b6d02a159e711586461306ce60a2b7a6a565a9e::price_info::PriceInfoObject, arg1: &0x8d97f1cd6ac663735be08d1d2b6d02a159e711586461306ce60a2b7a6a565a9e::price_info::PriceInfoObject, arg2: u64) : u64 {
        let (v0, v1) = extract_usd_price(arg0);
        let (v2, v3) = extract_usd_price(arg1);
        (((arg2 as u128) * v0 * pow10(v3) / v2 * pow10(v1)) as u64)
    }

    public(friend) fun cross_rate_min_output(arg0: &0x8d97f1cd6ac663735be08d1d2b6d02a159e711586461306ce60a2b7a6a565a9e::price_info::PriceInfoObject, arg1: &0x8d97f1cd6ac663735be08d1d2b6d02a159e711586461306ce60a2b7a6a565a9e::price_info::PriceInfoObject, arg2: u64) : u64 {
        cross_rate_expected_output(arg0, arg1, arg2) * 99 / 100
    }

    public(friend) fun deserialize_swap_params(arg0: vector<u8>) : (u64, u64, u16) {
        let v0 = 0x2::bcs::new(arg0);
        0x2::bcs::peel_vec_u8(&mut v0);
        0x2::bcs::peel_vec_u8(&mut v0);
        let v1 = 0x2::bcs::peel_u16(&mut v0);
        assert!(v1 <= 5000, 205);
        (0x2::bcs::peel_u64(&mut v0), 0x2::bcs::peel_u64(&mut v0), v1)
    }

    public fun end_swap<T0>(arg0: SwapReceipt, arg1: 0x2::coin::Coin<T0>, arg2: &mut 0x2::tx_context::TxContext) {
        let SwapReceipt {
            intent_id         : v0,
            intent_owner      : v1,
            min_output        : v2,
            oracle_expected   : v3,
            surplus_share_bps : v4,
        } = arg0;
        assert!(0x2::coin::value<T0>(&arg1) >= v2, 203);
        if (v4 > 0) {
            let v5 = &mut arg1;
            let v6 = split_surplus<T0>(v5, v3, v4, arg2);
            let v7 = 0x2::coin::value<T0>(&v6);
            if (v7 > 0) {
                let v8 = SurplusShared{
                    intent_id         : v0,
                    actual_output     : 0x2::coin::value<T0>(&arg1) + v7,
                    oracle_expected   : v3,
                    surplus           : 0x2::coin::value<T0>(&arg1) + v7 - v3,
                    executor_bonus    : v7,
                    surplus_share_bps : v4,
                };
                0x2::event::emit<SurplusShared>(v8);
                0x2::transfer::public_transfer<0x2::coin::Coin<T0>>(v6, 0x2::tx_context::sender(arg2));
            } else {
                0x2::coin::destroy_zero<T0>(v6);
            };
        };
        0x2::transfer::public_transfer<0x2::coin::Coin<T0>>(arg1, v1);
    }

    fun extract_usd_price(arg0: &0x8d97f1cd6ac663735be08d1d2b6d02a159e711586461306ce60a2b7a6a565a9e::price_info::PriceInfoObject) : (u128, u64) {
        let v0 = 0x8d97f1cd6ac663735be08d1d2b6d02a159e711586461306ce60a2b7a6a565a9e::price_info::get_price_info_from_price_info_object(arg0);
        let v1 = 0x8d97f1cd6ac663735be08d1d2b6d02a159e711586461306ce60a2b7a6a565a9e::price_feed::get_price(0x8d97f1cd6ac663735be08d1d2b6d02a159e711586461306ce60a2b7a6a565a9e::price_info::get_price_feed(&v0));
        let v2 = 0x8d97f1cd6ac663735be08d1d2b6d02a159e711586461306ce60a2b7a6a565a9e::price::get_price(&v1);
        let v3 = 0x8d97f1cd6ac663735be08d1d2b6d02a159e711586461306ce60a2b7a6a565a9e::price::get_expo(&v1);
        ((0x8d97f1cd6ac663735be08d1d2b6d02a159e711586461306ce60a2b7a6a565a9e::i64::get_magnitude_if_positive(&v2) as u128), 0x8d97f1cd6ac663735be08d1d2b6d02a159e711586461306ce60a2b7a6a565a9e::i64::get_magnitude_if_negative(&v3))
    }

    public(friend) fun new_receipt(arg0: 0x2::object::ID, arg1: address, arg2: u64, arg3: u64, arg4: u16) : SwapReceipt {
        SwapReceipt{
            intent_id         : arg0,
            intent_owner      : arg1,
            min_output        : arg2,
            oracle_expected   : arg3,
            surplus_share_bps : arg4,
        }
    }

    fun pow10(arg0: u64) : u128 {
        let v0 = 1;
        let v1 = 0;
        while (v1 < arg0) {
            v0 = v0 * 10;
            v1 = v1 + 1;
        };
        v0
    }

    fun split_surplus<T0>(arg0: &mut 0x2::coin::Coin<T0>, arg1: u64, arg2: u16, arg3: &mut 0x2::tx_context::TxContext) : 0x2::coin::Coin<T0> {
        let v0 = 0x2::coin::value<T0>(arg0);
        if (v0 <= arg1 || arg2 == 0) {
            return 0x2::coin::zero<T0>(arg3)
        };
        0x2::coin::split<T0>(arg0, ((((v0 - arg1) as u128) * (arg2 as u128) / 10000) as u64), arg3)
    }

    // decompiled from Move bytecode v6
}

