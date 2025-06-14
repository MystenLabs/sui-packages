module 0x926038960e9e8841158a7159075f2727624e18ebdf495ecc7cd23428188b7eb1::dex_aftermath {
    struct AftermathSwapExecuted has copy, drop {
        pool: address,
        pool_type: u8,
        amount_in: u64,
        amount_out: u64,
        fee_amount: u64,
        num_assets: u8,
    }

    struct AftermathMultiSwapExecuted has copy, drop {
        pools: vector<address>,
        total_amount_in: u64,
        total_amount_out: u64,
        total_fees: u64,
        num_hops: u8,
    }

    public fun swap<T0, T1>(arg0: address, arg1: u8, arg2: 0x2::coin::Coin<T0>, arg3: u64, arg4: &mut 0x2::tx_context::TxContext) : 0x2::coin::Coin<T1> {
        let v0 = 0x2::coin::value<T0>(&arg2);
        assert!(v0 > 0, 1002);
        let (v1, v2) = get_pool_params(arg0, arg1);
        let v3 = v0 * v1 / 10000;
        let v4 = calculate_swap_output(v0 - v3, arg1, arg0);
        assert!(v4 >= arg3, 1003);
        let v5 = AftermathSwapExecuted{
            pool       : arg0,
            pool_type  : arg1,
            amount_in  : v0,
            amount_out : v4,
            fee_amount : v3,
            num_assets : v2,
        };
        0x2::event::emit<AftermathSwapExecuted>(v5);
        0x2::coin::destroy_zero<T0>(arg2);
        0x2::coin::from_balance<T1>(0x2::balance::zero<T1>(), arg4)
    }

    public fun add_liquidity_weighted<T0, T1>(arg0: address, arg1: 0x2::coin::Coin<T0>, arg2: 0x2::coin::Coin<T1>, arg3: vector<u64>, arg4: u64, arg5: &mut 0x2::tx_context::TxContext) : u64 {
        let v0 = 0x2::coin::value<T0>(&arg1);
        let v1 = 0x2::coin::value<T1>(&arg2);
        assert!(0x1::vector::length<u64>(&arg3) == 2, 1004);
        let v2 = v0 * *0x1::vector::borrow<u64>(&arg3, 1) / v1 * *0x1::vector::borrow<u64>(&arg3, 0);
        assert!(v2 > 95 && v2 < 105, 1005);
        let v3 = (v0 + v1) / 2;
        assert!(v3 >= arg4, 1003);
        0x2::coin::destroy_zero<T0>(arg1);
        0x2::coin::destroy_zero<T1>(arg2);
        v3
    }

    fun calculate_price_impact(arg0: u64, arg1: address) : u64 {
        if (arg0 > 10000000000) {
            120
        } else if (arg0 > 1000000000) {
            50
        } else if (arg0 > 100000000) {
            20
        } else {
            5
        }
    }

    fun calculate_swap_output(arg0: u64, arg1: u8, arg2: address) : u64 {
        if (arg1 == 0) {
            arg0 - arg0 * calculate_price_impact(arg0, arg2) / 10000 / 2
        } else if (arg1 == 1) {
            arg0 - arg0 * calculate_price_impact(arg0, arg2) / 10000
        } else {
            arg0 - arg0 * calculate_price_impact(arg0, arg2) / 10000
        }
    }

    fun get_pool_params(arg0: address, arg1: u8) : (u64, u8) {
        if (arg1 == 0) {
            (10, 2)
        } else if (arg1 == 1) {
            (25, 4)
        } else if (arg1 == 2) {
            (20, 2)
        } else {
            (30, 2)
        }
    }

    public fun get_quote(arg0: address, arg1: u8, arg2: u64) : (u64, u64) {
        let (v0, _) = get_pool_params(arg0, arg1);
        let v2 = arg2 * v0 / 10000;
        (calculate_swap_output(arg2 - v2, arg1, arg0), v2)
    }

    public fun is_multi_asset_pool(arg0: u8) : bool {
        arg0 == 1
    }

    public fun multi_swap<T0, T1>(arg0: vector<address>, arg1: vector<u8>, arg2: 0x2::coin::Coin<T0>, arg3: u64, arg4: &mut 0x2::tx_context::TxContext) : 0x2::coin::Coin<T1> {
        let v0 = 0x1::vector::length<address>(&arg0);
        assert!(v0 > 0 && v0 <= 5, 1001);
        let v1 = 0x2::coin::value<T0>(&arg2);
        let v2 = v1;
        let v3 = 0;
        let v4 = 0;
        while (v4 < v0) {
            let v5 = *0x1::vector::borrow<address>(&arg0, v4);
            let (v6, _) = get_pool_params(v5, *0x1::vector::borrow<u8>(&arg1, v4));
            let v8 = v2 * v6 / 10000;
            v3 = v3 + v8;
            let v9 = v2 - v8;
            v2 = v9 - v9 * calculate_price_impact(v9, v5) / 10000;
            v4 = v4 + 1;
        };
        assert!(v2 >= arg3, 1003);
        let v10 = AftermathMultiSwapExecuted{
            pools            : arg0,
            total_amount_in  : v1,
            total_amount_out : v2,
            total_fees       : v3,
            num_hops         : (v0 as u8),
        };
        0x2::event::emit<AftermathMultiSwapExecuted>(v10);
        0x2::coin::destroy_zero<T0>(arg2);
        0x2::coin::from_balance<T1>(0x2::balance::zero<T1>(), arg4)
    }

    public fun swap_stable<T0, T1>(arg0: address, arg1: 0x2::coin::Coin<T0>, arg2: u64, arg3: &mut 0x2::tx_context::TxContext) : 0x2::coin::Coin<T1> {
        swap<T0, T1>(arg0, 0, arg1, arg2, arg3)
    }

    // decompiled from Move bytecode v6
}

