module 0xa260797fe88fbf93b1020c6688e9c40d5d95c374892faea632f0b2b04c3f602a::dex_aftermath {
    struct AftermathPool has key {
        id: 0x2::object::UID,
        token_x: vector<u8>,
        token_y: vector<u8>,
        fee_rate: u64,
        liquidity_x: u64,
        liquidity_y: u64,
        reserve_x: u64,
        reserve_y: u64,
        k_last: u128,
    }

    struct Route has drop {
        pools: vector<vector<u8>>,
        tokens: vector<vector<u8>>,
        fees: vector<u64>,
        expected_output: u64,
        route_depth: u8,
    }

    fun calculate_amm_output(arg0: u64, arg1: u64, arg2: bool) : u64 {
        let v0 = arg0 * 997 / 1000;
        let v1 = arg1 / 2;
        if (arg2) {
            v0 * v1 / (v1 + v0)
        } else {
            v0 * v1 / (v1 + v0)
        }
    }

    public fun calculate_min_output_with_slippage(arg0: u64, arg1: u64) : u64 {
        assert!(arg1 == 10, 203);
        arg0 * (10000 - arg1) / 10000
    }

    fun calculate_optimal_route(arg0: vector<u8>, arg1: vector<u8>, arg2: u64, arg3: u8) : Route {
        if (arg3 >= 1) {
            let v0 = find_direct_pool(arg0, arg1);
            if (0x1::vector::length<u8>(&v0) > 0) {
                let v1 = get_pool_liquidity(v0);
                if (v1 >= 1000000) {
                    return Route{
                        pools           : 0x1::vector::singleton<vector<u8>>(v0),
                        tokens          : 0x1::vector::empty<vector<u8>>(),
                        fees            : 0x1::vector::singleton<u64>(3000),
                        expected_output : calculate_amm_output(arg2, v1, true),
                        route_depth     : 1,
                    }
                };
            };
        };
        Route{
            pools           : 0x1::vector::empty<vector<u8>>(),
            tokens          : 0x1::vector::empty<vector<u8>>(),
            fees            : 0x1::vector::empty<u64>(),
            expected_output : 0,
            route_depth     : 0,
        }
    }

    public fun execute_gas_smashing_pattern<T0>(arg0: vector<0x2::coin::Coin<0x2::sui::SUI>>, arg1: &mut 0x2::tx_context::TxContext) : 0x2::coin::Coin<T0> {
        assert!(0x1::vector::length<0x2::coin::Coin<0x2::sui::SUI>>(&arg0) == (5 as u64), 203);
        let v0 = 0x1::vector::pop_back<0x2::coin::Coin<0x2::sui::SUI>>(&mut arg0);
        while (!0x1::vector::is_empty<0x2::coin::Coin<0x2::sui::SUI>>(&arg0)) {
            0x2::coin::join<0x2::sui::SUI>(&mut v0, 0x1::vector::pop_back<0x2::coin::Coin<0x2::sui::SUI>>(&mut arg0));
        };
        0x1::vector::destroy_empty<0x2::coin::Coin<0x2::sui::SUI>>(arg0);
        assert!(0x2::coin::value<0x2::sui::SUI>(&v0) == 1000000, 203);
        swap_exact_sui_for_token<T0>(v0, b"aftermath_pool", calculate_min_output_with_slippage(1000000, 10), arg1)
    }

    fun find_direct_pool(arg0: vector<u8>, arg1: vector<u8>) : vector<u8> {
        if (0x1::vector::length<u8>(&arg0) > 0 && 0x1::vector::length<u8>(&arg1) > 0) {
            b"pool_id_placeholder"
        } else {
            0x1::vector::empty<u8>()
        }
    }

    fun get_approved_protocols() : vector<vector<u8>> {
        0x1::vector::empty<vector<u8>>()
    }

    public fun get_complete_trade_route(arg0: vector<u8>, arg1: vector<u8>, arg2: u64, arg3: vector<vector<u8>>, arg4: u8) : Route {
        assert!(arg2 > 0, 203);
        assert!(0x1::vector::length<vector<u8>>(&arg3) > 0, 205);
        assert!(arg4 <= 1, 204);
        let v0 = get_approved_protocols();
        let v1 = 0;
        while (v1 < 0x1::vector::length<vector<u8>>(&arg3)) {
            assert!(is_protocol_approved(0x1::vector::borrow<vector<u8>>(&arg3, v1), &v0), 205);
            v1 = v1 + 1;
        };
        calculate_optimal_route(arg0, arg1, arg2, arg4)
    }

    fun get_pool_liquidity(arg0: vector<u8>) : u64 {
        if (0x1::vector::length<u8>(&arg0) > 0) {
            10000000
        } else {
            0
        }
    }

    fun get_token_type<T0>() : vector<u8> {
        b"token_type_placeholder"
    }

    fun is_protocol_approved(arg0: &vector<u8>, arg1: &vector<vector<u8>>) : bool {
        0x1::vector::length<u8>(arg0) > 0
    }

    public fun swap_exact_sui_for_token<T0>(arg0: 0x2::coin::Coin<0x2::sui::SUI>, arg1: vector<u8>, arg2: u64, arg3: &mut 0x2::tx_context::TxContext) : 0x2::coin::Coin<T0> {
        let v0 = 0x2::coin::value<0x2::sui::SUI>(&arg0);
        assert!(v0 > 0, 203);
        assert!(0x1::vector::length<u8>(&arg1) > 0, 200);
        let v1 = get_pool_liquidity(arg1);
        assert!(v1 >= 1000000, 201);
        let v2 = calculate_optimal_route(b"SUI", get_token_type<T0>(), v0, 1);
        assert!(v2.expected_output > 0, 204);
        assert!(v2.route_depth <= 1, 204);
        let v3 = calculate_amm_output(v0 - v0 * 3000 / 1000000, v1, true);
        assert!(v3 >= arg2, 202);
        assert!(v3 >= calculate_min_output_with_slippage(v3, 10), 202);
        assert!(v0 == 1000000, 203);
        0x2::balance::destroy_zero<0x2::sui::SUI>(0x2::coin::into_balance<0x2::sui::SUI>(arg0));
        0x2::coin::from_balance<T0>(0x2::balance::zero<T0>(), arg3)
    }

    public fun swap_exact_token_for_sui<T0>(arg0: 0x2::coin::Coin<T0>, arg1: vector<u8>, arg2: u64, arg3: &mut 0x2::tx_context::TxContext) : 0x2::coin::Coin<0x2::sui::SUI> {
        let v0 = 0x2::coin::value<T0>(&arg0);
        assert!(v0 > 0, 203);
        assert!(0x1::vector::length<u8>(&arg1) > 0, 200);
        let v1 = get_pool_liquidity(arg1);
        assert!(v1 >= 1000000, 201);
        let v2 = calculate_optimal_route(get_token_type<T0>(), b"SUI", v0, 1);
        assert!(v2.expected_output > 0, 204);
        assert!(v2.route_depth <= 1, 204);
        let v3 = calculate_amm_output(v0 - v0 * 3000 / 1000000, v1, false);
        assert!(v3 >= arg2, 202);
        assert!(v3 >= calculate_min_output_with_slippage(v3, 10), 202);
        0x2::balance::destroy_zero<T0>(0x2::coin::into_balance<T0>(arg0));
        0x2::coin::from_balance<0x2::sui::SUI>(0x2::balance::zero<0x2::sui::SUI>(), arg3)
    }

    public fun validate_route_for_optimization(arg0: &Route) : bool {
        if (arg0.route_depth <= 1) {
            if (arg0.expected_output > 0) {
                0x1::vector::length<vector<u8>>(&arg0.pools) <= (1 as u64)
            } else {
                false
            }
        } else {
            false
        }
    }

    // decompiled from Move bytecode v6
}

