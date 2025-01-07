module 0xe11048f0dbebdae00779ca38c7c3f8959765e2572f9b77b607e7dcf96111df22::math {
    public fun calc_all_coin_deposit<T0>(arg0: &0xe11048f0dbebdae00779ca38c7c3f8959765e2572f9b77b607e7dcf96111df22::pool::Pool<T0>, arg1: &vector<0x1::ascii::String>, arg2: &vector<u128>) : (u64, vector<u128>) {
        let v0 = reorder_and_zero_out_empty_coins<T0>(arg0, arg1, arg2);
        let v1 = if (0xe11048f0dbebdae00779ca38c7c3f8959765e2572f9b77b607e7dcf96111df22::pool::flatness<T0>(arg0) == 0) {
            let v2 = 0xe11048f0dbebdae00779ca38c7c3f8959765e2572f9b77b607e7dcf96111df22::pool::normalized_balances<T0>(arg0);
            0x9c0e058e8a8f8b70efab7e9804fdd51c2762305be3cffafbb1e627a69433bbfb::geometric_mean_calculations::calc_all_coin_deposit(&v2, &v0)
        } else {
            let v3 = 0xe11048f0dbebdae00779ca38c7c3f8959765e2572f9b77b607e7dcf96111df22::pool::normalized_balances<T0>(arg0);
            0x9c0e058e8a8f8b70efab7e9804fdd51c2762305be3cffafbb1e627a69433bbfb::stable_calculations::calc_all_coin_deposit(&v3, &v0)
        };
        let v4 = 0xaca10f85b508736ebce633d33581b0c511cc1b098283dbd2a4c359cab8e66a84::fixed::mul_by_fraction(0xe11048f0dbebdae00779ca38c7c3f8959765e2572f9b77b607e7dcf96111df22::pool::lp_supply_value<T0>(arg0), v1);
        assert!(v4 > 0, 56);
        let v5 = 0xe11048f0dbebdae00779ca38c7c3f8959765e2572f9b77b607e7dcf96111df22::pool::normalized_balances<T0>(arg0);
        0xaca10f85b508736ebce633d33581b0c511cc1b098283dbd2a4c359cab8e66a84::vector::scale_mut_vector_128_64(&mut v5, v1);
        let v6 = 0;
        while (v6 < 0x1::vector::length<u128>(&v5)) {
            assert!(0xe11048f0dbebdae00779ca38c7c3f8959765e2572f9b77b607e7dcf96111df22::pool::unnormalize_amount_with_index<T0>(arg0, v6, *0x1::vector::borrow<u128>(&v5, v6)) > 0, 54);
            v6 = v6 + 1;
        };
        (v4, reorder_by_order_of_calling_function<T0>(arg0, arg1, &v5))
    }

    public fun calc_invariant<T0>(arg0: &0xe11048f0dbebdae00779ca38c7c3f8959765e2572f9b77b607e7dcf96111df22::pool::Pool<T0>, arg1: &vector<u128>) : u128 {
        let v0 = if (0xe11048f0dbebdae00779ca38c7c3f8959765e2572f9b77b607e7dcf96111df22::pool::flatness<T0>(arg0) == 0) {
            let v1 = 0xe11048f0dbebdae00779ca38c7c3f8959765e2572f9b77b607e7dcf96111df22::pool::weights<T0>(arg0);
            0x9c0e058e8a8f8b70efab7e9804fdd51c2762305be3cffafbb1e627a69433bbfb::geometric_mean_calculations::calc_invariant(arg1, &v1)
        } else {
            let v2 = 0xe11048f0dbebdae00779ca38c7c3f8959765e2572f9b77b607e7dcf96111df22::pool::weights<T0>(arg0);
            0x9c0e058e8a8f8b70efab7e9804fdd51c2762305be3cffafbb1e627a69433bbfb::stable_calculations::calc_invariant(arg1, &v2, 0xe11048f0dbebdae00779ca38c7c3f8959765e2572f9b77b607e7dcf96111df22::pool::flatness<T0>(arg0))
        };
        assert!(v0 > 0, 51);
        v0
    }

    public fun calc_spot_price<T0, T1, T2>(arg0: &0xe11048f0dbebdae00779ca38c7c3f8959765e2572f9b77b607e7dcf96111df22::pool::Pool<T0>) : u128 {
        if (0xe11048f0dbebdae00779ca38c7c3f8959765e2572f9b77b607e7dcf96111df22::pool::flatness<T0>(arg0) == 0) {
            0x9c0e058e8a8f8b70efab7e9804fdd51c2762305be3cffafbb1e627a69433bbfb::geometric_mean_calculations::calc_spot_price_with_fees(0xe11048f0dbebdae00779ca38c7c3f8959765e2572f9b77b607e7dcf96111df22::pool::normalized_balance_of<T0, T2>(arg0), 0xe11048f0dbebdae00779ca38c7c3f8959765e2572f9b77b607e7dcf96111df22::pool::normalized_balance_of<T0, T1>(arg0), 0xe11048f0dbebdae00779ca38c7c3f8959765e2572f9b77b607e7dcf96111df22::pool::weight_of<T0, T2>(arg0), 0xe11048f0dbebdae00779ca38c7c3f8959765e2572f9b77b607e7dcf96111df22::pool::weight_of<T0, T1>(arg0), 0xe11048f0dbebdae00779ca38c7c3f8959765e2572f9b77b607e7dcf96111df22::pool::fees_swap_in_for<T0, T2>(arg0), 0xe11048f0dbebdae00779ca38c7c3f8959765e2572f9b77b607e7dcf96111df22::pool::fees_swap_out_for<T0, T1>(arg0))
        } else {
            let v1 = 0xe11048f0dbebdae00779ca38c7c3f8959765e2572f9b77b607e7dcf96111df22::pool::normalized_balances<T0>(arg0);
            let v2 = 0xe11048f0dbebdae00779ca38c7c3f8959765e2572f9b77b607e7dcf96111df22::pool::weights<T0>(arg0);
            0x9c0e058e8a8f8b70efab7e9804fdd51c2762305be3cffafbb1e627a69433bbfb::stable_calculations::calc_spot_price_with_fees(&v1, &v2, 0xe11048f0dbebdae00779ca38c7c3f8959765e2572f9b77b607e7dcf96111df22::pool::fees_swap_in_for<T0, T2>(arg0), 0xe11048f0dbebdae00779ca38c7c3f8959765e2572f9b77b607e7dcf96111df22::pool::fees_swap_out_for<T0, T1>(arg0), 0xe11048f0dbebdae00779ca38c7c3f8959765e2572f9b77b607e7dcf96111df22::pool::type_to_index<T0, T2>(arg0), 0xe11048f0dbebdae00779ca38c7c3f8959765e2572f9b77b607e7dcf96111df22::pool::type_to_index<T0, T1>(arg0), 0xe11048f0dbebdae00779ca38c7c3f8959765e2572f9b77b607e7dcf96111df22::pool::flatness<T0>(arg0))
        }
    }

    fun assert_max_swap_amount_invariant<T0>(arg0: &0xe11048f0dbebdae00779ca38c7c3f8959765e2572f9b77b607e7dcf96111df22::pool::Pool<T0>, arg1: &vector<0x1::ascii::String>, arg2: &vector<u128>, arg3: u128, arg4: u64) {
        let v0 = 0;
        while (v0 < 0x1::vector::length<u128>(arg2)) {
            assert!(0xaca10f85b508736ebce633d33581b0c511cc1b098283dbd2a4c359cab8e66a84::fixed::div_down_128(*0x1::vector::borrow<u128>(arg2, v0), 0xe11048f0dbebdae00779ca38c7c3f8959765e2572f9b77b607e7dcf96111df22::pool::type_name_to_normalized_balance_value<T0>(arg0, *0x1::vector::borrow<0x1::ascii::String>(arg1, v0))) <= arg3, arg4);
            v0 = v0 + 1;
        };
    }

    fun assert_slippage_lower_bound(arg0: u64, arg1: u64) {
        assert!(arg0 >= 1000000000000000000 - arg1, 51);
    }

    fun assert_slippage_upper_bound(arg0: u64, arg1: u64) {
        assert!(0xaca10f85b508736ebce633d33581b0c511cc1b098283dbd2a4c359cab8e66a84::fixed::mul_by_fraction(arg0, 1000000000000000000 - arg1) <= 1000000000000000000, 51);
    }

    public fun calc_all_coin_withdraw<T0>(arg0: &0xe11048f0dbebdae00779ca38c7c3f8959765e2572f9b77b607e7dcf96111df22::pool::Pool<T0>, arg1: u64) : vector<u128> {
        let v0 = 0xaca10f85b508736ebce633d33581b0c511cc1b098283dbd2a4c359cab8e66a84::fixed::div_by_fraction(arg1, 0xe11048f0dbebdae00779ca38c7c3f8959765e2572f9b77b607e7dcf96111df22::pool::lp_supply_value<T0>(arg0));
        assert!(v0 > 0, 57);
        let v1 = 0xe11048f0dbebdae00779ca38c7c3f8959765e2572f9b77b607e7dcf96111df22::pool::normalized_balances<T0>(arg0);
        0xaca10f85b508736ebce633d33581b0c511cc1b098283dbd2a4c359cab8e66a84::vector::scale_mut_vector_128_64(&mut v1, v0);
        v1
    }

    public fun calc_deposit_exact_in<T0>(arg0: &0xe11048f0dbebdae00779ca38c7c3f8959765e2572f9b77b607e7dcf96111df22::pool::Pool<T0>, arg1: &vector<0x1::ascii::String>, arg2: &vector<u128>, arg3: u128, arg4: u64) : u64 {
        let v0 = reorder_and_zero_out_empty_coins<T0>(arg0, arg1, arg2);
        assert!(arg3 > 0, 57);
        let v1 = if (0xe11048f0dbebdae00779ca38c7c3f8959765e2572f9b77b607e7dcf96111df22::pool::flatness<T0>(arg0) == 0) {
            let v2 = 0xe11048f0dbebdae00779ca38c7c3f8959765e2572f9b77b607e7dcf96111df22::pool::normalized_balances<T0>(arg0);
            let v3 = 0xe11048f0dbebdae00779ca38c7c3f8959765e2572f9b77b607e7dcf96111df22::pool::weights<T0>(arg0);
            let v4 = 0xe11048f0dbebdae00779ca38c7c3f8959765e2572f9b77b607e7dcf96111df22::pool::fees_swap_in<T0>(arg0);
            let v5 = 0xe11048f0dbebdae00779ca38c7c3f8959765e2572f9b77b607e7dcf96111df22::pool::fees_swap_out<T0>(arg0);
            0x9c0e058e8a8f8b70efab7e9804fdd51c2762305be3cffafbb1e627a69433bbfb::geometric_mean_calculations::calc_deposit_fixed_amounts(&v2, &v3, &v4, &v5, &v0, arg3)
        } else {
            let v6 = 0xe11048f0dbebdae00779ca38c7c3f8959765e2572f9b77b607e7dcf96111df22::pool::normalized_balances<T0>(arg0);
            let v7 = 0xe11048f0dbebdae00779ca38c7c3f8959765e2572f9b77b607e7dcf96111df22::pool::weights<T0>(arg0);
            let v8 = 0xe11048f0dbebdae00779ca38c7c3f8959765e2572f9b77b607e7dcf96111df22::pool::fees_swap_in<T0>(arg0);
            let v9 = 0xe11048f0dbebdae00779ca38c7c3f8959765e2572f9b77b607e7dcf96111df22::pool::fees_swap_out<T0>(arg0);
            0x9c0e058e8a8f8b70efab7e9804fdd51c2762305be3cffafbb1e627a69433bbfb::stable_calculations::calc_deposit_fixed_amounts(&v6, &v7, &v8, &v9, &v0, arg3, 0xe11048f0dbebdae00779ca38c7c3f8959765e2572f9b77b607e7dcf96111df22::pool::flatness<T0>(arg0))
        };
        assert_slippage_lower_bound(v1, arg4);
        let v10 = calc_lp_coins_to_mint_from_t<T0>(arg0, 0xe11048f0dbebdae00779ca38c7c3f8959765e2572f9b77b607e7dcf96111df22::pool::lp_supply_value<T0>(arg0), 0xaca10f85b508736ebce633d33581b0c511cc1b098283dbd2a4c359cab8e66a84::fixed::mul_by_fraction_64_128(v1, arg3));
        assert!(v10 > 0, 56);
        v10
    }

    public fun calc_lp_coins_to_mint_from_t<T0>(arg0: &0xe11048f0dbebdae00779ca38c7c3f8959765e2572f9b77b607e7dcf96111df22::pool::Pool<T0>, arg1: u64, arg2: u64) : u64 {
        let v0 = 0xe11048f0dbebdae00779ca38c7c3f8959765e2572f9b77b607e7dcf96111df22::pool::normalize_lp_amount<T0>(arg0, arg1);
        0xe11048f0dbebdae00779ca38c7c3f8959765e2572f9b77b607e7dcf96111df22::pool::unnormalize_lp_amount<T0>(arg0, 0xaca10f85b508736ebce633d33581b0c511cc1b098283dbd2a4c359cab8e66a84::fixed::div_by_fraction_128_64(v0, arg2) - v0)
    }

    public fun calc_lp_ratio_after_burning_lp_coin(arg0: u64, arg1: u64) : u64 {
        0xaca10f85b508736ebce633d33581b0c511cc1b098283dbd2a4c359cab8e66a84::fixed::div_by_fraction(arg0 - arg1, arg0)
    }

    public fun calc_multi_swap_exact_in<T0>(arg0: &0xe11048f0dbebdae00779ca38c7c3f8959765e2572f9b77b607e7dcf96111df22::pool::Pool<T0>, arg1: &vector<0x1::ascii::String>, arg2: &vector<u128>, arg3: &vector<0x1::ascii::String>, arg4: &vector<u128>, arg5: u64) : vector<u128> {
        assert_max_swap_amount_invariant<T0>(arg0, arg1, arg2, 300000000000000000, 52);
        let v0 = reorder_and_zero_out_empty_coins<T0>(arg0, arg1, arg2);
        let v1 = reorder_and_zero_out_empty_coins<T0>(arg0, arg3, arg4);
        let v2 = if (0xe11048f0dbebdae00779ca38c7c3f8959765e2572f9b77b607e7dcf96111df22::pool::flatness<T0>(arg0) == 0) {
            let v3 = 0xe11048f0dbebdae00779ca38c7c3f8959765e2572f9b77b607e7dcf96111df22::pool::normalized_balances<T0>(arg0);
            let v4 = 0xe11048f0dbebdae00779ca38c7c3f8959765e2572f9b77b607e7dcf96111df22::pool::weights<T0>(arg0);
            let v5 = 0xe11048f0dbebdae00779ca38c7c3f8959765e2572f9b77b607e7dcf96111df22::pool::fees_swap_in<T0>(arg0);
            let v6 = 0xe11048f0dbebdae00779ca38c7c3f8959765e2572f9b77b607e7dcf96111df22::pool::fees_swap_out<T0>(arg0);
            0x9c0e058e8a8f8b70efab7e9804fdd51c2762305be3cffafbb1e627a69433bbfb::geometric_mean_calculations::calc_swap_fixed_in(&v3, &v4, &v5, &v6, &v0, &v1)
        } else {
            let v7 = 0xe11048f0dbebdae00779ca38c7c3f8959765e2572f9b77b607e7dcf96111df22::pool::normalized_balances<T0>(arg0);
            let v8 = 0xe11048f0dbebdae00779ca38c7c3f8959765e2572f9b77b607e7dcf96111df22::pool::weights<T0>(arg0);
            let v9 = 0xe11048f0dbebdae00779ca38c7c3f8959765e2572f9b77b607e7dcf96111df22::pool::fees_swap_in<T0>(arg0);
            let v10 = 0xe11048f0dbebdae00779ca38c7c3f8959765e2572f9b77b607e7dcf96111df22::pool::fees_swap_out<T0>(arg0);
            0x9c0e058e8a8f8b70efab7e9804fdd51c2762305be3cffafbb1e627a69433bbfb::stable_calculations::calc_swap_fixed_in(&v7, &v8, &v9, &v10, &v0, &v1, 0xe11048f0dbebdae00779ca38c7c3f8959765e2572f9b77b607e7dcf96111df22::pool::flatness<T0>(arg0))
        };
        assert_slippage_lower_bound(v2, arg5);
        0xaca10f85b508736ebce633d33581b0c511cc1b098283dbd2a4c359cab8e66a84::vector::scale_mut_vector_128_64(&mut v1, v2);
        assert_max_swap_amount_invariant<T0>(arg0, arg3, &v1, 300000000000000000, 53);
        v1
    }

    public fun calc_multi_swap_exact_out<T0>(arg0: &0xe11048f0dbebdae00779ca38c7c3f8959765e2572f9b77b607e7dcf96111df22::pool::Pool<T0>, arg1: &vector<0x1::ascii::String>, arg2: &vector<u128>, arg3: &vector<0x1::ascii::String>, arg4: &vector<u128>, arg5: u64) : vector<u128> {
        assert_max_swap_amount_invariant<T0>(arg0, arg3, arg4, 300000000000000000, 53);
        let v0 = reorder_and_zero_out_empty_coins<T0>(arg0, arg1, arg2);
        let v1 = reorder_and_zero_out_empty_coins<T0>(arg0, arg3, arg4);
        let v2 = if (0xe11048f0dbebdae00779ca38c7c3f8959765e2572f9b77b607e7dcf96111df22::pool::flatness<T0>(arg0) == 0) {
            let v3 = 0xe11048f0dbebdae00779ca38c7c3f8959765e2572f9b77b607e7dcf96111df22::pool::normalized_balances<T0>(arg0);
            let v4 = 0xe11048f0dbebdae00779ca38c7c3f8959765e2572f9b77b607e7dcf96111df22::pool::weights<T0>(arg0);
            let v5 = 0xe11048f0dbebdae00779ca38c7c3f8959765e2572f9b77b607e7dcf96111df22::pool::fees_swap_in<T0>(arg0);
            let v6 = 0xe11048f0dbebdae00779ca38c7c3f8959765e2572f9b77b607e7dcf96111df22::pool::fees_swap_out<T0>(arg0);
            0x9c0e058e8a8f8b70efab7e9804fdd51c2762305be3cffafbb1e627a69433bbfb::geometric_mean_calculations::calc_swap_fixed_out(&v3, &v4, &v5, &v6, &v0, &v1)
        } else {
            let v7 = 0xe11048f0dbebdae00779ca38c7c3f8959765e2572f9b77b607e7dcf96111df22::pool::normalized_balances<T0>(arg0);
            let v8 = 0xe11048f0dbebdae00779ca38c7c3f8959765e2572f9b77b607e7dcf96111df22::pool::weights<T0>(arg0);
            let v9 = 0xe11048f0dbebdae00779ca38c7c3f8959765e2572f9b77b607e7dcf96111df22::pool::fees_swap_in<T0>(arg0);
            let v10 = 0xe11048f0dbebdae00779ca38c7c3f8959765e2572f9b77b607e7dcf96111df22::pool::fees_swap_out<T0>(arg0);
            0x9c0e058e8a8f8b70efab7e9804fdd51c2762305be3cffafbb1e627a69433bbfb::stable_calculations::calc_swap_fixed_out(&v7, &v8, &v9, &v10, &v0, &v1, 0xe11048f0dbebdae00779ca38c7c3f8959765e2572f9b77b607e7dcf96111df22::pool::flatness<T0>(arg0))
        };
        assert_slippage_upper_bound(v2, arg5);
        0xaca10f85b508736ebce633d33581b0c511cc1b098283dbd2a4c359cab8e66a84::vector::scale_mut_vector_128_64(&mut v0, v2);
        assert_max_swap_amount_invariant<T0>(arg0, arg1, &v0, 300000000000000000, 52);
        v0
    }

    public fun calc_oracle_price<T0, T1, T2>(arg0: &0xe11048f0dbebdae00779ca38c7c3f8959765e2572f9b77b607e7dcf96111df22::pool::Pool<T0>) : u128 {
        if (0xe11048f0dbebdae00779ca38c7c3f8959765e2572f9b77b607e7dcf96111df22::pool::flatness<T0>(arg0) == 0) {
            0x9c0e058e8a8f8b70efab7e9804fdd51c2762305be3cffafbb1e627a69433bbfb::geometric_mean_calculations::calc_spot_price(0xe11048f0dbebdae00779ca38c7c3f8959765e2572f9b77b607e7dcf96111df22::pool::normalized_balance_of<T0, T2>(arg0), 0xe11048f0dbebdae00779ca38c7c3f8959765e2572f9b77b607e7dcf96111df22::pool::normalized_balance_of<T0, T1>(arg0), 0xe11048f0dbebdae00779ca38c7c3f8959765e2572f9b77b607e7dcf96111df22::pool::weight_of<T0, T2>(arg0), 0xe11048f0dbebdae00779ca38c7c3f8959765e2572f9b77b607e7dcf96111df22::pool::weight_of<T0, T1>(arg0))
        } else {
            let v1 = 0xe11048f0dbebdae00779ca38c7c3f8959765e2572f9b77b607e7dcf96111df22::pool::normalized_balances<T0>(arg0);
            let v2 = 0xe11048f0dbebdae00779ca38c7c3f8959765e2572f9b77b607e7dcf96111df22::pool::weights<T0>(arg0);
            0x9c0e058e8a8f8b70efab7e9804fdd51c2762305be3cffafbb1e627a69433bbfb::stable_calculations::calc_spot_price(&v1, &v2, 0xe11048f0dbebdae00779ca38c7c3f8959765e2572f9b77b607e7dcf96111df22::pool::type_to_index<T0, T2>(arg0), 0xe11048f0dbebdae00779ca38c7c3f8959765e2572f9b77b607e7dcf96111df22::pool::type_to_index<T0, T1>(arg0), 0xe11048f0dbebdae00779ca38c7c3f8959765e2572f9b77b607e7dcf96111df22::pool::flatness<T0>(arg0))
        }
    }

    public fun calc_swap_exact_in<T0, T1, T2>(arg0: &0xe11048f0dbebdae00779ca38c7c3f8959765e2572f9b77b607e7dcf96111df22::pool::Pool<T0>, arg1: u128, arg2: u128, arg3: u64) : u128 {
        assert!(0xaca10f85b508736ebce633d33581b0c511cc1b098283dbd2a4c359cab8e66a84::fixed::div_down_128(arg1, 0xe11048f0dbebdae00779ca38c7c3f8959765e2572f9b77b607e7dcf96111df22::pool::normalized_balance_of<T0, T1>(arg0)) <= 300000000000000000, 52);
        let v0 = if (0xe11048f0dbebdae00779ca38c7c3f8959765e2572f9b77b607e7dcf96111df22::pool::flatness<T0>(arg0) == 0) {
            0x9c0e058e8a8f8b70efab7e9804fdd51c2762305be3cffafbb1e627a69433bbfb::geometric_mean_calculations::calc_out_given_in(0xe11048f0dbebdae00779ca38c7c3f8959765e2572f9b77b607e7dcf96111df22::pool::normalized_balance_of<T0, T1>(arg0), 0xe11048f0dbebdae00779ca38c7c3f8959765e2572f9b77b607e7dcf96111df22::pool::normalized_balance_of<T0, T2>(arg0), 0xe11048f0dbebdae00779ca38c7c3f8959765e2572f9b77b607e7dcf96111df22::pool::weight_of<T0, T1>(arg0), 0xe11048f0dbebdae00779ca38c7c3f8959765e2572f9b77b607e7dcf96111df22::pool::weight_of<T0, T2>(arg0), 0xe11048f0dbebdae00779ca38c7c3f8959765e2572f9b77b607e7dcf96111df22::pool::fees_swap_in_for<T0, T1>(arg0), 0xe11048f0dbebdae00779ca38c7c3f8959765e2572f9b77b607e7dcf96111df22::pool::fees_swap_out_for<T0, T2>(arg0), arg1, arg2)
        } else {
            let v1 = 0xe11048f0dbebdae00779ca38c7c3f8959765e2572f9b77b607e7dcf96111df22::pool::normalized_balances<T0>(arg0);
            let v2 = 0xe11048f0dbebdae00779ca38c7c3f8959765e2572f9b77b607e7dcf96111df22::pool::weights<T0>(arg0);
            0x9c0e058e8a8f8b70efab7e9804fdd51c2762305be3cffafbb1e627a69433bbfb::stable_calculations::calc_out_given_in(&v1, &v2, 0xe11048f0dbebdae00779ca38c7c3f8959765e2572f9b77b607e7dcf96111df22::pool::fees_swap_in_for<T0, T1>(arg0), 0xe11048f0dbebdae00779ca38c7c3f8959765e2572f9b77b607e7dcf96111df22::pool::fees_swap_out_for<T0, T2>(arg0), 0xe11048f0dbebdae00779ca38c7c3f8959765e2572f9b77b607e7dcf96111df22::pool::type_to_index<T0, T1>(arg0), 0xe11048f0dbebdae00779ca38c7c3f8959765e2572f9b77b607e7dcf96111df22::pool::type_to_index<T0, T2>(arg0), arg1, arg2, 0xe11048f0dbebdae00779ca38c7c3f8959765e2572f9b77b607e7dcf96111df22::pool::flatness<T0>(arg0))
        };
        let v3 = v0;
        0x1::debug::print<u64>(&v3);
        assert_slippage_lower_bound(v3, arg3);
        let v4 = 0xaca10f85b508736ebce633d33581b0c511cc1b098283dbd2a4c359cab8e66a84::fixed::mul_by_fraction_128_64(arg2, v3);
        assert!(v4 > 0, 55);
        assert!(0xaca10f85b508736ebce633d33581b0c511cc1b098283dbd2a4c359cab8e66a84::fixed::div_down_128(v4, 0xe11048f0dbebdae00779ca38c7c3f8959765e2572f9b77b607e7dcf96111df22::pool::normalized_balance_of<T0, T2>(arg0)) <= 300000000000000000, 53);
        v4
    }

    public fun calc_swap_exact_out<T0, T1, T2>(arg0: &0xe11048f0dbebdae00779ca38c7c3f8959765e2572f9b77b607e7dcf96111df22::pool::Pool<T0>, arg1: u128, arg2: u128, arg3: u64) : u128 {
        assert!(0xaca10f85b508736ebce633d33581b0c511cc1b098283dbd2a4c359cab8e66a84::fixed::div_down_128(arg2, 0xe11048f0dbebdae00779ca38c7c3f8959765e2572f9b77b607e7dcf96111df22::pool::normalized_balance_of<T0, T2>(arg0)) <= 300000000000000000, 53);
        let v0 = if (0xe11048f0dbebdae00779ca38c7c3f8959765e2572f9b77b607e7dcf96111df22::pool::flatness<T0>(arg0) == 0) {
            0x9c0e058e8a8f8b70efab7e9804fdd51c2762305be3cffafbb1e627a69433bbfb::geometric_mean_calculations::calc_in_given_out(0xe11048f0dbebdae00779ca38c7c3f8959765e2572f9b77b607e7dcf96111df22::pool::normalized_balance_of<T0, T1>(arg0), 0xe11048f0dbebdae00779ca38c7c3f8959765e2572f9b77b607e7dcf96111df22::pool::normalized_balance_of<T0, T2>(arg0), 0xe11048f0dbebdae00779ca38c7c3f8959765e2572f9b77b607e7dcf96111df22::pool::weight_of<T0, T1>(arg0), 0xe11048f0dbebdae00779ca38c7c3f8959765e2572f9b77b607e7dcf96111df22::pool::weight_of<T0, T2>(arg0), 0xe11048f0dbebdae00779ca38c7c3f8959765e2572f9b77b607e7dcf96111df22::pool::fees_swap_in_for<T0, T1>(arg0), 0xe11048f0dbebdae00779ca38c7c3f8959765e2572f9b77b607e7dcf96111df22::pool::fees_swap_out_for<T0, T2>(arg0), arg1, arg2)
        } else {
            let v1 = 0xe11048f0dbebdae00779ca38c7c3f8959765e2572f9b77b607e7dcf96111df22::pool::normalized_balances<T0>(arg0);
            let v2 = 0xe11048f0dbebdae00779ca38c7c3f8959765e2572f9b77b607e7dcf96111df22::pool::weights<T0>(arg0);
            0x9c0e058e8a8f8b70efab7e9804fdd51c2762305be3cffafbb1e627a69433bbfb::stable_calculations::calc_in_given_out(&v1, &v2, 0xe11048f0dbebdae00779ca38c7c3f8959765e2572f9b77b607e7dcf96111df22::pool::type_to_index<T0, T1>(arg0), 0xe11048f0dbebdae00779ca38c7c3f8959765e2572f9b77b607e7dcf96111df22::pool::type_to_index<T0, T2>(arg0), 0xe11048f0dbebdae00779ca38c7c3f8959765e2572f9b77b607e7dcf96111df22::pool::fees_swap_in_for<T0, T1>(arg0), 0xe11048f0dbebdae00779ca38c7c3f8959765e2572f9b77b607e7dcf96111df22::pool::fees_swap_out_for<T0, T2>(arg0), arg1, arg2, 0xe11048f0dbebdae00779ca38c7c3f8959765e2572f9b77b607e7dcf96111df22::pool::flatness<T0>(arg0))
        };
        assert_slippage_upper_bound(v0, arg3);
        let v3 = 0xaca10f85b508736ebce633d33581b0c511cc1b098283dbd2a4c359cab8e66a84::fixed::mul_by_fraction_128_64(arg1, v0);
        assert!(v3 > 0, 54);
        assert!(0xaca10f85b508736ebce633d33581b0c511cc1b098283dbd2a4c359cab8e66a84::fixed::div_down_128(v3, 0xe11048f0dbebdae00779ca38c7c3f8959765e2572f9b77b607e7dcf96111df22::pool::normalized_balance_of<T0, T1>(arg0)) <= 300000000000000000, 52);
        v3
    }

    public fun calc_withdraw_exact_lp<T0>(arg0: &0xe11048f0dbebdae00779ca38c7c3f8959765e2572f9b77b607e7dcf96111df22::pool::Pool<T0>, arg1: &vector<0x1::ascii::String>, arg2: u64, arg3: &vector<u128>, arg4: u64) : vector<u128> {
        let v0 = (calc_lp_ratio_after_burning_lp_coin(0xe11048f0dbebdae00779ca38c7c3f8959765e2572f9b77b607e7dcf96111df22::pool::lp_supply_value<T0>(arg0), arg2) as u128);
        assert!(v0 > 0, 57);
        let v1 = reorder_and_zero_out_empty_coins<T0>(arg0, arg1, arg3);
        let v2 = if (0xe11048f0dbebdae00779ca38c7c3f8959765e2572f9b77b607e7dcf96111df22::pool::flatness<T0>(arg0) == 0) {
            let v3 = 0xe11048f0dbebdae00779ca38c7c3f8959765e2572f9b77b607e7dcf96111df22::pool::normalized_balances<T0>(arg0);
            let v4 = 0xe11048f0dbebdae00779ca38c7c3f8959765e2572f9b77b607e7dcf96111df22::pool::weights<T0>(arg0);
            let v5 = 0xe11048f0dbebdae00779ca38c7c3f8959765e2572f9b77b607e7dcf96111df22::pool::fees_swap_in<T0>(arg0);
            let v6 = 0xe11048f0dbebdae00779ca38c7c3f8959765e2572f9b77b607e7dcf96111df22::pool::fees_swap_out<T0>(arg0);
            0x9c0e058e8a8f8b70efab7e9804fdd51c2762305be3cffafbb1e627a69433bbfb::geometric_mean_calculations::calc_withdraw_flp_amounts_out(&v3, &v4, &v5, &v6, &v1, v0)
        } else {
            let v7 = 0xe11048f0dbebdae00779ca38c7c3f8959765e2572f9b77b607e7dcf96111df22::pool::normalized_balances<T0>(arg0);
            let v8 = 0xe11048f0dbebdae00779ca38c7c3f8959765e2572f9b77b607e7dcf96111df22::pool::weights<T0>(arg0);
            let v9 = 0xe11048f0dbebdae00779ca38c7c3f8959765e2572f9b77b607e7dcf96111df22::pool::fees_swap_in<T0>(arg0);
            let v10 = 0xe11048f0dbebdae00779ca38c7c3f8959765e2572f9b77b607e7dcf96111df22::pool::fees_swap_out<T0>(arg0);
            0x9c0e058e8a8f8b70efab7e9804fdd51c2762305be3cffafbb1e627a69433bbfb::stable_calculations::calc_withdraw_flp_amounts_out(&v7, &v8, &v9, &v10, &v1, v0, 0xe11048f0dbebdae00779ca38c7c3f8959765e2572f9b77b607e7dcf96111df22::pool::flatness<T0>(arg0))
        };
        assert_slippage_lower_bound(v2, arg4);
        let v11 = *arg3;
        0xaca10f85b508736ebce633d33581b0c511cc1b098283dbd2a4c359cab8e66a84::vector::scale_mut_vector_128_64(&mut v11, v2);
        v11
    }

    public fun reorder_and_zero_out_empty_coins<T0>(arg0: &0xe11048f0dbebdae00779ca38c7c3f8959765e2572f9b77b607e7dcf96111df22::pool::Pool<T0>, arg1: &vector<0x1::ascii::String>, arg2: &vector<u128>) : vector<u128> {
        let v0 = 0xaca10f85b508736ebce633d33581b0c511cc1b098283dbd2a4c359cab8e66a84::vector::empty_vector_128(0xe11048f0dbebdae00779ca38c7c3f8959765e2572f9b77b607e7dcf96111df22::pool::size<T0>(arg0));
        let v1 = 0;
        while (v1 < 0x1::vector::length<0x1::ascii::String>(arg1)) {
            *0x1::vector::borrow_mut<u128>(&mut v0, 0xe11048f0dbebdae00779ca38c7c3f8959765e2572f9b77b607e7dcf96111df22::pool::type_name_to_index<T0>(arg0, *0x1::vector::borrow<0x1::ascii::String>(arg1, v1))) = *0x1::vector::borrow<u128>(arg2, v1);
            v1 = v1 + 1;
        };
        v0
    }

    public fun reorder_by_order_of_calling_function<T0>(arg0: &0xe11048f0dbebdae00779ca38c7c3f8959765e2572f9b77b607e7dcf96111df22::pool::Pool<T0>, arg1: &vector<0x1::ascii::String>, arg2: &vector<u128>) : vector<u128> {
        let v0 = 0xaca10f85b508736ebce633d33581b0c511cc1b098283dbd2a4c359cab8e66a84::vector::empty_vector_128(0x1::vector::length<0x1::ascii::String>(arg1));
        let v1 = 0;
        while (v1 < 0x1::vector::length<0x1::ascii::String>(arg1)) {
            let v2 = *0x1::vector::borrow<u128>(arg2, 0xe11048f0dbebdae00779ca38c7c3f8959765e2572f9b77b607e7dcf96111df22::pool::type_name_to_index<T0>(arg0, *0x1::vector::borrow<0x1::ascii::String>(arg1, v1)));
            assert!(v2 > 0, 54);
            *0x1::vector::borrow_mut<u128>(&mut v0, v1) = v2;
            v1 = v1 + 1;
        };
        v0
    }

    // decompiled from Move bytecode v6
}

