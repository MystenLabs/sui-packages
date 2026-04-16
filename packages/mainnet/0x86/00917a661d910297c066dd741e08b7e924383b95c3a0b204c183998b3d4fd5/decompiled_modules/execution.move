module 0x8600917a661d910297c066dd741e08b7e924383b95c3a0b204c183998b3d4fd5::execution {
    struct Config has store, key {
        id: 0x2::object::UID,
        owner: address,
    }

    struct Session<phantom T0, phantom T1> has key {
        id: 0x2::object::UID,
        config_id: 0x2::object::ID,
        owner: address,
        route_id: u64,
        expected_leg_count: u64,
        next_leg_index: u64,
        input_start_raw: u64,
        returned_start_raw: u128,
        has_deep_pricing: bool,
        input_deep_raw: u64,
        deep_remaining_raw: u64,
        max_deep_spend_raw: u64,
        deep_to_start_num: u128,
        deep_to_start_den: u128,
        min_execution_profit_start_raw: u64,
    }

    struct ExecutionStarted has copy, drop {
        config_id: 0x2::object::ID,
        route_id: u64,
        expected_leg_count: u64,
        start_token: vector<u8>,
        input_start_raw: u64,
        input_deep_raw: u64,
        min_execution_profit_start_raw: u64,
        max_deep_spend_raw: u64,
        deep_to_start_num: u128,
        deep_to_start_den: u128,
    }

    struct LegExecuted has copy, drop {
        route_id: u64,
        leg_index: u64,
        adapter_id: u8,
        pool_id: address,
        input_token: vector<u8>,
        output_token: vector<u8>,
        input_amount_raw: u64,
        output_amount_raw: u64,
        actual_deep_fee_spent_raw: u64,
    }

    struct ExecutionSucceeded has copy, drop {
        config_id: 0x2::object::ID,
        route_id: u64,
        input_start_raw: u64,
        returned_start_raw: u128,
        input_deep_raw: u64,
        returned_deep_raw: u64,
        actual_deep_spent_raw: u64,
        marked_deep_cost_start_raw: u128,
        min_execution_profit_start_raw: u64,
        execution_delta_start_raw: u128,
    }

    fun ceil_div(arg0: u128, arg1: u128) : u128 {
        if (arg0 == 0) {
            0
        } else {
            (arg0 - 1) / arg1 + 1
        }
    }

    public fun config_id(arg0: &Config) : 0x2::object::ID {
        0x2::object::id<Config>(arg0)
    }

    public entry fun create_config(arg0: address, arg1: &mut 0x2::tx_context::TxContext) {
        0x2::transfer::public_transfer<Config>(new_config(arg0, arg1), arg0);
    }

    fun create_session<T0, T1>(arg0: &Config, arg1: u64, arg2: u64, arg3: u64, arg4: u64, arg5: bool, arg6: u64, arg7: u64, arg8: u128, arg9: u128, arg10: &mut 0x2::tx_context::TxContext) : Session<T0, T1> {
        assert!(0x2::tx_context::sender(arg10) == arg0.owner, 0);
        assert!(arg2 > 0, 1);
        assert!(arg3 > 0, 2);
        if (!arg5) {
            let v0 = if (arg6 == 0) {
                if (arg7 == 0) {
                    if (arg8 == 0) {
                        arg9 == 0
                    } else {
                        false
                    }
                } else {
                    false
                }
            } else {
                false
            };
            assert!(v0, 4);
        };
        let v1 = Session<T0, T1>{
            id                             : 0x2::object::new(arg10),
            config_id                      : 0x2::object::id<Config>(arg0),
            owner                          : arg0.owner,
            route_id                       : arg1,
            expected_leg_count             : arg2,
            next_leg_index                 : 0,
            input_start_raw                : arg4,
            returned_start_raw             : 0,
            has_deep_pricing               : arg5,
            input_deep_raw                 : arg6,
            deep_remaining_raw             : arg6,
            max_deep_spend_raw             : arg7,
            deep_to_start_num              : arg8,
            deep_to_start_den              : arg9,
            min_execution_profit_start_raw : arg3,
        };
        let v2 = ExecutionStarted{
            config_id                      : v1.config_id,
            route_id                       : arg1,
            expected_leg_count             : arg2,
            start_token                    : type_bytes<T0>(),
            input_start_raw                : arg4,
            input_deep_raw                 : arg6,
            min_execution_profit_start_raw : arg3,
            max_deep_spend_raw             : arg7,
            deep_to_start_num              : arg8,
            deep_to_start_den              : arg9,
        };
        0x2::event::emit<ExecutionStarted>(v2);
        v1
    }

    public fun finish<T0, T1>(arg0: Session<T0, T1>, arg1: 0x2::coin::Coin<T0>, arg2: 0x2::coin::Coin<T1>) {
        let Session {
            id                             : v0,
            config_id                      : v1,
            owner                          : v2,
            route_id                       : v3,
            expected_leg_count             : v4,
            next_leg_index                 : v5,
            input_start_raw                : v6,
            returned_start_raw             : v7,
            has_deep_pricing               : v8,
            input_deep_raw                 : v9,
            deep_remaining_raw             : v10,
            max_deep_spend_raw             : v11,
            deep_to_start_num              : v12,
            deep_to_start_den              : v13,
            min_execution_profit_start_raw : v14,
        } = arg0;
        assert!(v5 == v4, 10);
        let v15 = v7 + (0x2::coin::value<T0>(&arg1) as u128);
        let v16 = 0x2::coin::value<T1>(&arg2);
        let (v17, v18, v19) = if (v8) {
            assert!(v16 <= v10, 7);
            let v20 = v9 - v16;
            assert!(v20 <= v11, 8);
            (v16, v20, ceil_div((v20 as u128) * v12, v13))
        } else {
            let v21 = if (v9 == 0) {
                if (v10 == 0) {
                    if (v11 == 0) {
                        if (v12 == 0) {
                            if (v13 == 0) {
                                v16 == 0
                            } else {
                                false
                            }
                        } else {
                            false
                        }
                    } else {
                        false
                    }
                } else {
                    false
                }
            } else {
                false
            };
            assert!(v21, 4);
            (0, 0, 0)
        };
        assert!(v15 >= (v6 as u128) + v19 + (v14 as u128), 9);
        let v22 = ExecutionSucceeded{
            config_id                      : v1,
            route_id                       : v3,
            input_start_raw                : v6,
            returned_start_raw             : v15,
            input_deep_raw                 : v9,
            returned_deep_raw              : v17,
            actual_deep_spent_raw          : v18,
            marked_deep_cost_start_raw     : v19,
            min_execution_profit_start_raw : v14,
            execution_delta_start_raw      : v15 - (v6 as u128) - v19,
        };
        0x2::event::emit<ExecutionSucceeded>(v22);
        0x2::transfer::public_transfer<0x2::coin::Coin<T0>>(arg1, v2);
        if (v16 == 0) {
            0x2::coin::destroy_zero<T1>(arg2);
        } else {
            0x2::transfer::public_transfer<0x2::coin::Coin<T1>>(arg2, v2);
        };
        0x2::object::delete(v0);
    }

    public fun is_supported_adapter(arg0: u8) : bool {
        if (arg0 == 0) {
            true
        } else if (arg0 == 1) {
            true
        } else if (arg0 == 2) {
            true
        } else if (arg0 == 3) {
            true
        } else if (arg0 == 4) {
            true
        } else if (arg0 == 5) {
            true
        } else if (arg0 == 6) {
            true
        } else if (arg0 == 7) {
            true
        } else if (arg0 == 8) {
            true
        } else if (arg0 == 9) {
            true
        } else if (arg0 == 10) {
            true
        } else if (arg0 == 11) {
            true
        } else if (arg0 == 12) {
            true
        } else if (arg0 == 13) {
            true
        } else {
            arg0 == 14
        }
    }

    fun new_config(arg0: address, arg1: &mut 0x2::tx_context::TxContext) : Config {
        Config{
            id    : 0x2::object::new(arg1),
            owner : arg0,
        }
    }

    public fun owner(arg0: &Config) : address {
        arg0.owner
    }

    public fun record_leg<T0, T1, T2, T3>(arg0: &mut Session<T0, T1>, arg1: u64, arg2: u8, arg3: address, arg4: u64, arg5: u64) {
        assert!(is_supported_adapter(arg2), 5);
        assert!(arg1 == arg0.next_leg_index, 6);
        let v0 = LegExecuted{
            route_id                  : arg0.route_id,
            leg_index                 : arg1,
            adapter_id                : arg2,
            pool_id                   : arg3,
            input_token               : type_bytes<T2>(),
            output_token              : type_bytes<T3>(),
            input_amount_raw          : arg4,
            output_amount_raw         : arg5,
            actual_deep_fee_spent_raw : 0,
        };
        0x2::event::emit<LegExecuted>(v0);
        arg0.next_leg_index = arg1 + 1;
    }

    public fun record_leg_with_deep<T0, T1, T2, T3>(arg0: &mut Session<T0, T1>, arg1: u64, arg2: u8, arg3: address, arg4: u64, arg5: u64, arg6: u64) {
        assert!(is_supported_adapter(arg2), 5);
        assert!(arg1 == arg0.next_leg_index, 6);
        assert!(arg0.has_deep_pricing, 4);
        assert!(arg6 <= arg0.deep_remaining_raw, 7);
        arg0.deep_remaining_raw = arg6;
        let v0 = LegExecuted{
            route_id                  : arg0.route_id,
            leg_index                 : arg1,
            adapter_id                : arg2,
            pool_id                   : arg3,
            input_token               : type_bytes<T2>(),
            output_token              : type_bytes<T3>(),
            input_amount_raw          : arg4,
            output_amount_raw         : arg5,
            actual_deep_fee_spent_raw : arg0.deep_remaining_raw - arg6,
        };
        0x2::event::emit<LegExecuted>(v0);
        arg0.next_leg_index = arg1 + 1;
    }

    public fun refund_aux<T0, T1, T2>(arg0: &mut Session<T0, T1>, arg1: 0x2::coin::Coin<T2>) {
        refund_coin_internal<T0, T1, T2>(arg0, arg1);
    }

    fun refund_coin_internal<T0, T1, T2>(arg0: &mut Session<T0, T1>, arg1: 0x2::coin::Coin<T2>) {
        let v0 = 0x2::coin::value<T2>(&arg1);
        if (type_bytes<T2>() == type_bytes<T0>()) {
            arg0.returned_start_raw = arg0.returned_start_raw + (v0 as u128);
        };
        if (v0 == 0) {
            0x2::coin::destroy_zero<T2>(arg1);
        } else {
            0x2::transfer::public_transfer<0x2::coin::Coin<T2>>(arg1, arg0.owner);
        };
    }

    public fun refund_deep<T0, T1>(arg0: &mut Session<T0, T1>, arg1: 0x2::coin::Coin<T1>) {
        let v0 = 0x2::coin::value<T1>(&arg1);
        if (arg0.has_deep_pricing) {
            assert!(v0 <= arg0.deep_remaining_raw, 7);
            arg0.deep_remaining_raw = v0;
        } else {
            assert!(v0 == 0, 4);
        };
        if (v0 == 0) {
            0x2::coin::destroy_zero<T1>(arg1);
        } else {
            0x2::transfer::public_transfer<0x2::coin::Coin<T1>>(arg1, arg0.owner);
        };
    }

    public fun refund_start<T0, T1>(arg0: &mut Session<T0, T1>, arg1: 0x2::coin::Coin<T0>) {
        arg0.returned_start_raw = arg0.returned_start_raw + (0x2::coin::value<T0>(&arg1) as u128);
        0x2::transfer::public_transfer<0x2::coin::Coin<T0>>(arg1, arg0.owner);
    }

    public fun start_with_deep<T0, T1>(arg0: &Config, arg1: u64, arg2: u64, arg3: u64, arg4: &0x2::coin::Coin<T0>, arg5: &0x2::coin::Coin<T1>, arg6: u64, arg7: u128, arg8: u128, arg9: &mut 0x2::tx_context::TxContext) : Session<T0, T1> {
        assert!(arg8 != 0, 3);
        create_session<T0, T1>(arg0, arg1, arg2, arg3, 0x2::coin::value<T0>(arg4), true, 0x2::coin::value<T1>(arg5), arg6, arg7, arg8, arg9)
    }

    public fun start_without_deep<T0, T1>(arg0: &Config, arg1: u64, arg2: u64, arg3: u64, arg4: &0x2::coin::Coin<T0>, arg5: &mut 0x2::tx_context::TxContext) : Session<T0, T1> {
        create_session<T0, T1>(arg0, arg1, arg2, arg3, 0x2::coin::value<T0>(arg4), false, 0, 0, 0, 0, arg5)
    }

    public fun take_input_or_all<T0, T1, T2>(arg0: &mut Session<T0, T1>, arg1: u64, arg2: 0x2::coin::Coin<T2>, arg3: &mut 0x2::tx_context::TxContext) : (0x2::coin::Coin<T2>, u64) {
        let v0 = 0x2::coin::value<T2>(&arg2);
        if (v0 <= arg1) {
            (arg2, v0)
        } else {
            refund_coin_internal<T0, T1, T2>(arg0, arg2);
            (0x2::coin::split<T2>(&mut arg2, arg1, arg3), arg1)
        }
    }

    fun type_bytes<T0>() : vector<u8> {
        0x1::ascii::into_bytes(0x1::type_name::into_string(0x1::type_name::with_original_ids<T0>()))
    }

    public fun uses_deep_pricing<T0, T1>(arg0: &Session<T0, T1>) : bool {
        arg0.has_deep_pricing
    }

    // decompiled from Move bytecode v6
}

