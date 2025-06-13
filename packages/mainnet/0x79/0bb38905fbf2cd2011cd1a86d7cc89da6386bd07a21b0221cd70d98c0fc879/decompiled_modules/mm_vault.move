module 0x790bb38905fbf2cd2011cd1a86d7cc89da6386bd07a21b0221cd70d98c0fc879::mm_vault {
    struct BalanceEvent has copy, drop {
        vault: 0x2::object::ID,
        user: address,
        base_asset_amount: u64,
        quote_asset_amount: u64,
        lp_amount: u64,
        deposit: bool,
    }

    struct Vault<phantom T0, phantom T1, phantom T2> has store, key {
        id: 0x2::object::UID,
        lp_treasury_cap: 0x2::coin::TreasuryCap<T2>,
        balance_manager: 0x2c8d603bc51326b8c13cef9dd07031a408a48dddb541963357661df5d3204809::balance_manager::BalanceManager,
        base_price_id: vector<u8>,
        quote_price_id: vector<u8>,
    }

    public fun deposit<T0, T1, T2>(arg0: &mut Vault<T0, T1, T2>, arg1: 0x2::coin::Coin<T0>, arg2: 0x2::coin::Coin<T1>, arg3: &0x8d97f1cd6ac663735be08d1d2b6d02a159e711586461306ce60a2b7a6a565a9e::price_info::PriceInfoObject, arg4: &0x8d97f1cd6ac663735be08d1d2b6d02a159e711586461306ce60a2b7a6a565a9e::price_info::PriceInfoObject, arg5: &0x2::clock::Clock, arg6: &mut 0x2::tx_context::TxContext) : 0x2::coin::Coin<T2> {
        let v0 = 0x2::coin::value<T0>(&arg1);
        let v1 = 0x2::coin::value<T1>(&arg2);
        let (v2, v3) = get_price(arg0.base_price_id, arg3, arg5);
        let v4 = v3;
        let v5 = v2;
        let (v6, v7) = get_price(arg0.quote_price_id, arg4, arg5);
        let v8 = v7;
        let v9 = v6;
        let v10 = 0x2::coin::total_supply<T2>(&arg0.lp_treasury_cap);
        let v11 = if (v10 == 0) {
            (v0 as u256) * normalize_price(&v5, &v4) + (v1 as u256) * normalize_price(&v9, &v8)
        } else {
            ((v0 as u256) * normalize_price(&v5, &v4) + (v1 as u256) * normalize_price(&v9, &v8)) * (v10 as u256) / get_total_value<T0, T1, T2>(arg0, arg3, arg4, arg5)
        };
        assert!(v11 <= 18446744073709551615, 2);
        0x2c8d603bc51326b8c13cef9dd07031a408a48dddb541963357661df5d3204809::balance_manager::deposit<T0>(&mut arg0.balance_manager, arg1, arg6);
        0x2c8d603bc51326b8c13cef9dd07031a408a48dddb541963357661df5d3204809::balance_manager::deposit<T1>(&mut arg0.balance_manager, arg2, arg6);
        let v12 = BalanceEvent{
            vault              : 0x2::object::id<Vault<T0, T1, T2>>(arg0),
            user               : 0x2::tx_context::sender(arg6),
            base_asset_amount  : v0,
            quote_asset_amount : v1,
            lp_amount          : (v11 as u64),
            deposit            : true,
        };
        0x2::event::emit<BalanceEvent>(v12);
        0x2::coin::mint<T2>(&mut arg0.lp_treasury_cap, (v11 as u64), arg6)
    }

    public fun withdraw<T0, T1, T2>(arg0: &mut Vault<T0, T1, T2>, arg1: 0x2::coin::Coin<T2>, arg2: &mut 0x2::tx_context::TxContext) : (0x2::coin::Coin<T0>, 0x2::coin::Coin<T1>) {
        let v0 = 0x2::coin::value<T2>(&arg1);
        let v1 = 0x2::coin::total_supply<T2>(&arg0.lp_treasury_cap);
        let (v2, v3) = get_vault_balance<T0, T1, T2>(arg0);
        let v4 = (v2 as u256) * (v0 as u256) / (v1 as u256);
        let v5 = (v3 as u256) * (v0 as u256) / (v1 as u256);
        assert!(v4 <= 18446744073709551615, 1);
        assert!(v5 <= 18446744073709551615, 1);
        let v6 = 0x2c8d603bc51326b8c13cef9dd07031a408a48dddb541963357661df5d3204809::balance_manager::withdraw<T0>(&mut arg0.balance_manager, (v4 as u64), arg2);
        let v7 = 0x2c8d603bc51326b8c13cef9dd07031a408a48dddb541963357661df5d3204809::balance_manager::withdraw<T1>(&mut arg0.balance_manager, (v5 as u64), arg2);
        0x2::coin::burn<T2>(&mut arg0.lp_treasury_cap, arg1);
        let v8 = BalanceEvent{
            vault              : 0x2::object::id<Vault<T0, T1, T2>>(arg0),
            user               : 0x2::tx_context::sender(arg2),
            base_asset_amount  : 0x2::coin::value<T0>(&v6),
            quote_asset_amount : 0x2::coin::value<T1>(&v7),
            lp_amount          : v0,
            deposit            : false,
        };
        0x2::event::emit<BalanceEvent>(v8);
        (v6, v7)
    }

    public fun create_vault<T0, T1, T2>(arg0: 0x2::coin::TreasuryCap<T2>, arg1: vector<u8>, arg2: vector<u8>, arg3: &mut 0x2::tx_context::TxContext) {
        let v0 = Vault<T0, T1, T2>{
            id              : 0x2::object::new(arg3),
            lp_treasury_cap : arg0,
            balance_manager : 0x2c8d603bc51326b8c13cef9dd07031a408a48dddb541963357661df5d3204809::balance_manager::new(arg3),
            base_price_id   : arg1,
            quote_price_id  : arg2,
        };
        0x2::transfer::share_object<Vault<T0, T1, T2>>(v0);
    }

    public fun get_balance_manager<T0, T1, T2>(arg0: &Vault<T0, T1, T2>) : &0x2c8d603bc51326b8c13cef9dd07031a408a48dddb541963357661df5d3204809::balance_manager::BalanceManager {
        &arg0.balance_manager
    }

    public fun get_price(arg0: vector<u8>, arg1: &0x8d97f1cd6ac663735be08d1d2b6d02a159e711586461306ce60a2b7a6a565a9e::price_info::PriceInfoObject, arg2: &0x2::clock::Clock) : (0x8d97f1cd6ac663735be08d1d2b6d02a159e711586461306ce60a2b7a6a565a9e::i64::I64, 0x8d97f1cd6ac663735be08d1d2b6d02a159e711586461306ce60a2b7a6a565a9e::i64::I64) {
        let v0 = 0x8d97f1cd6ac663735be08d1d2b6d02a159e711586461306ce60a2b7a6a565a9e::pyth::get_price_no_older_than(arg1, arg2, 60);
        let v1 = 0x8d97f1cd6ac663735be08d1d2b6d02a159e711586461306ce60a2b7a6a565a9e::price_info::get_price_info_from_price_info_object(arg1);
        let v2 = 0x8d97f1cd6ac663735be08d1d2b6d02a159e711586461306ce60a2b7a6a565a9e::price_info::get_price_identifier(&v1);
        assert!(0x8d97f1cd6ac663735be08d1d2b6d02a159e711586461306ce60a2b7a6a565a9e::price_identifier::get_bytes(&v2) == arg0, 0);
        (0x8d97f1cd6ac663735be08d1d2b6d02a159e711586461306ce60a2b7a6a565a9e::price::get_price(&v0), 0x8d97f1cd6ac663735be08d1d2b6d02a159e711586461306ce60a2b7a6a565a9e::price::get_expo(&v0))
    }

    public fun get_total_value<T0, T1, T2>(arg0: &Vault<T0, T1, T2>, arg1: &0x8d97f1cd6ac663735be08d1d2b6d02a159e711586461306ce60a2b7a6a565a9e::price_info::PriceInfoObject, arg2: &0x8d97f1cd6ac663735be08d1d2b6d02a159e711586461306ce60a2b7a6a565a9e::price_info::PriceInfoObject, arg3: &0x2::clock::Clock) : u256 {
        let (v0, v1) = get_price(arg0.base_price_id, arg1, arg3);
        let v2 = v1;
        let v3 = v0;
        let (v4, v5) = get_price(arg0.quote_price_id, arg2, arg3);
        let v6 = v5;
        let v7 = v4;
        0 + (0x2c8d603bc51326b8c13cef9dd07031a408a48dddb541963357661df5d3204809::balance_manager::balance<T0>(&arg0.balance_manager) as u256) * normalize_price(&v3, &v2) + (0x2c8d603bc51326b8c13cef9dd07031a408a48dddb541963357661df5d3204809::balance_manager::balance<T1>(&arg0.balance_manager) as u256) * normalize_price(&v7, &v6)
    }

    public fun get_vault_balance<T0, T1, T2>(arg0: &Vault<T0, T1, T2>) : (u64, u64) {
        (0x2c8d603bc51326b8c13cef9dd07031a408a48dddb541963357661df5d3204809::balance_manager::balance<T0>(&arg0.balance_manager), 0x2c8d603bc51326b8c13cef9dd07031a408a48dddb541963357661df5d3204809::balance_manager::balance<T1>(&arg0.balance_manager))
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
                (v0 as u256) / (0x1::u64::pow(10, ((v1 - v2) as u8)) as u256)
            } else {
                (v0 as u256) * (0x1::u64::pow(10, ((v2 - v1) as u8)) as u256)
            }
        } else {
            (v0 as u256) * (0x1::u64::pow(10, ((v1 + v2) as u8)) as u256)
        }
    }

    // decompiled from Move bytecode v6
}

