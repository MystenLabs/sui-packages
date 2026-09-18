module 0xf0f5a9c105384d5b79e212a9c9d3adfa5d030ef4c0cf9e22fa48674f9ad3652a::admin {
    struct RebalanceGap has copy, drop {
        col_recorded: u128,
        col_at_liquidity: u128,
        debt_recorded: u128,
        debt_at_liquidity: u128,
    }

    public fun add_admin(arg0: &0xf0f5a9c105384d5b79e212a9c9d3adfa5d030ef4c0cf9e22fa48674f9ad3652a::registry::VaultRegistry, arg1: &mut 0xf0f5a9c105384d5b79e212a9c9d3adfa5d030ef4c0cf9e22fa48674f9ad3652a::auth::VaultAdmin, arg2: address, arg3: &0x2::tx_context::TxContext) {
        0xf0f5a9c105384d5b79e212a9c9d3adfa5d030ef4c0cf9e22fa48674f9ad3652a::auth::assert_authority(arg0, arg1, arg3);
        0xf0f5a9c105384d5b79e212a9c9d3adfa5d030ef4c0cf9e22fa48674f9ad3652a::auth::add_admin(arg1, arg2);
    }

    public fun col_at_liquidity(arg0: &RebalanceGap) : u128 {
        arg0.col_at_liquidity
    }

    public fun col_gap(arg0: &RebalanceGap) : 0xd0f7e9baf5bb8c13444fc7abc562103b7632acea5f290ed7ab6bbe6f2191febb::structs::Amount {
        compute_rebalance_amount(arg0.col_recorded, arg0.col_at_liquidity)
    }

    public fun col_recorded(arg0: &RebalanceGap) : u128 {
        arg0.col_recorded
    }

    fun compute_rebalance_amount(arg0: u128, arg1: u128) : 0xd0f7e9baf5bb8c13444fc7abc562103b7632acea5f290ed7ab6bbe6f2191febb::structs::Amount {
        if (arg0 > arg1) {
            0xd0f7e9baf5bb8c13444fc7abc562103b7632acea5f290ed7ab6bbe6f2191febb::structs::positive(((arg0 - arg1) as u64))
        } else if (arg1 > arg0) {
            0xd0f7e9baf5bb8c13444fc7abc562103b7632acea5f290ed7ab6bbe6f2191febb::structs::negative(((arg1 - arg0) as u64))
        } else {
            0xd0f7e9baf5bb8c13444fc7abc562103b7632acea5f290ed7ab6bbe6f2191febb::structs::none()
        }
    }

    public fun debt_at_liquidity(arg0: &RebalanceGap) : u128 {
        arg0.debt_at_liquidity
    }

    public fun debt_gap(arg0: &RebalanceGap) : 0xd0f7e9baf5bb8c13444fc7abc562103b7632acea5f290ed7ab6bbe6f2191febb::structs::Amount {
        compute_rebalance_amount(arg0.debt_recorded, arg0.debt_at_liquidity)
    }

    public fun debt_recorded(arg0: &RebalanceGap) : u128 {
        arg0.debt_recorded
    }

    fun get_adjusted_rebalance_amount(arg0: 0xd0f7e9baf5bb8c13444fc7abc562103b7632acea5f290ed7ab6bbe6f2191febb::structs::Amount, arg1: 0x1::option::Option<u128>) : 0xd0f7e9baf5bb8c13444fc7abc562103b7632acea5f290ed7ab6bbe6f2191febb::structs::Amount {
        if (0x1::option::is_none<u128>(&arg1)) {
            return arg0
        };
        let v0 = *0x1::option::borrow<u128>(&arg1);
        let v1 = (0xd0f7e9baf5bb8c13444fc7abc562103b7632acea5f290ed7ab6bbe6f2191febb::structs::value(&arg0) as u128);
        let v2 = if (v1 < v0) {
            v1
        } else {
            v0
        };
        if (0xd0f7e9baf5bb8c13444fc7abc562103b7632acea5f290ed7ab6bbe6f2191febb::structs::get_is_positive(&arg0)) {
            0xd0f7e9baf5bb8c13444fc7abc562103b7632acea5f290ed7ab6bbe6f2191febb::structs::positive((v2 as u64))
        } else if (0xd0f7e9baf5bb8c13444fc7abc562103b7632acea5f290ed7ab6bbe6f2191febb::structs::get_is_negative(&arg0)) {
            0xd0f7e9baf5bb8c13444fc7abc562103b7632acea5f290ed7ab6bbe6f2191febb::structs::negative((v2 as u64))
        } else {
            0xd0f7e9baf5bb8c13444fc7abc562103b7632acea5f290ed7ab6bbe6f2191febb::structs::none()
        }
    }

    public fun init_vault_config<T0, T1>(arg0: &mut 0xf0f5a9c105384d5b79e212a9c9d3adfa5d030ef4c0cf9e22fa48674f9ad3652a::registry::VaultRegistry, arg1: &0xf0f5a9c105384d5b79e212a9c9d3adfa5d030ef4c0cf9e22fa48674f9ad3652a::auth::VaultAdmin, arg2: &0xd0f7e9baf5bb8c13444fc7abc562103b7632acea5f290ed7ab6bbe6f2191febb::registry::Registry, arg3: 0xf0f5a9c105384d5b79e212a9c9d3adfa5d030ef4c0cf9e22fa48674f9ad3652a::risk_config::RiskConfig, arg4: 0xf0f5a9c105384d5b79e212a9c9d3adfa5d030ef4c0cf9e22fa48674f9ad3652a::structs::RateMagnifier, arg5: 0xf0f5a9c105384d5b79e212a9c9d3adfa5d030ef4c0cf9e22fa48674f9ad3652a::structs::RateMagnifier, arg6: &0xebe2409c7ea9636f0e446797515cbee2ab809d898b06d99179d9eda59e1e42d5::oracle::Oracle, arg7: u8, arg8: u8, arg9: &0x2::clock::Clock, arg10: &mut 0x2::tx_context::TxContext) {
        0xf0f5a9c105384d5b79e212a9c9d3adfa5d030ef4c0cf9e22fa48674f9ad3652a::auth::assert_auths(arg0, arg1, arg10);
        let v0 = 0xf0f5a9c105384d5b79e212a9c9d3adfa5d030ef4c0cf9e22fa48674f9ad3652a::vault_market::create<T0, T1>(arg0, arg3, arg4, arg5, 0x2::object::id<0xebe2409c7ea9636f0e446797515cbee2ab809d898b06d99179d9eda59e1e42d5::oracle::Oracle>(arg6), 0x2::object::id<0xd0f7e9baf5bb8c13444fc7abc562103b7632acea5f290ed7ab6bbe6f2191febb::registry::Registry>(arg2), arg7, arg8, arg9, arg10);
        0xf0f5a9c105384d5b79e212a9c9d3adfa5d030ef4c0cf9e22fa48674f9ad3652a::events::emit_log_init_vault_config(0xf0f5a9c105384d5b79e212a9c9d3adfa5d030ef4c0cf9e22fa48674f9ad3652a::vault_market::vault_object_id<T0, T1>(&v0), 0xf0f5a9c105384d5b79e212a9c9d3adfa5d030ef4c0cf9e22fa48674f9ad3652a::vault_market::vault_id<T0, T1>(&v0));
        0xf0f5a9c105384d5b79e212a9c9d3adfa5d030ef4c0cf9e22fa48674f9ad3652a::vault_market::share<T0, T1>(v0);
    }

    public fun init_vault_state<T0, T1>(arg0: &mut 0xf0f5a9c105384d5b79e212a9c9d3adfa5d030ef4c0cf9e22fa48674f9ad3652a::vault_market::VaultMarket<T0, T1>, arg1: &0xf0f5a9c105384d5b79e212a9c9d3adfa5d030ef4c0cf9e22fa48674f9ad3652a::registry::VaultRegistry, arg2: &0xf0f5a9c105384d5b79e212a9c9d3adfa5d030ef4c0cf9e22fa48674f9ad3652a::auth::VaultAdmin, arg3: &0xd0f7e9baf5bb8c13444fc7abc562103b7632acea5f290ed7ab6bbe6f2191febb::reserve::TokenReserve<T0>, arg4: &0xd0f7e9baf5bb8c13444fc7abc562103b7632acea5f290ed7ab6bbe6f2191febb::reserve::TokenReserve<T1>, arg5: &0x2::clock::Clock, arg6: &0x2::tx_context::TxContext) {
        0xf0f5a9c105384d5b79e212a9c9d3adfa5d030ef4c0cf9e22fa48674f9ad3652a::auth::assert_auths(arg1, arg2, arg6);
        let (v0, _) = 0xf0f5a9c105384d5b79e212a9c9d3adfa5d030ef4c0cf9e22fa48674f9ad3652a::liquidity::get_exchange_prices<T0>(arg3, arg5);
        let (_, v3) = 0xf0f5a9c105384d5b79e212a9c9d3adfa5d030ef4c0cf9e22fa48674f9ad3652a::liquidity::get_exchange_prices<T1>(arg4, arg5);
        0xf0f5a9c105384d5b79e212a9c9d3adfa5d030ef4c0cf9e22fa48674f9ad3652a::vault_market::init_vault_state<T0, T1>(arg0, v0, v3, 0xc3715ec6e2efe31fce7096f93e5986fb57e32ea4d252618563ba0c7ded59565c::units::from_clock(arg5));
        0xf0f5a9c105384d5b79e212a9c9d3adfa5d030ef4c0cf9e22fa48674f9ad3652a::events::emit_log_init_vault_state(0xf0f5a9c105384d5b79e212a9c9d3adfa5d030ef4c0cf9e22fa48674f9ad3652a::vault_market::vault_object_id<T0, T1>(arg0));
    }

    public fun migrate_vault_registry(arg0: &mut 0xf0f5a9c105384d5b79e212a9c9d3adfa5d030ef4c0cf9e22fa48674f9ad3652a::registry::VaultRegistry, arg1: &0xf0f5a9c105384d5b79e212a9c9d3adfa5d030ef4c0cf9e22fa48674f9ad3652a::auth::VaultAdmin, arg2: &0x2::tx_context::TxContext) {
        0xf0f5a9c105384d5b79e212a9c9d3adfa5d030ef4c0cf9e22fa48674f9ad3652a::auth::assert_only_authority(arg1, 0x2::tx_context::sender(arg2));
        0xf0f5a9c105384d5b79e212a9c9d3adfa5d030ef4c0cf9e22fa48674f9ad3652a::registry::migrate(arg0);
    }

    public fun mint_and_install_caps<T0, T1>(arg0: &0xd0f7e9baf5bb8c13444fc7abc562103b7632acea5f290ed7ab6bbe6f2191febb::auth::Auth, arg1: &mut 0xd0f7e9baf5bb8c13444fc7abc562103b7632acea5f290ed7ab6bbe6f2191febb::registry::Registry, arg2: &mut 0xf0f5a9c105384d5b79e212a9c9d3adfa5d030ef4c0cf9e22fa48674f9ad3652a::vault_market::VaultMarket<T0, T1>, arg3: &0xf0f5a9c105384d5b79e212a9c9d3adfa5d030ef4c0cf9e22fa48674f9ad3652a::registry::VaultRegistry, arg4: &0xf0f5a9c105384d5b79e212a9c9d3adfa5d030ef4c0cf9e22fa48674f9ad3652a::auth::VaultAdmin, arg5: bool, arg6: bool, arg7: &0x2::tx_context::TxContext) {
        0xf0f5a9c105384d5b79e212a9c9d3adfa5d030ef4c0cf9e22fa48674f9ad3652a::auth::assert_auths(arg3, arg4, arg7);
        let v0 = 0xd0f7e9baf5bb8c13444fc7abc562103b7632acea5f290ed7ab6bbe6f2191febb::keys::holder_object(0x2::object::id<0xf0f5a9c105384d5b79e212a9c9d3adfa5d030ef4c0cf9e22fa48674f9ad3652a::vault_market::VaultMarket<T0, T1>>(arg2));
        let v1 = if (arg5) {
            0x1::option::some<0xd0f7e9baf5bb8c13444fc7abc562103b7632acea5f290ed7ab6bbe6f2191febb::user_cap::UserCap<T0>>(0xd0f7e9baf5bb8c13444fc7abc562103b7632acea5f290ed7ab6bbe6f2191febb::admin::mint_user_cap<T0>(arg0, arg1, v0, arg7))
        } else {
            0x1::option::none<0xd0f7e9baf5bb8c13444fc7abc562103b7632acea5f290ed7ab6bbe6f2191febb::user_cap::UserCap<T0>>()
        };
        let v2 = if (arg6) {
            0x1::option::some<0xd0f7e9baf5bb8c13444fc7abc562103b7632acea5f290ed7ab6bbe6f2191febb::user_cap::UserCap<T1>>(0xd0f7e9baf5bb8c13444fc7abc562103b7632acea5f290ed7ab6bbe6f2191febb::admin::mint_user_cap<T1>(arg0, arg1, v0, arg7))
        } else {
            0x1::option::none<0xd0f7e9baf5bb8c13444fc7abc562103b7632acea5f290ed7ab6bbe6f2191febb::user_cap::UserCap<T1>>()
        };
        0xf0f5a9c105384d5b79e212a9c9d3adfa5d030ef4c0cf9e22fa48674f9ad3652a::vault_market::add_caps<T0, T1>(arg2, v1, v2);
    }

    public fun preview<T0, T1>(arg0: &0xf0f5a9c105384d5b79e212a9c9d3adfa5d030ef4c0cf9e22fa48674f9ad3652a::vault_market::VaultMarket<T0, T1>, arg1: &0xd0f7e9baf5bb8c13444fc7abc562103b7632acea5f290ed7ab6bbe6f2191febb::reserve::TokenReserve<T0>, arg2: &0xd0f7e9baf5bb8c13444fc7abc562103b7632acea5f290ed7ab6bbe6f2191febb::reserve::TokenReserve<T1>, arg3: &0x2::clock::Clock) : RebalanceGap {
        let (v0, _) = 0xf0f5a9c105384d5b79e212a9c9d3adfa5d030ef4c0cf9e22fa48674f9ad3652a::liquidity::get_exchange_prices<T0>(arg1, arg3);
        let (_, v3) = 0xf0f5a9c105384d5b79e212a9c9d3adfa5d030ef4c0cf9e22fa48674f9ad3652a::liquidity::get_exchange_prices<T1>(arg2, arg3);
        let (v4, v5, v6, v7) = 0xf0f5a9c105384d5b79e212a9c9d3adfa5d030ef4c0cf9e22fa48674f9ad3652a::vault_market::load_exchange_prices<T0, T1>(arg0, v0, v3, 0xc3715ec6e2efe31fce7096f93e5986fb57e32ea4d252618563ba0c7ded59565c::units::from_clock(arg3));
        let v8 = 0xf0f5a9c105384d5b79e212a9c9d3adfa5d030ef4c0cf9e22fa48674f9ad3652a::constants::exchange_prices_precision();
        RebalanceGap{
            col_recorded      : 0xf0f5a9c105384d5b79e212a9c9d3adfa5d030ef4c0cf9e22fa48674f9ad3652a::constants::unscale_amounts(0xc3715ec6e2efe31fce7096f93e5986fb57e32ea4d252618563ba0c7ded59565c::math::mul_div_u128(0xf0f5a9c105384d5b79e212a9c9d3adfa5d030ef4c0cf9e22fa48674f9ad3652a::vault_market::get_total_supply<T0, T1>(arg0), v6, v8), 0xf0f5a9c105384d5b79e212a9c9d3adfa5d030ef4c0cf9e22fa48674f9ad3652a::vault_market::col_decimals<T0, T1>(arg0)),
            col_at_liquidity  : 0xc3715ec6e2efe31fce7096f93e5986fb57e32ea4d252618563ba0c7ded59565c::math::mul_div_u128(0xf0f5a9c105384d5b79e212a9c9d3adfa5d030ef4c0cf9e22fa48674f9ad3652a::liquidity::get_vault_supply_at_liquidity<T0, T1, T0>(arg0, arg1), v4, v8),
            debt_recorded     : 0xf0f5a9c105384d5b79e212a9c9d3adfa5d030ef4c0cf9e22fa48674f9ad3652a::constants::unscale_amounts(0xc3715ec6e2efe31fce7096f93e5986fb57e32ea4d252618563ba0c7ded59565c::math::mul_div_u128(0xf0f5a9c105384d5b79e212a9c9d3adfa5d030ef4c0cf9e22fa48674f9ad3652a::vault_market::get_total_borrow<T0, T1>(arg0), v7, v8), 0xf0f5a9c105384d5b79e212a9c9d3adfa5d030ef4c0cf9e22fa48674f9ad3652a::vault_market::debt_decimals<T0, T1>(arg0)),
            debt_at_liquidity : 0xc3715ec6e2efe31fce7096f93e5986fb57e32ea4d252618563ba0c7ded59565c::math::mul_div_u128(0xf0f5a9c105384d5b79e212a9c9d3adfa5d030ef4c0cf9e22fa48674f9ad3652a::liquidity::get_vault_borrow_at_liquidity<T0, T1, T1>(arg0, arg2), v5, v8),
        }
    }

    public fun rebalance<T0, T1>(arg0: &0xd0f7e9baf5bb8c13444fc7abc562103b7632acea5f290ed7ab6bbe6f2191febb::registry::Registry, arg1: &mut 0xf0f5a9c105384d5b79e212a9c9d3adfa5d030ef4c0cf9e22fa48674f9ad3652a::vault_market::VaultMarket<T0, T1>, arg2: &0xf0f5a9c105384d5b79e212a9c9d3adfa5d030ef4c0cf9e22fa48674f9ad3652a::registry::VaultRegistry, arg3: &0xf0f5a9c105384d5b79e212a9c9d3adfa5d030ef4c0cf9e22fa48674f9ad3652a::auth::VaultAdmin, arg4: &mut 0xd0f7e9baf5bb8c13444fc7abc562103b7632acea5f290ed7ab6bbe6f2191febb::reserve::TokenReserve<T0>, arg5: &mut 0xd0f7e9baf5bb8c13444fc7abc562103b7632acea5f290ed7ab6bbe6f2191febb::reserve::TokenReserve<T1>, arg6: 0x2::balance::Balance<T0>, arg7: 0x2::balance::Balance<T1>, arg8: &0x2::clock::Clock, arg9: &mut 0x2::tx_context::TxContext) : (0x2::balance::Balance<T0>, 0x2::balance::Balance<T1>) {
        rebalance_with_amounts<T0, T1>(arg0, arg1, arg2, arg3, arg4, arg5, arg6, arg7, 0x1::option::none<u128>(), 0x1::option::none<u128>(), arg8, arg9)
    }

    public fun rebalance_with_amounts<T0, T1>(arg0: &0xd0f7e9baf5bb8c13444fc7abc562103b7632acea5f290ed7ab6bbe6f2191febb::registry::Registry, arg1: &mut 0xf0f5a9c105384d5b79e212a9c9d3adfa5d030ef4c0cf9e22fa48674f9ad3652a::vault_market::VaultMarket<T0, T1>, arg2: &0xf0f5a9c105384d5b79e212a9c9d3adfa5d030ef4c0cf9e22fa48674f9ad3652a::registry::VaultRegistry, arg3: &0xf0f5a9c105384d5b79e212a9c9d3adfa5d030ef4c0cf9e22fa48674f9ad3652a::auth::VaultAdmin, arg4: &mut 0xd0f7e9baf5bb8c13444fc7abc562103b7632acea5f290ed7ab6bbe6f2191febb::reserve::TokenReserve<T0>, arg5: &mut 0xd0f7e9baf5bb8c13444fc7abc562103b7632acea5f290ed7ab6bbe6f2191febb::reserve::TokenReserve<T1>, arg6: 0x2::balance::Balance<T0>, arg7: 0x2::balance::Balance<T1>, arg8: 0x1::option::Option<u128>, arg9: 0x1::option::Option<u128>, arg10: &0x2::clock::Clock, arg11: &mut 0x2::tx_context::TxContext) : (0x2::balance::Balance<T0>, 0x2::balance::Balance<T1>) {
        0xf0f5a9c105384d5b79e212a9c9d3adfa5d030ef4c0cf9e22fa48674f9ad3652a::vault_market::assert_caps_installed<T0, T1>(arg1);
        0xf0f5a9c105384d5b79e212a9c9d3adfa5d030ef4c0cf9e22fa48674f9ad3652a::liquidity::assert_liquidity_program<T0, T1>(arg1, arg0);
        0xf0f5a9c105384d5b79e212a9c9d3adfa5d030ef4c0cf9e22fa48674f9ad3652a::auth::assert_rebalancer(arg2, arg3, 0x2::tx_context::sender(arg11), 0x2::object::id<0xf0f5a9c105384d5b79e212a9c9d3adfa5d030ef4c0cf9e22fa48674f9ad3652a::vault_market::VaultMarket<T0, T1>>(arg1));
        let v0 = preview<T0, T1>(arg1, arg4, arg5, arg10);
        let v1 = get_adjusted_rebalance_amount(col_gap(&v0), arg8);
        let v2 = get_adjusted_rebalance_amount(debt_gap(&v0), arg9);
        let v3 = 0xd0f7e9baf5bb8c13444fc7abc562103b7632acea5f290ed7ab6bbe6f2191febb::structs::is_none(&v1) && 0xd0f7e9baf5bb8c13444fc7abc562103b7632acea5f290ed7ab6bbe6f2191febb::structs::is_none(&v2);
        assert!(!v3, 0xf0f5a9c105384d5b79e212a9c9d3adfa5d030ef4c0cf9e22fa48674f9ad3652a::errors::vault_nothing_to_rebalance());
        let v4 = 0;
        let v5 = 0;
        let v6 = 0;
        let v7 = 0;
        let v8 = 0x2::balance::zero<T0>();
        if (!0xd0f7e9baf5bb8c13444fc7abc562103b7632acea5f290ed7ab6bbe6f2191febb::structs::is_none(&v1)) {
            if (0xd0f7e9baf5bb8c13444fc7abc562103b7632acea5f290ed7ab6bbe6f2191febb::structs::get_is_positive(&v1)) {
                let v9 = 0xd0f7e9baf5bb8c13444fc7abc562103b7632acea5f290ed7ab6bbe6f2191febb::structs::value(&v1);
                v4 = v9;
                0x2::balance::destroy_zero<T0>(0xf0f5a9c105384d5b79e212a9c9d3adfa5d030ef4c0cf9e22fa48674f9ad3652a::liquidity::supply<T0, T1>(arg0, arg1, arg4, v1, 0x2::balance::split<T0>(&mut arg6, v9), arg10, arg11));
            } else {
                v5 = 0xd0f7e9baf5bb8c13444fc7abc562103b7632acea5f290ed7ab6bbe6f2191febb::structs::value(&v1);
                0x2::balance::join<T0>(&mut v8, 0xf0f5a9c105384d5b79e212a9c9d3adfa5d030ef4c0cf9e22fa48674f9ad3652a::liquidity::supply<T0, T1>(arg0, arg1, arg4, v1, 0x2::balance::zero<T0>(), arg10, arg11));
            };
        };
        let v10 = 0x2::balance::zero<T1>();
        if (!0xd0f7e9baf5bb8c13444fc7abc562103b7632acea5f290ed7ab6bbe6f2191febb::structs::is_none(&v2)) {
            if (0xd0f7e9baf5bb8c13444fc7abc562103b7632acea5f290ed7ab6bbe6f2191febb::structs::get_is_positive(&v2)) {
                v7 = 0xd0f7e9baf5bb8c13444fc7abc562103b7632acea5f290ed7ab6bbe6f2191febb::structs::value(&v2);
                0x2::balance::join<T1>(&mut v10, 0xf0f5a9c105384d5b79e212a9c9d3adfa5d030ef4c0cf9e22fa48674f9ad3652a::liquidity::borrow<T0, T1>(arg0, arg1, arg5, v2, 0x2::balance::zero<T1>(), arg10, arg11));
            } else {
                let v11 = 0xd0f7e9baf5bb8c13444fc7abc562103b7632acea5f290ed7ab6bbe6f2191febb::structs::value(&v2);
                v6 = v11;
                0x2::balance::destroy_zero<T1>(0xf0f5a9c105384d5b79e212a9c9d3adfa5d030ef4c0cf9e22fa48674f9ad3652a::liquidity::borrow<T0, T1>(arg0, arg1, arg5, v2, 0x2::balance::split<T1>(&mut arg7, v11), arg10, arg11));
            };
        };
        0xf0f5a9c105384d5b79e212a9c9d3adfa5d030ef4c0cf9e22fa48674f9ad3652a::events::emit_log_rebalance(0xf0f5a9c105384d5b79e212a9c9d3adfa5d030ef4c0cf9e22fa48674f9ad3652a::vault_market::vault_id<T0, T1>(arg1), v4, v5, v6, v7);
        0x2::balance::join<T0>(&mut v8, arg6);
        0x2::balance::join<T1>(&mut v10, arg7);
        (v8, v10)
    }

    public fun remove_admin(arg0: &0xf0f5a9c105384d5b79e212a9c9d3adfa5d030ef4c0cf9e22fa48674f9ad3652a::registry::VaultRegistry, arg1: &mut 0xf0f5a9c105384d5b79e212a9c9d3adfa5d030ef4c0cf9e22fa48674f9ad3652a::auth::VaultAdmin, arg2: address, arg3: &0x2::tx_context::TxContext) {
        0xf0f5a9c105384d5b79e212a9c9d3adfa5d030ef4c0cf9e22fa48674f9ad3652a::auth::assert_authority(arg0, arg1, arg3);
        0xf0f5a9c105384d5b79e212a9c9d3adfa5d030ef4c0cf9e22fa48674f9ad3652a::auth::remove_admin(arg1, arg2);
    }

    public fun update_auths(arg0: &0xf0f5a9c105384d5b79e212a9c9d3adfa5d030ef4c0cf9e22fa48674f9ad3652a::registry::VaultRegistry, arg1: &mut 0xf0f5a9c105384d5b79e212a9c9d3adfa5d030ef4c0cf9e22fa48674f9ad3652a::auth::VaultAdmin, arg2: address, arg3: bool, arg4: &0x2::tx_context::TxContext) {
        0xf0f5a9c105384d5b79e212a9c9d3adfa5d030ef4c0cf9e22fa48674f9ad3652a::auth::assert_authority(arg0, arg1, arg4);
        if (arg3) {
            if (!0xf0f5a9c105384d5b79e212a9c9d3adfa5d030ef4c0cf9e22fa48674f9ad3652a::auth::has_auth_record(arg1, arg2)) {
                0xf0f5a9c105384d5b79e212a9c9d3adfa5d030ef4c0cf9e22fa48674f9ad3652a::auth::grant_auth(arg1, arg2);
            };
        } else if (0xf0f5a9c105384d5b79e212a9c9d3adfa5d030ef4c0cf9e22fa48674f9ad3652a::auth::has_auth_record(arg1, arg2)) {
            0xf0f5a9c105384d5b79e212a9c9d3adfa5d030ef4c0cf9e22fa48674f9ad3652a::auth::revoke_auth(arg1, arg2);
        };
        0xf0f5a9c105384d5b79e212a9c9d3adfa5d030ef4c0cf9e22fa48674f9ad3652a::events::emit_log_update_auths(arg2, arg3);
    }

    public fun update_borrow_fee<T0, T1>(arg0: &mut 0xf0f5a9c105384d5b79e212a9c9d3adfa5d030ef4c0cf9e22fa48674f9ad3652a::vault_market::VaultMarket<T0, T1>, arg1: &0xf0f5a9c105384d5b79e212a9c9d3adfa5d030ef4c0cf9e22fa48674f9ad3652a::registry::VaultRegistry, arg2: &0xf0f5a9c105384d5b79e212a9c9d3adfa5d030ef4c0cf9e22fa48674f9ad3652a::auth::VaultAdmin, arg3: &0xd0f7e9baf5bb8c13444fc7abc562103b7632acea5f290ed7ab6bbe6f2191febb::reserve::TokenReserve<T0>, arg4: &0xd0f7e9baf5bb8c13444fc7abc562103b7632acea5f290ed7ab6bbe6f2191febb::reserve::TokenReserve<T1>, arg5: u8, arg6: &0x2::clock::Clock, arg7: &0x2::tx_context::TxContext) {
        0xf0f5a9c105384d5b79e212a9c9d3adfa5d030ef4c0cf9e22fa48674f9ad3652a::auth::assert_auths(arg1, arg2, arg7);
        0xf0f5a9c105384d5b79e212a9c9d3adfa5d030ef4c0cf9e22fa48674f9ad3652a::user::update_exchange_prices<T0, T1>(arg0, arg1, arg3, arg4, arg6);
        assert!(arg5 <= 0xf0f5a9c105384d5b79e212a9c9d3adfa5d030ef4c0cf9e22fa48674f9ad3652a::constants::max_borrow_fee(), 0xf0f5a9c105384d5b79e212a9c9d3adfa5d030ef4c0cf9e22fa48674f9ad3652a::errors::vault_admin_value_above_limit());
        0xf0f5a9c105384d5b79e212a9c9d3adfa5d030ef4c0cf9e22fa48674f9ad3652a::vault_market::set_risk_config<T0, T1>(arg0, 0xf0f5a9c105384d5b79e212a9c9d3adfa5d030ef4c0cf9e22fa48674f9ad3652a::risk_config::new(0xf0f5a9c105384d5b79e212a9c9d3adfa5d030ef4c0cf9e22fa48674f9ad3652a::vault_market::collateral_factor<T0, T1>(arg0) * 10, 0xf0f5a9c105384d5b79e212a9c9d3adfa5d030ef4c0cf9e22fa48674f9ad3652a::vault_market::liquidation_threshold<T0, T1>(arg0) * 10, 0xf0f5a9c105384d5b79e212a9c9d3adfa5d030ef4c0cf9e22fa48674f9ad3652a::vault_market::liquidation_max_limit<T0, T1>(arg0) * 10, 0xf0f5a9c105384d5b79e212a9c9d3adfa5d030ef4c0cf9e22fa48674f9ad3652a::vault_market::withdraw_gap<T0, T1>(arg0) * 10, 0xf0f5a9c105384d5b79e212a9c9d3adfa5d030ef4c0cf9e22fa48674f9ad3652a::vault_market::liquidation_penalty<T0, T1>(arg0), arg5));
        0xf0f5a9c105384d5b79e212a9c9d3adfa5d030ef4c0cf9e22fa48674f9ad3652a::events::emit_log_update_borrow_fee(arg5);
    }

    public fun update_borrow_rate_magnifier<T0, T1>(arg0: &mut 0xf0f5a9c105384d5b79e212a9c9d3adfa5d030ef4c0cf9e22fa48674f9ad3652a::vault_market::VaultMarket<T0, T1>, arg1: &0xf0f5a9c105384d5b79e212a9c9d3adfa5d030ef4c0cf9e22fa48674f9ad3652a::registry::VaultRegistry, arg2: &0xf0f5a9c105384d5b79e212a9c9d3adfa5d030ef4c0cf9e22fa48674f9ad3652a::auth::VaultAdmin, arg3: &0xd0f7e9baf5bb8c13444fc7abc562103b7632acea5f290ed7ab6bbe6f2191febb::reserve::TokenReserve<T0>, arg4: &0xd0f7e9baf5bb8c13444fc7abc562103b7632acea5f290ed7ab6bbe6f2191febb::reserve::TokenReserve<T1>, arg5: 0xf0f5a9c105384d5b79e212a9c9d3adfa5d030ef4c0cf9e22fa48674f9ad3652a::structs::RateMagnifier, arg6: &0x2::clock::Clock, arg7: &0x2::tx_context::TxContext) {
        0xf0f5a9c105384d5b79e212a9c9d3adfa5d030ef4c0cf9e22fa48674f9ad3652a::auth::assert_auths(arg1, arg2, arg7);
        0xf0f5a9c105384d5b79e212a9c9d3adfa5d030ef4c0cf9e22fa48674f9ad3652a::user::update_exchange_prices<T0, T1>(arg0, arg1, arg3, arg4, arg6);
        0xf0f5a9c105384d5b79e212a9c9d3adfa5d030ef4c0cf9e22fa48674f9ad3652a::vault_market::set_borrow_rate_magnifier<T0, T1>(arg0, arg5);
        0xf0f5a9c105384d5b79e212a9c9d3adfa5d030ef4c0cf9e22fa48674f9ad3652a::events::emit_log_update_borrow_rate_magnifier(0xf0f5a9c105384d5b79e212a9c9d3adfa5d030ef4c0cf9e22fa48674f9ad3652a::structs::magnifier_magnitude(&arg5), 0xf0f5a9c105384d5b79e212a9c9d3adfa5d030ef4c0cf9e22fa48674f9ad3652a::structs::magnifier_is_negative(&arg5));
    }

    public fun update_collateral_factor<T0, T1>(arg0: &mut 0xf0f5a9c105384d5b79e212a9c9d3adfa5d030ef4c0cf9e22fa48674f9ad3652a::vault_market::VaultMarket<T0, T1>, arg1: &0xf0f5a9c105384d5b79e212a9c9d3adfa5d030ef4c0cf9e22fa48674f9ad3652a::registry::VaultRegistry, arg2: &0xf0f5a9c105384d5b79e212a9c9d3adfa5d030ef4c0cf9e22fa48674f9ad3652a::auth::VaultAdmin, arg3: &0xd0f7e9baf5bb8c13444fc7abc562103b7632acea5f290ed7ab6bbe6f2191febb::reserve::TokenReserve<T0>, arg4: &0xd0f7e9baf5bb8c13444fc7abc562103b7632acea5f290ed7ab6bbe6f2191febb::reserve::TokenReserve<T1>, arg5: u16, arg6: &0x2::clock::Clock, arg7: &0x2::tx_context::TxContext) {
        0xf0f5a9c105384d5b79e212a9c9d3adfa5d030ef4c0cf9e22fa48674f9ad3652a::auth::assert_auths(arg1, arg2, arg7);
        0xf0f5a9c105384d5b79e212a9c9d3adfa5d030ef4c0cf9e22fa48674f9ad3652a::user::update_exchange_prices<T0, T1>(arg0, arg1, arg3, arg4, arg6);
        0xf0f5a9c105384d5b79e212a9c9d3adfa5d030ef4c0cf9e22fa48674f9ad3652a::vault_market::set_risk_config<T0, T1>(arg0, 0xf0f5a9c105384d5b79e212a9c9d3adfa5d030ef4c0cf9e22fa48674f9ad3652a::risk_config::new(arg5, 0xf0f5a9c105384d5b79e212a9c9d3adfa5d030ef4c0cf9e22fa48674f9ad3652a::vault_market::liquidation_threshold<T0, T1>(arg0) * 10, 0xf0f5a9c105384d5b79e212a9c9d3adfa5d030ef4c0cf9e22fa48674f9ad3652a::vault_market::liquidation_max_limit<T0, T1>(arg0) * 10, 0xf0f5a9c105384d5b79e212a9c9d3adfa5d030ef4c0cf9e22fa48674f9ad3652a::vault_market::withdraw_gap<T0, T1>(arg0) * 10, 0xf0f5a9c105384d5b79e212a9c9d3adfa5d030ef4c0cf9e22fa48674f9ad3652a::vault_market::liquidation_penalty<T0, T1>(arg0), 0xf0f5a9c105384d5b79e212a9c9d3adfa5d030ef4c0cf9e22fa48674f9ad3652a::vault_market::borrow_fee<T0, T1>(arg0)));
        0xf0f5a9c105384d5b79e212a9c9d3adfa5d030ef4c0cf9e22fa48674f9ad3652a::events::emit_log_update_collateral_factor(arg5);
    }

    public fun update_core_settings<T0, T1>(arg0: &mut 0xf0f5a9c105384d5b79e212a9c9d3adfa5d030ef4c0cf9e22fa48674f9ad3652a::vault_market::VaultMarket<T0, T1>, arg1: &0xf0f5a9c105384d5b79e212a9c9d3adfa5d030ef4c0cf9e22fa48674f9ad3652a::registry::VaultRegistry, arg2: &0xf0f5a9c105384d5b79e212a9c9d3adfa5d030ef4c0cf9e22fa48674f9ad3652a::auth::VaultAdmin, arg3: &0xd0f7e9baf5bb8c13444fc7abc562103b7632acea5f290ed7ab6bbe6f2191febb::reserve::TokenReserve<T0>, arg4: &0xd0f7e9baf5bb8c13444fc7abc562103b7632acea5f290ed7ab6bbe6f2191febb::reserve::TokenReserve<T1>, arg5: 0xf0f5a9c105384d5b79e212a9c9d3adfa5d030ef4c0cf9e22fa48674f9ad3652a::risk_config::RiskConfig, arg6: 0xf0f5a9c105384d5b79e212a9c9d3adfa5d030ef4c0cf9e22fa48674f9ad3652a::structs::RateMagnifier, arg7: 0xf0f5a9c105384d5b79e212a9c9d3adfa5d030ef4c0cf9e22fa48674f9ad3652a::structs::RateMagnifier, arg8: &0x2::clock::Clock, arg9: &0x2::tx_context::TxContext) {
        0xf0f5a9c105384d5b79e212a9c9d3adfa5d030ef4c0cf9e22fa48674f9ad3652a::auth::assert_auths(arg1, arg2, arg9);
        0xf0f5a9c105384d5b79e212a9c9d3adfa5d030ef4c0cf9e22fa48674f9ad3652a::user::update_exchange_prices<T0, T1>(arg0, arg1, arg3, arg4, arg8);
        0xf0f5a9c105384d5b79e212a9c9d3adfa5d030ef4c0cf9e22fa48674f9ad3652a::vault_market::set_risk_config<T0, T1>(arg0, arg5);
        0xf0f5a9c105384d5b79e212a9c9d3adfa5d030ef4c0cf9e22fa48674f9ad3652a::vault_market::set_supply_rate_magnifier<T0, T1>(arg0, arg6);
        0xf0f5a9c105384d5b79e212a9c9d3adfa5d030ef4c0cf9e22fa48674f9ad3652a::vault_market::set_borrow_rate_magnifier<T0, T1>(arg0, arg7);
        0xf0f5a9c105384d5b79e212a9c9d3adfa5d030ef4c0cf9e22fa48674f9ad3652a::events::emit_log_update_core_settings(0xf0f5a9c105384d5b79e212a9c9d3adfa5d030ef4c0cf9e22fa48674f9ad3652a::structs::magnifier_magnitude(&arg6), 0xf0f5a9c105384d5b79e212a9c9d3adfa5d030ef4c0cf9e22fa48674f9ad3652a::structs::magnifier_is_negative(&arg6), 0xf0f5a9c105384d5b79e212a9c9d3adfa5d030ef4c0cf9e22fa48674f9ad3652a::structs::magnifier_magnitude(&arg7), 0xf0f5a9c105384d5b79e212a9c9d3adfa5d030ef4c0cf9e22fa48674f9ad3652a::structs::magnifier_is_negative(&arg7), 0xf0f5a9c105384d5b79e212a9c9d3adfa5d030ef4c0cf9e22fa48674f9ad3652a::risk_config::collateral_factor(&arg5), 0xf0f5a9c105384d5b79e212a9c9d3adfa5d030ef4c0cf9e22fa48674f9ad3652a::risk_config::liquidation_threshold(&arg5), 0xf0f5a9c105384d5b79e212a9c9d3adfa5d030ef4c0cf9e22fa48674f9ad3652a::risk_config::liquidation_max_limit(&arg5), 0xf0f5a9c105384d5b79e212a9c9d3adfa5d030ef4c0cf9e22fa48674f9ad3652a::risk_config::withdraw_gap(&arg5), 0xf0f5a9c105384d5b79e212a9c9d3adfa5d030ef4c0cf9e22fa48674f9ad3652a::risk_config::liquidation_penalty(&arg5), 0xf0f5a9c105384d5b79e212a9c9d3adfa5d030ef4c0cf9e22fa48674f9ad3652a::risk_config::borrow_fee(&arg5));
    }

    public fun update_liquidation_max_limit<T0, T1>(arg0: &mut 0xf0f5a9c105384d5b79e212a9c9d3adfa5d030ef4c0cf9e22fa48674f9ad3652a::vault_market::VaultMarket<T0, T1>, arg1: &0xf0f5a9c105384d5b79e212a9c9d3adfa5d030ef4c0cf9e22fa48674f9ad3652a::registry::VaultRegistry, arg2: &0xf0f5a9c105384d5b79e212a9c9d3adfa5d030ef4c0cf9e22fa48674f9ad3652a::auth::VaultAdmin, arg3: &0xd0f7e9baf5bb8c13444fc7abc562103b7632acea5f290ed7ab6bbe6f2191febb::reserve::TokenReserve<T0>, arg4: &0xd0f7e9baf5bb8c13444fc7abc562103b7632acea5f290ed7ab6bbe6f2191febb::reserve::TokenReserve<T1>, arg5: u16, arg6: &0x2::clock::Clock, arg7: &0x2::tx_context::TxContext) {
        0xf0f5a9c105384d5b79e212a9c9d3adfa5d030ef4c0cf9e22fa48674f9ad3652a::auth::assert_auths(arg1, arg2, arg7);
        0xf0f5a9c105384d5b79e212a9c9d3adfa5d030ef4c0cf9e22fa48674f9ad3652a::user::update_exchange_prices<T0, T1>(arg0, arg1, arg3, arg4, arg6);
        0xf0f5a9c105384d5b79e212a9c9d3adfa5d030ef4c0cf9e22fa48674f9ad3652a::vault_market::set_risk_config<T0, T1>(arg0, 0xf0f5a9c105384d5b79e212a9c9d3adfa5d030ef4c0cf9e22fa48674f9ad3652a::risk_config::new(0xf0f5a9c105384d5b79e212a9c9d3adfa5d030ef4c0cf9e22fa48674f9ad3652a::vault_market::collateral_factor<T0, T1>(arg0) * 10, 0xf0f5a9c105384d5b79e212a9c9d3adfa5d030ef4c0cf9e22fa48674f9ad3652a::vault_market::liquidation_threshold<T0, T1>(arg0) * 10, arg5, 0xf0f5a9c105384d5b79e212a9c9d3adfa5d030ef4c0cf9e22fa48674f9ad3652a::vault_market::withdraw_gap<T0, T1>(arg0) * 10, 0xf0f5a9c105384d5b79e212a9c9d3adfa5d030ef4c0cf9e22fa48674f9ad3652a::vault_market::liquidation_penalty<T0, T1>(arg0), 0xf0f5a9c105384d5b79e212a9c9d3adfa5d030ef4c0cf9e22fa48674f9ad3652a::vault_market::borrow_fee<T0, T1>(arg0)));
        0xf0f5a9c105384d5b79e212a9c9d3adfa5d030ef4c0cf9e22fa48674f9ad3652a::events::emit_log_update_liquidation_max_limit(arg5);
    }

    public fun update_liquidation_penalty<T0, T1>(arg0: &mut 0xf0f5a9c105384d5b79e212a9c9d3adfa5d030ef4c0cf9e22fa48674f9ad3652a::vault_market::VaultMarket<T0, T1>, arg1: &0xf0f5a9c105384d5b79e212a9c9d3adfa5d030ef4c0cf9e22fa48674f9ad3652a::registry::VaultRegistry, arg2: &0xf0f5a9c105384d5b79e212a9c9d3adfa5d030ef4c0cf9e22fa48674f9ad3652a::auth::VaultAdmin, arg3: &0xd0f7e9baf5bb8c13444fc7abc562103b7632acea5f290ed7ab6bbe6f2191febb::reserve::TokenReserve<T0>, arg4: &0xd0f7e9baf5bb8c13444fc7abc562103b7632acea5f290ed7ab6bbe6f2191febb::reserve::TokenReserve<T1>, arg5: u16, arg6: &0x2::clock::Clock, arg7: &0x2::tx_context::TxContext) {
        0xf0f5a9c105384d5b79e212a9c9d3adfa5d030ef4c0cf9e22fa48674f9ad3652a::auth::assert_auths(arg1, arg2, arg7);
        0xf0f5a9c105384d5b79e212a9c9d3adfa5d030ef4c0cf9e22fa48674f9ad3652a::user::update_exchange_prices<T0, T1>(arg0, arg1, arg3, arg4, arg6);
        0xf0f5a9c105384d5b79e212a9c9d3adfa5d030ef4c0cf9e22fa48674f9ad3652a::vault_market::set_risk_config<T0, T1>(arg0, 0xf0f5a9c105384d5b79e212a9c9d3adfa5d030ef4c0cf9e22fa48674f9ad3652a::risk_config::new(0xf0f5a9c105384d5b79e212a9c9d3adfa5d030ef4c0cf9e22fa48674f9ad3652a::vault_market::collateral_factor<T0, T1>(arg0) * 10, 0xf0f5a9c105384d5b79e212a9c9d3adfa5d030ef4c0cf9e22fa48674f9ad3652a::vault_market::liquidation_threshold<T0, T1>(arg0) * 10, 0xf0f5a9c105384d5b79e212a9c9d3adfa5d030ef4c0cf9e22fa48674f9ad3652a::vault_market::liquidation_max_limit<T0, T1>(arg0) * 10, 0xf0f5a9c105384d5b79e212a9c9d3adfa5d030ef4c0cf9e22fa48674f9ad3652a::vault_market::withdraw_gap<T0, T1>(arg0) * 10, arg5, 0xf0f5a9c105384d5b79e212a9c9d3adfa5d030ef4c0cf9e22fa48674f9ad3652a::vault_market::borrow_fee<T0, T1>(arg0)));
        0xf0f5a9c105384d5b79e212a9c9d3adfa5d030ef4c0cf9e22fa48674f9ad3652a::events::emit_log_update_liquidation_penalty(arg5);
    }

    public fun update_liquidation_threshold<T0, T1>(arg0: &mut 0xf0f5a9c105384d5b79e212a9c9d3adfa5d030ef4c0cf9e22fa48674f9ad3652a::vault_market::VaultMarket<T0, T1>, arg1: &0xf0f5a9c105384d5b79e212a9c9d3adfa5d030ef4c0cf9e22fa48674f9ad3652a::registry::VaultRegistry, arg2: &0xf0f5a9c105384d5b79e212a9c9d3adfa5d030ef4c0cf9e22fa48674f9ad3652a::auth::VaultAdmin, arg3: &0xd0f7e9baf5bb8c13444fc7abc562103b7632acea5f290ed7ab6bbe6f2191febb::reserve::TokenReserve<T0>, arg4: &0xd0f7e9baf5bb8c13444fc7abc562103b7632acea5f290ed7ab6bbe6f2191febb::reserve::TokenReserve<T1>, arg5: u16, arg6: &0x2::clock::Clock, arg7: &0x2::tx_context::TxContext) {
        0xf0f5a9c105384d5b79e212a9c9d3adfa5d030ef4c0cf9e22fa48674f9ad3652a::auth::assert_auths(arg1, arg2, arg7);
        0xf0f5a9c105384d5b79e212a9c9d3adfa5d030ef4c0cf9e22fa48674f9ad3652a::user::update_exchange_prices<T0, T1>(arg0, arg1, arg3, arg4, arg6);
        0xf0f5a9c105384d5b79e212a9c9d3adfa5d030ef4c0cf9e22fa48674f9ad3652a::vault_market::set_risk_config<T0, T1>(arg0, 0xf0f5a9c105384d5b79e212a9c9d3adfa5d030ef4c0cf9e22fa48674f9ad3652a::risk_config::new(0xf0f5a9c105384d5b79e212a9c9d3adfa5d030ef4c0cf9e22fa48674f9ad3652a::vault_market::collateral_factor<T0, T1>(arg0) * 10, arg5, 0xf0f5a9c105384d5b79e212a9c9d3adfa5d030ef4c0cf9e22fa48674f9ad3652a::vault_market::liquidation_max_limit<T0, T1>(arg0) * 10, 0xf0f5a9c105384d5b79e212a9c9d3adfa5d030ef4c0cf9e22fa48674f9ad3652a::vault_market::withdraw_gap<T0, T1>(arg0) * 10, 0xf0f5a9c105384d5b79e212a9c9d3adfa5d030ef4c0cf9e22fa48674f9ad3652a::vault_market::liquidation_penalty<T0, T1>(arg0), 0xf0f5a9c105384d5b79e212a9c9d3adfa5d030ef4c0cf9e22fa48674f9ad3652a::vault_market::borrow_fee<T0, T1>(arg0)));
        0xf0f5a9c105384d5b79e212a9c9d3adfa5d030ef4c0cf9e22fa48674f9ad3652a::events::emit_log_update_liquidation_threshold(arg5);
    }

    public fun update_oracle<T0, T1>(arg0: &mut 0xf0f5a9c105384d5b79e212a9c9d3adfa5d030ef4c0cf9e22fa48674f9ad3652a::vault_market::VaultMarket<T0, T1>, arg1: &0xf0f5a9c105384d5b79e212a9c9d3adfa5d030ef4c0cf9e22fa48674f9ad3652a::registry::VaultRegistry, arg2: &0xf0f5a9c105384d5b79e212a9c9d3adfa5d030ef4c0cf9e22fa48674f9ad3652a::auth::VaultAdmin, arg3: &0xd0f7e9baf5bb8c13444fc7abc562103b7632acea5f290ed7ab6bbe6f2191febb::reserve::TokenReserve<T0>, arg4: &0xd0f7e9baf5bb8c13444fc7abc562103b7632acea5f290ed7ab6bbe6f2191febb::reserve::TokenReserve<T1>, arg5: &0xebe2409c7ea9636f0e446797515cbee2ab809d898b06d99179d9eda59e1e42d5::oracle::Oracle, arg6: &0x2::clock::Clock, arg7: &0x2::tx_context::TxContext) {
        0xf0f5a9c105384d5b79e212a9c9d3adfa5d030ef4c0cf9e22fa48674f9ad3652a::auth::assert_auths(arg1, arg2, arg7);
        0xf0f5a9c105384d5b79e212a9c9d3adfa5d030ef4c0cf9e22fa48674f9ad3652a::user::update_exchange_prices<T0, T1>(arg0, arg1, arg3, arg4, arg6);
        let v0 = 0x2::object::id<0xebe2409c7ea9636f0e446797515cbee2ab809d898b06d99179d9eda59e1e42d5::oracle::Oracle>(arg5);
        assert!(v0 != 0xf0f5a9c105384d5b79e212a9c9d3adfa5d030ef4c0cf9e22fa48674f9ad3652a::vault_market::oracle<T0, T1>(arg0), 0xf0f5a9c105384d5b79e212a9c9d3adfa5d030ef4c0cf9e22fa48674f9ad3652a::errors::vault_invalid_oracle());
        0xf0f5a9c105384d5b79e212a9c9d3adfa5d030ef4c0cf9e22fa48674f9ad3652a::vault_market::set_oracle<T0, T1>(arg0, v0);
        0xf0f5a9c105384d5b79e212a9c9d3adfa5d030ef4c0cf9e22fa48674f9ad3652a::events::emit_log_update_oracle(v0);
    }

    public fun update_rebalancer<T0, T1>(arg0: &0xf0f5a9c105384d5b79e212a9c9d3adfa5d030ef4c0cf9e22fa48674f9ad3652a::registry::VaultRegistry, arg1: &mut 0xf0f5a9c105384d5b79e212a9c9d3adfa5d030ef4c0cf9e22fa48674f9ad3652a::auth::VaultAdmin, arg2: &0xf0f5a9c105384d5b79e212a9c9d3adfa5d030ef4c0cf9e22fa48674f9ad3652a::vault_market::VaultMarket<T0, T1>, arg3: address, arg4: bool, arg5: &0x2::tx_context::TxContext) {
        0xf0f5a9c105384d5b79e212a9c9d3adfa5d030ef4c0cf9e22fa48674f9ad3652a::auth::assert_authority(arg0, arg1, arg5);
        let v0 = 0x2::object::id<0xf0f5a9c105384d5b79e212a9c9d3adfa5d030ef4c0cf9e22fa48674f9ad3652a::vault_market::VaultMarket<T0, T1>>(arg2);
        if (arg4) {
            if (!0xf0f5a9c105384d5b79e212a9c9d3adfa5d030ef4c0cf9e22fa48674f9ad3652a::auth::get_is_rebalancer(arg1, arg3, v0)) {
                0xf0f5a9c105384d5b79e212a9c9d3adfa5d030ef4c0cf9e22fa48674f9ad3652a::auth::grant_rebalancer(arg1, arg3, v0);
            };
        } else if (0xf0f5a9c105384d5b79e212a9c9d3adfa5d030ef4c0cf9e22fa48674f9ad3652a::auth::get_is_rebalancer(arg1, arg3, v0)) {
            0xf0f5a9c105384d5b79e212a9c9d3adfa5d030ef4c0cf9e22fa48674f9ad3652a::auth::revoke_rebalancer(arg1, arg3, v0);
        };
        0xf0f5a9c105384d5b79e212a9c9d3adfa5d030ef4c0cf9e22fa48674f9ad3652a::events::emit_log_update_rebalancer(v0, arg3, arg4);
    }

    public fun update_supply_rate_magnifier<T0, T1>(arg0: &mut 0xf0f5a9c105384d5b79e212a9c9d3adfa5d030ef4c0cf9e22fa48674f9ad3652a::vault_market::VaultMarket<T0, T1>, arg1: &0xf0f5a9c105384d5b79e212a9c9d3adfa5d030ef4c0cf9e22fa48674f9ad3652a::registry::VaultRegistry, arg2: &0xf0f5a9c105384d5b79e212a9c9d3adfa5d030ef4c0cf9e22fa48674f9ad3652a::auth::VaultAdmin, arg3: &0xd0f7e9baf5bb8c13444fc7abc562103b7632acea5f290ed7ab6bbe6f2191febb::reserve::TokenReserve<T0>, arg4: &0xd0f7e9baf5bb8c13444fc7abc562103b7632acea5f290ed7ab6bbe6f2191febb::reserve::TokenReserve<T1>, arg5: 0xf0f5a9c105384d5b79e212a9c9d3adfa5d030ef4c0cf9e22fa48674f9ad3652a::structs::RateMagnifier, arg6: &0x2::clock::Clock, arg7: &0x2::tx_context::TxContext) {
        0xf0f5a9c105384d5b79e212a9c9d3adfa5d030ef4c0cf9e22fa48674f9ad3652a::auth::assert_auths(arg1, arg2, arg7);
        0xf0f5a9c105384d5b79e212a9c9d3adfa5d030ef4c0cf9e22fa48674f9ad3652a::user::update_exchange_prices<T0, T1>(arg0, arg1, arg3, arg4, arg6);
        0xf0f5a9c105384d5b79e212a9c9d3adfa5d030ef4c0cf9e22fa48674f9ad3652a::vault_market::set_supply_rate_magnifier<T0, T1>(arg0, arg5);
        0xf0f5a9c105384d5b79e212a9c9d3adfa5d030ef4c0cf9e22fa48674f9ad3652a::events::emit_log_update_supply_rate_magnifier(0xf0f5a9c105384d5b79e212a9c9d3adfa5d030ef4c0cf9e22fa48674f9ad3652a::structs::magnifier_magnitude(&arg5), 0xf0f5a9c105384d5b79e212a9c9d3adfa5d030ef4c0cf9e22fa48674f9ad3652a::structs::magnifier_is_negative(&arg5));
    }

    public fun update_withdraw_gap<T0, T1>(arg0: &mut 0xf0f5a9c105384d5b79e212a9c9d3adfa5d030ef4c0cf9e22fa48674f9ad3652a::vault_market::VaultMarket<T0, T1>, arg1: &0xf0f5a9c105384d5b79e212a9c9d3adfa5d030ef4c0cf9e22fa48674f9ad3652a::registry::VaultRegistry, arg2: &0xf0f5a9c105384d5b79e212a9c9d3adfa5d030ef4c0cf9e22fa48674f9ad3652a::auth::VaultAdmin, arg3: &0xd0f7e9baf5bb8c13444fc7abc562103b7632acea5f290ed7ab6bbe6f2191febb::reserve::TokenReserve<T0>, arg4: &0xd0f7e9baf5bb8c13444fc7abc562103b7632acea5f290ed7ab6bbe6f2191febb::reserve::TokenReserve<T1>, arg5: u16, arg6: &0x2::clock::Clock, arg7: &0x2::tx_context::TxContext) {
        0xf0f5a9c105384d5b79e212a9c9d3adfa5d030ef4c0cf9e22fa48674f9ad3652a::auth::assert_auths(arg1, arg2, arg7);
        0xf0f5a9c105384d5b79e212a9c9d3adfa5d030ef4c0cf9e22fa48674f9ad3652a::user::update_exchange_prices<T0, T1>(arg0, arg1, arg3, arg4, arg6);
        0xf0f5a9c105384d5b79e212a9c9d3adfa5d030ef4c0cf9e22fa48674f9ad3652a::vault_market::set_risk_config<T0, T1>(arg0, 0xf0f5a9c105384d5b79e212a9c9d3adfa5d030ef4c0cf9e22fa48674f9ad3652a::risk_config::new(0xf0f5a9c105384d5b79e212a9c9d3adfa5d030ef4c0cf9e22fa48674f9ad3652a::vault_market::collateral_factor<T0, T1>(arg0) * 10, 0xf0f5a9c105384d5b79e212a9c9d3adfa5d030ef4c0cf9e22fa48674f9ad3652a::vault_market::liquidation_threshold<T0, T1>(arg0) * 10, 0xf0f5a9c105384d5b79e212a9c9d3adfa5d030ef4c0cf9e22fa48674f9ad3652a::vault_market::liquidation_max_limit<T0, T1>(arg0) * 10, arg5, 0xf0f5a9c105384d5b79e212a9c9d3adfa5d030ef4c0cf9e22fa48674f9ad3652a::vault_market::liquidation_penalty<T0, T1>(arg0), 0xf0f5a9c105384d5b79e212a9c9d3adfa5d030ef4c0cf9e22fa48674f9ad3652a::vault_market::borrow_fee<T0, T1>(arg0)));
        0xf0f5a9c105384d5b79e212a9c9d3adfa5d030ef4c0cf9e22fa48674f9ad3652a::events::emit_log_update_withdraw_gap(arg5);
    }

    // decompiled from Move bytecode v7
}

