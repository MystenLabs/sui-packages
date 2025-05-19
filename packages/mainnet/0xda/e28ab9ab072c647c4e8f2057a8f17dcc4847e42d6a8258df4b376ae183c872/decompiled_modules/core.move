module 0xdae28ab9ab072c647c4e8f2057a8f17dcc4847e42d6a8258df4b376ae183c872::core {
    public(friend) fun add_liquidity<T0, T1>(arg0: &mut 0xdae28ab9ab072c647c4e8f2057a8f17dcc4847e42d6a8258df4b376ae183c872::manage::Pool<T0, T1>, arg1: 0x2::coin::Coin<T0>, arg2: u64, arg3: 0x2::coin::Coin<T1>, arg4: u64, arg5: &mut 0x2::tx_context::TxContext) : (0x2::coin::Coin<0xdae28ab9ab072c647c4e8f2057a8f17dcc4847e42d6a8258df4b376ae183c872::manage::LP<T0, T1>>, vector<u64>) {
        let v0 = 0x2::coin::value<T0>(&arg1);
        let v1 = 0x2::coin::value<T1>(&arg3);
        assert!(v0 > 0 && v1 > 0, 0);
        let v2 = 0x2::coin::into_balance<T0>(arg1);
        let v3 = 0x2::coin::into_balance<T1>(arg3);
        let (v4, v5, v6) = 0xdae28ab9ab072c647c4e8f2057a8f17dcc4847e42d6a8258df4b376ae183c872::manage::get_balance<T0, T1>(arg0);
        let (v7, v8) = 0xdae28ab9ab072c647c4e8f2057a8f17dcc4847e42d6a8258df4b376ae183c872::math::calc_optimal_coin_values(v0, v1, arg2, arg4, v4, v5);
        let v9 = if (v6 == 0) {
            let v10 = 0xdae28ab9ab072c647c4e8f2057a8f17dcc4847e42d6a8258df4b376ae183c872::math::sqrt(0xdae28ab9ab072c647c4e8f2057a8f17dcc4847e42d6a8258df4b376ae183c872::math::mul_to_u128(v7, v8));
            let v11 = 1000;
            assert!(v10 > v11, 3);
            0x2::balance::join<0xdae28ab9ab072c647c4e8f2057a8f17dcc4847e42d6a8258df4b376ae183c872::manage::LP<T0, T1>>(0xdae28ab9ab072c647c4e8f2057a8f17dcc4847e42d6a8258df4b376ae183c872::manage::get_mut_min_liquidity<T0, T1>(arg0), 0x2::balance::increase_supply<0xdae28ab9ab072c647c4e8f2057a8f17dcc4847e42d6a8258df4b376ae183c872::manage::LP<T0, T1>>(0xdae28ab9ab072c647c4e8f2057a8f17dcc4847e42d6a8258df4b376ae183c872::manage::get_mut_lp_supply<T0, T1>(arg0), v11));
            v10 - v11
        } else {
            let v12 = (v6 as u128) * (v7 as u128) / (v4 as u128);
            let v13 = (v6 as u128) * (v8 as u128) / (v5 as u128);
            if (v12 < v13) {
                assert!(v12 < (18446744073709551615 as u128), 4);
                (v12 as u64)
            } else {
                assert!(v13 < (18446744073709551615 as u128), 4);
                (v13 as u64)
            }
        };
        assert!(v9 > 0, 5);
        assert!(v9 >= 0xdae28ab9ab072c647c4e8f2057a8f17dcc4847e42d6a8258df4b376ae183c872::manage::get_min_add_liquidity_lp_amount<T0, T1>(arg0), 6);
        if (v7 < v0) {
            0x2::transfer::public_transfer<0x2::coin::Coin<T0>>(0x2::coin::from_balance<T0>(0x2::balance::split<T0>(&mut v2, v0 - v7), arg5), 0x2::tx_context::sender(arg5));
        };
        if (v8 < v1) {
            0x2::transfer::public_transfer<0x2::coin::Coin<T1>>(0x2::coin::from_balance<T1>(0x2::balance::split<T1>(&mut v3, v1 - v8), arg5), 0x2::tx_context::sender(arg5));
        };
        0x2::balance::join<T0>(0xdae28ab9ab072c647c4e8f2057a8f17dcc4847e42d6a8258df4b376ae183c872::manage::get_mut_bal_x<T0, T1>(arg0), v2);
        0x2::balance::join<T1>(0xdae28ab9ab072c647c4e8f2057a8f17dcc4847e42d6a8258df4b376ae183c872::manage::get_mut_bal_y<T0, T1>(arg0), v3);
        let v14 = 0x1::vector::empty<u64>();
        0x1::vector::push_back<u64>(&mut v14, v7);
        0x1::vector::push_back<u64>(&mut v14, v8);
        0x1::vector::push_back<u64>(&mut v14, v9);
        (0x2::coin::from_balance<0xdae28ab9ab072c647c4e8f2057a8f17dcc4847e42d6a8258df4b376ae183c872::manage::LP<T0, T1>>(0x2::balance::increase_supply<0xdae28ab9ab072c647c4e8f2057a8f17dcc4847e42d6a8258df4b376ae183c872::manage::LP<T0, T1>>(0xdae28ab9ab072c647c4e8f2057a8f17dcc4847e42d6a8258df4b376ae183c872::manage::get_mut_lp_supply<T0, T1>(arg0), v9), arg5), v14)
    }

    public(friend) fun remove_liquidity<T0, T1>(arg0: &mut 0xdae28ab9ab072c647c4e8f2057a8f17dcc4847e42d6a8258df4b376ae183c872::manage::Pool<T0, T1>, arg1: 0x2::coin::Coin<0xdae28ab9ab072c647c4e8f2057a8f17dcc4847e42d6a8258df4b376ae183c872::manage::LP<T0, T1>>, arg2: u64, arg3: u64, arg4: u64, arg5: &mut 0x2::tx_context::TxContext) : (0x2::coin::Coin<T0>, 0x2::coin::Coin<T1>, u64) {
        let v0 = 0x2::coin::value<0xdae28ab9ab072c647c4e8f2057a8f17dcc4847e42d6a8258df4b376ae183c872::manage::LP<T0, T1>>(&arg1);
        assert!(v0 > 0, 0);
        let v1 = 0xdae28ab9ab072c647c4e8f2057a8f17dcc4847e42d6a8258df4b376ae183c872::manage::get_min_remove_liquidity_lp_amount<T0, T1>(arg0);
        assert!(arg2 >= v1 && arg2 <= v0, 7);
        let (v2, v3, v4) = 0xdae28ab9ab072c647c4e8f2057a8f17dcc4847e42d6a8258df4b376ae183c872::manage::get_balance<T0, T1>(arg0);
        let v5 = v0 - arg2;
        if (v5 > 0 && v5 < v1) {
            arg2 = v0;
        };
        let v6 = 0xdae28ab9ab072c647c4e8f2057a8f17dcc4847e42d6a8258df4b376ae183c872::math::mul_div(v2, arg2, v4);
        let v7 = 0xdae28ab9ab072c647c4e8f2057a8f17dcc4847e42d6a8258df4b376ae183c872::math::mul_div(v3, arg2, v4);
        assert!(v6 >= arg3 && v7 >= arg4, 2);
        if (arg2 < v0) {
            0x2::transfer::public_transfer<0x2::coin::Coin<0xdae28ab9ab072c647c4e8f2057a8f17dcc4847e42d6a8258df4b376ae183c872::manage::LP<T0, T1>>>(0x2::coin::split<0xdae28ab9ab072c647c4e8f2057a8f17dcc4847e42d6a8258df4b376ae183c872::manage::LP<T0, T1>>(&mut arg1, v0 - arg2, arg5), 0x2::tx_context::sender(arg5));
        };
        0x2::balance::decrease_supply<0xdae28ab9ab072c647c4e8f2057a8f17dcc4847e42d6a8258df4b376ae183c872::manage::LP<T0, T1>>(0xdae28ab9ab072c647c4e8f2057a8f17dcc4847e42d6a8258df4b376ae183c872::manage::get_mut_lp_supply<T0, T1>(arg0), 0x2::coin::into_balance<0xdae28ab9ab072c647c4e8f2057a8f17dcc4847e42d6a8258df4b376ae183c872::manage::LP<T0, T1>>(arg1));
        (0x2::coin::take<T0>(0xdae28ab9ab072c647c4e8f2057a8f17dcc4847e42d6a8258df4b376ae183c872::manage::get_mut_bal_x<T0, T1>(arg0), v6, arg5), 0x2::coin::take<T1>(0xdae28ab9ab072c647c4e8f2057a8f17dcc4847e42d6a8258df4b376ae183c872::manage::get_mut_bal_y<T0, T1>(arg0), v7, arg5), arg2)
    }

    public(friend) fun swap_exact_x_to_y<T0, T1>(arg0: &0xdae28ab9ab072c647c4e8f2057a8f17dcc4847e42d6a8258df4b376ae183c872::manage::Global, arg1: &mut 0xdae28ab9ab072c647c4e8f2057a8f17dcc4847e42d6a8258df4b376ae183c872::manage::Pool<T0, T1>, arg2: 0x2::coin::Coin<T0>, arg3: u64, arg4: &mut 0x2::tx_context::TxContext) : (u64, u64, u64, u64, 0x2::coin::Coin<T1>) {
        let v0 = 0x2::coin::value<T0>(&arg2);
        assert!(v0 > 0, 0);
        let (v1, v2, _) = 0xdae28ab9ab072c647c4e8f2057a8f17dcc4847e42d6a8258df4b376ae183c872::manage::get_balance<T0, T1>(arg1);
        assert!(v1 > 0 && v2 > 0, 1);
        let v4 = 0xdae28ab9ab072c647c4e8f2057a8f17dcc4847e42d6a8258df4b376ae183c872::manage::get_fee_rate<T0, T1>(arg1);
        let v5 = 0xdae28ab9ab072c647c4e8f2057a8f17dcc4847e42d6a8258df4b376ae183c872::math::get_amount_out(v4, v0, v1, v2);
        assert!(v5 >= arg3, 2);
        let v6 = 0x2::coin::into_balance<T0>(arg2);
        let v7 = 0;
        if (0xdae28ab9ab072c647c4e8f2057a8f17dcc4847e42d6a8258df4b376ae183c872::manage::get_is_open_protocol_fee(arg0)) {
            let v8 = 0xdae28ab9ab072c647c4e8f2057a8f17dcc4847e42d6a8258df4b376ae183c872::math::get_fee_to_team(v4, v0);
            v7 = v8;
            if (v8 > 0) {
                0x2::balance::join<T0>(0xdae28ab9ab072c647c4e8f2057a8f17dcc4847e42d6a8258df4b376ae183c872::manage::get_mut_fee_bal_x<T0, T1>(arg1), 0x2::balance::split<T0>(&mut v6, v8));
            };
        };
        0x2::balance::join<T0>(0xdae28ab9ab072c647c4e8f2057a8f17dcc4847e42d6a8258df4b376ae183c872::manage::get_mut_bal_x<T0, T1>(arg1), v6);
        let (v9, v10, _) = 0xdae28ab9ab072c647c4e8f2057a8f17dcc4847e42d6a8258df4b376ae183c872::manage::get_balance<T0, T1>(arg1);
        0xdae28ab9ab072c647c4e8f2057a8f17dcc4847e42d6a8258df4b376ae183c872::math::assert_lp_value_is_increased(v1, v2, v9, v10);
        (v0, v5, v7, 0, 0x2::coin::take<T1>(0xdae28ab9ab072c647c4e8f2057a8f17dcc4847e42d6a8258df4b376ae183c872::manage::get_mut_bal_y<T0, T1>(arg1), v5, arg4))
    }

    public(friend) fun swap_exact_y_to_x<T0, T1>(arg0: &0xdae28ab9ab072c647c4e8f2057a8f17dcc4847e42d6a8258df4b376ae183c872::manage::Global, arg1: &mut 0xdae28ab9ab072c647c4e8f2057a8f17dcc4847e42d6a8258df4b376ae183c872::manage::Pool<T0, T1>, arg2: 0x2::coin::Coin<T1>, arg3: u64, arg4: &mut 0x2::tx_context::TxContext) : (u64, u64, u64, u64, 0x2::coin::Coin<T0>) {
        let v0 = 0x2::coin::value<T1>(&arg2);
        assert!(v0 > 0, 0);
        let (v1, v2, _) = 0xdae28ab9ab072c647c4e8f2057a8f17dcc4847e42d6a8258df4b376ae183c872::manage::get_balance<T0, T1>(arg1);
        assert!(v1 > 0 && v2 > 0, 1);
        let v4 = 0xdae28ab9ab072c647c4e8f2057a8f17dcc4847e42d6a8258df4b376ae183c872::manage::get_fee_rate<T0, T1>(arg1);
        let v5 = 0xdae28ab9ab072c647c4e8f2057a8f17dcc4847e42d6a8258df4b376ae183c872::math::get_amount_out(v4, v0, v2, v1);
        assert!(v5 >= arg3, 2);
        let v6 = 0x2::coin::into_balance<T1>(arg2);
        let v7 = 0;
        if (0xdae28ab9ab072c647c4e8f2057a8f17dcc4847e42d6a8258df4b376ae183c872::manage::get_is_open_protocol_fee(arg0)) {
            let v8 = 0xdae28ab9ab072c647c4e8f2057a8f17dcc4847e42d6a8258df4b376ae183c872::math::get_fee_to_team(v4, v0);
            v7 = v8;
            if (v8 > 0) {
                0x2::balance::join<T1>(0xdae28ab9ab072c647c4e8f2057a8f17dcc4847e42d6a8258df4b376ae183c872::manage::get_mut_fee_bal_y<T0, T1>(arg1), 0x2::balance::split<T1>(&mut v6, v8));
            };
        };
        0x2::balance::join<T1>(0xdae28ab9ab072c647c4e8f2057a8f17dcc4847e42d6a8258df4b376ae183c872::manage::get_mut_bal_y<T0, T1>(arg1), v6);
        let (v9, v10, _) = 0xdae28ab9ab072c647c4e8f2057a8f17dcc4847e42d6a8258df4b376ae183c872::manage::get_balance<T0, T1>(arg1);
        0xdae28ab9ab072c647c4e8f2057a8f17dcc4847e42d6a8258df4b376ae183c872::math::assert_lp_value_is_increased(v1, v2, v9, v10);
        (v0, v5, 0, v7, 0x2::coin::take<T0>(0xdae28ab9ab072c647c4e8f2057a8f17dcc4847e42d6a8258df4b376ae183c872::manage::get_mut_bal_x<T0, T1>(arg1), v5, arg4))
    }

    public(friend) fun swap_x_to_exact_y<T0, T1>(arg0: &0xdae28ab9ab072c647c4e8f2057a8f17dcc4847e42d6a8258df4b376ae183c872::manage::Global, arg1: &mut 0xdae28ab9ab072c647c4e8f2057a8f17dcc4847e42d6a8258df4b376ae183c872::manage::Pool<T0, T1>, arg2: 0x2::coin::Coin<T0>, arg3: u64, arg4: &mut 0x2::tx_context::TxContext) : (u64, u64, u64, u64, 0x2::coin::Coin<T1>, 0x2::coin::Coin<T0>) {
        let v0 = 0x2::coin::value<T0>(&arg2);
        assert!(v0 > 0, 0);
        let (v1, v2, _) = 0xdae28ab9ab072c647c4e8f2057a8f17dcc4847e42d6a8258df4b376ae183c872::manage::get_balance<T0, T1>(arg1);
        assert!(v1 > 0 && v2 > 0, 1);
        let v4 = 0xdae28ab9ab072c647c4e8f2057a8f17dcc4847e42d6a8258df4b376ae183c872::manage::get_fee_rate<T0, T1>(arg1);
        let v5 = 0xdae28ab9ab072c647c4e8f2057a8f17dcc4847e42d6a8258df4b376ae183c872::math::get_amount_in(v4, arg3, v1, v2);
        assert!(v5 <= v0, 2);
        let v6 = 0x2::coin::into_balance<T0>(arg2);
        let v7 = if (v5 < v0) {
            0x2::coin::take<T0>(&mut v6, v0 - v5, arg4)
        } else {
            0x2::coin::zero<T0>(arg4)
        };
        let v8 = 0;
        if (0xdae28ab9ab072c647c4e8f2057a8f17dcc4847e42d6a8258df4b376ae183c872::manage::get_is_open_protocol_fee(arg0)) {
            let v9 = 0xdae28ab9ab072c647c4e8f2057a8f17dcc4847e42d6a8258df4b376ae183c872::math::get_fee_to_team(v4, v5);
            v8 = v9;
            if (v9 > 0) {
                0x2::balance::join<T0>(0xdae28ab9ab072c647c4e8f2057a8f17dcc4847e42d6a8258df4b376ae183c872::manage::get_mut_fee_bal_x<T0, T1>(arg1), 0x2::balance::split<T0>(&mut v6, v9));
            };
        };
        0x2::balance::join<T0>(0xdae28ab9ab072c647c4e8f2057a8f17dcc4847e42d6a8258df4b376ae183c872::manage::get_mut_bal_x<T0, T1>(arg1), v6);
        let (v10, v11, _) = 0xdae28ab9ab072c647c4e8f2057a8f17dcc4847e42d6a8258df4b376ae183c872::manage::get_balance<T0, T1>(arg1);
        0xdae28ab9ab072c647c4e8f2057a8f17dcc4847e42d6a8258df4b376ae183c872::math::assert_lp_value_is_increased(v1, v2, v10, v11);
        (v5, arg3, v8, 0, 0x2::coin::take<T1>(0xdae28ab9ab072c647c4e8f2057a8f17dcc4847e42d6a8258df4b376ae183c872::manage::get_mut_bal_y<T0, T1>(arg1), arg3, arg4), v7)
    }

    public(friend) fun swap_y_to_exact_x<T0, T1>(arg0: &0xdae28ab9ab072c647c4e8f2057a8f17dcc4847e42d6a8258df4b376ae183c872::manage::Global, arg1: &mut 0xdae28ab9ab072c647c4e8f2057a8f17dcc4847e42d6a8258df4b376ae183c872::manage::Pool<T0, T1>, arg2: 0x2::coin::Coin<T1>, arg3: u64, arg4: &mut 0x2::tx_context::TxContext) : (u64, u64, u64, u64, 0x2::coin::Coin<T0>, 0x2::coin::Coin<T1>) {
        let v0 = 0x2::coin::value<T1>(&arg2);
        assert!(v0 > 0, 0);
        let (v1, v2, _) = 0xdae28ab9ab072c647c4e8f2057a8f17dcc4847e42d6a8258df4b376ae183c872::manage::get_balance<T0, T1>(arg1);
        assert!(v1 > 0 && v2 > 0, 1);
        let v4 = 0xdae28ab9ab072c647c4e8f2057a8f17dcc4847e42d6a8258df4b376ae183c872::manage::get_fee_rate<T0, T1>(arg1);
        let v5 = 0xdae28ab9ab072c647c4e8f2057a8f17dcc4847e42d6a8258df4b376ae183c872::math::get_amount_in(v4, arg3, v2, v1);
        assert!(v5 <= v0, 2);
        let v6 = 0x2::coin::into_balance<T1>(arg2);
        let v7 = if (v5 < v0) {
            0x2::coin::take<T1>(&mut v6, v0 - v5, arg4)
        } else {
            0x2::coin::zero<T1>(arg4)
        };
        let v8 = 0;
        if (0xdae28ab9ab072c647c4e8f2057a8f17dcc4847e42d6a8258df4b376ae183c872::manage::get_is_open_protocol_fee(arg0)) {
            let v9 = 0xdae28ab9ab072c647c4e8f2057a8f17dcc4847e42d6a8258df4b376ae183c872::math::get_fee_to_team(v4, v5);
            v8 = v9;
            if (v9 > 0) {
                0x2::balance::join<T1>(0xdae28ab9ab072c647c4e8f2057a8f17dcc4847e42d6a8258df4b376ae183c872::manage::get_mut_fee_bal_y<T0, T1>(arg1), 0x2::balance::split<T1>(&mut v6, v9));
            };
        };
        0x2::balance::join<T1>(0xdae28ab9ab072c647c4e8f2057a8f17dcc4847e42d6a8258df4b376ae183c872::manage::get_mut_bal_y<T0, T1>(arg1), v6);
        let (v10, v11, _) = 0xdae28ab9ab072c647c4e8f2057a8f17dcc4847e42d6a8258df4b376ae183c872::manage::get_balance<T0, T1>(arg1);
        0xdae28ab9ab072c647c4e8f2057a8f17dcc4847e42d6a8258df4b376ae183c872::math::assert_lp_value_is_increased(v1, v2, v10, v11);
        (v5, arg3, 0, v8, 0x2::coin::take<T0>(0xdae28ab9ab072c647c4e8f2057a8f17dcc4847e42d6a8258df4b376ae183c872::manage::get_mut_bal_x<T0, T1>(arg1), arg3, arg4), v7)
    }

    // decompiled from Move bytecode v6
}

