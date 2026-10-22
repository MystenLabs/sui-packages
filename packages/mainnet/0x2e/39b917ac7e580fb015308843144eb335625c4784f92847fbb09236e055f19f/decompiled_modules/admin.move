module 0x2e39b917ac7e580fb015308843144eb335625c4784f92847fbb09236e055f19f::admin {
    struct RebalanceGap has copy, drop {
        col_recorded: u128,
        col_at_liquidity: u128,
        debt_recorded: u128,
        debt_at_liquidity: u128,
    }

    public fun add_admin(arg0: &0x2e39b917ac7e580fb015308843144eb335625c4784f92847fbb09236e055f19f::registry::VaultRegistry, arg1: &mut 0x2e39b917ac7e580fb015308843144eb335625c4784f92847fbb09236e055f19f::auth::VaultAdmin, arg2: 0x1::option::Option<0x2e39b917ac7e580fb015308843144eb335625c4784f92847fbb09236e055f19f::timelock_cap::TimelockTicket>, arg3: address, arg4: &0x2::tx_context::TxContext) {
        0x2e39b917ac7e580fb015308843144eb335625c4784f92847fbb09236e055f19f::auth::assert_authority(arg0, arg1, arg2, arg4);
        0x2e39b917ac7e580fb015308843144eb335625c4784f92847fbb09236e055f19f::auth::add_admin(arg1, arg3);
    }

    public fun col_at_liquidity(arg0: &RebalanceGap) : u128 {
        arg0.col_at_liquidity
    }

    public fun col_gap(arg0: &RebalanceGap) : 0x6949079b5873a2bbb94439acf9c85836a5a96189c687199e6cec0308348867f8::structs::Amount {
        compute_rebalance_amount(arg0.col_recorded, arg0.col_at_liquidity)
    }

    public fun col_recorded(arg0: &RebalanceGap) : u128 {
        arg0.col_recorded
    }

    fun compute_rebalance_amount(arg0: u128, arg1: u128) : 0x6949079b5873a2bbb94439acf9c85836a5a96189c687199e6cec0308348867f8::structs::Amount {
        if (arg0 > arg1) {
            0x6949079b5873a2bbb94439acf9c85836a5a96189c687199e6cec0308348867f8::structs::positive(((arg0 - arg1) as u64))
        } else if (arg1 > arg0) {
            0x6949079b5873a2bbb94439acf9c85836a5a96189c687199e6cec0308348867f8::structs::negative(((arg1 - arg0) as u64))
        } else {
            0x6949079b5873a2bbb94439acf9c85836a5a96189c687199e6cec0308348867f8::structs::none()
        }
    }

    public fun debt_at_liquidity(arg0: &RebalanceGap) : u128 {
        arg0.debt_at_liquidity
    }

    public fun debt_gap(arg0: &RebalanceGap) : 0x6949079b5873a2bbb94439acf9c85836a5a96189c687199e6cec0308348867f8::structs::Amount {
        compute_rebalance_amount(arg0.debt_recorded, arg0.debt_at_liquidity)
    }

    public fun debt_recorded(arg0: &RebalanceGap) : u128 {
        arg0.debt_recorded
    }

    public fun disable_timelock(arg0: &0x2e39b917ac7e580fb015308843144eb335625c4784f92847fbb09236e055f19f::registry::VaultRegistry, arg1: &mut 0x2e39b917ac7e580fb015308843144eb335625c4784f92847fbb09236e055f19f::auth::VaultAdmin, arg2: 0x2e39b917ac7e580fb015308843144eb335625c4784f92847fbb09236e055f19f::timelock_cap::TimelockCap, arg3: &0x2::tx_context::TxContext) {
        0x2e39b917ac7e580fb015308843144eb335625c4784f92847fbb09236e055f19f::registry::assert_version(arg0);
        0x2e39b917ac7e580fb015308843144eb335625c4784f92847fbb09236e055f19f::auth::assert_only_authority_direct(arg1, arg3);
        0x2e39b917ac7e580fb015308843144eb335625c4784f92847fbb09236e055f19f::auth::disable_timelock(arg1, arg2);
        0x2e39b917ac7e580fb015308843144eb335625c4784f92847fbb09236e055f19f::events::emit_log_timelock_disabled(0x2::object::id<0x2e39b917ac7e580fb015308843144eb335625c4784f92847fbb09236e055f19f::timelock_cap::TimelockCap>(&arg2));
    }

    fun get_adjusted_rebalance_amount(arg0: 0x6949079b5873a2bbb94439acf9c85836a5a96189c687199e6cec0308348867f8::structs::Amount, arg1: 0x1::option::Option<u128>) : 0x6949079b5873a2bbb94439acf9c85836a5a96189c687199e6cec0308348867f8::structs::Amount {
        if (0x1::option::is_none<u128>(&arg1)) {
            return arg0
        };
        let v0 = *0x1::option::borrow<u128>(&arg1);
        let v1 = (0x6949079b5873a2bbb94439acf9c85836a5a96189c687199e6cec0308348867f8::structs::value(&arg0) as u128);
        let v2 = if (v1 < v0) {
            v1
        } else {
            v0
        };
        if (0x6949079b5873a2bbb94439acf9c85836a5a96189c687199e6cec0308348867f8::structs::get_is_positive(&arg0)) {
            0x6949079b5873a2bbb94439acf9c85836a5a96189c687199e6cec0308348867f8::structs::positive((v2 as u64))
        } else if (0x6949079b5873a2bbb94439acf9c85836a5a96189c687199e6cec0308348867f8::structs::get_is_negative(&arg0)) {
            0x6949079b5873a2bbb94439acf9c85836a5a96189c687199e6cec0308348867f8::structs::negative((v2 as u64))
        } else {
            0x6949079b5873a2bbb94439acf9c85836a5a96189c687199e6cec0308348867f8::structs::none()
        }
    }

    public fun init_vault_config<T0, T1>(arg0: &mut 0x2e39b917ac7e580fb015308843144eb335625c4784f92847fbb09236e055f19f::registry::VaultRegistry, arg1: &0x2e39b917ac7e580fb015308843144eb335625c4784f92847fbb09236e055f19f::auth::VaultAdmin, arg2: 0x1::option::Option<0x2e39b917ac7e580fb015308843144eb335625c4784f92847fbb09236e055f19f::timelock_cap::TimelockTicket>, arg3: &0x6949079b5873a2bbb94439acf9c85836a5a96189c687199e6cec0308348867f8::registry::Registry, arg4: 0x2e39b917ac7e580fb015308843144eb335625c4784f92847fbb09236e055f19f::risk_config::RiskConfig, arg5: 0x2e39b917ac7e580fb015308843144eb335625c4784f92847fbb09236e055f19f::structs::RateMagnifier, arg6: 0x2e39b917ac7e580fb015308843144eb335625c4784f92847fbb09236e055f19f::structs::RateMagnifier, arg7: &0xb43861086c8f85a23627c2aa6346dba8620dd2ea3147b3cdae4083912783a2ab::oracle::Oracle, arg8: u8, arg9: u8, arg10: &0x2::clock::Clock, arg11: &mut 0x2::tx_context::TxContext) {
        0x2e39b917ac7e580fb015308843144eb335625c4784f92847fbb09236e055f19f::auth::assert_auths(arg0, arg1, arg2, arg11);
        let v0 = 0x2e39b917ac7e580fb015308843144eb335625c4784f92847fbb09236e055f19f::vault_market::create<T0, T1>(arg0, arg4, arg5, arg6, 0x2::object::id<0xb43861086c8f85a23627c2aa6346dba8620dd2ea3147b3cdae4083912783a2ab::oracle::Oracle>(arg7), 0x2::object::id<0x6949079b5873a2bbb94439acf9c85836a5a96189c687199e6cec0308348867f8::registry::Registry>(arg3), arg8, arg9, arg10, arg11);
        0x2e39b917ac7e580fb015308843144eb335625c4784f92847fbb09236e055f19f::events::emit_log_init_vault_config(0x2e39b917ac7e580fb015308843144eb335625c4784f92847fbb09236e055f19f::vault_market::vault_object_id<T0, T1>(&v0), 0x2e39b917ac7e580fb015308843144eb335625c4784f92847fbb09236e055f19f::vault_market::vault_id<T0, T1>(&v0));
        0x2e39b917ac7e580fb015308843144eb335625c4784f92847fbb09236e055f19f::vault_market::share<T0, T1>(v0);
    }

    public fun init_vault_state<T0, T1>(arg0: &mut 0x2e39b917ac7e580fb015308843144eb335625c4784f92847fbb09236e055f19f::vault_market::VaultMarket<T0, T1>, arg1: &0x2e39b917ac7e580fb015308843144eb335625c4784f92847fbb09236e055f19f::registry::VaultRegistry, arg2: &0x2e39b917ac7e580fb015308843144eb335625c4784f92847fbb09236e055f19f::auth::VaultAdmin, arg3: 0x1::option::Option<0x2e39b917ac7e580fb015308843144eb335625c4784f92847fbb09236e055f19f::timelock_cap::TimelockTicket>, arg4: &0x6949079b5873a2bbb94439acf9c85836a5a96189c687199e6cec0308348867f8::reserve::TokenReserve<T0>, arg5: &0x6949079b5873a2bbb94439acf9c85836a5a96189c687199e6cec0308348867f8::reserve::TokenReserve<T1>, arg6: &0x2::clock::Clock, arg7: &0x2::tx_context::TxContext) {
        0x2e39b917ac7e580fb015308843144eb335625c4784f92847fbb09236e055f19f::auth::assert_auths(arg1, arg2, arg3, arg7);
        let (v0, _) = 0x2e39b917ac7e580fb015308843144eb335625c4784f92847fbb09236e055f19f::liquidity::get_exchange_prices<T0>(arg4, arg6);
        let (_, v3) = 0x2e39b917ac7e580fb015308843144eb335625c4784f92847fbb09236e055f19f::liquidity::get_exchange_prices<T1>(arg5, arg6);
        0x2e39b917ac7e580fb015308843144eb335625c4784f92847fbb09236e055f19f::vault_market::init_vault_state<T0, T1>(arg0, v0, v3, 0x8dd99ecce2f05548858a39694aa5bbdd1c61adc260f9b90dc3889a9c7930ad01::units::from_clock(arg6));
        0x2e39b917ac7e580fb015308843144eb335625c4784f92847fbb09236e055f19f::events::emit_log_init_vault_state(0x2e39b917ac7e580fb015308843144eb335625c4784f92847fbb09236e055f19f::vault_market::vault_object_id<T0, T1>(arg0));
    }

    public fun migrate_vault_registry(arg0: &0x2e39b917ac7e580fb015308843144eb335625c4784f92847fbb09236e055f19f::auth::VaultAdmin, arg1: &mut 0x2e39b917ac7e580fb015308843144eb335625c4784f92847fbb09236e055f19f::registry::VaultRegistry, arg2: &0x2::tx_context::TxContext) {
        0x2e39b917ac7e580fb015308843144eb335625c4784f92847fbb09236e055f19f::auth::assert_only_migrators(arg0, arg2);
        0x2e39b917ac7e580fb015308843144eb335625c4784f92847fbb09236e055f19f::registry::migrate(arg1);
    }

    public fun mint_and_install_caps<T0, T1>(arg0: &0x6949079b5873a2bbb94439acf9c85836a5a96189c687199e6cec0308348867f8::auth::Auth, arg1: &mut 0x6949079b5873a2bbb94439acf9c85836a5a96189c687199e6cec0308348867f8::registry::Registry, arg2: 0x1::option::Option<0x6949079b5873a2bbb94439acf9c85836a5a96189c687199e6cec0308348867f8::timelock_cap::TimelockTicket>, arg3: 0x1::option::Option<0x6949079b5873a2bbb94439acf9c85836a5a96189c687199e6cec0308348867f8::timelock_cap::TimelockTicket>, arg4: &mut 0x2e39b917ac7e580fb015308843144eb335625c4784f92847fbb09236e055f19f::vault_market::VaultMarket<T0, T1>, arg5: &0x2e39b917ac7e580fb015308843144eb335625c4784f92847fbb09236e055f19f::registry::VaultRegistry, arg6: &0x2e39b917ac7e580fb015308843144eb335625c4784f92847fbb09236e055f19f::auth::VaultAdmin, arg7: 0x1::option::Option<0x2e39b917ac7e580fb015308843144eb335625c4784f92847fbb09236e055f19f::timelock_cap::TimelockTicket>, arg8: bool, arg9: bool, arg10: &0x2::tx_context::TxContext) {
        0x2e39b917ac7e580fb015308843144eb335625c4784f92847fbb09236e055f19f::auth::assert_auths(arg5, arg6, arg7, arg10);
        let v0 = 0x6949079b5873a2bbb94439acf9c85836a5a96189c687199e6cec0308348867f8::keys::holder_object(0x2::object::id<0x2e39b917ac7e580fb015308843144eb335625c4784f92847fbb09236e055f19f::vault_market::VaultMarket<T0, T1>>(arg4));
        let v1 = if (arg8) {
            0x1::option::some<0x6949079b5873a2bbb94439acf9c85836a5a96189c687199e6cec0308348867f8::user_cap::UserCap<T0>>(0x6949079b5873a2bbb94439acf9c85836a5a96189c687199e6cec0308348867f8::admin::mint_user_cap<T0>(arg0, arg1, arg2, v0, arg10))
        } else {
            0x1::option::none<0x6949079b5873a2bbb94439acf9c85836a5a96189c687199e6cec0308348867f8::user_cap::UserCap<T0>>()
        };
        let v2 = if (arg9) {
            0x1::option::some<0x6949079b5873a2bbb94439acf9c85836a5a96189c687199e6cec0308348867f8::user_cap::UserCap<T1>>(0x6949079b5873a2bbb94439acf9c85836a5a96189c687199e6cec0308348867f8::admin::mint_user_cap<T1>(arg0, arg1, arg3, v0, arg10))
        } else {
            0x1::option::none<0x6949079b5873a2bbb94439acf9c85836a5a96189c687199e6cec0308348867f8::user_cap::UserCap<T1>>()
        };
        0x2e39b917ac7e580fb015308843144eb335625c4784f92847fbb09236e055f19f::vault_market::add_caps<T0, T1>(arg4, v1, v2);
    }

    public fun mint_timelock_cap(arg0: &0x2e39b917ac7e580fb015308843144eb335625c4784f92847fbb09236e055f19f::registry::VaultRegistry, arg1: &mut 0x2e39b917ac7e580fb015308843144eb335625c4784f92847fbb09236e055f19f::auth::VaultAdmin, arg2: &mut 0x2::tx_context::TxContext) : 0x2e39b917ac7e580fb015308843144eb335625c4784f92847fbb09236e055f19f::timelock_cap::TimelockCap {
        0x2e39b917ac7e580fb015308843144eb335625c4784f92847fbb09236e055f19f::registry::assert_version(arg0);
        0x2e39b917ac7e580fb015308843144eb335625c4784f92847fbb09236e055f19f::auth::assert_only_authority_direct(arg1, arg2);
        let v0 = 0x2e39b917ac7e580fb015308843144eb335625c4784f92847fbb09236e055f19f::auth::enable_timelock(arg1, arg2);
        0x2e39b917ac7e580fb015308843144eb335625c4784f92847fbb09236e055f19f::events::emit_log_timelock_enabled(0x2::object::id<0x2e39b917ac7e580fb015308843144eb335625c4784f92847fbb09236e055f19f::timelock_cap::TimelockCap>(&v0));
        v0
    }

    public fun preview<T0, T1>(arg0: &0x2e39b917ac7e580fb015308843144eb335625c4784f92847fbb09236e055f19f::vault_market::VaultMarket<T0, T1>, arg1: &0x6949079b5873a2bbb94439acf9c85836a5a96189c687199e6cec0308348867f8::reserve::TokenReserve<T0>, arg2: &0x6949079b5873a2bbb94439acf9c85836a5a96189c687199e6cec0308348867f8::reserve::TokenReserve<T1>, arg3: &0x2::clock::Clock) : RebalanceGap {
        let (v0, _) = 0x2e39b917ac7e580fb015308843144eb335625c4784f92847fbb09236e055f19f::liquidity::get_exchange_prices<T0>(arg1, arg3);
        let (_, v3) = 0x2e39b917ac7e580fb015308843144eb335625c4784f92847fbb09236e055f19f::liquidity::get_exchange_prices<T1>(arg2, arg3);
        let (v4, v5, v6, v7) = 0x2e39b917ac7e580fb015308843144eb335625c4784f92847fbb09236e055f19f::vault_market::load_exchange_prices<T0, T1>(arg0, v0, v3, 0x8dd99ecce2f05548858a39694aa5bbdd1c61adc260f9b90dc3889a9c7930ad01::units::from_clock(arg3));
        let v8 = 0x2e39b917ac7e580fb015308843144eb335625c4784f92847fbb09236e055f19f::constants::exchange_prices_precision();
        RebalanceGap{
            col_recorded      : 0x2e39b917ac7e580fb015308843144eb335625c4784f92847fbb09236e055f19f::constants::unscale_amounts(0x8dd99ecce2f05548858a39694aa5bbdd1c61adc260f9b90dc3889a9c7930ad01::math::mul_div_u128(0x2e39b917ac7e580fb015308843144eb335625c4784f92847fbb09236e055f19f::vault_market::get_total_supply<T0, T1>(arg0), v6, v8), 0x2e39b917ac7e580fb015308843144eb335625c4784f92847fbb09236e055f19f::vault_market::col_decimals<T0, T1>(arg0)),
            col_at_liquidity  : 0x8dd99ecce2f05548858a39694aa5bbdd1c61adc260f9b90dc3889a9c7930ad01::math::mul_div_u128(0x2e39b917ac7e580fb015308843144eb335625c4784f92847fbb09236e055f19f::liquidity::get_vault_supply_at_liquidity<T0, T1, T0>(arg0, arg1), v4, v8),
            debt_recorded     : 0x2e39b917ac7e580fb015308843144eb335625c4784f92847fbb09236e055f19f::constants::unscale_amounts(0x8dd99ecce2f05548858a39694aa5bbdd1c61adc260f9b90dc3889a9c7930ad01::math::mul_div_u128(0x2e39b917ac7e580fb015308843144eb335625c4784f92847fbb09236e055f19f::vault_market::get_total_borrow<T0, T1>(arg0), v7, v8), 0x2e39b917ac7e580fb015308843144eb335625c4784f92847fbb09236e055f19f::vault_market::debt_decimals<T0, T1>(arg0)),
            debt_at_liquidity : 0x8dd99ecce2f05548858a39694aa5bbdd1c61adc260f9b90dc3889a9c7930ad01::math::mul_div_u128(0x2e39b917ac7e580fb015308843144eb335625c4784f92847fbb09236e055f19f::liquidity::get_vault_borrow_at_liquidity<T0, T1, T1>(arg0, arg2), v5, v8),
        }
    }

    public fun rebalance<T0, T1>(arg0: &0x6949079b5873a2bbb94439acf9c85836a5a96189c687199e6cec0308348867f8::registry::Registry, arg1: &mut 0x2e39b917ac7e580fb015308843144eb335625c4784f92847fbb09236e055f19f::vault_market::VaultMarket<T0, T1>, arg2: &0x2e39b917ac7e580fb015308843144eb335625c4784f92847fbb09236e055f19f::registry::VaultRegistry, arg3: &0x2e39b917ac7e580fb015308843144eb335625c4784f92847fbb09236e055f19f::auth::VaultAdmin, arg4: &mut 0x6949079b5873a2bbb94439acf9c85836a5a96189c687199e6cec0308348867f8::reserve::TokenReserve<T0>, arg5: &mut 0x6949079b5873a2bbb94439acf9c85836a5a96189c687199e6cec0308348867f8::reserve::TokenReserve<T1>, arg6: 0x2::balance::Balance<T0>, arg7: 0x2::balance::Balance<T1>, arg8: &0x2::clock::Clock, arg9: &mut 0x2::tx_context::TxContext) : (0x2::balance::Balance<T0>, 0x2::balance::Balance<T1>) {
        rebalance_with_amounts<T0, T1>(arg0, arg1, arg2, arg3, arg4, arg5, arg6, arg7, 0x1::option::none<u128>(), 0x1::option::none<u128>(), arg8, arg9)
    }

    public fun rebalance_with_amounts<T0, T1>(arg0: &0x6949079b5873a2bbb94439acf9c85836a5a96189c687199e6cec0308348867f8::registry::Registry, arg1: &mut 0x2e39b917ac7e580fb015308843144eb335625c4784f92847fbb09236e055f19f::vault_market::VaultMarket<T0, T1>, arg2: &0x2e39b917ac7e580fb015308843144eb335625c4784f92847fbb09236e055f19f::registry::VaultRegistry, arg3: &0x2e39b917ac7e580fb015308843144eb335625c4784f92847fbb09236e055f19f::auth::VaultAdmin, arg4: &mut 0x6949079b5873a2bbb94439acf9c85836a5a96189c687199e6cec0308348867f8::reserve::TokenReserve<T0>, arg5: &mut 0x6949079b5873a2bbb94439acf9c85836a5a96189c687199e6cec0308348867f8::reserve::TokenReserve<T1>, arg6: 0x2::balance::Balance<T0>, arg7: 0x2::balance::Balance<T1>, arg8: 0x1::option::Option<u128>, arg9: 0x1::option::Option<u128>, arg10: &0x2::clock::Clock, arg11: &mut 0x2::tx_context::TxContext) : (0x2::balance::Balance<T0>, 0x2::balance::Balance<T1>) {
        0x2e39b917ac7e580fb015308843144eb335625c4784f92847fbb09236e055f19f::vault_market::assert_caps_installed<T0, T1>(arg1);
        0x2e39b917ac7e580fb015308843144eb335625c4784f92847fbb09236e055f19f::liquidity::assert_liquidity_program<T0, T1>(arg1, arg0);
        0x2e39b917ac7e580fb015308843144eb335625c4784f92847fbb09236e055f19f::auth::assert_rebalancer(arg2, arg3, arg11, 0x2::object::id<0x2e39b917ac7e580fb015308843144eb335625c4784f92847fbb09236e055f19f::vault_market::VaultMarket<T0, T1>>(arg1));
        let v0 = preview<T0, T1>(arg1, arg4, arg5, arg10);
        let v1 = get_adjusted_rebalance_amount(col_gap(&v0), arg8);
        let v2 = get_adjusted_rebalance_amount(debt_gap(&v0), arg9);
        let v3 = 0x6949079b5873a2bbb94439acf9c85836a5a96189c687199e6cec0308348867f8::structs::is_none(&v1) && 0x6949079b5873a2bbb94439acf9c85836a5a96189c687199e6cec0308348867f8::structs::is_none(&v2);
        assert!(!v3, 0x2e39b917ac7e580fb015308843144eb335625c4784f92847fbb09236e055f19f::errors::vault_nothing_to_rebalance());
        let v4 = 0;
        let v5 = 0;
        let v6 = 0;
        let v7 = 0;
        let v8 = 0x2::balance::zero<T0>();
        if (!0x6949079b5873a2bbb94439acf9c85836a5a96189c687199e6cec0308348867f8::structs::is_none(&v1)) {
            if (0x6949079b5873a2bbb94439acf9c85836a5a96189c687199e6cec0308348867f8::structs::get_is_positive(&v1)) {
                let v9 = 0x6949079b5873a2bbb94439acf9c85836a5a96189c687199e6cec0308348867f8::structs::value(&v1);
                v4 = v9;
                0x2::balance::destroy_zero<T0>(0x2e39b917ac7e580fb015308843144eb335625c4784f92847fbb09236e055f19f::liquidity::supply<T0, T1>(arg0, arg1, arg4, v1, 0x2::balance::split<T0>(&mut arg6, v9), arg10, arg11));
            } else {
                v5 = 0x6949079b5873a2bbb94439acf9c85836a5a96189c687199e6cec0308348867f8::structs::value(&v1);
                0x2::balance::join<T0>(&mut v8, 0x2e39b917ac7e580fb015308843144eb335625c4784f92847fbb09236e055f19f::liquidity::supply<T0, T1>(arg0, arg1, arg4, v1, 0x2::balance::zero<T0>(), arg10, arg11));
            };
        };
        let v10 = 0x2::balance::zero<T1>();
        if (!0x6949079b5873a2bbb94439acf9c85836a5a96189c687199e6cec0308348867f8::structs::is_none(&v2)) {
            if (0x6949079b5873a2bbb94439acf9c85836a5a96189c687199e6cec0308348867f8::structs::get_is_positive(&v2)) {
                v7 = 0x6949079b5873a2bbb94439acf9c85836a5a96189c687199e6cec0308348867f8::structs::value(&v2);
                0x2::balance::join<T1>(&mut v10, 0x2e39b917ac7e580fb015308843144eb335625c4784f92847fbb09236e055f19f::liquidity::borrow<T0, T1>(arg0, arg1, arg5, v2, 0x2::balance::zero<T1>(), arg10, arg11));
            } else {
                let v11 = 0x6949079b5873a2bbb94439acf9c85836a5a96189c687199e6cec0308348867f8::structs::value(&v2);
                v6 = v11;
                0x2::balance::destroy_zero<T1>(0x2e39b917ac7e580fb015308843144eb335625c4784f92847fbb09236e055f19f::liquidity::borrow<T0, T1>(arg0, arg1, arg5, v2, 0x2::balance::split<T1>(&mut arg7, v11), arg10, arg11));
            };
        };
        0x2e39b917ac7e580fb015308843144eb335625c4784f92847fbb09236e055f19f::events::emit_log_rebalance(0x2e39b917ac7e580fb015308843144eb335625c4784f92847fbb09236e055f19f::vault_market::vault_id<T0, T1>(arg1), v4, v5, v6, v7);
        0x2::balance::join<T0>(&mut v8, arg6);
        0x2::balance::join<T1>(&mut v10, arg7);
        (v8, v10)
    }

    public fun remove_admin(arg0: &0x2e39b917ac7e580fb015308843144eb335625c4784f92847fbb09236e055f19f::registry::VaultRegistry, arg1: &mut 0x2e39b917ac7e580fb015308843144eb335625c4784f92847fbb09236e055f19f::auth::VaultAdmin, arg2: 0x1::option::Option<0x2e39b917ac7e580fb015308843144eb335625c4784f92847fbb09236e055f19f::timelock_cap::TimelockTicket>, arg3: address, arg4: &0x2::tx_context::TxContext) {
        0x2e39b917ac7e580fb015308843144eb335625c4784f92847fbb09236e055f19f::auth::assert_authority(arg0, arg1, arg2, arg4);
        0x2e39b917ac7e580fb015308843144eb335625c4784f92847fbb09236e055f19f::auth::remove_admin(arg1, arg3);
    }

    public fun update_auths(arg0: &0x2e39b917ac7e580fb015308843144eb335625c4784f92847fbb09236e055f19f::registry::VaultRegistry, arg1: &mut 0x2e39b917ac7e580fb015308843144eb335625c4784f92847fbb09236e055f19f::auth::VaultAdmin, arg2: 0x1::option::Option<0x2e39b917ac7e580fb015308843144eb335625c4784f92847fbb09236e055f19f::timelock_cap::TimelockTicket>, arg3: address, arg4: bool, arg5: &0x2::tx_context::TxContext) {
        0x2e39b917ac7e580fb015308843144eb335625c4784f92847fbb09236e055f19f::auth::assert_authority(arg0, arg1, arg2, arg5);
        if (arg4) {
            if (!0x2e39b917ac7e580fb015308843144eb335625c4784f92847fbb09236e055f19f::auth::has_auth_record(arg1, arg3)) {
                0x2e39b917ac7e580fb015308843144eb335625c4784f92847fbb09236e055f19f::auth::grant_auth(arg1, arg3);
            };
        } else if (0x2e39b917ac7e580fb015308843144eb335625c4784f92847fbb09236e055f19f::auth::has_auth_record(arg1, arg3)) {
            0x2e39b917ac7e580fb015308843144eb335625c4784f92847fbb09236e055f19f::auth::revoke_auth(arg1, arg3);
        };
        0x2e39b917ac7e580fb015308843144eb335625c4784f92847fbb09236e055f19f::events::emit_log_update_auths(arg3, arg4);
    }

    public fun update_borrow_fee<T0, T1>(arg0: &mut 0x2e39b917ac7e580fb015308843144eb335625c4784f92847fbb09236e055f19f::vault_market::VaultMarket<T0, T1>, arg1: &0x2e39b917ac7e580fb015308843144eb335625c4784f92847fbb09236e055f19f::registry::VaultRegistry, arg2: &0x2e39b917ac7e580fb015308843144eb335625c4784f92847fbb09236e055f19f::auth::VaultAdmin, arg3: 0x1::option::Option<0x2e39b917ac7e580fb015308843144eb335625c4784f92847fbb09236e055f19f::timelock_cap::TimelockTicket>, arg4: &0x6949079b5873a2bbb94439acf9c85836a5a96189c687199e6cec0308348867f8::reserve::TokenReserve<T0>, arg5: &0x6949079b5873a2bbb94439acf9c85836a5a96189c687199e6cec0308348867f8::reserve::TokenReserve<T1>, arg6: u8, arg7: &0x2::clock::Clock, arg8: &0x2::tx_context::TxContext) {
        0x2e39b917ac7e580fb015308843144eb335625c4784f92847fbb09236e055f19f::auth::assert_auths(arg1, arg2, arg3, arg8);
        0x2e39b917ac7e580fb015308843144eb335625c4784f92847fbb09236e055f19f::user::update_exchange_prices<T0, T1>(arg0, arg1, arg4, arg5, arg7);
        assert!(arg6 <= 0x2e39b917ac7e580fb015308843144eb335625c4784f92847fbb09236e055f19f::constants::max_borrow_fee(), 0x2e39b917ac7e580fb015308843144eb335625c4784f92847fbb09236e055f19f::errors::vault_admin_value_above_limit());
        0x2e39b917ac7e580fb015308843144eb335625c4784f92847fbb09236e055f19f::vault_market::set_risk_config<T0, T1>(arg0, 0x2e39b917ac7e580fb015308843144eb335625c4784f92847fbb09236e055f19f::risk_config::new(0x2e39b917ac7e580fb015308843144eb335625c4784f92847fbb09236e055f19f::vault_market::collateral_factor<T0, T1>(arg0) * 10, 0x2e39b917ac7e580fb015308843144eb335625c4784f92847fbb09236e055f19f::vault_market::liquidation_threshold<T0, T1>(arg0) * 10, 0x2e39b917ac7e580fb015308843144eb335625c4784f92847fbb09236e055f19f::vault_market::liquidation_max_limit<T0, T1>(arg0) * 10, 0x2e39b917ac7e580fb015308843144eb335625c4784f92847fbb09236e055f19f::vault_market::withdraw_gap<T0, T1>(arg0) * 10, 0x2e39b917ac7e580fb015308843144eb335625c4784f92847fbb09236e055f19f::vault_market::liquidation_penalty<T0, T1>(arg0), arg6));
        0x2e39b917ac7e580fb015308843144eb335625c4784f92847fbb09236e055f19f::events::emit_log_update_borrow_fee(0x2e39b917ac7e580fb015308843144eb335625c4784f92847fbb09236e055f19f::vault_market::vault_id<T0, T1>(arg0), arg6);
    }

    public fun update_borrow_rate_magnifier<T0, T1>(arg0: &mut 0x2e39b917ac7e580fb015308843144eb335625c4784f92847fbb09236e055f19f::vault_market::VaultMarket<T0, T1>, arg1: &0x2e39b917ac7e580fb015308843144eb335625c4784f92847fbb09236e055f19f::registry::VaultRegistry, arg2: &0x2e39b917ac7e580fb015308843144eb335625c4784f92847fbb09236e055f19f::auth::VaultAdmin, arg3: 0x1::option::Option<0x2e39b917ac7e580fb015308843144eb335625c4784f92847fbb09236e055f19f::timelock_cap::TimelockTicket>, arg4: &0x6949079b5873a2bbb94439acf9c85836a5a96189c687199e6cec0308348867f8::reserve::TokenReserve<T0>, arg5: &0x6949079b5873a2bbb94439acf9c85836a5a96189c687199e6cec0308348867f8::reserve::TokenReserve<T1>, arg6: 0x2e39b917ac7e580fb015308843144eb335625c4784f92847fbb09236e055f19f::structs::RateMagnifier, arg7: &0x2::clock::Clock, arg8: &0x2::tx_context::TxContext) {
        0x2e39b917ac7e580fb015308843144eb335625c4784f92847fbb09236e055f19f::auth::assert_auths(arg1, arg2, arg3, arg8);
        0x2e39b917ac7e580fb015308843144eb335625c4784f92847fbb09236e055f19f::user::update_exchange_prices<T0, T1>(arg0, arg1, arg4, arg5, arg7);
        0x2e39b917ac7e580fb015308843144eb335625c4784f92847fbb09236e055f19f::vault_market::set_borrow_rate_magnifier<T0, T1>(arg0, arg6);
        0x2e39b917ac7e580fb015308843144eb335625c4784f92847fbb09236e055f19f::events::emit_log_update_borrow_rate_magnifier(0x2e39b917ac7e580fb015308843144eb335625c4784f92847fbb09236e055f19f::vault_market::vault_id<T0, T1>(arg0), 0x2e39b917ac7e580fb015308843144eb335625c4784f92847fbb09236e055f19f::structs::magnifier_magnitude(&arg6), 0x2e39b917ac7e580fb015308843144eb335625c4784f92847fbb09236e055f19f::structs::magnifier_is_negative(&arg6));
    }

    public fun update_collateral_factor<T0, T1>(arg0: &mut 0x2e39b917ac7e580fb015308843144eb335625c4784f92847fbb09236e055f19f::vault_market::VaultMarket<T0, T1>, arg1: &0x2e39b917ac7e580fb015308843144eb335625c4784f92847fbb09236e055f19f::registry::VaultRegistry, arg2: &0x2e39b917ac7e580fb015308843144eb335625c4784f92847fbb09236e055f19f::auth::VaultAdmin, arg3: 0x1::option::Option<0x2e39b917ac7e580fb015308843144eb335625c4784f92847fbb09236e055f19f::timelock_cap::TimelockTicket>, arg4: &0x6949079b5873a2bbb94439acf9c85836a5a96189c687199e6cec0308348867f8::reserve::TokenReserve<T0>, arg5: &0x6949079b5873a2bbb94439acf9c85836a5a96189c687199e6cec0308348867f8::reserve::TokenReserve<T1>, arg6: u16, arg7: &0x2::clock::Clock, arg8: &0x2::tx_context::TxContext) {
        0x2e39b917ac7e580fb015308843144eb335625c4784f92847fbb09236e055f19f::auth::assert_auths(arg1, arg2, arg3, arg8);
        0x2e39b917ac7e580fb015308843144eb335625c4784f92847fbb09236e055f19f::user::update_exchange_prices<T0, T1>(arg0, arg1, arg4, arg5, arg7);
        0x2e39b917ac7e580fb015308843144eb335625c4784f92847fbb09236e055f19f::vault_market::set_risk_config<T0, T1>(arg0, 0x2e39b917ac7e580fb015308843144eb335625c4784f92847fbb09236e055f19f::risk_config::new(arg6, 0x2e39b917ac7e580fb015308843144eb335625c4784f92847fbb09236e055f19f::vault_market::liquidation_threshold<T0, T1>(arg0) * 10, 0x2e39b917ac7e580fb015308843144eb335625c4784f92847fbb09236e055f19f::vault_market::liquidation_max_limit<T0, T1>(arg0) * 10, 0x2e39b917ac7e580fb015308843144eb335625c4784f92847fbb09236e055f19f::vault_market::withdraw_gap<T0, T1>(arg0) * 10, 0x2e39b917ac7e580fb015308843144eb335625c4784f92847fbb09236e055f19f::vault_market::liquidation_penalty<T0, T1>(arg0), 0x2e39b917ac7e580fb015308843144eb335625c4784f92847fbb09236e055f19f::vault_market::borrow_fee<T0, T1>(arg0)));
        0x2e39b917ac7e580fb015308843144eb335625c4784f92847fbb09236e055f19f::events::emit_log_update_collateral_factor(0x2e39b917ac7e580fb015308843144eb335625c4784f92847fbb09236e055f19f::vault_market::vault_id<T0, T1>(arg0), arg6);
    }

    public fun update_core_settings<T0, T1>(arg0: &mut 0x2e39b917ac7e580fb015308843144eb335625c4784f92847fbb09236e055f19f::vault_market::VaultMarket<T0, T1>, arg1: &0x2e39b917ac7e580fb015308843144eb335625c4784f92847fbb09236e055f19f::registry::VaultRegistry, arg2: &0x2e39b917ac7e580fb015308843144eb335625c4784f92847fbb09236e055f19f::auth::VaultAdmin, arg3: 0x1::option::Option<0x2e39b917ac7e580fb015308843144eb335625c4784f92847fbb09236e055f19f::timelock_cap::TimelockTicket>, arg4: &0x6949079b5873a2bbb94439acf9c85836a5a96189c687199e6cec0308348867f8::reserve::TokenReserve<T0>, arg5: &0x6949079b5873a2bbb94439acf9c85836a5a96189c687199e6cec0308348867f8::reserve::TokenReserve<T1>, arg6: 0x2e39b917ac7e580fb015308843144eb335625c4784f92847fbb09236e055f19f::risk_config::RiskConfig, arg7: 0x2e39b917ac7e580fb015308843144eb335625c4784f92847fbb09236e055f19f::structs::RateMagnifier, arg8: 0x2e39b917ac7e580fb015308843144eb335625c4784f92847fbb09236e055f19f::structs::RateMagnifier, arg9: &0x2::clock::Clock, arg10: &0x2::tx_context::TxContext) {
        0x2e39b917ac7e580fb015308843144eb335625c4784f92847fbb09236e055f19f::auth::assert_auths(arg1, arg2, arg3, arg10);
        0x2e39b917ac7e580fb015308843144eb335625c4784f92847fbb09236e055f19f::user::update_exchange_prices<T0, T1>(arg0, arg1, arg4, arg5, arg9);
        0x2e39b917ac7e580fb015308843144eb335625c4784f92847fbb09236e055f19f::vault_market::set_risk_config<T0, T1>(arg0, arg6);
        0x2e39b917ac7e580fb015308843144eb335625c4784f92847fbb09236e055f19f::vault_market::set_supply_rate_magnifier<T0, T1>(arg0, arg7);
        0x2e39b917ac7e580fb015308843144eb335625c4784f92847fbb09236e055f19f::vault_market::set_borrow_rate_magnifier<T0, T1>(arg0, arg8);
        0x2e39b917ac7e580fb015308843144eb335625c4784f92847fbb09236e055f19f::events::emit_log_update_core_settings(0x2e39b917ac7e580fb015308843144eb335625c4784f92847fbb09236e055f19f::vault_market::vault_id<T0, T1>(arg0), 0x2e39b917ac7e580fb015308843144eb335625c4784f92847fbb09236e055f19f::structs::magnifier_magnitude(&arg7), 0x2e39b917ac7e580fb015308843144eb335625c4784f92847fbb09236e055f19f::structs::magnifier_is_negative(&arg7), 0x2e39b917ac7e580fb015308843144eb335625c4784f92847fbb09236e055f19f::structs::magnifier_magnitude(&arg8), 0x2e39b917ac7e580fb015308843144eb335625c4784f92847fbb09236e055f19f::structs::magnifier_is_negative(&arg8), 0x2e39b917ac7e580fb015308843144eb335625c4784f92847fbb09236e055f19f::risk_config::collateral_factor(&arg6), 0x2e39b917ac7e580fb015308843144eb335625c4784f92847fbb09236e055f19f::risk_config::liquidation_threshold(&arg6), 0x2e39b917ac7e580fb015308843144eb335625c4784f92847fbb09236e055f19f::risk_config::liquidation_max_limit(&arg6), 0x2e39b917ac7e580fb015308843144eb335625c4784f92847fbb09236e055f19f::risk_config::withdraw_gap(&arg6), 0x2e39b917ac7e580fb015308843144eb335625c4784f92847fbb09236e055f19f::risk_config::liquidation_penalty(&arg6), 0x2e39b917ac7e580fb015308843144eb335625c4784f92847fbb09236e055f19f::risk_config::borrow_fee(&arg6));
    }

    public fun update_liquidation_max_limit<T0, T1>(arg0: &mut 0x2e39b917ac7e580fb015308843144eb335625c4784f92847fbb09236e055f19f::vault_market::VaultMarket<T0, T1>, arg1: &0x2e39b917ac7e580fb015308843144eb335625c4784f92847fbb09236e055f19f::registry::VaultRegistry, arg2: &0x2e39b917ac7e580fb015308843144eb335625c4784f92847fbb09236e055f19f::auth::VaultAdmin, arg3: 0x1::option::Option<0x2e39b917ac7e580fb015308843144eb335625c4784f92847fbb09236e055f19f::timelock_cap::TimelockTicket>, arg4: &0x6949079b5873a2bbb94439acf9c85836a5a96189c687199e6cec0308348867f8::reserve::TokenReserve<T0>, arg5: &0x6949079b5873a2bbb94439acf9c85836a5a96189c687199e6cec0308348867f8::reserve::TokenReserve<T1>, arg6: u16, arg7: &0x2::clock::Clock, arg8: &0x2::tx_context::TxContext) {
        0x2e39b917ac7e580fb015308843144eb335625c4784f92847fbb09236e055f19f::auth::assert_auths(arg1, arg2, arg3, arg8);
        0x2e39b917ac7e580fb015308843144eb335625c4784f92847fbb09236e055f19f::user::update_exchange_prices<T0, T1>(arg0, arg1, arg4, arg5, arg7);
        0x2e39b917ac7e580fb015308843144eb335625c4784f92847fbb09236e055f19f::vault_market::set_risk_config<T0, T1>(arg0, 0x2e39b917ac7e580fb015308843144eb335625c4784f92847fbb09236e055f19f::risk_config::new(0x2e39b917ac7e580fb015308843144eb335625c4784f92847fbb09236e055f19f::vault_market::collateral_factor<T0, T1>(arg0) * 10, 0x2e39b917ac7e580fb015308843144eb335625c4784f92847fbb09236e055f19f::vault_market::liquidation_threshold<T0, T1>(arg0) * 10, arg6, 0x2e39b917ac7e580fb015308843144eb335625c4784f92847fbb09236e055f19f::vault_market::withdraw_gap<T0, T1>(arg0) * 10, 0x2e39b917ac7e580fb015308843144eb335625c4784f92847fbb09236e055f19f::vault_market::liquidation_penalty<T0, T1>(arg0), 0x2e39b917ac7e580fb015308843144eb335625c4784f92847fbb09236e055f19f::vault_market::borrow_fee<T0, T1>(arg0)));
        0x2e39b917ac7e580fb015308843144eb335625c4784f92847fbb09236e055f19f::events::emit_log_update_liquidation_max_limit(0x2e39b917ac7e580fb015308843144eb335625c4784f92847fbb09236e055f19f::vault_market::vault_id<T0, T1>(arg0), arg6);
    }

    public fun update_liquidation_penalty<T0, T1>(arg0: &mut 0x2e39b917ac7e580fb015308843144eb335625c4784f92847fbb09236e055f19f::vault_market::VaultMarket<T0, T1>, arg1: &0x2e39b917ac7e580fb015308843144eb335625c4784f92847fbb09236e055f19f::registry::VaultRegistry, arg2: &0x2e39b917ac7e580fb015308843144eb335625c4784f92847fbb09236e055f19f::auth::VaultAdmin, arg3: 0x1::option::Option<0x2e39b917ac7e580fb015308843144eb335625c4784f92847fbb09236e055f19f::timelock_cap::TimelockTicket>, arg4: &0x6949079b5873a2bbb94439acf9c85836a5a96189c687199e6cec0308348867f8::reserve::TokenReserve<T0>, arg5: &0x6949079b5873a2bbb94439acf9c85836a5a96189c687199e6cec0308348867f8::reserve::TokenReserve<T1>, arg6: u16, arg7: &0x2::clock::Clock, arg8: &0x2::tx_context::TxContext) {
        0x2e39b917ac7e580fb015308843144eb335625c4784f92847fbb09236e055f19f::auth::assert_auths(arg1, arg2, arg3, arg8);
        0x2e39b917ac7e580fb015308843144eb335625c4784f92847fbb09236e055f19f::user::update_exchange_prices<T0, T1>(arg0, arg1, arg4, arg5, arg7);
        0x2e39b917ac7e580fb015308843144eb335625c4784f92847fbb09236e055f19f::vault_market::set_risk_config<T0, T1>(arg0, 0x2e39b917ac7e580fb015308843144eb335625c4784f92847fbb09236e055f19f::risk_config::new(0x2e39b917ac7e580fb015308843144eb335625c4784f92847fbb09236e055f19f::vault_market::collateral_factor<T0, T1>(arg0) * 10, 0x2e39b917ac7e580fb015308843144eb335625c4784f92847fbb09236e055f19f::vault_market::liquidation_threshold<T0, T1>(arg0) * 10, 0x2e39b917ac7e580fb015308843144eb335625c4784f92847fbb09236e055f19f::vault_market::liquidation_max_limit<T0, T1>(arg0) * 10, 0x2e39b917ac7e580fb015308843144eb335625c4784f92847fbb09236e055f19f::vault_market::withdraw_gap<T0, T1>(arg0) * 10, arg6, 0x2e39b917ac7e580fb015308843144eb335625c4784f92847fbb09236e055f19f::vault_market::borrow_fee<T0, T1>(arg0)));
        0x2e39b917ac7e580fb015308843144eb335625c4784f92847fbb09236e055f19f::events::emit_log_update_liquidation_penalty(0x2e39b917ac7e580fb015308843144eb335625c4784f92847fbb09236e055f19f::vault_market::vault_id<T0, T1>(arg0), arg6);
    }

    public fun update_liquidation_threshold<T0, T1>(arg0: &mut 0x2e39b917ac7e580fb015308843144eb335625c4784f92847fbb09236e055f19f::vault_market::VaultMarket<T0, T1>, arg1: &0x2e39b917ac7e580fb015308843144eb335625c4784f92847fbb09236e055f19f::registry::VaultRegistry, arg2: &0x2e39b917ac7e580fb015308843144eb335625c4784f92847fbb09236e055f19f::auth::VaultAdmin, arg3: 0x1::option::Option<0x2e39b917ac7e580fb015308843144eb335625c4784f92847fbb09236e055f19f::timelock_cap::TimelockTicket>, arg4: &0x6949079b5873a2bbb94439acf9c85836a5a96189c687199e6cec0308348867f8::reserve::TokenReserve<T0>, arg5: &0x6949079b5873a2bbb94439acf9c85836a5a96189c687199e6cec0308348867f8::reserve::TokenReserve<T1>, arg6: u16, arg7: &0x2::clock::Clock, arg8: &0x2::tx_context::TxContext) {
        0x2e39b917ac7e580fb015308843144eb335625c4784f92847fbb09236e055f19f::auth::assert_auths(arg1, arg2, arg3, arg8);
        0x2e39b917ac7e580fb015308843144eb335625c4784f92847fbb09236e055f19f::user::update_exchange_prices<T0, T1>(arg0, arg1, arg4, arg5, arg7);
        0x2e39b917ac7e580fb015308843144eb335625c4784f92847fbb09236e055f19f::vault_market::set_risk_config<T0, T1>(arg0, 0x2e39b917ac7e580fb015308843144eb335625c4784f92847fbb09236e055f19f::risk_config::new(0x2e39b917ac7e580fb015308843144eb335625c4784f92847fbb09236e055f19f::vault_market::collateral_factor<T0, T1>(arg0) * 10, arg6, 0x2e39b917ac7e580fb015308843144eb335625c4784f92847fbb09236e055f19f::vault_market::liquidation_max_limit<T0, T1>(arg0) * 10, 0x2e39b917ac7e580fb015308843144eb335625c4784f92847fbb09236e055f19f::vault_market::withdraw_gap<T0, T1>(arg0) * 10, 0x2e39b917ac7e580fb015308843144eb335625c4784f92847fbb09236e055f19f::vault_market::liquidation_penalty<T0, T1>(arg0), 0x2e39b917ac7e580fb015308843144eb335625c4784f92847fbb09236e055f19f::vault_market::borrow_fee<T0, T1>(arg0)));
        0x2e39b917ac7e580fb015308843144eb335625c4784f92847fbb09236e055f19f::events::emit_log_update_liquidation_threshold(0x2e39b917ac7e580fb015308843144eb335625c4784f92847fbb09236e055f19f::vault_market::vault_id<T0, T1>(arg0), arg6);
    }

    public fun update_migrators(arg0: &0x2e39b917ac7e580fb015308843144eb335625c4784f92847fbb09236e055f19f::registry::VaultRegistry, arg1: &mut 0x2e39b917ac7e580fb015308843144eb335625c4784f92847fbb09236e055f19f::auth::VaultAdmin, arg2: 0x1::option::Option<0x2e39b917ac7e580fb015308843144eb335625c4784f92847fbb09236e055f19f::timelock_cap::TimelockTicket>, arg3: address, arg4: bool, arg5: &0x2::tx_context::TxContext) {
        0x2e39b917ac7e580fb015308843144eb335625c4784f92847fbb09236e055f19f::auth::assert_authority(arg0, arg1, arg2, arg5);
        if (arg4) {
            if (!0x2e39b917ac7e580fb015308843144eb335625c4784f92847fbb09236e055f19f::auth::has_migrator_record(arg1, arg3)) {
                0x2e39b917ac7e580fb015308843144eb335625c4784f92847fbb09236e055f19f::auth::grant_migrator(arg1, arg3);
            };
        } else if (0x2e39b917ac7e580fb015308843144eb335625c4784f92847fbb09236e055f19f::auth::has_migrator_record(arg1, arg3)) {
            0x2e39b917ac7e580fb015308843144eb335625c4784f92847fbb09236e055f19f::auth::revoke_migrator(arg1, arg3);
        };
        0x2e39b917ac7e580fb015308843144eb335625c4784f92847fbb09236e055f19f::events::emit_log_update_migrators(arg3, arg4);
    }

    public fun update_oracle<T0, T1>(arg0: &mut 0x2e39b917ac7e580fb015308843144eb335625c4784f92847fbb09236e055f19f::vault_market::VaultMarket<T0, T1>, arg1: &0x2e39b917ac7e580fb015308843144eb335625c4784f92847fbb09236e055f19f::registry::VaultRegistry, arg2: &0x2e39b917ac7e580fb015308843144eb335625c4784f92847fbb09236e055f19f::auth::VaultAdmin, arg3: 0x1::option::Option<0x2e39b917ac7e580fb015308843144eb335625c4784f92847fbb09236e055f19f::timelock_cap::TimelockTicket>, arg4: &0x6949079b5873a2bbb94439acf9c85836a5a96189c687199e6cec0308348867f8::reserve::TokenReserve<T0>, arg5: &0x6949079b5873a2bbb94439acf9c85836a5a96189c687199e6cec0308348867f8::reserve::TokenReserve<T1>, arg6: &0xb43861086c8f85a23627c2aa6346dba8620dd2ea3147b3cdae4083912783a2ab::oracle::Oracle, arg7: &0x2::clock::Clock, arg8: &0x2::tx_context::TxContext) {
        0x2e39b917ac7e580fb015308843144eb335625c4784f92847fbb09236e055f19f::auth::assert_auths(arg1, arg2, arg3, arg8);
        0x2e39b917ac7e580fb015308843144eb335625c4784f92847fbb09236e055f19f::user::update_exchange_prices<T0, T1>(arg0, arg1, arg4, arg5, arg7);
        let v0 = 0x2::object::id<0xb43861086c8f85a23627c2aa6346dba8620dd2ea3147b3cdae4083912783a2ab::oracle::Oracle>(arg6);
        assert!(v0 != 0x2e39b917ac7e580fb015308843144eb335625c4784f92847fbb09236e055f19f::vault_market::oracle<T0, T1>(arg0), 0x2e39b917ac7e580fb015308843144eb335625c4784f92847fbb09236e055f19f::errors::vault_invalid_oracle());
        0x2e39b917ac7e580fb015308843144eb335625c4784f92847fbb09236e055f19f::vault_market::set_oracle<T0, T1>(arg0, v0);
        0x2e39b917ac7e580fb015308843144eb335625c4784f92847fbb09236e055f19f::events::emit_log_update_oracle(0x2e39b917ac7e580fb015308843144eb335625c4784f92847fbb09236e055f19f::vault_market::vault_id<T0, T1>(arg0), v0);
    }

    public fun update_rebalancer<T0, T1>(arg0: &0x2e39b917ac7e580fb015308843144eb335625c4784f92847fbb09236e055f19f::registry::VaultRegistry, arg1: &mut 0x2e39b917ac7e580fb015308843144eb335625c4784f92847fbb09236e055f19f::auth::VaultAdmin, arg2: 0x1::option::Option<0x2e39b917ac7e580fb015308843144eb335625c4784f92847fbb09236e055f19f::timelock_cap::TimelockTicket>, arg3: &0x2e39b917ac7e580fb015308843144eb335625c4784f92847fbb09236e055f19f::vault_market::VaultMarket<T0, T1>, arg4: address, arg5: bool, arg6: &0x2::tx_context::TxContext) {
        0x2e39b917ac7e580fb015308843144eb335625c4784f92847fbb09236e055f19f::auth::assert_authority(arg0, arg1, arg2, arg6);
        let v0 = 0x2::object::id<0x2e39b917ac7e580fb015308843144eb335625c4784f92847fbb09236e055f19f::vault_market::VaultMarket<T0, T1>>(arg3);
        if (arg5) {
            if (!0x2e39b917ac7e580fb015308843144eb335625c4784f92847fbb09236e055f19f::auth::get_is_rebalancer(arg1, arg4, v0)) {
                0x2e39b917ac7e580fb015308843144eb335625c4784f92847fbb09236e055f19f::auth::grant_rebalancer(arg1, arg4, v0);
            };
        } else if (0x2e39b917ac7e580fb015308843144eb335625c4784f92847fbb09236e055f19f::auth::get_is_rebalancer(arg1, arg4, v0)) {
            0x2e39b917ac7e580fb015308843144eb335625c4784f92847fbb09236e055f19f::auth::revoke_rebalancer(arg1, arg4, v0);
        };
        0x2e39b917ac7e580fb015308843144eb335625c4784f92847fbb09236e055f19f::events::emit_log_update_rebalancer(v0, arg4, arg5);
    }

    public fun update_supply_rate_magnifier<T0, T1>(arg0: &mut 0x2e39b917ac7e580fb015308843144eb335625c4784f92847fbb09236e055f19f::vault_market::VaultMarket<T0, T1>, arg1: &0x2e39b917ac7e580fb015308843144eb335625c4784f92847fbb09236e055f19f::registry::VaultRegistry, arg2: &0x2e39b917ac7e580fb015308843144eb335625c4784f92847fbb09236e055f19f::auth::VaultAdmin, arg3: 0x1::option::Option<0x2e39b917ac7e580fb015308843144eb335625c4784f92847fbb09236e055f19f::timelock_cap::TimelockTicket>, arg4: &0x6949079b5873a2bbb94439acf9c85836a5a96189c687199e6cec0308348867f8::reserve::TokenReserve<T0>, arg5: &0x6949079b5873a2bbb94439acf9c85836a5a96189c687199e6cec0308348867f8::reserve::TokenReserve<T1>, arg6: 0x2e39b917ac7e580fb015308843144eb335625c4784f92847fbb09236e055f19f::structs::RateMagnifier, arg7: &0x2::clock::Clock, arg8: &0x2::tx_context::TxContext) {
        0x2e39b917ac7e580fb015308843144eb335625c4784f92847fbb09236e055f19f::auth::assert_auths(arg1, arg2, arg3, arg8);
        0x2e39b917ac7e580fb015308843144eb335625c4784f92847fbb09236e055f19f::user::update_exchange_prices<T0, T1>(arg0, arg1, arg4, arg5, arg7);
        0x2e39b917ac7e580fb015308843144eb335625c4784f92847fbb09236e055f19f::vault_market::set_supply_rate_magnifier<T0, T1>(arg0, arg6);
        0x2e39b917ac7e580fb015308843144eb335625c4784f92847fbb09236e055f19f::events::emit_log_update_supply_rate_magnifier(0x2e39b917ac7e580fb015308843144eb335625c4784f92847fbb09236e055f19f::vault_market::vault_id<T0, T1>(arg0), 0x2e39b917ac7e580fb015308843144eb335625c4784f92847fbb09236e055f19f::structs::magnifier_magnitude(&arg6), 0x2e39b917ac7e580fb015308843144eb335625c4784f92847fbb09236e055f19f::structs::magnifier_is_negative(&arg6));
    }

    public fun update_withdraw_gap<T0, T1>(arg0: &mut 0x2e39b917ac7e580fb015308843144eb335625c4784f92847fbb09236e055f19f::vault_market::VaultMarket<T0, T1>, arg1: &0x2e39b917ac7e580fb015308843144eb335625c4784f92847fbb09236e055f19f::registry::VaultRegistry, arg2: &0x2e39b917ac7e580fb015308843144eb335625c4784f92847fbb09236e055f19f::auth::VaultAdmin, arg3: 0x1::option::Option<0x2e39b917ac7e580fb015308843144eb335625c4784f92847fbb09236e055f19f::timelock_cap::TimelockTicket>, arg4: &0x6949079b5873a2bbb94439acf9c85836a5a96189c687199e6cec0308348867f8::reserve::TokenReserve<T0>, arg5: &0x6949079b5873a2bbb94439acf9c85836a5a96189c687199e6cec0308348867f8::reserve::TokenReserve<T1>, arg6: u16, arg7: &0x2::clock::Clock, arg8: &0x2::tx_context::TxContext) {
        0x2e39b917ac7e580fb015308843144eb335625c4784f92847fbb09236e055f19f::auth::assert_auths(arg1, arg2, arg3, arg8);
        0x2e39b917ac7e580fb015308843144eb335625c4784f92847fbb09236e055f19f::user::update_exchange_prices<T0, T1>(arg0, arg1, arg4, arg5, arg7);
        0x2e39b917ac7e580fb015308843144eb335625c4784f92847fbb09236e055f19f::vault_market::set_risk_config<T0, T1>(arg0, 0x2e39b917ac7e580fb015308843144eb335625c4784f92847fbb09236e055f19f::risk_config::new(0x2e39b917ac7e580fb015308843144eb335625c4784f92847fbb09236e055f19f::vault_market::collateral_factor<T0, T1>(arg0) * 10, 0x2e39b917ac7e580fb015308843144eb335625c4784f92847fbb09236e055f19f::vault_market::liquidation_threshold<T0, T1>(arg0) * 10, 0x2e39b917ac7e580fb015308843144eb335625c4784f92847fbb09236e055f19f::vault_market::liquidation_max_limit<T0, T1>(arg0) * 10, arg6, 0x2e39b917ac7e580fb015308843144eb335625c4784f92847fbb09236e055f19f::vault_market::liquidation_penalty<T0, T1>(arg0), 0x2e39b917ac7e580fb015308843144eb335625c4784f92847fbb09236e055f19f::vault_market::borrow_fee<T0, T1>(arg0)));
        0x2e39b917ac7e580fb015308843144eb335625c4784f92847fbb09236e055f19f::events::emit_log_update_withdraw_gap(0x2e39b917ac7e580fb015308843144eb335625c4784f92847fbb09236e055f19f::vault_market::vault_id<T0, T1>(arg0), arg6);
    }

    // decompiled from Move bytecode v7
}

