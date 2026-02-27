module 0xc6333fb9512cd7f21494517ad79b9339662be42f7592b7ecf3fa832cf4d6a33b::yield {
    struct YieldPool has store, key {
        id: 0x2::object::UID,
        pool_type: u8,
        total_deposited: u64,
        total_shares: u64,
        current_apy: u64,
        enabled: bool,
    }

    struct MultiStrategy has store, key {
        id: 0x2::object::UID,
        strategies: vector<u8>,
        allocations: vector<u64>,
        auto_compound: bool,
    }

    struct UserYieldRecord has store, key {
        id: 0x2::object::UID,
        user: address,
        shares_per_strategy: vector<u64>,
        accumulated_yield: u64,
        last_update: u64,
    }

    public fun calculate_compound_yield(arg0: u64, arg1: u64, arg2: u64) : u64 {
        arg0 * arg1 * arg2 / 3650000
    }

    public fun calculate_simple_yield(arg0: u64, arg1: u64, arg2: u64) : u64 {
        arg0 * arg1 * arg2 / 3650000
    }

    public fun calculate_user_yield(arg0: u64, arg1: u64, arg2: u64, arg3: u64, arg4: u64) : u64 {
        if (arg1 == 0 || arg2 == 0) {
            return 0
        };
        calculate_compound_yield(arg2 * arg0 * 10000 / arg1 / 10000, arg3, arg4)
    }

    public fun create_multi_strategy(arg0: vector<u8>, arg1: vector<u64>, arg2: &mut 0x2::tx_context::TxContext) : MultiStrategy {
        let v0 = 0;
        let v1 = 0;
        while (v1 < 0x1::vector::length<u64>(&arg1)) {
            v0 = v0 + *0x1::vector::borrow<u64>(&arg1, v1);
            v1 = v1 + 1;
        };
        assert!(v0 == 10000, 104);
        MultiStrategy{
            id            : 0x2::object::new(arg2),
            strategies    : arg0,
            allocations   : arg1,
            auto_compound : true,
        }
    }

    public fun deposit_to_multi_strategy<T0>(arg0: u64, arg1: &MultiStrategy, arg2: &mut 0x2::tx_context::TxContext) : vector<0x2::balance::Balance<T0>> {
        let v0 = 0x1::vector::empty<0x2::balance::Balance<T0>>();
        let v1 = 0;
        while (v1 < 0x1::vector::length<u8>(&arg1.strategies)) {
            let v2 = *0x1::vector::borrow<u8>(&arg1.strategies, v1);
            let v3 = if (v2 == 1) {
                deposit_to_navi<T0>(arg0 * *0x1::vector::borrow<u64>(&arg1.allocations, v1) / 10000, arg2)
            } else if (v2 == 2) {
                deposit_to_scallop<T0>(arg0 * *0x1::vector::borrow<u64>(&arg1.allocations, v1) / 10000, arg2)
            } else {
                deposit_to_navi<T0>(arg0 * *0x1::vector::borrow<u64>(&arg1.allocations, v1) / 10000, arg2)
            };
            0x1::vector::push_back<0x2::balance::Balance<T0>>(&mut v0, v3);
            v1 = v1 + 1;
        };
        v0
    }

    public fun deposit_to_navi<T0>(arg0: u64, arg1: &mut 0x2::tx_context::TxContext) : 0x2::balance::Balance<T0> {
        0x2::balance::zero<T0>()
    }

    public fun deposit_to_scallop<T0>(arg0: u64, arg1: &mut 0x2::tx_context::TxContext) : 0x2::balance::Balance<T0> {
        0x2::balance::zero<T0>()
    }

    public fun get_available_strategies() : vector<u8> {
        let v0 = 0x1::vector::empty<u8>();
        let v1 = &mut v0;
        0x1::vector::push_back<u8>(v1, 1);
        0x1::vector::push_back<u8>(v1, 2);
        0x1::vector::push_back<u8>(v1, 3);
        v0
    }

    public fun get_multi_strategy_apy(arg0: &MultiStrategy) : u64 {
        let v0 = 0;
        let v1 = 0;
        while (v1 < 0x1::vector::length<u8>(&arg0.strategies)) {
            let v2 = *0x1::vector::borrow<u8>(&arg0.strategies, v1);
            let v3 = if (v2 == 1) {
                get_navi_apy()
            } else if (v2 == 2) {
                get_scallop_apy()
            } else {
                500
            };
            v0 = v0 + v3 * *0x1::vector::borrow<u64>(&arg0.allocations, v1);
            v1 = v1 + 1;
        };
        v0 / 10000
    }

    public fun get_navi_apy() : u64 {
        500
    }

    public fun get_scallop_apy() : u64 {
        450
    }

    public fun get_strategy_name(arg0: u8) : vector<u8> {
        if (arg0 == 1) {
            b"Navi"
        } else if (arg0 == 2) {
            b"Scallop"
        } else if (arg0 == 3) {
            b"Cetus"
        } else {
            b"Unknown"
        }
    }

    public fun withdraw_from_multi_strategy<T0>(arg0: vector<u64>, arg1: vector<u64>, arg2: &MultiStrategy, arg3: &mut 0x2::tx_context::TxContext) : 0x2::balance::Balance<T0> {
        let v0 = 0x2::balance::zero<T0>();
        let v1 = 0;
        while (v1 < 0x1::vector::length<u8>(&arg2.strategies)) {
            let v2 = *0x1::vector::borrow<u8>(&arg2.strategies, v1);
            let v3 = if (v2 == 1) {
                withdraw_from_navi<T0>(*0x1::vector::borrow<u64>(&arg1, v1), arg3)
            } else if (v2 == 2) {
                withdraw_from_scallop<T0>(*0x1::vector::borrow<u64>(&arg1, v1), arg3)
            } else {
                withdraw_from_navi<T0>(*0x1::vector::borrow<u64>(&arg1, v1), arg3)
            };
            0x2::balance::join<T0>(&mut v0, v3);
            v1 = v1 + 1;
        };
        v0
    }

    public fun withdraw_from_navi<T0>(arg0: u64, arg1: &mut 0x2::tx_context::TxContext) : 0x2::balance::Balance<T0> {
        0x2::balance::zero<T0>()
    }

    public fun withdraw_from_scallop<T0>(arg0: u64, arg1: &mut 0x2::tx_context::TxContext) : 0x2::balance::Balance<T0> {
        0x2::balance::zero<T0>()
    }

    // decompiled from Move bytecode v6
}

