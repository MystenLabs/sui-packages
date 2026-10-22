module 0x6949079b5873a2bbb94439acf9c85836a5a96189c687199e6cec0308348867f8::admin {
    public fun add_admin(arg0: &mut 0x6949079b5873a2bbb94439acf9c85836a5a96189c687199e6cec0308348867f8::auth::Auth, arg1: &0x6949079b5873a2bbb94439acf9c85836a5a96189c687199e6cec0308348867f8::registry::Registry, arg2: 0x1::option::Option<0x6949079b5873a2bbb94439acf9c85836a5a96189c687199e6cec0308348867f8::timelock_cap::TimelockTicket>, arg3: address, arg4: &0x2::tx_context::TxContext) {
        0x6949079b5873a2bbb94439acf9c85836a5a96189c687199e6cec0308348867f8::auth::assert_governance(arg1, arg0, arg2, arg4);
        assert!(arg3 != @0x0, 0x6949079b5873a2bbb94439acf9c85836a5a96189c687199e6cec0308348867f8::errors::admin_module_address_zero());
        0x6949079b5873a2bbb94439acf9c85836a5a96189c687199e6cec0308348867f8::auth::add_admin(arg0, arg3);
    }

    public fun collect_revenue<T0>(arg0: &0x6949079b5873a2bbb94439acf9c85836a5a96189c687199e6cec0308348867f8::auth::Auth, arg1: &0x6949079b5873a2bbb94439acf9c85836a5a96189c687199e6cec0308348867f8::registry::Registry, arg2: 0x1::option::Option<0x6949079b5873a2bbb94439acf9c85836a5a96189c687199e6cec0308348867f8::timelock_cap::TimelockTicket>, arg3: &mut 0x6949079b5873a2bbb94439acf9c85836a5a96189c687199e6cec0308348867f8::reserve::TokenReserve<T0>, arg4: &0x2::clock::Clock, arg5: &mut 0x2::tx_context::TxContext) {
        0x6949079b5873a2bbb94439acf9c85836a5a96189c687199e6cec0308348867f8::auth::assert_auth(arg1, arg0, arg2, arg5);
        let v0 = 0x6949079b5873a2bbb94439acf9c85836a5a96189c687199e6cec0308348867f8::registry::get_revenue_collector(arg1);
        assert!(v0 != @0x0, 0x6949079b5873a2bbb94439acf9c85836a5a96189c687199e6cec0308348867f8::errors::admin_module_revenue_collector_not_set());
        let (v1, v2) = 0x6949079b5873a2bbb94439acf9c85836a5a96189c687199e6cec0308348867f8::reserve::update_exchange_price<T0>(arg3, 0x8dd99ecce2f05548858a39694aa5bbdd1c61adc260f9b90dc3889a9c7930ad01::units::from_clock(arg4));
        let v3 = 0x6949079b5873a2bbb94439acf9c85836a5a96189c687199e6cec0308348867f8::reserve::calc_revenue<T0>(arg3, v1, v2);
        if (v3 > 0) {
            0x2::transfer::public_transfer<0x2::coin::Coin<T0>>(0x2::coin::from_balance<T0>(0x6949079b5873a2bbb94439acf9c85836a5a96189c687199e6cec0308348867f8::reserve::withdraw<T0>(arg3, v3), arg5), v0);
        };
        0x6949079b5873a2bbb94439acf9c85836a5a96189c687199e6cec0308348867f8::events::emit_log_collect_revenue(0x1::type_name::with_defining_ids<T0>(), v3);
    }

    public fun disable_timelock(arg0: &mut 0x6949079b5873a2bbb94439acf9c85836a5a96189c687199e6cec0308348867f8::auth::Auth, arg1: &0x6949079b5873a2bbb94439acf9c85836a5a96189c687199e6cec0308348867f8::registry::Registry, arg2: 0x6949079b5873a2bbb94439acf9c85836a5a96189c687199e6cec0308348867f8::timelock_cap::TimelockCap, arg3: &0x2::tx_context::TxContext) {
        0x6949079b5873a2bbb94439acf9c85836a5a96189c687199e6cec0308348867f8::registry::assert_version(arg1);
        0x6949079b5873a2bbb94439acf9c85836a5a96189c687199e6cec0308348867f8::auth::assert_is_governance_direct(arg0, arg3);
        0x6949079b5873a2bbb94439acf9c85836a5a96189c687199e6cec0308348867f8::auth::disable_timelock(arg0, arg2);
        0x6949079b5873a2bbb94439acf9c85836a5a96189c687199e6cec0308348867f8::events::emit_log_timelock_disabled(0x2::object::id<0x6949079b5873a2bbb94439acf9c85836a5a96189c687199e6cec0308348867f8::timelock_cap::TimelockCap>(&arg2));
    }

    public fun init_token_reserve<T0>(arg0: &0x6949079b5873a2bbb94439acf9c85836a5a96189c687199e6cec0308348867f8::auth::Auth, arg1: &mut 0x6949079b5873a2bbb94439acf9c85836a5a96189c687199e6cec0308348867f8::registry::Registry, arg2: 0x1::option::Option<0x6949079b5873a2bbb94439acf9c85836a5a96189c687199e6cec0308348867f8::timelock_cap::TimelockTicket>, arg3: &0x2::coin_registry::Currency<T0>, arg4: &0x2::clock::Clock, arg5: &mut 0x2::tx_context::TxContext) {
        0x6949079b5873a2bbb94439acf9c85836a5a96189c687199e6cec0308348867f8::auth::assert_auth(arg1, arg0, arg2, arg5);
        let v0 = 0x2::coin_registry::decimals<T0>(arg3);
        let v1 = 0x6949079b5873a2bbb94439acf9c85836a5a96189c687199e6cec0308348867f8::reserve::new_reserve<T0>(arg1, v0, 0x8dd99ecce2f05548858a39694aa5bbdd1c61adc260f9b90dc3889a9c7930ad01::units::from_clock(arg4), arg5);
        0x6949079b5873a2bbb94439acf9c85836a5a96189c687199e6cec0308348867f8::events::emit_log_init_token_reserve(0x1::type_name::with_defining_ids<T0>(), 0x2::object::id<0x6949079b5873a2bbb94439acf9c85836a5a96189c687199e6cec0308348867f8::reserve::TokenReserve<T0>>(&v1), v0, 0x2::tx_context::sender(arg5));
        0x6949079b5873a2bbb94439acf9c85836a5a96189c687199e6cec0308348867f8::reserve::share<T0>(v1);
    }

    public fun init_token_reserve_with_metadata<T0>(arg0: &0x6949079b5873a2bbb94439acf9c85836a5a96189c687199e6cec0308348867f8::auth::Auth, arg1: &mut 0x6949079b5873a2bbb94439acf9c85836a5a96189c687199e6cec0308348867f8::registry::Registry, arg2: 0x1::option::Option<0x6949079b5873a2bbb94439acf9c85836a5a96189c687199e6cec0308348867f8::timelock_cap::TimelockTicket>, arg3: &0x2::coin::CoinMetadata<T0>, arg4: &0x2::clock::Clock, arg5: &mut 0x2::tx_context::TxContext) {
        0x6949079b5873a2bbb94439acf9c85836a5a96189c687199e6cec0308348867f8::auth::assert_auth(arg1, arg0, arg2, arg5);
        let v0 = 0x2::coin::get_decimals<T0>(arg3);
        let v1 = 0x6949079b5873a2bbb94439acf9c85836a5a96189c687199e6cec0308348867f8::reserve::new_reserve<T0>(arg1, v0, 0x8dd99ecce2f05548858a39694aa5bbdd1c61adc260f9b90dc3889a9c7930ad01::units::from_clock(arg4), arg5);
        0x6949079b5873a2bbb94439acf9c85836a5a96189c687199e6cec0308348867f8::events::emit_log_init_token_reserve(0x1::type_name::with_defining_ids<T0>(), 0x2::object::id<0x6949079b5873a2bbb94439acf9c85836a5a96189c687199e6cec0308348867f8::reserve::TokenReserve<T0>>(&v1), v0, 0x2::tx_context::sender(arg5));
        0x6949079b5873a2bbb94439acf9c85836a5a96189c687199e6cec0308348867f8::reserve::share<T0>(v1);
    }

    public fun migrate(arg0: &0x6949079b5873a2bbb94439acf9c85836a5a96189c687199e6cec0308348867f8::auth::Auth, arg1: &mut 0x6949079b5873a2bbb94439acf9c85836a5a96189c687199e6cec0308348867f8::registry::Registry, arg2: &0x2::tx_context::TxContext) {
        0x6949079b5873a2bbb94439acf9c85836a5a96189c687199e6cec0308348867f8::auth::assert_is_migrator(arg0, arg2);
        0x6949079b5873a2bbb94439acf9c85836a5a96189c687199e6cec0308348867f8::registry::migrate(arg1);
    }

    public fun mint_timelock_cap(arg0: &mut 0x6949079b5873a2bbb94439acf9c85836a5a96189c687199e6cec0308348867f8::auth::Auth, arg1: &0x6949079b5873a2bbb94439acf9c85836a5a96189c687199e6cec0308348867f8::registry::Registry, arg2: &mut 0x2::tx_context::TxContext) : 0x6949079b5873a2bbb94439acf9c85836a5a96189c687199e6cec0308348867f8::timelock_cap::TimelockCap {
        0x6949079b5873a2bbb94439acf9c85836a5a96189c687199e6cec0308348867f8::registry::assert_version(arg1);
        0x6949079b5873a2bbb94439acf9c85836a5a96189c687199e6cec0308348867f8::auth::assert_is_governance_direct(arg0, arg2);
        let v0 = 0x6949079b5873a2bbb94439acf9c85836a5a96189c687199e6cec0308348867f8::auth::enable_timelock(arg0, arg2);
        0x6949079b5873a2bbb94439acf9c85836a5a96189c687199e6cec0308348867f8::events::emit_log_timelock_enabled(0x2::object::id<0x6949079b5873a2bbb94439acf9c85836a5a96189c687199e6cec0308348867f8::timelock_cap::TimelockCap>(&v0));
        v0
    }

    public fun mint_user_cap<T0>(arg0: &0x6949079b5873a2bbb94439acf9c85836a5a96189c687199e6cec0308348867f8::auth::Auth, arg1: &mut 0x6949079b5873a2bbb94439acf9c85836a5a96189c687199e6cec0308348867f8::registry::Registry, arg2: 0x1::option::Option<0x6949079b5873a2bbb94439acf9c85836a5a96189c687199e6cec0308348867f8::timelock_cap::TimelockTicket>, arg3: 0x6949079b5873a2bbb94439acf9c85836a5a96189c687199e6cec0308348867f8::keys::Holder, arg4: &0x2::tx_context::TxContext) : 0x6949079b5873a2bbb94439acf9c85836a5a96189c687199e6cec0308348867f8::user_cap::UserCap<T0> {
        0x6949079b5873a2bbb94439acf9c85836a5a96189c687199e6cec0308348867f8::auth::assert_governance(arg1, arg0, arg2, arg4);
        0x6949079b5873a2bbb94439acf9c85836a5a96189c687199e6cec0308348867f8::keys::assert_holder_valid(arg3);
        assert!(0x6949079b5873a2bbb94439acf9c85836a5a96189c687199e6cec0308348867f8::registry::get_reserve_exists<T0>(arg1), 0x6949079b5873a2bbb94439acf9c85836a5a96189c687199e6cec0308348867f8::errors::registry_reserve_not_found());
        let v0 = 0x6949079b5873a2bbb94439acf9c85836a5a96189c687199e6cec0308348867f8::user_cap::mint<T0>(arg1, arg3);
        0x6949079b5873a2bbb94439acf9c85836a5a96189c687199e6cec0308348867f8::events::emit_log_mint_user_cap(0x2::object::id<0x6949079b5873a2bbb94439acf9c85836a5a96189c687199e6cec0308348867f8::user_cap::UserCap<T0>>(&v0), arg3, 0x1::type_name::with_defining_ids<T0>());
        v0
    }

    public fun pause_global(arg0: &0x6949079b5873a2bbb94439acf9c85836a5a96189c687199e6cec0308348867f8::auth::Auth, arg1: &mut 0x6949079b5873a2bbb94439acf9c85836a5a96189c687199e6cec0308348867f8::registry::Registry, arg2: 0x6949079b5873a2bbb94439acf9c85836a5a96189c687199e6cec0308348867f8::pause::Action, arg3: &0x2::tx_context::TxContext) {
        0x6949079b5873a2bbb94439acf9c85836a5a96189c687199e6cec0308348867f8::auth::assert_guardian(arg1, arg0, arg3);
        let v0 = 0x6949079b5873a2bbb94439acf9c85836a5a96189c687199e6cec0308348867f8::registry::get_pause_flags(arg1);
        assert!(0x6949079b5873a2bbb94439acf9c85836a5a96189c687199e6cec0308348867f8::pause::get_allows(&v0, arg2), 0x6949079b5873a2bbb94439acf9c85836a5a96189c687199e6cec0308348867f8::errors::admin_module_invalid_params());
        0x6949079b5873a2bbb94439acf9c85836a5a96189c687199e6cec0308348867f8::registry::set_global_pause(arg1, arg2, true);
        0x6949079b5873a2bbb94439acf9c85836a5a96189c687199e6cec0308348867f8::events::emit_log_global_pause_changed(arg2, true, 0x2::tx_context::sender(arg3));
    }

    public fun pause_token<T0>(arg0: &0x6949079b5873a2bbb94439acf9c85836a5a96189c687199e6cec0308348867f8::auth::Auth, arg1: &0x6949079b5873a2bbb94439acf9c85836a5a96189c687199e6cec0308348867f8::registry::Registry, arg2: &mut 0x6949079b5873a2bbb94439acf9c85836a5a96189c687199e6cec0308348867f8::reserve::TokenReserve<T0>, arg3: 0x6949079b5873a2bbb94439acf9c85836a5a96189c687199e6cec0308348867f8::pause::Action, arg4: &0x2::tx_context::TxContext) {
        0x6949079b5873a2bbb94439acf9c85836a5a96189c687199e6cec0308348867f8::auth::assert_guardian(arg1, arg0, arg4);
        let v0 = 0x6949079b5873a2bbb94439acf9c85836a5a96189c687199e6cec0308348867f8::reserve::get_pause_flags<T0>(arg2);
        assert!(0x6949079b5873a2bbb94439acf9c85836a5a96189c687199e6cec0308348867f8::pause::get_allows(&v0, arg3), 0x6949079b5873a2bbb94439acf9c85836a5a96189c687199e6cec0308348867f8::errors::admin_module_invalid_params());
        0x6949079b5873a2bbb94439acf9c85836a5a96189c687199e6cec0308348867f8::reserve::set_reserve_pause<T0>(arg2, arg3, true);
        0x6949079b5873a2bbb94439acf9c85836a5a96189c687199e6cec0308348867f8::events::emit_log_token_pause_changed(0x1::type_name::with_defining_ids<T0>(), arg3, true, 0x2::tx_context::sender(arg4));
    }

    public fun pause_user<T0>(arg0: &0x6949079b5873a2bbb94439acf9c85836a5a96189c687199e6cec0308348867f8::auth::Auth, arg1: &0x6949079b5873a2bbb94439acf9c85836a5a96189c687199e6cec0308348867f8::registry::Registry, arg2: &mut 0x6949079b5873a2bbb94439acf9c85836a5a96189c687199e6cec0308348867f8::reserve::TokenReserve<T0>, arg3: 0x6949079b5873a2bbb94439acf9c85836a5a96189c687199e6cec0308348867f8::keys::Holder, arg4: 0x6949079b5873a2bbb94439acf9c85836a5a96189c687199e6cec0308348867f8::pause::Action, arg5: &0x2::tx_context::TxContext) {
        0x6949079b5873a2bbb94439acf9c85836a5a96189c687199e6cec0308348867f8::auth::assert_guardian(arg1, arg0, arg5);
        if (arg4 == 0x6949079b5873a2bbb94439acf9c85836a5a96189c687199e6cec0308348867f8::pause::action_supply() || arg4 == 0x6949079b5873a2bbb94439acf9c85836a5a96189c687199e6cec0308348867f8::pause::action_withdraw()) {
            assert!(0x6949079b5873a2bbb94439acf9c85836a5a96189c687199e6cec0308348867f8::reserve::get_supply_position_exists<T0>(arg2, arg3), 0x6949079b5873a2bbb94439acf9c85836a5a96189c687199e6cec0308348867f8::errors::admin_module_user_not_defined());
            let v0 = 0x6949079b5873a2bbb94439acf9c85836a5a96189c687199e6cec0308348867f8::reserve::get_supply_position_mut<T0>(arg2, arg3);
            assert!(!0x6949079b5873a2bbb94439acf9c85836a5a96189c687199e6cec0308348867f8::supply_position::get_supply_configs_not_set(v0), 0x6949079b5873a2bbb94439acf9c85836a5a96189c687199e6cec0308348867f8::errors::admin_module_user_not_defined());
            assert!(!0x6949079b5873a2bbb94439acf9c85836a5a96189c687199e6cec0308348867f8::supply_position::get_supply_pause(v0, arg4), 0x6949079b5873a2bbb94439acf9c85836a5a96189c687199e6cec0308348867f8::errors::admin_module_invalid_params());
            0x6949079b5873a2bbb94439acf9c85836a5a96189c687199e6cec0308348867f8::supply_position::set_supply_pause(v0, arg4, true);
        } else {
            assert!(0x6949079b5873a2bbb94439acf9c85836a5a96189c687199e6cec0308348867f8::reserve::get_borrow_position_exists<T0>(arg2, arg3), 0x6949079b5873a2bbb94439acf9c85836a5a96189c687199e6cec0308348867f8::errors::admin_module_user_not_defined());
            let v1 = 0x6949079b5873a2bbb94439acf9c85836a5a96189c687199e6cec0308348867f8::reserve::get_borrow_position_mut<T0>(arg2, arg3);
            assert!(!0x6949079b5873a2bbb94439acf9c85836a5a96189c687199e6cec0308348867f8::borrow_position::get_borrow_configs_not_set(v1), 0x6949079b5873a2bbb94439acf9c85836a5a96189c687199e6cec0308348867f8::errors::admin_module_user_not_defined());
            assert!(!0x6949079b5873a2bbb94439acf9c85836a5a96189c687199e6cec0308348867f8::borrow_position::get_borrow_pause(v1, arg4), 0x6949079b5873a2bbb94439acf9c85836a5a96189c687199e6cec0308348867f8::errors::admin_module_invalid_params());
            0x6949079b5873a2bbb94439acf9c85836a5a96189c687199e6cec0308348867f8::borrow_position::set_borrow_pause(v1, arg4, true);
        };
        0x6949079b5873a2bbb94439acf9c85836a5a96189c687199e6cec0308348867f8::events::emit_log_position_pause_changed(arg3, 0x1::type_name::with_defining_ids<T0>(), arg4, true, 0x2::tx_context::sender(arg5));
    }

    public fun remove_admin(arg0: &mut 0x6949079b5873a2bbb94439acf9c85836a5a96189c687199e6cec0308348867f8::auth::Auth, arg1: &0x6949079b5873a2bbb94439acf9c85836a5a96189c687199e6cec0308348867f8::registry::Registry, arg2: 0x1::option::Option<0x6949079b5873a2bbb94439acf9c85836a5a96189c687199e6cec0308348867f8::timelock_cap::TimelockTicket>, arg3: address, arg4: &0x2::tx_context::TxContext) {
        0x6949079b5873a2bbb94439acf9c85836a5a96189c687199e6cec0308348867f8::auth::assert_governance(arg1, arg0, arg2, arg4);
        0x6949079b5873a2bbb94439acf9c85836a5a96189c687199e6cec0308348867f8::auth::remove_admin(arg0, arg3);
    }

    public fun set_user_authorization<T0>(arg0: &0x6949079b5873a2bbb94439acf9c85836a5a96189c687199e6cec0308348867f8::auth::Auth, arg1: &mut 0x6949079b5873a2bbb94439acf9c85836a5a96189c687199e6cec0308348867f8::registry::Registry, arg2: 0x1::option::Option<0x6949079b5873a2bbb94439acf9c85836a5a96189c687199e6cec0308348867f8::timelock_cap::TimelockTicket>, arg3: 0x6949079b5873a2bbb94439acf9c85836a5a96189c687199e6cec0308348867f8::keys::Holder, arg4: bool, arg5: &0x2::tx_context::TxContext) {
        0x6949079b5873a2bbb94439acf9c85836a5a96189c687199e6cec0308348867f8::auth::assert_governance(arg1, arg0, arg2, arg5);
        if (arg4) {
            0x6949079b5873a2bbb94439acf9c85836a5a96189c687199e6cec0308348867f8::user_cap::activate<T0>(arg1, arg3);
        } else {
            0x6949079b5873a2bbb94439acf9c85836a5a96189c687199e6cec0308348867f8::user_cap::revoke<T0>(arg1, arg3);
        };
        0x6949079b5873a2bbb94439acf9c85836a5a96189c687199e6cec0308348867f8::events::emit_log_set_user_authorization(0x6949079b5873a2bbb94439acf9c85836a5a96189c687199e6cec0308348867f8::user_cap::get_user_cap_id<T0>(arg1, arg3), arg3, 0x1::type_name::with_defining_ids<T0>(), arg4);
    }

    public fun unpause_global(arg0: &0x6949079b5873a2bbb94439acf9c85836a5a96189c687199e6cec0308348867f8::auth::Auth, arg1: &mut 0x6949079b5873a2bbb94439acf9c85836a5a96189c687199e6cec0308348867f8::registry::Registry, arg2: 0x1::option::Option<0x6949079b5873a2bbb94439acf9c85836a5a96189c687199e6cec0308348867f8::timelock_cap::TimelockTicket>, arg3: 0x6949079b5873a2bbb94439acf9c85836a5a96189c687199e6cec0308348867f8::pause::Action, arg4: &0x2::tx_context::TxContext) {
        0x6949079b5873a2bbb94439acf9c85836a5a96189c687199e6cec0308348867f8::auth::assert_governance(arg1, arg0, arg2, arg4);
        let v0 = 0x6949079b5873a2bbb94439acf9c85836a5a96189c687199e6cec0308348867f8::registry::get_pause_flags(arg1);
        assert!(!0x6949079b5873a2bbb94439acf9c85836a5a96189c687199e6cec0308348867f8::pause::get_allows(&v0, arg3), 0x6949079b5873a2bbb94439acf9c85836a5a96189c687199e6cec0308348867f8::errors::admin_module_user_not_paused());
        0x6949079b5873a2bbb94439acf9c85836a5a96189c687199e6cec0308348867f8::registry::set_global_pause(arg1, arg3, false);
        0x6949079b5873a2bbb94439acf9c85836a5a96189c687199e6cec0308348867f8::events::emit_log_global_pause_changed(arg3, false, 0x2::tx_context::sender(arg4));
    }

    public fun unpause_token<T0>(arg0: &0x6949079b5873a2bbb94439acf9c85836a5a96189c687199e6cec0308348867f8::auth::Auth, arg1: &0x6949079b5873a2bbb94439acf9c85836a5a96189c687199e6cec0308348867f8::registry::Registry, arg2: 0x1::option::Option<0x6949079b5873a2bbb94439acf9c85836a5a96189c687199e6cec0308348867f8::timelock_cap::TimelockTicket>, arg3: &mut 0x6949079b5873a2bbb94439acf9c85836a5a96189c687199e6cec0308348867f8::reserve::TokenReserve<T0>, arg4: 0x6949079b5873a2bbb94439acf9c85836a5a96189c687199e6cec0308348867f8::pause::Action, arg5: &0x2::tx_context::TxContext) {
        0x6949079b5873a2bbb94439acf9c85836a5a96189c687199e6cec0308348867f8::auth::assert_governance(arg1, arg0, arg2, arg5);
        let v0 = 0x6949079b5873a2bbb94439acf9c85836a5a96189c687199e6cec0308348867f8::reserve::get_pause_flags<T0>(arg3);
        assert!(!0x6949079b5873a2bbb94439acf9c85836a5a96189c687199e6cec0308348867f8::pause::get_allows(&v0, arg4), 0x6949079b5873a2bbb94439acf9c85836a5a96189c687199e6cec0308348867f8::errors::admin_module_user_not_paused());
        0x6949079b5873a2bbb94439acf9c85836a5a96189c687199e6cec0308348867f8::reserve::set_reserve_pause<T0>(arg3, arg4, false);
        0x6949079b5873a2bbb94439acf9c85836a5a96189c687199e6cec0308348867f8::events::emit_log_token_pause_changed(0x1::type_name::with_defining_ids<T0>(), arg4, false, 0x2::tx_context::sender(arg5));
    }

    public fun unpause_user<T0>(arg0: &0x6949079b5873a2bbb94439acf9c85836a5a96189c687199e6cec0308348867f8::auth::Auth, arg1: &0x6949079b5873a2bbb94439acf9c85836a5a96189c687199e6cec0308348867f8::registry::Registry, arg2: 0x1::option::Option<0x6949079b5873a2bbb94439acf9c85836a5a96189c687199e6cec0308348867f8::timelock_cap::TimelockTicket>, arg3: &mut 0x6949079b5873a2bbb94439acf9c85836a5a96189c687199e6cec0308348867f8::reserve::TokenReserve<T0>, arg4: 0x6949079b5873a2bbb94439acf9c85836a5a96189c687199e6cec0308348867f8::keys::Holder, arg5: 0x6949079b5873a2bbb94439acf9c85836a5a96189c687199e6cec0308348867f8::pause::Action, arg6: &0x2::tx_context::TxContext) {
        0x6949079b5873a2bbb94439acf9c85836a5a96189c687199e6cec0308348867f8::auth::assert_governance(arg1, arg0, arg2, arg6);
        if (arg5 == 0x6949079b5873a2bbb94439acf9c85836a5a96189c687199e6cec0308348867f8::pause::action_supply() || arg5 == 0x6949079b5873a2bbb94439acf9c85836a5a96189c687199e6cec0308348867f8::pause::action_withdraw()) {
            assert!(0x6949079b5873a2bbb94439acf9c85836a5a96189c687199e6cec0308348867f8::reserve::get_supply_position_exists<T0>(arg3, arg4), 0x6949079b5873a2bbb94439acf9c85836a5a96189c687199e6cec0308348867f8::errors::admin_module_user_not_paused());
            let v0 = 0x6949079b5873a2bbb94439acf9c85836a5a96189c687199e6cec0308348867f8::reserve::get_supply_position_mut<T0>(arg3, arg4);
            assert!(0x6949079b5873a2bbb94439acf9c85836a5a96189c687199e6cec0308348867f8::supply_position::get_supply_pause(v0, arg5), 0x6949079b5873a2bbb94439acf9c85836a5a96189c687199e6cec0308348867f8::errors::admin_module_user_not_paused());
            0x6949079b5873a2bbb94439acf9c85836a5a96189c687199e6cec0308348867f8::supply_position::set_supply_pause(v0, arg5, false);
        } else {
            assert!(0x6949079b5873a2bbb94439acf9c85836a5a96189c687199e6cec0308348867f8::reserve::get_borrow_position_exists<T0>(arg3, arg4), 0x6949079b5873a2bbb94439acf9c85836a5a96189c687199e6cec0308348867f8::errors::admin_module_user_not_paused());
            let v1 = 0x6949079b5873a2bbb94439acf9c85836a5a96189c687199e6cec0308348867f8::reserve::get_borrow_position_mut<T0>(arg3, arg4);
            assert!(0x6949079b5873a2bbb94439acf9c85836a5a96189c687199e6cec0308348867f8::borrow_position::get_borrow_pause(v1, arg5), 0x6949079b5873a2bbb94439acf9c85836a5a96189c687199e6cec0308348867f8::errors::admin_module_user_not_paused());
            0x6949079b5873a2bbb94439acf9c85836a5a96189c687199e6cec0308348867f8::borrow_position::set_borrow_pause(v1, arg5, false);
        };
        0x6949079b5873a2bbb94439acf9c85836a5a96189c687199e6cec0308348867f8::events::emit_log_position_pause_changed(arg4, 0x1::type_name::with_defining_ids<T0>(), arg5, false, 0x2::tx_context::sender(arg6));
    }

    public fun update_auths(arg0: &mut 0x6949079b5873a2bbb94439acf9c85836a5a96189c687199e6cec0308348867f8::auth::Auth, arg1: &0x6949079b5873a2bbb94439acf9c85836a5a96189c687199e6cec0308348867f8::registry::Registry, arg2: 0x1::option::Option<0x6949079b5873a2bbb94439acf9c85836a5a96189c687199e6cec0308348867f8::timelock_cap::TimelockTicket>, arg3: vector<0x6949079b5873a2bbb94439acf9c85836a5a96189c687199e6cec0308348867f8::structs::AddressBool>, arg4: &0x2::tx_context::TxContext) {
        0x6949079b5873a2bbb94439acf9c85836a5a96189c687199e6cec0308348867f8::auth::assert_governance(arg1, arg0, arg2, arg4);
        let v0 = 0;
        while (v0 < 0x1::vector::length<0x6949079b5873a2bbb94439acf9c85836a5a96189c687199e6cec0308348867f8::structs::AddressBool>(&arg3)) {
            let v1 = 0x1::vector::borrow<0x6949079b5873a2bbb94439acf9c85836a5a96189c687199e6cec0308348867f8::structs::AddressBool>(&arg3, v0);
            assert!(0x6949079b5873a2bbb94439acf9c85836a5a96189c687199e6cec0308348867f8::structs::get_address_bool_addr(v1) != @0x0, 0x6949079b5873a2bbb94439acf9c85836a5a96189c687199e6cec0308348867f8::errors::admin_module_address_zero());
            let v2 = 0x6949079b5873a2bbb94439acf9c85836a5a96189c687199e6cec0308348867f8::structs::get_address_bool_addr(v1);
            if (0x6949079b5873a2bbb94439acf9c85836a5a96189c687199e6cec0308348867f8::structs::get_address_bool_value(v1)) {
                if (!0x6949079b5873a2bbb94439acf9c85836a5a96189c687199e6cec0308348867f8::auth::get_is_auth_record(arg0, v2)) {
                    0x6949079b5873a2bbb94439acf9c85836a5a96189c687199e6cec0308348867f8::auth::grant_role<0x6949079b5873a2bbb94439acf9c85836a5a96189c687199e6cec0308348867f8::auth::AuthorizeRole>(arg0, v2);
                };
            } else if (0x6949079b5873a2bbb94439acf9c85836a5a96189c687199e6cec0308348867f8::auth::get_is_auth_record(arg0, v2)) {
                0x6949079b5873a2bbb94439acf9c85836a5a96189c687199e6cec0308348867f8::auth::revoke_role<0x6949079b5873a2bbb94439acf9c85836a5a96189c687199e6cec0308348867f8::auth::AuthorizeRole>(arg0, v2);
            };
            v0 = v0 + 1;
        };
        0x6949079b5873a2bbb94439acf9c85836a5a96189c687199e6cec0308348867f8::events::emit_log_update_auths(arg3);
    }

    public fun update_exchange_prices<T0>(arg0: &0x6949079b5873a2bbb94439acf9c85836a5a96189c687199e6cec0308348867f8::registry::Registry, arg1: &mut 0x6949079b5873a2bbb94439acf9c85836a5a96189c687199e6cec0308348867f8::reserve::TokenReserve<T0>, arg2: &0x2::clock::Clock) : (u128, u128) {
        0x6949079b5873a2bbb94439acf9c85836a5a96189c687199e6cec0308348867f8::registry::assert_version(arg0);
        0x6949079b5873a2bbb94439acf9c85836a5a96189c687199e6cec0308348867f8::reserve::update_exchange_prices_and_rates<T0>(arg1, 0x8dd99ecce2f05548858a39694aa5bbdd1c61adc260f9b90dc3889a9c7930ad01::units::from_clock(arg2))
    }

    public fun update_guardians(arg0: &mut 0x6949079b5873a2bbb94439acf9c85836a5a96189c687199e6cec0308348867f8::auth::Auth, arg1: &0x6949079b5873a2bbb94439acf9c85836a5a96189c687199e6cec0308348867f8::registry::Registry, arg2: 0x1::option::Option<0x6949079b5873a2bbb94439acf9c85836a5a96189c687199e6cec0308348867f8::timelock_cap::TimelockTicket>, arg3: vector<0x6949079b5873a2bbb94439acf9c85836a5a96189c687199e6cec0308348867f8::structs::AddressBool>, arg4: &0x2::tx_context::TxContext) {
        0x6949079b5873a2bbb94439acf9c85836a5a96189c687199e6cec0308348867f8::auth::assert_governance(arg1, arg0, arg2, arg4);
        let v0 = 0;
        while (v0 < 0x1::vector::length<0x6949079b5873a2bbb94439acf9c85836a5a96189c687199e6cec0308348867f8::structs::AddressBool>(&arg3)) {
            let v1 = 0x1::vector::borrow<0x6949079b5873a2bbb94439acf9c85836a5a96189c687199e6cec0308348867f8::structs::AddressBool>(&arg3, v0);
            assert!(0x6949079b5873a2bbb94439acf9c85836a5a96189c687199e6cec0308348867f8::structs::get_address_bool_addr(v1) != @0x0, 0x6949079b5873a2bbb94439acf9c85836a5a96189c687199e6cec0308348867f8::errors::admin_module_address_zero());
            let v2 = 0x6949079b5873a2bbb94439acf9c85836a5a96189c687199e6cec0308348867f8::structs::get_address_bool_addr(v1);
            if (0x6949079b5873a2bbb94439acf9c85836a5a96189c687199e6cec0308348867f8::structs::get_address_bool_value(v1)) {
                if (!0x6949079b5873a2bbb94439acf9c85836a5a96189c687199e6cec0308348867f8::auth::get_is_guardian_record(arg0, v2)) {
                    0x6949079b5873a2bbb94439acf9c85836a5a96189c687199e6cec0308348867f8::auth::grant_role<0x6949079b5873a2bbb94439acf9c85836a5a96189c687199e6cec0308348867f8::auth::GuardianRole>(arg0, v2);
                };
            } else if (0x6949079b5873a2bbb94439acf9c85836a5a96189c687199e6cec0308348867f8::auth::get_is_guardian_record(arg0, v2)) {
                0x6949079b5873a2bbb94439acf9c85836a5a96189c687199e6cec0308348867f8::auth::revoke_role<0x6949079b5873a2bbb94439acf9c85836a5a96189c687199e6cec0308348867f8::auth::GuardianRole>(arg0, v2);
            };
            v0 = v0 + 1;
        };
        0x6949079b5873a2bbb94439acf9c85836a5a96189c687199e6cec0308348867f8::events::emit_log_update_guardians(arg3);
    }

    public fun update_migrators(arg0: &mut 0x6949079b5873a2bbb94439acf9c85836a5a96189c687199e6cec0308348867f8::auth::Auth, arg1: &0x6949079b5873a2bbb94439acf9c85836a5a96189c687199e6cec0308348867f8::registry::Registry, arg2: 0x1::option::Option<0x6949079b5873a2bbb94439acf9c85836a5a96189c687199e6cec0308348867f8::timelock_cap::TimelockTicket>, arg3: vector<0x6949079b5873a2bbb94439acf9c85836a5a96189c687199e6cec0308348867f8::structs::AddressBool>, arg4: &0x2::tx_context::TxContext) {
        0x6949079b5873a2bbb94439acf9c85836a5a96189c687199e6cec0308348867f8::auth::assert_governance(arg1, arg0, arg2, arg4);
        let v0 = 0;
        while (v0 < 0x1::vector::length<0x6949079b5873a2bbb94439acf9c85836a5a96189c687199e6cec0308348867f8::structs::AddressBool>(&arg3)) {
            let v1 = 0x1::vector::borrow<0x6949079b5873a2bbb94439acf9c85836a5a96189c687199e6cec0308348867f8::structs::AddressBool>(&arg3, v0);
            assert!(0x6949079b5873a2bbb94439acf9c85836a5a96189c687199e6cec0308348867f8::structs::get_address_bool_addr(v1) != @0x0, 0x6949079b5873a2bbb94439acf9c85836a5a96189c687199e6cec0308348867f8::errors::admin_module_address_zero());
            let v2 = 0x6949079b5873a2bbb94439acf9c85836a5a96189c687199e6cec0308348867f8::structs::get_address_bool_addr(v1);
            if (0x6949079b5873a2bbb94439acf9c85836a5a96189c687199e6cec0308348867f8::structs::get_address_bool_value(v1)) {
                if (!0x6949079b5873a2bbb94439acf9c85836a5a96189c687199e6cec0308348867f8::auth::get_is_migrator_record(arg0, v2)) {
                    0x6949079b5873a2bbb94439acf9c85836a5a96189c687199e6cec0308348867f8::auth::grant_role<0x6949079b5873a2bbb94439acf9c85836a5a96189c687199e6cec0308348867f8::auth::MigrateRole>(arg0, v2);
                };
            } else if (0x6949079b5873a2bbb94439acf9c85836a5a96189c687199e6cec0308348867f8::auth::get_is_migrator_record(arg0, v2)) {
                0x6949079b5873a2bbb94439acf9c85836a5a96189c687199e6cec0308348867f8::auth::revoke_role<0x6949079b5873a2bbb94439acf9c85836a5a96189c687199e6cec0308348867f8::auth::MigrateRole>(arg0, v2);
            };
            v0 = v0 + 1;
        };
        0x6949079b5873a2bbb94439acf9c85836a5a96189c687199e6cec0308348867f8::events::emit_log_update_migrators(arg3);
    }

    public fun update_rate_data_v1<T0>(arg0: &0x6949079b5873a2bbb94439acf9c85836a5a96189c687199e6cec0308348867f8::auth::Auth, arg1: &0x6949079b5873a2bbb94439acf9c85836a5a96189c687199e6cec0308348867f8::registry::Registry, arg2: 0x1::option::Option<0x6949079b5873a2bbb94439acf9c85836a5a96189c687199e6cec0308348867f8::timelock_cap::TimelockTicket>, arg3: &mut 0x6949079b5873a2bbb94439acf9c85836a5a96189c687199e6cec0308348867f8::reserve::TokenReserve<T0>, arg4: 0x6949079b5873a2bbb94439acf9c85836a5a96189c687199e6cec0308348867f8::structs::RateDataV1Params, arg5: &0x2::clock::Clock, arg6: &0x2::tx_context::TxContext) {
        0x6949079b5873a2bbb94439acf9c85836a5a96189c687199e6cec0308348867f8::auth::assert_auth(arg1, arg0, arg2, arg6);
        let v0 = 0x8dd99ecce2f05548858a39694aa5bbdd1c61adc260f9b90dc3889a9c7930ad01::units::from_clock(arg5);
        let (_, _) = 0x6949079b5873a2bbb94439acf9c85836a5a96189c687199e6cec0308348867f8::reserve::update_exchange_price<T0>(arg3, v0);
        0x6949079b5873a2bbb94439acf9c85836a5a96189c687199e6cec0308348867f8::reserve::set_rate_data_v1<T0>(arg3, 0x6949079b5873a2bbb94439acf9c85836a5a96189c687199e6cec0308348867f8::rate_model::set_rate_data_v1(&arg4));
        let (_, _) = 0x6949079b5873a2bbb94439acf9c85836a5a96189c687199e6cec0308348867f8::reserve::update_exchange_prices_and_rates<T0>(arg3, v0);
        0x6949079b5873a2bbb94439acf9c85836a5a96189c687199e6cec0308348867f8::events::emit_log_update_rate_data_v1s(0x1::type_name::with_defining_ids<T0>(), arg4);
    }

    public fun update_rate_data_v2<T0>(arg0: &0x6949079b5873a2bbb94439acf9c85836a5a96189c687199e6cec0308348867f8::auth::Auth, arg1: &0x6949079b5873a2bbb94439acf9c85836a5a96189c687199e6cec0308348867f8::registry::Registry, arg2: 0x1::option::Option<0x6949079b5873a2bbb94439acf9c85836a5a96189c687199e6cec0308348867f8::timelock_cap::TimelockTicket>, arg3: &mut 0x6949079b5873a2bbb94439acf9c85836a5a96189c687199e6cec0308348867f8::reserve::TokenReserve<T0>, arg4: 0x6949079b5873a2bbb94439acf9c85836a5a96189c687199e6cec0308348867f8::structs::RateDataV2Params, arg5: &0x2::clock::Clock, arg6: &0x2::tx_context::TxContext) {
        0x6949079b5873a2bbb94439acf9c85836a5a96189c687199e6cec0308348867f8::auth::assert_auth(arg1, arg0, arg2, arg6);
        let v0 = 0x8dd99ecce2f05548858a39694aa5bbdd1c61adc260f9b90dc3889a9c7930ad01::units::from_clock(arg5);
        let (_, _) = 0x6949079b5873a2bbb94439acf9c85836a5a96189c687199e6cec0308348867f8::reserve::update_exchange_price<T0>(arg3, v0);
        0x6949079b5873a2bbb94439acf9c85836a5a96189c687199e6cec0308348867f8::reserve::set_rate_data_v2<T0>(arg3, 0x6949079b5873a2bbb94439acf9c85836a5a96189c687199e6cec0308348867f8::rate_model::set_rate_data_v2(&arg4));
        let (_, _) = 0x6949079b5873a2bbb94439acf9c85836a5a96189c687199e6cec0308348867f8::reserve::update_exchange_prices_and_rates<T0>(arg3, v0);
        0x6949079b5873a2bbb94439acf9c85836a5a96189c687199e6cec0308348867f8::events::emit_log_update_rate_data_v2s(0x1::type_name::with_defining_ids<T0>(), arg4);
    }

    public fun update_revenue_collector(arg0: &0x6949079b5873a2bbb94439acf9c85836a5a96189c687199e6cec0308348867f8::auth::Auth, arg1: &mut 0x6949079b5873a2bbb94439acf9c85836a5a96189c687199e6cec0308348867f8::registry::Registry, arg2: 0x1::option::Option<0x6949079b5873a2bbb94439acf9c85836a5a96189c687199e6cec0308348867f8::timelock_cap::TimelockTicket>, arg3: address, arg4: &0x2::tx_context::TxContext) {
        0x6949079b5873a2bbb94439acf9c85836a5a96189c687199e6cec0308348867f8::auth::assert_governance(arg1, arg0, arg2, arg4);
        assert!(arg3 != @0x0, 0x6949079b5873a2bbb94439acf9c85836a5a96189c687199e6cec0308348867f8::errors::admin_module_address_zero());
        0x6949079b5873a2bbb94439acf9c85836a5a96189c687199e6cec0308348867f8::registry::set_revenue_collector(arg1, arg3);
        0x6949079b5873a2bbb94439acf9c85836a5a96189c687199e6cec0308348867f8::events::emit_log_update_revenue_collector(arg3);
    }

    public fun update_token_config<T0>(arg0: &0x6949079b5873a2bbb94439acf9c85836a5a96189c687199e6cec0308348867f8::auth::Auth, arg1: &0x6949079b5873a2bbb94439acf9c85836a5a96189c687199e6cec0308348867f8::registry::Registry, arg2: 0x1::option::Option<0x6949079b5873a2bbb94439acf9c85836a5a96189c687199e6cec0308348867f8::timelock_cap::TimelockTicket>, arg3: &mut 0x6949079b5873a2bbb94439acf9c85836a5a96189c687199e6cec0308348867f8::reserve::TokenReserve<T0>, arg4: 0x6949079b5873a2bbb94439acf9c85836a5a96189c687199e6cec0308348867f8::structs::TokenConfig, arg5: &0x2::clock::Clock, arg6: &0x2::tx_context::TxContext) {
        0x6949079b5873a2bbb94439acf9c85836a5a96189c687199e6cec0308348867f8::auth::assert_auth(arg1, arg0, arg2, arg6);
        let v0 = 0x8dd99ecce2f05548858a39694aa5bbdd1c61adc260f9b90dc3889a9c7930ad01::units::from_clock(arg5);
        assert!(0x6949079b5873a2bbb94439acf9c85836a5a96189c687199e6cec0308348867f8::reserve::get_rate_data_set<T0>(arg3), 0x6949079b5873a2bbb94439acf9c85836a5a96189c687199e6cec0308348867f8::errors::admin_module_invalid_config_order());
        assert!(0x6949079b5873a2bbb94439acf9c85836a5a96189c687199e6cec0308348867f8::structs::get_token_config_fee(&arg4) <= 0x6949079b5873a2bbb94439acf9c85836a5a96189c687199e6cec0308348867f8::constants::four_decimals(), 0x6949079b5873a2bbb94439acf9c85836a5a96189c687199e6cec0308348867f8::errors::admin_module_value_overflow_fee());
        assert!(0x6949079b5873a2bbb94439acf9c85836a5a96189c687199e6cec0308348867f8::structs::get_token_config_fee(&arg4) != 0, 0x6949079b5873a2bbb94439acf9c85836a5a96189c687199e6cec0308348867f8::errors::admin_module_invalid_params());
        assert!(0x6949079b5873a2bbb94439acf9c85836a5a96189c687199e6cec0308348867f8::structs::get_token_config_max_utilization(&arg4) <= 0x6949079b5873a2bbb94439acf9c85836a5a96189c687199e6cec0308348867f8::constants::four_decimals(), 0x6949079b5873a2bbb94439acf9c85836a5a96189c687199e6cec0308348867f8::errors::admin_module_value_overflow_max_utilization());
        assert!(0x6949079b5873a2bbb94439acf9c85836a5a96189c687199e6cec0308348867f8::structs::get_token_config_max_utilization(&arg4) != 0, 0x6949079b5873a2bbb94439acf9c85836a5a96189c687199e6cec0308348867f8::errors::admin_module_invalid_params());
        let (_, _) = 0x6949079b5873a2bbb94439acf9c85836a5a96189c687199e6cec0308348867f8::reserve::update_exchange_price<T0>(arg3, v0);
        0x6949079b5873a2bbb94439acf9c85836a5a96189c687199e6cec0308348867f8::reserve::set_token_config<T0>(arg3, 0x6949079b5873a2bbb94439acf9c85836a5a96189c687199e6cec0308348867f8::structs::get_token_config_fee(&arg4), 0x6949079b5873a2bbb94439acf9c85836a5a96189c687199e6cec0308348867f8::structs::get_token_config_max_utilization(&arg4));
        let (_, _) = 0x6949079b5873a2bbb94439acf9c85836a5a96189c687199e6cec0308348867f8::reserve::update_exchange_prices_and_rates<T0>(arg3, v0);
        0x6949079b5873a2bbb94439acf9c85836a5a96189c687199e6cec0308348867f8::events::emit_log_update_token_configs(0x1::type_name::with_defining_ids<T0>(), arg4);
    }

    public fun update_user_borrow_configs<T0>(arg0: &0x6949079b5873a2bbb94439acf9c85836a5a96189c687199e6cec0308348867f8::auth::Auth, arg1: &0x6949079b5873a2bbb94439acf9c85836a5a96189c687199e6cec0308348867f8::registry::Registry, arg2: 0x1::option::Option<0x6949079b5873a2bbb94439acf9c85836a5a96189c687199e6cec0308348867f8::timelock_cap::TimelockTicket>, arg3: &mut 0x6949079b5873a2bbb94439acf9c85836a5a96189c687199e6cec0308348867f8::reserve::TokenReserve<T0>, arg4: 0x6949079b5873a2bbb94439acf9c85836a5a96189c687199e6cec0308348867f8::keys::Holder, arg5: 0x6949079b5873a2bbb94439acf9c85836a5a96189c687199e6cec0308348867f8::structs::UserBorrowConfig, arg6: &0x2::clock::Clock, arg7: &0x2::tx_context::TxContext) {
        0x6949079b5873a2bbb94439acf9c85836a5a96189c687199e6cec0308348867f8::auth::assert_auth(arg1, arg0, arg2, arg7);
        let v0 = 0x8dd99ecce2f05548858a39694aa5bbdd1c61adc260f9b90dc3889a9c7930ad01::units::from_clock(arg6);
        0x6949079b5873a2bbb94439acf9c85836a5a96189c687199e6cec0308348867f8::user_cap::assert_active_at<T0>(arg1, arg4);
        assert!(0x6949079b5873a2bbb94439acf9c85836a5a96189c687199e6cec0308348867f8::reserve::get_token_config_set<T0>(arg3), 0x6949079b5873a2bbb94439acf9c85836a5a96189c687199e6cec0308348867f8::errors::admin_module_invalid_config_order());
        assert!(0x6949079b5873a2bbb94439acf9c85836a5a96189c687199e6cec0308348867f8::structs::get_borrow_config_mode(&arg5) <= 1, 0x6949079b5873a2bbb94439acf9c85836a5a96189c687199e6cec0308348867f8::errors::admin_module_invalid_params());
        assert!(0x6949079b5873a2bbb94439acf9c85836a5a96189c687199e6cec0308348867f8::structs::get_borrow_config_base_debt_ceiling(&arg5) <= 0x6949079b5873a2bbb94439acf9c85836a5a96189c687199e6cec0308348867f8::structs::get_borrow_config_max_debt_ceiling(&arg5), 0x6949079b5873a2bbb94439acf9c85836a5a96189c687199e6cec0308348867f8::errors::admin_module_invalid_params());
        assert!(0x6949079b5873a2bbb94439acf9c85836a5a96189c687199e6cec0308348867f8::structs::get_borrow_config_max_debt_ceiling(&arg5) <= 0x6949079b5873a2bbb94439acf9c85836a5a96189c687199e6cec0308348867f8::constants::max_token_amount_cap(), 0x6949079b5873a2bbb94439acf9c85836a5a96189c687199e6cec0308348867f8::errors::admin_max_debt_ceiling_above_cap());
        assert!(0x6949079b5873a2bbb94439acf9c85836a5a96189c687199e6cec0308348867f8::structs::get_borrow_config_expand_percent(&arg5) <= 0x6949079b5873a2bbb94439acf9c85836a5a96189c687199e6cec0308348867f8::constants::x14(), 0x6949079b5873a2bbb94439acf9c85836a5a96189c687199e6cec0308348867f8::errors::admin_module_value_overflow_expand_percent_borrow());
        assert!(0x8dd99ecce2f05548858a39694aa5bbdd1c61adc260f9b90dc3889a9c7930ad01::units::raw(0x6949079b5873a2bbb94439acf9c85836a5a96189c687199e6cec0308348867f8::structs::get_borrow_config_expand_duration(&arg5)) <= 0x6949079b5873a2bbb94439acf9c85836a5a96189c687199e6cec0308348867f8::constants::x24(), 0x6949079b5873a2bbb94439acf9c85836a5a96189c687199e6cec0308348867f8::errors::admin_module_value_overflow_expand_duration_borrow());
        assert!(0x8dd99ecce2f05548858a39694aa5bbdd1c61adc260f9b90dc3889a9c7930ad01::units::raw(0x6949079b5873a2bbb94439acf9c85836a5a96189c687199e6cec0308348867f8::structs::get_borrow_config_expand_duration(&arg5)) >= 0x6949079b5873a2bbb94439acf9c85836a5a96189c687199e6cec0308348867f8::constants::min_expand_duration(), 0x6949079b5873a2bbb94439acf9c85836a5a96189c687199e6cec0308348867f8::errors::admin_module_invalid_params());
        assert!(0x6949079b5873a2bbb94439acf9c85836a5a96189c687199e6cec0308348867f8::structs::get_borrow_config_base_debt_ceiling(&arg5) != 0 && 0x6949079b5873a2bbb94439acf9c85836a5a96189c687199e6cec0308348867f8::structs::get_borrow_config_max_debt_ceiling(&arg5) != 0, 0x6949079b5873a2bbb94439acf9c85836a5a96189c687199e6cec0308348867f8::errors::admin_module_limit_zero());
        let v1 = 0x6949079b5873a2bbb94439acf9c85836a5a96189c687199e6cec0308348867f8::structs::get_borrow_config_with_interest(&arg5);
        0x6949079b5873a2bbb94439acf9c85836a5a96189c687199e6cec0308348867f8::reserve::ensure_borrow_position<T0>(arg3, arg4, v0);
        let v2 = 0x6949079b5873a2bbb94439acf9c85836a5a96189c687199e6cec0308348867f8::reserve::get_borrow_position<T0>(arg3, arg4);
        let v3 = 0x6949079b5873a2bbb94439acf9c85836a5a96189c687199e6cec0308348867f8::borrow_position::get_borrow_with_interest(v2);
        if (0x6949079b5873a2bbb94439acf9c85836a5a96189c687199e6cec0308348867f8::borrow_position::get_borrow_configs_not_set(v2)) {
            0x6949079b5873a2bbb94439acf9c85836a5a96189c687199e6cec0308348867f8::borrow_position::set_borrow_config(0x6949079b5873a2bbb94439acf9c85836a5a96189c687199e6cec0308348867f8::reserve::get_borrow_position_mut<T0>(arg3, arg4), arg5);
        } else if (v3 == v1) {
            0x6949079b5873a2bbb94439acf9c85836a5a96189c687199e6cec0308348867f8::borrow_position::set_borrow_config(0x6949079b5873a2bbb94439acf9c85836a5a96189c687199e6cec0308348867f8::reserve::get_borrow_position_mut<T0>(arg3, arg4), arg5);
        } else {
            let (_, v5) = 0x6949079b5873a2bbb94439acf9c85836a5a96189c687199e6cec0308348867f8::reserve::update_exchange_price<T0>(arg3, v0);
            let v6 = 0x6949079b5873a2bbb94439acf9c85836a5a96189c687199e6cec0308348867f8::reserve::get_borrow_position<T0>(arg3, arg4);
            let v7 = (0x6949079b5873a2bbb94439acf9c85836a5a96189c687199e6cec0308348867f8::borrow_position::get_borrow_amount(v6) as u128);
            let (v8, v9) = if (!v3 && v1) {
                0x6949079b5873a2bbb94439acf9c85836a5a96189c687199e6cec0308348867f8::reserve::set_new_total_borrow_interest_free<T0>(arg3, false, v7);
                let v10 = 0x8dd99ecce2f05548858a39694aa5bbdd1c61adc260f9b90dc3889a9c7930ad01::math::mul_div_ceil_u128(v7, 0x6949079b5873a2bbb94439acf9c85836a5a96189c687199e6cec0308348867f8::constants::exchange_prices_precision(), v5);
                0x6949079b5873a2bbb94439acf9c85836a5a96189c687199e6cec0308348867f8::reserve::set_new_total_borrow_with_interest<T0>(arg3, true, v10);
                (v10, 0x8dd99ecce2f05548858a39694aa5bbdd1c61adc260f9b90dc3889a9c7930ad01::math::mul_div_u128((0x6949079b5873a2bbb94439acf9c85836a5a96189c687199e6cec0308348867f8::borrow_position::get_borrow_debt_ceiling(v6) as u128), 0x6949079b5873a2bbb94439acf9c85836a5a96189c687199e6cec0308348867f8::constants::exchange_prices_precision(), v5))
            } else {
                0x6949079b5873a2bbb94439acf9c85836a5a96189c687199e6cec0308348867f8::reserve::set_new_total_borrow_with_interest<T0>(arg3, false, v7);
                let v11 = 0x8dd99ecce2f05548858a39694aa5bbdd1c61adc260f9b90dc3889a9c7930ad01::math::mul_div_ceil_u128(v7, v5, 0x6949079b5873a2bbb94439acf9c85836a5a96189c687199e6cec0308348867f8::constants::exchange_prices_precision());
                0x6949079b5873a2bbb94439acf9c85836a5a96189c687199e6cec0308348867f8::reserve::set_new_total_borrow_interest_free<T0>(arg3, true, v11);
                (v11, 0x8dd99ecce2f05548858a39694aa5bbdd1c61adc260f9b90dc3889a9c7930ad01::math::mul_div_u128((0x6949079b5873a2bbb94439acf9c85836a5a96189c687199e6cec0308348867f8::borrow_position::get_borrow_debt_ceiling(v6) as u128), v5, 0x6949079b5873a2bbb94439acf9c85836a5a96189c687199e6cec0308348867f8::constants::exchange_prices_precision()))
            };
            let v12 = 0x6949079b5873a2bbb94439acf9c85836a5a96189c687199e6cec0308348867f8::reserve::get_borrow_position_mut<T0>(arg3, arg4);
            0x6949079b5873a2bbb94439acf9c85836a5a96189c687199e6cec0308348867f8::borrow_position::set_borrow_config(v12, arg5);
            0x6949079b5873a2bbb94439acf9c85836a5a96189c687199e6cec0308348867f8::borrow_position::set_borrow_amount(v12, v8);
            0x6949079b5873a2bbb94439acf9c85836a5a96189c687199e6cec0308348867f8::borrow_position::set_borrow_debt_ceiling(v12, v9);
            let (_, _) = 0x6949079b5873a2bbb94439acf9c85836a5a96189c687199e6cec0308348867f8::reserve::update_exchange_prices_and_rates<T0>(arg3, v0);
        };
        0x6949079b5873a2bbb94439acf9c85836a5a96189c687199e6cec0308348867f8::events::emit_log_update_user_borrow_configs(arg4, 0x1::type_name::with_defining_ids<T0>(), arg5);
    }

    public fun update_user_supply_config<T0>(arg0: &0x6949079b5873a2bbb94439acf9c85836a5a96189c687199e6cec0308348867f8::auth::Auth, arg1: &0x6949079b5873a2bbb94439acf9c85836a5a96189c687199e6cec0308348867f8::registry::Registry, arg2: 0x1::option::Option<0x6949079b5873a2bbb94439acf9c85836a5a96189c687199e6cec0308348867f8::timelock_cap::TimelockTicket>, arg3: &mut 0x6949079b5873a2bbb94439acf9c85836a5a96189c687199e6cec0308348867f8::reserve::TokenReserve<T0>, arg4: 0x6949079b5873a2bbb94439acf9c85836a5a96189c687199e6cec0308348867f8::keys::Holder, arg5: 0x6949079b5873a2bbb94439acf9c85836a5a96189c687199e6cec0308348867f8::structs::UserSupplyConfig, arg6: &0x2::clock::Clock, arg7: &0x2::tx_context::TxContext) {
        0x6949079b5873a2bbb94439acf9c85836a5a96189c687199e6cec0308348867f8::auth::assert_auth(arg1, arg0, arg2, arg7);
        let v0 = 0x8dd99ecce2f05548858a39694aa5bbdd1c61adc260f9b90dc3889a9c7930ad01::units::from_clock(arg6);
        0x6949079b5873a2bbb94439acf9c85836a5a96189c687199e6cec0308348867f8::user_cap::assert_active_at<T0>(arg1, arg4);
        assert!(0x6949079b5873a2bbb94439acf9c85836a5a96189c687199e6cec0308348867f8::reserve::get_token_config_set<T0>(arg3), 0x6949079b5873a2bbb94439acf9c85836a5a96189c687199e6cec0308348867f8::errors::admin_module_invalid_config_order());
        assert!(0x6949079b5873a2bbb94439acf9c85836a5a96189c687199e6cec0308348867f8::structs::get_supply_config_mode(&arg5) <= 1, 0x6949079b5873a2bbb94439acf9c85836a5a96189c687199e6cec0308348867f8::errors::admin_module_invalid_params());
        assert!(0x6949079b5873a2bbb94439acf9c85836a5a96189c687199e6cec0308348867f8::structs::get_supply_config_expand_percent(&arg5) <= 0x6949079b5873a2bbb94439acf9c85836a5a96189c687199e6cec0308348867f8::constants::four_decimals(), 0x6949079b5873a2bbb94439acf9c85836a5a96189c687199e6cec0308348867f8::errors::admin_module_value_overflow_expand_percent());
        assert!(0x8dd99ecce2f05548858a39694aa5bbdd1c61adc260f9b90dc3889a9c7930ad01::units::raw(0x6949079b5873a2bbb94439acf9c85836a5a96189c687199e6cec0308348867f8::structs::get_supply_config_expand_duration(&arg5)) <= 0x6949079b5873a2bbb94439acf9c85836a5a96189c687199e6cec0308348867f8::constants::x24(), 0x6949079b5873a2bbb94439acf9c85836a5a96189c687199e6cec0308348867f8::errors::admin_module_value_overflow_expand_duration());
        assert!(0x8dd99ecce2f05548858a39694aa5bbdd1c61adc260f9b90dc3889a9c7930ad01::units::raw(0x6949079b5873a2bbb94439acf9c85836a5a96189c687199e6cec0308348867f8::structs::get_supply_config_expand_duration(&arg5)) >= 0x6949079b5873a2bbb94439acf9c85836a5a96189c687199e6cec0308348867f8::constants::min_expand_duration(), 0x6949079b5873a2bbb94439acf9c85836a5a96189c687199e6cec0308348867f8::errors::admin_module_invalid_params());
        assert!(0x6949079b5873a2bbb94439acf9c85836a5a96189c687199e6cec0308348867f8::structs::get_supply_config_base_withdrawal_limit(&arg5) != 0, 0x6949079b5873a2bbb94439acf9c85836a5a96189c687199e6cec0308348867f8::errors::admin_module_limit_zero());
        let v1 = 0x6949079b5873a2bbb94439acf9c85836a5a96189c687199e6cec0308348867f8::structs::get_supply_config_with_interest(&arg5);
        0x6949079b5873a2bbb94439acf9c85836a5a96189c687199e6cec0308348867f8::reserve::ensure_supply_position<T0>(arg3, arg4, v0);
        let v2 = 0x6949079b5873a2bbb94439acf9c85836a5a96189c687199e6cec0308348867f8::reserve::get_supply_position<T0>(arg3, arg4);
        let v3 = 0x6949079b5873a2bbb94439acf9c85836a5a96189c687199e6cec0308348867f8::supply_position::get_supply_with_interest(v2);
        if (0x6949079b5873a2bbb94439acf9c85836a5a96189c687199e6cec0308348867f8::supply_position::get_supply_configs_not_set(v2)) {
            let v4 = 0x6949079b5873a2bbb94439acf9c85836a5a96189c687199e6cec0308348867f8::reserve::get_supply_position_mut<T0>(arg3, arg4);
            0x6949079b5873a2bbb94439acf9c85836a5a96189c687199e6cec0308348867f8::supply_position::set_supply_config(v4, arg5);
            0x6949079b5873a2bbb94439acf9c85836a5a96189c687199e6cec0308348867f8::supply_position::reset_supply_decay(v4);
        } else if (v3 == v1) {
            let v5 = 0x6949079b5873a2bbb94439acf9c85836a5a96189c687199e6cec0308348867f8::reserve::get_supply_position_mut<T0>(arg3, arg4);
            0x6949079b5873a2bbb94439acf9c85836a5a96189c687199e6cec0308348867f8::supply_position::set_supply_config(v5, arg5);
            0x6949079b5873a2bbb94439acf9c85836a5a96189c687199e6cec0308348867f8::supply_position::reset_supply_decay(v5);
        } else {
            let (v6, _) = 0x6949079b5873a2bbb94439acf9c85836a5a96189c687199e6cec0308348867f8::reserve::update_exchange_price<T0>(arg3, v0);
            let v8 = 0x6949079b5873a2bbb94439acf9c85836a5a96189c687199e6cec0308348867f8::reserve::get_supply_position<T0>(arg3, arg4);
            let v9 = (0x6949079b5873a2bbb94439acf9c85836a5a96189c687199e6cec0308348867f8::supply_position::get_supply_amount(v8) as u128);
            let (v10, v11) = if (!v3 && v1) {
                0x6949079b5873a2bbb94439acf9c85836a5a96189c687199e6cec0308348867f8::reserve::set_new_total_supply_interest_free<T0>(arg3, false, v9);
                let v12 = 0x8dd99ecce2f05548858a39694aa5bbdd1c61adc260f9b90dc3889a9c7930ad01::math::mul_div_u128(v9, 0x6949079b5873a2bbb94439acf9c85836a5a96189c687199e6cec0308348867f8::constants::exchange_prices_precision(), v6);
                0x6949079b5873a2bbb94439acf9c85836a5a96189c687199e6cec0308348867f8::reserve::set_new_total_supply_with_interest<T0>(arg3, true, v12);
                (v12, 0x8dd99ecce2f05548858a39694aa5bbdd1c61adc260f9b90dc3889a9c7930ad01::math::mul_div_u128((0x6949079b5873a2bbb94439acf9c85836a5a96189c687199e6cec0308348867f8::supply_position::get_supply_withdrawal_limit(v8) as u128), 0x6949079b5873a2bbb94439acf9c85836a5a96189c687199e6cec0308348867f8::constants::exchange_prices_precision(), v6))
            } else {
                0x6949079b5873a2bbb94439acf9c85836a5a96189c687199e6cec0308348867f8::reserve::set_new_total_supply_with_interest<T0>(arg3, false, v9);
                let v13 = 0x8dd99ecce2f05548858a39694aa5bbdd1c61adc260f9b90dc3889a9c7930ad01::math::mul_div_u128(v9, v6, 0x6949079b5873a2bbb94439acf9c85836a5a96189c687199e6cec0308348867f8::constants::exchange_prices_precision());
                0x6949079b5873a2bbb94439acf9c85836a5a96189c687199e6cec0308348867f8::reserve::set_new_total_supply_interest_free<T0>(arg3, true, v13);
                (v13, 0x8dd99ecce2f05548858a39694aa5bbdd1c61adc260f9b90dc3889a9c7930ad01::math::mul_div_u128((0x6949079b5873a2bbb94439acf9c85836a5a96189c687199e6cec0308348867f8::supply_position::get_supply_withdrawal_limit(v8) as u128), v6, 0x6949079b5873a2bbb94439acf9c85836a5a96189c687199e6cec0308348867f8::constants::exchange_prices_precision()))
            };
            let v14 = 0x6949079b5873a2bbb94439acf9c85836a5a96189c687199e6cec0308348867f8::reserve::get_supply_position_mut<T0>(arg3, arg4);
            0x6949079b5873a2bbb94439acf9c85836a5a96189c687199e6cec0308348867f8::supply_position::set_supply_config(v14, arg5);
            0x6949079b5873a2bbb94439acf9c85836a5a96189c687199e6cec0308348867f8::supply_position::set_supply_amount(v14, v10);
            0x6949079b5873a2bbb94439acf9c85836a5a96189c687199e6cec0308348867f8::supply_position::set_supply_withdrawal_limit(v14, v11);
            0x6949079b5873a2bbb94439acf9c85836a5a96189c687199e6cec0308348867f8::supply_position::reset_supply_decay(v14);
            let (_, _) = 0x6949079b5873a2bbb94439acf9c85836a5a96189c687199e6cec0308348867f8::reserve::update_exchange_prices_and_rates<T0>(arg3, v0);
        };
        0x6949079b5873a2bbb94439acf9c85836a5a96189c687199e6cec0308348867f8::events::emit_log_update_user_supply_configs(arg4, 0x1::type_name::with_defining_ids<T0>(), arg5);
    }

    public fun update_user_withdrawal_limit<T0>(arg0: &0x6949079b5873a2bbb94439acf9c85836a5a96189c687199e6cec0308348867f8::auth::Auth, arg1: &0x6949079b5873a2bbb94439acf9c85836a5a96189c687199e6cec0308348867f8::registry::Registry, arg2: 0x1::option::Option<0x6949079b5873a2bbb94439acf9c85836a5a96189c687199e6cec0308348867f8::timelock_cap::TimelockTicket>, arg3: &mut 0x6949079b5873a2bbb94439acf9c85836a5a96189c687199e6cec0308348867f8::reserve::TokenReserve<T0>, arg4: 0x6949079b5873a2bbb94439acf9c85836a5a96189c687199e6cec0308348867f8::keys::Holder, arg5: u64, arg6: &0x2::clock::Clock, arg7: &0x2::tx_context::TxContext) {
        0x6949079b5873a2bbb94439acf9c85836a5a96189c687199e6cec0308348867f8::auth::assert_auth(arg1, arg0, arg2, arg7);
        0x6949079b5873a2bbb94439acf9c85836a5a96189c687199e6cec0308348867f8::user_cap::assert_active_at<T0>(arg1, arg4);
        let v0 = 0x6949079b5873a2bbb94439acf9c85836a5a96189c687199e6cec0308348867f8::reserve::get_supply_position_mut<T0>(arg3, arg4);
        assert!(!0x6949079b5873a2bbb94439acf9c85836a5a96189c687199e6cec0308348867f8::supply_position::get_supply_configs_not_set(v0), 0x6949079b5873a2bbb94439acf9c85836a5a96189c687199e6cec0308348867f8::errors::admin_module_user_not_defined());
        let v1 = (0x6949079b5873a2bbb94439acf9c85836a5a96189c687199e6cec0308348867f8::supply_position::get_supply_amount(v0) as u128);
        let v2 = v1 - (0x6949079b5873a2bbb94439acf9c85836a5a96189c687199e6cec0308348867f8::liquidity_calcs::expansion_amount((v1 as u256), 0x6949079b5873a2bbb94439acf9c85836a5a96189c687199e6cec0308348867f8::supply_position::get_supply_expand_percent(v0)) as u128);
        let v3 = (arg5 as u128);
        let v4 = v3;
        if (v3 == 0 || v3 < v2) {
            v4 = v2;
        } else if (arg5 == (0x6949079b5873a2bbb94439acf9c85836a5a96189c687199e6cec0308348867f8::constants::max_u64() as u64) || v3 > v1) {
            v4 = v1;
        };
        if (v1 < (0x6949079b5873a2bbb94439acf9c85836a5a96189c687199e6cec0308348867f8::supply_position::get_supply_base_withdrawal_limit(v0) as u128)) {
            v4 = 0;
        };
        0x6949079b5873a2bbb94439acf9c85836a5a96189c687199e6cec0308348867f8::supply_position::set_supply_withdrawal_limit(v0, v4);
        0x6949079b5873a2bbb94439acf9c85836a5a96189c687199e6cec0308348867f8::supply_position::set_supply_last_update(v0, 0x8dd99ecce2f05548858a39694aa5bbdd1c61adc260f9b90dc3889a9c7930ad01::units::from_clock(arg6));
        0x6949079b5873a2bbb94439acf9c85836a5a96189c687199e6cec0308348867f8::supply_position::reset_supply_decay(v0);
        0x6949079b5873a2bbb94439acf9c85836a5a96189c687199e6cec0308348867f8::events::emit_log_update_user_withdrawal_limit(arg4, 0x1::type_name::with_defining_ids<T0>(), (v4 as u64));
    }

    // decompiled from Move bytecode v7
}

