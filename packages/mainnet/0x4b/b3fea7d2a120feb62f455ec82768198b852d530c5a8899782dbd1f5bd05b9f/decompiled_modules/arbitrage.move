module 0x4bb3fea7d2a120feb62f455ec82768198b852d530c5a8899782dbd1f5bd05b9f::arbitrage {
    struct ArbitrageExecuted has copy, drop {
        executor: address,
        profit: u64,
        path: vector<0x1::string::String>,
        dexes: vector<0x1::string::String>,
        timestamp: u64,
    }

    struct ArbitrageFailed has copy, drop {
        executor: address,
        reason: 0x1::string::String,
        timestamp: u64,
    }

    struct ArbitrageConfig has key {
        id: 0x2::object::UID,
        min_profit_threshold: u64,
        max_slippage: u64,
        admin: address,
    }

    struct DEXCall has drop {
        dex_name: 0x1::string::String,
        function_name: 0x1::string::String,
        input_amount: u64,
        expected_output: u64,
    }

    fun buy_on_dex<T0>(arg0: 0x2::coin::Coin<T0>, arg1: &0x1::string::String, arg2: &0x1::string::String, arg3: &mut 0x2::tx_context::TxContext) : 0x2::coin::Coin<T0> {
        let v0 = 0x1::string::utf8(b"SUI");
        let v1 = 0x1::string::utf8(b"TOKEN");
        swap_on_dex<T0>(arg0, arg1, &v0, &v1, arg3)
    }

    public fun config_max_slippage(arg0: &ArbitrageConfig) : u64 {
        arg0.max_slippage
    }

    public fun config_min_profit(arg0: &ArbitrageConfig) : u64 {
        arg0.min_profit_threshold
    }

    fun execute_arbitrage_path<T0>(arg0: 0x2::coin::Coin<T0>, arg1: &vector<0x1::string::String>, arg2: &vector<0x1::string::String>, arg3: &mut 0x2::tx_context::TxContext) : 0x2::coin::Coin<T0> {
        let v0 = arg0;
        let v1 = 0;
        while (v1 < 0x1::vector::length<0x1::string::String>(arg1) - 1) {
            v0 = swap_on_dex<T0>(v0, 0x1::vector::borrow<0x1::string::String>(arg2, v1), 0x1::vector::borrow<0x1::string::String>(arg1, v1), 0x1::vector::borrow<0x1::string::String>(arg1, v1 + 1), arg3);
            v1 = v1 + 1;
        };
        v0
    }

    public fun execute_cross_dex_arbitrage<T0>(arg0: &mut 0x4bb3fea7d2a120feb62f455ec82768198b852d530c5a8899782dbd1f5bd05b9f::flashloan::FlashloanPool<T0>, arg1: u64, arg2: 0x1::string::String, arg3: 0x1::string::String, arg4: 0x1::string::String, arg5: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x4bb3fea7d2a120feb62f455ec82768198b852d530c5a8899782dbd1f5bd05b9f::flashloan::flashloan<T0>(arg0, arg1, arg5);
        let v2 = v1;
        let v3 = 0x2::tx_context::sender(arg5);
        let v4 = arg1 + 0x4bb3fea7d2a120feb62f455ec82768198b852d530c5a8899782dbd1f5bd05b9f::flashloan::receipt_fee<T0>(&v2);
        let v5 = buy_on_dex<T0>(v0, &arg3, &arg2, arg5);
        let v6 = sell_on_dex<T0>(v5, &arg4, &arg2, arg5);
        let v7 = 0x2::coin::value<T0>(&v6);
        assert!(v7 > v4, 1);
        0x4bb3fea7d2a120feb62f455ec82768198b852d530c5a8899782dbd1f5bd05b9f::flashloan::repay_flashloan<T0>(arg0, 0x2::coin::split<T0>(&mut v6, v4, arg5), v2, arg5);
        0x2::transfer::public_transfer<0x2::coin::Coin<T0>>(v6, v3);
        let v8 = 0x1::vector::empty<0x1::string::String>();
        0x1::vector::push_back<0x1::string::String>(&mut v8, 0x1::string::utf8(b"SUI"));
        0x1::vector::push_back<0x1::string::String>(&mut v8, arg2);
        0x1::vector::push_back<0x1::string::String>(&mut v8, 0x1::string::utf8(b"SUI"));
        let v9 = 0x1::vector::empty<0x1::string::String>();
        0x1::vector::push_back<0x1::string::String>(&mut v9, arg3);
        0x1::vector::push_back<0x1::string::String>(&mut v9, arg4);
        let v10 = ArbitrageExecuted{
            executor  : v3,
            profit    : v7 - v4,
            path      : v8,
            dexes     : v9,
            timestamp : 0x2::tx_context::epoch_timestamp_ms(arg5),
        };
        0x2::event::emit<ArbitrageExecuted>(v10);
    }

    public fun execute_triangular_arbitrage<T0>(arg0: &mut 0x4bb3fea7d2a120feb62f455ec82768198b852d530c5a8899782dbd1f5bd05b9f::flashloan::FlashloanPool<T0>, arg1: u64, arg2: vector<0x1::string::String>, arg3: vector<0x1::string::String>, arg4: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x4bb3fea7d2a120feb62f455ec82768198b852d530c5a8899782dbd1f5bd05b9f::flashloan::flashloan<T0>(arg0, arg1, arg4);
        let v2 = v1;
        let v3 = 0x2::tx_context::sender(arg4);
        let v4 = arg1 + 0x4bb3fea7d2a120feb62f455ec82768198b852d530c5a8899782dbd1f5bd05b9f::flashloan::receipt_fee<T0>(&v2);
        let v5 = execute_arbitrage_path<T0>(v0, &arg2, &arg3, arg4);
        let v6 = 0x2::coin::value<T0>(&v5);
        assert!(v6 > v4, 1);
        0x4bb3fea7d2a120feb62f455ec82768198b852d530c5a8899782dbd1f5bd05b9f::flashloan::repay_flashloan<T0>(arg0, 0x2::coin::split<T0>(&mut v5, v4, arg4), v2, arg4);
        0x2::transfer::public_transfer<0x2::coin::Coin<T0>>(v5, v3);
        let v7 = ArbitrageExecuted{
            executor  : v3,
            profit    : v6 - v4,
            path      : arg2,
            dexes     : arg3,
            timestamp : 0x2::tx_context::epoch_timestamp_ms(arg4),
        };
        0x2::event::emit<ArbitrageExecuted>(v7);
    }

    public fun init_config(arg0: &mut 0x2::tx_context::TxContext) : ArbitrageConfig {
        ArbitrageConfig{
            id                   : 0x2::object::new(arg0),
            min_profit_threshold : 100,
            max_slippage         : 50,
            admin                : 0x2::tx_context::sender(arg0),
        }
    }

    fun mock_cetus_swap<T0>(arg0: 0x2::coin::Coin<T0>, arg1: &mut 0x2::tx_context::TxContext) : 0x2::coin::Coin<T0> {
        arg0
    }

    fun mock_deepbook_swap<T0>(arg0: 0x2::coin::Coin<T0>, arg1: &mut 0x2::tx_context::TxContext) : 0x2::coin::Coin<T0> {
        arg0
    }

    fun mock_turbos_swap<T0>(arg0: 0x2::coin::Coin<T0>, arg1: &mut 0x2::tx_context::TxContext) : 0x2::coin::Coin<T0> {
        arg0
    }

    fun sell_on_dex<T0>(arg0: 0x2::coin::Coin<T0>, arg1: &0x1::string::String, arg2: &0x1::string::String, arg3: &mut 0x2::tx_context::TxContext) : 0x2::coin::Coin<T0> {
        let v0 = 0x1::string::utf8(b"TOKEN");
        let v1 = 0x1::string::utf8(b"SUI");
        swap_on_dex<T0>(arg0, arg1, &v0, &v1, arg3)
    }

    fun swap_on_dex<T0>(arg0: 0x2::coin::Coin<T0>, arg1: &0x1::string::String, arg2: &0x1::string::String, arg3: &0x1::string::String, arg4: &mut 0x2::tx_context::TxContext) : 0x2::coin::Coin<T0> {
        let v0 = 0x1::string::as_bytes(arg1);
        let v1 = b"Cetus";
        if (v0 == &v1) {
            mock_cetus_swap<T0>(arg0, arg4)
        } else {
            let v3 = b"DeepBook";
            if (v0 == &v3) {
                mock_deepbook_swap<T0>(arg0, arg4)
            } else {
                let v4 = b"Turbos";
                if (v0 == &v4) {
                    mock_turbos_swap<T0>(arg0, arg4)
                } else {
                    arg0
                }
            }
        }
    }

    // decompiled from Move bytecode v6
}

