module 0x1269ebf4edc63a9d4df8469bfd386938f4d71543734ae0cf0398630461085f02::weight {
    struct AllocationDrift has copy, drop {
        sign: bool,
        percentage: 0x1269ebf4edc63a9d4df8469bfd386938f4d71543734ae0cf0398630461085f02::decimals::Decimal,
        asset_id: u64,
        asset_balance: 0x1269ebf4edc63a9d4df8469bfd386938f4d71543734ae0cf0398630461085f02::decimals::Decimal,
        value: 0x1269ebf4edc63a9d4df8469bfd386938f4d71543734ae0cf0398630461085f02::decimals::Decimal,
        vault_id: address,
    }

    struct AllocationMovement has copy, drop {
        percentage: 0x1269ebf4edc63a9d4df8469bfd386938f4d71543734ae0cf0398630461085f02::decimals::Decimal,
        source_id: u64,
        target_id: u64,
        source_vault: address,
        target_vault: address,
    }

    fun allocation_drift<T0>(arg0: &0x1269ebf4edc63a9d4df8469bfd386938f4d71543734ae0cf0398630461085f02::index::Index<T0>, arg1: &0x1269ebf4edc63a9d4df8469bfd386938f4d71543734ae0cf0398630461085f02::asset_registry::AssetRegistry, arg2: &0x1269ebf4edc63a9d4df8469bfd386938f4d71543734ae0cf0398630461085f02::price_registry::PriceRegistry, arg3: &0x1269ebf4edc63a9d4df8469bfd386938f4d71543734ae0cf0398630461085f02::balances_registry::BalancesRegistry, arg4: 0x1269ebf4edc63a9d4df8469bfd386938f4d71543734ae0cf0398630461085f02::decimals::Decimal, arg5: &0x2::clock::Clock) : 0x2::vec_map::VecMap<u64, AllocationDrift> {
        let v0 = 0x2::object::id<0x1269ebf4edc63a9d4df8469bfd386938f4d71543734ae0cf0398630461085f02::index::Index<T0>>(arg0);
        let v1 = 0x2::object::id_to_address(&v0);
        let v2 = 0x1269ebf4edc63a9d4df8469bfd386938f4d71543734ae0cf0398630461085f02::balances_registry::product_balance(arg3, v1);
        let v3 = 0x1269ebf4edc63a9d4df8469bfd386938f4d71543734ae0cf0398630461085f02::balances_registry::product_fee(arg3, v1);
        let v4 = 0x2::vec_map::empty<u64, AllocationDrift>();
        if (0x1269ebf4edc63a9d4df8469bfd386938f4d71543734ae0cf0398630461085f02::decimals::is_zero(arg4)) {
            return v4
        };
        let v5 = 0x2::vec_map::keys<u64, u64>(v2);
        0x1::vector::reverse<u64>(&mut v5);
        let v6 = 0;
        while (v6 < 0x1::vector::length<u64>(&v5)) {
            let v7 = 0x1::vector::pop_back<u64>(&mut v5);
            let v8 = 0x1269ebf4edc63a9d4df8469bfd386938f4d71543734ae0cf0398630461085f02::index::assets<T0>(arg0);
            let (v9, v10) = 0x1::vector::index_of<u64>(&v8, &v7);
            let v11 = 0x1269ebf4edc63a9d4df8469bfd386938f4d71543734ae0cf0398630461085f02::index::subscribed_vaults<T0>(arg0);
            assert!(v9, 1001);
            let v12 = 0x1269ebf4edc63a9d4df8469bfd386938f4d71543734ae0cf0398630461085f02::asset_registry::get_asset_unsafe(arg1, v7);
            let v13 = 0x1269ebf4edc63a9d4df8469bfd386938f4d71543734ae0cf0398630461085f02::decimals::sub(0x1269ebf4edc63a9d4df8469bfd386938f4d71543734ae0cf0398630461085f02::decimals::from_u64(*0x2::vec_map::get<u64, u64>(v2, &v7), 0x1269ebf4edc63a9d4df8469bfd386938f4d71543734ae0cf0398630461085f02::asset_registry::decimals(v12)), 0x1269ebf4edc63a9d4df8469bfd386938f4d71543734ae0cf0398630461085f02::decimals::from_u64(*0x2::vec_map::get<u64, u64>(v3, &v7), 0x1269ebf4edc63a9d4df8469bfd386938f4d71543734ae0cf0398630461085f02::asset_registry::decimals(v12)));
            let v14 = 0x1269ebf4edc63a9d4df8469bfd386938f4d71543734ae0cf0398630461085f02::decimals::mul(v13, 0x1269ebf4edc63a9d4df8469bfd386938f4d71543734ae0cf0398630461085f02::price_registry::get_price_by_asset_id(arg2, v7, arg5));
            let v15 = 0x1269ebf4edc63a9d4df8469bfd386938f4d71543734ae0cf0398630461085f02::decimals::div(v14, arg4);
            let v16 = 0x1269ebf4edc63a9d4df8469bfd386938f4d71543734ae0cf0398630461085f02::index::weights<T0>(arg0);
            let v17 = 0x1269ebf4edc63a9d4df8469bfd386938f4d71543734ae0cf0398630461085f02::decimals::from_percentage(*0x1::vector::borrow<u64>(&v16, v10));
            if (0x1269ebf4edc63a9d4df8469bfd386938f4d71543734ae0cf0398630461085f02::decimals::gt(v17, v15)) {
                let v18 = AllocationDrift{
                    sign          : false,
                    percentage    : 0x1269ebf4edc63a9d4df8469bfd386938f4d71543734ae0cf0398630461085f02::decimals::sub(v17, v15),
                    asset_id      : v7,
                    asset_balance : v13,
                    value         : v14,
                    vault_id      : *0x1::vector::borrow<address>(&v11, v10),
                };
                0x2::vec_map::insert<u64, AllocationDrift>(&mut v4, v7, v18);
            } else if (0x1269ebf4edc63a9d4df8469bfd386938f4d71543734ae0cf0398630461085f02::decimals::lt(v17, v15)) {
                let v19 = AllocationDrift{
                    sign          : true,
                    percentage    : 0x1269ebf4edc63a9d4df8469bfd386938f4d71543734ae0cf0398630461085f02::decimals::sub(v15, v17),
                    asset_id      : v7,
                    asset_balance : v13,
                    value         : v14,
                    vault_id      : *0x1::vector::borrow<address>(&v11, v10),
                };
                0x2::vec_map::insert<u64, AllocationDrift>(&mut v4, v7, v19);
            };
            v6 = v6 + 1;
        };
        0x1::vector::destroy_empty<u64>(v5);
        v4
    }

    public fun rebalance<T0>(arg0: &mut 0x1269ebf4edc63a9d4df8469bfd386938f4d71543734ae0cf0398630461085f02::index::Index<T0>, arg1: &0x1269ebf4edc63a9d4df8469bfd386938f4d71543734ae0cf0398630461085f02::asset_registry::AssetRegistry, arg2: &0x1269ebf4edc63a9d4df8469bfd386938f4d71543734ae0cf0398630461085f02::balances_registry::BalancesRegistry, arg3: &0x1269ebf4edc63a9d4df8469bfd386938f4d71543734ae0cf0398630461085f02::price_registry::PriceRegistry, arg4: &mut 0x1269ebf4edc63a9d4df8469bfd386938f4d71543734ae0cf0398630461085f02::dispatcher::Dispatcher, arg5: vector<u64>, arg6: &0x2::clock::Clock, arg7: &0x1269ebf4edc63a9d4df8469bfd386938f4d71543734ae0cf0398630461085f02::admin::AdminCap) {
        let v0 = 0x1269ebf4edc63a9d4df8469bfd386938f4d71543734ae0cf0398630461085f02::price_registry::index_nav<T0>(arg0, arg2, arg3, arg1, arg6);
        0x1269ebf4edc63a9d4df8469bfd386938f4d71543734ae0cf0398630461085f02::index::set_weights<T0>(arg0, arg5);
        0x1269ebf4edc63a9d4df8469bfd386938f4d71543734ae0cf0398630461085f02::dispatcher::empty(arg4);
        let v1 = 0x2::object::id<0x1269ebf4edc63a9d4df8469bfd386938f4d71543734ae0cf0398630461085f02::index::Index<T0>>(arg0);
        let v2 = 0x2::object::id_to_address(&v1);
        let v3 = allocation_drift<T0>(arg0, arg1, arg3, arg2, v0, arg6);
        let v4 = 0x1::vector::empty<AllocationDrift>();
        let v5 = 0x1::vector::empty<AllocationDrift>();
        let v6 = 0x1::vector::empty<AllocationMovement>();
        let v7 = 0x2::vec_map::keys<u64, AllocationDrift>(&v3);
        0x1::vector::reverse<u64>(&mut v7);
        let v8 = 0;
        while (v8 < 0x1::vector::length<u64>(&v7)) {
            let v9 = 0x1::vector::pop_back<u64>(&mut v7);
            let v10 = 0x2::vec_map::get<u64, AllocationDrift>(&v3, &v9);
            if (v10.sign) {
                0x1::vector::push_back<AllocationDrift>(&mut v5, *v10);
            } else {
                0x1::vector::push_back<AllocationDrift>(&mut v4, *v10);
            };
            v8 = v8 + 1;
        };
        0x1::vector::destroy_empty<u64>(v7);
        let v11 = &mut v4;
        let v12 = 0;
        while (v12 < 0x1::vector::length<AllocationDrift>(v11)) {
            let v13 = 0x1::vector::borrow_mut<AllocationDrift>(v11, v12);
            let v14 = 0;
            while (0x1269ebf4edc63a9d4df8469bfd386938f4d71543734ae0cf0398630461085f02::decimals::to_percentage(v13.percentage) > 0) {
                let v15 = 0x1::vector::borrow_mut<AllocationDrift>(&mut v5, v14);
                if (0x1269ebf4edc63a9d4df8469bfd386938f4d71543734ae0cf0398630461085f02::decimals::to_percentage(v15.percentage) > 0) {
                    if (0x1269ebf4edc63a9d4df8469bfd386938f4d71543734ae0cf0398630461085f02::decimals::ge(v15.percentage, v13.percentage)) {
                        let v16 = AllocationMovement{
                            percentage   : v13.percentage,
                            source_id    : v15.asset_id,
                            target_id    : v13.asset_id,
                            source_vault : v15.vault_id,
                            target_vault : v13.vault_id,
                        };
                        0x1::vector::push_back<AllocationMovement>(&mut v6, v16);
                        v15.percentage = 0x1269ebf4edc63a9d4df8469bfd386938f4d71543734ae0cf0398630461085f02::decimals::sub(v15.percentage, v13.percentage);
                        v13.percentage = 0x1269ebf4edc63a9d4df8469bfd386938f4d71543734ae0cf0398630461085f02::decimals::zero();
                    } else {
                        let v17 = AllocationMovement{
                            percentage   : v15.percentage,
                            source_id    : v15.asset_id,
                            target_id    : v13.asset_id,
                            source_vault : v15.vault_id,
                            target_vault : v13.vault_id,
                        };
                        0x1::vector::push_back<AllocationMovement>(&mut v6, v17);
                        v13.percentage = 0x1269ebf4edc63a9d4df8469bfd386938f4d71543734ae0cf0398630461085f02::decimals::sub(v13.percentage, v15.percentage);
                        v15.percentage = 0x1269ebf4edc63a9d4df8469bfd386938f4d71543734ae0cf0398630461085f02::decimals::zero();
                    };
                };
                v14 = v14 + 1;
            };
            v12 = v12 + 1;
        };
        let v18 = 0;
        while (v18 < 0x1::vector::length<AllocationMovement>(&v6)) {
            let v19 = 0x1::vector::pop_back<AllocationMovement>(&mut v6);
            let v20 = 0x1269ebf4edc63a9d4df8469bfd386938f4d71543734ae0cf0398630461085f02::price_registry::get_price_by_asset_id(arg3, v19.source_id, arg6);
            let v21 = 0x1269ebf4edc63a9d4df8469bfd386938f4d71543734ae0cf0398630461085f02::decimals::div(0x1269ebf4edc63a9d4df8469bfd386938f4d71543734ae0cf0398630461085f02::decimals::mul(v0, v19.percentage), v20);
            let v22 = 0x1269ebf4edc63a9d4df8469bfd386938f4d71543734ae0cf0398630461085f02::dispatcher::new_transfer_details(v19.source_vault, v2, 0x1269ebf4edc63a9d4df8469bfd386938f4d71543734ae0cf0398630461085f02::vault::index_product());
            let v23 = 0x1269ebf4edc63a9d4df8469bfd386938f4d71543734ae0cf0398630461085f02::dispatcher::new_transfer_details(v19.target_vault, v2, 0x1269ebf4edc63a9d4df8469bfd386938f4d71543734ae0cf0398630461085f02::vault::index_product());
            0x2::event::emit<AllocationMovement>(v19);
            if (!0x1269ebf4edc63a9d4df8469bfd386938f4d71543734ae0cf0398630461085f02::decimals::is_zero(v21)) {
                0x1269ebf4edc63a9d4df8469bfd386938f4d71543734ae0cf0398630461085f02::dispatcher::add_record(arg4, &v22, &v23, 1, v21, v20, 0x1269ebf4edc63a9d4df8469bfd386938f4d71543734ae0cf0398630461085f02::price_registry::get_price_by_asset_id(arg3, v19.target_id, arg6));
            };
            v18 = v18 + 1;
        };
        0x1::vector::destroy_empty<AllocationMovement>(v6);
    }

    // decompiled from Move bytecode v6
}

