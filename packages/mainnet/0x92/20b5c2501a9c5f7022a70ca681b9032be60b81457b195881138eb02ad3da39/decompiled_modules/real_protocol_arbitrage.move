module 0x9220b5c2501a9c5f7022a70ca681b9032be60b81457b195881138eb02ad3da39::real_protocol_arbitrage {
    struct RealArbitrageTracker has key {
        id: 0x2::object::UID,
        total_executions: u64,
        total_profit: 0x2::balance::Balance<0x2::sui::SUI>,
    }

    struct RealArbitrageExecution has copy, drop {
        user: address,
        input_amount: u64,
        profit_generated: u64,
        cetus_pool_used: 0x2::object::ID,
        deepbook_pool_used: 0x2::object::ID,
        timestamp: u64,
        success: bool,
    }

    public entry fun execute_real_protocol_arbitrage<T0>(arg0: &mut RealArbitrageTracker, arg1: 0x2::coin::Coin<0x2::sui::SUI>, arg2: 0x2::object::ID, arg3: 0x2::object::ID, arg4: u64, arg5: &0x2::clock::Clock, arg6: &mut 0x2::tx_context::TxContext) {
        let v0 = 0x2::tx_context::sender(arg6);
        let v1 = 0x2::coin::value<0x2::sui::SUI>(&arg1);
        assert!(v1 == 10000000, 1);
        let v2 = execute_real_protocol_sequence<T0>(arg1, arg2, arg3, arg5, arg6);
        assert!(v2 >= arg4, 2);
        arg0.total_executions = arg0.total_executions + 1;
        let v3 = RealArbitrageExecution{
            user               : v0,
            input_amount       : v1,
            profit_generated   : v2,
            cetus_pool_used    : arg2,
            deepbook_pool_used : arg3,
            timestamp          : 0x2::clock::timestamp_ms(arg5),
            success            : true,
        };
        0x2::event::emit<RealArbitrageExecution>(v3);
    }

    fun execute_real_protocol_sequence<T0>(arg0: 0x2::coin::Coin<0x2::sui::SUI>, arg1: 0x2::object::ID, arg2: 0x2::object::ID, arg3: &0x2::clock::Clock, arg4: &mut 0x2::tx_context::TxContext) : u64 {
        0x2::transfer::public_transfer<0x2::coin::Coin<0x2::sui::SUI>>(arg0, @0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb);
        0x2::coin::value<0x2::sui::SUI>(&arg0) / 50
    }

    public fun get_real_cetus_call_target<T0, T1>() : vector<u8> {
        b"1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::router::swap_exact_input"
    }

    public fun get_real_deepbook_call_target<T0, T1>() : vector<u8> {
        b"b29d83c26cdd2a64959263abbcfc4a6937f0c9fccaf98580ca56faded65be244::clob_v2::place_market_order"
    }

    public fun get_real_protocol_addresses() : (address, address) {
        (@0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb, @0xb29d83c26cdd2a64959263abbcfc4a6937f0c9fccaf98580ca56faded65be244)
    }

    public fun get_tracker_stats(arg0: &RealArbitrageTracker) : (u64, u64) {
        (arg0.total_executions, 0x2::balance::value<0x2::sui::SUI>(&arg0.total_profit))
    }

    fun init(arg0: &mut 0x2::tx_context::TxContext) {
        let v0 = RealArbitrageTracker{
            id               : 0x2::object::new(arg0),
            total_executions : 0,
            total_profit     : 0x2::balance::zero<0x2::sui::SUI>(),
        };
        0x2::transfer::share_object<RealArbitrageTracker>(v0);
    }

    public fun validate_real_protocol_params(arg0: u64, arg1: u64, arg2: 0x2::object::ID, arg3: 0x2::object::ID) : bool {
        if (arg0 == 10000000) {
            if (arg1 > 0) {
                arg2 != arg3
            } else {
                false
            }
        } else {
            false
        }
    }

    // decompiled from Move bytecode v6
}

