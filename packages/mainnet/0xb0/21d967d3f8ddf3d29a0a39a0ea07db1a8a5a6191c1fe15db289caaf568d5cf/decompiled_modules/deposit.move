module 0xb021d967d3f8ddf3d29a0a39a0ea07db1a8a5a6191c1fe15db289caaf568d5cf::deposit {
    struct QuoteBalanceKey<phantom T0> has copy, drop, store {
        dummy_field: bool,
    }

    public fun check_and_convert<T0>(arg0: &mut 0xb021d967d3f8ddf3d29a0a39a0ea07db1a8a5a6191c1fe15db289caaf568d5cf::launch::VaultLaunch, arg1: &0x2::clock::Clock, arg2: &mut 0x2::tx_context::TxContext) {
        if (!0xb021d967d3f8ddf3d29a0a39a0ea07db1a8a5a6191c1fe15db289caaf568d5cf::launch::is_funding(arg0)) {
            return
        };
        let v0 = 0xb021d967d3f8ddf3d29a0a39a0ea07db1a8a5a6191c1fe15db289caaf568d5cf::launch::creator(arg0);
        let v1 = 0x2::clock::timestamp_ms(arg1);
        let v2 = 0xb021d967d3f8ddf3d29a0a39a0ea07db1a8a5a6191c1fe15db289caaf568d5cf::config::bps_denominator();
        let v3 = QuoteBalanceKey<T0>{dummy_field: false};
        let v4 = 0xb021d967d3f8ddf3d29a0a39a0ea07db1a8a5a6191c1fe15db289caaf568d5cf::launch::uid(arg0);
        if (!0x2::dynamic_field::exists_<QuoteBalanceKey<T0>>(v4, v3)) {
            return
        };
        if (0x2::balance::value<T0>(0x2::dynamic_field::borrow<QuoteBalanceKey<T0>, 0x2::balance::Balance<T0>>(v4, v3)) < 0xb021d967d3f8ddf3d29a0a39a0ea07db1a8a5a6191c1fe15db289caaf568d5cf::launch::goal_amount(arg0)) {
            return
        };
        let v5 = 0x2::balance::value<T0>(0x2::dynamic_field::borrow<QuoteBalanceKey<T0>, 0x2::balance::Balance<T0>>(0xb021d967d3f8ddf3d29a0a39a0ea07db1a8a5a6191c1fe15db289caaf568d5cf::launch::uid(arg0), v3));
        let v6 = (((v5 as u128) * (0xb021d967d3f8ddf3d29a0a39a0ea07db1a8a5a6191c1fe15db289caaf568d5cf::config::platform_fee_bps() as u128) / (v2 as u128)) as u64);
        let v7 = (((v5 as u128) * (0xb021d967d3f8ddf3d29a0a39a0ea07db1a8a5a6191c1fe15db289caaf568d5cf::config::creator_fee_bps() as u128) / (v2 as u128)) as u64);
        let v8 = 0x2::dynamic_field::remove<QuoteBalanceKey<T0>, 0x2::balance::Balance<T0>>(0xb021d967d3f8ddf3d29a0a39a0ea07db1a8a5a6191c1fe15db289caaf568d5cf::launch::uid_mut(arg0), v3);
        let v9 = QuoteBalanceKey<T0>{dummy_field: false};
        0x2::dynamic_field::add<QuoteBalanceKey<T0>, 0x2::balance::Balance<T0>>(0xb021d967d3f8ddf3d29a0a39a0ea07db1a8a5a6191c1fe15db289caaf568d5cf::launch::uid_mut(arg0), v9, v8);
        0xb021d967d3f8ddf3d29a0a39a0ea07db1a8a5a6191c1fe15db289caaf568d5cf::launch::set_converted(arg0, v6, v7, v1);
        0x2::transfer::public_transfer<0x2::coin::Coin<T0>>(0x2::coin::from_balance<T0>(0x2::balance::split<T0>(&mut v8, v6), arg2), v0);
        0x2::transfer::public_transfer<0x2::coin::Coin<T0>>(0x2::coin::from_balance<T0>(0x2::balance::split<T0>(&mut v8, v7), arg2), v0);
        0xb021d967d3f8ddf3d29a0a39a0ea07db1a8a5a6191c1fe15db289caaf568d5cf::events::emit_vault_converted(0xb021d967d3f8ddf3d29a0a39a0ea07db1a8a5a6191c1fe15db289caaf568d5cf::launch::id(arg0), v5, v6, v7, v5 - v6 - v7, v1);
    }

    public fun check_and_convert_with_config<T0>(arg0: &mut 0xb021d967d3f8ddf3d29a0a39a0ea07db1a8a5a6191c1fe15db289caaf568d5cf::launch::VaultLaunch, arg1: &0xb021d967d3f8ddf3d29a0a39a0ea07db1a8a5a6191c1fe15db289caaf568d5cf::config::GlobalConfig, arg2: &0x2::clock::Clock, arg3: &mut 0x2::tx_context::TxContext) {
        if (!0xb021d967d3f8ddf3d29a0a39a0ea07db1a8a5a6191c1fe15db289caaf568d5cf::launch::is_funding(arg0)) {
            return
        };
        let v0 = 0x2::clock::timestamp_ms(arg2);
        let v1 = 0xb021d967d3f8ddf3d29a0a39a0ea07db1a8a5a6191c1fe15db289caaf568d5cf::config::bps_denominator();
        let v2 = QuoteBalanceKey<T0>{dummy_field: false};
        let v3 = 0xb021d967d3f8ddf3d29a0a39a0ea07db1a8a5a6191c1fe15db289caaf568d5cf::launch::uid(arg0);
        if (!0x2::dynamic_field::exists_<QuoteBalanceKey<T0>>(v3, v2)) {
            return
        };
        if (0x2::balance::value<T0>(0x2::dynamic_field::borrow<QuoteBalanceKey<T0>, 0x2::balance::Balance<T0>>(v3, v2)) < 0xb021d967d3f8ddf3d29a0a39a0ea07db1a8a5a6191c1fe15db289caaf568d5cf::launch::goal_amount(arg0)) {
            return
        };
        let v4 = 0x2::balance::value<T0>(0x2::dynamic_field::borrow<QuoteBalanceKey<T0>, 0x2::balance::Balance<T0>>(0xb021d967d3f8ddf3d29a0a39a0ea07db1a8a5a6191c1fe15db289caaf568d5cf::launch::uid(arg0), v2));
        let v5 = (((v4 as u128) * (0xb021d967d3f8ddf3d29a0a39a0ea07db1a8a5a6191c1fe15db289caaf568d5cf::config::platform_fee_bps() as u128) / (v1 as u128)) as u64);
        let v6 = (((v4 as u128) * (0xb021d967d3f8ddf3d29a0a39a0ea07db1a8a5a6191c1fe15db289caaf568d5cf::config::creator_fee_bps() as u128) / (v1 as u128)) as u64);
        let v7 = 0x2::dynamic_field::remove<QuoteBalanceKey<T0>, 0x2::balance::Balance<T0>>(0xb021d967d3f8ddf3d29a0a39a0ea07db1a8a5a6191c1fe15db289caaf568d5cf::launch::uid_mut(arg0), v2);
        let v8 = QuoteBalanceKey<T0>{dummy_field: false};
        0x2::dynamic_field::add<QuoteBalanceKey<T0>, 0x2::balance::Balance<T0>>(0xb021d967d3f8ddf3d29a0a39a0ea07db1a8a5a6191c1fe15db289caaf568d5cf::launch::uid_mut(arg0), v8, v7);
        0xb021d967d3f8ddf3d29a0a39a0ea07db1a8a5a6191c1fe15db289caaf568d5cf::launch::set_converted(arg0, v5, v6, v0);
        0x2::transfer::public_transfer<0x2::coin::Coin<T0>>(0x2::coin::from_balance<T0>(0x2::balance::split<T0>(&mut v7, v5), arg3), 0xb021d967d3f8ddf3d29a0a39a0ea07db1a8a5a6191c1fe15db289caaf568d5cf::config::platform_treasury(arg1));
        0x2::transfer::public_transfer<0x2::coin::Coin<T0>>(0x2::coin::from_balance<T0>(0x2::balance::split<T0>(&mut v7, v6), arg3), 0xb021d967d3f8ddf3d29a0a39a0ea07db1a8a5a6191c1fe15db289caaf568d5cf::launch::creator(arg0));
        0xb021d967d3f8ddf3d29a0a39a0ea07db1a8a5a6191c1fe15db289caaf568d5cf::events::emit_vault_converted(0xb021d967d3f8ddf3d29a0a39a0ea07db1a8a5a6191c1fe15db289caaf568d5cf::launch::id(arg0), v4, v5, v6, v4 - v5 - v6, v0);
    }

    public entry fun collect_liquidity_quote<T0>(arg0: &mut 0xb021d967d3f8ddf3d29a0a39a0ea07db1a8a5a6191c1fe15db289caaf568d5cf::launch::VaultLaunch, arg1: &0xb021d967d3f8ddf3d29a0a39a0ea07db1a8a5a6191c1fe15db289caaf568d5cf::launch::LaunchCap, arg2: &mut 0x2::tx_context::TxContext) {
        assert!(0xb021d967d3f8ddf3d29a0a39a0ea07db1a8a5a6191c1fe15db289caaf568d5cf::launch::is_live(arg0), 0);
        assert!(0xb021d967d3f8ddf3d29a0a39a0ea07db1a8a5a6191c1fe15db289caaf568d5cf::launch::cap_launch_id(arg1) == 0xb021d967d3f8ddf3d29a0a39a0ea07db1a8a5a6191c1fe15db289caaf568d5cf::launch::id(arg0), 2);
        let v0 = QuoteBalanceKey<T0>{dummy_field: false};
        0x2::transfer::public_transfer<0x2::coin::Coin<T0>>(0x2::coin::from_balance<T0>(0x2::dynamic_field::remove<QuoteBalanceKey<T0>, 0x2::balance::Balance<T0>>(0xb021d967d3f8ddf3d29a0a39a0ea07db1a8a5a6191c1fe15db289caaf568d5cf::launch::uid_mut(arg0), v0), arg2), 0xb021d967d3f8ddf3d29a0a39a0ea07db1a8a5a6191c1fe15db289caaf568d5cf::launch::creator(arg0));
    }

    public fun deposit_quote<T0>(arg0: &mut 0x2::object::UID, arg1: 0x2::coin::Coin<T0>) {
        let v0 = QuoteBalanceKey<T0>{dummy_field: false};
        if (0x2::dynamic_field::exists_<QuoteBalanceKey<T0>>(arg0, v0)) {
            0x2::balance::join<T0>(0x2::dynamic_field::borrow_mut<QuoteBalanceKey<T0>, 0x2::balance::Balance<T0>>(arg0, v0), 0x2::coin::into_balance<T0>(arg1));
        } else {
            0x2::dynamic_field::add<QuoteBalanceKey<T0>, 0x2::balance::Balance<T0>>(arg0, v0, 0x2::coin::into_balance<T0>(arg1));
        };
    }

    public fun quote_balance_value<T0>(arg0: &0xb021d967d3f8ddf3d29a0a39a0ea07db1a8a5a6191c1fe15db289caaf568d5cf::launch::VaultLaunch) : u64 {
        let v0 = 0xb021d967d3f8ddf3d29a0a39a0ea07db1a8a5a6191c1fe15db289caaf568d5cf::launch::uid(arg0);
        let v1 = QuoteBalanceKey<T0>{dummy_field: false};
        if (!0x2::dynamic_field::exists_<QuoteBalanceKey<T0>>(v0, v1)) {
            return 0
        };
        0x2::balance::value<T0>(0x2::dynamic_field::borrow<QuoteBalanceKey<T0>, 0x2::balance::Balance<T0>>(v0, v1))
    }

    // decompiled from Move bytecode v7
}

