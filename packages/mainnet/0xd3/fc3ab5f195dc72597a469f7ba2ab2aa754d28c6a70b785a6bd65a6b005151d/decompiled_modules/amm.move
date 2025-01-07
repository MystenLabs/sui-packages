module 0xd3fc3ab5f195dc72597a469f7ba2ab2aa754d28c6a70b785a6bd65a6b005151d::amm {
    struct LP<phantom T0, phantom T1> has drop, store {
        dummy_field: bool,
    }

    struct Pool<phantom T0, phantom T1> has store {
        global: 0x2::object::ID,
        coin_x: 0x2::balance::Balance<T0>,
        coin_y: 0x2::balance::Balance<T1>,
        weight_x: u64,
        weight_y: u64,
        lp_supply: 0x2::balance::Supply<LP<T0, T1>>,
        min_liquidity: 0x2::balance::Balance<LP<T0, T1>>,
        swap_fee: 0xd3fc3ab5f195dc72597a469f7ba2ab2aa754d28c6a70b785a6bd65a6b005151d::fixed_point64::FixedPoint64,
        lbp_params: 0x1::option::Option<0xd3fc3ab5f195dc72597a469f7ba2ab2aa754d28c6a70b785a6bd65a6b005151d::lbp::LBPParams>,
        lbp_storage: 0x1::option::Option<0xd3fc3ab5f195dc72597a469f7ba2ab2aa754d28c6a70b785a6bd65a6b005151d::lbp::LBPStorage>,
        has_paused: bool,
        is_stable: bool,
        is_lbp: bool,
    }

    struct AMMGlobal has key {
        id: 0x2::object::UID,
        pools: 0x2::bag::Bag,
        archives: 0x2::bag::Bag,
        enable_whitelist: bool,
        whitelist: vector<address>,
        treasury: address,
    }

    public entry fun swap<T0, T1>(arg0: &mut AMMGlobal, arg1: 0x2::coin::Coin<T0>, arg2: u64, arg3: &mut 0x2::tx_context::TxContext) {
        let v0 = is_order<T0, T1>();
        let v1 = is_paused<T0, T1>(arg0, v0);
        assert!(!v1, 222);
        let v2 = swap_out_non_entry<T0, T1>(arg0, arg1, arg2, v0, arg3);
        0xd3fc3ab5f195dc72597a469f7ba2ab2aa754d28c6a70b785a6bd65a6b005151d::event::swapped_event(0x2::object::id<AMMGlobal>(arg0), generate_lp_name<T0, T1>(), 0x1::vector::pop_back<u64>(&mut v2), 0x1::vector::pop_back<u64>(&mut v2), 0x1::vector::pop_back<u64>(&mut v2), 0x1::vector::pop_back<u64>(&mut v2));
    }

    public fun id<T0, T1>(arg0: &AMMGlobal) : 0x2::object::ID {
        0x2::object::uid_to_inner(&arg0.id)
    }

    public entry fun add_liquidity<T0, T1>(arg0: &mut AMMGlobal, arg1: 0x2::coin::Coin<T0>, arg2: u64, arg3: 0x2::coin::Coin<T1>, arg4: u64, arg5: &mut 0x2::tx_context::TxContext) {
        let v0 = is_order<T0, T1>();
        assert!(has_registered<T0, T1>(arg0), 223);
        let v1 = is_paused<T0, T1>(arg0, v0);
        assert!(!v1, 222);
        let v2 = get_mut_pool<T0, T1>(arg0, v0);
        let (v3, v4, v5) = add_liquidity_non_entry<T0, T1>(v2, arg1, arg2, arg3, arg4, v0, arg5);
        let v6 = v4;
        assert!(0x1::vector::length<u64>(&v6) == 3, 224);
        if (v5) {
            0x2::transfer::public_transfer<0x2::coin::Coin<LP<T0, T1>>>(v3, get_treasury_address(arg0));
        } else {
            0x2::transfer::public_transfer<0x2::coin::Coin<LP<T0, T1>>>(v3, 0x2::tx_context::sender(arg5));
        };
        0xd3fc3ab5f195dc72597a469f7ba2ab2aa754d28c6a70b785a6bd65a6b005151d::event::add_liquidity_event(0x2::object::id<AMMGlobal>(arg0), generate_lp_name<T0, T1>(), 0x1::vector::pop_back<u64>(&mut v6), 0x1::vector::pop_back<u64>(&mut v6), 0x1::vector::pop_back<u64>(&mut v6), v5);
    }

    public fun add_liquidity_non_entry<T0, T1>(arg0: &mut Pool<T0, T1>, arg1: 0x2::coin::Coin<T0>, arg2: u64, arg3: 0x2::coin::Coin<T1>, arg4: u64, arg5: bool, arg6: &mut 0x2::tx_context::TxContext) : (0x2::coin::Coin<LP<T0, T1>>, vector<u64>, bool) {
        assert!(arg5, 212);
        let v0 = 0x2::coin::value<T0>(&arg1);
        let v1 = 0x2::coin::value<T1>(&arg3);
        assert!(v0 > 0 && v1 > 0, 200);
        let v2 = 0x2::coin::into_balance<T0>(arg1);
        let v3 = 0x2::coin::into_balance<T1>(arg3);
        let (v4, v5, v6) = get_reserves_size<T0, T1>(arg0, arg5);
        let (v7, v8, v9) = calc_optimal_coin_values<T0, T1>(arg0, v0, v1, arg2, arg4, v4, v5);
        let v10 = calculate_provided_liq<T0, T1>(arg0, v6, v4, v5, v7, v8);
        assert!(v10 > 0, 215);
        if (v7 < v0) {
            0x2::transfer::public_transfer<0x2::coin::Coin<T0>>(0x2::coin::from_balance<T0>(0x2::balance::split<T0>(&mut v2, v0 - v7), arg6), 0x2::tx_context::sender(arg6));
        };
        if (v8 < v1) {
            0x2::transfer::public_transfer<0x2::coin::Coin<T1>>(0x2::coin::from_balance<T1>(0x2::balance::split<T1>(&mut v3, v1 - v8), arg6), 0x2::tx_context::sender(arg6));
        };
        assert!(0x2::balance::join<T0>(&mut arg0.coin_x, v2) < 18446744073709551615, 202);
        assert!(0x2::balance::join<T1>(&mut arg0.coin_y, v3) < 18446744073709551615, 202);
        let v11 = 0x1::vector::empty<u64>();
        0x1::vector::push_back<u64>(&mut v11, v0);
        0x1::vector::push_back<u64>(&mut v11, v1);
        0x1::vector::push_back<u64>(&mut v11, v10);
        (0x2::coin::from_balance<LP<T0, T1>>(0x2::balance::increase_supply<LP<T0, T1>>(&mut arg0.lp_supply, v10), arg6), v11, v9)
    }

    public entry fun add_whitelist(arg0: &mut AMMGlobal, arg1: &mut 0xd3fc3ab5f195dc72597a469f7ba2ab2aa754d28c6a70b785a6bd65a6b005151d::vault::ManagerCap, arg2: address) {
        assert!(!0x1::vector::contains<address>(&arg0.whitelist, &arg2), 217);
        0x1::vector::push_back<address>(&mut arg0.whitelist, arg2);
    }

    public fun balance_x<T0, T1>(arg0: &Pool<T0, T1>) : u64 {
        0x2::balance::value<T0>(&arg0.coin_x)
    }

    public fun balance_y<T0, T1>(arg0: &Pool<T0, T1>) : u64 {
        0x2::balance::value<T1>(&arg0.coin_y)
    }

    public fun calc_optimal_coin_values<T0, T1>(arg0: &Pool<T0, T1>, arg1: u64, arg2: u64, arg3: u64, arg4: u64, arg5: u64, arg6: u64) : (u64, u64, bool) {
        if (arg5 == 0 && arg6 == 0) {
            return (arg1, arg2, true)
        };
        if (!arg0.is_stable) {
            let (v0, v1) = pool_current_weight<T0, T1>(arg0);
            let v2 = 0xd3fc3ab5f195dc72597a469f7ba2ab2aa754d28c6a70b785a6bd65a6b005151d::weighted_math::compute_optimal_value(arg1, arg6, v1, arg5, v0);
            if (v2 <= arg2) {
                assert!(v2 >= arg4, 204);
                return (arg1, v2, false)
            };
            let v3 = 0xd3fc3ab5f195dc72597a469f7ba2ab2aa754d28c6a70b785a6bd65a6b005151d::weighted_math::compute_optimal_value(arg2, arg5, v0, arg6, v1);
            assert!(v3 <= arg1, 206);
            assert!(v3 >= arg3, 203);
            return (v3, arg2, false)
        };
        let v4 = 0xd3fc3ab5f195dc72597a469f7ba2ab2aa754d28c6a70b785a6bd65a6b005151d::stable_math::get_amount_out(arg1, arg5, arg6);
        if (v4 <= arg2) {
            assert!(v4 >= arg4, 204);
            return (arg1, v4, false)
        };
        let v5 = 0xd3fc3ab5f195dc72597a469f7ba2ab2aa754d28c6a70b785a6bd65a6b005151d::stable_math::get_amount_out(arg2, arg6, arg5);
        assert!(v5 <= arg1, 206);
        assert!(v5 >= arg3, 203);
        (v5, arg2, false)
    }

    public fun calculate_provided_liq<T0, T1>(arg0: &mut Pool<T0, T1>, arg1: u64, arg2: u64, arg3: u64, arg4: u64, arg5: u64) : u64 {
        if (!arg0.is_stable) {
            let (v1, v2) = pool_current_weight<T0, T1>(arg0);
            if (0 == arg1) {
                let v3 = 0xd3fc3ab5f195dc72597a469f7ba2ab2aa754d28c6a70b785a6bd65a6b005151d::weighted_math::compute_initial_lp(v1, v2, arg4, arg5);
                assert!(v3 > 1000, 208);
                0x2::balance::join<LP<T0, T1>>(&mut arg0.min_liquidity, 0x2::balance::increase_supply<LP<T0, T1>>(&mut arg0.lp_supply, 1000));
                v3 - 1000
            } else {
                0xd3fc3ab5f195dc72597a469f7ba2ab2aa754d28c6a70b785a6bd65a6b005151d::weighted_math::compute_derive_lp(arg4, arg5, v1, v2, arg2, arg3, arg1)
            }
        } else if (0 == arg1) {
            let v4 = 0xd3fc3ab5f195dc72597a469f7ba2ab2aa754d28c6a70b785a6bd65a6b005151d::stable_math::compute_initial_lp(arg4, arg5);
            assert!(v4 > 1000, 208);
            0x2::balance::join<LP<T0, T1>>(&mut arg0.min_liquidity, 0x2::balance::increase_supply<LP<T0, T1>>(&mut arg0.lp_supply, 1000));
            v4 - 1000
        } else {
            let v5 = (arg1 as u128) * (arg4 as u128) / (arg2 as u128);
            let v6 = (arg1 as u128) * (arg5 as u128) / (arg3 as u128);
            if (v5 < v6) {
                assert!(v5 < (18446744073709551615 as u128), 213);
                (v5 as u64)
            } else {
                assert!(v6 < (18446744073709551615 as u128), 213);
                (v6 as u64)
            }
        }
    }

    fun check_whitelist(arg0: &AMMGlobal, arg1: address) {
        let (v0, _) = 0x1::vector::index_of<address>(&arg0.whitelist, &arg1);
        assert!(v0, 218);
    }

    public entry fun enable_whitelist(arg0: &mut AMMGlobal, arg1: &mut 0xd3fc3ab5f195dc72597a469f7ba2ab2aa754d28c6a70b785a6bd65a6b005151d::vault::ManagerCap, arg2: bool) {
        arg0.enable_whitelist = arg2;
    }

    public entry fun future_swap<T0, T1>(arg0: &mut 0x3::sui_system::SuiSystemState, arg1: &mut AMMGlobal, arg2: &mut 0xd3fc3ab5f195dc72597a469f7ba2ab2aa754d28c6a70b785a6bd65a6b005151d::vault::Global, arg3: 0x3::staking_pool::StakedSui, arg4: &mut 0x2::tx_context::TxContext) {
        assert!(has_registered<0x2::sui::SUI, T1>(arg1), 223);
        let v0 = is_order<0x2::sui::SUI, T1>();
        let v1 = is_paused<0x2::sui::SUI, T1>(arg1, v0);
        assert!(!v1, 222);
        let (v2, v3) = 0xd3fc3ab5f195dc72597a469f7ba2ab2aa754d28c6a70b785a6bd65a6b005151d::vault::mint_non_entry<T0>(arg0, arg2, arg3, arg4);
        let v4 = v2;
        0x2::transfer::public_transfer<0x2::coin::Coin<0xd3fc3ab5f195dc72597a469f7ba2ab2aa754d28c6a70b785a6bd65a6b005151d::vault::PT_TOKEN<T0>>>(0x2::coin::split<0xd3fc3ab5f195dc72597a469f7ba2ab2aa754d28c6a70b785a6bd65a6b005151d::vault::PT_TOKEN<T0>>(&mut v4, 0x2::coin::value<0xd3fc3ab5f195dc72597a469f7ba2ab2aa754d28c6a70b785a6bd65a6b005151d::vault::PT_TOKEN<T0>>(&v4) - v3, arg4), 0x2::tx_context::sender(arg4));
        let v5 = 0x2::coin::value<0xd3fc3ab5f195dc72597a469f7ba2ab2aa754d28c6a70b785a6bd65a6b005151d::vault::PT_TOKEN<T0>>(&v4);
        assert!(v5 > 0, 229);
        let v6 = get_mut_pool<0x2::sui::SUI, T1>(arg1, v0);
        assert!(v6.is_lbp, 225);
        let (v7, v8, _) = get_reserves_size<0x2::sui::SUI, T1>(v6, true);
        assert!(v7 > 0 && v8 > 0, 201);
        let (v10, v11) = pool_current_weight<0x2::sui::SUI, T1>(v6);
        let v12 = 0x1::option::borrow_mut<0xd3fc3ab5f195dc72597a469f7ba2ab2aa754d28c6a70b785a6bd65a6b005151d::lbp::LBPParams>(&mut v6.lbp_params);
        assert!(0xd3fc3ab5f195dc72597a469f7ba2ab2aa754d28c6a70b785a6bd65a6b005151d::lbp::is_vault(v12), 230);
        let v13 = get_amount_out(v6.is_stable, v5, v7, v10, v8, v11);
        0xd3fc3ab5f195dc72597a469f7ba2ab2aa754d28c6a70b785a6bd65a6b005151d::lbp::verify_and_adjust_amount(v12, true, v5, v13, true);
        0xd3fc3ab5f195dc72597a469f7ba2ab2aa754d28c6a70b785a6bd65a6b005151d::lbp::add_pending_in<T0>(0x1::option::borrow_mut<0xd3fc3ab5f195dc72597a469f7ba2ab2aa754d28c6a70b785a6bd65a6b005151d::lbp::LBPStorage>(&mut v6.lbp_storage), v4, v5);
        0x2::transfer::public_transfer<0x2::coin::Coin<T1>>(0x2::coin::take<T1>(&mut v6.coin_y, v13, arg4), 0x2::tx_context::sender(arg4));
        0xd3fc3ab5f195dc72597a469f7ba2ab2aa754d28c6a70b785a6bd65a6b005151d::event::future_swapped_event(0x2::object::id<AMMGlobal>(arg1), generate_lp_name<0x2::sui::SUI, T1>(), 0x3::staking_pool::staked_sui_amount(&arg3), v3, v13);
    }

    public entry fun future_swap_with_sui<T0, T1>(arg0: &mut 0x3::sui_system::SuiSystemState, arg1: &mut AMMGlobal, arg2: &mut 0xd3fc3ab5f195dc72597a469f7ba2ab2aa754d28c6a70b785a6bd65a6b005151d::vault::Global, arg3: 0x2::coin::Coin<0x2::sui::SUI>, arg4: &mut 0x2::tx_context::TxContext) {
        assert!(0x2::coin::value<0x2::sui::SUI>(&arg3) >= 1000000000, 228);
        let v0 = 0x3::sui_system::request_add_stake_non_entry(arg0, arg3, 0xd3fc3ab5f195dc72597a469f7ba2ab2aa754d28c6a70b785a6bd65a6b005151d::vault::get_random_validator_address(0xd3fc3ab5f195dc72597a469f7ba2ab2aa754d28c6a70b785a6bd65a6b005151d::vault::staking_pools(arg2), arg4), arg4);
        future_swap<T0, T1>(arg0, arg1, arg2, v0, arg4);
    }

    public fun generate_lp_name<T0, T1>() : 0x1::string::String {
        let v0 = 0x1::string::utf8(b"");
        0x1::string::append_utf8(&mut v0, b"LP-");
        if (is_order<T0, T1>()) {
            0x1::string::append_utf8(&mut v0, 0x1::ascii::into_bytes(0x1::type_name::into_string(0x1::type_name::get<T0>())));
            0x1::string::append_utf8(&mut v0, b"-");
            0x1::string::append_utf8(&mut v0, 0x1::ascii::into_bytes(0x1::type_name::into_string(0x1::type_name::get<T1>())));
        } else {
            0x1::string::append_utf8(&mut v0, 0x1::ascii::into_bytes(0x1::type_name::into_string(0x1::type_name::get<T1>())));
            0x1::string::append_utf8(&mut v0, b"-");
            0x1::string::append_utf8(&mut v0, 0x1::ascii::into_bytes(0x1::type_name::into_string(0x1::type_name::get<T0>())));
        };
        v0
    }

    public fun get_amount_out(arg0: bool, arg1: u64, arg2: u64, arg3: u64, arg4: u64, arg5: u64) : u64 {
        if (!arg0) {
            0xd3fc3ab5f195dc72597a469f7ba2ab2aa754d28c6a70b785a6bd65a6b005151d::weighted_math::get_amount_out(arg1, arg2, arg3, arg4, arg5)
        } else {
            0xd3fc3ab5f195dc72597a469f7ba2ab2aa754d28c6a70b785a6bd65a6b005151d::stable_math::get_amount_out(arg1, arg2, arg4)
        }
    }

    public fun get_mut_pool<T0, T1>(arg0: &mut AMMGlobal, arg1: bool) : &mut Pool<T0, T1> {
        assert!(arg1, 212);
        let v0 = generate_lp_name<T0, T1>();
        assert!(0x2::bag::contains_with_type<0x1::string::String, Pool<T0, T1>>(&arg0.pools, v0), 211);
        0x2::bag::borrow_mut<0x1::string::String, Pool<T0, T1>>(&mut arg0.pools, v0)
    }

    public fun get_reserves_size<T0, T1>(arg0: &Pool<T0, T1>, arg1: bool) : (u64, u64, u64) {
        if (!arg0.is_lbp) {
            (0x2::balance::value<T0>(&arg0.coin_x), 0x2::balance::value<T1>(&arg0.coin_y), 0x2::balance::supply_value<LP<T0, T1>>(&arg0.lp_supply))
        } else {
            let v3 = 0x1::option::borrow<0xd3fc3ab5f195dc72597a469f7ba2ab2aa754d28c6a70b785a6bd65a6b005151d::lbp::LBPParams>(&arg0.lbp_params);
            let v4 = 0;
            let v5 = 0;
            if (0xd3fc3ab5f195dc72597a469f7ba2ab2aa754d28c6a70b785a6bd65a6b005151d::lbp::is_vault(v3)) {
                let v6 = arg1 && 0xd3fc3ab5f195dc72597a469f7ba2ab2aa754d28c6a70b785a6bd65a6b005151d::lbp::is_buy(v3) || !0xd3fc3ab5f195dc72597a469f7ba2ab2aa754d28c6a70b785a6bd65a6b005151d::lbp::is_buy(v3);
                let v7 = 0xd3fc3ab5f195dc72597a469f7ba2ab2aa754d28c6a70b785a6bd65a6b005151d::lbp::pending_in_amount(0x1::option::borrow<0xd3fc3ab5f195dc72597a469f7ba2ab2aa754d28c6a70b785a6bd65a6b005151d::lbp::LBPStorage>(&arg0.lbp_storage));
                let v8 = 0x1::type_name::get<0x2::sui::SUI>();
                let v9 = 0x1::type_name::get<T0>();
                let v10 = 0xd3fc3ab5f195dc72597a469f7ba2ab2aa754d28c6a70b785a6bd65a6b005151d::comparator::compare<0x1::type_name::TypeName>(&v8, &v9);
                if (0xd3fc3ab5f195dc72597a469f7ba2ab2aa754d28c6a70b785a6bd65a6b005151d::comparator::is_equal(&v10) && v6) {
                    v4 = v7;
                };
                let v11 = 0x1::type_name::get<0x2::sui::SUI>();
                let v12 = 0x1::type_name::get<T1>();
                let v13 = 0xd3fc3ab5f195dc72597a469f7ba2ab2aa754d28c6a70b785a6bd65a6b005151d::comparator::compare<0x1::type_name::TypeName>(&v11, &v12);
                if (0xd3fc3ab5f195dc72597a469f7ba2ab2aa754d28c6a70b785a6bd65a6b005151d::comparator::is_equal(&v13) && v6) {
                    v5 = v7;
                };
            };
            (0x2::balance::value<T0>(&arg0.coin_x) + v4, 0x2::balance::value<T1>(&arg0.coin_y) + v5, 0x2::balance::supply_value<LP<T0, T1>>(&arg0.lp_supply))
        }
    }

    fun get_treasury_address(arg0: &AMMGlobal) : address {
        arg0.treasury
    }

    public fun global_id<T0, T1>(arg0: &Pool<T0, T1>) : 0x2::object::ID {
        arg0.global
    }

    public fun has_registered<T0, T1>(arg0: &AMMGlobal) : bool {
        0x2::bag::contains_with_type<0x1::string::String, Pool<T0, T1>>(&arg0.pools, generate_lp_name<T0, T1>())
    }

    fun init(arg0: &mut 0x2::tx_context::TxContext) {
        let v0 = 0x1::vector::empty<address>();
        0x1::vector::push_back<address>(&mut v0, 0x2::tx_context::sender(arg0));
        let v1 = AMMGlobal{
            id               : 0x2::object::new(arg0),
            pools            : 0x2::bag::new(arg0),
            archives         : 0x2::bag::new(arg0),
            enable_whitelist : true,
            whitelist        : v0,
            treasury         : 0x2::tx_context::sender(arg0),
        };
        0x2::transfer::share_object<AMMGlobal>(v1);
    }

    public fun is_order<T0, T1>() : bool {
        let v0 = 0x1::type_name::get<T0>();
        let v1 = 0x1::type_name::get<T1>();
        let v2 = 0xd3fc3ab5f195dc72597a469f7ba2ab2aa754d28c6a70b785a6bd65a6b005151d::comparator::compare<0x1::type_name::TypeName>(&v0, &v1);
        assert!(!0xd3fc3ab5f195dc72597a469f7ba2ab2aa754d28c6a70b785a6bd65a6b005151d::comparator::is_equal(&v2), 209);
        0xd3fc3ab5f195dc72597a469f7ba2ab2aa754d28c6a70b785a6bd65a6b005151d::comparator::is_smaller_than(&v2)
    }

    public fun is_paused<T0, T1>(arg0: &mut AMMGlobal, arg1: bool) : bool {
        arg1 && get_mut_pool<T0, T1>(arg0, arg1).has_paused || get_mut_pool<T1, T0>(arg0, !arg1).has_paused
    }

    public entry fun lbp_enable_buy_with_pair_and_vault<T0>(arg0: &mut AMMGlobal, arg1: &mut 0xd3fc3ab5f195dc72597a469f7ba2ab2aa754d28c6a70b785a6bd65a6b005151d::vault::ManagerCap, arg2: bool, arg3: bool) {
        assert!(has_registered<0x2::sui::SUI, T0>(arg0), 223);
        let v0 = get_mut_pool<0x2::sui::SUI, T0>(arg0, is_order<0x2::sui::SUI, T0>());
        assert!(v0.is_lbp, 225);
        let v1 = 0x1::option::borrow_mut<0xd3fc3ab5f195dc72597a469f7ba2ab2aa754d28c6a70b785a6bd65a6b005151d::lbp::LBPParams>(&mut v0.lbp_params);
        0xd3fc3ab5f195dc72597a469f7ba2ab2aa754d28c6a70b785a6bd65a6b005151d::lbp::enable_buy_with_pair(v1, arg2);
        0xd3fc3ab5f195dc72597a469f7ba2ab2aa754d28c6a70b785a6bd65a6b005151d::lbp::enable_buy_with_vault(v1, arg3);
    }

    public fun lbp_info<T0, T1>(arg0: &mut AMMGlobal) : (u64, u64, u64, u64) {
        let v0 = is_order<T0, T1>();
        if (v0) {
            let v5 = get_mut_pool<T0, T1>(arg0, v0);
            assert!(v5.is_lbp == true, 225);
            let (v6, v7) = pool_current_weight<T0, T1>(v5);
            let v8 = 0x1::option::borrow<0xd3fc3ab5f195dc72597a469f7ba2ab2aa754d28c6a70b785a6bd65a6b005151d::lbp::LBPParams>(&v5.lbp_params);
            (v6, v7, 0xd3fc3ab5f195dc72597a469f7ba2ab2aa754d28c6a70b785a6bd65a6b005151d::lbp::total_amount_collected(v8), 0xd3fc3ab5f195dc72597a469f7ba2ab2aa754d28c6a70b785a6bd65a6b005151d::lbp::total_target_amount(v8))
        } else {
            let v9 = get_mut_pool<T1, T0>(arg0, true);
            assert!(v9.is_lbp == true, 225);
            let (v10, v11) = pool_current_weight<T1, T0>(v9);
            let v12 = 0x1::option::borrow<0xd3fc3ab5f195dc72597a469f7ba2ab2aa754d28c6a70b785a6bd65a6b005151d::lbp::LBPParams>(&v9.lbp_params);
            (v11, v10, 0xd3fc3ab5f195dc72597a469f7ba2ab2aa754d28c6a70b785a6bd65a6b005151d::lbp::total_amount_collected(v12), 0xd3fc3ab5f195dc72597a469f7ba2ab2aa754d28c6a70b785a6bd65a6b005151d::lbp::total_target_amount(v12))
        }
    }

    public entry fun lbp_replenish<T0, T1>(arg0: &mut 0x3::sui_system::SuiSystemState, arg1: &mut AMMGlobal, arg2: &mut 0xd3fc3ab5f195dc72597a469f7ba2ab2aa754d28c6a70b785a6bd65a6b005151d::vault::Global, arg3: &mut 0x2::tx_context::TxContext) {
        assert!(has_registered<0x2::sui::SUI, T0>(arg1), 223);
        let v0 = is_order<0x2::sui::SUI, T0>();
        let v1 = is_paused<0x2::sui::SUI, T0>(arg1, v0);
        assert!(!v1, 222);
        let v2 = get_mut_pool<0x2::sui::SUI, T0>(arg1, v0);
        assert!(v2.is_lbp, 225);
        let (v3, _) = 0xd3fc3ab5f195dc72597a469f7ba2ab2aa754d28c6a70b785a6bd65a6b005151d::vault::redeem_non_entry<T1>(arg0, arg2, 0xd3fc3ab5f195dc72597a469f7ba2ab2aa754d28c6a70b785a6bd65a6b005151d::lbp::withdraw_pending_in<T1>(0x1::option::borrow_mut<0xd3fc3ab5f195dc72597a469f7ba2ab2aa754d28c6a70b785a6bd65a6b005151d::lbp::LBPStorage>(&mut v2.lbp_storage), arg3), arg3);
        0x2::balance::join<0x2::sui::SUI>(&mut v2.coin_x, 0x2::coin::into_balance<0x2::sui::SUI>(v3));
    }

    public entry fun lbp_set_target_amount<T0>(arg0: &mut AMMGlobal, arg1: &mut 0xd3fc3ab5f195dc72597a469f7ba2ab2aa754d28c6a70b785a6bd65a6b005151d::vault::ManagerCap, arg2: u64) {
        assert!(has_registered<0x2::sui::SUI, T0>(arg0), 223);
        let v0 = get_mut_pool<0x2::sui::SUI, T0>(arg0, is_order<0x2::sui::SUI, T0>());
        assert!(v0.is_lbp, 225);
        0xd3fc3ab5f195dc72597a469f7ba2ab2aa754d28c6a70b785a6bd65a6b005151d::lbp::set_new_target_amount(0x1::option::borrow_mut<0xd3fc3ab5f195dc72597a469f7ba2ab2aa754d28c6a70b785a6bd65a6b005151d::lbp::LBPParams>(&mut v0.lbp_params), arg2);
    }

    public entry fun move_to_archive<T0, T1>(arg0: &mut AMMGlobal, arg1: &mut 0xd3fc3ab5f195dc72597a469f7ba2ab2aa754d28c6a70b785a6bd65a6b005151d::vault::ManagerCap) {
        assert!(is_order<T0, T1>(), 212);
        let v0 = generate_lp_name<T0, T1>();
        0x2::bag::add<0x1::string::String, Pool<T0, T1>>(&mut arg0.archives, v0, 0x2::bag::remove<0x1::string::String, Pool<T0, T1>>(&mut arg0.pools, v0));
    }

    public entry fun pause<T0, T1>(arg0: &mut AMMGlobal, arg1: &mut 0xd3fc3ab5f195dc72597a469f7ba2ab2aa754d28c6a70b785a6bd65a6b005151d::vault::ManagerCap) {
        get_mut_pool<T0, T1>(arg0, is_order<T0, T1>()).has_paused = true;
    }

    public fun pool_current_weight<T0, T1>(arg0: &Pool<T0, T1>) : (u64, u64) {
        if (!arg0.is_lbp) {
            (arg0.weight_x, arg0.weight_y)
        } else {
            0xd3fc3ab5f195dc72597a469f7ba2ab2aa754d28c6a70b785a6bd65a6b005151d::lbp::current_weight(0x1::option::borrow<0xd3fc3ab5f195dc72597a469f7ba2ab2aa754d28c6a70b785a6bd65a6b005151d::lbp::LBPParams>(&arg0.lbp_params))
        }
    }

    public entry fun register_lbp_pool<T0, T1>(arg0: &mut AMMGlobal, arg1: bool, arg2: u64, arg3: u64, arg4: bool, arg5: u64, arg6: &mut 0x2::tx_context::TxContext) {
        assert!(is_order<T0, T1>(), 212);
        if (arg0.enable_whitelist) {
            check_whitelist(arg0, 0x2::tx_context::sender(arg6));
        };
        let v0 = generate_lp_name<T0, T1>();
        assert!(!0x2::bag::contains_with_type<0x1::string::String, Pool<T0, T1>>(&arg0.pools, v0), 210);
        let v1 = LP<T0, T1>{dummy_field: false};
        let v2 = Pool<T0, T1>{
            global        : 0x2::object::uid_to_inner(&arg0.id),
            coin_x        : 0x2::balance::zero<T0>(),
            coin_y        : 0x2::balance::zero<T1>(),
            weight_x      : 0,
            weight_y      : 0,
            lp_supply     : 0x2::balance::create_supply<LP<T0, T1>>(v1),
            min_liquidity : 0x2::balance::zero<LP<T0, T1>>(),
            swap_fee      : 0xd3fc3ab5f195dc72597a469f7ba2ab2aa754d28c6a70b785a6bd65a6b005151d::fixed_point64::create_from_raw_value(46116860184273879),
            lbp_params    : 0x1::option::some<0xd3fc3ab5f195dc72597a469f7ba2ab2aa754d28c6a70b785a6bd65a6b005151d::lbp::LBPParams>(0xd3fc3ab5f195dc72597a469f7ba2ab2aa754d28c6a70b785a6bd65a6b005151d::lbp::construct_init_params(arg1, arg2, arg3, arg4, arg5)),
            lbp_storage   : 0x1::option::some<0xd3fc3ab5f195dc72597a469f7ba2ab2aa754d28c6a70b785a6bd65a6b005151d::lbp::LBPStorage>(0xd3fc3ab5f195dc72597a469f7ba2ab2aa754d28c6a70b785a6bd65a6b005151d::lbp::create_empty_storage(arg6)),
            has_paused    : false,
            is_stable     : false,
            is_lbp        : true,
        };
        0x2::bag::add<0x1::string::String, Pool<T0, T1>>(&mut arg0.pools, v0, v2);
        0xd3fc3ab5f195dc72597a469f7ba2ab2aa754d28c6a70b785a6bd65a6b005151d::event::register_pool_event(0x2::object::id<AMMGlobal>(arg0), v0, arg2, arg3, false, true);
    }

    public entry fun register_pool<T0, T1>(arg0: &mut AMMGlobal, arg1: u64, arg2: u64, arg3: &mut 0x2::tx_context::TxContext) {
        assert!(is_order<T0, T1>(), 212);
        if (arg0.enable_whitelist) {
            check_whitelist(arg0, 0x2::tx_context::sender(arg3));
        };
        let v0 = generate_lp_name<T0, T1>();
        assert!(!0x2::bag::contains_with_type<0x1::string::String, Pool<T0, T1>>(&arg0.pools, v0), 210);
        let v1 = LP<T0, T1>{dummy_field: false};
        assert!(arg1 + arg2 == 10000, 219);
        let v2 = Pool<T0, T1>{
            global        : 0x2::object::uid_to_inner(&arg0.id),
            coin_x        : 0x2::balance::zero<T0>(),
            coin_y        : 0x2::balance::zero<T1>(),
            weight_x      : arg1,
            weight_y      : arg2,
            lp_supply     : 0x2::balance::create_supply<LP<T0, T1>>(v1),
            min_liquidity : 0x2::balance::zero<LP<T0, T1>>(),
            swap_fee      : 0xd3fc3ab5f195dc72597a469f7ba2ab2aa754d28c6a70b785a6bd65a6b005151d::fixed_point64::create_from_raw_value(92233720368547758),
            lbp_params    : 0x1::option::none<0xd3fc3ab5f195dc72597a469f7ba2ab2aa754d28c6a70b785a6bd65a6b005151d::lbp::LBPParams>(),
            lbp_storage   : 0x1::option::none<0xd3fc3ab5f195dc72597a469f7ba2ab2aa754d28c6a70b785a6bd65a6b005151d::lbp::LBPStorage>(),
            has_paused    : false,
            is_stable     : false,
            is_lbp        : false,
        };
        0x2::bag::add<0x1::string::String, Pool<T0, T1>>(&mut arg0.pools, v0, v2);
        0xd3fc3ab5f195dc72597a469f7ba2ab2aa754d28c6a70b785a6bd65a6b005151d::event::register_pool_event(0x2::object::id<AMMGlobal>(arg0), v0, arg1, arg2, false, false);
    }

    public entry fun register_stable_pool<T0, T1>(arg0: &mut AMMGlobal, arg1: &mut 0x2::tx_context::TxContext) {
        assert!(is_order<T0, T1>(), 212);
        if (arg0.enable_whitelist) {
            check_whitelist(arg0, 0x2::tx_context::sender(arg1));
        };
        let v0 = generate_lp_name<T0, T1>();
        assert!(!0x2::bag::contains_with_type<0x1::string::String, Pool<T0, T1>>(&arg0.pools, v0), 210);
        let v1 = LP<T0, T1>{dummy_field: false};
        let v2 = Pool<T0, T1>{
            global        : 0x2::object::uid_to_inner(&arg0.id),
            coin_x        : 0x2::balance::zero<T0>(),
            coin_y        : 0x2::balance::zero<T1>(),
            weight_x      : 5000,
            weight_y      : 5000,
            lp_supply     : 0x2::balance::create_supply<LP<T0, T1>>(v1),
            min_liquidity : 0x2::balance::zero<LP<T0, T1>>(),
            swap_fee      : 0xd3fc3ab5f195dc72597a469f7ba2ab2aa754d28c6a70b785a6bd65a6b005151d::fixed_point64::create_from_raw_value(18446744073709551),
            lbp_params    : 0x1::option::none<0xd3fc3ab5f195dc72597a469f7ba2ab2aa754d28c6a70b785a6bd65a6b005151d::lbp::LBPParams>(),
            lbp_storage   : 0x1::option::none<0xd3fc3ab5f195dc72597a469f7ba2ab2aa754d28c6a70b785a6bd65a6b005151d::lbp::LBPStorage>(),
            has_paused    : false,
            is_stable     : true,
            is_lbp        : false,
        };
        0x2::bag::add<0x1::string::String, Pool<T0, T1>>(&mut arg0.pools, v0, v2);
        0xd3fc3ab5f195dc72597a469f7ba2ab2aa754d28c6a70b785a6bd65a6b005151d::event::register_pool_event(0x2::object::id<AMMGlobal>(arg0), v0, 5000, 5000, true, false);
    }

    public entry fun remove_liquidity<T0, T1>(arg0: &mut AMMGlobal, arg1: 0x2::coin::Coin<LP<T0, T1>>, arg2: &mut 0x2::tx_context::TxContext) {
        let v0 = is_order<T0, T1>();
        let v1 = is_paused<T0, T1>(arg0, v0);
        assert!(!v1, 222);
        let v2 = get_mut_pool<T0, T1>(arg0, v0);
        let (v3, v4) = remove_liquidity_non_entry<T0, T1>(v2, arg1, v0, arg2);
        let v5 = v4;
        let v6 = v3;
        0x2::transfer::public_transfer<0x2::coin::Coin<T0>>(v6, 0x2::tx_context::sender(arg2));
        0x2::transfer::public_transfer<0x2::coin::Coin<T1>>(v5, 0x2::tx_context::sender(arg2));
        0xd3fc3ab5f195dc72597a469f7ba2ab2aa754d28c6a70b785a6bd65a6b005151d::event::remove_liquidity_event(0x2::object::id<AMMGlobal>(arg0), generate_lp_name<T0, T1>(), 0x2::coin::value<T0>(&v6), 0x2::coin::value<T1>(&v5), 0x2::coin::value<LP<T0, T1>>(&arg1));
    }

    public fun remove_liquidity_non_entry<T0, T1>(arg0: &mut Pool<T0, T1>, arg1: 0x2::coin::Coin<LP<T0, T1>>, arg2: bool, arg3: &mut 0x2::tx_context::TxContext) : (0x2::coin::Coin<T0>, 0x2::coin::Coin<T1>) {
        assert!(arg2, 212);
        let v0 = 0x2::coin::value<LP<T0, T1>>(&arg1);
        assert!(v0 > 0, 200);
        let (v1, v2, v3) = get_reserves_size<T0, T1>(arg0, arg2);
        if (!arg0.is_stable) {
            let (v6, v7) = pool_current_weight<T0, T1>(arg0);
            let (v8, v9) = 0xd3fc3ab5f195dc72597a469f7ba2ab2aa754d28c6a70b785a6bd65a6b005151d::weighted_math::compute_withdrawn_coins(v0, v3, v1, v2, v6, v7);
            0x2::balance::decrease_supply<LP<T0, T1>>(&mut arg0.lp_supply, 0x2::coin::into_balance<LP<T0, T1>>(arg1));
            (0x2::coin::take<T0>(&mut arg0.coin_x, v8, arg3), 0x2::coin::take<T1>(&mut arg0.coin_y, v9, arg3))
        } else {
            let v10 = 0xd3fc3ab5f195dc72597a469f7ba2ab2aa754d28c6a70b785a6bd65a6b005151d::fixed_point64::create_from_rational((v0 as u128), (v3 as u128));
            0x2::balance::decrease_supply<LP<T0, T1>>(&mut arg0.lp_supply, 0x2::coin::into_balance<LP<T0, T1>>(arg1));
            (0x2::coin::take<T0>(&mut arg0.coin_x, (0xd3fc3ab5f195dc72597a469f7ba2ab2aa754d28c6a70b785a6bd65a6b005151d::fixed_point64::multiply_u128((v1 as u128), v10) as u64), arg3), 0x2::coin::take<T1>(&mut arg0.coin_y, (0xd3fc3ab5f195dc72597a469f7ba2ab2aa754d28c6a70b785a6bd65a6b005151d::fixed_point64::multiply_u128((v2 as u128), v10) as u64), arg3))
        }
    }

    public entry fun remove_whitelist(arg0: &mut AMMGlobal, arg1: &mut 0xd3fc3ab5f195dc72597a469f7ba2ab2aa754d28c6a70b785a6bd65a6b005151d::vault::ManagerCap, arg2: address) {
        let (v0, v1) = 0x1::vector::index_of<address>(&arg0.whitelist, &arg2);
        assert!(v0, 216);
        0x1::vector::remove<address>(&mut arg0.whitelist, v1);
    }

    public entry fun resume<T0, T1>(arg0: &mut AMMGlobal, arg1: &mut 0xd3fc3ab5f195dc72597a469f7ba2ab2aa754d28c6a70b785a6bd65a6b005151d::vault::ManagerCap) {
        get_mut_pool<T0, T1>(arg0, is_order<T0, T1>()).has_paused = false;
    }

    public fun swap_out_non_entry<T0, T1>(arg0: &mut AMMGlobal, arg1: 0x2::coin::Coin<T0>, arg2: u64, arg3: bool, arg4: &mut 0x2::tx_context::TxContext) : vector<u64> {
        assert!(0x2::coin::value<T0>(&arg1) > 0, 200);
        let v0 = get_treasury_address(arg0);
        if (arg3) {
            let v2 = get_mut_pool<T0, T1>(arg0, arg3);
            let (v3, v4, _) = get_reserves_size<T0, T1>(v2, arg3);
            assert!(v3 > 0 && v4 > 0, 201);
            let v6 = 0x2::coin::value<T0>(&arg1);
            let (v7, v8) = 0xd3fc3ab5f195dc72597a469f7ba2ab2aa754d28c6a70b785a6bd65a6b005151d::weighted_math::get_fee_to_treasury(v2.swap_fee, v6);
            let (v9, v10) = pool_current_weight<T0, T1>(v2);
            let v11 = get_amount_out(v2.is_stable, v7, v3, v9, v4, v10);
            assert!(v11 >= arg2, 207);
            if (v2.is_lbp) {
                let v12 = 0x1::option::borrow_mut<0xd3fc3ab5f195dc72597a469f7ba2ab2aa754d28c6a70b785a6bd65a6b005151d::lbp::LBPParams>(&mut v2.lbp_params);
                0xd3fc3ab5f195dc72597a469f7ba2ab2aa754d28c6a70b785a6bd65a6b005151d::lbp::verify_and_adjust_amount(v12, 0xd3fc3ab5f195dc72597a469f7ba2ab2aa754d28c6a70b785a6bd65a6b005151d::lbp::is_buy(v12), v6, v11, false);
            };
            let v13 = 0x2::coin::into_balance<T0>(arg1);
            0x2::transfer::public_transfer<0x2::coin::Coin<T0>>(0x2::coin::from_balance<T0>(0x2::balance::split<T0>(&mut v13, v8), arg4), v0);
            0x2::balance::join<T0>(&mut v2.coin_x, v13);
            0x2::transfer::public_transfer<0x2::coin::Coin<T1>>(0x2::coin::take<T1>(&mut v2.coin_y, v11, arg4), 0x2::tx_context::sender(arg4));
            let v14 = 0x1::vector::empty<u64>();
            0x1::vector::push_back<u64>(&mut v14, v6);
            0x1::vector::push_back<u64>(&mut v14, 0);
            0x1::vector::push_back<u64>(&mut v14, 0);
            0x1::vector::push_back<u64>(&mut v14, v11);
            v14
        } else {
            let v15 = get_mut_pool<T1, T0>(arg0, !arg3);
            let (v16, v17, _) = get_reserves_size<T1, T0>(v15, arg3);
            assert!(v16 > 0 && v17 > 0, 201);
            let v19 = 0x2::coin::value<T0>(&arg1);
            let (v20, v21) = pool_current_weight<T1, T0>(v15);
            let (v22, v23) = 0xd3fc3ab5f195dc72597a469f7ba2ab2aa754d28c6a70b785a6bd65a6b005151d::weighted_math::get_fee_to_treasury(v15.swap_fee, v19);
            let v24 = get_amount_out(v15.is_stable, v22, v17, v21, v16, v20);
            assert!(v24 >= arg2, 207);
            if (v15.is_lbp) {
                let v25 = 0x1::option::borrow_mut<0xd3fc3ab5f195dc72597a469f7ba2ab2aa754d28c6a70b785a6bd65a6b005151d::lbp::LBPParams>(&mut v15.lbp_params);
                0xd3fc3ab5f195dc72597a469f7ba2ab2aa754d28c6a70b785a6bd65a6b005151d::lbp::verify_and_adjust_amount(v25, !0xd3fc3ab5f195dc72597a469f7ba2ab2aa754d28c6a70b785a6bd65a6b005151d::lbp::is_buy(v25), v19, v24, false);
            };
            let v26 = 0x2::coin::into_balance<T0>(arg1);
            0x2::transfer::public_transfer<0x2::coin::Coin<T0>>(0x2::coin::from_balance<T0>(0x2::balance::split<T0>(&mut v26, v23), arg4), v0);
            0x2::balance::join<T0>(&mut v15.coin_y, v26);
            0x2::transfer::public_transfer<0x2::coin::Coin<T1>>(0x2::coin::take<T1>(&mut v15.coin_x, v24, arg4), 0x2::tx_context::sender(arg4));
            let v27 = 0x1::vector::empty<u64>();
            0x1::vector::push_back<u64>(&mut v27, 0);
            0x1::vector::push_back<u64>(&mut v27, v24);
            0x1::vector::push_back<u64>(&mut v27, v19);
            0x1::vector::push_back<u64>(&mut v27, 0);
            v27
        }
    }

    public entry fun update_pool_fee<T0, T1>(arg0: &mut AMMGlobal, arg1: &mut 0xd3fc3ab5f195dc72597a469f7ba2ab2aa754d28c6a70b785a6bd65a6b005151d::vault::ManagerCap, arg2: u128, arg3: u128) {
        get_mut_pool<T0, T1>(arg0, is_order<T0, T1>()).swap_fee = 0xd3fc3ab5f195dc72597a469f7ba2ab2aa754d28c6a70b785a6bd65a6b005151d::fixed_point64::create_from_rational(arg2, arg3);
    }

    public entry fun update_treasury(arg0: &mut AMMGlobal, arg1: &mut 0xd3fc3ab5f195dc72597a469f7ba2ab2aa754d28c6a70b785a6bd65a6b005151d::vault::ManagerCap, arg2: address) {
        arg0.treasury = arg2;
    }

    // decompiled from Move bytecode v6
}

