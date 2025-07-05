module 0x1269ebf4edc63a9d4df8469bfd386938f4d71543734ae0cf0398630461085f02::mint {
    struct IndexMinted has copy, drop {
        value: 0x1269ebf4edc63a9d4df8469bfd386938f4d71543734ae0cf0398630461085f02::decimals::Decimal,
        fee_percentage: 0x1269ebf4edc63a9d4df8469bfd386938f4d71543734ae0cf0398630461085f02::decimals::Decimal,
        amount: u64,
    }

    struct IndexPreMinted has copy, drop {
        value: 0x1269ebf4edc63a9d4df8469bfd386938f4d71543734ae0cf0398630461085f02::decimals::Decimal,
        fee_percentage: 0x1269ebf4edc63a9d4df8469bfd386938f4d71543734ae0cf0398630461085f02::decimals::Decimal,
        amount: u64,
    }

    public fun mint<T0, T1>(arg0: &mut 0x1269ebf4edc63a9d4df8469bfd386938f4d71543734ae0cf0398630461085f02::index::Index<T0>, arg1: &mut 0x1269ebf4edc63a9d4df8469bfd386938f4d71543734ae0cf0398630461085f02::vault::Vault<T1>, arg2: &0x1269ebf4edc63a9d4df8469bfd386938f4d71543734ae0cf0398630461085f02::asset_registry::AssetRegistry, arg3: 0x2::coin::Coin<T1>, arg4: &mut 0x1269ebf4edc63a9d4df8469bfd386938f4d71543734ae0cf0398630461085f02::balances_registry::BalancesRegistry, arg5: &mut 0x1269ebf4edc63a9d4df8469bfd386938f4d71543734ae0cf0398630461085f02::price_registry::PriceRegistry, arg6: &mut 0x1269ebf4edc63a9d4df8469bfd386938f4d71543734ae0cf0398630461085f02::dispatcher::Dispatcher, arg7: &0x2::clock::Clock, arg8: &mut 0x2::tx_context::TxContext) : 0x2::coin::Coin<T0> {
        0x1269ebf4edc63a9d4df8469bfd386938f4d71543734ae0cf0398630461085f02::index::assert_mint_is_public<T0>(arg0);
        let v0 = 0x1269ebf4edc63a9d4df8469bfd386938f4d71543734ae0cf0398630461085f02::index::mint_fee<T0>(arg0);
        mint_internal<T0, T1>(arg0, arg2, arg1, arg4, arg5, arg3, v0, arg6, arg7, arg8)
    }

    fun mint_internal<T0, T1>(arg0: &mut 0x1269ebf4edc63a9d4df8469bfd386938f4d71543734ae0cf0398630461085f02::index::Index<T0>, arg1: &0x1269ebf4edc63a9d4df8469bfd386938f4d71543734ae0cf0398630461085f02::asset_registry::AssetRegistry, arg2: &mut 0x1269ebf4edc63a9d4df8469bfd386938f4d71543734ae0cf0398630461085f02::vault::Vault<T1>, arg3: &mut 0x1269ebf4edc63a9d4df8469bfd386938f4d71543734ae0cf0398630461085f02::balances_registry::BalancesRegistry, arg4: &mut 0x1269ebf4edc63a9d4df8469bfd386938f4d71543734ae0cf0398630461085f02::price_registry::PriceRegistry, arg5: 0x2::coin::Coin<T1>, arg6: 0x1269ebf4edc63a9d4df8469bfd386938f4d71543734ae0cf0398630461085f02::decimals::Decimal, arg7: &mut 0x1269ebf4edc63a9d4df8469bfd386938f4d71543734ae0cf0398630461085f02::dispatcher::Dispatcher, arg8: &0x2::clock::Clock, arg9: &mut 0x2::tx_context::TxContext) : 0x2::coin::Coin<T0> {
        0x1269ebf4edc63a9d4df8469bfd386938f4d71543734ae0cf0398630461085f02::index::assert_vault_is_subscribed<T0, T1>(arg0, arg2);
        let v0 = 0x1269ebf4edc63a9d4df8469bfd386938f4d71543734ae0cf0398630461085f02::price_registry::get_price_by_asset<T1>(arg4, arg1, arg8);
        let v1 = 0x2::object::id<0x1269ebf4edc63a9d4df8469bfd386938f4d71543734ae0cf0398630461085f02::index::Index<T0>>(arg0);
        let v2 = 0x2::object::id_to_address(&v1);
        let v3 = 0x1269ebf4edc63a9d4df8469bfd386938f4d71543734ae0cf0398630461085f02::deposit::complete<T1>(0x1269ebf4edc63a9d4df8469bfd386938f4d71543734ae0cf0398630461085f02::deposit::deposit<T1>(arg2, arg1, 0x2::coin::into_balance<T1>(arg5), arg4, arg8), arg1, arg3, arg2, arg6, v2, 0x1269ebf4edc63a9d4df8469bfd386938f4d71543734ae0cf0398630461085f02::vault::index_product(), arg8, arg9);
        let v4 = 0x1269ebf4edc63a9d4df8469bfd386938f4d71543734ae0cf0398630461085f02::decimals::mul(v3, v0);
        let v5 = 0x1269ebf4edc63a9d4df8469bfd386938f4d71543734ae0cf0398630461085f02::decimals::to_u64(0x1269ebf4edc63a9d4df8469bfd386938f4d71543734ae0cf0398630461085f02::decimals::div(v4, 0x1269ebf4edc63a9d4df8469bfd386938f4d71543734ae0cf0398630461085f02::price_registry::refresh_index_price<T0>(arg4, arg1, arg3, arg0, arg8)), 0x1269ebf4edc63a9d4df8469bfd386938f4d71543734ae0cf0398630461085f02::index::decimals<T0>(arg0));
        let v6 = 0x1269ebf4edc63a9d4df8469bfd386938f4d71543734ae0cf0398630461085f02::index::weights<T0>(arg0);
        let v7 = 0x2::object::id<0x1269ebf4edc63a9d4df8469bfd386938f4d71543734ae0cf0398630461085f02::vault::Vault<T1>>(arg2);
        let v8 = 0x1269ebf4edc63a9d4df8469bfd386938f4d71543734ae0cf0398630461085f02::dispatcher::new_transfer_details(0x2::object::id_to_address(&v7), v2, 0x1269ebf4edc63a9d4df8469bfd386938f4d71543734ae0cf0398630461085f02::vault::index_product());
        let v9 = 0;
        while (v9 < 0x1::vector::length<u64>(&v6)) {
            let v10 = 0x1269ebf4edc63a9d4df8469bfd386938f4d71543734ae0cf0398630461085f02::index::vaults<T0>(arg0);
            let v11 = *0x1::vector::borrow<address>(&v10, v9);
            let v12 = 0x1269ebf4edc63a9d4df8469bfd386938f4d71543734ae0cf0398630461085f02::index::assets<T0>(arg0);
            let v13 = 0x1269ebf4edc63a9d4df8469bfd386938f4d71543734ae0cf0398630461085f02::dispatcher::new_transfer_details(v11, v2, 0x1269ebf4edc63a9d4df8469bfd386938f4d71543734ae0cf0398630461085f02::vault::index_product());
            let v14 = 0x2::object::id<0x1269ebf4edc63a9d4df8469bfd386938f4d71543734ae0cf0398630461085f02::vault::Vault<T1>>(arg2);
            if (v11 != 0x2::object::id_to_address(&v14)) {
                0x1269ebf4edc63a9d4df8469bfd386938f4d71543734ae0cf0398630461085f02::dispatcher::add_record(arg7, &v8, &v13, 0, 0x1269ebf4edc63a9d4df8469bfd386938f4d71543734ae0cf0398630461085f02::decimals::mul(v3, 0x1269ebf4edc63a9d4df8469bfd386938f4d71543734ae0cf0398630461085f02::decimals::from_percentage(*0x1::vector::borrow<u64>(&v6, v9))), v0, 0x1269ebf4edc63a9d4df8469bfd386938f4d71543734ae0cf0398630461085f02::price_registry::get_price_by_asset_id(arg4, *0x1::vector::borrow<u64>(&v12, v9), arg8));
            };
            v9 = v9 + 1;
        };
        let v15 = IndexMinted{
            value          : v4,
            fee_percentage : arg6,
            amount         : v5,
        };
        0x2::event::emit<IndexMinted>(v15);
        0x1269ebf4edc63a9d4df8469bfd386938f4d71543734ae0cf0398630461085f02::index::mint_coin<T0>(arg0, v5, arg9)
    }

    public fun mint_whitelist<T0, T1>(arg0: &mut 0x1269ebf4edc63a9d4df8469bfd386938f4d71543734ae0cf0398630461085f02::index::Index<T0>, arg1: &mut 0x1269ebf4edc63a9d4df8469bfd386938f4d71543734ae0cf0398630461085f02::vault::Vault<T1>, arg2: &0x1269ebf4edc63a9d4df8469bfd386938f4d71543734ae0cf0398630461085f02::asset_registry::AssetRegistry, arg3: &0x1269ebf4edc63a9d4df8469bfd386938f4d71543734ae0cf0398630461085f02::whitelist::WhitelistCertificate<T0>, arg4: &mut 0x1269ebf4edc63a9d4df8469bfd386938f4d71543734ae0cf0398630461085f02::balances_registry::BalancesRegistry, arg5: &mut 0x1269ebf4edc63a9d4df8469bfd386938f4d71543734ae0cf0398630461085f02::price_registry::PriceRegistry, arg6: 0x2::coin::Coin<T1>, arg7: &mut 0x1269ebf4edc63a9d4df8469bfd386938f4d71543734ae0cf0398630461085f02::dispatcher::Dispatcher, arg8: &0x2::clock::Clock, arg9: &mut 0x2::tx_context::TxContext) : 0x2::coin::Coin<T0> {
        0x1269ebf4edc63a9d4df8469bfd386938f4d71543734ae0cf0398630461085f02::index::assert_mint_is_open<T0>(arg0);
        0x1269ebf4edc63a9d4df8469bfd386938f4d71543734ae0cf0398630461085f02::whitelist::assert_expiration<T0>(arg3, arg8);
        let v0 = 0x1269ebf4edc63a9d4df8469bfd386938f4d71543734ae0cf0398630461085f02::index::mint_fee<T0>(arg0);
        mint_internal<T0, T1>(arg0, arg2, arg1, arg4, arg5, arg6, v0, arg7, arg8, arg9)
    }

    public fun mint_whitelist_with_discount<T0, T1>(arg0: &mut 0x1269ebf4edc63a9d4df8469bfd386938f4d71543734ae0cf0398630461085f02::index::Index<T0>, arg1: &mut 0x1269ebf4edc63a9d4df8469bfd386938f4d71543734ae0cf0398630461085f02::vault::Vault<T1>, arg2: &0x1269ebf4edc63a9d4df8469bfd386938f4d71543734ae0cf0398630461085f02::asset_registry::AssetRegistry, arg3: &mut 0x1269ebf4edc63a9d4df8469bfd386938f4d71543734ae0cf0398630461085f02::balances_registry::BalancesRegistry, arg4: &mut 0x1269ebf4edc63a9d4df8469bfd386938f4d71543734ae0cf0398630461085f02::price_registry::PriceRegistry, arg5: &0x1269ebf4edc63a9d4df8469bfd386938f4d71543734ae0cf0398630461085f02::whitelist::WhitelistCertificate<T0>, arg6: 0x2::coin::Coin<T1>, arg7: &0x1269ebf4edc63a9d4df8469bfd386938f4d71543734ae0cf0398630461085f02::discount::MintDiscountBadge<T0>, arg8: &mut 0x1269ebf4edc63a9d4df8469bfd386938f4d71543734ae0cf0398630461085f02::dispatcher::Dispatcher, arg9: &0x2::clock::Clock, arg10: &mut 0x2::tx_context::TxContext) : 0x2::coin::Coin<T0> {
        0x1269ebf4edc63a9d4df8469bfd386938f4d71543734ae0cf0398630461085f02::index::assert_mint_is_open<T0>(arg0);
        0x1269ebf4edc63a9d4df8469bfd386938f4d71543734ae0cf0398630461085f02::whitelist::assert_expiration<T0>(arg5, arg9);
        0x1269ebf4edc63a9d4df8469bfd386938f4d71543734ae0cf0398630461085f02::discount::assert_expiration<T0>(arg7, arg9);
        let v0 = 0x1269ebf4edc63a9d4df8469bfd386938f4d71543734ae0cf0398630461085f02::index::mint_fee<T0>(arg0);
        mint_internal<T0, T1>(arg0, arg2, arg1, arg3, arg4, arg6, 0x1269ebf4edc63a9d4df8469bfd386938f4d71543734ae0cf0398630461085f02::decimals::sub(v0, 0x1269ebf4edc63a9d4df8469bfd386938f4d71543734ae0cf0398630461085f02::decimals::mul(v0, 0x1269ebf4edc63a9d4df8469bfd386938f4d71543734ae0cf0398630461085f02::discount::percentage<T0>(arg7))), arg8, arg9, arg10)
    }

    public fun mint_with_discount<T0, T1>(arg0: &mut 0x1269ebf4edc63a9d4df8469bfd386938f4d71543734ae0cf0398630461085f02::index::Index<T0>, arg1: &mut 0x1269ebf4edc63a9d4df8469bfd386938f4d71543734ae0cf0398630461085f02::vault::Vault<T1>, arg2: &0x1269ebf4edc63a9d4df8469bfd386938f4d71543734ae0cf0398630461085f02::asset_registry::AssetRegistry, arg3: &mut 0x1269ebf4edc63a9d4df8469bfd386938f4d71543734ae0cf0398630461085f02::balances_registry::BalancesRegistry, arg4: &mut 0x1269ebf4edc63a9d4df8469bfd386938f4d71543734ae0cf0398630461085f02::price_registry::PriceRegistry, arg5: 0x2::coin::Coin<T1>, arg6: &0x1269ebf4edc63a9d4df8469bfd386938f4d71543734ae0cf0398630461085f02::discount::MintDiscountBadge<T0>, arg7: &mut 0x1269ebf4edc63a9d4df8469bfd386938f4d71543734ae0cf0398630461085f02::dispatcher::Dispatcher, arg8: &0x2::clock::Clock, arg9: &mut 0x2::tx_context::TxContext) : 0x2::coin::Coin<T0> {
        0x1269ebf4edc63a9d4df8469bfd386938f4d71543734ae0cf0398630461085f02::index::assert_mint_is_public<T0>(arg0);
        0x1269ebf4edc63a9d4df8469bfd386938f4d71543734ae0cf0398630461085f02::discount::assert_expiration<T0>(arg6, arg8);
        let v0 = 0x1269ebf4edc63a9d4df8469bfd386938f4d71543734ae0cf0398630461085f02::index::mint_fee<T0>(arg0);
        mint_internal<T0, T1>(arg0, arg2, arg1, arg3, arg4, arg5, 0x1269ebf4edc63a9d4df8469bfd386938f4d71543734ae0cf0398630461085f02::decimals::sub(v0, 0x1269ebf4edc63a9d4df8469bfd386938f4d71543734ae0cf0398630461085f02::decimals::mul(v0, 0x1269ebf4edc63a9d4df8469bfd386938f4d71543734ae0cf0398630461085f02::discount::percentage<T0>(arg6))), arg7, arg8, arg9)
    }

    public fun pre_mint<T0, T1>(arg0: &0x1269ebf4edc63a9d4df8469bfd386938f4d71543734ae0cf0398630461085f02::index::Index<T0>, arg1: &0x1269ebf4edc63a9d4df8469bfd386938f4d71543734ae0cf0398630461085f02::asset_registry::AssetRegistry, arg2: &0x1269ebf4edc63a9d4df8469bfd386938f4d71543734ae0cf0398630461085f02::balances_registry::BalancesRegistry, arg3: &mut 0x1269ebf4edc63a9d4df8469bfd386938f4d71543734ae0cf0398630461085f02::price_registry::PriceRegistry, arg4: u64, arg5: &0x2::clock::Clock) {
        let v0 = 0x1269ebf4edc63a9d4df8469bfd386938f4d71543734ae0cf0398630461085f02::decimals::mul(0x1269ebf4edc63a9d4df8469bfd386938f4d71543734ae0cf0398630461085f02::decimals::from_u64(arg4, 0x1269ebf4edc63a9d4df8469bfd386938f4d71543734ae0cf0398630461085f02::asset_registry::decimals(0x1269ebf4edc63a9d4df8469bfd386938f4d71543734ae0cf0398630461085f02::asset_registry::get_asset<T1>(arg1))), 0x1269ebf4edc63a9d4df8469bfd386938f4d71543734ae0cf0398630461085f02::price_registry::get_price_by_asset<T1>(arg3, arg1, arg5));
        let v1 = 0x1269ebf4edc63a9d4df8469bfd386938f4d71543734ae0cf0398630461085f02::decimals::sub(v0, 0x1269ebf4edc63a9d4df8469bfd386938f4d71543734ae0cf0398630461085f02::decimals::mul(v0, 0x1269ebf4edc63a9d4df8469bfd386938f4d71543734ae0cf0398630461085f02::index::mint_fee<T0>(arg0)));
        let v2 = IndexPreMinted{
            value          : v1,
            fee_percentage : 0x1269ebf4edc63a9d4df8469bfd386938f4d71543734ae0cf0398630461085f02::index::mint_fee<T0>(arg0),
            amount         : 0x1269ebf4edc63a9d4df8469bfd386938f4d71543734ae0cf0398630461085f02::decimals::to_u64(0x1269ebf4edc63a9d4df8469bfd386938f4d71543734ae0cf0398630461085f02::decimals::div(v1, 0x1269ebf4edc63a9d4df8469bfd386938f4d71543734ae0cf0398630461085f02::price_registry::refresh_index_price<T0>(arg3, arg1, arg2, arg0, arg5)), 0x1269ebf4edc63a9d4df8469bfd386938f4d71543734ae0cf0398630461085f02::index::decimals<T0>(arg0)),
        };
        0x2::event::emit<IndexPreMinted>(v2);
    }

    public fun pre_mint_with_discount<T0, T1>(arg0: &0x1269ebf4edc63a9d4df8469bfd386938f4d71543734ae0cf0398630461085f02::index::Index<T0>, arg1: &0x1269ebf4edc63a9d4df8469bfd386938f4d71543734ae0cf0398630461085f02::asset_registry::AssetRegistry, arg2: &0x1269ebf4edc63a9d4df8469bfd386938f4d71543734ae0cf0398630461085f02::balances_registry::BalancesRegistry, arg3: &mut 0x1269ebf4edc63a9d4df8469bfd386938f4d71543734ae0cf0398630461085f02::price_registry::PriceRegistry, arg4: &0x1269ebf4edc63a9d4df8469bfd386938f4d71543734ae0cf0398630461085f02::discount::MintDiscountBadge<T0>, arg5: u64, arg6: &0x2::coin::CoinMetadata<T1>, arg7: &0x2::clock::Clock) {
        0x1269ebf4edc63a9d4df8469bfd386938f4d71543734ae0cf0398630461085f02::discount::assert_expiration<T0>(arg4, arg7);
        let v0 = 0x1269ebf4edc63a9d4df8469bfd386938f4d71543734ae0cf0398630461085f02::decimals::mul(0x1269ebf4edc63a9d4df8469bfd386938f4d71543734ae0cf0398630461085f02::decimals::from_u64(arg5, 0x2::coin::get_decimals<T1>(arg6)), 0x1269ebf4edc63a9d4df8469bfd386938f4d71543734ae0cf0398630461085f02::price_registry::get_price_by_asset<T1>(arg3, arg1, arg7));
        let v1 = 0x1269ebf4edc63a9d4df8469bfd386938f4d71543734ae0cf0398630461085f02::decimals::sub(v0, 0x1269ebf4edc63a9d4df8469bfd386938f4d71543734ae0cf0398630461085f02::decimals::mul(v0, 0x1269ebf4edc63a9d4df8469bfd386938f4d71543734ae0cf0398630461085f02::decimals::sub(0x1269ebf4edc63a9d4df8469bfd386938f4d71543734ae0cf0398630461085f02::index::mint_fee<T0>(arg0), 0x1269ebf4edc63a9d4df8469bfd386938f4d71543734ae0cf0398630461085f02::decimals::mul(0x1269ebf4edc63a9d4df8469bfd386938f4d71543734ae0cf0398630461085f02::index::mint_fee<T0>(arg0), 0x1269ebf4edc63a9d4df8469bfd386938f4d71543734ae0cf0398630461085f02::discount::percentage<T0>(arg4)))));
        let v2 = IndexPreMinted{
            value          : v1,
            fee_percentage : 0x1269ebf4edc63a9d4df8469bfd386938f4d71543734ae0cf0398630461085f02::index::mint_fee<T0>(arg0),
            amount         : 0x1269ebf4edc63a9d4df8469bfd386938f4d71543734ae0cf0398630461085f02::decimals::to_u64(0x1269ebf4edc63a9d4df8469bfd386938f4d71543734ae0cf0398630461085f02::decimals::div(v1, 0x1269ebf4edc63a9d4df8469bfd386938f4d71543734ae0cf0398630461085f02::price_registry::refresh_index_price<T0>(arg3, arg1, arg2, arg0, arg7)), 0x1269ebf4edc63a9d4df8469bfd386938f4d71543734ae0cf0398630461085f02::index::decimals<T0>(arg0)),
        };
        0x2::event::emit<IndexPreMinted>(v2);
    }

    // decompiled from Move bytecode v6
}

