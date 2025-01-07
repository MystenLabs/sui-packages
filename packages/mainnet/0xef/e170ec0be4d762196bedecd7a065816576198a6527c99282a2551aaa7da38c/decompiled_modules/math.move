module 0xefe170ec0be4d762196bedecd7a065816576198a6527c99282a2551aaa7da38c::math {
    public fun calc_all_coin_deposit<T0>(arg0: &0xefe170ec0be4d762196bedecd7a065816576198a6527c99282a2551aaa7da38c::pool::Pool<T0>, arg1: &vector<0x1::ascii::String>, arg2: &vector<u64>) : (u64, vector<u64>) {
        let v0 = reorder_and_zero_out_empty_coins<T0>(arg0, arg1, arg2);
        let v1 = 0xefe170ec0be4d762196bedecd7a065816576198a6527c99282a2551aaa7da38c::pool::normalize_amounts<T0>(arg0, &v0);
        let v2 = if (0xefe170ec0be4d762196bedecd7a065816576198a6527c99282a2551aaa7da38c::pool::flatness<T0>(arg0) == 0) {
            let v3 = 0xefe170ec0be4d762196bedecd7a065816576198a6527c99282a2551aaa7da38c::pool::normalized_balances<T0>(arg0);
            0x712579292f80c11a0c9de4ff553d6e5c4757105e83a8a3129823d2b39e65d062::geometric_mean_calculations::calc_all_coin_deposit(&v3, &v1)
        } else {
            let v4 = 0xefe170ec0be4d762196bedecd7a065816576198a6527c99282a2551aaa7da38c::pool::normalized_balances<T0>(arg0);
            0x712579292f80c11a0c9de4ff553d6e5c4757105e83a8a3129823d2b39e65d062::stable_calculations::calc_all_coin_deposit(&v4, &v1)
        };
        let v5 = 0x73baa782c55003b3a359dec04b189312565d18e7309d4a51f5f112f891e3b2ab::fixed::mul_by_fraction(0xefe170ec0be4d762196bedecd7a065816576198a6527c99282a2551aaa7da38c::pool::lp_supply_value<T0>(arg0), v2);
        assert!(v5 > 0, 56);
        let v6 = 0xefe170ec0be4d762196bedecd7a065816576198a6527c99282a2551aaa7da38c::pool::normalized_balances<T0>(arg0);
        0x73baa782c55003b3a359dec04b189312565d18e7309d4a51f5f112f891e3b2ab::vector::scale_mut_vector_128_64(&mut v6, v2);
        let v7 = 0;
        while (v7 < 0x1::vector::length<u128>(&v6)) {
            assert!(0xefe170ec0be4d762196bedecd7a065816576198a6527c99282a2551aaa7da38c::pool::unnormalize_amount_with_index<T0>(arg0, v7, *0x1::vector::borrow<u128>(&v6, v7)) > 0, 54);
            v7 = v7 + 1;
        };
        let v8 = 0xefe170ec0be4d762196bedecd7a065816576198a6527c99282a2551aaa7da38c::pool::unnormalize_amounts<T0>(arg0, &v6);
        (v5, reorder_by_order_of_calling_function<T0>(arg0, arg1, &v8))
    }

    public fun calc_invariant<T0>(arg0: &0xefe170ec0be4d762196bedecd7a065816576198a6527c99282a2551aaa7da38c::pool::Pool<T0>, arg1: &vector<u128>) : u128 {
        let v0 = if (0xefe170ec0be4d762196bedecd7a065816576198a6527c99282a2551aaa7da38c::pool::flatness<T0>(arg0) == 0) {
            let v1 = 0xefe170ec0be4d762196bedecd7a065816576198a6527c99282a2551aaa7da38c::pool::weights<T0>(arg0);
            0x712579292f80c11a0c9de4ff553d6e5c4757105e83a8a3129823d2b39e65d062::geometric_mean_calculations::calc_invariant(arg1, &v1)
        } else {
            let v2 = 0xefe170ec0be4d762196bedecd7a065816576198a6527c99282a2551aaa7da38c::pool::weights<T0>(arg0);
            0x712579292f80c11a0c9de4ff553d6e5c4757105e83a8a3129823d2b39e65d062::stable_calculations::calc_invariant(arg1, &v2, 0xefe170ec0be4d762196bedecd7a065816576198a6527c99282a2551aaa7da38c::pool::flatness<T0>(arg0))
        };
        assert!(v0 > 0, 51);
        v0
    }

    public fun calc_spot_price<T0, T1, T2>(arg0: &0xefe170ec0be4d762196bedecd7a065816576198a6527c99282a2551aaa7da38c::pool::Pool<T0>) : u128 {
        if (0xefe170ec0be4d762196bedecd7a065816576198a6527c99282a2551aaa7da38c::pool::flatness<T0>(arg0) == 0) {
            0x712579292f80c11a0c9de4ff553d6e5c4757105e83a8a3129823d2b39e65d062::geometric_mean_calculations::calc_spot_price_with_fees(0xefe170ec0be4d762196bedecd7a065816576198a6527c99282a2551aaa7da38c::pool::normalized_balance_of<T0, T2>(arg0), 0xefe170ec0be4d762196bedecd7a065816576198a6527c99282a2551aaa7da38c::pool::normalized_balance_of<T0, T1>(arg0), 0xefe170ec0be4d762196bedecd7a065816576198a6527c99282a2551aaa7da38c::pool::weight_of<T0, T2>(arg0), 0xefe170ec0be4d762196bedecd7a065816576198a6527c99282a2551aaa7da38c::pool::weight_of<T0, T1>(arg0), 0xefe170ec0be4d762196bedecd7a065816576198a6527c99282a2551aaa7da38c::pool::fees_swap_in_for<T0, T2>(arg0), 0xefe170ec0be4d762196bedecd7a065816576198a6527c99282a2551aaa7da38c::pool::fees_swap_out_for<T0, T1>(arg0))
        } else {
            let v1 = 0xefe170ec0be4d762196bedecd7a065816576198a6527c99282a2551aaa7da38c::pool::normalized_balances<T0>(arg0);
            let v2 = 0xefe170ec0be4d762196bedecd7a065816576198a6527c99282a2551aaa7da38c::pool::weights<T0>(arg0);
            0x712579292f80c11a0c9de4ff553d6e5c4757105e83a8a3129823d2b39e65d062::stable_calculations::calc_spot_price_with_fees(&v1, &v2, 0xefe170ec0be4d762196bedecd7a065816576198a6527c99282a2551aaa7da38c::pool::fees_swap_in_for<T0, T2>(arg0), 0xefe170ec0be4d762196bedecd7a065816576198a6527c99282a2551aaa7da38c::pool::fees_swap_out_for<T0, T1>(arg0), 0xefe170ec0be4d762196bedecd7a065816576198a6527c99282a2551aaa7da38c::pool::type_to_index<T0, T2>(arg0), 0xefe170ec0be4d762196bedecd7a065816576198a6527c99282a2551aaa7da38c::pool::type_to_index<T0, T1>(arg0), 0xefe170ec0be4d762196bedecd7a065816576198a6527c99282a2551aaa7da38c::pool::flatness<T0>(arg0))
        }
    }

    fun assert_max_swap_amount_invariant<T0>(arg0: &0xefe170ec0be4d762196bedecd7a065816576198a6527c99282a2551aaa7da38c::pool::Pool<T0>, arg1: &vector<0x1::ascii::String>, arg2: &vector<u128>, arg3: u128, arg4: u64) {
        let v0 = 0;
        while (v0 < 0x1::vector::length<u128>(arg2)) {
            assert!(0x73baa782c55003b3a359dec04b189312565d18e7309d4a51f5f112f891e3b2ab::fixed::div_down_128(*0x1::vector::borrow<u128>(arg2, v0), 0xefe170ec0be4d762196bedecd7a065816576198a6527c99282a2551aaa7da38c::pool::type_name_to_normalized_balance_value<T0>(arg0, *0x1::vector::borrow<0x1::ascii::String>(arg1, v0))) <= arg3, arg4);
            v0 = v0 + 1;
        };
    }

    fun assert_slippage_lower_bound(arg0: u64, arg1: u64) {
        assert!(arg0 >= 1000000000000000000 - arg1, 51);
    }

    fun assert_slippage_upper_bound(arg0: u64, arg1: u64) {
        assert!(0x73baa782c55003b3a359dec04b189312565d18e7309d4a51f5f112f891e3b2ab::fixed::mul_by_fraction(arg0, 1000000000000000000 - arg1) <= 1000000000000000000, 51);
    }

    public fun calc_all_coin_withdraw<T0>(arg0: &0xefe170ec0be4d762196bedecd7a065816576198a6527c99282a2551aaa7da38c::pool::Pool<T0>, arg1: u64) : vector<u64> {
        let v0 = 0x73baa782c55003b3a359dec04b189312565d18e7309d4a51f5f112f891e3b2ab::fixed::div_by_fraction(arg1, 0xefe170ec0be4d762196bedecd7a065816576198a6527c99282a2551aaa7da38c::pool::lp_supply_value<T0>(arg0));
        assert!(v0 > 0, 57);
        let v1 = 0xefe170ec0be4d762196bedecd7a065816576198a6527c99282a2551aaa7da38c::pool::normalized_balances<T0>(arg0);
        0x73baa782c55003b3a359dec04b189312565d18e7309d4a51f5f112f891e3b2ab::vector::scale_mut_vector_128_64(&mut v1, v0);
        0xefe170ec0be4d762196bedecd7a065816576198a6527c99282a2551aaa7da38c::pool::unnormalize_amounts<T0>(arg0, &v1)
    }

    public fun calc_deposit_exact_in<T0>(arg0: &0xefe170ec0be4d762196bedecd7a065816576198a6527c99282a2551aaa7da38c::pool::Pool<T0>, arg1: &vector<0x1::ascii::String>, arg2: &vector<u64>, arg3: u128, arg4: u64) : u64 {
        let v0 = reorder_and_zero_out_empty_coins<T0>(arg0, arg1, arg2);
        let v1 = 0xefe170ec0be4d762196bedecd7a065816576198a6527c99282a2551aaa7da38c::pool::normalize_amounts<T0>(arg0, &v0);
        assert!(arg3 > 0, 57);
        let v2 = if (0xefe170ec0be4d762196bedecd7a065816576198a6527c99282a2551aaa7da38c::pool::flatness<T0>(arg0) == 0) {
            let v3 = 0xefe170ec0be4d762196bedecd7a065816576198a6527c99282a2551aaa7da38c::pool::normalized_balances<T0>(arg0);
            let v4 = 0xefe170ec0be4d762196bedecd7a065816576198a6527c99282a2551aaa7da38c::pool::weights<T0>(arg0);
            let v5 = 0xefe170ec0be4d762196bedecd7a065816576198a6527c99282a2551aaa7da38c::pool::fees_swap_in<T0>(arg0);
            let v6 = 0xefe170ec0be4d762196bedecd7a065816576198a6527c99282a2551aaa7da38c::pool::fees_swap_out<T0>(arg0);
            0x712579292f80c11a0c9de4ff553d6e5c4757105e83a8a3129823d2b39e65d062::geometric_mean_calculations::calc_deposit_fixed_amounts(&v3, &v4, &v5, &v6, &v1, arg3)
        } else {
            let v7 = 0xefe170ec0be4d762196bedecd7a065816576198a6527c99282a2551aaa7da38c::pool::normalized_balances<T0>(arg0);
            let v8 = 0xefe170ec0be4d762196bedecd7a065816576198a6527c99282a2551aaa7da38c::pool::weights<T0>(arg0);
            let v9 = 0xefe170ec0be4d762196bedecd7a065816576198a6527c99282a2551aaa7da38c::pool::fees_swap_in<T0>(arg0);
            let v10 = 0xefe170ec0be4d762196bedecd7a065816576198a6527c99282a2551aaa7da38c::pool::fees_swap_out<T0>(arg0);
            0x712579292f80c11a0c9de4ff553d6e5c4757105e83a8a3129823d2b39e65d062::stable_calculations::calc_deposit_fixed_amounts(&v7, &v8, &v9, &v10, &v1, arg3, 0xefe170ec0be4d762196bedecd7a065816576198a6527c99282a2551aaa7da38c::pool::flatness<T0>(arg0))
        };
        assert_slippage_lower_bound(v2, arg4);
        let v11 = calc_lp_coins_to_mint_from_t<T0>(arg0, 0xefe170ec0be4d762196bedecd7a065816576198a6527c99282a2551aaa7da38c::pool::lp_supply_value<T0>(arg0), 0x73baa782c55003b3a359dec04b189312565d18e7309d4a51f5f112f891e3b2ab::fixed::mul_by_fraction_64_128(v2, arg3));
        assert!(v11 > 0, 56);
        v11
    }

    public fun calc_lp_coins_to_mint_from_t<T0>(arg0: &0xefe170ec0be4d762196bedecd7a065816576198a6527c99282a2551aaa7da38c::pool::Pool<T0>, arg1: u64, arg2: u64) : u64 {
        let v0 = 0xefe170ec0be4d762196bedecd7a065816576198a6527c99282a2551aaa7da38c::pool::normalize_lp_amount<T0>(arg0, arg1);
        0xefe170ec0be4d762196bedecd7a065816576198a6527c99282a2551aaa7da38c::pool::unnormalize_lp_amount<T0>(arg0, 0x73baa782c55003b3a359dec04b189312565d18e7309d4a51f5f112f891e3b2ab::fixed::div_by_fraction_128_64(v0, arg2) - v0)
    }

    public fun calc_lp_ratio_after_burning_lp_coin(arg0: u64, arg1: u64) : u64 {
        0x73baa782c55003b3a359dec04b189312565d18e7309d4a51f5f112f891e3b2ab::fixed::div_by_fraction(arg0 - arg1, arg0)
    }

    public fun calc_oracle_price<T0, T1, T2>(arg0: &0xefe170ec0be4d762196bedecd7a065816576198a6527c99282a2551aaa7da38c::pool::Pool<T0>) : u128 {
        if (0xefe170ec0be4d762196bedecd7a065816576198a6527c99282a2551aaa7da38c::pool::flatness<T0>(arg0) == 0) {
            0x712579292f80c11a0c9de4ff553d6e5c4757105e83a8a3129823d2b39e65d062::geometric_mean_calculations::calc_spot_price(0xefe170ec0be4d762196bedecd7a065816576198a6527c99282a2551aaa7da38c::pool::normalized_balance_of<T0, T2>(arg0), 0xefe170ec0be4d762196bedecd7a065816576198a6527c99282a2551aaa7da38c::pool::normalized_balance_of<T0, T1>(arg0), 0xefe170ec0be4d762196bedecd7a065816576198a6527c99282a2551aaa7da38c::pool::weight_of<T0, T2>(arg0), 0xefe170ec0be4d762196bedecd7a065816576198a6527c99282a2551aaa7da38c::pool::weight_of<T0, T1>(arg0))
        } else {
            let v1 = 0xefe170ec0be4d762196bedecd7a065816576198a6527c99282a2551aaa7da38c::pool::normalized_balances<T0>(arg0);
            let v2 = 0xefe170ec0be4d762196bedecd7a065816576198a6527c99282a2551aaa7da38c::pool::weights<T0>(arg0);
            0x712579292f80c11a0c9de4ff553d6e5c4757105e83a8a3129823d2b39e65d062::stable_calculations::calc_spot_price(&v1, &v2, 0xefe170ec0be4d762196bedecd7a065816576198a6527c99282a2551aaa7da38c::pool::type_to_index<T0, T2>(arg0), 0xefe170ec0be4d762196bedecd7a065816576198a6527c99282a2551aaa7da38c::pool::type_to_index<T0, T1>(arg0), 0xefe170ec0be4d762196bedecd7a065816576198a6527c99282a2551aaa7da38c::pool::flatness<T0>(arg0))
        }
    }

    public fun calc_swap_exact_in<T0, T1, T2>(arg0: &0xefe170ec0be4d762196bedecd7a065816576198a6527c99282a2551aaa7da38c::pool::Pool<T0>, arg1: u64, arg2: u64, arg3: u64) : u64 {
        let v0 = 0xefe170ec0be4d762196bedecd7a065816576198a6527c99282a2551aaa7da38c::pool::normalize_amount<T0, T1>(arg0, arg1);
        let v1 = 0xefe170ec0be4d762196bedecd7a065816576198a6527c99282a2551aaa7da38c::pool::normalize_amount<T0, T2>(arg0, arg2);
        assert!(0x73baa782c55003b3a359dec04b189312565d18e7309d4a51f5f112f891e3b2ab::fixed::div_down_128(v0, 0xefe170ec0be4d762196bedecd7a065816576198a6527c99282a2551aaa7da38c::pool::normalized_balance_of<T0, T1>(arg0)) <= 300000000000000000, 52);
        let v2 = if (0xefe170ec0be4d762196bedecd7a065816576198a6527c99282a2551aaa7da38c::pool::flatness<T0>(arg0) == 0) {
            0x712579292f80c11a0c9de4ff553d6e5c4757105e83a8a3129823d2b39e65d062::geometric_mean_calculations::calc_out_given_in(0xefe170ec0be4d762196bedecd7a065816576198a6527c99282a2551aaa7da38c::pool::normalized_balance_of<T0, T1>(arg0), 0xefe170ec0be4d762196bedecd7a065816576198a6527c99282a2551aaa7da38c::pool::normalized_balance_of<T0, T2>(arg0), 0xefe170ec0be4d762196bedecd7a065816576198a6527c99282a2551aaa7da38c::pool::weight_of<T0, T1>(arg0), 0xefe170ec0be4d762196bedecd7a065816576198a6527c99282a2551aaa7da38c::pool::weight_of<T0, T2>(arg0), 0xefe170ec0be4d762196bedecd7a065816576198a6527c99282a2551aaa7da38c::pool::fees_swap_in_for<T0, T1>(arg0), 0xefe170ec0be4d762196bedecd7a065816576198a6527c99282a2551aaa7da38c::pool::fees_swap_out_for<T0, T2>(arg0), v0, v1)
        } else {
            let v3 = 0xefe170ec0be4d762196bedecd7a065816576198a6527c99282a2551aaa7da38c::pool::normalized_balances<T0>(arg0);
            let v4 = 0xefe170ec0be4d762196bedecd7a065816576198a6527c99282a2551aaa7da38c::pool::weights<T0>(arg0);
            0x712579292f80c11a0c9de4ff553d6e5c4757105e83a8a3129823d2b39e65d062::stable_calculations::calc_out_given_in(&v3, &v4, 0xefe170ec0be4d762196bedecd7a065816576198a6527c99282a2551aaa7da38c::pool::fees_swap_in_for<T0, T1>(arg0), 0xefe170ec0be4d762196bedecd7a065816576198a6527c99282a2551aaa7da38c::pool::fees_swap_out_for<T0, T2>(arg0), 0xefe170ec0be4d762196bedecd7a065816576198a6527c99282a2551aaa7da38c::pool::type_to_index<T0, T1>(arg0), 0xefe170ec0be4d762196bedecd7a065816576198a6527c99282a2551aaa7da38c::pool::type_to_index<T0, T2>(arg0), v0, v1, 0xefe170ec0be4d762196bedecd7a065816576198a6527c99282a2551aaa7da38c::pool::flatness<T0>(arg0))
        };
        assert_slippage_lower_bound(v2, arg3);
        let v5 = 0x73baa782c55003b3a359dec04b189312565d18e7309d4a51f5f112f891e3b2ab::fixed::mul_by_fraction_128_64(v1, v2);
        let v6 = 0xefe170ec0be4d762196bedecd7a065816576198a6527c99282a2551aaa7da38c::pool::unnormalize_amount<T0, T2>(arg0, v5);
        assert!(v6 > 0, 55);
        assert!(0x73baa782c55003b3a359dec04b189312565d18e7309d4a51f5f112f891e3b2ab::fixed::div_down_128(v5, 0xefe170ec0be4d762196bedecd7a065816576198a6527c99282a2551aaa7da38c::pool::normalized_balance_of<T0, T2>(arg0)) <= 300000000000000000, 53);
        v6
    }

    public fun calc_swap_exact_out<T0, T1, T2>(arg0: &0xefe170ec0be4d762196bedecd7a065816576198a6527c99282a2551aaa7da38c::pool::Pool<T0>, arg1: u64, arg2: u64, arg3: u64) : u64 {
        let v0 = 0xefe170ec0be4d762196bedecd7a065816576198a6527c99282a2551aaa7da38c::pool::normalize_amount<T0, T1>(arg0, arg1);
        let v1 = 0xefe170ec0be4d762196bedecd7a065816576198a6527c99282a2551aaa7da38c::pool::normalize_amount<T0, T2>(arg0, arg2);
        assert!(0x73baa782c55003b3a359dec04b189312565d18e7309d4a51f5f112f891e3b2ab::fixed::div_down_128(v1, 0xefe170ec0be4d762196bedecd7a065816576198a6527c99282a2551aaa7da38c::pool::normalized_balance_of<T0, T2>(arg0)) <= 300000000000000000, 53);
        let v2 = if (0xefe170ec0be4d762196bedecd7a065816576198a6527c99282a2551aaa7da38c::pool::flatness<T0>(arg0) == 0) {
            0x712579292f80c11a0c9de4ff553d6e5c4757105e83a8a3129823d2b39e65d062::geometric_mean_calculations::calc_in_given_out(0xefe170ec0be4d762196bedecd7a065816576198a6527c99282a2551aaa7da38c::pool::normalized_balance_of<T0, T1>(arg0), 0xefe170ec0be4d762196bedecd7a065816576198a6527c99282a2551aaa7da38c::pool::normalized_balance_of<T0, T2>(arg0), 0xefe170ec0be4d762196bedecd7a065816576198a6527c99282a2551aaa7da38c::pool::weight_of<T0, T1>(arg0), 0xefe170ec0be4d762196bedecd7a065816576198a6527c99282a2551aaa7da38c::pool::weight_of<T0, T2>(arg0), 0xefe170ec0be4d762196bedecd7a065816576198a6527c99282a2551aaa7da38c::pool::fees_swap_in_for<T0, T1>(arg0), 0xefe170ec0be4d762196bedecd7a065816576198a6527c99282a2551aaa7da38c::pool::fees_swap_out_for<T0, T2>(arg0), v0, v1)
        } else {
            let v3 = 0xefe170ec0be4d762196bedecd7a065816576198a6527c99282a2551aaa7da38c::pool::normalized_balances<T0>(arg0);
            let v4 = 0xefe170ec0be4d762196bedecd7a065816576198a6527c99282a2551aaa7da38c::pool::weights<T0>(arg0);
            0x712579292f80c11a0c9de4ff553d6e5c4757105e83a8a3129823d2b39e65d062::stable_calculations::calc_in_given_out(&v3, &v4, 0xefe170ec0be4d762196bedecd7a065816576198a6527c99282a2551aaa7da38c::pool::type_to_index<T0, T1>(arg0), 0xefe170ec0be4d762196bedecd7a065816576198a6527c99282a2551aaa7da38c::pool::type_to_index<T0, T2>(arg0), 0xefe170ec0be4d762196bedecd7a065816576198a6527c99282a2551aaa7da38c::pool::fees_swap_in_for<T0, T1>(arg0), 0xefe170ec0be4d762196bedecd7a065816576198a6527c99282a2551aaa7da38c::pool::fees_swap_out_for<T0, T2>(arg0), v0, v1, 0xefe170ec0be4d762196bedecd7a065816576198a6527c99282a2551aaa7da38c::pool::flatness<T0>(arg0))
        };
        assert_slippage_upper_bound(v2, arg3);
        let v5 = 0x73baa782c55003b3a359dec04b189312565d18e7309d4a51f5f112f891e3b2ab::fixed::mul_by_fraction_128_64(v0, v2);
        let v6 = 0xefe170ec0be4d762196bedecd7a065816576198a6527c99282a2551aaa7da38c::pool::unnormalize_amount<T0, T1>(arg0, v5);
        assert!(v6 > 0, 54);
        assert!(0x73baa782c55003b3a359dec04b189312565d18e7309d4a51f5f112f891e3b2ab::fixed::div_down_128(v5, 0xefe170ec0be4d762196bedecd7a065816576198a6527c99282a2551aaa7da38c::pool::normalized_balance_of<T0, T1>(arg0)) <= 300000000000000000, 52);
        v6
    }

    public fun reorder_and_zero_out_empty_coins<T0>(arg0: &0xefe170ec0be4d762196bedecd7a065816576198a6527c99282a2551aaa7da38c::pool::Pool<T0>, arg1: &vector<0x1::ascii::String>, arg2: &vector<u64>) : vector<u64> {
        let v0 = 0x73baa782c55003b3a359dec04b189312565d18e7309d4a51f5f112f891e3b2ab::vector::empty_vector(0xefe170ec0be4d762196bedecd7a065816576198a6527c99282a2551aaa7da38c::pool::size<T0>(arg0));
        let v1 = 0;
        while (v1 < 0x1::vector::length<0x1::ascii::String>(arg1)) {
            *0x1::vector::borrow_mut<u64>(&mut v0, 0xefe170ec0be4d762196bedecd7a065816576198a6527c99282a2551aaa7da38c::pool::type_name_to_index<T0>(arg0, *0x1::vector::borrow<0x1::ascii::String>(arg1, v1))) = *0x1::vector::borrow<u64>(arg2, v1);
            v1 = v1 + 1;
        };
        v0
    }

    public fun reorder_by_order_of_calling_function<T0>(arg0: &0xefe170ec0be4d762196bedecd7a065816576198a6527c99282a2551aaa7da38c::pool::Pool<T0>, arg1: &vector<0x1::ascii::String>, arg2: &vector<u64>) : vector<u64> {
        let v0 = 0x73baa782c55003b3a359dec04b189312565d18e7309d4a51f5f112f891e3b2ab::vector::empty_vector(0x1::vector::length<0x1::ascii::String>(arg1));
        let v1 = 0;
        while (v1 < 0x1::vector::length<0x1::ascii::String>(arg1)) {
            let v2 = *0x1::vector::borrow<u64>(arg2, 0xefe170ec0be4d762196bedecd7a065816576198a6527c99282a2551aaa7da38c::pool::type_name_to_index<T0>(arg0, *0x1::vector::borrow<0x1::ascii::String>(arg1, v1)));
            assert!(v2 > 0, 54);
            *0x1::vector::borrow_mut<u64>(&mut v0, v1) = v2;
            v1 = v1 + 1;
        };
        v0
    }

    // decompiled from Move bytecode v6
}

