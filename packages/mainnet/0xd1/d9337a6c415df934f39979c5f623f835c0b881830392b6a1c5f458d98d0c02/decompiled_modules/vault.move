module 0xd1d9337a6c415df934f39979c5f623f835c0b881830392b6a1c5f458d98d0c02::vault {
    struct AdminCap has store, key {
        id: 0x2::object::UID,
    }

    struct VaultCap has store, key {
        id: 0x2::object::UID,
        vault_id: 0x2::object::ID,
        is_initialised: bool,
    }

    struct RebalanceCap has store, key {
        id: 0x2::object::UID,
        vault_id: 0x2::object::ID,
        whitelisted_address: address,
    }

    struct SwapRoute has store {
        route: vector<0x360802cb106b004205cd67a706e314eaeadd8590d5f4d1cee46137566232a627::bag_value::Value>,
        returns_x: bool,
    }

    struct Vault<phantom T0, phantom T1, phantom T2> has key {
        id: 0x2::object::UID,
        treasury_cap: 0x2::coin::TreasuryCap<T2>,
        free_balance_a: 0x2::balance::Balance<T0>,
        free_balance_b: 0x2::balance::Balance<T1>,
        fee_a: 0x2::balance::Balance<T0>,
        fee_b: 0x2::balance::Balance<T1>,
        seed_balance: 0x2::balance::Balance<T2>,
        rewards_bag: 0x2::bag::Bag,
        swap_routes: 0x2::bag::Bag,
        clmm_pool_id: 0x2::object::ID,
        lower_tick: u32,
        upper_tick: u32,
        last_rebalance_sqrt_price: u128,
        lower_trigger_price: u128,
        upper_trigger_price: u128,
        last_rebalance_time: u64,
        upper_price_scalling: u128,
        lower_price_scalling: u128,
        upper_trigger_price_scalling: u128,
        lower_trigger_price_scalling: u128,
        slippage_up: u128,
        slippage_down: u128,
        free_threshold_a: u64,
        free_threshold_b: u64,
        fee_val: u64,
    }

    struct VaultCreatedEvent has copy, drop {
        id: 0x2::object::ID,
        clmm_pool_id: 0x2::object::ID,
        type_a: 0x1::type_name::TypeName,
        type_b: 0x1::type_name::TypeName,
        type_v: 0x1::type_name::TypeName,
        upper_price_scalling: u128,
        lower_price_scalling: u128,
        upper_trigger_price_scalling: u128,
        lower_trigger_price_scalling: u128,
        slippage_up: u128,
        slippage_down: u128,
        free_threshold_a: u64,
        free_threshold_b: u64,
        fee_val: u64,
    }

    public fun new<T0, T1, T2>(arg0: &0xf6c05e2d9301e6e91dc6ab6c3ca918f7d55896e1f1edd64adc0e615cde27ebf1::pool::Pool<T0, T1>, arg1: 0x2::coin::TreasuryCap<T2>, arg2: u128, arg3: u128, arg4: u128, arg5: u128, arg6: u128, arg7: u128, arg8: u64, arg9: u64, arg10: u64, arg11: &mut 0x2::tx_context::TxContext) {
        assert!(0x2::coin::total_supply<T2>(&arg1) == 0, 0);
        assert!(arg4 > arg5, 9);
        assert!(arg2 > arg3, 10);
        let v0 = Vault<T0, T1, T2>{
            id                           : 0x2::object::new(arg11),
            treasury_cap                 : arg1,
            free_balance_a               : 0x2::balance::zero<T0>(),
            free_balance_b               : 0x2::balance::zero<T1>(),
            fee_a                        : 0x2::balance::zero<T0>(),
            fee_b                        : 0x2::balance::zero<T1>(),
            seed_balance                 : 0x2::balance::zero<T2>(),
            rewards_bag                  : 0x2::bag::new(arg11),
            swap_routes                  : 0x2::bag::new(arg11),
            clmm_pool_id                 : 0x2::object::id<0xf6c05e2d9301e6e91dc6ab6c3ca918f7d55896e1f1edd64adc0e615cde27ebf1::pool::Pool<T0, T1>>(arg0),
            lower_tick                   : 0,
            upper_tick                   : 0,
            last_rebalance_sqrt_price    : 0,
            lower_trigger_price          : 0,
            upper_trigger_price          : 0,
            last_rebalance_time          : 0,
            upper_price_scalling         : arg2,
            lower_price_scalling         : arg3,
            upper_trigger_price_scalling : arg4,
            lower_trigger_price_scalling : arg5,
            slippage_up                  : arg6,
            slippage_down                : arg7,
            free_threshold_a             : arg8,
            free_threshold_b             : arg9,
            fee_val                      : arg10,
        };
        0x2::dynamic_field::add<vector<u8>, bool>(&mut v0.id, b"deposit_enabled", true);
        let v1 = VaultCap{
            id             : 0x2::object::new(arg11),
            vault_id       : 0x2::object::id<Vault<T0, T1, T2>>(&v0),
            is_initialised : false,
        };
        emit_event<T0, T1, T2>(&v0);
        0x2::transfer::share_object<Vault<T0, T1, T2>>(v0);
        0x2::transfer::transfer<VaultCap>(v1, 0x2::tx_context::sender(arg11));
    }

    public(friend) fun total_supply<T0, T1, T2>(arg0: &Vault<T0, T1, T2>) : u64 {
        0x2::coin::total_supply<T2>(&arg0.treasury_cap)
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

    public(friend) fun add_swap_route<T0, T1, T2, T3>(arg0: &mut Vault<T0, T1, T2>, arg1: vector<0x360802cb106b004205cd67a706e314eaeadd8590d5f4d1cee46137566232a627::bag_value::Value>, arg2: bool) {
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

    public fun assert_rebalance_cap<T0, T1, T2>(arg0: &Vault<T0, T1, T2>, arg1: &RebalanceCap, arg2: &mut 0x2::tx_context::TxContext) {
        assert!(0x2::object::id<Vault<T0, T1, T2>>(arg0) == arg1.vault_id, 7);
        assert!(arg1.whitelisted_address == 0x2::tx_context::sender(arg2), 8);
    }

    public(friend) fun burn_vault_coin<T0, T1, T2>(arg0: &mut Vault<T0, T1, T2>, arg1: 0x2::coin::Coin<T2>) {
        0x2::coin::burn<T2>(&mut arg0.treasury_cap, arg1);
    }

    public fun calc_fee<T0, T1, T2>(arg0: &Vault<T0, T1, T2>, arg1: u64) : u64 {
        (((arg1 as u128) * (arg0.fee_val as u128) / (1000000 as u128)) as u64)
    }

    public fun check_pool_compatibility<T0, T1, T2>(arg0: &Vault<T0, T1, T2>, arg1: &0xf6c05e2d9301e6e91dc6ab6c3ca918f7d55896e1f1edd64adc0e615cde27ebf1::pool::Pool<T0, T1>) {
        assert!(arg0.clmm_pool_id == 0x2::object::id<0xf6c05e2d9301e6e91dc6ab6c3ca918f7d55896e1f1edd64adc0e615cde27ebf1::pool::Pool<T0, T1>>(arg1), 4);
    }

    public fun check_vault_cap_compatibility<T0, T1, T2>(arg0: &Vault<T0, T1, T2>, arg1: &VaultCap) {
        assert!(arg1.vault_id == 0x2::object::id<Vault<T0, T1, T2>>(arg0), 6);
    }

    public fun check_vault_cap_uninitialised(arg0: &VaultCap) {
        assert!(arg0.is_initialised == false, 6);
    }

    fun emit_event<T0, T1, T2>(arg0: &Vault<T0, T1, T2>) {
        let v0 = VaultCreatedEvent{
            id                           : 0x2::object::id<Vault<T0, T1, T2>>(arg0),
            clmm_pool_id                 : arg0.clmm_pool_id,
            type_a                       : 0x1::type_name::get<T0>(),
            type_b                       : 0x1::type_name::get<T1>(),
            type_v                       : 0x1::type_name::get<T2>(),
            upper_price_scalling         : arg0.upper_price_scalling,
            lower_price_scalling         : arg0.lower_price_scalling,
            upper_trigger_price_scalling : arg0.upper_trigger_price_scalling,
            lower_trigger_price_scalling : arg0.lower_trigger_price_scalling,
            slippage_up                  : arg0.slippage_up,
            slippage_down                : arg0.slippage_down,
            free_threshold_a             : arg0.free_threshold_a,
            free_threshold_b             : arg0.free_threshold_b,
            fee_val                      : arg0.fee_val,
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

    public fun get_amount_by_liquidity<T0, T1, T2>(arg0: &Vault<T0, T1, T2>, arg1: &0xf6c05e2d9301e6e91dc6ab6c3ca918f7d55896e1f1edd64adc0e615cde27ebf1::pool::Pool<T0, T1>, arg2: bool) : (u64, u64) {
        let v0 = position_borrow<T0, T1, T2>(arg0);
        let v1 = if (arg2) {
            0xf6c05e2d9301e6e91dc6ab6c3ca918f7d55896e1f1edd64adc0e615cde27ebf1::position::liquidity(v0)
        } else {
            0xf6c05e2d9301e6e91dc6ab6c3ca918f7d55896e1f1edd64adc0e615cde27ebf1::pool::liquidity<T0, T1>(arg1)
        };
        0xf6c05e2d9301e6e91dc6ab6c3ca918f7d55896e1f1edd64adc0e615cde27ebf1::liquidity_math::get_amounts_for_liquidity(0xf6c05e2d9301e6e91dc6ab6c3ca918f7d55896e1f1edd64adc0e615cde27ebf1::pool::sqrt_price<T0, T1>(arg1), 0xf6c05e2d9301e6e91dc6ab6c3ca918f7d55896e1f1edd64adc0e615cde27ebf1::tick_math::get_sqrt_price_at_tick(0xf6c05e2d9301e6e91dc6ab6c3ca918f7d55896e1f1edd64adc0e615cde27ebf1::position::tick_lower_index(v0)), 0xf6c05e2d9301e6e91dc6ab6c3ca918f7d55896e1f1edd64adc0e615cde27ebf1::tick_math::get_sqrt_price_at_tick(0xf6c05e2d9301e6e91dc6ab6c3ca918f7d55896e1f1edd64adc0e615cde27ebf1::position::tick_upper_index(v0)), v1, false)
    }

    public(friend) fun get_free_balance_a<T0, T1, T2>(arg0: &mut Vault<T0, T1, T2>) : 0x2::balance::Balance<T0> {
        0x2::balance::split<T0>(&mut arg0.free_balance_a, free_balance_a_val<T0, T1, T2>(arg0))
    }

    public(friend) fun get_free_balance_b<T0, T1, T2>(arg0: &mut Vault<T0, T1, T2>) : 0x2::balance::Balance<T1> {
        0x2::balance::split<T1>(&mut arg0.free_balance_b, free_balance_b_val<T0, T1, T2>(arg0))
    }

    public fun get_optimal_swap_amount_for_single_sided_liquidity<T0, T1, T2>(arg0: &Vault<T0, T1, T2>, arg1: &0xf6c05e2d9301e6e91dc6ab6c3ca918f7d55896e1f1edd64adc0e615cde27ebf1::pool::Pool<T0, T1>, arg2: u64, arg3: bool, arg4: u64) : (u64, bool) {
        let v0 = if (arg3) {
            4295048017
        } else {
            79226673515401279992447579054
        };
        0xf6c05e2d9301e6e91dc6ab6c3ca918f7d55896e1f1edd64adc0e615cde27ebf1::trade::get_optimal_swap_amount_for_single_sided_liquidity<T0, T1>(arg1, arg2, position_borrow<T0, T1, T2>(arg0), v0, arg3, arg4)
    }

    public fun get_position_tick_range<T0, T1, T2>(arg0: &Vault<T0, T1, T2>) : (0xf6c05e2d9301e6e91dc6ab6c3ca918f7d55896e1f1edd64adc0e615cde27ebf1::i32::I32, 0xf6c05e2d9301e6e91dc6ab6c3ca918f7d55896e1f1edd64adc0e615cde27ebf1::i32::I32) {
        let v0 = position_borrow<T0, T1, T2>(arg0);
        (0xf6c05e2d9301e6e91dc6ab6c3ca918f7d55896e1f1edd64adc0e615cde27ebf1::position::tick_lower_index(v0), 0xf6c05e2d9301e6e91dc6ab6c3ca918f7d55896e1f1edd64adc0e615cde27ebf1::position::tick_upper_index(v0))
    }

    public(friend) fun get_reward_balance<T0, T1, T2, T3>(arg0: &mut Vault<T0, T1, T2>) : 0x2::balance::Balance<T3> {
        let v0 = 0x2::bag::borrow_mut<0x1::ascii::String, 0x2::balance::Balance<T3>>(&mut arg0.rewards_bag, 0x1::type_name::into_string(0x1::type_name::get<T3>()));
        0x2::balance::split<T3>(v0, 0x2::balance::value<T3>(v0))
    }

    public fun get_swap_route<T0, T1, T2, T3>(arg0: &Vault<T0, T1, T2>) : (vector<0x360802cb106b004205cd67a706e314eaeadd8590d5f4d1cee46137566232a627::bag_value::Value>, bool) {
        let v0 = 0x1::type_name::into_string(0x1::type_name::get<T3>());
        assert!(0x2::bag::contains<0x1::ascii::String>(&arg0.swap_routes, v0), 3);
        let v1 = 0x2::bag::borrow<0x1::ascii::String, SwapRoute>(&arg0.swap_routes, v0);
        (v1.route, v1.returns_x)
    }

    fun init(arg0: &mut 0x2::tx_context::TxContext) {
        let v0 = AdminCap{id: 0x2::object::new(arg0)};
        0x2::transfer::transfer<AdminCap>(v0, 0x2::tx_context::sender(arg0));
    }

    public(friend) fun insert_position<T0, T1, T2>(arg0: &mut Vault<T0, T1, T2>, arg1: 0xf6c05e2d9301e6e91dc6ab6c3ca918f7d55896e1f1edd64adc0e615cde27ebf1::position::Position) {
        0x2::dynamic_field::add<vector<u8>, 0xf6c05e2d9301e6e91dc6ab6c3ca918f7d55896e1f1edd64adc0e615cde27ebf1::position::Position>(&mut arg0.id, b"position", arg1);
    }

    public fun is_deposit_enabled<T0, T1, T2>(arg0: &Vault<T0, T1, T2>) : bool {
        *0x2::dynamic_field::borrow<vector<u8>, bool>(&arg0.id, b"deposit_enabled")
    }

    public fun issue_rebalance_cap(arg0: &VaultCap, arg1: address, arg2: &0xd1d9337a6c415df934f39979c5f623f835c0b881830392b6a1c5f458d98d0c02::version::Version, arg3: &mut 0x2::tx_context::TxContext) {
        0xd1d9337a6c415df934f39979c5f623f835c0b881830392b6a1c5f458d98d0c02::version::assert_supported_version(arg2);
        let v0 = RebalanceCap{
            id                  : 0x2::object::new(arg3),
            vault_id            : arg0.vault_id,
            whitelisted_address : arg1,
        };
        0x2::transfer::share_object<RebalanceCap>(v0);
    }

    public fun last_rebalance_sqrt_price<T0, T1, T2>(arg0: &Vault<T0, T1, T2>) : u128 {
        arg0.last_rebalance_sqrt_price
    }

    public fun last_rebalance_time<T0, T1, T2>(arg0: &Vault<T0, T1, T2>) : u64 {
        arg0.last_rebalance_time
    }

    public fun lower_price_scalling<T0, T1, T2>(arg0: &Vault<T0, T1, T2>) : u128 {
        arg0.lower_price_scalling
    }

    public fun lower_trigger_price<T0, T1, T2>(arg0: &Vault<T0, T1, T2>) : u128 {
        arg0.lower_trigger_price
    }

    public fun lower_trigger_price_scalling<T0, T1, T2>(arg0: &Vault<T0, T1, T2>) : u128 {
        arg0.lower_trigger_price_scalling
    }

    public(friend) fun mint_vault_coin<T0, T1, T2>(arg0: &mut Vault<T0, T1, T2>, arg1: u128, arg2: u128, arg3: &mut 0x2::tx_context::TxContext) : 0x2::coin::Coin<T2> {
        let v0 = ((arg1 * (total_supply<T0, T1, T2>(arg0) as u128) / arg2) as u64);
        assert!(v0 > 0, 5);
        0x2::coin::mint<T2>(&mut arg0.treasury_cap, v0, arg3)
    }

    public(friend) fun mint_vault_coin_unsafe<T0, T1, T2>(arg0: &mut Vault<T0, T1, T2>, arg1: u64, arg2: &mut 0x2::tx_context::TxContext) : 0x2::coin::Coin<T2> {
        0x2::coin::mint<T2>(&mut arg0.treasury_cap, arg1, arg2)
    }

    public(friend) fun position_borrow<T0, T1, T2>(arg0: &Vault<T0, T1, T2>) : &0xf6c05e2d9301e6e91dc6ab6c3ca918f7d55896e1f1edd64adc0e615cde27ebf1::position::Position {
        0x2::dynamic_field::borrow<vector<u8>, 0xf6c05e2d9301e6e91dc6ab6c3ca918f7d55896e1f1edd64adc0e615cde27ebf1::position::Position>(&arg0.id, b"position")
    }

    public(friend) fun position_borrow_mut<T0, T1, T2>(arg0: &mut Vault<T0, T1, T2>) : &mut 0xf6c05e2d9301e6e91dc6ab6c3ca918f7d55896e1f1edd64adc0e615cde27ebf1::position::Position {
        0x2::dynamic_field::borrow_mut<vector<u8>, 0xf6c05e2d9301e6e91dc6ab6c3ca918f7d55896e1f1edd64adc0e615cde27ebf1::position::Position>(&mut arg0.id, b"position")
    }

    public fun position_id<T0, T1, T2>(arg0: &Vault<T0, T1, T2>) : 0x2::object::ID {
        0x2::object::id<0xf6c05e2d9301e6e91dc6ab6c3ca918f7d55896e1f1edd64adc0e615cde27ebf1::position::Position>(0x2::dynamic_field::borrow<vector<u8>, 0xf6c05e2d9301e6e91dc6ab6c3ca918f7d55896e1f1edd64adc0e615cde27ebf1::position::Position>(&arg0.id, b"position"))
    }

    public(friend) fun remove_position<T0, T1, T2>(arg0: &mut Vault<T0, T1, T2>) : 0xf6c05e2d9301e6e91dc6ab6c3ca918f7d55896e1f1edd64adc0e615cde27ebf1::position::Position {
        0x2::dynamic_field::remove<vector<u8>, 0xf6c05e2d9301e6e91dc6ab6c3ca918f7d55896e1f1edd64adc0e615cde27ebf1::position::Position>(&mut arg0.id, b"position")
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
        while (!0x1::vector::is_empty<0x360802cb106b004205cd67a706e314eaeadd8590d5f4d1cee46137566232a627::bag_value::Value>(&v3)) {
            let (_, _) = 0x360802cb106b004205cd67a706e314eaeadd8590d5f4d1cee46137566232a627::bag_value::unwrap(0x1::vector::pop_back<0x360802cb106b004205cd67a706e314eaeadd8590d5f4d1cee46137566232a627::bag_value::Value>(&mut v3));
        };
        0x1::vector::destroy_empty<0x360802cb106b004205cd67a706e314eaeadd8590d5f4d1cee46137566232a627::bag_value::Value>(v3);
    }

    public fun scalling_factor() : u128 {
        (18446744073709551616 as u128)
    }

    public(friend) fun seed<T0, T1, T2>(arg0: &mut Vault<T0, T1, T2>, arg1: 0x2::balance::Balance<T2>) {
        assert!(0x2::balance::value<T2>(&arg0.seed_balance) == 0, 2);
        0x2::balance::join<T2>(&mut arg0.seed_balance, arg1);
    }

    public fun seed_balance<T0, T1, T2>(arg0: &Vault<T0, T1, T2>) : u64 {
        0x2::balance::value<T2>(&arg0.seed_balance)
    }

    public fun set_deposit_enable<T0, T1, T2>(arg0: &mut Vault<T0, T1, T2>, arg1: &VaultCap, arg2: bool) {
        check_vault_cap_compatibility<T0, T1, T2>(arg0, arg1);
        *0x2::dynamic_field::borrow_mut<vector<u8>, bool>(&mut arg0.id, b"deposit_enabled") = arg2;
    }

    public fun set_fee<T0, T1, T2>(arg0: &mut Vault<T0, T1, T2>, arg1: &VaultCap, arg2: u64) {
        check_vault_cap_compatibility<T0, T1, T2>(arg0, arg1);
        arg0.fee_val = arg2;
    }

    public fun set_free_threshold_a<T0, T1, T2>(arg0: &mut Vault<T0, T1, T2>, arg1: &VaultCap, arg2: u64) {
        check_vault_cap_compatibility<T0, T1, T2>(arg0, arg1);
        arg0.free_threshold_a = arg2;
    }

    public fun set_free_threshold_b<T0, T1, T2>(arg0: &mut Vault<T0, T1, T2>, arg1: &VaultCap, arg2: u64) {
        check_vault_cap_compatibility<T0, T1, T2>(arg0, arg1);
        arg0.free_threshold_b = arg2;
    }

    public(friend) fun set_intialised(arg0: &mut VaultCap) {
        arg0.is_initialised = true;
    }

    public(friend) fun set_rebalance_time<T0, T1, T2>(arg0: &mut Vault<T0, T1, T2>, arg1: u64) {
        arg0.last_rebalance_time = arg1;
    }

    public fun set_slippage_down<T0, T1, T2>(arg0: &mut Vault<T0, T1, T2>, arg1: &VaultCap, arg2: u128) {
        check_vault_cap_compatibility<T0, T1, T2>(arg0, arg1);
        arg0.slippage_down = arg2;
    }

    public fun set_slippage_up<T0, T1, T2>(arg0: &mut Vault<T0, T1, T2>, arg1: &VaultCap, arg2: u128) {
        check_vault_cap_compatibility<T0, T1, T2>(arg0, arg1);
        arg0.slippage_up = arg2;
    }

    public fun set_trigger_scalling<T0, T1, T2>(arg0: &mut Vault<T0, T1, T2>, arg1: &AdminCap, arg2: u128, arg3: u128) {
        assert!(arg3 > arg2, 9);
        arg0.lower_trigger_price_scalling = arg2;
        arg0.upper_trigger_price_scalling = arg3;
    }

    public fun slippage<T0, T1, T2>(arg0: &Vault<T0, T1, T2>) : (u128, u128) {
        (arg0.slippage_up, arg0.slippage_down)
    }

    public fun swap_route_returns_x<T0, T1, T2, T3>(arg0: &Vault<T0, T1, T2>) : bool {
        let v0 = 0x1::type_name::into_string(0x1::type_name::get<T3>());
        assert!(0x2::bag::contains<0x1::ascii::String>(&arg0.swap_routes, v0), 3);
        0x2::bag::borrow<0x1::ascii::String, SwapRoute>(&arg0.swap_routes, v0).returns_x
    }

    public(friend) fun tc_borrow_mut<T0, T1, T2>(arg0: &mut Vault<T0, T1, T2>) : &mut 0x2::coin::TreasuryCap<T2> {
        &mut arg0.treasury_cap
    }

    public(friend) fun update_last_rebalance_sqrt_price<T0, T1, T2>(arg0: &mut Vault<T0, T1, T2>, arg1: u128) {
        arg0.last_rebalance_sqrt_price = arg1;
    }

    public fun update_rebalance_cap_ownership(arg0: &VaultCap, arg1: &mut RebalanceCap, arg2: address, arg3: &0xd1d9337a6c415df934f39979c5f623f835c0b881830392b6a1c5f458d98d0c02::version::Version) {
        0xd1d9337a6c415df934f39979c5f623f835c0b881830392b6a1c5f458d98d0c02::version::assert_supported_version(arg3);
        assert!(arg0.vault_id == arg1.vault_id, 7);
        arg1.whitelisted_address = arg2;
    }

    public(friend) fun update_ticks_info<T0, T1, T2>(arg0: &mut Vault<T0, T1, T2>, arg1: u32, arg2: u32) {
        arg0.lower_tick = arg1;
        arg0.upper_tick = arg2;
    }

    public(friend) fun update_trigger_ticks_info<T0, T1, T2>(arg0: &mut Vault<T0, T1, T2>, arg1: u128, arg2: u128) {
        arg0.lower_trigger_price = arg1;
        arg0.upper_trigger_price = arg2;
    }

    public fun upper_price_scalling<T0, T1, T2>(arg0: &Vault<T0, T1, T2>) : u128 {
        arg0.upper_price_scalling
    }

    public fun upper_trigger_price<T0, T1, T2>(arg0: &Vault<T0, T1, T2>) : u128 {
        arg0.upper_trigger_price
    }

    public fun upper_trigger_price_scalling<T0, T1, T2>(arg0: &Vault<T0, T1, T2>) : u128 {
        arg0.upper_trigger_price_scalling
    }

    // decompiled from Move bytecode v6
}

