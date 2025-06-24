module 0x9adc2caf7a827f1e05a76bf6cafb2bf7c8ebc30a27ff407b27b0cf03e9ddd183::lb_quoter {
    struct FetchQuoteEvent has copy, drop {
        route: vector<0x1::type_name::TypeName>,
        pair_ids: vector<0x2::object::ID>,
        bin_steps: vector<u16>,
        amounts: vector<u128>,
        virtual_amounts_without_slippage: vector<u128>,
        fees: vector<u128>,
    }

    struct PairQuote has copy, drop {
        pair_id: 0x2::object::ID,
        bin_step: u16,
        amount_out: u128,
        amount_in: u128,
        fee: u128,
        virtual_amount: u128,
    }

    struct FetchPairQuoteEvent has copy, drop {
        quotes: vector<PairQuote>,
    }

    public fun calculate_fee_percentage(arg0: u128, arg1: u128) : u128 {
        if (arg1 == 0) {
            return 0
        };
        0x9adc2caf7a827f1e05a76bf6cafb2bf7c8ebc30a27ff407b27b0cf03e9ddd183::safe_math::safe128((arg0 as u256) * 1000000000000000000 / (arg1 as u256))
    }

    fun calculate_virtual_amount(arg0: u256, arg1: u32, arg2: u16, arg3: bool) : u128 {
        if (arg3) {
            0x9adc2caf7a827f1e05a76bf6cafb2bf7c8ebc30a27ff407b27b0cf03e9ddd183::safe_math::safe128(0x9adc2caf7a827f1e05a76bf6cafb2bf7c8ebc30a27ff407b27b0cf03e9ddd183::uint256x256_math::mul_shift_round_down(arg0, 0x9adc2caf7a827f1e05a76bf6cafb2bf7c8ebc30a27ff407b27b0cf03e9ddd183::price_helper::get_price_from_id(arg1, arg2), 0x9adc2caf7a827f1e05a76bf6cafb2bf7c8ebc30a27ff407b27b0cf03e9ddd183::constants::scale_offset()))
        } else {
            0x9adc2caf7a827f1e05a76bf6cafb2bf7c8ebc30a27ff407b27b0cf03e9ddd183::safe_math::safe128(0x9adc2caf7a827f1e05a76bf6cafb2bf7c8ebc30a27ff407b27b0cf03e9ddd183::uint256x256_math::shift_div_round_down(arg0, 0x9adc2caf7a827f1e05a76bf6cafb2bf7c8ebc30a27ff407b27b0cf03e9ddd183::constants::scale_offset(), 0x9adc2caf7a827f1e05a76bf6cafb2bf7c8ebc30a27ff407b27b0cf03e9ddd183::price_helper::get_price_from_id(arg1, arg2)))
        }
    }

    public fun find_best_pair_for_tokens<T0, T1>(arg0: &0x9adc2caf7a827f1e05a76bf6cafb2bf7c8ebc30a27ff407b27b0cf03e9ddd183::lb_factory::LBFactory) : (0x2::object::ID, u16) {
        let v0 = 0x9adc2caf7a827f1e05a76bf6cafb2bf7c8ebc30a27ff407b27b0cf03e9ddd183::lb_factory::get_all_lb_pairs<T0, T1>(arg0);
        let v1 = 0x2::object::id_from_address(@0x0);
        let v2 = 0;
        let v3 = 0;
        while (v3 < 0x1::vector::length<0x9adc2caf7a827f1e05a76bf6cafb2bf7c8ebc30a27ff407b27b0cf03e9ddd183::lb_factory::LBPairInformation>(&v0)) {
            let v4 = 0x1::vector::borrow<0x9adc2caf7a827f1e05a76bf6cafb2bf7c8ebc30a27ff407b27b0cf03e9ddd183::lb_factory::LBPairInformation>(&v0, v3);
            if (0x9adc2caf7a827f1e05a76bf6cafb2bf7c8ebc30a27ff407b27b0cf03e9ddd183::lb_factory::get_pair_info_id(v4) != 0x2::object::id_from_address(@0x0) && !0x9adc2caf7a827f1e05a76bf6cafb2bf7c8ebc30a27ff407b27b0cf03e9ddd183::lb_factory::is_pair_ignored(v4)) {
                if (v1 == 0x2::object::id_from_address(@0x0) || 0x9adc2caf7a827f1e05a76bf6cafb2bf7c8ebc30a27ff407b27b0cf03e9ddd183::lb_factory::get_pair_info_bin_step(v4) < v2) {
                    v1 = 0x9adc2caf7a827f1e05a76bf6cafb2bf7c8ebc30a27ff407b27b0cf03e9ddd183::lb_factory::get_pair_info_id(v4);
                    v2 = 0x9adc2caf7a827f1e05a76bf6cafb2bf7c8ebc30a27ff407b27b0cf03e9ddd183::lb_factory::get_pair_info_bin_step(v4);
                };
            };
            v3 = v3 + 1;
        };
        (v1, v2)
    }

    public fun find_best_path_from_amount_in<T0, T1>(arg0: &0x9adc2caf7a827f1e05a76bf6cafb2bf7c8ebc30a27ff407b27b0cf03e9ddd183::lb_factory::LBFactory, arg1: u128) {
        let v0 = 0x1::vector::empty<0x1::type_name::TypeName>();
        0x1::vector::push_back<0x1::type_name::TypeName>(&mut v0, 0x1::type_name::get<T0>());
        0x1::vector::push_back<0x1::type_name::TypeName>(&mut v0, 0x1::type_name::get<T1>());
        let v1 = 0x9adc2caf7a827f1e05a76bf6cafb2bf7c8ebc30a27ff407b27b0cf03e9ddd183::lb_factory::get_all_lb_pairs<T0, T1>(arg0);
        let v2 = 0x2::object::id_from_address(@0x0);
        let v3 = 0;
        let v4 = 0;
        let v5 = 0;
        let v6 = 0;
        let v7 = 0;
        while (v7 < 0x1::vector::length<0x9adc2caf7a827f1e05a76bf6cafb2bf7c8ebc30a27ff407b27b0cf03e9ddd183::lb_factory::LBPairInformation>(&v1)) {
            let v8 = 0x1::vector::borrow<0x9adc2caf7a827f1e05a76bf6cafb2bf7c8ebc30a27ff407b27b0cf03e9ddd183::lb_factory::LBPairInformation>(&v1, v7);
            if (0x9adc2caf7a827f1e05a76bf6cafb2bf7c8ebc30a27ff407b27b0cf03e9ddd183::lb_factory::get_pair_info_id(v8) != 0x2::object::id_from_address(@0x0) && !0x9adc2caf7a827f1e05a76bf6cafb2bf7c8ebc30a27ff407b27b0cf03e9ddd183::lb_factory::is_pair_ignored(v8)) {
                if (v2 == 0x2::object::id_from_address(@0x0)) {
                    v2 = 0x9adc2caf7a827f1e05a76bf6cafb2bf7c8ebc30a27ff407b27b0cf03e9ddd183::lb_factory::get_pair_info_id(v8);
                    let v9 = 0x9adc2caf7a827f1e05a76bf6cafb2bf7c8ebc30a27ff407b27b0cf03e9ddd183::lb_factory::get_pair_info_bin_step(v8);
                    v3 = v9;
                    let v10 = arg1 * 3000 / 1000000;
                    v5 = v10;
                    v4 = arg1 - v10;
                    v6 = calculate_virtual_amount(((arg1 - v10) as u256), 8388608, v9, true);
                };
            };
            v7 = v7 + 1;
        };
        let v11 = 0x1::vector::empty<0x2::object::ID>();
        let v12 = 0x1::vector::empty<u16>();
        let v13 = 0x1::vector::empty<u128>();
        let v14 = 0x1::vector::empty<u128>();
        let v15 = 0x1::vector::empty<u128>();
        if (v2 != 0x2::object::id_from_address(@0x0)) {
            0x1::vector::push_back<0x2::object::ID>(&mut v11, v2);
            0x1::vector::push_back<u16>(&mut v12, v3);
            0x1::vector::push_back<u128>(&mut v15, v5);
            0x1::vector::push_back<u128>(&mut v13, arg1);
            0x1::vector::push_back<u128>(&mut v13, v4);
            0x1::vector::push_back<u128>(&mut v14, arg1);
            0x1::vector::push_back<u128>(&mut v14, v6);
        } else {
            0x1::vector::push_back<u128>(&mut v13, arg1);
            0x1::vector::push_back<u128>(&mut v13, 0);
            0x1::vector::push_back<u128>(&mut v14, arg1);
            0x1::vector::push_back<u128>(&mut v14, 0);
        };
        let v16 = FetchQuoteEvent{
            route                            : v0,
            pair_ids                         : v11,
            bin_steps                        : v12,
            amounts                          : v13,
            virtual_amounts_without_slippage : v14,
            fees                             : v15,
        };
        0x2::event::emit<FetchQuoteEvent>(v16);
    }

    public fun find_best_path_from_amount_out<T0, T1>(arg0: &0x9adc2caf7a827f1e05a76bf6cafb2bf7c8ebc30a27ff407b27b0cf03e9ddd183::lb_factory::LBFactory, arg1: u128) {
        let v0 = 0x1::vector::empty<0x1::type_name::TypeName>();
        0x1::vector::push_back<0x1::type_name::TypeName>(&mut v0, 0x1::type_name::get<T0>());
        0x1::vector::push_back<0x1::type_name::TypeName>(&mut v0, 0x1::type_name::get<T1>());
        let v1 = 0x9adc2caf7a827f1e05a76bf6cafb2bf7c8ebc30a27ff407b27b0cf03e9ddd183::lb_factory::get_all_lb_pairs<T0, T1>(arg0);
        let v2 = 0x2::object::id_from_address(@0x0);
        let v3 = 0;
        let v4 = 0;
        let v5 = 0;
        let v6 = 0;
        let v7 = 0;
        while (v7 < 0x1::vector::length<0x9adc2caf7a827f1e05a76bf6cafb2bf7c8ebc30a27ff407b27b0cf03e9ddd183::lb_factory::LBPairInformation>(&v1)) {
            let v8 = 0x1::vector::borrow<0x9adc2caf7a827f1e05a76bf6cafb2bf7c8ebc30a27ff407b27b0cf03e9ddd183::lb_factory::LBPairInformation>(&v1, v7);
            if (0x9adc2caf7a827f1e05a76bf6cafb2bf7c8ebc30a27ff407b27b0cf03e9ddd183::lb_factory::get_pair_info_id(v8) != 0x2::object::id_from_address(@0x0) && !0x9adc2caf7a827f1e05a76bf6cafb2bf7c8ebc30a27ff407b27b0cf03e9ddd183::lb_factory::is_pair_ignored(v8)) {
                if (v2 == 0x2::object::id_from_address(@0x0)) {
                    v2 = 0x9adc2caf7a827f1e05a76bf6cafb2bf7c8ebc30a27ff407b27b0cf03e9ddd183::lb_factory::get_pair_info_id(v8);
                    let v9 = 0x9adc2caf7a827f1e05a76bf6cafb2bf7c8ebc30a27ff407b27b0cf03e9ddd183::lb_factory::get_pair_info_bin_step(v8);
                    v3 = v9;
                    let v10 = arg1 * 1000000 / 997000;
                    v4 = v10;
                    let v11 = v10 - arg1;
                    v5 = v11;
                    v6 = calculate_virtual_amount((arg1 as u256), 8388608, v9, false) + v11;
                };
            };
            v7 = v7 + 1;
        };
        let v12 = 0x1::vector::empty<0x2::object::ID>();
        let v13 = 0x1::vector::empty<u16>();
        let v14 = 0x1::vector::empty<u128>();
        let v15 = 0x1::vector::empty<u128>();
        let v16 = 0x1::vector::empty<u128>();
        if (v2 != 0x2::object::id_from_address(@0x0)) {
            0x1::vector::push_back<0x2::object::ID>(&mut v12, v2);
            0x1::vector::push_back<u16>(&mut v13, v3);
            0x1::vector::push_back<u128>(&mut v16, v5);
            0x1::vector::push_back<u128>(&mut v14, v4);
            0x1::vector::push_back<u128>(&mut v14, arg1);
            0x1::vector::push_back<u128>(&mut v15, v6);
            0x1::vector::push_back<u128>(&mut v15, arg1);
        } else {
            0x1::vector::push_back<u128>(&mut v14, 0);
            0x1::vector::push_back<u128>(&mut v14, arg1);
            0x1::vector::push_back<u128>(&mut v15, 0);
            0x1::vector::push_back<u128>(&mut v15, arg1);
        };
        let v17 = FetchQuoteEvent{
            route                            : v0,
            pair_ids                         : v12,
            bin_steps                        : v13,
            amounts                          : v14,
            virtual_amounts_without_slippage : v15,
            fees                             : v16,
        };
        0x2::event::emit<FetchQuoteEvent>(v17);
    }

    public fun get_all_quotes_for_pair<T0, T1>(arg0: &0x9adc2caf7a827f1e05a76bf6cafb2bf7c8ebc30a27ff407b27b0cf03e9ddd183::lb_factory::LBFactory) {
        let v0 = 0x9adc2caf7a827f1e05a76bf6cafb2bf7c8ebc30a27ff407b27b0cf03e9ddd183::lb_factory::get_all_lb_pairs<T0, T1>(arg0);
        let v1 = 0x1::vector::empty<PairQuote>();
        let v2 = 0;
        while (v2 < 0x1::vector::length<0x9adc2caf7a827f1e05a76bf6cafb2bf7c8ebc30a27ff407b27b0cf03e9ddd183::lb_factory::LBPairInformation>(&v0)) {
            let v3 = 0x1::vector::borrow<0x9adc2caf7a827f1e05a76bf6cafb2bf7c8ebc30a27ff407b27b0cf03e9ddd183::lb_factory::LBPairInformation>(&v0, v2);
            if (0x9adc2caf7a827f1e05a76bf6cafb2bf7c8ebc30a27ff407b27b0cf03e9ddd183::lb_factory::get_pair_info_id(v3) != 0x2::object::id_from_address(@0x0) && !0x9adc2caf7a827f1e05a76bf6cafb2bf7c8ebc30a27ff407b27b0cf03e9ddd183::lb_factory::is_pair_ignored(v3)) {
                let v4 = PairQuote{
                    pair_id        : 0x9adc2caf7a827f1e05a76bf6cafb2bf7c8ebc30a27ff407b27b0cf03e9ddd183::lb_factory::get_pair_info_id(v3),
                    bin_step       : 0x9adc2caf7a827f1e05a76bf6cafb2bf7c8ebc30a27ff407b27b0cf03e9ddd183::lb_factory::get_pair_info_bin_step(v3),
                    amount_out     : 0,
                    amount_in      : 0,
                    fee            : 0,
                    virtual_amount : 0,
                };
                0x1::vector::push_back<PairQuote>(&mut v1, v4);
            };
            v2 = v2 + 1;
        };
        let v5 = FetchPairQuoteEvent{quotes: v1};
        0x2::event::emit<FetchPairQuoteEvent>(v5);
    }

    public fun get_optimal_bin_step<T0, T1>(arg0: &0x9adc2caf7a827f1e05a76bf6cafb2bf7c8ebc30a27ff407b27b0cf03e9ddd183::lb_factory::LBFactory, arg1: u128) : u16 {
        let v0 = 0x9adc2caf7a827f1e05a76bf6cafb2bf7c8ebc30a27ff407b27b0cf03e9ddd183::lb_factory::get_all_lb_pairs<T0, T1>(arg0);
        let v1 = 0;
        let v2 = 0;
        while (v2 < 0x1::vector::length<0x9adc2caf7a827f1e05a76bf6cafb2bf7c8ebc30a27ff407b27b0cf03e9ddd183::lb_factory::LBPairInformation>(&v0)) {
            let v3 = 0x1::vector::borrow<0x9adc2caf7a827f1e05a76bf6cafb2bf7c8ebc30a27ff407b27b0cf03e9ddd183::lb_factory::LBPairInformation>(&v0, v2);
            if (0x9adc2caf7a827f1e05a76bf6cafb2bf7c8ebc30a27ff407b27b0cf03e9ddd183::lb_factory::get_pair_info_id(v3) != 0x2::object::id_from_address(@0x0) && !0x9adc2caf7a827f1e05a76bf6cafb2bf7c8ebc30a27ff407b27b0cf03e9ddd183::lb_factory::is_pair_ignored(v3)) {
                if (v1 == 0 || arg1 > 1000000000000 && 0x9adc2caf7a827f1e05a76bf6cafb2bf7c8ebc30a27ff407b27b0cf03e9ddd183::lb_factory::get_pair_info_bin_step(v3) < v1) {
                    v1 = 0x9adc2caf7a827f1e05a76bf6cafb2bf7c8ebc30a27ff407b27b0cf03e9ddd183::lb_factory::get_pair_info_bin_step(v3);
                };
            };
            v2 = v2 + 1;
        };
        v1
    }

    public fun get_quote_for_exact_out<T0, T1>(arg0: &0x9adc2caf7a827f1e05a76bf6cafb2bf7c8ebc30a27ff407b27b0cf03e9ddd183::lb_factory::LBPairWrapper<T0, T1>, arg1: u64, arg2: bool, arg3: &0x2::clock::Clock) : (u64, u64, u128) {
        let v0 = 0x9adc2caf7a827f1e05a76bf6cafb2bf7c8ebc30a27ff407b27b0cf03e9ddd183::lb_factory::get_lb_pair<T0, T1>(arg0);
        let (v1, v2, v3) = 0x9adc2caf7a827f1e05a76bf6cafb2bf7c8ebc30a27ff407b27b0cf03e9ddd183::lb_pair::get_swap_in<T0, T1>(v0, arg1, arg2, arg3);
        assert!(v2 == 0, 5003);
        (v1, v3, calculate_virtual_amount((arg1 as u256), 0x9adc2caf7a827f1e05a76bf6cafb2bf7c8ebc30a27ff407b27b0cf03e9ddd183::lb_pair::get_active_id<T0, T1>(v0), 0x9adc2caf7a827f1e05a76bf6cafb2bf7c8ebc30a27ff407b27b0cf03e9ddd183::lb_pair::get_bin_step<T0, T1>(v0), !arg2) + (v3 as u128))
    }

    public fun get_quote_for_pair<T0, T1>(arg0: &0x9adc2caf7a827f1e05a76bf6cafb2bf7c8ebc30a27ff407b27b0cf03e9ddd183::lb_factory::LBPairWrapper<T0, T1>, arg1: u64, arg2: bool, arg3: &0x2::clock::Clock) : (u64, u64, u128) {
        let v0 = 0x9adc2caf7a827f1e05a76bf6cafb2bf7c8ebc30a27ff407b27b0cf03e9ddd183::lb_factory::get_lb_pair<T0, T1>(arg0);
        let (v1, v2, v3) = 0x9adc2caf7a827f1e05a76bf6cafb2bf7c8ebc30a27ff407b27b0cf03e9ddd183::lb_pair::get_swap_out<T0, T1>(v0, arg1, arg2, arg3);
        assert!(v1 == 0, 5003);
        (v2, v3, calculate_virtual_amount(((arg1 - v3) as u256), 0x9adc2caf7a827f1e05a76bf6cafb2bf7c8ebc30a27ff407b27b0cf03e9ddd183::lb_pair::get_active_id<T0, T1>(v0), 0x9adc2caf7a827f1e05a76bf6cafb2bf7c8ebc30a27ff407b27b0cf03e9ddd183::lb_pair::get_bin_step<T0, T1>(v0), arg2))
    }

    public fun is_swap_possible<T0, T1>(arg0: &0x9adc2caf7a827f1e05a76bf6cafb2bf7c8ebc30a27ff407b27b0cf03e9ddd183::lb_factory::LBFactory) : bool {
        let v0 = 0x9adc2caf7a827f1e05a76bf6cafb2bf7c8ebc30a27ff407b27b0cf03e9ddd183::lb_factory::get_all_lb_pairs<T0, T1>(arg0);
        let v1 = 0;
        while (v1 < 0x1::vector::length<0x9adc2caf7a827f1e05a76bf6cafb2bf7c8ebc30a27ff407b27b0cf03e9ddd183::lb_factory::LBPairInformation>(&v0)) {
            let v2 = 0x1::vector::borrow<0x9adc2caf7a827f1e05a76bf6cafb2bf7c8ebc30a27ff407b27b0cf03e9ddd183::lb_factory::LBPairInformation>(&v0, v1);
            if (0x9adc2caf7a827f1e05a76bf6cafb2bf7c8ebc30a27ff407b27b0cf03e9ddd183::lb_factory::get_pair_info_id(v2) != 0x2::object::id_from_address(@0x0) && !0x9adc2caf7a827f1e05a76bf6cafb2bf7c8ebc30a27ff407b27b0cf03e9ddd183::lb_factory::is_pair_ignored(v2)) {
                return true
            };
            v1 = v1 + 1;
        };
        false
    }

    public fun validate_path(arg0: &vector<0x1::type_name::TypeName>) : bool {
        let v0 = 0x1::vector::length<0x1::type_name::TypeName>(arg0);
        if (v0 < 2) {
            return false
        };
        let v1 = 0;
        while (v1 < v0 - 1) {
            if (*0x1::vector::borrow<0x1::type_name::TypeName>(arg0, v1) == *0x1::vector::borrow<0x1::type_name::TypeName>(arg0, v1 + 1)) {
                return false
            };
            v1 = v1 + 1;
        };
        true
    }

    // decompiled from Move bytecode v6
}

