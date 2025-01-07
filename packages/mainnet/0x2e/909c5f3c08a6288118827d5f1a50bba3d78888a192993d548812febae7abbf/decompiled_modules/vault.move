module 0x2e909c5f3c08a6288118827d5f1a50bba3d78888a192993d548812febae7abbf::vault {
    struct AdminCap has store, key {
        id: 0x2::object::UID,
    }

    struct SwapRoute has store {
        route: vector<0x5ee65cecc4d42683b4da21eeea88539ce1c57e3871d0eeaf74f5feb8c3f39838::bag_value::Value>,
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

    public fun new<T0, T1, T2>(arg0: &0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool::Pool<T0, T1>, arg1: 0x2::coin::TreasuryCap<T2>, arg2: u64, arg3: u64, arg4: u64, arg5: &mut 0x2::tx_context::TxContext) {
        assert!(0x2::coin::total_supply<T2>(&arg1) == 0, 0);
        let v0 = Vault<T0, T1, T2>{
            id                        : 0x2::object::new(arg5),
            clmm_pool_id              : 0x2::object::id<0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool::Pool<T0, T1>>(arg0),
            treasury_cap              : arg1,
            free_balance_a            : 0x2::balance::zero<T0>(),
            free_balance_b            : 0x2::balance::zero<T1>(),
            rewards_bag               : 0x2::bag::new(arg5),
            seed_balance              : 0x2::balance::zero<T2>(),
            upper_price_scalling_fac  : arg2,
            lower_price_scalling_fac  : arg3,
            last_rebalance_sqrt_price : 0,
            min_rebalance_time        : arg4,
            last_rebalance_time       : 0,
            swap_routes               : 0x2::bag::new(arg5),
        };
        emit_event<T0, T1, T2>(&v0);
        0x2::transfer::share_object<Vault<T0, T1, T2>>(v0);
    }

    public(friend) fun total_supply<T0, T1, T2>(arg0: &Vault<T0, T1, T2>) : u64 {
        0x2::coin::total_supply<T2>(&arg0.treasury_cap)
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

    public(friend) fun add_swap_route<T0, T1, T2, T3>(arg0: &mut Vault<T0, T1, T2>, arg1: vector<0x5ee65cecc4d42683b4da21eeea88539ce1c57e3871d0eeaf74f5feb8c3f39838::bag_value::Value>, arg2: bool) {
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

    public fun free_balance_a_val<T0, T1, T2>(arg0: &Vault<T0, T1, T2>) : u64 {
        0x2::balance::value<T0>(&arg0.free_balance_a)
    }

    public fun free_balance_b_val<T0, T1, T2>(arg0: &Vault<T0, T1, T2>) : u64 {
        0x2::balance::value<T1>(&arg0.free_balance_b)
    }

    public(friend) fun get_free_balance_a<T0, T1, T2>(arg0: &mut Vault<T0, T1, T2>) : 0x2::balance::Balance<T0> {
        0x2::balance::split<T0>(&mut arg0.free_balance_a, free_balance_a_val<T0, T1, T2>(arg0))
    }

    public(friend) fun get_free_balance_b<T0, T1, T2>(arg0: &mut Vault<T0, T1, T2>) : 0x2::balance::Balance<T1> {
        0x2::balance::split<T1>(&mut arg0.free_balance_b, free_balance_a_val<T0, T1, T2>(arg0))
    }

    public fun get_position_assets<T0, T1, T2>(arg0: &Vault<T0, T1, T2>, arg1: &mut 0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool::Pool<T0, T1>) : (u64, u64) {
        0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool::get_position_amounts<T0, T1>(arg1, 0x2::object::id<0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::position::Position>(position_borrow<T0, T1, T2>(arg0)))
    }

    public(friend) fun get_reward_balance<T0, T1, T2, T3>(arg0: &mut Vault<T0, T1, T2>) : 0x2::balance::Balance<T3> {
        let v0 = 0x2::bag::borrow_mut<0x1::ascii::String, 0x2::balance::Balance<T3>>(&mut arg0.rewards_bag, 0x1::type_name::into_string(0x1::type_name::get<T3>()));
        0x2::balance::split<T3>(v0, 0x2::balance::value<T3>(v0))
    }

    public fun get_swap_route<T0, T1, T2, T3>(arg0: &Vault<T0, T1, T2>) : (vector<0x5ee65cecc4d42683b4da21eeea88539ce1c57e3871d0eeaf74f5feb8c3f39838::bag_value::Value>, bool) {
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
        while (!0x1::vector::is_empty<0x5ee65cecc4d42683b4da21eeea88539ce1c57e3871d0eeaf74f5feb8c3f39838::bag_value::Value>(&v3)) {
            let (_, _) = 0x5ee65cecc4d42683b4da21eeea88539ce1c57e3871d0eeaf74f5feb8c3f39838::bag_value::unwrap(0x1::vector::pop_back<0x5ee65cecc4d42683b4da21eeea88539ce1c57e3871d0eeaf74f5feb8c3f39838::bag_value::Value>(&mut v3));
        };
        0x1::vector::destroy_empty<0x5ee65cecc4d42683b4da21eeea88539ce1c57e3871d0eeaf74f5feb8c3f39838::bag_value::Value>(v3);
    }

    public fun scalling_factor() : u128 {
        (1000000 as u128)
    }

    public(friend) fun seed<T0, T1, T2>(arg0: &mut Vault<T0, T1, T2>, arg1: 0x2::balance::Balance<T2>) {
        assert!(0x2::balance::value<T2>(&arg0.seed_balance) == 0, 2);
        0x2::balance::join<T2>(&mut arg0.seed_balance, arg1);
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

