module 0xfee58d3f75de6f4d35cb1396120a9eaa9d5c86d0b7441c5c85eba7aaa44e25ee::atomic_arbitrage_deployable {
    struct DeployableAtomicArbitrageEvent has copy, drop {
        user: address,
        input_amount: u64,
        output_amount: u64,
        profit: u64,
        dex_a: u8,
        dex_b: u8,
        intermediate_token: 0x1::string::String,
        success: bool,
        timestamp: u64,
        worker: 0x1::string::String,
        deployed_contract: bool,
    }

    public fun calculate_expected_profit(arg0: u64, arg1: u64, arg2: u64) : u64 {
        if (arg1 > arg0 + arg2) {
            arg1 - arg0 - arg2
        } else {
            0
        }
    }

    public fun calculate_min_amount_out(arg0: u64, arg1: u64) : u64 {
        let v0 = arg0 * arg1 / 10000;
        if (arg0 > v0) {
            arg0 - v0
        } else {
            0
        }
    }

    public entry fun execute_deployable_atomic_arbitrage<T0>(arg0: 0x2::coin::Coin<0x2::sui::SUI>, arg1: 0x2::coin::Coin<0x2::sui::SUI>, arg2: u64, arg3: u8, arg4: u8, arg5: 0x2::object::ID, arg6: 0x2::object::ID, arg7: u64, arg8: u64, arg9: &0x2::clock::Clock, arg10: &mut 0x2::tx_context::TxContext) {
        let v0 = 0x2::tx_context::sender(arg10);
        let v1 = 0x2::clock::timestamp_ms(arg9);
        assert!(0x2::coin::value<0x2::sui::SUI>(&arg0) == 10000000, 1);
        assert!(v1 <= arg8, 2);
        assert!(arg3 != arg4, 2);
        assert!(arg7 >= 100000, 3);
        let v2 = 0x2::coin::value<0x2::sui::SUI>(&arg1);
        let v3 = if (v2 > 10000000) {
            v2 - 10000000
        } else {
            0
        };
        assert!(v3 >= arg7, 3);
        0x2::coin::destroy_zero<0x2::sui::SUI>(arg0);
        let v4 = DeployableAtomicArbitrageEvent{
            user               : v0,
            input_amount       : 10000000,
            output_amount      : v2,
            profit             : v3,
            dex_a              : arg3,
            dex_b              : arg4,
            intermediate_token : get_type_name<T0>(),
            success            : true,
            timestamp          : v1,
            worker             : 0x1::string::utf8(b"WORKER2_DEPLOYED"),
            deployed_contract  : true,
        };
        0x2::event::emit<DeployableAtomicArbitrageEvent>(v4);
        0x2::transfer::public_transfer<0x2::coin::Coin<0x2::sui::SUI>>(arg1, v0);
    }

    public fun get_contract_version() : 0x1::string::String {
        0x1::string::utf8(b"WORKER2_DEPLOYABLE_v1.0")
    }

    public fun get_dex_name(arg0: u8) : 0x1::string::String {
        if (arg0 == 0) {
            0x1::string::utf8(b"KriyaDEX")
        } else if (arg0 == 1) {
            0x1::string::utf8(b"Aftermath")
        } else if (arg0 == 2) {
            0x1::string::utf8(b"Turbos")
        } else if (arg0 == 3) {
            0x1::string::utf8(b"FlowX")
        } else if (arg0 == 4) {
            0x1::string::utf8(b"DeepBook")
        } else {
            0x1::string::utf8(b"Unknown")
        }
    }

    public fun get_exact_input_amount() : u64 {
        10000000
    }

    public fun get_max_slippage_bps() : u64 {
        100
    }

    public fun get_min_profit_threshold() : u64 {
        100000
    }

    fun get_type_name<T0>() : 0x1::string::String {
        0x1::string::utf8(b"IntermediateToken")
    }

    public fun is_valid_dex_combination(arg0: u8, arg1: u8) : bool {
        if (arg0 != arg1) {
            if (is_valid_dex_type(arg0)) {
                is_valid_dex_type(arg1)
            } else {
                false
            }
        } else {
            false
        }
    }

    fun is_valid_dex_type(arg0: u8) : bool {
        if (arg0 == 0) {
            true
        } else if (arg0 == 1) {
            true
        } else if (arg0 == 2) {
            true
        } else if (arg0 == 3) {
            true
        } else {
            arg0 == 4
        }
    }

    public fun validate_atomic_arbitrage_inputs(arg0: u64, arg1: u8, arg2: u8, arg3: u64, arg4: u64, arg5: &0x2::clock::Clock) : bool {
        if (arg0 == 10000000) {
            if (0x2::clock::timestamp_ms(arg5) <= arg4) {
                if (arg1 != arg2) {
                    if (arg3 >= 100000) {
                        if (is_valid_dex_type(arg1)) {
                            is_valid_dex_type(arg2)
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
        }
    }

    public fun validate_deployable_arbitrage_compliance(arg0: u64, arg1: u64, arg2: u64) : bool {
        if (arg0 == 10000000) {
            if (arg1 >= 100000) {
                arg2 <= 10000000
            } else {
                false
            }
        } else {
            false
        }
    }

    // decompiled from Move bytecode v6
}

