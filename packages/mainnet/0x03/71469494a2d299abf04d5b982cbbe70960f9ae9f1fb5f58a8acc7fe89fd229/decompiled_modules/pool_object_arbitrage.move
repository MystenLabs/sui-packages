module 0x371469494a2d299abf04d5b982cbbe70960f9ae9f1fb5f58a8acc7fe89fd229::pool_object_arbitrage {
    struct PoolWrapper has store, key {
        id: 0x2::object::UID,
        pool_id: 0x2::object::ID,
        pool_type: vector<u8>,
        fee_rate: u64,
    }

    struct AtomicArbitrageExecuted has copy, drop {
        trader: address,
        initial_amount: u64,
        final_amount: u64,
        profit: u64,
        timestamp: u64,
        route: vector<u8>,
        pools_used: vector<0x2::object::ID>,
    }

    struct ArbitrageResult has store, key {
        id: 0x2::object::UID,
        profit: u64,
        success: bool,
        execution_time: u64,
        route: vector<u8>,
        pools_used: vector<0x2::object::ID>,
    }

    public entry fun arb_with_pool_objects(arg0: 0x2::coin::Coin<0x2::sui::SUI>, arg1: 0x2::object::ID, arg2: 0x2::object::ID, arg3: u64, arg4: &0x2::clock::Clock, arg5: &mut 0x2::tx_context::TxContext) {
        let v0 = 0x2::coin::value<0x2::sui::SUI>(&arg0);
        let v1 = 0x2::tx_context::sender(arg5);
        let v2 = 0x2::clock::timestamp_ms(arg4);
        assert!(v0 > 0, 0x371469494a2d299abf04d5b982cbbe70960f9ae9f1fb5f58a8acc7fe89fd229::constants::get_invalid_amount_error());
        assert!(v0 >= 0x371469494a2d299abf04d5b982cbbe70960f9ae9f1fb5f58a8acc7fe89fd229::constants::get_min_sui_amount(), 0x371469494a2d299abf04d5b982cbbe70960f9ae9f1fb5f58a8acc7fe89fd229::constants::get_invalid_amount_error());
        let v3 = 0x1::vector::empty<0x2::object::ID>();
        0x1::vector::push_back<0x2::object::ID>(&mut v3, arg1);
        0x1::vector::push_back<0x2::object::ID>(&mut v3, arg2);
        let v4 = v0 * 30 / 10000 + v0 * 25 / 10000 + v0 * 10 / 10000 + 3000000;
        if (v4 < v0) {
            0x2::transfer::public_transfer<0x2::coin::Coin<0x2::sui::SUI>>(0x2::coin::split<0x2::sui::SUI>(&mut arg0, v4, arg5), @0x0);
        };
        let v5 = 0x2::coin::value<0x2::sui::SUI>(&arg0);
        let v6 = if (v5 > v0) {
            v5 - v0
        } else {
            0
        };
        assert!(v6 >= arg3, 0x371469494a2d299abf04d5b982cbbe70960f9ae9f1fb5f58a8acc7fe89fd229::constants::get_insufficient_profit_error());
        let v7 = ArbitrageResult{
            id             : 0x2::object::new(arg5),
            profit         : v6,
            success        : true,
            execution_time : v2,
            route          : b"POOL-OBJECT-ARB",
            pools_used     : v3,
        };
        let v8 = AtomicArbitrageExecuted{
            trader         : v1,
            initial_amount : v0,
            final_amount   : v5,
            profit         : v6,
            timestamp      : v2,
            route          : b"POOL-OBJECT-ARB",
            pools_used     : v3,
        };
        0x2::event::emit<AtomicArbitrageExecuted>(v8);
        0x2::transfer::public_transfer<0x2::coin::Coin<0x2::sui::SUI>>(arg0, v1);
        0x2::transfer::transfer<ArbitrageResult>(v7, v1);
    }

    public fun create_pool_wrapper(arg0: 0x2::object::ID, arg1: vector<u8>, arg2: u64, arg3: &mut 0x2::tx_context::TxContext) : PoolWrapper {
        PoolWrapper{
            id        : 0x2::object::new(arg3),
            pool_id   : arg0,
            pool_type : arg1,
            fee_rate  : arg2,
        }
    }

    public fun get_pool_info(arg0: &PoolWrapper) : (0x2::object::ID, vector<u8>, u64) {
        (arg0.pool_id, arg0.pool_type, arg0.fee_rate)
    }

    // decompiled from Move bytecode v6
}

