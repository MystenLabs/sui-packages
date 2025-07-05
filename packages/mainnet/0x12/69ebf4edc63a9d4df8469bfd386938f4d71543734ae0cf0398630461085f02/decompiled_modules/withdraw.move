module 0x1269ebf4edc63a9d4df8469bfd386938f4d71543734ae0cf0398630461085f02::withdraw {
    struct WithdrawReceipt<phantom T0> {
        value: 0x1269ebf4edc63a9d4df8469bfd386938f4d71543734ae0cf0398630461085f02::decimals::Decimal,
        price: 0x1269ebf4edc63a9d4df8469bfd386938f4d71543734ae0cf0398630461085f02::decimals::Decimal,
        amount: 0x1269ebf4edc63a9d4df8469bfd386938f4d71543734ae0cf0398630461085f02::decimals::Decimal,
        decimals: u8,
        vault_id: address,
        product_id: address,
        product_category: u64,
        fee_percentage: 0x1269ebf4edc63a9d4df8469bfd386938f4d71543734ae0cf0398630461085f02::decimals::Decimal,
    }

    public fun complete<T0>(arg0: WithdrawReceipt<T0>, arg1: &0x1269ebf4edc63a9d4df8469bfd386938f4d71543734ae0cf0398630461085f02::asset_registry::AssetRegistry, arg2: &mut 0x1269ebf4edc63a9d4df8469bfd386938f4d71543734ae0cf0398630461085f02::balances_registry::BalancesRegistry, arg3: &mut 0x1269ebf4edc63a9d4df8469bfd386938f4d71543734ae0cf0398630461085f02::vault::Vault<T0>, arg4: &0x2::clock::Clock, arg5: &mut 0x2::tx_context::TxContext) : 0x2::coin::Coin<T0> {
        complete_internal<T0>(arg0, arg1, arg2, arg3, arg4, arg5)
    }

    fun complete_internal<T0>(arg0: WithdrawReceipt<T0>, arg1: &0x1269ebf4edc63a9d4df8469bfd386938f4d71543734ae0cf0398630461085f02::asset_registry::AssetRegistry, arg2: &mut 0x1269ebf4edc63a9d4df8469bfd386938f4d71543734ae0cf0398630461085f02::balances_registry::BalancesRegistry, arg3: &mut 0x1269ebf4edc63a9d4df8469bfd386938f4d71543734ae0cf0398630461085f02::vault::Vault<T0>, arg4: &0x2::clock::Clock, arg5: &mut 0x2::tx_context::TxContext) : 0x2::coin::Coin<T0> {
        let WithdrawReceipt {
            value            : _,
            price            : _,
            amount           : v2,
            decimals         : _,
            vault_id         : _,
            product_id       : v5,
            product_category : v6,
            fee_percentage   : v7,
        } = arg0;
        let v8 = 0x1269ebf4edc63a9d4df8469bfd386938f4d71543734ae0cf0398630461085f02::decimals::mul(v2, v7);
        0x1269ebf4edc63a9d4df8469bfd386938f4d71543734ae0cf0398630461085f02::vault::add_fee_balance<T0>(arg3, arg1, arg2, v5, v8);
        0x2::coin::from_balance<T0>(0x1269ebf4edc63a9d4df8469bfd386938f4d71543734ae0cf0398630461085f02::vault::withdraw<T0>(arg3, arg1, arg2, v5, 0x1269ebf4edc63a9d4df8469bfd386938f4d71543734ae0cf0398630461085f02::decimals::sub(v2, v8), v6, arg4, arg5), arg5)
    }

    public(friend) fun create_receipt<T0>(arg0: &0x1269ebf4edc63a9d4df8469bfd386938f4d71543734ae0cf0398630461085f02::vault::Vault<T0>, arg1: &0x1269ebf4edc63a9d4df8469bfd386938f4d71543734ae0cf0398630461085f02::asset_registry::AssetRegistry, arg2: &0x1269ebf4edc63a9d4df8469bfd386938f4d71543734ae0cf0398630461085f02::price_registry::PriceRegistry, arg3: 0x1269ebf4edc63a9d4df8469bfd386938f4d71543734ae0cf0398630461085f02::decimals::Decimal, arg4: address, arg5: u64, arg6: 0x1269ebf4edc63a9d4df8469bfd386938f4d71543734ae0cf0398630461085f02::decimals::Decimal, arg7: &0x2::clock::Clock) : WithdrawReceipt<T0> {
        let v0 = 0x1269ebf4edc63a9d4df8469bfd386938f4d71543734ae0cf0398630461085f02::price_registry::get_price_by_asset<T0>(arg2, arg1, arg7);
        let v1 = 0x2::object::id<0x1269ebf4edc63a9d4df8469bfd386938f4d71543734ae0cf0398630461085f02::vault::Vault<T0>>(arg0);
        WithdrawReceipt<T0>{
            value            : 0x1269ebf4edc63a9d4df8469bfd386938f4d71543734ae0cf0398630461085f02::decimals::mul(arg3, v0),
            price            : v0,
            amount           : arg3,
            decimals         : 0x1269ebf4edc63a9d4df8469bfd386938f4d71543734ae0cf0398630461085f02::asset_registry::decimals(0x1269ebf4edc63a9d4df8469bfd386938f4d71543734ae0cf0398630461085f02::asset_registry::get_asset<T0>(arg1)),
            vault_id         : 0x2::object::id_to_address(&v1),
            product_id       : arg4,
            product_category : arg5,
            fee_percentage   : arg6,
        }
    }

    // decompiled from Move bytecode v6
}

