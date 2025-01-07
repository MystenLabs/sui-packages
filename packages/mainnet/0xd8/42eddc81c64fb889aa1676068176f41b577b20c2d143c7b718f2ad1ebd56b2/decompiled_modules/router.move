module 0xd842eddc81c64fb889aa1676068176f41b577b20c2d143c7b718f2ad1ebd56b2::router {
    public entry fun add_lp<T0, T1>(arg0: vector<0x2::coin::Coin<T0>>, arg1: u64, arg2: u64, arg3: vector<0x2::coin::Coin<T1>>, arg4: u64, arg5: u64, arg6: &mut 0xd842eddc81c64fb889aa1676068176f41b577b20c2d143c7b718f2ad1ebd56b2::swap::RyuSwap, arg7: &0x2::clock::Clock, arg8: &mut 0x2::tx_context::TxContext) {
        assert!(0x169518d7d80b7817ee834a6e19eaeeb518d37a56c843edc34f1b5b82b4871494::coin_helper::is_sorted<T0, T1>(), 208);
        let v0 = handle_coin_obj<T0>(arg0, arg1, arg8);
        let v1 = handle_coin_obj<T1>(arg3, arg4, arg8);
        let v2 = 0x2::coin::value<T0>(&v0);
        let v3 = 0x2::coin::value<T1>(&v1);
        assert!(v2 >= arg2, 203);
        assert!(v3 >= arg5, 202);
        let (v4, v5) = calc_optimal_coin_values<T0, T1>(arg6, v2, v3, arg2, arg5);
        let v6 = 0x2::tx_context::sender(arg8);
        if (0x2::coin::value<T0>(&v0) == 0) {
            0x2::coin::destroy_zero<T0>(v0);
        } else {
            0x2::transfer::public_transfer<0x2::coin::Coin<T0>>(v0, v6);
        };
        if (0x2::coin::value<T1>(&v1) == 0) {
            0x2::coin::destroy_zero<T1>(v1);
        } else {
            0x2::transfer::public_transfer<0x2::coin::Coin<T1>>(v1, v6);
        };
        0x2::transfer::public_transfer<0x2::coin::Coin<0xd842eddc81c64fb889aa1676068176f41b577b20c2d143c7b718f2ad1ebd56b2::swap::LPCoin<T0, T1>>>(0xd842eddc81c64fb889aa1676068176f41b577b20c2d143c7b718f2ad1ebd56b2::swap::mint<T0, T1>(arg6, arg7, 0x2::coin::split<T0>(&mut v0, v4, arg8), 0x2::coin::split<T1>(&mut v1, v5, arg8), arg8), v6);
    }

    public fun calc_optimal_coin_values<T0, T1>(arg0: &mut 0xd842eddc81c64fb889aa1676068176f41b577b20c2d143c7b718f2ad1ebd56b2::swap::RyuSwap, arg1: u64, arg2: u64, arg3: u64, arg4: u64) : (u64, u64) {
        let (v0, v1) = get_reserves_size<T0, T1>(arg0);
        if (v0 == 0 && v1 == 0) {
            return (arg1, arg2)
        };
        let v2 = convert_with_current_price(arg1, v0, v1);
        if (v2 <= arg2) {
            assert!(v2 >= arg4, 202);
            return (arg1, v2)
        };
        let v3 = convert_with_current_price(arg2, v1, v0);
        assert!(v3 <= arg1, 204);
        assert!(v3 >= arg3, 203);
        (v3, arg2)
    }

    public fun convert_with_current_price(arg0: u64, arg1: u64, arg2: u64) : u64 {
        assert!(arg0 > 0, 200);
        assert!(arg1 > 0 && arg2 > 0, 201);
        let v0 = (arg0 as u128) * (arg2 as u128) / (arg1 as u128);
        assert!(v0 <= 18446744073709551615, 208);
        (v0 as u64)
    }

    public fun get_amount_in<T0, T1>(arg0: u64, arg1: u64, arg2: u64, arg3: u64, arg4: u64) : u64 {
        get_coin_in_with_fees<T0, T1>(arg2, arg3, arg4, arg1, arg0)
    }

    public fun get_amount_out<T0, T1>(arg0: u64, arg1: u64, arg2: u64, arg3: u64, arg4: u64) : u64 {
        get_coin_out_with_fees<T0, T1>(arg2, arg3, arg4, arg0, arg1)
    }

    fun get_coin_in_with_fees<T0, T1>(arg0: u64, arg1: u64, arg2: u64, arg3: u64, arg4: u64) : u64 {
        assert!(arg3 > arg2, 202);
        let v0 = (arg2 as u128);
        0x169518d7d80b7817ee834a6e19eaeeb518d37a56c843edc34f1b5b82b4871494::math::mul_div_u128(v0, (arg4 as u128) * (arg1 as u128), ((arg3 as u128) - v0) * ((arg1 - arg0) as u128)) + 1
    }

    fun get_coin_out_with_fees<T0, T1>(arg0: u64, arg1: u64, arg2: u64, arg3: u64, arg4: u64) : u64 {
        let v0 = 0x169518d7d80b7817ee834a6e19eaeeb518d37a56c843edc34f1b5b82b4871494::math::mul_to_u128(arg2, arg1 - arg0);
        0x169518d7d80b7817ee834a6e19eaeeb518d37a56c843edc34f1b5b82b4871494::math::mul_div_u128(v0, (arg4 as u128), 0x169518d7d80b7817ee834a6e19eaeeb518d37a56c843edc34f1b5b82b4871494::math::mul_to_u128(arg3, arg1) + v0)
    }

    public fun get_cumulative_prices<T0, T1>(arg0: &mut 0xd842eddc81c64fb889aa1676068176f41b577b20c2d143c7b718f2ad1ebd56b2::swap::RyuSwap) : (u128, u128, u64) {
        if (0x169518d7d80b7817ee834a6e19eaeeb518d37a56c843edc34f1b5b82b4871494::coin_helper::is_sorted<T0, T1>()) {
            0xd842eddc81c64fb889aa1676068176f41b577b20c2d143c7b718f2ad1ebd56b2::swap::get_cumulative_prices<T0, T1>(arg0)
        } else {
            0xd842eddc81c64fb889aa1676068176f41b577b20c2d143c7b718f2ad1ebd56b2::swap::get_cumulative_prices<T1, T0>(arg0)
        }
    }

    public fun get_dao_fee<T0, T1>(arg0: &mut 0xd842eddc81c64fb889aa1676068176f41b577b20c2d143c7b718f2ad1ebd56b2::swap::RyuSwap) : u64 {
        if (0x169518d7d80b7817ee834a6e19eaeeb518d37a56c843edc34f1b5b82b4871494::coin_helper::is_sorted<T0, T1>()) {
            0xd842eddc81c64fb889aa1676068176f41b577b20c2d143c7b718f2ad1ebd56b2::swap::get_dao_fee<T0, T1>(arg0)
        } else {
            0xd842eddc81c64fb889aa1676068176f41b577b20c2d143c7b718f2ad1ebd56b2::swap::get_dao_fee<T1, T0>(arg0)
        }
    }

    public fun get_dao_fees_config<T0, T1>(arg0: &mut 0xd842eddc81c64fb889aa1676068176f41b577b20c2d143c7b718f2ad1ebd56b2::swap::RyuSwap) : (u64, u64) {
        if (0x169518d7d80b7817ee834a6e19eaeeb518d37a56c843edc34f1b5b82b4871494::coin_helper::is_sorted<T0, T1>()) {
            0xd842eddc81c64fb889aa1676068176f41b577b20c2d143c7b718f2ad1ebd56b2::swap::get_dao_fees_config<T0, T1>(arg0)
        } else {
            0xd842eddc81c64fb889aa1676068176f41b577b20c2d143c7b718f2ad1ebd56b2::swap::get_dao_fees_config<T1, T0>(arg0)
        }
    }

    public fun get_fee<T0, T1>(arg0: &mut 0xd842eddc81c64fb889aa1676068176f41b577b20c2d143c7b718f2ad1ebd56b2::swap::RyuSwap) : u64 {
        if (0x169518d7d80b7817ee834a6e19eaeeb518d37a56c843edc34f1b5b82b4871494::coin_helper::is_sorted<T0, T1>()) {
            0xd842eddc81c64fb889aa1676068176f41b577b20c2d143c7b718f2ad1ebd56b2::swap::get_fee<T0, T1>(arg0)
        } else {
            0xd842eddc81c64fb889aa1676068176f41b577b20c2d143c7b718f2ad1ebd56b2::swap::get_fee<T1, T0>(arg0)
        }
    }

    public fun get_fees_config<T0, T1>(arg0: &mut 0xd842eddc81c64fb889aa1676068176f41b577b20c2d143c7b718f2ad1ebd56b2::swap::RyuSwap) : (u64, u64) {
        if (0x169518d7d80b7817ee834a6e19eaeeb518d37a56c843edc34f1b5b82b4871494::coin_helper::is_sorted<T0, T1>()) {
            0xd842eddc81c64fb889aa1676068176f41b577b20c2d143c7b718f2ad1ebd56b2::swap::get_fees_config<T0, T1>(arg0)
        } else {
            0xd842eddc81c64fb889aa1676068176f41b577b20c2d143c7b718f2ad1ebd56b2::swap::get_fees_config<T1, T0>(arg0)
        }
    }

    public fun get_reserves_for_lp_coins<T0, T1>(arg0: &mut 0xd842eddc81c64fb889aa1676068176f41b577b20c2d143c7b718f2ad1ebd56b2::swap::RyuSwap, arg1: &mut 0xd842eddc81c64fb889aa1676068176f41b577b20c2d143c7b718f2ad1ebd56b2::swap::LiquidityPool<T0, T1>, arg2: u64) : (u64, u64) {
        let (v0, v1) = get_reserves_size<T0, T1>(arg0);
        let v2 = 0xd842eddc81c64fb889aa1676068176f41b577b20c2d143c7b718f2ad1ebd56b2::swap::get_lp_total<T0, T1>(arg1);
        let v3 = 0x169518d7d80b7817ee834a6e19eaeeb518d37a56c843edc34f1b5b82b4871494::math::mul_div_u128((arg2 as u128), (v0 as u128), (v2 as u128));
        let v4 = 0x169518d7d80b7817ee834a6e19eaeeb518d37a56c843edc34f1b5b82b4871494::math::mul_div_u128((arg2 as u128), (v1 as u128), (v2 as u128));
        assert!(v3 > 0 && v4 > 0, 200);
        (v3, v4)
    }

    public fun get_reserves_size<T0, T1>(arg0: &mut 0xd842eddc81c64fb889aa1676068176f41b577b20c2d143c7b718f2ad1ebd56b2::swap::RyuSwap) : (u64, u64) {
        if (0x169518d7d80b7817ee834a6e19eaeeb518d37a56c843edc34f1b5b82b4871494::coin_helper::is_sorted<T0, T1>()) {
            0xd842eddc81c64fb889aa1676068176f41b577b20c2d143c7b718f2ad1ebd56b2::swap::get_reserves_size<T0, T1>(arg0)
        } else {
            let (v2, v3) = 0xd842eddc81c64fb889aa1676068176f41b577b20c2d143c7b718f2ad1ebd56b2::swap::get_reserves_size<T1, T0>(arg0);
            (v3, v2)
        }
    }

    fun handle_coin_obj<T0>(arg0: vector<0x2::coin::Coin<T0>>, arg1: u64, arg2: &mut 0x2::tx_context::TxContext) : 0x2::coin::Coin<T0> {
        assert!(0x1::vector::length<0x2::coin::Coin<T0>>(&arg0) > 0, 3);
        assert!(arg1 > 0, 4);
        let v0 = 0x2::coin::zero<T0>(arg2);
        let v1 = 0;
        while (0x1::vector::length<0x2::coin::Coin<T0>>(&arg0) > 0) {
            let v2 = 0x1::vector::pop_back<0x2::coin::Coin<T0>>(&mut arg0);
            if (v1 < arg1) {
                let v3 = 0x2::coin::value<T0>(&v2);
                if (v3 + v1 <= arg1) {
                    0x2::coin::join<T0>(&mut v0, v2);
                    v1 = v3 + v1;
                    continue
                };
                let v4 = arg1 - v1;
                0x2::coin::join<T0>(&mut v0, 0x2::coin::split<T0>(&mut v2, v4, arg2));
                v1 = v1 + v4;
                0x2::transfer::public_transfer<0x2::coin::Coin<T0>>(v2, 0x2::tx_context::sender(arg2));
                continue
            };
            0x2::transfer::public_transfer<0x2::coin::Coin<T0>>(v2, 0x2::tx_context::sender(arg2));
        };
        0x1::vector::destroy_empty<0x2::coin::Coin<T0>>(arg0);
        assert!(0x2::coin::value<T0>(&v0) == arg1, 2);
        v0
    }

    fun handle_lpcoin_obj<T0, T1>(arg0: vector<0x2::coin::Coin<0xd842eddc81c64fb889aa1676068176f41b577b20c2d143c7b718f2ad1ebd56b2::swap::LPCoin<T0, T1>>>, arg1: u64, arg2: &mut 0x2::tx_context::TxContext) : 0x2::coin::Coin<0xd842eddc81c64fb889aa1676068176f41b577b20c2d143c7b718f2ad1ebd56b2::swap::LPCoin<T0, T1>> {
        assert!(0x1::vector::length<0x2::coin::Coin<0xd842eddc81c64fb889aa1676068176f41b577b20c2d143c7b718f2ad1ebd56b2::swap::LPCoin<T0, T1>>>(&arg0) > 0, 3);
        assert!(arg1 > 0, 4);
        let v0 = 0x2::coin::zero<0xd842eddc81c64fb889aa1676068176f41b577b20c2d143c7b718f2ad1ebd56b2::swap::LPCoin<T0, T1>>(arg2);
        let v1 = 0;
        while (0x1::vector::length<0x2::coin::Coin<0xd842eddc81c64fb889aa1676068176f41b577b20c2d143c7b718f2ad1ebd56b2::swap::LPCoin<T0, T1>>>(&arg0) > 0) {
            let v2 = 0x1::vector::pop_back<0x2::coin::Coin<0xd842eddc81c64fb889aa1676068176f41b577b20c2d143c7b718f2ad1ebd56b2::swap::LPCoin<T0, T1>>>(&mut arg0);
            if (v1 < arg1) {
                let v3 = 0x2::coin::value<0xd842eddc81c64fb889aa1676068176f41b577b20c2d143c7b718f2ad1ebd56b2::swap::LPCoin<T0, T1>>(&v2);
                if (v3 + v1 <= arg1) {
                    0x2::coin::join<0xd842eddc81c64fb889aa1676068176f41b577b20c2d143c7b718f2ad1ebd56b2::swap::LPCoin<T0, T1>>(&mut v0, v2);
                    v1 = v3 + v1;
                    continue
                };
                let v4 = arg1 - v1;
                0x2::coin::join<0xd842eddc81c64fb889aa1676068176f41b577b20c2d143c7b718f2ad1ebd56b2::swap::LPCoin<T0, T1>>(&mut v0, 0x2::coin::split<0xd842eddc81c64fb889aa1676068176f41b577b20c2d143c7b718f2ad1ebd56b2::swap::LPCoin<T0, T1>>(&mut v2, v4, arg2));
                v1 = v1 + v4;
                0x2::transfer::public_transfer<0x2::coin::Coin<0xd842eddc81c64fb889aa1676068176f41b577b20c2d143c7b718f2ad1ebd56b2::swap::LPCoin<T0, T1>>>(v2, 0x2::tx_context::sender(arg2));
                continue
            };
            0x2::transfer::public_transfer<0x2::coin::Coin<0xd842eddc81c64fb889aa1676068176f41b577b20c2d143c7b718f2ad1ebd56b2::swap::LPCoin<T0, T1>>>(v2, 0x2::tx_context::sender(arg2));
        };
        0x1::vector::destroy_empty<0x2::coin::Coin<0xd842eddc81c64fb889aa1676068176f41b577b20c2d143c7b718f2ad1ebd56b2::swap::LPCoin<T0, T1>>>(arg0);
        assert!(0x2::coin::value<0xd842eddc81c64fb889aa1676068176f41b577b20c2d143c7b718f2ad1ebd56b2::swap::LPCoin<T0, T1>>(&v0) == arg1, 2);
        v0
    }

    public fun is_swap_exists<T0, T1>(arg0: &mut 0xd842eddc81c64fb889aa1676068176f41b577b20c2d143c7b718f2ad1ebd56b2::swap::RyuSwap) : bool {
        0x169518d7d80b7817ee834a6e19eaeeb518d37a56c843edc34f1b5b82b4871494::coin_helper::is_sorted<T0, T1>() && 0xd842eddc81c64fb889aa1676068176f41b577b20c2d143c7b718f2ad1ebd56b2::swap::is_pool_exists<T0, T1>(arg0) || 0xd842eddc81c64fb889aa1676068176f41b577b20c2d143c7b718f2ad1ebd56b2::swap::is_pool_exists<T1, T0>(arg0)
    }

    public entry fun register_lp<T0, T1>(arg0: vector<0x2::coin::Coin<T0>>, arg1: u64, arg2: vector<0x2::coin::Coin<T1>>, arg3: u64, arg4: &0x2::clock::Clock, arg5: &mut 0xd842eddc81c64fb889aa1676068176f41b577b20c2d143c7b718f2ad1ebd56b2::swap::RyuSwap, arg6: &mut 0xd842eddc81c64fb889aa1676068176f41b577b20c2d143c7b718f2ad1ebd56b2::dao_fee::DaoFeeInfo, arg7: &mut 0x2::tx_context::TxContext) {
        assert!(0x169518d7d80b7817ee834a6e19eaeeb518d37a56c843edc34f1b5b82b4871494::coin_helper::is_sorted<T0, T1>(), 208);
        let v0 = handle_coin_obj<T0>(arg0, arg1, arg7);
        let v1 = handle_coin_obj<T1>(arg2, arg3, arg7);
        0x2::transfer::public_transfer<0x2::coin::Coin<0xd842eddc81c64fb889aa1676068176f41b577b20c2d143c7b718f2ad1ebd56b2::swap::LPCoin<T0, T1>>>(0xd842eddc81c64fb889aa1676068176f41b577b20c2d143c7b718f2ad1ebd56b2::swap::register<T0, T1>(v0, v1, arg4, arg5, arg6, arg7), 0x2::tx_context::sender(arg7));
    }

    public entry fun remove_lp<T0, T1>(arg0: vector<0x2::coin::Coin<0xd842eddc81c64fb889aa1676068176f41b577b20c2d143c7b718f2ad1ebd56b2::swap::LPCoin<T0, T1>>>, arg1: u64, arg2: u64, arg3: u64, arg4: &mut 0xd842eddc81c64fb889aa1676068176f41b577b20c2d143c7b718f2ad1ebd56b2::swap::RyuSwap, arg5: &0x2::clock::Clock, arg6: &mut 0x2::tx_context::TxContext) {
        assert!(0x169518d7d80b7817ee834a6e19eaeeb518d37a56c843edc34f1b5b82b4871494::coin_helper::is_sorted<T0, T1>(), 208);
        let v0 = handle_lpcoin_obj<T0, T1>(arg0, arg1, arg6);
        let (v1, v2) = 0xd842eddc81c64fb889aa1676068176f41b577b20c2d143c7b718f2ad1ebd56b2::swap::burn<T0, T1>(arg4, arg5, v0, arg6);
        let v3 = v2;
        let v4 = v1;
        assert!(0x2::coin::value<T0>(&v4) >= arg2, 205);
        assert!(0x2::coin::value<T1>(&v3) >= arg3, 205);
        let v5 = 0x2::tx_context::sender(arg6);
        0x2::transfer::public_transfer<0x2::coin::Coin<T0>>(v4, v5);
        0x2::transfer::public_transfer<0x2::coin::Coin<T1>>(v3, v5);
    }

    fun swap_coin_for_coin_unchecked<T0, T1>(arg0: &mut 0xd842eddc81c64fb889aa1676068176f41b577b20c2d143c7b718f2ad1ebd56b2::swap::RyuSwap, arg1: &mut 0xd842eddc81c64fb889aa1676068176f41b577b20c2d143c7b718f2ad1ebd56b2::dao_fee::DaoFeeInfo, arg2: &0x2::clock::Clock, arg3: 0x2::coin::Coin<T0>, arg4: u64, arg5: &mut 0x2::tx_context::TxContext) : 0x2::coin::Coin<T1> {
        let (v0, v1) = if (0x169518d7d80b7817ee834a6e19eaeeb518d37a56c843edc34f1b5b82b4871494::coin_helper::is_sorted<T0, T1>()) {
            let (v2, v3) = 0xd842eddc81c64fb889aa1676068176f41b577b20c2d143c7b718f2ad1ebd56b2::swap::swap<T0, T1>(arg0, arg1, arg2, arg3, 0, 0x2::coin::zero<T1>(arg5), arg4, arg5);
            (v3, v2)
        } else {
            0xd842eddc81c64fb889aa1676068176f41b577b20c2d143c7b718f2ad1ebd56b2::swap::swap<T1, T0>(arg0, arg1, arg2, 0x2::coin::zero<T1>(arg5), arg4, arg3, 0, arg5)
        };
        0x2::coin::destroy_zero<T0>(v1);
        v0
    }

    public entry fun swap_coin_for_exact_coin<T0, T1>(arg0: vector<0x2::coin::Coin<T0>>, arg1: u64, arg2: u64, arg3: &mut 0xd842eddc81c64fb889aa1676068176f41b577b20c2d143c7b718f2ad1ebd56b2::swap::RyuSwap, arg4: &mut 0xd842eddc81c64fb889aa1676068176f41b577b20c2d143c7b718f2ad1ebd56b2::dao_fee::DaoFeeInfo, arg5: &0x2::clock::Clock, arg6: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = get_reserves_size<T0, T1>(arg3);
        let (v2, v3) = get_fees_config<T0, T1>(arg3);
        let v4 = get_amount_in<T0, T1>(v0, v1, v2, v3, arg2);
        let v5 = handle_coin_obj<T0>(arg0, arg1, arg6);
        let v6 = 0x2::tx_context::sender(arg6);
        let v7 = 0x2::coin::value<T0>(&v5);
        assert!(v4 <= v7, 206);
        let v8 = if (v4 < v7) {
            let v9 = 0x2::coin::split<T0>(&mut v5, v4, arg6);
            0x2::transfer::public_transfer<0x2::coin::Coin<T0>>(v5, v6);
            swap_coin_for_coin_unchecked<T0, T1>(arg3, arg4, arg5, v9, arg2, arg6)
        } else {
            swap_coin_for_coin_unchecked<T0, T1>(arg3, arg4, arg5, v5, arg2, arg6)
        };
        0x2::transfer::public_transfer<0x2::coin::Coin<T1>>(v8, v6);
    }

    public entry fun swap_exact_coin_for_coin<T0, T1>(arg0: vector<0x2::coin::Coin<T0>>, arg1: u64, arg2: u64, arg3: &mut 0xd842eddc81c64fb889aa1676068176f41b577b20c2d143c7b718f2ad1ebd56b2::swap::RyuSwap, arg4: &mut 0xd842eddc81c64fb889aa1676068176f41b577b20c2d143c7b718f2ad1ebd56b2::dao_fee::DaoFeeInfo, arg5: &0x2::clock::Clock, arg6: &mut 0x2::tx_context::TxContext) {
        let v0 = handle_coin_obj<T0>(arg0, arg1, arg6);
        let (v1, v2) = get_reserves_size<T0, T1>(arg3);
        let (v3, v4) = get_fees_config<T0, T1>(arg3);
        let v5 = 0x2::tx_context::sender(arg6);
        let v6 = get_amount_out<T0, T1>(v1, v2, v3, v4, 0x2::coin::value<T0>(&v0));
        assert!(v6 >= arg2, 205);
        0x2::transfer::public_transfer<0x2::coin::Coin<T1>>(swap_coin_for_coin_unchecked<T0, T1>(arg3, arg4, arg5, v0, v6, arg6), v5);
    }

    // decompiled from Move bytecode v6
}

