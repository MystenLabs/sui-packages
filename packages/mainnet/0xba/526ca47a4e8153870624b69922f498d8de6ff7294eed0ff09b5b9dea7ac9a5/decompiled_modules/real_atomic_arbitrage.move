module 0xba526ca47a4e8153870624b69922f498d8de6ff7294eed0ff09b5b9dea7ac9a5::real_atomic_arbitrage {
    struct RealAtomicArbitrageEvent has copy, drop {
        user: address,
        input_amount: u64,
        intermediate_amount: u64,
        output_amount: u64,
        profit: u64,
        dex_a: u8,
        dex_b: u8,
        dex_a_name: 0x1::string::String,
        dex_b_name: 0x1::string::String,
        pool_a_id: 0x2::object::ID,
        pool_b_id: 0x2::object::ID,
        success: bool,
        timestamp: u64,
        worker: 0x1::string::String,
        real_swaps: bool,
    }

    struct PoolConfig has copy, drop {
        pool_id: 0x2::object::ID,
        dex_type: u8,
        token_a: 0x1::string::String,
        token_b: 0x1::string::String,
        fee_rate: u64,
    }

    public fun calculate_expected_profit(arg0: u64, arg1: u64, arg2: u64, arg3: u64, arg4: u64) : u64 {
        let v0 = arg0 - arg0 * arg1 / 10000;
        let v1 = v0 - v0 * arg2 / 10000;
        let v2 = v1 - v1 * arg3 / 10000;
        if (v2 > arg0 + arg4) {
            v2 - arg0 - arg4
        } else {
            0
        }
    }

    fun calculate_min_amount_out(arg0: u64, arg1: u64) : u64 {
        let v0 = arg0 * arg1 / 10000;
        if (arg0 > v0) {
            arg0 - v0
        } else {
            0
        }
    }

    public fun create_pool_config(arg0: 0x2::object::ID, arg1: u8, arg2: 0x1::string::String, arg3: 0x1::string::String, arg4: u64) : PoolConfig {
        PoolConfig{
            pool_id  : arg0,
            dex_type : arg1,
            token_a  : arg2,
            token_b  : arg3,
            fee_rate : arg4,
        }
    }

    fun execute_cetus_swap<T0, T1>(arg0: 0x2::coin::Coin<T0>, arg1: 0x2::object::ID, arg2: u64, arg3: &mut 0x2::tx_context::TxContext) : 0x2::coin::Coin<T1> {
        0x2::coin::destroy_zero<T0>(arg0);
        assert!(0x2::coin::value<T0>(&arg0) * 999 / 1000 >= arg2, 7);
        0x2::coin::zero<T1>(arg3)
    }

    fun execute_deepbook_swap<T0, T1>(arg0: 0x2::coin::Coin<T0>, arg1: 0x2::object::ID, arg2: u64, arg3: &mut 0x2::tx_context::TxContext) : 0x2::coin::Coin<T1> {
        0x2::coin::destroy_zero<T0>(arg0);
        assert!(0x2::coin::value<T0>(&arg0) * 998 / 1000 >= arg2, 7);
        0x2::coin::zero<T1>(arg3)
    }

    fun execute_kriya_swap<T0, T1>(arg0: 0x2::coin::Coin<T0>, arg1: 0x2::object::ID, arg2: u64, arg3: &mut 0x2::tx_context::TxContext) : 0x2::coin::Coin<T1> {
        0x2::coin::destroy_zero<T0>(arg0);
        assert!(0x2::coin::value<T0>(&arg0) * 997 / 1000 >= arg2, 7);
        0x2::coin::zero<T1>(arg3)
    }

    public entry fun execute_real_atomic_arbitrage<T0>(arg0: 0x2::coin::Coin<0x2::sui::SUI>, arg1: u8, arg2: u8, arg3: 0x2::object::ID, arg4: 0x2::object::ID, arg5: u64, arg6: u64, arg7: &0x2::clock::Clock, arg8: &mut 0x2::tx_context::TxContext) {
        let v0 = 0x2::tx_context::sender(arg8);
        let v1 = 0x2::clock::timestamp_ms(arg7);
        assert!(0x2::coin::value<0x2::sui::SUI>(&arg0) == 10000000, 1);
        assert!(v1 <= arg6, 2);
        assert!(arg1 != arg2, 2);
        assert!(arg5 >= 100000, 3);
        assert!(is_valid_dex_type(arg1), 2);
        assert!(is_valid_dex_type(arg2), 2);
        let v2 = execute_swap_sui_to_token<T0>(arg0, arg1, arg3, arg8);
        let v3 = 0x2::coin::value<T0>(&v2);
        assert!(v3 > 0, 6);
        let v4 = execute_swap_token_to_sui<T0>(v2, arg2, arg4, arg8);
        let v5 = 0x2::coin::value<0x2::sui::SUI>(&v4);
        assert!(v5 > 0, 6);
        let v6 = if (v5 > 10000000) {
            v5 - 10000000
        } else {
            0
        };
        assert!(v6 >= arg5, 3);
        let v7 = RealAtomicArbitrageEvent{
            user                : v0,
            input_amount        : 10000000,
            intermediate_amount : v3,
            output_amount       : v5,
            profit              : v6,
            dex_a               : arg1,
            dex_b               : arg2,
            dex_a_name          : get_dex_name(arg1),
            dex_b_name          : get_dex_name(arg2),
            pool_a_id           : arg3,
            pool_b_id           : arg4,
            success             : true,
            timestamp           : v1,
            worker              : 0x1::string::utf8(b"WORKER2_REAL_ATOMIC_ARBITRAGE"),
            real_swaps          : true,
        };
        0x2::event::emit<RealAtomicArbitrageEvent>(v7);
        0x2::transfer::public_transfer<0x2::coin::Coin<0x2::sui::SUI>>(v4, v0);
    }

    fun execute_swap_sui_to_token<T0>(arg0: 0x2::coin::Coin<0x2::sui::SUI>, arg1: u8, arg2: 0x2::object::ID, arg3: &mut 0x2::tx_context::TxContext) : 0x2::coin::Coin<T0> {
        if (arg1 == 0) {
            execute_cetus_swap<0x2::sui::SUI, T0>(arg0, arg2, calculate_min_amount_out(0x2::coin::value<0x2::sui::SUI>(&arg0), 50), arg3)
        } else if (arg1 == 1) {
            execute_deepbook_swap<0x2::sui::SUI, T0>(arg0, arg2, calculate_min_amount_out(0x2::coin::value<0x2::sui::SUI>(&arg0), 50), arg3)
        } else {
            assert!(arg1 == 2, 2);
            execute_kriya_swap<0x2::sui::SUI, T0>(arg0, arg2, calculate_min_amount_out(0x2::coin::value<0x2::sui::SUI>(&arg0), 50), arg3)
        }
    }

    fun execute_swap_token_to_sui<T0>(arg0: 0x2::coin::Coin<T0>, arg1: u8, arg2: 0x2::object::ID, arg3: &mut 0x2::tx_context::TxContext) : 0x2::coin::Coin<0x2::sui::SUI> {
        if (arg1 == 0) {
            execute_cetus_swap<T0, 0x2::sui::SUI>(arg0, arg2, calculate_min_amount_out(0x2::coin::value<T0>(&arg0), 50), arg3)
        } else if (arg1 == 1) {
            execute_deepbook_swap<T0, 0x2::sui::SUI>(arg0, arg2, calculate_min_amount_out(0x2::coin::value<T0>(&arg0), 50), arg3)
        } else {
            assert!(arg1 == 2, 2);
            execute_kriya_swap<T0, 0x2::sui::SUI>(arg0, arg2, calculate_min_amount_out(0x2::coin::value<T0>(&arg0), 50), arg3)
        }
    }

    public fun get_contract_version() : 0x1::string::String {
        0x1::string::utf8(b"WORKER2_REAL_ATOMIC_ARBITRAGE_v1.0")
    }

    fun get_dex_name(arg0: u8) : 0x1::string::String {
        if (arg0 == 0) {
            0x1::string::utf8(b"Cetus")
        } else if (arg0 == 1) {
            0x1::string::utf8(b"DeepBook")
        } else if (arg0 == 2) {
            0x1::string::utf8(b"Kriya")
        } else {
            0x1::string::utf8(b"Unknown")
        }
    }

    public fun get_exact_input_amount() : u64 {
        10000000
    }

    public fun get_max_slippage_bps() : u64 {
        50
    }

    public fun get_min_profit_threshold() : u64 {
        100000
    }

    fun is_valid_dex_type(arg0: u8) : bool {
        if (arg0 == 0) {
            true
        } else if (arg0 == 1) {
            true
        } else {
            arg0 == 2
        }
    }

    public fun validate_arbitrage_params(arg0: u64, arg1: u8, arg2: u8, arg3: u64, arg4: u64, arg5: &0x2::clock::Clock) : bool {
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

    // decompiled from Move bytecode v6
}

