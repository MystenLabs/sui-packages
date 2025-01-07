module 0x96a97326ccd669412951ba9378f153121a909d8a1a536fe8da230039d05eab50::vault {
    struct AdminCap has store, key {
        id: 0x2::object::UID,
    }

    struct SwapRoute has store {
        route: vector<0x67eb137746b6ca899d2925dcc7d0f76a3ecd41fbcea279b112b63c8e2183f317::bag_value::Value>,
        returns_x: bool,
    }

    struct Vault<phantom T0, phantom T1, phantom T2> has key {
        id: 0x2::object::UID,
        clmm_pool_id: 0x2::object::ID,
        treasury_cap: 0x2::coin::TreasuryCap<T2>,
        free_balance_a: 0x2::balance::Balance<T0>,
        free_balance_b: 0x2::balance::Balance<T1>,
        rewards_bag: 0x2::bag::Bag,
        seed_balance: 0x2::balance::Balance<T2>,
        upper_price_scalling_fac: u64,
        lower_price_scalling_fac: u64,
        last_rebalance_sqrt_price: u128,
        min_rebalance_time: u64,
        last_rebalance_time: u64,
        swap_routes: 0x2::bag::Bag,
        free_threshold_a: u64,
        free_threshold_b: u64,
        fee_a: 0x2::balance::Balance<T0>,
        fee_b: 0x2::balance::Balance<T1>,
        fee_val: u64,
    }

    struct VaultCreatedEvent has copy, drop {
        id: 0x2::object::ID,
        clmm_pool_id: 0x2::object::ID,
        type_a: 0x1::type_name::TypeName,
        type_b: 0x1::type_name::TypeName,
        type_v: 0x1::type_name::TypeName,
        upper_price_scalling_fac: u64,
        lower_price_scalling_fac: u64,
        min_rebalance_time: u64,
    }

    public fun new<T0, T1, T2>(arg0: &0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool::Pool<T0, T1>, arg1: 0x2::coin::TreasuryCap<T2>, arg2: u64, arg3: u64, arg4: u64, arg5: u64, arg6: u64, arg7: u64, arg8: &mut 0x2::tx_context::TxContext) {
        assert!(0x2::coin::total_supply<T2>(&arg1) == 0, 0);
        let v0 = Vault<T0, T1, T2>{
            id                        : 0x2::object::new(arg8),
            clmm_pool_id              : 0x2::object::id<0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool::Pool<T0, T1>>(arg0),
            treasury_cap              : arg1,
            free_balance_a            : 0x2::balance::zero<T0>(),
            free_balance_b            : 0x2::balance::zero<T1>(),
            rewards_bag               : 0x2::bag::new(arg8),
            seed_balance              : 0x2::balance::zero<T2>(),
            upper_price_scalling_fac  : arg2,
            lower_price_scalling_fac  : arg3,
            last_rebalance_sqrt_price : 0,
            min_rebalance_time        : arg7,
            last_rebalance_time       : 0,
            swap_routes               : 0x2::bag::new(arg8),
            free_threshold_a          : arg4,
            free_threshold_b          : arg5,
            fee_a                     : 0x2::balance::zero<T0>(),
            fee_b                     : 0x2::balance::zero<T1>(),
            fee_val                   : arg6,
        };
        emit_event<T0, T1, T2>(&v0);
        0x2::transfer::share_object<Vault<T0, T1, T2>>(v0);
    }

    public(friend) fun total_supply<T0, T1, T2>(arg0: &Vault<T0, T1, T2>) : u64 {
        0x2::coin::total_supply<T2>(&arg0.treasury_cap)
    }

    public fun get_amount_by_liquidity<T0, T1, T2>(arg0: &Vault<T0, T1, T2>, arg1: &0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool::Pool<T0, T1>, arg2: bool) : (u64, u64) {
        let (v0, v1) = 0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::position::tick_range(position_borrow<T0, T1, T2>(arg0));
        let v2 = if (arg2) {
            0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::position::liquidity(position_borrow<T0, T1, T2>(arg0))
        } else {
            0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool::liquidity<T0, T1>(arg1)
        };
        0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool::get_amount_by_liquidity(v0, v1, 0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool::current_tick_index<T0, T1>(arg1), 0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool::current_sqrt_price<T0, T1>(arg1), v2, true)
    }

    public(friend) fun add_fee_a<T0, T1, T2>(arg0: &mut Vault<T0, T1, T2>, arg1: 0x2::balance::Balance<T0>) {
        0x2::balance::join<T0>(&mut arg0.fee_a, arg1);
    }

    public(friend) fun add_fee_b<T0, T1, T2>(arg0: &mut Vault<T0, T1, T2>, arg1: 0x2::balance::Balance<T1>) {
        0x2::balance::join<T1>(&mut arg0.fee_b, arg1);
    }

    public(friend) fun add_free_balance_a<T0, T1, T2>(arg0: &mut Vault<T0, T1, T2>, arg1: 0x2::balance::Balance<T0>) {
        0x2::balance::join<T0>(&mut arg0.free_balance_a, arg1);
    }

    public(friend) fun add_free_balance_b<T0, T1, T2>(arg0: &mut Vault<T0, T1, T2>, arg1: 0x2::balance::Balance<T1>) {
        0x2::balance::join<T1>(&mut arg0.free_balance_b, arg1);
    }

    public fun add_reward<T0, T1, T2, T3>(arg0: &mut Vault<T0, T1, T2>, arg1: 0x2::balance::Balance<T3>) {
        let v0 = 0x1::type_name::into_string(0x1::type_name::get<T3>());
        assert!(v0 != 0x1::type_name::into_string(0x1::type_name::get<T0>()), 1);
        assert!(v0 != 0x1::type_name::into_string(0x1::type_name::get<T1>()), 1);
        if (0x2::bag::contains<0x1::ascii::String>(&arg0.rewards_bag, v0)) {
            0x2::balance::join<T3>(0x2::bag::borrow_mut<0x1::ascii::String, 0x2::balance::Balance<T3>>(&mut arg0.rewards_bag, v0), arg1);
        } else {
            0x2::bag::add<0x1::ascii::String, 0x2::balance::Balance<T3>>(&mut arg0.rewards_bag, v0, arg1);
        };
    }

    public fun add_reward_x<T0, T1, T2>(arg0: &mut Vault<T0, T1, T2>, arg1: 0x2::balance::Balance<T0>) {
        0x2::balance::join<T0>(&mut arg0.free_balance_a, arg1);
    }

    public fun add_reward_y<T0, T1, T2>(arg0: &mut Vault<T0, T1, T2>, arg1: 0x2::balance::Balance<T1>) {
        0x2::balance::join<T1>(&mut arg0.free_balance_b, arg1);
    }

    public(friend) fun add_swap_route<T0, T1, T2, T3>(arg0: &mut Vault<T0, T1, T2>, arg1: vector<0x67eb137746b6ca899d2925dcc7d0f76a3ecd41fbcea279b112b63c8e2183f317::bag_value::Value>, arg2: bool) {
        let v0 = 0x1::type_name::into_string(0x1::type_name::get<T3>());
        assert!(v0 != 0x1::type_name::into_string(0x1::type_name::get<T0>()), 3);
        assert!(v0 != 0x1::type_name::into_string(0x1::type_name::get<T1>()), 3);
        assert!(!0x2::bag::contains<0x1::ascii::String>(&arg0.swap_routes, v0), 3);
        let v1 = SwapRoute{
            route     : arg1,
            returns_x : arg2,
        };
        0x2::bag::add<0x1::ascii::String, SwapRoute>(&mut arg0.swap_routes, v0, v1);
    }

    public(friend) fun burn_vault_coin<T0, T1, T2>(arg0: &mut Vault<T0, T1, T2>, arg1: 0x2::coin::Coin<T2>) {
        0x2::coin::burn<T2>(&mut arg0.treasury_cap, arg1);
    }

    public fun calc_fee<T0, T1, T2>(arg0: &Vault<T0, T1, T2>, arg1: u64) : u64 {
        (((arg1 as u128) * (arg0.fee_val as u128) / (1000000 as u128)) as u64)
    }

    fun closer(arg0: u128, arg1: u128, arg2: u128) : bool {
        if (arg0 > arg2 && arg1 > arg2) {
            arg0 - arg2 < arg1 - arg2
        } else if (arg0 < arg2 && arg1 < arg2) {
            arg2 - arg0 < arg2 - arg1
        } else {
            let v1 = if (arg0 > arg2) {
                arg0 - arg2
            } else {
                arg2 - arg0
            };
            let v2 = if (arg1 > arg2) {
                arg1 - arg2
            } else {
                arg2 - arg1
            };
            v1 < v2
        }
    }

    fun emit_event<T0, T1, T2>(arg0: &Vault<T0, T1, T2>) {
        let v0 = VaultCreatedEvent{
            id                       : 0x2::object::id<Vault<T0, T1, T2>>(arg0),
            clmm_pool_id             : arg0.clmm_pool_id,
            type_a                   : 0x1::type_name::get<T0>(),
            type_b                   : 0x1::type_name::get<T1>(),
            type_v                   : 0x1::type_name::get<T2>(),
            upper_price_scalling_fac : arg0.upper_price_scalling_fac,
            lower_price_scalling_fac : arg0.lower_price_scalling_fac,
            min_rebalance_time       : arg0.min_rebalance_time,
        };
        0x2::event::emit<VaultCreatedEvent>(v0);
    }

    public fun fee_val<T0, T1, T2>(arg0: &Vault<T0, T1, T2>) : u64 {
        arg0.fee_val
    }

    public fun free_balance_a_val<T0, T1, T2>(arg0: &Vault<T0, T1, T2>) : u64 {
        0x2::balance::value<T0>(&arg0.free_balance_a)
    }

    public fun free_balance_b_val<T0, T1, T2>(arg0: &Vault<T0, T1, T2>) : u64 {
        0x2::balance::value<T1>(&arg0.free_balance_b)
    }

    public fun free_threshold_a<T0, T1, T2>(arg0: &Vault<T0, T1, T2>) : u64 {
        arg0.free_threshold_a
    }

    public fun free_threshold_b<T0, T1, T2>(arg0: &Vault<T0, T1, T2>) : u64 {
        arg0.free_threshold_b
    }

    public(friend) fun get_free_balance_a<T0, T1, T2>(arg0: &mut Vault<T0, T1, T2>) : 0x2::balance::Balance<T0> {
        0x2::balance::split<T0>(&mut arg0.free_balance_a, free_balance_a_val<T0, T1, T2>(arg0))
    }

    public(friend) fun get_free_balance_b<T0, T1, T2>(arg0: &mut Vault<T0, T1, T2>) : 0x2::balance::Balance<T1> {
        0x2::balance::split<T1>(&mut arg0.free_balance_b, free_balance_a_val<T0, T1, T2>(arg0))
    }

    public fun get_optimal_swap_amount_for_single_sided_liquidity<T0, T1, T2>(arg0: &Vault<T0, T1, T2>, arg1: &0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool::Pool<T0, T1>, arg2: u64, arg3: bool, arg4: u64) : u64 {
        let (v0, v1) = get_amount_by_liquidity<T0, T1, T2>(arg0, arg1, true);
        let v2 = 1000000;
        let v3 = (v0 as u128) * (v2 as u128) / (v1 as u128);
        let v4 = 0;
        let v5 = arg2 / 2;
        let v6 = 1;
        let v7 = v6;
        while (v4 < arg4) {
            let v8 = 0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool::calculate_swap_result<T0, T1>(arg1, arg3, true, v5);
            let v9 = 0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool::calculated_swap_result_amount_out(&v8);
            let v10 = if (arg3) {
                arg2 - v5
            } else {
                v9
            };
            let v11 = if (arg3) {
                v9
            } else {
                arg2 - v5
            };
            let v12 = (v10 as u128) * (v2 as u128) / (v11 as u128);
            if (v4 == 0) {
                v7 = v12;
            } else {
                if (closer(v12, v6, v3)) {
                    v7 = v12;
                };
                if (v7 > v3) {
                    if (arg3) {
                        let v13 = v5 / 2;
                        v5 = v5 + v13;
                    } else {
                        let v14 = v5 / 2;
                        v5 = v5 - v14;
                    };
                } else if (arg3) {
                    let v15 = v5 / 2;
                    v5 = v5 - v15;
                } else {
                    let v16 = v5 / 2;
                    v5 = v5 + v16;
                };
            };
            v4 = v4 + 1;
        };
        v5
    }

    public fun get_position_assets<T0, T1, T2>(arg0: &Vault<T0, T1, T2>, arg1: &mut 0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool::Pool<T0, T1>) : (u64, u64) {
        0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool::get_position_amounts<T0, T1>(arg1, 0x2::object::id<0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::position::Position>(position_borrow<T0, T1, T2>(arg0)))
    }

    public(friend) fun get_reward_balance<T0, T1, T2, T3>(arg0: &mut Vault<T0, T1, T2>) : 0x2::balance::Balance<T3> {
        let v0 = 0x2::bag::borrow_mut<0x1::ascii::String, 0x2::balance::Balance<T3>>(&mut arg0.rewards_bag, 0x1::type_name::into_string(0x1::type_name::get<T3>()));
        0x2::balance::split<T3>(v0, 0x2::balance::value<T3>(v0))
    }

    public fun get_swap_route<T0, T1, T2, T3>(arg0: &Vault<T0, T1, T2>) : (vector<0x67eb137746b6ca899d2925dcc7d0f76a3ecd41fbcea279b112b63c8e2183f317::bag_value::Value>, bool) {
        let v0 = 0x1::type_name::into_string(0x1::type_name::get<T3>());
        assert!(0x2::bag::contains<0x1::ascii::String>(&arg0.swap_routes, v0), 3);
        let v1 = 0x2::bag::borrow<0x1::ascii::String, SwapRoute>(&arg0.swap_routes, v0);
        (v1.route, v1.returns_x)
    }

    fun init(arg0: &mut 0x2::tx_context::TxContext) {
        let v0 = AdminCap{id: 0x2::object::new(arg0)};
        0x2::transfer::transfer<AdminCap>(v0, 0x2::tx_context::sender(arg0));
    }

    public(friend) fun insert_position<T0, T1, T2>(arg0: &mut Vault<T0, T1, T2>, arg1: 0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::position::Position) {
        0x2::dynamic_field::add<vector<u8>, 0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::position::Position>(&mut arg0.id, b"position", arg1);
    }

    public fun last_rebalance_sqrt_price<T0, T1, T2>(arg0: &Vault<T0, T1, T2>) : u128 {
        arg0.last_rebalance_sqrt_price
    }

    public fun last_rebalance_time<T0, T1, T2>(arg0: &Vault<T0, T1, T2>) : u64 {
        arg0.last_rebalance_time
    }

    public fun lower_price_scalling_fac<T0, T1, T2>(arg0: &Vault<T0, T1, T2>) : u64 {
        arg0.lower_price_scalling_fac
    }

    public fun min_rebalance_time<T0, T1, T2>(arg0: &Vault<T0, T1, T2>) : u64 {
        arg0.min_rebalance_time
    }

    public(friend) fun mint_vault_coin<T0, T1, T2>(arg0: &mut Vault<T0, T1, T2>, arg1: u128, arg2: u128, arg3: &mut 0x2::tx_context::TxContext) : 0x2::coin::Coin<T2> {
        0x2::coin::mint<T2>(&mut arg0.treasury_cap, ((arg1 * (total_supply<T0, T1, T2>(arg0) as u128) / arg2) as u64), arg3)
    }

    public(friend) fun mint_vault_coin_unsafe<T0, T1, T2>(arg0: &mut Vault<T0, T1, T2>, arg1: u64, arg2: &mut 0x2::tx_context::TxContext) : 0x2::coin::Coin<T2> {
        0x2::coin::mint<T2>(&mut arg0.treasury_cap, arg1, arg2)
    }

    public(friend) fun position_borrow<T0, T1, T2>(arg0: &Vault<T0, T1, T2>) : &0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::position::Position {
        0x2::dynamic_field::borrow<vector<u8>, 0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::position::Position>(&arg0.id, b"position")
    }

    public(friend) fun position_borrow_mut<T0, T1, T2>(arg0: &mut Vault<T0, T1, T2>) : &mut 0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::position::Position {
        0x2::dynamic_field::borrow_mut<vector<u8>, 0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::position::Position>(&mut arg0.id, b"position")
    }

    public fun position_id<T0, T1, T2>(arg0: &Vault<T0, T1, T2>) : 0x2::object::ID {
        0x2::object::id<0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::position::Position>(0x2::dynamic_field::borrow<vector<u8>, 0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::position::Position>(&arg0.id, b"position"))
    }

    public(friend) fun remove_position<T0, T1, T2>(arg0: &mut Vault<T0, T1, T2>) : 0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::position::Position {
        0x2::dynamic_field::remove<vector<u8>, 0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::position::Position>(&mut arg0.id, b"position")
    }

    public(friend) fun remove_swap_route<T0, T1, T2, T3>(arg0: &mut Vault<T0, T1, T2>) {
        let v0 = 0x1::type_name::into_string(0x1::type_name::get<T3>());
        assert!(v0 != 0x1::type_name::into_string(0x1::type_name::get<T0>()), 3);
        assert!(v0 != 0x1::type_name::into_string(0x1::type_name::get<T1>()), 3);
        assert!(0x2::bag::contains<0x1::ascii::String>(&arg0.swap_routes, v0), 3);
        let SwapRoute {
            route     : v1,
            returns_x : _,
        } = 0x2::bag::remove<0x1::ascii::String, SwapRoute>(&mut arg0.swap_routes, v0);
        let v3 = v1;
        while (!0x1::vector::is_empty<0x67eb137746b6ca899d2925dcc7d0f76a3ecd41fbcea279b112b63c8e2183f317::bag_value::Value>(&v3)) {
            let (_, _) = 0x67eb137746b6ca899d2925dcc7d0f76a3ecd41fbcea279b112b63c8e2183f317::bag_value::unwrap(0x1::vector::pop_back<0x67eb137746b6ca899d2925dcc7d0f76a3ecd41fbcea279b112b63c8e2183f317::bag_value::Value>(&mut v3));
        };
        0x1::vector::destroy_empty<0x67eb137746b6ca899d2925dcc7d0f76a3ecd41fbcea279b112b63c8e2183f317::bag_value::Value>(v3);
    }

    public fun scalling_factor() : u128 {
        (1000000 as u128)
    }

    public(friend) fun seed<T0, T1, T2>(arg0: &mut Vault<T0, T1, T2>, arg1: 0x2::balance::Balance<T2>) {
        assert!(0x2::balance::value<T2>(&arg0.seed_balance) == 0, 2);
        0x2::balance::join<T2>(&mut arg0.seed_balance, arg1);
    }

    public fun seed_balance<T0, T1, T2>(arg0: &Vault<T0, T1, T2>) : u64 {
        0x2::balance::value<T2>(&arg0.seed_balance)
    }

    public(friend) fun set_rebalance_time<T0, T1, T2>(arg0: &mut Vault<T0, T1, T2>, arg1: u64) {
        arg0.last_rebalance_time = arg1;
    }

    public fun swap_route_returns_x<T0, T1, T2, T3>(arg0: &Vault<T0, T1, T2>) : bool {
        let v0 = 0x1::type_name::into_string(0x1::type_name::get<T3>());
        assert!(0x2::bag::contains<0x1::ascii::String>(&arg0.swap_routes, v0), 3);
        0x2::bag::borrow<0x1::ascii::String, SwapRoute>(&arg0.swap_routes, v0).returns_x
    }

    public(friend) fun tc_borrow_mut<T0, T1, T2>(arg0: &mut Vault<T0, T1, T2>) : &mut 0x2::coin::TreasuryCap<T2> {
        &mut arg0.treasury_cap
    }

    public fun upper_price_scalling_fac<T0, T1, T2>(arg0: &Vault<T0, T1, T2>) : u64 {
        arg0.upper_price_scalling_fac
    }

    // decompiled from Move bytecode v6
}

