module 0x20a65e88af1067e992c08c3d739df5411f4f34de38a7073102a709ae0aa6057e::math {
    fun assert_max_swap_amount_invariant<T0>(arg0: &0x20a65e88af1067e992c08c3d739df5411f4f34de38a7073102a709ae0aa6057e::pool::Pool<T0>, arg1: &vector<0x1::ascii::String>, arg2: &vector<u64>, arg3: u64, arg4: u64) {
        let v0 = 0;
        while (v0 < 0x1::vector::length<u64>(arg2)) {
            assert!(0x11b955825d69f808589ef3bd86a653af1c7e3db4bda4455b0b081dfe5eff100c::fixed::div_by_fraction(*0x1::vector::borrow<u64>(arg2, v0), 0x20a65e88af1067e992c08c3d739df5411f4f34de38a7073102a709ae0aa6057e::pool::type_name_to_balance_value<T0>(arg0, *0x1::vector::borrow<0x1::ascii::String>(arg1, v0))) <= arg3, arg4);
            v0 = v0 + 1;
        };
    }

    fun assert_slippage_lower_bound(arg0: u64, arg1: u64) {
        assert!(arg0 >= 1000000000000000000 - arg1, 51);
    }

    fun assert_slippage_upper_bound(arg0: u64, arg1: u64) {
        assert!(arg0 <= 0x11b955825d69f808589ef3bd86a653af1c7e3db4bda4455b0b081dfe5eff100c::fixed::div_by_fraction(1000000000000000000, 1000000000000000000 - arg1), 51);
    }

    public fun calc_all_coin_deposit<T0>(arg0: &0x20a65e88af1067e992c08c3d739df5411f4f34de38a7073102a709ae0aa6057e::pool::Pool<T0>, arg1: &vector<0x1::ascii::String>, arg2: &vector<u64>) : (u64, vector<u64>) {
        let v0 = reorder_and_zero_out_empty_coins<T0>(arg0, arg1, arg2);
        let v1 = if (0x20a65e88af1067e992c08c3d739df5411f4f34de38a7073102a709ae0aa6057e::pool::flatness<T0>(arg0) == 0) {
            let v2 = 0x20a65e88af1067e992c08c3d739df5411f4f34de38a7073102a709ae0aa6057e::pool::balances<T0>(arg0);
            0x86ab16dfe4228f1a83e2d8f82f1e4e5b11a6e3c8c1bc12297592276b5badb90c::geometric_mean_calculations::calc_all_coin_deposit(&v2, &v0)
        } else {
            let v3 = 0x20a65e88af1067e992c08c3d739df5411f4f34de38a7073102a709ae0aa6057e::pool::balances<T0>(arg0);
            0x86ab16dfe4228f1a83e2d8f82f1e4e5b11a6e3c8c1bc12297592276b5badb90c::stable_calculations::calc_all_coin_deposit(&v3, &v0)
        };
        let v4 = 0x11b955825d69f808589ef3bd86a653af1c7e3db4bda4455b0b081dfe5eff100c::fixed::mul_by_fraction(0x20a65e88af1067e992c08c3d739df5411f4f34de38a7073102a709ae0aa6057e::pool::lp_supply_value<T0>(arg0), v1);
        assert!(v4 > 0, 56);
        let v5 = 0x20a65e88af1067e992c08c3d739df5411f4f34de38a7073102a709ae0aa6057e::pool::balances<T0>(arg0);
        0x11b955825d69f808589ef3bd86a653af1c7e3db4bda4455b0b081dfe5eff100c::vector::scale_mut_vector_64_64(&mut v5, v1);
        (v4, reorder_by_order_of_calling_function<T0>(arg0, arg1, &v5))
    }

    public fun calc_all_coin_withdraw<T0>(arg0: &0x20a65e88af1067e992c08c3d739df5411f4f34de38a7073102a709ae0aa6057e::pool::Pool<T0>, arg1: u64) : vector<u64> {
        let v0 = 0x11b955825d69f808589ef3bd86a653af1c7e3db4bda4455b0b081dfe5eff100c::fixed::div_by_fraction(arg1, 0x20a65e88af1067e992c08c3d739df5411f4f34de38a7073102a709ae0aa6057e::pool::lp_supply_value<T0>(arg0));
        assert!(v0 > 0, 57);
        let v1 = 0x20a65e88af1067e992c08c3d739df5411f4f34de38a7073102a709ae0aa6057e::pool::balances<T0>(arg0);
        0x11b955825d69f808589ef3bd86a653af1c7e3db4bda4455b0b081dfe5eff100c::vector::scale_mut_vector_64_64(&mut v1, v0);
        v1
    }

    public fun calc_deposit_exact_in<T0>(arg0: &0x20a65e88af1067e992c08c3d739df5411f4f34de38a7073102a709ae0aa6057e::pool::Pool<T0>, arg1: &vector<0x1::ascii::String>, arg2: &vector<u64>, arg3: u128, arg4: u64) : u64 {
        let v0 = reorder_and_zero_out_empty_coins<T0>(arg0, arg1, arg2);
        let v1 = if (0x20a65e88af1067e992c08c3d739df5411f4f34de38a7073102a709ae0aa6057e::pool::flatness<T0>(arg0) == 0) {
            let v2 = 0x20a65e88af1067e992c08c3d739df5411f4f34de38a7073102a709ae0aa6057e::pool::balances<T0>(arg0);
            let v3 = 0x20a65e88af1067e992c08c3d739df5411f4f34de38a7073102a709ae0aa6057e::pool::weights<T0>(arg0);
            let v4 = 0x20a65e88af1067e992c08c3d739df5411f4f34de38a7073102a709ae0aa6057e::pool::fees_swap_in<T0>(arg0);
            let v5 = 0x20a65e88af1067e992c08c3d739df5411f4f34de38a7073102a709ae0aa6057e::pool::fees_swap_out<T0>(arg0);
            0x86ab16dfe4228f1a83e2d8f82f1e4e5b11a6e3c8c1bc12297592276b5badb90c::geometric_mean_calculations::calc_deposit_fixed_amounts(&v2, &v3, &v4, &v5, &v0, arg3)
        } else {
            let v6 = 0x20a65e88af1067e992c08c3d739df5411f4f34de38a7073102a709ae0aa6057e::pool::balances<T0>(arg0);
            let v7 = 0x20a65e88af1067e992c08c3d739df5411f4f34de38a7073102a709ae0aa6057e::pool::weights<T0>(arg0);
            let v8 = 0x20a65e88af1067e992c08c3d739df5411f4f34de38a7073102a709ae0aa6057e::pool::fees_swap_in<T0>(arg0);
            let v9 = 0x20a65e88af1067e992c08c3d739df5411f4f34de38a7073102a709ae0aa6057e::pool::fees_swap_out<T0>(arg0);
            0x86ab16dfe4228f1a83e2d8f82f1e4e5b11a6e3c8c1bc12297592276b5badb90c::stable_calculations::calc_deposit_fixed_amounts(&v6, &v7, &v8, &v9, &v0, arg3, 0x20a65e88af1067e992c08c3d739df5411f4f34de38a7073102a709ae0aa6057e::pool::flatness<T0>(arg0))
        };
        assert_slippage_lower_bound(v1, arg4);
        let v10 = calc_lp_coins_to_mint_from_t(0x20a65e88af1067e992c08c3d739df5411f4f34de38a7073102a709ae0aa6057e::pool::lp_supply_value<T0>(arg0), 0x11b955825d69f808589ef3bd86a653af1c7e3db4bda4455b0b081dfe5eff100c::fixed::mul_by_fraction_64_128(v1, arg3));
        assert!(v10 > 0, 56);
        v10
    }

    public fun calc_invariant<T0>(arg0: &0x20a65e88af1067e992c08c3d739df5411f4f34de38a7073102a709ae0aa6057e::pool::Pool<T0>, arg1: &vector<u64>) : u64 {
        let v0 = if (0x20a65e88af1067e992c08c3d739df5411f4f34de38a7073102a709ae0aa6057e::pool::flatness<T0>(arg0) == 0) {
            let v1 = 0x20a65e88af1067e992c08c3d739df5411f4f34de38a7073102a709ae0aa6057e::pool::weights<T0>(arg0);
            0x86ab16dfe4228f1a83e2d8f82f1e4e5b11a6e3c8c1bc12297592276b5badb90c::geometric_mean_calculations::calc_invariant(arg1, &v1)
        } else {
            let v2 = 0x20a65e88af1067e992c08c3d739df5411f4f34de38a7073102a709ae0aa6057e::pool::weights<T0>(arg0);
            0x86ab16dfe4228f1a83e2d8f82f1e4e5b11a6e3c8c1bc12297592276b5badb90c::stable_calculations::calc_invariant(arg1, &v2, 0x20a65e88af1067e992c08c3d739df5411f4f34de38a7073102a709ae0aa6057e::pool::flatness<T0>(arg0))
        };
        assert!(v0 > 0, 51);
        v0
    }

    public fun calc_lp_coins_to_mint_from_t(arg0: u64, arg1: u64) : u64 {
        let v0 = 0x11b955825d69f808589ef3bd86a653af1c7e3db4bda4455b0b081dfe5eff100c::fixed::convert_balance9_to_fixed(arg0);
        0x11b955825d69f808589ef3bd86a653af1c7e3db4bda4455b0b081dfe5eff100c::fixed::convert_fixed_to_balance9(0x11b955825d69f808589ef3bd86a653af1c7e3db4bda4455b0b081dfe5eff100c::fixed::div_down(v0, (arg1 as u256)) - v0)
    }

    public fun calc_lp_ratio_after_burning_lp_coin(arg0: u64, arg1: u64) : u64 {
        0x11b955825d69f808589ef3bd86a653af1c7e3db4bda4455b0b081dfe5eff100c::fixed::div_by_fraction(arg0 - arg1, arg0)
    }

    public fun calc_multi_swap_exact_in<T0>(arg0: &0x20a65e88af1067e992c08c3d739df5411f4f34de38a7073102a709ae0aa6057e::pool::Pool<T0>, arg1: &vector<0x1::ascii::String>, arg2: &vector<u64>, arg3: &vector<0x1::ascii::String>, arg4: &vector<u64>, arg5: u64) : vector<u64> {
        assert_max_swap_amount_invariant<T0>(arg0, arg1, arg2, 300000000000000000, 52);
        let v0 = reorder_and_zero_out_empty_coins<T0>(arg0, arg1, arg2);
        let v1 = reorder_and_zero_out_empty_coins<T0>(arg0, arg3, arg4);
        let v2 = if (0x20a65e88af1067e992c08c3d739df5411f4f34de38a7073102a709ae0aa6057e::pool::flatness<T0>(arg0) == 0) {
            let v3 = 0x20a65e88af1067e992c08c3d739df5411f4f34de38a7073102a709ae0aa6057e::pool::balances<T0>(arg0);
            let v4 = 0x20a65e88af1067e992c08c3d739df5411f4f34de38a7073102a709ae0aa6057e::pool::weights<T0>(arg0);
            let v5 = 0x20a65e88af1067e992c08c3d739df5411f4f34de38a7073102a709ae0aa6057e::pool::fees_swap_in<T0>(arg0);
            let v6 = 0x20a65e88af1067e992c08c3d739df5411f4f34de38a7073102a709ae0aa6057e::pool::fees_swap_out<T0>(arg0);
            0x86ab16dfe4228f1a83e2d8f82f1e4e5b11a6e3c8c1bc12297592276b5badb90c::geometric_mean_calculations::calc_swap_fixed_in(&v3, &v4, &v5, &v6, &v0, &v1)
        } else {
            let v7 = 0x20a65e88af1067e992c08c3d739df5411f4f34de38a7073102a709ae0aa6057e::pool::balances<T0>(arg0);
            let v8 = 0x20a65e88af1067e992c08c3d739df5411f4f34de38a7073102a709ae0aa6057e::pool::weights<T0>(arg0);
            let v9 = 0x20a65e88af1067e992c08c3d739df5411f4f34de38a7073102a709ae0aa6057e::pool::fees_swap_in<T0>(arg0);
            let v10 = 0x20a65e88af1067e992c08c3d739df5411f4f34de38a7073102a709ae0aa6057e::pool::fees_swap_out<T0>(arg0);
            0x86ab16dfe4228f1a83e2d8f82f1e4e5b11a6e3c8c1bc12297592276b5badb90c::stable_calculations::calc_swap_fixed_in(&v7, &v8, &v9, &v10, &v0, &v1, 0x20a65e88af1067e992c08c3d739df5411f4f34de38a7073102a709ae0aa6057e::pool::flatness<T0>(arg0))
        };
        assert_slippage_lower_bound(v2, arg5);
        let v11 = *arg4;
        0x11b955825d69f808589ef3bd86a653af1c7e3db4bda4455b0b081dfe5eff100c::vector::scale_mut_vector_64_64(&mut v11, v2);
        assert_max_swap_amount_invariant<T0>(arg0, arg3, &v11, 300000000000000000, 53);
        v11
    }

    public fun calc_multi_swap_exact_out<T0>(arg0: &0x20a65e88af1067e992c08c3d739df5411f4f34de38a7073102a709ae0aa6057e::pool::Pool<T0>, arg1: &vector<0x1::ascii::String>, arg2: &vector<u64>, arg3: &vector<0x1::ascii::String>, arg4: &vector<u64>, arg5: u64) : vector<u64> {
        assert_max_swap_amount_invariant<T0>(arg0, arg3, arg4, 300000000000000000, 53);
        let v0 = reorder_and_zero_out_empty_coins<T0>(arg0, arg1, arg2);
        let v1 = reorder_and_zero_out_empty_coins<T0>(arg0, arg3, arg4);
        let v2 = if (0x20a65e88af1067e992c08c3d739df5411f4f34de38a7073102a709ae0aa6057e::pool::flatness<T0>(arg0) == 0) {
            let v3 = 0x20a65e88af1067e992c08c3d739df5411f4f34de38a7073102a709ae0aa6057e::pool::balances<T0>(arg0);
            let v4 = 0x20a65e88af1067e992c08c3d739df5411f4f34de38a7073102a709ae0aa6057e::pool::weights<T0>(arg0);
            let v5 = 0x20a65e88af1067e992c08c3d739df5411f4f34de38a7073102a709ae0aa6057e::pool::fees_swap_in<T0>(arg0);
            let v6 = 0x20a65e88af1067e992c08c3d739df5411f4f34de38a7073102a709ae0aa6057e::pool::fees_swap_out<T0>(arg0);
            0x86ab16dfe4228f1a83e2d8f82f1e4e5b11a6e3c8c1bc12297592276b5badb90c::geometric_mean_calculations::calc_swap_fixed_out(&v3, &v4, &v5, &v6, &v0, &v1)
        } else {
            let v7 = 0x20a65e88af1067e992c08c3d739df5411f4f34de38a7073102a709ae0aa6057e::pool::balances<T0>(arg0);
            let v8 = 0x20a65e88af1067e992c08c3d739df5411f4f34de38a7073102a709ae0aa6057e::pool::weights<T0>(arg0);
            let v9 = 0x20a65e88af1067e992c08c3d739df5411f4f34de38a7073102a709ae0aa6057e::pool::fees_swap_in<T0>(arg0);
            let v10 = 0x20a65e88af1067e992c08c3d739df5411f4f34de38a7073102a709ae0aa6057e::pool::fees_swap_out<T0>(arg0);
            0x86ab16dfe4228f1a83e2d8f82f1e4e5b11a6e3c8c1bc12297592276b5badb90c::stable_calculations::calc_swap_fixed_out(&v7, &v8, &v9, &v10, &v0, &v1, 0x20a65e88af1067e992c08c3d739df5411f4f34de38a7073102a709ae0aa6057e::pool::flatness<T0>(arg0))
        };
        assert_slippage_upper_bound(v2, arg5);
        0x11b955825d69f808589ef3bd86a653af1c7e3db4bda4455b0b081dfe5eff100c::vector::scale_mut_vector_64_64(&mut v0, v2);
        assert_max_swap_amount_invariant<T0>(arg0, arg1, &v0, 300000000000000000, 52);
        v0
    }

    public fun calc_oracle_price<T0, T1, T2>(arg0: &0x20a65e88af1067e992c08c3d739df5411f4f34de38a7073102a709ae0aa6057e::pool::Pool<T0>) : u128 {
        if (0x20a65e88af1067e992c08c3d739df5411f4f34de38a7073102a709ae0aa6057e::pool::flatness<T0>(arg0) == 0) {
            0x86ab16dfe4228f1a83e2d8f82f1e4e5b11a6e3c8c1bc12297592276b5badb90c::geometric_mean_calculations::calc_spot_price(0x20a65e88af1067e992c08c3d739df5411f4f34de38a7073102a709ae0aa6057e::pool::balance_of<T0, T2>(arg0), 0x20a65e88af1067e992c08c3d739df5411f4f34de38a7073102a709ae0aa6057e::pool::balance_of<T0, T1>(arg0), 0x20a65e88af1067e992c08c3d739df5411f4f34de38a7073102a709ae0aa6057e::pool::weight_of<T0, T2>(arg0), 0x20a65e88af1067e992c08c3d739df5411f4f34de38a7073102a709ae0aa6057e::pool::weight_of<T0, T1>(arg0))
        } else {
            let v1 = 0x20a65e88af1067e992c08c3d739df5411f4f34de38a7073102a709ae0aa6057e::pool::balances<T0>(arg0);
            let v2 = 0x20a65e88af1067e992c08c3d739df5411f4f34de38a7073102a709ae0aa6057e::pool::weights<T0>(arg0);
            0x86ab16dfe4228f1a83e2d8f82f1e4e5b11a6e3c8c1bc12297592276b5badb90c::stable_calculations::calc_spot_price(&v1, &v2, 0x20a65e88af1067e992c08c3d739df5411f4f34de38a7073102a709ae0aa6057e::pool::type_to_index<T0, T2>(arg0), 0x20a65e88af1067e992c08c3d739df5411f4f34de38a7073102a709ae0aa6057e::pool::type_to_index<T0, T1>(arg0), 0x20a65e88af1067e992c08c3d739df5411f4f34de38a7073102a709ae0aa6057e::pool::flatness<T0>(arg0))
        }
    }

    public fun calc_spot_price<T0, T1, T2>(arg0: &0x20a65e88af1067e992c08c3d739df5411f4f34de38a7073102a709ae0aa6057e::pool::Pool<T0>) : u128 {
        if (0x20a65e88af1067e992c08c3d739df5411f4f34de38a7073102a709ae0aa6057e::pool::flatness<T0>(arg0) == 0) {
            0x86ab16dfe4228f1a83e2d8f82f1e4e5b11a6e3c8c1bc12297592276b5badb90c::geometric_mean_calculations::calc_spot_price_with_fees(0x20a65e88af1067e992c08c3d739df5411f4f34de38a7073102a709ae0aa6057e::pool::balance_of<T0, T2>(arg0), 0x20a65e88af1067e992c08c3d739df5411f4f34de38a7073102a709ae0aa6057e::pool::balance_of<T0, T1>(arg0), 0x20a65e88af1067e992c08c3d739df5411f4f34de38a7073102a709ae0aa6057e::pool::weight_of<T0, T2>(arg0), 0x20a65e88af1067e992c08c3d739df5411f4f34de38a7073102a709ae0aa6057e::pool::weight_of<T0, T1>(arg0), 0x20a65e88af1067e992c08c3d739df5411f4f34de38a7073102a709ae0aa6057e::pool::fees_swap_in_for<T0, T2>(arg0), 0x20a65e88af1067e992c08c3d739df5411f4f34de38a7073102a709ae0aa6057e::pool::fees_swap_out_for<T0, T1>(arg0))
        } else {
            let v1 = 0x20a65e88af1067e992c08c3d739df5411f4f34de38a7073102a709ae0aa6057e::pool::balances<T0>(arg0);
            let v2 = 0x20a65e88af1067e992c08c3d739df5411f4f34de38a7073102a709ae0aa6057e::pool::weights<T0>(arg0);
            0x86ab16dfe4228f1a83e2d8f82f1e4e5b11a6e3c8c1bc12297592276b5badb90c::stable_calculations::calc_spot_price_with_fees(&v1, &v2, 0x20a65e88af1067e992c08c3d739df5411f4f34de38a7073102a709ae0aa6057e::pool::fees_swap_in_for<T0, T2>(arg0), 0x20a65e88af1067e992c08c3d739df5411f4f34de38a7073102a709ae0aa6057e::pool::fees_swap_out_for<T0, T1>(arg0), 0x20a65e88af1067e992c08c3d739df5411f4f34de38a7073102a709ae0aa6057e::pool::type_to_index<T0, T2>(arg0), 0x20a65e88af1067e992c08c3d739df5411f4f34de38a7073102a709ae0aa6057e::pool::type_to_index<T0, T1>(arg0), 0x20a65e88af1067e992c08c3d739df5411f4f34de38a7073102a709ae0aa6057e::pool::flatness<T0>(arg0))
        }
    }

    public fun calc_swap_exact_in<T0, T1, T2>(arg0: &0x20a65e88af1067e992c08c3d739df5411f4f34de38a7073102a709ae0aa6057e::pool::Pool<T0>, arg1: u64, arg2: u64, arg3: u64) : u64 {
        assert!(0x11b955825d69f808589ef3bd86a653af1c7e3db4bda4455b0b081dfe5eff100c::fixed::div_by_fraction(arg1, 0x20a65e88af1067e992c08c3d739df5411f4f34de38a7073102a709ae0aa6057e::pool::balance_of<T0, T1>(arg0)) <= 300000000000000000, 52);
        let v0 = if (0x20a65e88af1067e992c08c3d739df5411f4f34de38a7073102a709ae0aa6057e::pool::flatness<T0>(arg0) == 0) {
            0x86ab16dfe4228f1a83e2d8f82f1e4e5b11a6e3c8c1bc12297592276b5badb90c::geometric_mean_calculations::calc_out_given_in(0x20a65e88af1067e992c08c3d739df5411f4f34de38a7073102a709ae0aa6057e::pool::balance_of<T0, T1>(arg0), 0x20a65e88af1067e992c08c3d739df5411f4f34de38a7073102a709ae0aa6057e::pool::balance_of<T0, T2>(arg0), 0x20a65e88af1067e992c08c3d739df5411f4f34de38a7073102a709ae0aa6057e::pool::weight_of<T0, T1>(arg0), 0x20a65e88af1067e992c08c3d739df5411f4f34de38a7073102a709ae0aa6057e::pool::weight_of<T0, T2>(arg0), 0x20a65e88af1067e992c08c3d739df5411f4f34de38a7073102a709ae0aa6057e::pool::fees_swap_in_for<T0, T1>(arg0), 0x20a65e88af1067e992c08c3d739df5411f4f34de38a7073102a709ae0aa6057e::pool::fees_swap_out_for<T0, T2>(arg0), arg1, arg2)
        } else {
            let v1 = 0x20a65e88af1067e992c08c3d739df5411f4f34de38a7073102a709ae0aa6057e::pool::balances<T0>(arg0);
            let v2 = 0x20a65e88af1067e992c08c3d739df5411f4f34de38a7073102a709ae0aa6057e::pool::weights<T0>(arg0);
            0x86ab16dfe4228f1a83e2d8f82f1e4e5b11a6e3c8c1bc12297592276b5badb90c::stable_calculations::calc_out_given_in(&v1, &v2, 0x20a65e88af1067e992c08c3d739df5411f4f34de38a7073102a709ae0aa6057e::pool::fees_swap_in_for<T0, T1>(arg0), 0x20a65e88af1067e992c08c3d739df5411f4f34de38a7073102a709ae0aa6057e::pool::fees_swap_out_for<T0, T2>(arg0), 0x20a65e88af1067e992c08c3d739df5411f4f34de38a7073102a709ae0aa6057e::pool::type_to_index<T0, T1>(arg0), 0x20a65e88af1067e992c08c3d739df5411f4f34de38a7073102a709ae0aa6057e::pool::type_to_index<T0, T2>(arg0), arg1, arg2, 0x20a65e88af1067e992c08c3d739df5411f4f34de38a7073102a709ae0aa6057e::pool::flatness<T0>(arg0))
        };
        assert_slippage_lower_bound(v0, arg3);
        let v3 = 0x11b955825d69f808589ef3bd86a653af1c7e3db4bda4455b0b081dfe5eff100c::fixed::mul_by_fraction(arg2, v0);
        assert!(v3 > 0, 55);
        assert!(0x11b955825d69f808589ef3bd86a653af1c7e3db4bda4455b0b081dfe5eff100c::fixed::div_by_fraction(v3, 0x20a65e88af1067e992c08c3d739df5411f4f34de38a7073102a709ae0aa6057e::pool::balance_of<T0, T2>(arg0)) <= 300000000000000000, 53);
        v3
    }

    public fun calc_swap_exact_out<T0, T1, T2>(arg0: &0x20a65e88af1067e992c08c3d739df5411f4f34de38a7073102a709ae0aa6057e::pool::Pool<T0>, arg1: u64, arg2: u64, arg3: u64) : u64 {
        assert!(0x11b955825d69f808589ef3bd86a653af1c7e3db4bda4455b0b081dfe5eff100c::fixed::div_by_fraction(arg2, 0x20a65e88af1067e992c08c3d739df5411f4f34de38a7073102a709ae0aa6057e::pool::balance_of<T0, T2>(arg0)) <= 300000000000000000, 53);
        let v0 = if (0x20a65e88af1067e992c08c3d739df5411f4f34de38a7073102a709ae0aa6057e::pool::flatness<T0>(arg0) == 0) {
            0x86ab16dfe4228f1a83e2d8f82f1e4e5b11a6e3c8c1bc12297592276b5badb90c::geometric_mean_calculations::calc_in_given_out(0x20a65e88af1067e992c08c3d739df5411f4f34de38a7073102a709ae0aa6057e::pool::balance_of<T0, T1>(arg0), 0x20a65e88af1067e992c08c3d739df5411f4f34de38a7073102a709ae0aa6057e::pool::balance_of<T0, T2>(arg0), 0x20a65e88af1067e992c08c3d739df5411f4f34de38a7073102a709ae0aa6057e::pool::weight_of<T0, T1>(arg0), 0x20a65e88af1067e992c08c3d739df5411f4f34de38a7073102a709ae0aa6057e::pool::weight_of<T0, T2>(arg0), 0x20a65e88af1067e992c08c3d739df5411f4f34de38a7073102a709ae0aa6057e::pool::fees_swap_in_for<T0, T1>(arg0), 0x20a65e88af1067e992c08c3d739df5411f4f34de38a7073102a709ae0aa6057e::pool::fees_swap_out_for<T0, T2>(arg0), arg1, arg2)
        } else {
            let v1 = 0x20a65e88af1067e992c08c3d739df5411f4f34de38a7073102a709ae0aa6057e::pool::balances<T0>(arg0);
            let v2 = 0x20a65e88af1067e992c08c3d739df5411f4f34de38a7073102a709ae0aa6057e::pool::weights<T0>(arg0);
            0x86ab16dfe4228f1a83e2d8f82f1e4e5b11a6e3c8c1bc12297592276b5badb90c::stable_calculations::calc_in_given_out(&v1, &v2, 0x20a65e88af1067e992c08c3d739df5411f4f34de38a7073102a709ae0aa6057e::pool::type_to_index<T0, T1>(arg0), 0x20a65e88af1067e992c08c3d739df5411f4f34de38a7073102a709ae0aa6057e::pool::type_to_index<T0, T2>(arg0), 0x20a65e88af1067e992c08c3d739df5411f4f34de38a7073102a709ae0aa6057e::pool::fees_swap_in_for<T0, T1>(arg0), 0x20a65e88af1067e992c08c3d739df5411f4f34de38a7073102a709ae0aa6057e::pool::fees_swap_out_for<T0, T2>(arg0), arg1, arg2, 0x20a65e88af1067e992c08c3d739df5411f4f34de38a7073102a709ae0aa6057e::pool::flatness<T0>(arg0))
        };
        assert_slippage_upper_bound(v0, arg3);
        let v3 = 0x11b955825d69f808589ef3bd86a653af1c7e3db4bda4455b0b081dfe5eff100c::fixed::mul_by_fraction(arg1, v0);
        assert!(v3 > 0, 54);
        assert!(0x11b955825d69f808589ef3bd86a653af1c7e3db4bda4455b0b081dfe5eff100c::fixed::div_by_fraction(v3, 0x20a65e88af1067e992c08c3d739df5411f4f34de38a7073102a709ae0aa6057e::pool::balance_of<T0, T1>(arg0)) <= 300000000000000000, 52);
        v3
    }

    public fun calc_withdraw_exact_lp<T0>(arg0: &0x20a65e88af1067e992c08c3d739df5411f4f34de38a7073102a709ae0aa6057e::pool::Pool<T0>, arg1: &vector<0x1::ascii::String>, arg2: u64, arg3: &vector<u64>, arg4: u64) : vector<u64> {
        let v0 = (calc_lp_ratio_after_burning_lp_coin(0x20a65e88af1067e992c08c3d739df5411f4f34de38a7073102a709ae0aa6057e::pool::lp_supply_value<T0>(arg0), arg2) as u128);
        assert!(v0 > 0, 57);
        let v1 = reorder_and_zero_out_empty_coins<T0>(arg0, arg1, arg3);
        let v2 = if (0x20a65e88af1067e992c08c3d739df5411f4f34de38a7073102a709ae0aa6057e::pool::flatness<T0>(arg0) == 0) {
            let v3 = 0x20a65e88af1067e992c08c3d739df5411f4f34de38a7073102a709ae0aa6057e::pool::balances<T0>(arg0);
            let v4 = 0x20a65e88af1067e992c08c3d739df5411f4f34de38a7073102a709ae0aa6057e::pool::weights<T0>(arg0);
            let v5 = 0x20a65e88af1067e992c08c3d739df5411f4f34de38a7073102a709ae0aa6057e::pool::fees_swap_in<T0>(arg0);
            let v6 = 0x20a65e88af1067e992c08c3d739df5411f4f34de38a7073102a709ae0aa6057e::pool::fees_swap_out<T0>(arg0);
            0x86ab16dfe4228f1a83e2d8f82f1e4e5b11a6e3c8c1bc12297592276b5badb90c::geometric_mean_calculations::calc_withdraw_flp_amounts_out(&v3, &v4, &v5, &v6, &v1, v0)
        } else {
            let v7 = 0x20a65e88af1067e992c08c3d739df5411f4f34de38a7073102a709ae0aa6057e::pool::balances<T0>(arg0);
            let v8 = 0x20a65e88af1067e992c08c3d739df5411f4f34de38a7073102a709ae0aa6057e::pool::weights<T0>(arg0);
            let v9 = 0x20a65e88af1067e992c08c3d739df5411f4f34de38a7073102a709ae0aa6057e::pool::fees_swap_in<T0>(arg0);
            let v10 = 0x20a65e88af1067e992c08c3d739df5411f4f34de38a7073102a709ae0aa6057e::pool::fees_swap_out<T0>(arg0);
            0x86ab16dfe4228f1a83e2d8f82f1e4e5b11a6e3c8c1bc12297592276b5badb90c::stable_calculations::calc_withdraw_flp_amounts_out(&v7, &v8, &v9, &v10, &v1, v0, 0x20a65e88af1067e992c08c3d739df5411f4f34de38a7073102a709ae0aa6057e::pool::flatness<T0>(arg0))
        };
        assert_slippage_lower_bound(v2, arg4);
        let v11 = *arg3;
        0x11b955825d69f808589ef3bd86a653af1c7e3db4bda4455b0b081dfe5eff100c::vector::scale_mut_vector_64_64(&mut v11, v2);
        v11
    }

    public fun reorder_and_zero_out_empty_coins<T0>(arg0: &0x20a65e88af1067e992c08c3d739df5411f4f34de38a7073102a709ae0aa6057e::pool::Pool<T0>, arg1: &vector<0x1::ascii::String>, arg2: &vector<u64>) : vector<u64> {
        let v0 = 0x11b955825d69f808589ef3bd86a653af1c7e3db4bda4455b0b081dfe5eff100c::vector::empty_vector(0x20a65e88af1067e992c08c3d739df5411f4f34de38a7073102a709ae0aa6057e::pool::size<T0>(arg0));
        let v1 = 0;
        while (v1 < 0x1::vector::length<0x1::ascii::String>(arg1)) {
            *0x1::vector::borrow_mut<u64>(&mut v0, 0x20a65e88af1067e992c08c3d739df5411f4f34de38a7073102a709ae0aa6057e::pool::type_name_to_index<T0>(arg0, *0x1::vector::borrow<0x1::ascii::String>(arg1, v1))) = *0x1::vector::borrow<u64>(arg2, v1);
            v1 = v1 + 1;
        };
        v0
    }

    public fun reorder_by_order_of_calling_function<T0>(arg0: &0x20a65e88af1067e992c08c3d739df5411f4f34de38a7073102a709ae0aa6057e::pool::Pool<T0>, arg1: &vector<0x1::ascii::String>, arg2: &vector<u64>) : vector<u64> {
        let v0 = 0x11b955825d69f808589ef3bd86a653af1c7e3db4bda4455b0b081dfe5eff100c::vector::empty_vector(0x1::vector::length<0x1::ascii::String>(arg1));
        let v1 = 0;
        while (v1 < 0x1::vector::length<0x1::ascii::String>(arg1)) {
            let v2 = *0x1::vector::borrow<u64>(arg2, 0x20a65e88af1067e992c08c3d739df5411f4f34de38a7073102a709ae0aa6057e::pool::type_name_to_index<T0>(arg0, *0x1::vector::borrow<0x1::ascii::String>(arg1, v1)));
            assert!(v2 > 0, 54);
            *0x1::vector::borrow_mut<u64>(&mut v0, v1) = v2;
            v1 = v1 + 1;
        };
        v0
    }

    // decompiled from Move bytecode v6
}

