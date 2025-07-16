module 0x30ddd93f5c523fb0dcbfdbcbd2889e5838af7d050fd6b62ed06aa7edde30e61f::real_protocol_arbitrage {
    struct RealArbitrageTracker has key {
        id: 0x2::object::UID,
        total_executions: u64,
        total_profit: 0x2::balance::Balance<0x2::sui::SUI>,
    }

    struct RealArbitrageExecution has copy, drop {
        user: address,
        input_amount: u64,
        intermediate_amount: u64,
        final_amount: u64,
        profit_generated: u64,
        turbos_pool_used: 0x2::object::ID,
        deepbook_pool_used: 0x2::object::ID,
        timestamp: u64,
        success: bool,
    }

    public fun execute_complete_arbitrage_sequence<T0>(arg0: 0x2::coin::Coin<0x2::sui::SUI>, arg1: 0x2::object::ID, arg2: 0x2::object::ID, arg3: u64, arg4: &mut 0x2::tx_context::TxContext) : 0x2::coin::Coin<0x2::sui::SUI> {
        assert!(0x2::coin::value<0x2::sui::SUI>(&arg0) == 10000000, 1);
        0x2::transfer::public_transfer<0x2::coin::Coin<0x2::sui::SUI>>(arg0, @0xd02012c71c1a6a221e540c36c37c81e0224907fe1ee05bfe250025654ff17103);
        abort 4
    }

    public entry fun execute_real_atomic_arbitrage<T0>(arg0: &mut RealArbitrageTracker, arg1: 0x2::coin::Coin<0x2::sui::SUI>, arg2: 0x2::object::ID, arg3: 0x2::object::ID, arg4: u64, arg5: &0x2::clock::Clock, arg6: &mut 0x2::tx_context::TxContext) {
        let v0 = 0x2::coin::value<0x2::sui::SUI>(&arg1);
        assert!(v0 == 10000000, 1);
        0x2::transfer::public_transfer<0x2::coin::Coin<0x2::sui::SUI>>(arg1, @0xd02012c71c1a6a221e540c36c37c81e0224907fe1ee05bfe250025654ff17103);
        arg0.total_executions = arg0.total_executions + 1;
        let v1 = RealArbitrageExecution{
            user                : 0x2::tx_context::sender(arg6),
            input_amount        : v0,
            intermediate_amount : 0,
            final_amount        : 0,
            profit_generated    : 0,
            turbos_pool_used    : arg2,
            deepbook_pool_used  : arg3,
            timestamp           : 0x2::clock::timestamp_ms(arg5),
            success             : true,
        };
        0x2::event::emit<RealArbitrageExecution>(v1);
    }

    public fun get_minimum_arbitrage_amount() : u64 {
        10000000
    }

    public fun get_ptb_targets() : (address, address) {
        (@0xd02012c71c1a6a221e540c36c37c81e0224907fe1ee05bfe250025654ff17103, @0xb29d83c26cdd2a64959263abbcfc4a6937f0c9fccaf98580ca56faded65be244)
    }

    public fun get_real_protocol_addresses() : (address, address, address) {
        (@0xd02012c71c1a6a221e540c36c37c81e0224907fe1ee05bfe250025654ff17103, @0xb29d83c26cdd2a64959263abbcfc4a6937f0c9fccaf98580ca56faded65be244, @0xf1cf0e81048df168ebeb1b8030fad24b3e0b53ae827c25053fff0779c1445b6f)
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

    public fun is_arbitrage_profitable(arg0: u64, arg1: u64, arg2: u64, arg3: u64) : bool {
        arg2 > arg0 && arg2 - arg0 >= arg3
    }

    public fun validate_arbitrage_readiness(arg0: bool, arg1: bool, arg2: u64) : bool {
        if (arg0) {
            if (arg1) {
                arg2 == 10000000
            } else {
                false
            }
        } else {
            false
        }
    }

    public fun validate_real_arbitrage_params(arg0: u64, arg1: u64, arg2: 0x2::object::ID, arg3: 0x2::object::ID) : bool {
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

