module 0x1269ebf4edc63a9d4df8469bfd386938f4d71543734ae0cf0398630461085f02::borrow {
    struct BorrowReceipt {
        creator: u64,
        value: 0x1269ebf4edc63a9d4df8469bfd386938f4d71543734ae0cf0398630461085f02::decimals::Decimal,
        amount: u64,
        vault_id: address,
        product_id: address,
        product_category: u64,
        repay_vaults: vector<address>,
        fee_percentage: 0x1269ebf4edc63a9d4df8469bfd386938f4d71543734ae0cf0398630461085f02::decimals::Decimal,
    }

    struct DebtRepaid has copy, drop {
        creator: u64,
        product_id: address,
        product_category: u64,
        fee_percentage: 0x1269ebf4edc63a9d4df8469bfd386938f4d71543734ae0cf0398630461085f02::decimals::Decimal,
        source_vault: address,
        target_vault: address,
        value: 0x1269ebf4edc63a9d4df8469bfd386938f4d71543734ae0cf0398630461085f02::decimals::Decimal,
    }

    public(friend) fun value(arg0: &BorrowReceipt) : 0x1269ebf4edc63a9d4df8469bfd386938f4d71543734ae0cf0398630461085f02::decimals::Decimal {
        arg0.value
    }

    public(friend) fun amount(arg0: &BorrowReceipt) : u64 {
        arg0.amount
    }

    public(friend) fun create_receipt<T0>(arg0: &mut 0x1269ebf4edc63a9d4df8469bfd386938f4d71543734ae0cf0398630461085f02::vault::Vault<T0>, arg1: u64, arg2: &0x1269ebf4edc63a9d4df8469bfd386938f4d71543734ae0cf0398630461085f02::asset_registry::AssetRegistry, arg3: &0x1269ebf4edc63a9d4df8469bfd386938f4d71543734ae0cf0398630461085f02::price_registry::PriceRegistry, arg4: &mut 0x1269ebf4edc63a9d4df8469bfd386938f4d71543734ae0cf0398630461085f02::balances_registry::BalancesRegistry, arg5: vector<address>, arg6: 0x1269ebf4edc63a9d4df8469bfd386938f4d71543734ae0cf0398630461085f02::decimals::Decimal, arg7: address, arg8: u64, arg9: 0x1269ebf4edc63a9d4df8469bfd386938f4d71543734ae0cf0398630461085f02::decimals::Decimal, arg10: &0x2::clock::Clock, arg11: &mut 0x2::tx_context::TxContext) : (BorrowReceipt, 0x2::coin::Coin<T0>) {
        let v0 = 0x1269ebf4edc63a9d4df8469bfd386938f4d71543734ae0cf0398630461085f02::withdraw::complete<T0>(0x1269ebf4edc63a9d4df8469bfd386938f4d71543734ae0cf0398630461085f02::withdraw::create_receipt<T0>(arg0, arg2, arg3, arg6, arg7, arg8, arg9, arg10), arg2, arg4, arg0, arg10, arg11);
        let v1 = 0x2::object::id<0x1269ebf4edc63a9d4df8469bfd386938f4d71543734ae0cf0398630461085f02::vault::Vault<T0>>(arg0);
        let v2 = BorrowReceipt{
            creator          : arg1,
            value            : 0x1269ebf4edc63a9d4df8469bfd386938f4d71543734ae0cf0398630461085f02::decimals::mul(0x1269ebf4edc63a9d4df8469bfd386938f4d71543734ae0cf0398630461085f02::decimals::from_u64(0x2::coin::value<T0>(&v0), 0x1269ebf4edc63a9d4df8469bfd386938f4d71543734ae0cf0398630461085f02::asset_registry::decimals(0x1269ebf4edc63a9d4df8469bfd386938f4d71543734ae0cf0398630461085f02::asset_registry::get_asset<T0>(arg2))), 0x1269ebf4edc63a9d4df8469bfd386938f4d71543734ae0cf0398630461085f02::price_registry::get_price_by_asset<T0>(arg3, arg2, arg10)),
            amount           : 0x2::coin::value<T0>(&v0),
            vault_id         : 0x2::object::id_to_address(&v1),
            product_id       : arg7,
            product_category : arg8,
            repay_vaults     : arg5,
            fee_percentage   : arg9,
        };
        (v2, v0)
    }

    public fun repay<T0>(arg0: BorrowReceipt, arg1: &mut 0x1269ebf4edc63a9d4df8469bfd386938f4d71543734ae0cf0398630461085f02::vault::Vault<T0>, arg2: &0x1269ebf4edc63a9d4df8469bfd386938f4d71543734ae0cf0398630461085f02::asset_registry::AssetRegistry, arg3: &mut 0x1269ebf4edc63a9d4df8469bfd386938f4d71543734ae0cf0398630461085f02::balances_registry::BalancesRegistry, arg4: &0x1269ebf4edc63a9d4df8469bfd386938f4d71543734ae0cf0398630461085f02::price_registry::PriceRegistry, arg5: &mut 0x2::coin::Coin<T0>, arg6: &0x2::clock::Clock, arg7: &mut 0x2::tx_context::TxContext) {
        let BorrowReceipt {
            creator          : v0,
            value            : v1,
            amount           : _,
            vault_id         : v3,
            product_id       : v4,
            product_category : v5,
            repay_vaults     : v6,
            fee_percentage   : v7,
        } = arg0;
        let v8 = v6;
        let v9 = 0x2::object::id<0x1269ebf4edc63a9d4df8469bfd386938f4d71543734ae0cf0398630461085f02::vault::Vault<T0>>(arg1);
        let v10 = 0x2::object::id_to_address(&v9);
        assert!(0x1::vector::contains<address>(&v8, &v10), 1700);
        let v11 = 0x1269ebf4edc63a9d4df8469bfd386938f4d71543734ae0cf0398630461085f02::decimals::to_u64(0x1269ebf4edc63a9d4df8469bfd386938f4d71543734ae0cf0398630461085f02::decimals::div(v1, 0x1269ebf4edc63a9d4df8469bfd386938f4d71543734ae0cf0398630461085f02::price_registry::get_price_by_asset<T0>(arg4, arg2, arg6)), 0x1269ebf4edc63a9d4df8469bfd386938f4d71543734ae0cf0398630461085f02::asset_registry::decimals(0x1269ebf4edc63a9d4df8469bfd386938f4d71543734ae0cf0398630461085f02::asset_registry::get_asset<T0>(arg2)));
        assert!(v11 <= 0x2::coin::value<T0>(arg5), 1701);
        0x1269ebf4edc63a9d4df8469bfd386938f4d71543734ae0cf0398630461085f02::deposit::complete<T0>(0x1269ebf4edc63a9d4df8469bfd386938f4d71543734ae0cf0398630461085f02::deposit::deposit<T0>(arg1, arg2, 0x2::balance::split<T0>(0x2::coin::balance_mut<T0>(arg5), v11), arg4, arg6), arg2, arg3, arg1, v7, v4, v5, arg6, arg7);
        let v12 = 0x2::object::id<0x1269ebf4edc63a9d4df8469bfd386938f4d71543734ae0cf0398630461085f02::vault::Vault<T0>>(arg1);
        let v13 = DebtRepaid{
            creator          : v0,
            product_id       : v4,
            product_category : v5,
            fee_percentage   : v7,
            source_vault     : v3,
            target_vault     : 0x2::object::id_to_address(&v12),
            value            : v1,
        };
        0x2::event::emit<DebtRepaid>(v13);
    }

    public(friend) fun vault_id(arg0: &BorrowReceipt) : address {
        arg0.vault_id
    }

    // decompiled from Move bytecode v6
}

