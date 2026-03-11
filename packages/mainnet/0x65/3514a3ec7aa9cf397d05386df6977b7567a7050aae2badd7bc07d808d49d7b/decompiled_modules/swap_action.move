module 0x653514a3ec7aa9cf397d05386df6977b7567a7050aae2badd7bc07d808d49d7b::swap_action {
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

    public fun begin_swap<T0>(arg0: &mut 0x653514a3ec7aa9cf397d05386df6977b7567a7050aae2badd7bc07d808d49d7b::intent::Intent<T0>, arg1: &0x653514a3ec7aa9cf397d05386df6977b7567a7050aae2badd7bc07d808d49d7b::config::ProtocolConfig, arg2: &0x8d97f1cd6ac663735be08d1d2b6d02a159e711586461306ce60a2b7a6a565a9e::price_info::PriceInfoObject, arg3: u64, arg4: &0x2::clock::Clock, arg5: &mut 0x2::tx_context::TxContext) : (0x2::coin::Coin<T0>, SwapReceipt) {
        let v0 = 0x1::vector::borrow<0x653514a3ec7aa9cf397d05386df6977b7567a7050aae2badd7bc07d808d49d7b::intent::ActionBlock>(0x653514a3ec7aa9cf397d05386df6977b7567a7050aae2badd7bc07d808d49d7b::intent::actions<T0>(arg0), 0);
        assert!(0x653514a3ec7aa9cf397d05386df6977b7567a7050aae2badd7bc07d808d49d7b::intent::action_block_type(v0) == 0, 200);
        let (v1, v2, v3, v4) = deserialize_swap_params_v3(0x653514a3ec7aa9cf397d05386df6977b7567a7050aae2badd7bc07d808d49d7b::intent::action_block_params(v0));
        let v5 = if (v3 > 0) {
            v3
        } else {
            0x653514a3ec7aa9cf397d05386df6977b7567a7050aae2badd7bc07d808d49d7b::config::max_oracle_freshness_ms(arg1)
        };
        check_oracle_freshness(arg2, v5, arg4);
        let (v6, v7, v8) = 0x653514a3ec7aa9cf397d05386df6977b7567a7050aae2badd7bc07d808d49d7b::intent::execute_intent<T0>(arg0, arg1, arg3, arg4, arg5);
        let v9 = v6;
        0x2::transfer::public_transfer<0x2::coin::Coin<T0>>(v7, 0x2::tx_context::sender(arg5));
        0x2::transfer::public_transfer<0x2::coin::Coin<T0>>(v8, 0x653514a3ec7aa9cf397d05386df6977b7567a7050aae2badd7bc07d808d49d7b::config::treasury(arg1));
        let v10 = 0x2::coin::value<T0>(&v9);
        let v11 = if (v2 > 0) {
            v2
        } else {
            oracle_min_output(arg2, v10, v1)
        };
        let v12 = SwapReceipt{
            intent_id         : 0x2::object::id<0x653514a3ec7aa9cf397d05386df6977b7567a7050aae2badd7bc07d808d49d7b::intent::Intent<T0>>(arg0),
            intent_owner      : 0x653514a3ec7aa9cf397d05386df6977b7567a7050aae2badd7bc07d808d49d7b::intent::owner<T0>(arg0),
            min_output        : v11,
            oracle_expected   : oracle_expected_output(arg2, v10, v1),
            surplus_share_bps : v4,
        };
        (v9, v12)
    }

    public(friend) fun check_oracle_freshness(arg0: &0x8d97f1cd6ac663735be08d1d2b6d02a159e711586461306ce60a2b7a6a565a9e::price_info::PriceInfoObject, arg1: u64, arg2: &0x2::clock::Clock) {
        let v0 = 0x8d97f1cd6ac663735be08d1d2b6d02a159e711586461306ce60a2b7a6a565a9e::price_info::get_price_info_from_price_info_object(arg0);
        let v1 = 0x8d97f1cd6ac663735be08d1d2b6d02a159e711586461306ce60a2b7a6a565a9e::price_feed::get_price(0x8d97f1cd6ac663735be08d1d2b6d02a159e711586461306ce60a2b7a6a565a9e::price_info::get_price_feed(&v0));
        assert!(0x2::clock::timestamp_ms(arg2) / 1000 <= 0x8d97f1cd6ac663735be08d1d2b6d02a159e711586461306ce60a2b7a6a565a9e::price::get_timestamp(&v1) + arg1 / 1000, 202);
    }

    fun deserialize_swap_params_v2(arg0: vector<u8>) : (address, bool, u64, u64, u16) {
        let v0 = 0x2::bcs::new(arg0);
        let v1 = 0x2::bcs::peel_u8(&mut v0);
        if (v1 == 1) {
            assert!(0x1::vector::length<u8>(&arg0) == 50, 201);
            (0x2::bcs::peel_address(&mut v0), 0x2::bcs::peel_u8(&mut v0) != 0, 0x2::bcs::peel_u64(&mut v0), 0x2::bcs::peel_u64(&mut v0), 0)
        } else {
            assert!(v1 == 2 && 0x1::vector::length<u8>(&arg0) == 52, 201);
            let v7 = 0x2::bcs::peel_u16(&mut v0);
            assert!(v7 <= 5000, 205);
            (0x2::bcs::peel_address(&mut v0), 0x2::bcs::peel_u8(&mut v0) != 0, 0x2::bcs::peel_u64(&mut v0), 0x2::bcs::peel_u64(&mut v0), v7)
        }
    }

    public(friend) fun deserialize_swap_params_v3(arg0: vector<u8>) : (bool, u64, u64, u16) {
        assert!(0x1::vector::length<u8>(&arg0) == 20, 201);
        let v0 = 0x2::bcs::new(arg0);
        assert!(0x2::bcs::peel_u8(&mut v0) == 3, 201);
        let v1 = 0x2::bcs::peel_u16(&mut v0);
        assert!(v1 <= 5000, 205);
        (0x2::bcs::peel_u8(&mut v0) != 0, 0x2::bcs::peel_u64(&mut v0), 0x2::bcs::peel_u64(&mut v0), v1)
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

    public fun execute_dca_base_to_quote<T0, T1>(arg0: &mut 0x653514a3ec7aa9cf397d05386df6977b7567a7050aae2badd7bc07d808d49d7b::intent::Intent<T0>, arg1: &0x653514a3ec7aa9cf397d05386df6977b7567a7050aae2badd7bc07d808d49d7b::config::ProtocolConfig, arg2: &mut 0x2c8d603bc51326b8c13cef9dd07031a408a48dddb541963357661df5d3204809::pool::Pool<T0, T1>, arg3: &0x8d97f1cd6ac663735be08d1d2b6d02a159e711586461306ce60a2b7a6a565a9e::price_info::PriceInfoObject, arg4: 0x2::coin::Coin<0xdeeb7a4662eec9f2f3def03fb937a663dddaa2e215b8078a284d026b7946c270::deep::DEEP>, arg5: u64, arg6: &0x2::clock::Clock, arg7: &mut 0x2::tx_context::TxContext) {
        let v0 = 0x1::vector::borrow<0x653514a3ec7aa9cf397d05386df6977b7567a7050aae2badd7bc07d808d49d7b::intent::ActionBlock>(0x653514a3ec7aa9cf397d05386df6977b7567a7050aae2badd7bc07d808d49d7b::intent::actions<T0>(arg0), 0);
        assert!(0x653514a3ec7aa9cf397d05386df6977b7567a7050aae2badd7bc07d808d49d7b::intent::action_block_type(v0) == 0, 200);
        let (v1, v2, v3, v4, v5) = deserialize_swap_params_v2(0x653514a3ec7aa9cf397d05386df6977b7567a7050aae2badd7bc07d808d49d7b::intent::action_block_params(v0));
        assert!(v1 == 0x2::object::id_address<0x2c8d603bc51326b8c13cef9dd07031a408a48dddb541963357661df5d3204809::pool::Pool<T0, T1>>(arg2), 204);
        assert!(v2 == true, 201);
        let v6 = if (v4 > 0) {
            v4
        } else {
            0x653514a3ec7aa9cf397d05386df6977b7567a7050aae2badd7bc07d808d49d7b::config::max_oracle_freshness_ms(arg1)
        };
        check_oracle_freshness(arg3, v6, arg6);
        let v7 = 0x653514a3ec7aa9cf397d05386df6977b7567a7050aae2badd7bc07d808d49d7b::intent::owner<T0>(arg0);
        let (v8, v9, v10) = 0x653514a3ec7aa9cf397d05386df6977b7567a7050aae2badd7bc07d808d49d7b::intent::execute_intent<T0>(arg0, arg1, arg5, arg6, arg7);
        let v11 = v8;
        let v12 = 0x2::coin::value<T0>(&v11);
        let v13 = if (v3 > 0) {
            v3
        } else {
            oracle_min_output(arg3, v12, true)
        };
        let (v14, v15, v16) = 0x2c8d603bc51326b8c13cef9dd07031a408a48dddb541963357661df5d3204809::pool::swap_exact_base_for_quote<T0, T1>(arg2, v11, arg4, v13, arg6, arg7);
        let v17 = v16;
        let v18 = v15;
        let v19 = v14;
        assert!(0x2::coin::value<T1>(&v18) >= v13, 203);
        if (v5 > 0) {
            let v20 = oracle_expected_output(arg3, v12, true);
            let v21 = &mut v18;
            let v22 = split_surplus<T1>(v21, v20, v5, arg7);
            let v23 = 0x2::coin::value<T1>(&v22);
            if (v23 > 0) {
                let v24 = SurplusShared{
                    intent_id         : 0x2::object::id<0x653514a3ec7aa9cf397d05386df6977b7567a7050aae2badd7bc07d808d49d7b::intent::Intent<T0>>(arg0),
                    actual_output     : 0x2::coin::value<T1>(&v18) + v23,
                    oracle_expected   : v20,
                    surplus           : 0x2::coin::value<T1>(&v18) + v23 - v20,
                    executor_bonus    : v23,
                    surplus_share_bps : v5,
                };
                0x2::event::emit<SurplusShared>(v24);
                0x2::transfer::public_transfer<0x2::coin::Coin<T1>>(v22, 0x2::tx_context::sender(arg7));
            } else {
                0x2::coin::destroy_zero<T1>(v22);
            };
        };
        0x2::transfer::public_transfer<0x2::coin::Coin<T1>>(v18, v7);
        if (0x2::coin::value<T0>(&v19) > 0) {
            0x2::transfer::public_transfer<0x2::coin::Coin<T0>>(v19, v7);
        } else {
            0x2::coin::destroy_zero<T0>(v19);
        };
        if (0x2::coin::value<0xdeeb7a4662eec9f2f3def03fb937a663dddaa2e215b8078a284d026b7946c270::deep::DEEP>(&v17) > 0) {
            0x2::transfer::public_transfer<0x2::coin::Coin<0xdeeb7a4662eec9f2f3def03fb937a663dddaa2e215b8078a284d026b7946c270::deep::DEEP>>(v17, 0x2::tx_context::sender(arg7));
        } else {
            0x2::coin::destroy_zero<0xdeeb7a4662eec9f2f3def03fb937a663dddaa2e215b8078a284d026b7946c270::deep::DEEP>(v17);
        };
        0x2::transfer::public_transfer<0x2::coin::Coin<T0>>(v9, 0x2::tx_context::sender(arg7));
        0x2::transfer::public_transfer<0x2::coin::Coin<T0>>(v10, 0x653514a3ec7aa9cf397d05386df6977b7567a7050aae2badd7bc07d808d49d7b::config::treasury(arg1));
    }

    public fun execute_dca_quote_to_base<T0, T1>(arg0: &mut 0x653514a3ec7aa9cf397d05386df6977b7567a7050aae2badd7bc07d808d49d7b::intent::Intent<T1>, arg1: &0x653514a3ec7aa9cf397d05386df6977b7567a7050aae2badd7bc07d808d49d7b::config::ProtocolConfig, arg2: &mut 0x2c8d603bc51326b8c13cef9dd07031a408a48dddb541963357661df5d3204809::pool::Pool<T0, T1>, arg3: &0x8d97f1cd6ac663735be08d1d2b6d02a159e711586461306ce60a2b7a6a565a9e::price_info::PriceInfoObject, arg4: 0x2::coin::Coin<0xdeeb7a4662eec9f2f3def03fb937a663dddaa2e215b8078a284d026b7946c270::deep::DEEP>, arg5: u64, arg6: &0x2::clock::Clock, arg7: &mut 0x2::tx_context::TxContext) {
        let v0 = 0x1::vector::borrow<0x653514a3ec7aa9cf397d05386df6977b7567a7050aae2badd7bc07d808d49d7b::intent::ActionBlock>(0x653514a3ec7aa9cf397d05386df6977b7567a7050aae2badd7bc07d808d49d7b::intent::actions<T1>(arg0), 0);
        assert!(0x653514a3ec7aa9cf397d05386df6977b7567a7050aae2badd7bc07d808d49d7b::intent::action_block_type(v0) == 0, 200);
        let (v1, v2, v3, v4, v5) = deserialize_swap_params_v2(0x653514a3ec7aa9cf397d05386df6977b7567a7050aae2badd7bc07d808d49d7b::intent::action_block_params(v0));
        assert!(v1 == 0x2::object::id_address<0x2c8d603bc51326b8c13cef9dd07031a408a48dddb541963357661df5d3204809::pool::Pool<T0, T1>>(arg2), 204);
        assert!(v2 == false, 201);
        let v6 = if (v4 > 0) {
            v4
        } else {
            0x653514a3ec7aa9cf397d05386df6977b7567a7050aae2badd7bc07d808d49d7b::config::max_oracle_freshness_ms(arg1)
        };
        check_oracle_freshness(arg3, v6, arg6);
        let v7 = 0x653514a3ec7aa9cf397d05386df6977b7567a7050aae2badd7bc07d808d49d7b::intent::owner<T1>(arg0);
        let (v8, v9, v10) = 0x653514a3ec7aa9cf397d05386df6977b7567a7050aae2badd7bc07d808d49d7b::intent::execute_intent<T1>(arg0, arg1, arg5, arg6, arg7);
        let v11 = v8;
        let v12 = 0x2::coin::value<T1>(&v11);
        let v13 = if (v3 > 0) {
            v3
        } else {
            oracle_min_output(arg3, v12, false)
        };
        let (v14, v15, v16) = 0x2c8d603bc51326b8c13cef9dd07031a408a48dddb541963357661df5d3204809::pool::swap_exact_quote_for_base<T0, T1>(arg2, v11, arg4, v13, arg6, arg7);
        let v17 = v16;
        let v18 = v15;
        let v19 = v14;
        assert!(0x2::coin::value<T0>(&v19) >= v13, 203);
        if (v5 > 0) {
            let v20 = oracle_expected_output(arg3, v12, false);
            let v21 = &mut v19;
            let v22 = split_surplus<T0>(v21, v20, v5, arg7);
            let v23 = 0x2::coin::value<T0>(&v22);
            if (v23 > 0) {
                let v24 = SurplusShared{
                    intent_id         : 0x2::object::id<0x653514a3ec7aa9cf397d05386df6977b7567a7050aae2badd7bc07d808d49d7b::intent::Intent<T1>>(arg0),
                    actual_output     : 0x2::coin::value<T0>(&v19) + v23,
                    oracle_expected   : v20,
                    surplus           : 0x2::coin::value<T0>(&v19) + v23 - v20,
                    executor_bonus    : v23,
                    surplus_share_bps : v5,
                };
                0x2::event::emit<SurplusShared>(v24);
                0x2::transfer::public_transfer<0x2::coin::Coin<T0>>(v22, 0x2::tx_context::sender(arg7));
            } else {
                0x2::coin::destroy_zero<T0>(v22);
            };
        };
        0x2::transfer::public_transfer<0x2::coin::Coin<T0>>(v19, v7);
        if (0x2::coin::value<T1>(&v18) > 0) {
            0x2::transfer::public_transfer<0x2::coin::Coin<T1>>(v18, v7);
        } else {
            0x2::coin::destroy_zero<T1>(v18);
        };
        if (0x2::coin::value<0xdeeb7a4662eec9f2f3def03fb937a663dddaa2e215b8078a284d026b7946c270::deep::DEEP>(&v17) > 0) {
            0x2::transfer::public_transfer<0x2::coin::Coin<0xdeeb7a4662eec9f2f3def03fb937a663dddaa2e215b8078a284d026b7946c270::deep::DEEP>>(v17, 0x2::tx_context::sender(arg7));
        } else {
            0x2::coin::destroy_zero<0xdeeb7a4662eec9f2f3def03fb937a663dddaa2e215b8078a284d026b7946c270::deep::DEEP>(v17);
        };
        0x2::transfer::public_transfer<0x2::coin::Coin<T1>>(v9, 0x2::tx_context::sender(arg7));
        0x2::transfer::public_transfer<0x2::coin::Coin<T1>>(v10, 0x653514a3ec7aa9cf397d05386df6977b7567a7050aae2badd7bc07d808d49d7b::config::treasury(arg1));
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

    public(friend) fun oracle_expected_output(arg0: &0x8d97f1cd6ac663735be08d1d2b6d02a159e711586461306ce60a2b7a6a565a9e::price_info::PriceInfoObject, arg1: u64, arg2: bool) : u64 {
        let v0 = 0x8d97f1cd6ac663735be08d1d2b6d02a159e711586461306ce60a2b7a6a565a9e::price_info::get_price_info_from_price_info_object(arg0);
        let v1 = 0x8d97f1cd6ac663735be08d1d2b6d02a159e711586461306ce60a2b7a6a565a9e::price_feed::get_price(0x8d97f1cd6ac663735be08d1d2b6d02a159e711586461306ce60a2b7a6a565a9e::price_info::get_price_feed(&v0));
        let v2 = 0x8d97f1cd6ac663735be08d1d2b6d02a159e711586461306ce60a2b7a6a565a9e::price::get_price(&v1);
        let v3 = 0x8d97f1cd6ac663735be08d1d2b6d02a159e711586461306ce60a2b7a6a565a9e::price::get_expo(&v1);
        if (arg2) {
            (((arg1 as u128) * (0x8d97f1cd6ac663735be08d1d2b6d02a159e711586461306ce60a2b7a6a565a9e::i64::get_magnitude_if_positive(&v2) as u128) / pow10(0x8d97f1cd6ac663735be08d1d2b6d02a159e711586461306ce60a2b7a6a565a9e::i64::get_magnitude_if_negative(&v3))) as u64)
        } else {
            (((arg1 as u128) * pow10(0x8d97f1cd6ac663735be08d1d2b6d02a159e711586461306ce60a2b7a6a565a9e::i64::get_magnitude_if_negative(&v3)) / (0x8d97f1cd6ac663735be08d1d2b6d02a159e711586461306ce60a2b7a6a565a9e::i64::get_magnitude_if_positive(&v2) as u128)) as u64)
        }
    }

    public(friend) fun oracle_min_output(arg0: &0x8d97f1cd6ac663735be08d1d2b6d02a159e711586461306ce60a2b7a6a565a9e::price_info::PriceInfoObject, arg1: u64, arg2: bool) : u64 {
        let v0 = 0x8d97f1cd6ac663735be08d1d2b6d02a159e711586461306ce60a2b7a6a565a9e::price_info::get_price_info_from_price_info_object(arg0);
        let v1 = 0x8d97f1cd6ac663735be08d1d2b6d02a159e711586461306ce60a2b7a6a565a9e::price_feed::get_price(0x8d97f1cd6ac663735be08d1d2b6d02a159e711586461306ce60a2b7a6a565a9e::price_info::get_price_feed(&v0));
        let v2 = 0x8d97f1cd6ac663735be08d1d2b6d02a159e711586461306ce60a2b7a6a565a9e::price::get_price(&v1);
        let v3 = 0x8d97f1cd6ac663735be08d1d2b6d02a159e711586461306ce60a2b7a6a565a9e::price::get_expo(&v1);
        if (arg2) {
            (((arg1 as u128) * (0x8d97f1cd6ac663735be08d1d2b6d02a159e711586461306ce60a2b7a6a565a9e::i64::get_magnitude_if_positive(&v2) as u128) / pow10(0x8d97f1cd6ac663735be08d1d2b6d02a159e711586461306ce60a2b7a6a565a9e::i64::get_magnitude_if_negative(&v3)) * 99 / 100) as u64)
        } else {
            (((arg1 as u128) * pow10(0x8d97f1cd6ac663735be08d1d2b6d02a159e711586461306ce60a2b7a6a565a9e::i64::get_magnitude_if_negative(&v3)) / (0x8d97f1cd6ac663735be08d1d2b6d02a159e711586461306ce60a2b7a6a565a9e::i64::get_magnitude_if_positive(&v2) as u128) * 99 / 100) as u64)
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

