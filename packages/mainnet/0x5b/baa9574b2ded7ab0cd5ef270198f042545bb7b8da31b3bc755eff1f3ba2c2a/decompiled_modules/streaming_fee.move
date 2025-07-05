module 0x5bbaa9574b2ded7ab0cd5ef270198f042545bb7b8da31b3bc755eff1f3ba2c2a::streaming_fee {
    struct StreamingFee has store {
        parent_id: address,
        parent_category: u64,
        checkpoint: u64,
        ter_sec: 0x5bbaa9574b2ded7ab0cd5ef270198f042545bb7b8da31b3bc755eff1f3ba2c2a::decimals::Decimal,
        distribution_tasks: 0x2::table::Table<u64, DistributionTaskGroup>,
    }

    struct DistributionTaskGroup has store {
        target_category: u64,
        source_category: u64,
        amount_to_distribute: 0x1::option::Option<0x5bbaa9574b2ded7ab0cd5ef270198f042545bb7b8da31b3bc755eff1f3ba2c2a::decimals::Decimal>,
        tasks: 0x2::table::Table<u64, DistributionTask>,
        cursor: u64,
    }

    struct DistributionTask has drop, store {
        destination_products: vector<address>,
        asset_id: u64,
        cursor: u64,
    }

    public(friend) fun new(arg0: &mut 0x5bbaa9574b2ded7ab0cd5ef270198f042545bb7b8da31b3bc755eff1f3ba2c2a::balances_registry::BalancesRegistry, arg1: address, arg2: u64, arg3: u64, arg4: &0x2::clock::Clock, arg5: &mut 0x2::tx_context::TxContext) : StreamingFee {
        let v0 = 0x2::clock::timestamp_ms(arg4);
        0x5bbaa9574b2ded7ab0cd5ef270198f042545bb7b8da31b3bc755eff1f3ba2c2a::balances_registry::add_historical_checkpoint(arg0, ((v0 / 1000 / 60) as u32), arg5);
        StreamingFee{
            parent_id          : arg1,
            parent_category    : arg2,
            checkpoint         : v0,
            ter_sec            : 0x5bbaa9574b2ded7ab0cd5ef270198f042545bb7b8da31b3bc755eff1f3ba2c2a::decimals::div(0x5bbaa9574b2ded7ab0cd5ef270198f042545bb7b8da31b3bc755eff1f3ba2c2a::decimals::from_percentage(arg3), 0x5bbaa9574b2ded7ab0cd5ef270198f042545bb7b8da31b3bc755eff1f3ba2c2a::decimals::from_u128_denominator(31536000, 1)),
            distribution_tasks : 0x2::table::new<u64, DistributionTaskGroup>(arg5),
        }
    }

    public(friend) fun checkpoint(arg0: &StreamingFee) : u64 {
        arg0.checkpoint
    }

    public(friend) fun distribute<T0>(arg0: &mut StreamingFee, arg1: &0x5bbaa9574b2ded7ab0cd5ef270198f042545bb7b8da31b3bc755eff1f3ba2c2a::asset_registry::AssetRegistry, arg2: &mut 0x5bbaa9574b2ded7ab0cd5ef270198f042545bb7b8da31b3bc755eff1f3ba2c2a::balances_registry::BalancesRegistry, arg3: &mut 0x5bbaa9574b2ded7ab0cd5ef270198f042545bb7b8da31b3bc755eff1f3ba2c2a::vault::Vault<T0>, arg4: 0x5bbaa9574b2ded7ab0cd5ef270198f042545bb7b8da31b3bc755eff1f3ba2c2a::decimals::Decimal, arg5: &mut 0x5bbaa9574b2ded7ab0cd5ef270198f042545bb7b8da31b3bc755eff1f3ba2c2a::fee_dispatcher::FeeDispatcher<T0>, arg6: u64, arg7: &0x2::clock::Clock, arg8: &mut 0x2::tx_context::TxContext) {
        let v0 = 0x5bbaa9574b2ded7ab0cd5ef270198f042545bb7b8da31b3bc755eff1f3ba2c2a::asset_registry::get_asset_id<T0>(arg1);
        if (!0x2::table::contains<u64, DistributionTaskGroup>(&arg0.distribution_tasks, v0)) {
            return
        };
        let v1 = 0x2::table::borrow_mut<u64, DistributionTaskGroup>(&mut arg0.distribution_tasks, v0);
        let v2 = if (0x1::option::is_none<0x5bbaa9574b2ded7ab0cd5ef270198f042545bb7b8da31b3bc755eff1f3ba2c2a::decimals::Decimal>(&v1.amount_to_distribute)) {
            let v3 = 0x5bbaa9574b2ded7ab0cd5ef270198f042545bb7b8da31b3bc755eff1f3ba2c2a::decimals::mul(0x5bbaa9574b2ded7ab0cd5ef270198f042545bb7b8da31b3bc755eff1f3ba2c2a::vault::balance_amount<T0>(arg3, arg1, arg0.parent_id), percentage(arg0, arg7));
            v1.amount_to_distribute = 0x1::option::some<0x5bbaa9574b2ded7ab0cd5ef270198f042545bb7b8da31b3bc755eff1f3ba2c2a::decimals::Decimal>(v3);
            v3
        } else {
            *0x1::option::borrow<0x5bbaa9574b2ded7ab0cd5ef270198f042545bb7b8da31b3bc755eff1f3ba2c2a::decimals::Decimal>(&v1.amount_to_distribute)
        };
        let v4 = 0x5bbaa9574b2ded7ab0cd5ef270198f042545bb7b8da31b3bc755eff1f3ba2c2a::vault::withdraw<T0>(arg3, arg1, arg2, arg0.parent_id, v2, v1.source_category, arg7, arg8);
        let v5 = ((arg0.checkpoint / 1000 / 60) as u32);
        let v6 = 0x5bbaa9574b2ded7ab0cd5ef270198f042545bb7b8da31b3bc755eff1f3ba2c2a::asset_registry::get_asset<T0>(arg1);
        let v7 = 0x5bbaa9574b2ded7ab0cd5ef270198f042545bb7b8da31b3bc755eff1f3ba2c2a::asset_registry::get_asset_id<T0>(arg1);
        let v8 = 0x2::table::borrow_mut<u64, DistributionTask>(&mut v1.tasks, v1.cursor);
        let v9 = if (v8.cursor + arg6 > 0x1::vector::length<address>(&v8.destination_products)) {
            0x1::vector::length<address>(&v8.destination_products)
        } else {
            v8.cursor + arg6
        };
        while (v8.cursor < v9) {
            let v10 = *0x1::vector::borrow<address>(&v8.destination_products, v8.cursor);
            let v11 = 0x2::object::id<0x5bbaa9574b2ded7ab0cd5ef270198f042545bb7b8da31b3bc755eff1f3ba2c2a::vault::Vault<T0>>(arg3);
            0x5bbaa9574b2ded7ab0cd5ef270198f042545bb7b8da31b3bc755eff1f3ba2c2a::fee_dispatcher::add_record<T0>(arg5, v10, v1.target_category, 0x2::object::id_to_address(&v11), 0x2::balance::split<T0>(&mut v4, 0x5bbaa9574b2ded7ab0cd5ef270198f042545bb7b8da31b3bc755eff1f3ba2c2a::decimals::to_u64(0x5bbaa9574b2ded7ab0cd5ef270198f042545bb7b8da31b3bc755eff1f3ba2c2a::decimals::mul(0x5bbaa9574b2ded7ab0cd5ef270198f042545bb7b8da31b3bc755eff1f3ba2c2a::decimals::mul(v2, 0x5bbaa9574b2ded7ab0cd5ef270198f042545bb7b8da31b3bc755eff1f3ba2c2a::decimals::div(0x5bbaa9574b2ded7ab0cd5ef270198f042545bb7b8da31b3bc755eff1f3ba2c2a::balances_registry::average_balance(arg2, arg1, v10, v7, v5, arg7), 0x5bbaa9574b2ded7ab0cd5ef270198f042545bb7b8da31b3bc755eff1f3ba2c2a::balances_registry::average_total(arg2, arg1, v1.target_category, v7, v5, arg7))), arg4), 0x5bbaa9574b2ded7ab0cd5ef270198f042545bb7b8da31b3bc755eff1f3ba2c2a::asset_registry::decimals(v6))));
            v8.cursor = v8.cursor + 1;
        };
        *0x1::option::borrow_mut<0x5bbaa9574b2ded7ab0cd5ef270198f042545bb7b8da31b3bc755eff1f3ba2c2a::decimals::Decimal>(&mut v1.amount_to_distribute) = 0x5bbaa9574b2ded7ab0cd5ef270198f042545bb7b8da31b3bc755eff1f3ba2c2a::decimals::from_u64(0x2::balance::value<T0>(&v4), 0x5bbaa9574b2ded7ab0cd5ef270198f042545bb7b8da31b3bc755eff1f3ba2c2a::asset_registry::decimals(v6));
        if (v8.cursor >= 0x1::vector::length<address>(&v8.destination_products)) {
            0x2::table::remove<u64, DistributionTask>(&mut v1.tasks, v1.cursor);
            v1.cursor = v1.cursor + 1;
        };
        if (0x2::table::length<u64, DistributionTask>(&v1.tasks) == 0) {
            let DistributionTaskGroup {
                target_category      : _,
                source_category      : _,
                amount_to_distribute : _,
                tasks                : v15,
                cursor               : _,
            } = 0x2::table::remove<u64, DistributionTaskGroup>(&mut arg0.distribution_tasks, v7);
            0x2::table::destroy_empty<u64, DistributionTask>(v15);
            0x5bbaa9574b2ded7ab0cd5ef270198f042545bb7b8da31b3bc755eff1f3ba2c2a::vault::add_fee_balance<T0>(arg3, arg1, arg2, arg0.parent_id, 0x5bbaa9574b2ded7ab0cd5ef270198f042545bb7b8da31b3bc755eff1f3ba2c2a::decimals::from_u64(0x2::balance::value<T0>(&v4), 0x5bbaa9574b2ded7ab0cd5ef270198f042545bb7b8da31b3bc755eff1f3ba2c2a::asset_registry::decimals(v6)));
        };
        if (0x2::table::length<u64, DistributionTaskGroup>(&arg0.distribution_tasks) == 0) {
            reset_checkpoint(arg0, arg2, arg7, arg8);
        };
        0x5bbaa9574b2ded7ab0cd5ef270198f042545bb7b8da31b3bc755eff1f3ba2c2a::vault::deposit_product_balance<T0>(arg3, arg1, arg2, arg0.parent_id, v4, arg0.parent_category, arg7, arg8);
    }

    public(friend) fun drop(arg0: StreamingFee) {
        let StreamingFee {
            parent_id          : _,
            parent_category    : _,
            checkpoint         : _,
            ter_sec            : _,
            distribution_tasks : v4,
        } = arg0;
        0x2::table::destroy_empty<u64, DistributionTaskGroup>(v4);
    }

    public(friend) fun percentage(arg0: &StreamingFee, arg1: &0x2::clock::Clock) : 0x5bbaa9574b2ded7ab0cd5ef270198f042545bb7b8da31b3bc755eff1f3ba2c2a::decimals::Decimal {
        0x5bbaa9574b2ded7ab0cd5ef270198f042545bb7b8da31b3bc755eff1f3ba2c2a::decimals::mul(0x5bbaa9574b2ded7ab0cd5ef270198f042545bb7b8da31b3bc755eff1f3ba2c2a::decimals::from_u64_denominator(0x2::clock::timestamp_ms(arg1) - arg0.checkpoint, 1000), arg0.ter_sec)
    }

    public(friend) fun reset_checkpoint(arg0: &mut StreamingFee, arg1: &mut 0x5bbaa9574b2ded7ab0cd5ef270198f042545bb7b8da31b3bc755eff1f3ba2c2a::balances_registry::BalancesRegistry, arg2: &0x2::clock::Clock, arg3: &mut 0x2::tx_context::TxContext) {
        0x5bbaa9574b2ded7ab0cd5ef270198f042545bb7b8da31b3bc755eff1f3ba2c2a::balances_registry::delete_historical_checkpoint(arg1, ((arg0.checkpoint / 100 / 60) as u32));
        let v0 = 0x2::clock::timestamp_ms(arg2);
        arg0.checkpoint = v0;
        0x5bbaa9574b2ded7ab0cd5ef270198f042545bb7b8da31b3bc755eff1f3ba2c2a::balances_registry::add_historical_checkpoint(arg1, ((v0 / 1000 / 60) as u32), arg3);
    }

    public(friend) fun start_distribution(arg0: &mut StreamingFee, arg1: &0x5bbaa9574b2ded7ab0cd5ef270198f042545bb7b8da31b3bc755eff1f3ba2c2a::balances_registry::BalancesRegistry, arg2: u64, arg3: u64, arg4: vector<u64>, arg5: &mut 0x2::tx_context::TxContext) {
        assert!(0x2::table::length<u64, DistributionTaskGroup>(&arg0.distribution_tasks) == 0, 900);
        let v0 = 0;
        while (v0 < 0x1::vector::length<u64>(&arg4)) {
            let v1 = *0x1::vector::borrow<u64>(&arg4, v0);
            if (0x5bbaa9574b2ded7ab0cd5ef270198f042545bb7b8da31b3bc755eff1f3ba2c2a::balances_registry::product_asset_category_exists(arg1, arg2, v1)) {
                let v2 = DistributionTaskGroup{
                    target_category      : arg2,
                    source_category      : arg3,
                    amount_to_distribute : 0x1::option::none<0x5bbaa9574b2ded7ab0cd5ef270198f042545bb7b8da31b3bc755eff1f3ba2c2a::decimals::Decimal>(),
                    tasks                : 0x2::table::new<u64, DistributionTask>(arg5),
                    cursor               : 0,
                };
                let v3 = 0x5bbaa9574b2ded7ab0cd5ef270198f042545bb7b8da31b3bc755eff1f3ba2c2a::balances_registry::products(arg1, v1, arg2);
                let v4 = 0;
                while (v4 < 0x2::table::length<u64, vector<address>>(v3)) {
                    let v5 = DistributionTask{
                        destination_products : *0x2::table::borrow<u64, vector<address>>(v3, v4),
                        asset_id             : v1,
                        cursor               : 0,
                    };
                    0x2::table::add<u64, DistributionTask>(&mut v2.tasks, v4, v5);
                    v4 = v4 + 1;
                };
                0x2::table::add<u64, DistributionTaskGroup>(&mut arg0.distribution_tasks, v1, v2);
            };
            v0 = v0 + 1;
        };
    }

    // decompiled from Move bytecode v6
}

