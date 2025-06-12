module 0xb8953bff9aef52fab485c5565b11b8cdf5468bfbaae384d3ff4cc7c1fc309746::mm_vault {
    struct BalanceEvent has copy, drop {
        vault: 0x2::object::ID,
        user: address,
        base_asset_amount: u64,
        quote_asset_amount: u64,
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

    struct Vault<phantom T0, phantom T1, phantom T2> has store, key {
        id: 0x2::object::UID,
        lp_treasury_cap: 0x2::coin::TreasuryCap<T2>,
        user_balance_managers: 0x2::vec_map::VecMap<address, UserBalanceManager>,
        base_price_id: vector<u8>,
        quote_price_id: vector<u8>,
    }

    public fun get_price(arg0: vector<u8>, arg1: &0x8d97f1cd6ac663735be08d1d2b6d02a159e711586461306ce60a2b7a6a565a9e::price_info::PriceInfoObject, arg2: &0x2::clock::Clock) : (0x8d97f1cd6ac663735be08d1d2b6d02a159e711586461306ce60a2b7a6a565a9e::i64::I64, 0x8d97f1cd6ac663735be08d1d2b6d02a159e711586461306ce60a2b7a6a565a9e::i64::I64) {
        let v0 = 0x8d97f1cd6ac663735be08d1d2b6d02a159e711586461306ce60a2b7a6a565a9e::pyth::get_price_no_older_than(arg1, arg2, 60);
        let v1 = 0x8d97f1cd6ac663735be08d1d2b6d02a159e711586461306ce60a2b7a6a565a9e::price_info::get_price_info_from_price_info_object(arg1);
        let v2 = 0x8d97f1cd6ac663735be08d1d2b6d02a159e711586461306ce60a2b7a6a565a9e::price_info::get_price_identifier(&v1);
        assert!(0x8d97f1cd6ac663735be08d1d2b6d02a159e711586461306ce60a2b7a6a565a9e::price_identifier::get_bytes(&v2) == arg0, 0);
        (0x8d97f1cd6ac663735be08d1d2b6d02a159e711586461306ce60a2b7a6a565a9e::price::get_price(&v0), 0x8d97f1cd6ac663735be08d1d2b6d02a159e711586461306ce60a2b7a6a565a9e::price::get_expo(&v0))
    }

    public fun create_vault<T0, T1, T2>(arg0: 0x2::coin::TreasuryCap<T2>, arg1: vector<u8>, arg2: vector<u8>, arg3: &mut 0x2::tx_context::TxContext) {
        let v0 = Vault<T0, T1, T2>{
            id                    : 0x2::object::new(arg3),
            lp_treasury_cap       : arg0,
            user_balance_managers : 0x2::vec_map::empty<address, UserBalanceManager>(),
            base_price_id         : arg1,
            quote_price_id        : arg2,
        };
        0x2::transfer::share_object<Vault<T0, T1, T2>>(v0);
    }

    public fun deposit<T0, T1, T2>(arg0: &mut Vault<T0, T1, T2>, arg1: 0x2::coin::Coin<T0>, arg2: 0x2::coin::Coin<T1>, arg3: &0x8d97f1cd6ac663735be08d1d2b6d02a159e711586461306ce60a2b7a6a565a9e::price_info::PriceInfoObject, arg4: &0x8d97f1cd6ac663735be08d1d2b6d02a159e711586461306ce60a2b7a6a565a9e::price_info::PriceInfoObject, arg5: &0x2::clock::Clock, arg6: &mut 0x2::tx_context::TxContext) : 0x2::coin::Coin<T2> {
        let v0 = 0x2::tx_context::sender(arg6);
        assert!(0x2::vec_map::contains<address, UserBalanceManager>(&arg0.user_balance_managers, &v0), 3);
        let v1 = 0x2::coin::value<T0>(&arg1);
        let v2 = 0x2::coin::value<T1>(&arg2);
        let (v3, v4) = get_price(arg0.base_price_id, arg3, arg5);
        let v5 = v4;
        let v6 = v3;
        let (v7, v8) = get_price(arg0.quote_price_id, arg4, arg5);
        let v9 = v8;
        let v10 = v7;
        let v11 = 0x2::vec_map::get_mut<address, UserBalanceManager>(&mut arg0.user_balance_managers, &v0);
        0x2c8d603bc51326b8c13cef9dd07031a408a48dddb541963357661df5d3204809::balance_manager::deposit_with_cap<T0>(&mut v11.balance_manager, &v11.deposit_cap, arg1, arg6);
        0x2c8d603bc51326b8c13cef9dd07031a408a48dddb541963357661df5d3204809::balance_manager::deposit_with_cap<T1>(&mut v11.balance_manager, &v11.deposit_cap, arg2, arg6);
        let v12 = 0x2::coin::total_supply<T2>(&arg0.lp_treasury_cap);
        let v13 = if (v12 == 0) {
            (v1 as u256) * normalize_price(&v6, &v5) + (v2 as u256) * normalize_price(&v10, &v9)
        } else {
            ((v1 as u256) * normalize_price(&v6, &v5) + (v2 as u256) * normalize_price(&v10, &v9)) * (v12 as u256) / get_total_value<T0, T1, T2>(arg0, arg3, arg4, arg5)
        };
        assert!(v13 <= 18446744073709551615, 2);
        let v14 = BalanceEvent{
            vault              : 0x2::object::id<Vault<T0, T1, T2>>(arg0),
            user               : v0,
            base_asset_amount  : v1,
            quote_asset_amount : v2,
            lp_amount          : (v13 as u64),
            deposit            : true,
        };
        0x2::event::emit<BalanceEvent>(v14);
        0x2::coin::mint<T2>(&mut arg0.lp_treasury_cap, (v13 as u64), arg6)
    }

    public fun get_total_value<T0, T1, T2>(arg0: &Vault<T0, T1, T2>, arg1: &0x8d97f1cd6ac663735be08d1d2b6d02a159e711586461306ce60a2b7a6a565a9e::price_info::PriceInfoObject, arg2: &0x8d97f1cd6ac663735be08d1d2b6d02a159e711586461306ce60a2b7a6a565a9e::price_info::PriceInfoObject, arg3: &0x2::clock::Clock) : u256 {
        let (v0, v1) = get_price(arg0.base_price_id, arg1, arg3);
        let v2 = v1;
        let v3 = v0;
        let (v4, v5) = get_price(arg0.quote_price_id, arg2, arg3);
        let v6 = v5;
        let v7 = v4;
        let v8 = 0;
        let v9 = 0;
        let v10 = 0x2::vec_map::keys<address, UserBalanceManager>(&arg0.user_balance_managers);
        while (v9 < 0x1::vector::length<address>(&v10)) {
            let v11 = *0x1::vector::borrow<address>(&v10, v9);
            let v12 = 0x2::vec_map::get<address, UserBalanceManager>(&arg0.user_balance_managers, &v11);
            let v13 = v8 + (0x2c8d603bc51326b8c13cef9dd07031a408a48dddb541963357661df5d3204809::balance_manager::balance<T0>(&v12.balance_manager) as u256) * normalize_price(&v3, &v2);
            v8 = v13 + (0x2c8d603bc51326b8c13cef9dd07031a408a48dddb541963357661df5d3204809::balance_manager::balance<T1>(&v12.balance_manager) as u256) * normalize_price(&v7, &v6);
            v9 = v9 + 1;
        };
        v8
    }

    public fun get_user_balance_manager<T0, T1, T2>(arg0: &mut Vault<T0, T1, T2>, arg1: address) : &mut 0x2c8d603bc51326b8c13cef9dd07031a408a48dddb541963357661df5d3204809::balance_manager::BalanceManager {
        assert!(0x2::vec_map::contains<address, UserBalanceManager>(&arg0.user_balance_managers, &arg1), 3);
        &mut 0x2::vec_map::get_mut<address, UserBalanceManager>(&mut arg0.user_balance_managers, &arg1).balance_manager
    }

    public fun get_user_trade_cap<T0, T1, T2>(arg0: &mut Vault<T0, T1, T2>, arg1: address) : &mut 0x2c8d603bc51326b8c13cef9dd07031a408a48dddb541963357661df5d3204809::balance_manager::TradeCap {
        assert!(0x2::vec_map::contains<address, UserBalanceManager>(&arg0.user_balance_managers, &arg1), 3);
        &mut 0x2::vec_map::get_mut<address, UserBalanceManager>(&mut arg0.user_balance_managers, &arg1).trade_cap
    }

    public fun get_vault_balance<T0, T1, T2>(arg0: &Vault<T0, T1, T2>) : (u64, u64) {
        let v0 = 0;
        let v1 = 0;
        let v2 = 0;
        let v3 = 0x2::vec_map::keys<address, UserBalanceManager>(&arg0.user_balance_managers);
        while (v2 < 0x1::vector::length<address>(&v3)) {
            let v4 = *0x1::vector::borrow<address>(&v3, v2);
            let v5 = 0x2::vec_map::get<address, UserBalanceManager>(&arg0.user_balance_managers, &v4);
            v0 = v0 + 0x2c8d603bc51326b8c13cef9dd07031a408a48dddb541963357661df5d3204809::balance_manager::balance<T0>(&v5.balance_manager);
            v1 = v1 + 0x2c8d603bc51326b8c13cef9dd07031a408a48dddb541963357661df5d3204809::balance_manager::balance<T1>(&v5.balance_manager);
            v2 = v2 + 1;
        };
        (v0, v1)
    }

    public fun is_user_registered<T0, T1, T2>(arg0: &Vault<T0, T1, T2>, arg1: address) : bool {
        0x2::vec_map::contains<address, UserBalanceManager>(&arg0.user_balance_managers, &arg1)
    }

    fun normalize_price(arg0: &0x8d97f1cd6ac663735be08d1d2b6d02a159e711586461306ce60a2b7a6a565a9e::i64::I64, arg1: &0x8d97f1cd6ac663735be08d1d2b6d02a159e711586461306ce60a2b7a6a565a9e::i64::I64) : u256 {
        let v0 = if (0x8d97f1cd6ac663735be08d1d2b6d02a159e711586461306ce60a2b7a6a565a9e::i64::get_is_negative(arg0)) {
            0x8d97f1cd6ac663735be08d1d2b6d02a159e711586461306ce60a2b7a6a565a9e::i64::get_magnitude_if_negative(arg0)
        } else {
            0x8d97f1cd6ac663735be08d1d2b6d02a159e711586461306ce60a2b7a6a565a9e::i64::get_magnitude_if_positive(arg0)
        };
        let v1 = if (0x8d97f1cd6ac663735be08d1d2b6d02a159e711586461306ce60a2b7a6a565a9e::i64::get_is_negative(arg1)) {
            0x8d97f1cd6ac663735be08d1d2b6d02a159e711586461306ce60a2b7a6a565a9e::i64::get_magnitude_if_negative(arg1)
        } else {
            0x8d97f1cd6ac663735be08d1d2b6d02a159e711586461306ce60a2b7a6a565a9e::i64::get_magnitude_if_positive(arg1)
        };
        let v2 = 8;
        if (0x8d97f1cd6ac663735be08d1d2b6d02a159e711586461306ce60a2b7a6a565a9e::i64::get_is_negative(arg1)) {
            if (v1 >= v2) {
                (v0 as u256) * (100000000 as u256) / (0x1::u64::pow(10, ((v1 - v2) as u8)) as u256)
            } else {
                (v0 as u256) * (100000000 as u256) * (0x1::u64::pow(10, ((v2 - v1) as u8)) as u256)
            }
        } else {
            (v0 as u256) * (0x1::u64::pow(10, ((v1 + v2) as u8)) as u256)
        }
    }

    public fun take_bm<T0, T1, T2>(arg0: &mut Vault<T0, T1, T2>, arg1: 0x2c8d603bc51326b8c13cef9dd07031a408a48dddb541963357661df5d3204809::balance_manager::BalanceManager, arg2: 0x2c8d603bc51326b8c13cef9dd07031a408a48dddb541963357661df5d3204809::balance_manager::TradeCap, arg3: 0x2c8d603bc51326b8c13cef9dd07031a408a48dddb541963357661df5d3204809::balance_manager::DepositCap, arg4: 0x2c8d603bc51326b8c13cef9dd07031a408a48dddb541963357661df5d3204809::balance_manager::WithdrawCap, arg5: &mut 0x2::tx_context::TxContext) {
        let v0 = 0x2::tx_context::sender(arg5);
        let v1 = UserBalanceManager{
            balance_manager : arg1,
            trade_cap       : arg2,
            deposit_cap     : arg3,
            withdraw_cap    : arg4,
        };
        0x2::vec_map::insert<address, UserBalanceManager>(&mut arg0.user_balance_managers, v0, v1);
        let v2 = RegistrationEvent{
            vault : 0x2::object::id<Vault<T0, T1, T2>>(arg0),
            user  : v0,
        };
        0x2::event::emit<RegistrationEvent>(v2);
    }

    public fun withdraw<T0, T1, T2>(arg0: &mut Vault<T0, T1, T2>, arg1: 0x2::coin::Coin<T2>, arg2: &mut 0x2::tx_context::TxContext) : (0x2::coin::Coin<T0>, 0x2::coin::Coin<T1>) {
        let v0 = 0x2::tx_context::sender(arg2);
        let v1 = 0x2::coin::value<T2>(&arg1);
        assert!(0x2::vec_map::contains<address, UserBalanceManager>(&arg0.user_balance_managers, &v0), 3);
        let v2 = (v1 as u256) / (0x2::coin::total_supply<T2>(&arg0.lp_treasury_cap) as u256);
        let (v3, v4) = get_vault_balance<T0, T1, T2>(arg0);
        let v5 = (v3 as u256) * v2;
        let v6 = (v4 as u256) * v2;
        assert!(v5 <= 18446744073709551615, 1);
        assert!(v6 <= 18446744073709551615, 1);
        let v7 = 0x2::vec_map::get_mut<address, UserBalanceManager>(&mut arg0.user_balance_managers, &v0);
        let v8 = 0x2c8d603bc51326b8c13cef9dd07031a408a48dddb541963357661df5d3204809::balance_manager::withdraw_with_cap<T0>(&mut v7.balance_manager, &v7.withdraw_cap, (v5 as u64), arg2);
        let v9 = 0x2c8d603bc51326b8c13cef9dd07031a408a48dddb541963357661df5d3204809::balance_manager::withdraw_with_cap<T1>(&mut v7.balance_manager, &v7.withdraw_cap, (v6 as u64), arg2);
        0x2::coin::burn<T2>(&mut arg0.lp_treasury_cap, arg1);
        let v10 = BalanceEvent{
            vault              : 0x2::object::id<Vault<T0, T1, T2>>(arg0),
            user               : v0,
            base_asset_amount  : 0x2::coin::value<T0>(&v8),
            quote_asset_amount : 0x2::coin::value<T1>(&v9),
            lp_amount          : v1,
            deposit            : false,
        };
        0x2::event::emit<BalanceEvent>(v10);
        (v8, v9)
    }

    // decompiled from Move bytecode v6
}

