module 0xe13d83dee356238e36e116382e328a490420ecee5bdb44c7620abdb1d28b4589::mm_vault {
    struct BalanceEvent has copy, drop {
        vault: 0x2::object::ID,
        user: address,
        asset_amount: u64,
        lp_amount: u64,
        deposit: bool,
    }

    struct RegistrationEvent has copy, drop {
        vault: 0x2::object::ID,
        user: address,
    }

    struct UserBalanceManager has store {
        balance_manager: 0x2c8d603bc51326b8c13cef9dd07031a408a48dddb541963357661df5d3204809::balance_manager::BalanceManager,
        trade_cap: 0x2c8d603bc51326b8c13cef9dd07031a408a48dddb541963357661df5d3204809::balance_manager::TradeCap,
        deposit_cap: 0x2c8d603bc51326b8c13cef9dd07031a408a48dddb541963357661df5d3204809::balance_manager::DepositCap,
        withdraw_cap: 0x2c8d603bc51326b8c13cef9dd07031a408a48dddb541963357661df5d3204809::balance_manager::WithdrawCap,
    }

    struct Vault<phantom T0> has store, key {
        id: 0x2::object::UID,
        lp_treasury_cap: 0x2::coin::TreasuryCap<T0>,
        user_balance_managers: 0x2::vec_map::VecMap<address, UserBalanceManager>,
    }

    public fun create_vault<T0>(arg0: 0x2::coin::TreasuryCap<T0>, arg1: &mut 0x2::tx_context::TxContext) {
        let v0 = Vault<T0>{
            id                    : 0x2::object::new(arg1),
            lp_treasury_cap       : arg0,
            user_balance_managers : 0x2::vec_map::empty<address, UserBalanceManager>(),
        };
        0x2::transfer::share_object<Vault<T0>>(v0);
    }

    public fun deposit<T0>(arg0: &mut Vault<T0>, arg1: 0x2::coin::Coin<0xdeeb7a4662eec9f2f3def03fb937a663dddaa2e215b8078a284d026b7946c270::deep::DEEP>, arg2: &0x8d97f1cd6ac663735be08d1d2b6d02a159e711586461306ce60a2b7a6a565a9e::price_info::PriceInfoObject, arg3: &0x8d97f1cd6ac663735be08d1d2b6d02a159e711586461306ce60a2b7a6a565a9e::price_info::PriceInfoObject, arg4: &0x8d97f1cd6ac663735be08d1d2b6d02a159e711586461306ce60a2b7a6a565a9e::price_info::PriceInfoObject, arg5: &0x2::clock::Clock, arg6: &mut 0x2::tx_context::TxContext) : 0x2::coin::Coin<T0> {
        let v0 = 0x2::tx_context::sender(arg6);
        let v1 = 0x2::coin::value<0xdeeb7a4662eec9f2f3def03fb937a663dddaa2e215b8078a284d026b7946c270::deep::DEEP>(&arg1);
        assert!(0x2::vec_map::contains<address, UserBalanceManager>(&arg0.user_balance_managers, &v0), 3);
        let v2 = 0x2::vec_map::get_mut<address, UserBalanceManager>(&mut arg0.user_balance_managers, &v0);
        0x2c8d603bc51326b8c13cef9dd07031a408a48dddb541963357661df5d3204809::balance_manager::deposit_with_cap<0xdeeb7a4662eec9f2f3def03fb937a663dddaa2e215b8078a284d026b7946c270::deep::DEEP>(&mut v2.balance_manager, &v2.deposit_cap, arg1, arg6);
        let v3 = 0x2::coin::total_supply<T0>(&arg0.lp_treasury_cap);
        let v4 = if (v3 == 0) {
            (v1 as u256) * get_deep_price(arg3, arg5)
        } else {
            let (v5, _, _, _, _) = get_total_value<T0>(arg0, arg2, arg3, arg4, arg5);
            (v1 as u256) * get_deep_price(arg3, arg5) * (v3 as u256) / v5
        };
        assert!(v4 <= 18446744073709551615, 2);
        let v10 = BalanceEvent{
            vault        : 0x2::object::id<Vault<T0>>(arg0),
            user         : v0,
            asset_amount : v1,
            lp_amount    : (v4 as u64),
            deposit      : true,
        };
        0x2::event::emit<BalanceEvent>(v10);
        0x2::coin::mint<T0>(&mut arg0.lp_treasury_cap, (v4 as u64), arg6)
    }

    public fun get_deep_price(arg0: &0x8d97f1cd6ac663735be08d1d2b6d02a159e711586461306ce60a2b7a6a565a9e::price_info::PriceInfoObject, arg1: &0x2::clock::Clock) : u256 {
        let v0 = 0x8d97f1cd6ac663735be08d1d2b6d02a159e711586461306ce60a2b7a6a565a9e::pyth::get_price_no_older_than(arg0, arg1, 60);
        let v1 = 0x8d97f1cd6ac663735be08d1d2b6d02a159e711586461306ce60a2b7a6a565a9e::price_info::get_price_info_from_price_info_object(arg0);
        let v2 = 0x8d97f1cd6ac663735be08d1d2b6d02a159e711586461306ce60a2b7a6a565a9e::price_info::get_price_identifier(&v1);
        assert!(0x8d97f1cd6ac663735be08d1d2b6d02a159e711586461306ce60a2b7a6a565a9e::price_identifier::get_bytes(&v2) == x"29bdd5248234e33bd93d3b81100b5fa32eaa5997843847e2c2cb16d7c6d9f7ff", 0);
        let v3 = 0x8d97f1cd6ac663735be08d1d2b6d02a159e711586461306ce60a2b7a6a565a9e::price::get_price(&v0);
        let v4 = 0x8d97f1cd6ac663735be08d1d2b6d02a159e711586461306ce60a2b7a6a565a9e::price::get_expo(&v0);
        normalize_price(&v3, &v4)
    }

    public fun get_sui_price(arg0: &0x8d97f1cd6ac663735be08d1d2b6d02a159e711586461306ce60a2b7a6a565a9e::price_info::PriceInfoObject, arg1: &0x2::clock::Clock) : u256 {
        let v0 = 0x8d97f1cd6ac663735be08d1d2b6d02a159e711586461306ce60a2b7a6a565a9e::pyth::get_price_no_older_than(arg0, arg1, 60);
        let v1 = 0x8d97f1cd6ac663735be08d1d2b6d02a159e711586461306ce60a2b7a6a565a9e::price_info::get_price_info_from_price_info_object(arg0);
        let v2 = 0x8d97f1cd6ac663735be08d1d2b6d02a159e711586461306ce60a2b7a6a565a9e::price_info::get_price_identifier(&v1);
        assert!(0x8d97f1cd6ac663735be08d1d2b6d02a159e711586461306ce60a2b7a6a565a9e::price_identifier::get_bytes(&v2) == x"23d7315113f5b1d3ba7a83604c44b94d79f4fd69af77f804fc7f920a6dc65744", 0);
        let v3 = 0x8d97f1cd6ac663735be08d1d2b6d02a159e711586461306ce60a2b7a6a565a9e::price::get_price(&v0);
        let v4 = 0x8d97f1cd6ac663735be08d1d2b6d02a159e711586461306ce60a2b7a6a565a9e::price::get_expo(&v0);
        normalize_price(&v3, &v4)
    }

    public fun get_total_value<T0>(arg0: &Vault<T0>, arg1: &0x8d97f1cd6ac663735be08d1d2b6d02a159e711586461306ce60a2b7a6a565a9e::price_info::PriceInfoObject, arg2: &0x8d97f1cd6ac663735be08d1d2b6d02a159e711586461306ce60a2b7a6a565a9e::price_info::PriceInfoObject, arg3: &0x8d97f1cd6ac663735be08d1d2b6d02a159e711586461306ce60a2b7a6a565a9e::price_info::PriceInfoObject, arg4: &0x2::clock::Clock) : (u256, u256, u256, u256, u64) {
        let v0 = 0;
        let v1 = 0;
        let v2 = 0;
        let v3 = 0;
        let v4 = 0x2::vec_map::keys<address, UserBalanceManager>(&arg0.user_balance_managers);
        while (v3 < 0x1::vector::length<address>(&v4)) {
            let v5 = *0x1::vector::borrow<address>(&v4, v3);
            let v6 = 0x2::vec_map::get<address, UserBalanceManager>(&arg0.user_balance_managers, &v5);
            v0 = v0 + (0x2c8d603bc51326b8c13cef9dd07031a408a48dddb541963357661df5d3204809::balance_manager::balance<0xdba34672e30cb065b1f93e3ab55318768fd6fef66c15942c9f7cb846e2f900e7::usdc::USDC>(&v6.balance_manager) as u256) * get_usdc_price(arg3, arg4);
            v1 = v1 + (0x2c8d603bc51326b8c13cef9dd07031a408a48dddb541963357661df5d3204809::balance_manager::balance<0x2::sui::SUI>(&v6.balance_manager) as u256) * get_sui_price(arg1, arg4);
            v2 = v2 + (0x2c8d603bc51326b8c13cef9dd07031a408a48dddb541963357661df5d3204809::balance_manager::balance<0xdeeb7a4662eec9f2f3def03fb937a663dddaa2e215b8078a284d026b7946c270::deep::DEEP>(&v6.balance_manager) as u256) * get_deep_price(arg2, arg4);
            v3 = v3 + 1;
        };
        (v0 + v1 + v2, v0, v1, v2, 1)
    }

    public fun get_usdc_price(arg0: &0x8d97f1cd6ac663735be08d1d2b6d02a159e711586461306ce60a2b7a6a565a9e::price_info::PriceInfoObject, arg1: &0x2::clock::Clock) : u256 {
        let v0 = 0x8d97f1cd6ac663735be08d1d2b6d02a159e711586461306ce60a2b7a6a565a9e::pyth::get_price_no_older_than(arg0, arg1, 60);
        let v1 = 0x8d97f1cd6ac663735be08d1d2b6d02a159e711586461306ce60a2b7a6a565a9e::price_info::get_price_info_from_price_info_object(arg0);
        let v2 = 0x8d97f1cd6ac663735be08d1d2b6d02a159e711586461306ce60a2b7a6a565a9e::price_info::get_price_identifier(&v1);
        assert!(0x8d97f1cd6ac663735be08d1d2b6d02a159e711586461306ce60a2b7a6a565a9e::price_identifier::get_bytes(&v2) == x"eaa020c61cc479712813461ce153894a96a6c00b21ed0cfc2798d1f9a9e9c94a", 0);
        let v3 = 0x8d97f1cd6ac663735be08d1d2b6d02a159e711586461306ce60a2b7a6a565a9e::price::get_price(&v0);
        let v4 = 0x8d97f1cd6ac663735be08d1d2b6d02a159e711586461306ce60a2b7a6a565a9e::price::get_expo(&v0);
        normalize_price(&v3, &v4)
    }

    public fun get_user_balance_manager<T0>(arg0: &mut Vault<T0>, arg1: address) : &mut 0x2c8d603bc51326b8c13cef9dd07031a408a48dddb541963357661df5d3204809::balance_manager::BalanceManager {
        assert!(0x2::vec_map::contains<address, UserBalanceManager>(&arg0.user_balance_managers, &arg1), 3);
        &mut 0x2::vec_map::get_mut<address, UserBalanceManager>(&mut arg0.user_balance_managers, &arg1).balance_manager
    }

    public fun get_user_trade_cap<T0>(arg0: &mut Vault<T0>, arg1: address) : &mut 0x2c8d603bc51326b8c13cef9dd07031a408a48dddb541963357661df5d3204809::balance_manager::TradeCap {
        assert!(0x2::vec_map::contains<address, UserBalanceManager>(&arg0.user_balance_managers, &arg1), 3);
        &mut 0x2::vec_map::get_mut<address, UserBalanceManager>(&mut arg0.user_balance_managers, &arg1).trade_cap
    }

    public fun get_vault_balance<T0, T1>(arg0: &Vault<T0>) : u64 {
        let v0 = 0;
        let v1 = 0;
        let v2 = 0x2::vec_map::keys<address, UserBalanceManager>(&arg0.user_balance_managers);
        while (v1 < 0x1::vector::length<address>(&v2)) {
            let v3 = *0x1::vector::borrow<address>(&v2, v1);
            v0 = v0 + 0x2c8d603bc51326b8c13cef9dd07031a408a48dddb541963357661df5d3204809::balance_manager::balance<T1>(&0x2::vec_map::get<address, UserBalanceManager>(&arg0.user_balance_managers, &v3).balance_manager);
            v1 = v1 + 1;
        };
        v0
    }

    public fun is_user_registered<T0>(arg0: &Vault<T0>, arg1: address) : bool {
        0x2::vec_map::contains<address, UserBalanceManager>(&arg0.user_balance_managers, &arg1)
    }

    fun normalize_price(arg0: &0x8d97f1cd6ac663735be08d1d2b6d02a159e711586461306ce60a2b7a6a565a9e::i64::I64, arg1: &0x8d97f1cd6ac663735be08d1d2b6d02a159e711586461306ce60a2b7a6a565a9e::i64::I64) : u256 {
        let v0 = 0x8d97f1cd6ac663735be08d1d2b6d02a159e711586461306ce60a2b7a6a565a9e::i64::get_magnitude_if_negative(arg1);
        if (v0 < 1) {
            (0x8d97f1cd6ac663735be08d1d2b6d02a159e711586461306ce60a2b7a6a565a9e::i64::get_magnitude_if_positive(arg0) as u256) / (0x1::u64::pow(10, ((1 - v0) as u8)) as u256)
        } else {
            (0x8d97f1cd6ac663735be08d1d2b6d02a159e711586461306ce60a2b7a6a565a9e::i64::get_magnitude_if_positive(arg0) as u256) * (0x1::u64::pow(10, ((v0 - 1) as u8)) as u256)
        }
    }

    public fun take_bm<T0>(arg0: &mut Vault<T0>, arg1: 0x2c8d603bc51326b8c13cef9dd07031a408a48dddb541963357661df5d3204809::balance_manager::BalanceManager, arg2: 0x2c8d603bc51326b8c13cef9dd07031a408a48dddb541963357661df5d3204809::balance_manager::TradeCap, arg3: 0x2c8d603bc51326b8c13cef9dd07031a408a48dddb541963357661df5d3204809::balance_manager::DepositCap, arg4: 0x2c8d603bc51326b8c13cef9dd07031a408a48dddb541963357661df5d3204809::balance_manager::WithdrawCap, arg5: &mut 0x2::tx_context::TxContext) {
        let v0 = 0x2::tx_context::sender(arg5);
        let v1 = UserBalanceManager{
            balance_manager : arg1,
            trade_cap       : arg2,
            deposit_cap     : arg3,
            withdraw_cap    : arg4,
        };
        0x2::vec_map::insert<address, UserBalanceManager>(&mut arg0.user_balance_managers, v0, v1);
        let v2 = RegistrationEvent{
            vault : 0x2::object::id<Vault<T0>>(arg0),
            user  : v0,
        };
        0x2::event::emit<RegistrationEvent>(v2);
    }

    public fun withdraw<T0>(arg0: &mut Vault<T0>, arg1: 0x2::coin::Coin<T0>, arg2: &0x8d97f1cd6ac663735be08d1d2b6d02a159e711586461306ce60a2b7a6a565a9e::price_info::PriceInfoObject, arg3: &0x8d97f1cd6ac663735be08d1d2b6d02a159e711586461306ce60a2b7a6a565a9e::price_info::PriceInfoObject, arg4: &0x8d97f1cd6ac663735be08d1d2b6d02a159e711586461306ce60a2b7a6a565a9e::price_info::PriceInfoObject, arg5: &0x2::clock::Clock, arg6: &mut 0x2::tx_context::TxContext) : 0x2::coin::Coin<0xdeeb7a4662eec9f2f3def03fb937a663dddaa2e215b8078a284d026b7946c270::deep::DEEP> {
        let v0 = 0x2::tx_context::sender(arg6);
        let v1 = 0x2::coin::value<T0>(&arg1);
        assert!(0x2::vec_map::contains<address, UserBalanceManager>(&arg0.user_balance_managers, &v0), 3);
        let (v2, _, _, _, _) = get_total_value<T0>(arg0, arg2, arg3, arg4, arg5);
        let v7 = (v1 as u256) * v2 / (0x2::coin::total_supply<T0>(&arg0.lp_treasury_cap) as u256) / get_deep_price(arg3, arg5);
        assert!(v7 <= 18446744073709551615, 1);
        let v8 = 0x2::vec_map::get_mut<address, UserBalanceManager>(&mut arg0.user_balance_managers, &v0);
        let v9 = 0x2c8d603bc51326b8c13cef9dd07031a408a48dddb541963357661df5d3204809::balance_manager::withdraw_with_cap<0xdeeb7a4662eec9f2f3def03fb937a663dddaa2e215b8078a284d026b7946c270::deep::DEEP>(&mut v8.balance_manager, &v8.withdraw_cap, (v7 as u64), arg6);
        0x2::coin::burn<T0>(&mut arg0.lp_treasury_cap, arg1);
        let v10 = BalanceEvent{
            vault        : 0x2::object::id<Vault<T0>>(arg0),
            user         : v0,
            asset_amount : 0x2::coin::value<0xdeeb7a4662eec9f2f3def03fb937a663dddaa2e215b8078a284d026b7946c270::deep::DEEP>(&v9),
            lp_amount    : v1,
            deposit      : false,
        };
        0x2::event::emit<BalanceEvent>(v10);
        v9
    }

    // decompiled from Move bytecode v6
}

