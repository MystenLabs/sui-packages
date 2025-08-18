module 0xd875ffed6bf6f4036c523ec8df68313251ec15b72eba1b963457eb87a6b54d24::vault {
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
        route: vector<0x7d798502daf9e53a65b7a725c855de31c7887913227b6d155bc49508d757510f::bag_value::Value>,
        returns_x: bool,
    }

    struct Vault<phantom T0, phantom T1, phantom T2, T3: copy + drop + store> has key {
        id: 0x2::object::UID,
        paused: bool,
        treasury_cap: 0x2::coin::TreasuryCap<T2>,
        free_balance_a: 0x2::balance::Balance<T0>,
        free_balance_b: 0x2::balance::Balance<T1>,
        fee_a: 0x2::balance::Balance<T0>,
        fee_b: 0x2::balance::Balance<T1>,
        seed_balance: 0x2::balance::Balance<T2>,
        swap_routes: 0x2::bag::Bag,
        clmm_pool_id: 0x2::object::ID,
        upper_price_scalling: u128,
        lower_price_scalling: u128,
        lower_tick: u32,
        upper_tick: u32,
        last_rebalance_sqrt_price: u128,
        last_rebalance_time: u64,
        deposit_limit: u64,
        free_threshold_a: u64,
        free_threshold_b: u64,
        lock_threshold_a: u64,
        lock_threshold_b: u64,
        slippage_up: u128,
        slippage_down: u128,
        fee_val: u64,
        withdraw_fee_val: u64,
        decimals_a: u8,
        decimals_b: u8,
        config: 0xd875ffed6bf6f4036c523ec8df68313251ec15b72eba1b963457eb87a6b54d24::config::Config<T3>,
    }

    struct VaultCreatedEvent<T0: copy + drop + store> has copy, drop {
        id: 0x2::object::ID,
        clmm_pool_id: 0x2::object::ID,
        type_a: 0x1::type_name::TypeName,
        type_b: 0x1::type_name::TypeName,
        type_v: 0x1::type_name::TypeName,
        upper_price_scalling: u128,
        lower_price_scalling: u128,
        slippage_up: u128,
        slippage_down: u128,
        free_threshold_a: u64,
        free_threshold_b: u64,
        lock_threshold_a: u64,
        lock_threshold_b: u64,
        fee_val: u64,
        withdraw_fee: u64,
        config: 0xd875ffed6bf6f4036c523ec8df68313251ec15b72eba1b963457eb87a6b54d24::config::Config<T0>,
    }

    public fun total_supply<T0, T1, T2, T3: copy + drop + store>(arg0: &Vault<T0, T1, T2, T3>) : u64 {
        0x2::coin::total_supply<T2>(&arg0.treasury_cap)
    }

    public fun get_optimal_swap_amount_for_single_sided_liquidity<T0, T1, T2, T3: copy + drop + store>(arg0: &Vault<T0, T1, T2, T3>, arg1: &0x70285592c97965e811e0c6f98dccc3a9c2b4ad854b3594faab9597ada267b860::pool::Pool<T0, T1>, arg2: u64, arg3: bool, arg4: u64) : (u64, bool) {
        let v0 = if (arg3) {
            4295048017
        } else {
            79226673515401279992447579054
        };
        0x70285592c97965e811e0c6f98dccc3a9c2b4ad854b3594faab9597ada267b860::trade::get_optimal_swap_amount_for_single_sided_liquidity<T0, T1>(arg1, arg2, position_borrow<T0, T1, T2, T3>(arg0), v0, arg3, arg4)
    }

    public fun set_target_adapter<T0, T1, T2>(arg0: &mut Vault<T0, T1, T2, 0xd875ffed6bf6f4036c523ec8df68313251ec15b72eba1b963457eb87a6b54d24::config::Drift>, arg1: &VaultCap, arg2: 0x1::ascii::String) {
        abort 0
    }

    public fun set_uc_is_target_reverse<T0, T1, T2>(arg0: &mut Vault<T0, T1, T2, 0xd875ffed6bf6f4036c523ec8df68313251ec15b72eba1b963457eb87a6b54d24::config::Uncorrelated>, arg1: &VaultCap, arg2: bool) {
        abort 0
    }

    public fun set_uc_target_adapter<T0, T1, T2>(arg0: &mut Vault<T0, T1, T2, 0xd875ffed6bf6f4036c523ec8df68313251ec15b72eba1b963457eb87a6b54d24::config::Uncorrelated>, arg1: &VaultCap, arg2: 0x1::ascii::String) {
        abort 0
    }

    public(friend) fun add_fee_a<T0, T1, T2, T3: copy + drop + store>(arg0: &mut Vault<T0, T1, T2, T3>, arg1: 0x2::balance::Balance<T0>) {
        0x2::balance::join<T0>(&mut arg0.fee_a, arg1);
    }

    public(friend) fun add_fee_b<T0, T1, T2, T3: copy + drop + store>(arg0: &mut Vault<T0, T1, T2, T3>, arg1: 0x2::balance::Balance<T1>) {
        0x2::balance::join<T1>(&mut arg0.fee_b, arg1);
    }

    public(friend) fun add_force_rebalance_df<T0, T1, T2, T3: copy + drop + store>(arg0: &mut Vault<T0, T1, T2, T3>) {
        0x2::dynamic_field::add<vector<u8>, bool>(&mut arg0.id, b"f_rb", true);
    }

    public(friend) fun add_free_balance_a<T0, T1, T2, T3: copy + drop + store>(arg0: &mut Vault<T0, T1, T2, T3>, arg1: 0x2::balance::Balance<T0>) {
        0x2::balance::join<T0>(&mut arg0.free_balance_a, arg1);
    }

    public(friend) fun add_free_balance_b<T0, T1, T2, T3: copy + drop + store>(arg0: &mut Vault<T0, T1, T2, T3>, arg1: 0x2::balance::Balance<T1>) {
        0x2::balance::join<T1>(&mut arg0.free_balance_b, arg1);
    }

    public fun add_reward_x<T0, T1, T2, T3: copy + drop + store>(arg0: &mut Vault<T0, T1, T2, T3>, arg1: 0x2::balance::Balance<T0>) {
        0x2::balance::join<T0>(&mut arg0.free_balance_a, arg1);
    }

    public fun add_reward_y<T0, T1, T2, T3: copy + drop + store>(arg0: &mut Vault<T0, T1, T2, T3>, arg1: 0x2::balance::Balance<T1>) {
        0x2::balance::join<T1>(&mut arg0.free_balance_b, arg1);
    }

    public(friend) fun add_swap_route<T0, T1, T2, T3: copy + drop + store, T4>(arg0: &mut Vault<T0, T1, T2, T3>, arg1: vector<0x7d798502daf9e53a65b7a725c855de31c7887913227b6d155bc49508d757510f::bag_value::Value>, arg2: bool) {
        let v0 = 0x1::type_name::into_string(0x1::type_name::get<T4>());
        assert!(v0 != 0x1::type_name::into_string(0x1::type_name::get<T0>()), 0xd875ffed6bf6f4036c523ec8df68313251ec15b72eba1b963457eb87a6b54d24::error::invalid_route_key());
        assert!(v0 != 0x1::type_name::into_string(0x1::type_name::get<T1>()), 0xd875ffed6bf6f4036c523ec8df68313251ec15b72eba1b963457eb87a6b54d24::error::invalid_route_key());
        assert!(!0x2::bag::contains<0x1::ascii::String>(&arg0.swap_routes, v0), 0xd875ffed6bf6f4036c523ec8df68313251ec15b72eba1b963457eb87a6b54d24::error::invalid_route_key());
        let v1 = SwapRoute{
            route     : arg1,
            returns_x : arg2,
        };
        0x2::bag::add<0x1::ascii::String, SwapRoute>(&mut arg0.swap_routes, v0, v1);
    }

    public fun assert_rebalance_cap<T0, T1, T2, T3: copy + drop + store>(arg0: &Vault<T0, T1, T2, T3>, arg1: &RebalanceCap, arg2: &mut 0x2::tx_context::TxContext) {
        assert!(0x2::object::id<Vault<T0, T1, T2, T3>>(arg0) == arg1.vault_id, 0xd875ffed6bf6f4036c523ec8df68313251ec15b72eba1b963457eb87a6b54d24::error::invalid_rebalance_cap());
        assert!(arg1.whitelisted_address == 0x2::tx_context::sender(arg2), 0xd875ffed6bf6f4036c523ec8df68313251ec15b72eba1b963457eb87a6b54d24::error::invalid_rebalance_owner());
    }

    public fun borrow_config<T0, T1, T2, T3: copy + drop + store>(arg0: &Vault<T0, T1, T2, T3>) : &0xd875ffed6bf6f4036c523ec8df68313251ec15b72eba1b963457eb87a6b54d24::config::Config<T3> {
        &arg0.config
    }

    public(friend) fun borrow_mut_config<T0, T1, T2, T3: copy + drop + store>(arg0: &mut Vault<T0, T1, T2, T3>) : &mut 0xd875ffed6bf6f4036c523ec8df68313251ec15b72eba1b963457eb87a6b54d24::config::Config<T3> {
        &mut arg0.config
    }

    public(friend) fun burn_vault_coin<T0, T1, T2, T3: copy + drop + store>(arg0: &mut Vault<T0, T1, T2, T3>, arg1: 0x2::coin::Coin<T2>) {
        0x2::coin::burn<T2>(&mut arg0.treasury_cap, arg1);
    }

    public fun calc_fee<T0, T1, T2, T3: copy + drop + store>(arg0: &Vault<T0, T1, T2, T3>, arg1: u64) : u64 {
        (((arg1 as u128) * (arg0.fee_val as u128) / (1000000 as u128)) as u64)
    }

    public fun calc_withdraw_fee<T0, T1, T2, T3: copy + drop + store>(arg0: &Vault<T0, T1, T2, T3>, arg1: u64) : u64 {
        (((arg1 as u128) * (arg0.withdraw_fee_val as u128) / (1000000 as u128)) as u64)
    }

    public fun check_pool_compatibility<T0, T1, T2, T3: copy + drop + store>(arg0: &Vault<T0, T1, T2, T3>, arg1: &0x70285592c97965e811e0c6f98dccc3a9c2b4ad854b3594faab9597ada267b860::pool::Pool<T0, T1>) {
        assert!(arg0.clmm_pool_id == 0x2::object::id<0x70285592c97965e811e0c6f98dccc3a9c2b4ad854b3594faab9597ada267b860::pool::Pool<T0, T1>>(arg1), 0xd875ffed6bf6f4036c523ec8df68313251ec15b72eba1b963457eb87a6b54d24::error::invalid_pool());
    }

    public fun check_vault_cap_compatibility<T0, T1, T2, T3: copy + drop + store>(arg0: &Vault<T0, T1, T2, T3>, arg1: &VaultCap) {
        assert!(arg1.vault_id == 0x2::object::id<Vault<T0, T1, T2, T3>>(arg0), 0xd875ffed6bf6f4036c523ec8df68313251ec15b72eba1b963457eb87a6b54d24::error::invalid_vault_cap());
        if (0x2::dynamic_field::exists_<vector<u8>>(&arg0.id, b"vault_cap")) {
            let v0 = 0x2::object::id<VaultCap>(arg1);
            assert!(0x2::dynamic_field::borrow<vector<u8>, 0x2::object::ID>(&arg0.id, b"vault_cap") == &v0, 0xd875ffed6bf6f4036c523ec8df68313251ec15b72eba1b963457eb87a6b54d24::error::invalid_vault_cap());
        };
    }

    public fun check_vault_cap_uninitialised(arg0: &VaultCap) {
        assert!(arg0.is_initialised == false, 0xd875ffed6bf6f4036c523ec8df68313251ec15b72eba1b963457eb87a6b54d24::error::invalid_vault_cap());
    }

    public fun decimals<T0, T1, T2, T3: copy + drop + store>(arg0: &Vault<T0, T1, T2, T3>) : (u8, u8) {
        (arg0.decimals_a, arg0.decimals_b)
    }

    public fun deposit_limit<T0, T1, T2, T3: copy + drop + store>(arg0: &Vault<T0, T1, T2, T3>) : u64 {
        arg0.deposit_limit
    }

    fun emit_event<T0, T1, T2, T3: copy + drop + store>(arg0: &Vault<T0, T1, T2, T3>, arg1: 0xd875ffed6bf6f4036c523ec8df68313251ec15b72eba1b963457eb87a6b54d24::config::Config<T3>) {
        let v0 = VaultCreatedEvent<T3>{
            id                   : 0x2::object::id<Vault<T0, T1, T2, T3>>(arg0),
            clmm_pool_id         : arg0.clmm_pool_id,
            type_a               : 0x1::type_name::get<T0>(),
            type_b               : 0x1::type_name::get<T1>(),
            type_v               : 0x1::type_name::get<T2>(),
            upper_price_scalling : arg0.upper_price_scalling,
            lower_price_scalling : arg0.lower_price_scalling,
            slippage_up          : arg0.slippage_up,
            slippage_down        : arg0.slippage_down,
            free_threshold_a     : arg0.free_threshold_a,
            free_threshold_b     : arg0.free_threshold_b,
            lock_threshold_a     : arg0.lock_threshold_a,
            lock_threshold_b     : arg0.lock_threshold_b,
            fee_val              : arg0.fee_val,
            withdraw_fee         : arg0.withdraw_fee_val,
            config               : arg1,
        };
        0x2::event::emit<VaultCreatedEvent<T3>>(v0);
    }

    public fun fee_val<T0, T1, T2, T3: copy + drop + store>(arg0: &Vault<T0, T1, T2, T3>) : u64 {
        arg0.fee_val
    }

    public fun free_balance_a_val<T0, T1, T2, T3: copy + drop + store>(arg0: &Vault<T0, T1, T2, T3>) : u64 {
        0x2::balance::value<T0>(&arg0.free_balance_a)
    }

    public fun free_balance_b_val<T0, T1, T2, T3: copy + drop + store>(arg0: &Vault<T0, T1, T2, T3>) : u64 {
        0x2::balance::value<T1>(&arg0.free_balance_b)
    }

    public fun free_threshold_a<T0, T1, T2, T3: copy + drop + store>(arg0: &Vault<T0, T1, T2, T3>) : u64 {
        arg0.free_threshold_a
    }

    public fun free_threshold_b<T0, T1, T2, T3: copy + drop + store>(arg0: &Vault<T0, T1, T2, T3>) : u64 {
        arg0.free_threshold_b
    }

    public(friend) fun get_free_balance_a<T0, T1, T2, T3: copy + drop + store>(arg0: &mut Vault<T0, T1, T2, T3>) : 0x2::balance::Balance<T0> {
        0x2::balance::split<T0>(&mut arg0.free_balance_a, free_balance_a_val<T0, T1, T2, T3>(arg0))
    }

    public(friend) fun get_free_balance_b<T0, T1, T2, T3: copy + drop + store>(arg0: &mut Vault<T0, T1, T2, T3>) : 0x2::balance::Balance<T1> {
        0x2::balance::split<T1>(&mut arg0.free_balance_b, free_balance_b_val<T0, T1, T2, T3>(arg0))
    }

    public fun get_position_assets<T0, T1, T2, T3: copy + drop + store>(arg0: &Vault<T0, T1, T2, T3>, arg1: &0x70285592c97965e811e0c6f98dccc3a9c2b4ad854b3594faab9597ada267b860::pool::Pool<T0, T1>) : (u64, u64) {
        let v0 = position_borrow<T0, T1, T2, T3>(arg0);
        0x70285592c97965e811e0c6f98dccc3a9c2b4ad854b3594faab9597ada267b860::liquidity_math::get_amounts_for_liquidity(0x70285592c97965e811e0c6f98dccc3a9c2b4ad854b3594faab9597ada267b860::pool::sqrt_price<T0, T1>(arg1), 0x70285592c97965e811e0c6f98dccc3a9c2b4ad854b3594faab9597ada267b860::tick_math::get_sqrt_price_at_tick(0x70285592c97965e811e0c6f98dccc3a9c2b4ad854b3594faab9597ada267b860::position::tick_lower_index(v0)), 0x70285592c97965e811e0c6f98dccc3a9c2b4ad854b3594faab9597ada267b860::tick_math::get_sqrt_price_at_tick(0x70285592c97965e811e0c6f98dccc3a9c2b4ad854b3594faab9597ada267b860::position::tick_upper_index(v0)), 0x70285592c97965e811e0c6f98dccc3a9c2b4ad854b3594faab9597ada267b860::position::liquidity(v0), true)
    }

    public fun get_position_tick_range<T0, T1, T2, T3: copy + drop + store>(arg0: &Vault<T0, T1, T2, T3>) : (0x70285592c97965e811e0c6f98dccc3a9c2b4ad854b3594faab9597ada267b860::i32::I32, 0x70285592c97965e811e0c6f98dccc3a9c2b4ad854b3594faab9597ada267b860::i32::I32) {
        let v0 = position_borrow<T0, T1, T2, T3>(arg0);
        (0x70285592c97965e811e0c6f98dccc3a9c2b4ad854b3594faab9597ada267b860::position::tick_lower_index(v0), 0x70285592c97965e811e0c6f98dccc3a9c2b4ad854b3594faab9597ada267b860::position::tick_upper_index(v0))
    }

    public fun get_price_scalling<T0, T1, T2, T3: copy + drop + store>(arg0: &Vault<T0, T1, T2, T3>) : (u128, u128) {
        (arg0.lower_price_scalling, arg0.upper_price_scalling)
    }

    public(friend) fun get_rebalance_price_source<T0, T1, T2, T3: copy + drop + store>(arg0: &Vault<T0, T1, T2, T3>) : u8 {
        if (0x2::dynamic_field::exists_<vector<u8>>(&arg0.id, b"price_source")) {
            *0x2::dynamic_field::borrow<vector<u8>, u8>(&arg0.id, b"price_source")
        } else {
            0
        }
    }

    public(friend) fun get_slippage<T0, T1, T2, T3: copy + drop + store>(arg0: &Vault<T0, T1, T2, T3>) : (u128, u128) {
        (arg0.slippage_up, arg0.slippage_down)
    }

    public fun get_swap_route<T0, T1, T2, T3: copy + drop + store, T4>(arg0: &Vault<T0, T1, T2, T3>) : (vector<0x7d798502daf9e53a65b7a725c855de31c7887913227b6d155bc49508d757510f::bag_value::Value>, bool) {
        let v0 = 0x1::type_name::into_string(0x1::type_name::get<T4>());
        assert!(0x2::bag::contains<0x1::ascii::String>(&arg0.swap_routes, v0), 0xd875ffed6bf6f4036c523ec8df68313251ec15b72eba1b963457eb87a6b54d24::error::invalid_route_key());
        let v1 = 0x2::bag::borrow<0x1::ascii::String, SwapRoute>(&arg0.swap_routes, v0);
        (v1.route, v1.returns_x)
    }

    fun init(arg0: &mut 0x2::tx_context::TxContext) {
        let v0 = AdminCap{id: 0x2::object::new(arg0)};
        0x2::transfer::transfer<AdminCap>(v0, 0x2::tx_context::sender(arg0));
    }

    public(friend) fun insert_position<T0, T1, T2, T3: copy + drop + store>(arg0: &mut Vault<T0, T1, T2, T3>, arg1: 0x70285592c97965e811e0c6f98dccc3a9c2b4ad854b3594faab9597ada267b860::position::Position) {
        0x2::dynamic_field::add<vector<u8>, 0x70285592c97965e811e0c6f98dccc3a9c2b4ad854b3594faab9597ada267b860::position::Position>(&mut arg0.id, b"position", arg1);
    }

    public(friend) fun is_cap_valid<T0, T1, T2, T3: copy + drop + store>(arg0: &Vault<T0, T1, T2, T3>, arg1: 0x2::object::ID) {
        assert!(!0x2::dynamic_field::exists_<0x2::object::ID>(&arg0.id, arg1), 1);
    }

    public fun is_deposit_enabled<T0, T1, T2, T3: copy + drop + store>(arg0: &Vault<T0, T1, T2, T3>) : bool {
        *0x2::dynamic_field::borrow<vector<u8>, bool>(&arg0.id, 0xd875ffed6bf6f4036c523ec8df68313251ec15b72eba1b963457eb87a6b54d24::constants::deposit_enabled_df_key())
    }

    public fun is_locked<T0, T1, T2, T3: copy + drop + store>(arg0: &Vault<T0, T1, T2, T3>) : bool {
        arg0.lock_threshold_a == 0 && arg0.lock_threshold_b == 0 && false || 0x2::balance::value<T0>(&arg0.free_balance_a) >= arg0.lock_threshold_a || 0x2::balance::value<T1>(&arg0.free_balance_b) >= arg0.lock_threshold_b
    }

    public fun issue_rebalance_cap(arg0: &VaultCap, arg1: address, arg2: &0xd875ffed6bf6f4036c523ec8df68313251ec15b72eba1b963457eb87a6b54d24::version::Version, arg3: &mut 0x2::tx_context::TxContext) {
        0xd875ffed6bf6f4036c523ec8df68313251ec15b72eba1b963457eb87a6b54d24::version::assert_supported_version(arg2);
        let v0 = RebalanceCap{
            id                  : 0x2::object::new(arg3),
            vault_id            : arg0.vault_id,
            whitelisted_address : arg1,
        };
        0x2::transfer::share_object<RebalanceCap>(v0);
    }

    public(friend) fun issue_vault_cap<T0, T1, T2, T3: copy + drop + store>(arg0: &Vault<T0, T1, T2, T3>, arg1: &mut 0x2::tx_context::TxContext) {
        let v0 = VaultCap{
            id             : 0x2::object::new(arg1),
            vault_id       : 0x2::object::id<Vault<T0, T1, T2, T3>>(arg0),
            is_initialised : true,
        };
        0x2::transfer::transfer<VaultCap>(v0, 0x2::tx_context::sender(arg1));
    }

    public fun last_rebalance_sqrt_price<T0, T1, T2, T3: copy + drop + store>(arg0: &Vault<T0, T1, T2, T3>) : u128 {
        arg0.last_rebalance_sqrt_price
    }

    public fun last_rebalance_time<T0, T1, T2, T3: copy + drop + store>(arg0: &Vault<T0, T1, T2, T3>) : u64 {
        arg0.last_rebalance_time
    }

    public(friend) fun mint_vault_coin<T0, T1, T2, T3: copy + drop + store>(arg0: &mut Vault<T0, T1, T2, T3>, arg1: u128, arg2: u128, arg3: &mut 0x2::tx_context::TxContext) : 0x2::coin::Coin<T2> {
        let v0 = ((arg1 * (total_supply<T0, T1, T2, T3>(arg0) as u128) / arg2) as u64);
        assert!(v0 > 0, 0xd875ffed6bf6f4036c523ec8df68313251ec15b72eba1b963457eb87a6b54d24::error::seed_mint_zero());
        0x2::coin::mint<T2>(&mut arg0.treasury_cap, v0, arg3)
    }

    public(friend) fun mint_vault_coin_unsafe<T0, T1, T2, T3: copy + drop + store>(arg0: &mut Vault<T0, T1, T2, T3>, arg1: u64, arg2: &mut 0x2::tx_context::TxContext) : 0x2::coin::Coin<T2> {
        0x2::coin::mint<T2>(&mut arg0.treasury_cap, arg1, arg2)
    }

    public fun new_drift_vault<T0, T1, T2>(arg0: &0x70285592c97965e811e0c6f98dccc3a9c2b4ad854b3594faab9597ada267b860::pool::Pool<T0, T1>, arg1: 0x2::coin::TreasuryCap<T2>, arg2: u128, arg3: u128, arg4: u128, arg5: u128, arg6: u128, arg7: u64, arg8: u64, arg9: u64, arg10: u64, arg11: u64, arg12: u64, arg13: u8, arg14: u8, arg15: u64, arg16: 0x1::ascii::String, arg17: &mut 0x2::tx_context::TxContext) {
        assert!(0x2::coin::total_supply<T2>(&arg1) == 0, 0xd875ffed6bf6f4036c523ec8df68313251ec15b72eba1b963457eb87a6b54d24::error::treasury_cap_supply_non_zero());
        assert!(arg2 > arg3, 0xd875ffed6bf6f4036c523ec8df68313251ec15b72eba1b963457eb87a6b54d24::error::invalid_price_scalling());
        let v0 = 0xd875ffed6bf6f4036c523ec8df68313251ec15b72eba1b963457eb87a6b54d24::config::new_drift_config(arg16, arg4);
        let v1 = Vault<T0, T1, T2, 0xd875ffed6bf6f4036c523ec8df68313251ec15b72eba1b963457eb87a6b54d24::config::Drift>{
            id                        : 0x2::object::new(arg17),
            paused                    : false,
            treasury_cap              : arg1,
            free_balance_a            : 0x2::balance::zero<T0>(),
            free_balance_b            : 0x2::balance::zero<T1>(),
            fee_a                     : 0x2::balance::zero<T0>(),
            fee_b                     : 0x2::balance::zero<T1>(),
            seed_balance              : 0x2::balance::zero<T2>(),
            swap_routes               : 0x2::bag::new(arg17),
            clmm_pool_id              : 0x2::object::id<0x70285592c97965e811e0c6f98dccc3a9c2b4ad854b3594faab9597ada267b860::pool::Pool<T0, T1>>(arg0),
            upper_price_scalling      : arg2,
            lower_price_scalling      : arg3,
            lower_tick                : 0,
            upper_tick                : 0,
            last_rebalance_sqrt_price : 0,
            last_rebalance_time       : 0,
            deposit_limit             : arg15,
            free_threshold_a          : arg7,
            free_threshold_b          : arg8,
            lock_threshold_a          : arg9,
            lock_threshold_b          : arg10,
            slippage_up               : arg5,
            slippage_down             : arg6,
            fee_val                   : arg11,
            withdraw_fee_val          : arg12,
            decimals_a                : arg13,
            decimals_b                : arg14,
            config                    : v0,
        };
        0x2::dynamic_field::add<vector<u8>, bool>(&mut v1.id, 0xd875ffed6bf6f4036c523ec8df68313251ec15b72eba1b963457eb87a6b54d24::constants::deposit_enabled_df_key(), true);
        let v2 = VaultCap{
            id             : 0x2::object::new(arg17),
            vault_id       : 0x2::object::id<Vault<T0, T1, T2, 0xd875ffed6bf6f4036c523ec8df68313251ec15b72eba1b963457eb87a6b54d24::config::Drift>>(&v1),
            is_initialised : false,
        };
        emit_event<T0, T1, T2, 0xd875ffed6bf6f4036c523ec8df68313251ec15b72eba1b963457eb87a6b54d24::config::Drift>(&v1, v0);
        0x2::transfer::share_object<Vault<T0, T1, T2, 0xd875ffed6bf6f4036c523ec8df68313251ec15b72eba1b963457eb87a6b54d24::config::Drift>>(v1);
        0x2::transfer::transfer<VaultCap>(v2, 0x2::tx_context::sender(arg17));
    }

    public fun new_stable_vault<T0, T1, T2>(arg0: &0x70285592c97965e811e0c6f98dccc3a9c2b4ad854b3594faab9597ada267b860::pool::Pool<T0, T1>, arg1: 0x2::coin::TreasuryCap<T2>, arg2: u128, arg3: u128, arg4: u128, arg5: u128, arg6: u64, arg7: u64, arg8: u64, arg9: u64, arg10: u8, arg11: u8, arg12: u64, arg13: &mut 0x2::tx_context::TxContext) {
        assert!(0x2::coin::total_supply<T2>(&arg1) == 0, 0xd875ffed6bf6f4036c523ec8df68313251ec15b72eba1b963457eb87a6b54d24::error::treasury_cap_supply_non_zero());
        assert!(arg2 > arg3, 0xd875ffed6bf6f4036c523ec8df68313251ec15b72eba1b963457eb87a6b54d24::error::invalid_price_scalling());
        let v0 = 0xd875ffed6bf6f4036c523ec8df68313251ec15b72eba1b963457eb87a6b54d24::config::new_stable_config();
        let v1 = Vault<T0, T1, T2, 0xd875ffed6bf6f4036c523ec8df68313251ec15b72eba1b963457eb87a6b54d24::config::Stable>{
            id                        : 0x2::object::new(arg13),
            paused                    : false,
            treasury_cap              : arg1,
            free_balance_a            : 0x2::balance::zero<T0>(),
            free_balance_b            : 0x2::balance::zero<T1>(),
            fee_a                     : 0x2::balance::zero<T0>(),
            fee_b                     : 0x2::balance::zero<T1>(),
            seed_balance              : 0x2::balance::zero<T2>(),
            swap_routes               : 0x2::bag::new(arg13),
            clmm_pool_id              : 0x2::object::id<0x70285592c97965e811e0c6f98dccc3a9c2b4ad854b3594faab9597ada267b860::pool::Pool<T0, T1>>(arg0),
            upper_price_scalling      : arg2,
            lower_price_scalling      : arg3,
            lower_tick                : 0,
            upper_tick                : 0,
            last_rebalance_sqrt_price : 0,
            last_rebalance_time       : 0,
            deposit_limit             : arg12,
            free_threshold_a          : arg6,
            free_threshold_b          : arg7,
            lock_threshold_a          : 0,
            lock_threshold_b          : 0,
            slippage_up               : arg4,
            slippage_down             : arg5,
            fee_val                   : arg8,
            withdraw_fee_val          : arg9,
            decimals_a                : arg10,
            decimals_b                : arg11,
            config                    : v0,
        };
        0x2::dynamic_field::add<vector<u8>, bool>(&mut v1.id, 0xd875ffed6bf6f4036c523ec8df68313251ec15b72eba1b963457eb87a6b54d24::constants::deposit_enabled_df_key(), true);
        let v2 = VaultCap{
            id             : 0x2::object::new(arg13),
            vault_id       : 0x2::object::id<Vault<T0, T1, T2, 0xd875ffed6bf6f4036c523ec8df68313251ec15b72eba1b963457eb87a6b54d24::config::Stable>>(&v1),
            is_initialised : false,
        };
        emit_event<T0, T1, T2, 0xd875ffed6bf6f4036c523ec8df68313251ec15b72eba1b963457eb87a6b54d24::config::Stable>(&v1, v0);
        0x2::transfer::share_object<Vault<T0, T1, T2, 0xd875ffed6bf6f4036c523ec8df68313251ec15b72eba1b963457eb87a6b54d24::config::Stable>>(v1);
        0x2::transfer::transfer<VaultCap>(v2, 0x2::tx_context::sender(arg13));
    }

    public fun new_uncorrelated_vault<T0, T1, T2>(arg0: &0x70285592c97965e811e0c6f98dccc3a9c2b4ad854b3594faab9597ada267b860::pool::Pool<T0, T1>, arg1: 0x2::coin::TreasuryCap<T2>, arg2: u128, arg3: u128, arg4: u128, arg5: u128, arg6: u128, arg7: u128, arg8: u64, arg9: u64, arg10: u64, arg11: u64, arg12: u64, arg13: u64, arg14: u8, arg15: u8, arg16: u64, arg17: 0x1::ascii::String, arg18: bool, arg19: &mut 0x2::tx_context::TxContext) {
        assert!(0x2::coin::total_supply<T2>(&arg1) == 0, 0xd875ffed6bf6f4036c523ec8df68313251ec15b72eba1b963457eb87a6b54d24::error::treasury_cap_supply_non_zero());
        assert!(arg4 > arg5, 0xd875ffed6bf6f4036c523ec8df68313251ec15b72eba1b963457eb87a6b54d24::error::upper_lower_trigger_price_incompatible());
        assert!(arg2 > arg3, 0xd875ffed6bf6f4036c523ec8df68313251ec15b72eba1b963457eb87a6b54d24::error::invalid_price_scalling());
        let v0 = 0xd875ffed6bf6f4036c523ec8df68313251ec15b72eba1b963457eb87a6b54d24::config::new_uncorrelated_config(arg17, arg18, 0, 0, arg4, arg5);
        let v1 = Vault<T0, T1, T2, 0xd875ffed6bf6f4036c523ec8df68313251ec15b72eba1b963457eb87a6b54d24::config::Uncorrelated>{
            id                        : 0x2::object::new(arg19),
            paused                    : false,
            treasury_cap              : arg1,
            free_balance_a            : 0x2::balance::zero<T0>(),
            free_balance_b            : 0x2::balance::zero<T1>(),
            fee_a                     : 0x2::balance::zero<T0>(),
            fee_b                     : 0x2::balance::zero<T1>(),
            seed_balance              : 0x2::balance::zero<T2>(),
            swap_routes               : 0x2::bag::new(arg19),
            clmm_pool_id              : 0x2::object::id<0x70285592c97965e811e0c6f98dccc3a9c2b4ad854b3594faab9597ada267b860::pool::Pool<T0, T1>>(arg0),
            upper_price_scalling      : arg2,
            lower_price_scalling      : arg3,
            lower_tick                : 0,
            upper_tick                : 0,
            last_rebalance_sqrt_price : 0,
            last_rebalance_time       : 0,
            deposit_limit             : arg16,
            free_threshold_a          : arg8,
            free_threshold_b          : arg9,
            lock_threshold_a          : arg10,
            lock_threshold_b          : arg11,
            slippage_up               : arg6,
            slippage_down             : arg7,
            fee_val                   : arg12,
            withdraw_fee_val          : arg13,
            decimals_a                : arg14,
            decimals_b                : arg15,
            config                    : v0,
        };
        0x2::dynamic_field::add<vector<u8>, bool>(&mut v1.id, 0xd875ffed6bf6f4036c523ec8df68313251ec15b72eba1b963457eb87a6b54d24::constants::deposit_enabled_df_key(), true);
        let v2 = VaultCap{
            id             : 0x2::object::new(arg19),
            vault_id       : 0x2::object::id<Vault<T0, T1, T2, 0xd875ffed6bf6f4036c523ec8df68313251ec15b72eba1b963457eb87a6b54d24::config::Uncorrelated>>(&v1),
            is_initialised : false,
        };
        emit_event<T0, T1, T2, 0xd875ffed6bf6f4036c523ec8df68313251ec15b72eba1b963457eb87a6b54d24::config::Uncorrelated>(&v1, v0);
        0x2::transfer::share_object<Vault<T0, T1, T2, 0xd875ffed6bf6f4036c523ec8df68313251ec15b72eba1b963457eb87a6b54d24::config::Uncorrelated>>(v1);
        0x2::transfer::transfer<VaultCap>(v2, 0x2::tx_context::sender(arg19));
    }

    public(friend) fun pause<T0, T1, T2, T3: copy + drop + store>(arg0: &mut Vault<T0, T1, T2, T3>) {
        arg0.paused = true;
    }

    public(friend) fun pop_force_rebalance_df_if_exists<T0, T1, T2, T3: copy + drop + store>(arg0: &mut Vault<T0, T1, T2, T3>) : bool {
        0x2::dynamic_field::exists_<vector<u8>>(&arg0.id, b"f_rb") && 0x2::dynamic_field::remove<vector<u8>, bool>(&mut arg0.id, b"f_rb")
    }

    public(friend) fun position_borrow<T0, T1, T2, T3: copy + drop + store>(arg0: &Vault<T0, T1, T2, T3>) : &0x70285592c97965e811e0c6f98dccc3a9c2b4ad854b3594faab9597ada267b860::position::Position {
        0x2::dynamic_field::borrow<vector<u8>, 0x70285592c97965e811e0c6f98dccc3a9c2b4ad854b3594faab9597ada267b860::position::Position>(&arg0.id, b"position")
    }

    public(friend) fun position_borrow_mut<T0, T1, T2, T3: copy + drop + store>(arg0: &mut Vault<T0, T1, T2, T3>) : &mut 0x70285592c97965e811e0c6f98dccc3a9c2b4ad854b3594faab9597ada267b860::position::Position {
        0x2::dynamic_field::borrow_mut<vector<u8>, 0x70285592c97965e811e0c6f98dccc3a9c2b4ad854b3594faab9597ada267b860::position::Position>(&mut arg0.id, b"position")
    }

    public fun position_id<T0, T1, T2, T3: copy + drop + store>(arg0: &Vault<T0, T1, T2, T3>) : 0x2::object::ID {
        0x2::object::id<0x70285592c97965e811e0c6f98dccc3a9c2b4ad854b3594faab9597ada267b860::position::Position>(0x2::dynamic_field::borrow<vector<u8>, 0x70285592c97965e811e0c6f98dccc3a9c2b4ad854b3594faab9597ada267b860::position::Position>(&arg0.id, b"position"))
    }

    public(friend) fun remove_position<T0, T1, T2, T3: copy + drop + store>(arg0: &mut Vault<T0, T1, T2, T3>) : 0x70285592c97965e811e0c6f98dccc3a9c2b4ad854b3594faab9597ada267b860::position::Position {
        0x2::dynamic_field::remove<vector<u8>, 0x70285592c97965e811e0c6f98dccc3a9c2b4ad854b3594faab9597ada267b860::position::Position>(&mut arg0.id, b"position")
    }

    public(friend) fun remove_swap_route<T0, T1, T2, T3: copy + drop + store, T4>(arg0: &mut Vault<T0, T1, T2, T3>) {
        let v0 = 0x1::type_name::into_string(0x1::type_name::get<T4>());
        assert!(v0 != 0x1::type_name::into_string(0x1::type_name::get<T0>()), 0xd875ffed6bf6f4036c523ec8df68313251ec15b72eba1b963457eb87a6b54d24::error::invalid_route_key());
        assert!(v0 != 0x1::type_name::into_string(0x1::type_name::get<T1>()), 0xd875ffed6bf6f4036c523ec8df68313251ec15b72eba1b963457eb87a6b54d24::error::invalid_route_key());
        assert!(0x2::bag::contains<0x1::ascii::String>(&arg0.swap_routes, v0), 0xd875ffed6bf6f4036c523ec8df68313251ec15b72eba1b963457eb87a6b54d24::error::invalid_route_key());
        let SwapRoute {
            route     : v1,
            returns_x : _,
        } = 0x2::bag::remove<0x1::ascii::String, SwapRoute>(&mut arg0.swap_routes, v0);
        let v3 = v1;
        while (!0x1::vector::is_empty<0x7d798502daf9e53a65b7a725c855de31c7887913227b6d155bc49508d757510f::bag_value::Value>(&v3)) {
            let (_, _) = 0x7d798502daf9e53a65b7a725c855de31c7887913227b6d155bc49508d757510f::bag_value::unwrap(0x1::vector::pop_back<0x7d798502daf9e53a65b7a725c855de31c7887913227b6d155bc49508d757510f::bag_value::Value>(&mut v3));
        };
        0x1::vector::destroy_empty<0x7d798502daf9e53a65b7a725c855de31c7887913227b6d155bc49508d757510f::bag_value::Value>(v3);
    }

    public(friend) fun revoke_cap<T0, T1, T2, T3: copy + drop + store>(arg0: &mut Vault<T0, T1, T2, T3>, arg1: 0x2::object::ID) {
        0x2::dynamic_field::add<0x2::object::ID, bool>(&mut arg0.id, arg1, true);
    }

    public fun scalling_factor() : u128 {
        (18446744073709551616 as u128)
    }

    public(friend) fun seed<T0, T1, T2, T3: copy + drop + store>(arg0: &mut Vault<T0, T1, T2, T3>, arg1: 0x2::balance::Balance<T2>) {
        assert!(0x2::balance::value<T2>(&arg0.seed_balance) == 0, 0xd875ffed6bf6f4036c523ec8df68313251ec15b72eba1b963457eb87a6b54d24::error::seed_balance_zero());
        0x2::balance::join<T2>(&mut arg0.seed_balance, arg1);
    }

    public fun seed_balance<T0, T1, T2, T3: copy + drop + store>(arg0: &Vault<T0, T1, T2, T3>) : u64 {
        0x2::balance::value<T2>(&arg0.seed_balance)
    }

    public fun set_active_vault_cap<T0, T1, T2, T3: copy + drop + store>(arg0: &mut Vault<T0, T1, T2, T3>, arg1: 0x2::object::ID, arg2: &mut 0x2::tx_context::TxContext) {
        abort 0
    }

    public(friend) fun set_active_vault_cap_internal<T0, T1, T2, T3: copy + drop + store>(arg0: &mut Vault<T0, T1, T2, T3>, arg1: 0x2::object::ID, arg2: &mut 0x2::tx_context::TxContext) {
        if (0x2::dynamic_field::exists_<vector<u8>>(&arg0.id, b"vault_cap")) {
            0x2::dynamic_field::remove<vector<u8>, 0x2::object::ID>(&mut arg0.id, b"vault_cap");
        };
        0x2::dynamic_field::add<vector<u8>, 0x2::object::ID>(&mut arg0.id, b"vault_cap", arg1);
    }

    public(friend) fun set_deposit_enable<T0, T1, T2, T3: copy + drop + store>(arg0: &mut Vault<T0, T1, T2, T3>, arg1: bool) {
        *0x2::dynamic_field::borrow_mut<vector<u8>, bool>(&mut arg0.id, 0xd875ffed6bf6f4036c523ec8df68313251ec15b72eba1b963457eb87a6b54d24::constants::deposit_enabled_df_key()) = arg1;
    }

    public fun set_deposit_limit<T0, T1, T2, T3: copy + drop + store>(arg0: &mut Vault<T0, T1, T2, T3>, arg1: &VaultCap, arg2: u64) {
        abort 0
    }

    public(friend) fun set_deposit_limit_internal<T0, T1, T2, T3: copy + drop + store>(arg0: &mut Vault<T0, T1, T2, T3>, arg1: u64) {
        arg0.deposit_limit = arg1;
    }

    public fun set_fee<T0, T1, T2, T3: copy + drop + store>(arg0: &mut Vault<T0, T1, T2, T3>, arg1: &VaultCap, arg2: u64) {
        abort 0
    }

    public(friend) fun set_fee_val_internal<T0, T1, T2, T3: copy + drop + store>(arg0: &mut Vault<T0, T1, T2, T3>, arg1: u64) {
        assert!(arg1 <= 1000000, 0xd875ffed6bf6f4036c523ec8df68313251ec15b72eba1b963457eb87a6b54d24::error::invalid_fee_val());
        arg0.fee_val = arg1;
    }

    public fun set_free_threshold_a<T0, T1, T2, T3: copy + drop + store>(arg0: &mut Vault<T0, T1, T2, T3>, arg1: &VaultCap, arg2: u64) {
        abort 0
    }

    public(friend) fun set_free_threshold_a_internal<T0, T1, T2, T3: copy + drop + store>(arg0: &mut Vault<T0, T1, T2, T3>, arg1: u64) {
        arg0.free_threshold_a = arg1;
    }

    public fun set_free_threshold_b<T0, T1, T2, T3: copy + drop + store>(arg0: &mut Vault<T0, T1, T2, T3>, arg1: &VaultCap, arg2: u64) {
        abort 0
    }

    public(friend) fun set_free_threshold_b_internal<T0, T1, T2, T3: copy + drop + store>(arg0: &mut Vault<T0, T1, T2, T3>, arg1: u64) {
        arg0.free_threshold_b = arg1;
    }

    public(friend) fun set_intialised(arg0: &mut VaultCap) {
        arg0.is_initialised = true;
    }

    public fun set_lock_threshold_a<T0, T1, T2, T3: copy + drop + store>(arg0: &mut Vault<T0, T1, T2, T3>, arg1: &VaultCap, arg2: u64) {
        abort 0
    }

    public(friend) fun set_lock_threshold_a_internal<T0, T1, T2, T3: copy + drop + store>(arg0: &mut Vault<T0, T1, T2, T3>, arg1: u64) {
        arg0.lock_threshold_a = arg1;
    }

    public fun set_lock_threshold_b<T0, T1, T2, T3: copy + drop + store>(arg0: &mut Vault<T0, T1, T2, T3>, arg1: &VaultCap, arg2: u64) {
        abort 0
    }

    public(friend) fun set_lock_threshold_b_internal<T0, T1, T2, T3: copy + drop + store>(arg0: &mut Vault<T0, T1, T2, T3>, arg1: u64) {
        arg0.lock_threshold_b = arg1;
    }

    public(friend) fun set_price_scalling<T0, T1, T2, T3: copy + drop + store>(arg0: &mut Vault<T0, T1, T2, T3>, arg1: u128, arg2: u128) {
        arg0.lower_price_scalling = arg1;
        arg0.upper_price_scalling = arg2;
    }

    public(friend) fun set_rebalance_price_source<T0, T1, T2, T3: copy + drop + store>(arg0: &mut Vault<T0, T1, T2, T3>, arg1: u8) {
        if (0x2::dynamic_field::exists_<vector<u8>>(&arg0.id, b"price_source")) {
            0x2::dynamic_field::remove<vector<u8>, u8>(&mut arg0.id, b"price_source");
        };
        0x2::dynamic_field::add<vector<u8>, u8>(&mut arg0.id, b"price_source", arg1);
    }

    public(friend) fun set_rebalance_time<T0, T1, T2, T3: copy + drop + store>(arg0: &mut Vault<T0, T1, T2, T3>, arg1: u64) {
        arg0.last_rebalance_time = arg1;
    }

    public(friend) fun set_slippage<T0, T1, T2, T3: copy + drop + store>(arg0: &mut Vault<T0, T1, T2, T3>, arg1: u128, arg2: u128) {
        arg0.slippage_up = arg1;
        arg0.slippage_down = arg2;
    }

    public fun set_slippage_down<T0, T1, T2, T3: copy + drop + store>(arg0: &mut Vault<T0, T1, T2, T3>, arg1: &VaultCap, arg2: u128) {
        abort 0
    }

    public fun set_slippage_up<T0, T1, T2, T3: copy + drop + store>(arg0: &mut Vault<T0, T1, T2, T3>, arg1: &VaultCap, arg2: u128) {
        abort 0
    }

    public(friend) fun set_target_adapter_internal<T0, T1, T2>(arg0: &mut Vault<T0, T1, T2, 0xd875ffed6bf6f4036c523ec8df68313251ec15b72eba1b963457eb87a6b54d24::config::Drift>, arg1: 0x1::ascii::String) {
        0xd875ffed6bf6f4036c523ec8df68313251ec15b72eba1b963457eb87a6b54d24::config::set_target_adapter(borrow_mut_config<T0, T1, T2, 0xd875ffed6bf6f4036c523ec8df68313251ec15b72eba1b963457eb87a6b54d24::config::Drift>(arg0), arg1);
    }

    public(friend) fun set_uc_is_target_reverse_internal<T0, T1, T2>(arg0: &mut Vault<T0, T1, T2, 0xd875ffed6bf6f4036c523ec8df68313251ec15b72eba1b963457eb87a6b54d24::config::Uncorrelated>, arg1: bool) {
        0xd875ffed6bf6f4036c523ec8df68313251ec15b72eba1b963457eb87a6b54d24::config::set_uc_is_target_reverse(borrow_mut_config<T0, T1, T2, 0xd875ffed6bf6f4036c523ec8df68313251ec15b72eba1b963457eb87a6b54d24::config::Uncorrelated>(arg0), arg1);
    }

    public(friend) fun set_uc_target_adapter_internal<T0, T1, T2>(arg0: &mut Vault<T0, T1, T2, 0xd875ffed6bf6f4036c523ec8df68313251ec15b72eba1b963457eb87a6b54d24::config::Uncorrelated>, arg1: 0x1::ascii::String) {
        0xd875ffed6bf6f4036c523ec8df68313251ec15b72eba1b963457eb87a6b54d24::config::set_uc_target_adapter(borrow_mut_config<T0, T1, T2, 0xd875ffed6bf6f4036c523ec8df68313251ec15b72eba1b963457eb87a6b54d24::config::Uncorrelated>(arg0), arg1);
    }

    public fun set_withdraw_fee<T0, T1, T2, T3: copy + drop + store>(arg0: &mut Vault<T0, T1, T2, T3>, arg1: &VaultCap, arg2: u64) {
        abort 0
    }

    public(friend) fun set_withdraw_fee_val_internal<T0, T1, T2, T3: copy + drop + store>(arg0: &mut Vault<T0, T1, T2, T3>, arg1: u64) {
        assert!(arg1 <= 1000000, 0xd875ffed6bf6f4036c523ec8df68313251ec15b72eba1b963457eb87a6b54d24::error::invalid_fee_val());
        arg0.withdraw_fee_val = arg1;
    }

    public fun swap_route_returns_x<T0, T1, T2, T3: copy + drop + store, T4>(arg0: &Vault<T0, T1, T2, T3>) : bool {
        let v0 = 0x1::type_name::into_string(0x1::type_name::get<T4>());
        assert!(0x2::bag::contains<0x1::ascii::String>(&arg0.swap_routes, v0), 0xd875ffed6bf6f4036c523ec8df68313251ec15b72eba1b963457eb87a6b54d24::error::invalid_route_key());
        0x2::bag::borrow<0x1::ascii::String, SwapRoute>(&arg0.swap_routes, v0).returns_x
    }

    public(friend) fun tc_borrow_mut<T0, T1, T2, T3: copy + drop + store>(arg0: &mut Vault<T0, T1, T2, T3>) : &mut 0x2::coin::TreasuryCap<T2> {
        &mut arg0.treasury_cap
    }

    public(friend) fun unpause<T0, T1, T2, T3: copy + drop + store>(arg0: &mut Vault<T0, T1, T2, T3>) {
        arg0.paused = false;
    }

    public(friend) fun update_last_rebalance_sqrt_price<T0, T1, T2, T3: copy + drop + store>(arg0: &mut Vault<T0, T1, T2, T3>, arg1: u128) {
        arg0.last_rebalance_sqrt_price = arg1;
    }

    public fun update_rebalance_cap_ownership(arg0: &VaultCap, arg1: &mut RebalanceCap, arg2: address, arg3: &0xd875ffed6bf6f4036c523ec8df68313251ec15b72eba1b963457eb87a6b54d24::version::Version) {
        0xd875ffed6bf6f4036c523ec8df68313251ec15b72eba1b963457eb87a6b54d24::version::assert_supported_version(arg3);
        assert!(arg0.vault_id == arg1.vault_id, 0xd875ffed6bf6f4036c523ec8df68313251ec15b72eba1b963457eb87a6b54d24::error::invalid_rebalance_cap());
        arg1.whitelisted_address = arg2;
    }

    public(friend) fun update_ticks_info<T0, T1, T2, T3: copy + drop + store>(arg0: &mut Vault<T0, T1, T2, T3>, arg1: u32, arg2: u32) {
        arg0.lower_tick = arg1;
        arg0.upper_tick = arg2;
    }

    public fun when_not_paused<T0, T1, T2, T3: copy + drop + store>(arg0: &Vault<T0, T1, T2, T3>) {
        assert!(!arg0.paused, 0xd875ffed6bf6f4036c523ec8df68313251ec15b72eba1b963457eb87a6b54d24::error::vault_paused());
    }

    public(friend) fun withdraw_fee_a<T0, T1, T2, T3: copy + drop + store>(arg0: &mut Vault<T0, T1, T2, T3>, arg1: u64, arg2: &mut 0x2::tx_context::TxContext) : 0x2::balance::Balance<T0> {
        0x2::balance::split<T0>(&mut arg0.fee_a, arg1)
    }

    public(friend) fun withdraw_fee_b<T0, T1, T2, T3: copy + drop + store>(arg0: &mut Vault<T0, T1, T2, T3>, arg1: u64, arg2: &mut 0x2::tx_context::TxContext) : 0x2::balance::Balance<T1> {
        0x2::balance::split<T1>(&mut arg0.fee_b, arg1)
    }

    public fun withdraw_fee_val<T0, T1, T2, T3: copy + drop + store>(arg0: &Vault<T0, T1, T2, T3>) : u64 {
        arg0.withdraw_fee_val
    }

    // decompiled from Move bytecode v6
}

