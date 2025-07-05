module 0x1269ebf4edc63a9d4df8469bfd386938f4d71543734ae0cf0398630461085f02::balances_registry {
    struct AverageBalances has store {
        totals: 0x2::table::Table<u128, u128>,
        balances: 0x2::table::Table<address, 0x2::vec_map::VecMap<u64, u128>>,
    }

    struct BalancesRegistry has store, key {
        id: 0x2::object::UID,
        totals: 0x2::table::Table<u128, u64>,
        products_index: 0x2::table::Table<u128, 0x2::table::Table<u64, vector<address>>>,
        historical_checkpoints: vector<u32>,
        historical_balances: 0x2::table::Table<u32, AverageBalances>,
        product_balances: 0x2::table::Table<address, 0x2::vec_map::VecMap<u64, u64>>,
        product_fees: 0x2::table::Table<address, 0x2::vec_map::VecMap<u64, u64>>,
    }

    public(friend) fun new(arg0: &mut 0x2::tx_context::TxContext) {
        let v0 = BalancesRegistry{
            id                     : 0x2::object::new(arg0),
            totals                 : 0x2::table::new<u128, u64>(arg0),
            products_index         : 0x2::table::new<u128, 0x2::table::Table<u64, vector<address>>>(arg0),
            historical_checkpoints : 0x1::vector::empty<u32>(),
            historical_balances    : 0x2::table::new<u32, AverageBalances>(arg0),
            product_balances       : 0x2::table::new<address, 0x2::vec_map::VecMap<u64, u64>>(arg0),
            product_fees           : 0x2::table::new<address, 0x2::vec_map::VecMap<u64, u64>>(arg0),
        };
        0x2::transfer::public_share_object<BalancesRegistry>(v0);
    }

    public(friend) fun add_fee<T0>(arg0: &mut BalancesRegistry, arg1: &0x1269ebf4edc63a9d4df8469bfd386938f4d71543734ae0cf0398630461085f02::asset_registry::AssetRegistry, arg2: u64, arg3: address) {
        if (!0x2::table::contains<address, 0x2::vec_map::VecMap<u64, u64>>(&arg0.product_fees, arg3)) {
            0x2::table::add<address, 0x2::vec_map::VecMap<u64, u64>>(&mut arg0.product_fees, arg3, 0x2::vec_map::empty<u64, u64>());
        };
        let v0 = 0x2::table::borrow_mut<address, 0x2::vec_map::VecMap<u64, u64>>(&mut arg0.product_fees, arg3);
        let v1 = 0x1269ebf4edc63a9d4df8469bfd386938f4d71543734ae0cf0398630461085f02::asset_registry::get_asset_id<T0>(arg1);
        if (0x2::vec_map::contains<u64, u64>(v0, &v1)) {
            let v2 = 0x2::vec_map::get_mut<u64, u64>(v0, &v1);
            *v2 = *v2 + arg2;
        } else {
            0x2::vec_map::insert<u64, u64>(v0, v1, arg2);
        };
    }

    public(friend) fun add_historical_checkpoint(arg0: &mut BalancesRegistry, arg1: u32, arg2: &mut 0x2::tx_context::TxContext) {
        let v0 = AverageBalances{
            totals   : 0x2::table::new<u128, u128>(arg2),
            balances : 0x2::table::new<address, 0x2::vec_map::VecMap<u64, u128>>(arg2),
        };
        0x2::table::add<u32, AverageBalances>(&mut arg0.historical_balances, arg1, v0);
        0x1::vector::push_back<u32>(&mut arg0.historical_checkpoints, arg1);
    }

    public fun average_balance(arg0: &BalancesRegistry, arg1: &0x1269ebf4edc63a9d4df8469bfd386938f4d71543734ae0cf0398630461085f02::asset_registry::AssetRegistry, arg2: address, arg3: u64, arg4: u32, arg5: &0x2::clock::Clock) : 0x1269ebf4edc63a9d4df8469bfd386938f4d71543734ae0cf0398630461085f02::decimals::Decimal {
        let v0 = *0x2::vec_map::get<u64, u64>(0x2::table::borrow<address, 0x2::vec_map::VecMap<u64, u64>>(&arg0.product_balances, arg2), &arg3);
        let v1 = if (0x2::table::contains<address, 0x2::vec_map::VecMap<u64, u128>>(&0x2::table::borrow<u32, AverageBalances>(&arg0.historical_balances, arg4).balances, arg2)) {
            let v2 = *0x2::table::borrow<address, 0x2::vec_map::VecMap<u64, u128>>(&0x2::table::borrow<u32, AverageBalances>(&arg0.historical_balances, arg4).balances, arg2);
            if (0x2::vec_map::contains<u64, u128>(&v2, &arg3)) {
                *0x2::vec_map::get<u64, u128>(&v2, &arg3)
            } else {
                pack_acc_minute((v0 as u128), arg4)
            }
        } else {
            pack_acc_minute((v0 as u128), arg4)
        };
        let (v3, v4) = unpack_acc_minute(v1);
        let v5 = ((0x2::clock::timestamp_ms(arg5) / 1000 / 60) as u32);
        let v6 = if (arg4 > v4) {
            v5 - arg4
        } else {
            1
        };
        0x1269ebf4edc63a9d4df8469bfd386938f4d71543734ae0cf0398630461085f02::decimals::div(0x1269ebf4edc63a9d4df8469bfd386938f4d71543734ae0cf0398630461085f02::decimals::from_u128(v3 + (v0 as u128) * ((v5 - v4) as u128), 0x1269ebf4edc63a9d4df8469bfd386938f4d71543734ae0cf0398630461085f02::asset_registry::decimals(0x1269ebf4edc63a9d4df8469bfd386938f4d71543734ae0cf0398630461085f02::asset_registry::get_asset_unsafe(arg1, arg3))), 0x1269ebf4edc63a9d4df8469bfd386938f4d71543734ae0cf0398630461085f02::decimals::from_int((v6 as u64)))
    }

    public fun average_total(arg0: &BalancesRegistry, arg1: &0x1269ebf4edc63a9d4df8469bfd386938f4d71543734ae0cf0398630461085f02::asset_registry::AssetRegistry, arg2: u64, arg3: u64, arg4: u32, arg5: &0x2::clock::Clock) : 0x1269ebf4edc63a9d4df8469bfd386938f4d71543734ae0cf0398630461085f02::decimals::Decimal {
        let v0 = get_id(arg2, arg3);
        let v1 = *0x2::table::borrow<u128, u64>(&arg0.totals, v0);
        let v2 = 0x2::table::borrow<u32, AverageBalances>(&arg0.historical_balances, arg4);
        let v3 = if (0x2::table::contains<u128, u128>(&v2.totals, v0)) {
            *0x2::table::borrow<u128, u128>(&v2.totals, v0)
        } else {
            pack_acc_minute((v1 as u128), arg4)
        };
        let (v4, v5) = unpack_acc_minute(v3);
        let v6 = ((0x2::clock::timestamp_ms(arg5) / 1000 / 60) as u32);
        let v7 = if (arg4 > v5) {
            v6 - arg4
        } else {
            1
        };
        0x1269ebf4edc63a9d4df8469bfd386938f4d71543734ae0cf0398630461085f02::decimals::div(0x1269ebf4edc63a9d4df8469bfd386938f4d71543734ae0cf0398630461085f02::decimals::from_u128(v4 + (v1 as u128) * ((v6 - v5) as u128), 0x1269ebf4edc63a9d4df8469bfd386938f4d71543734ae0cf0398630461085f02::asset_registry::decimals(0x1269ebf4edc63a9d4df8469bfd386938f4d71543734ae0cf0398630461085f02::asset_registry::get_asset_unsafe(arg1, arg3))), 0x1269ebf4edc63a9d4df8469bfd386938f4d71543734ae0cf0398630461085f02::decimals::from_int((v7 as u64)))
    }

    public(friend) fun delete_historical_checkpoint(arg0: &mut BalancesRegistry, arg1: u32) {
        let AverageBalances {
            totals   : v0,
            balances : v1,
        } = 0x2::table::remove<u32, AverageBalances>(&mut arg0.historical_balances, arg1);
        let v2 = &arg0.historical_checkpoints;
        let v3 = 0;
        let v4;
        while (v3 < 0x1::vector::length<u32>(v2)) {
            if (0x1::vector::borrow<u32>(v2, v3) == &arg1) {
                v4 = 0x1::option::some<u64>(v3);
                /* label 6 */
                assert!(0x1::option::is_some<u64>(&v4), 400);
                0x1::vector::remove<u32>(&mut arg0.historical_checkpoints, *0x1::option::borrow<u64>(&v4));
                0x2::table::drop<u128, u128>(v0);
                0x2::table::drop<address, 0x2::vec_map::VecMap<u64, u128>>(v1);
                return
            };
            v3 = v3 + 1;
        };
        v4 = 0x1::option::none<u64>();
        /* goto 6 */
    }

    fun get_id(arg0: u64, arg1: u64) : u128 {
        (arg0 as u128) << 64 | (arg1 as u128)
    }

    fun pack_acc_minute(arg0: u128, arg1: u32) : u128 {
        arg0 << 32 | (arg1 as u128)
    }

    public fun product_asset_category_exists(arg0: &BalancesRegistry, arg1: u64, arg2: u64) : bool {
        0x2::table::contains<u128, 0x2::table::Table<u64, vector<address>>>(&arg0.products_index, get_id(arg1, arg2))
    }

    public fun product_balance(arg0: &BalancesRegistry, arg1: address) : &0x2::vec_map::VecMap<u64, u64> {
        0x2::table::borrow<address, 0x2::vec_map::VecMap<u64, u64>>(&arg0.product_balances, arg1)
    }

    public fun product_fee(arg0: &BalancesRegistry, arg1: address) : &0x2::vec_map::VecMap<u64, u64> {
        0x2::table::borrow<address, 0x2::vec_map::VecMap<u64, u64>>(&arg0.product_fees, arg1)
    }

    public fun products(arg0: &BalancesRegistry, arg1: u64, arg2: u64) : &0x2::table::Table<u64, vector<address>> {
        0x2::table::borrow<u128, 0x2::table::Table<u64, vector<address>>>(&arg0.products_index, get_id(arg2, arg1))
    }

    fun register_product(arg0: &mut BalancesRegistry, arg1: u64, arg2: address, arg3: u64, arg4: &mut 0x2::tx_context::TxContext) {
        if (!0x2::table::contains<address, 0x2::vec_map::VecMap<u64, u64>>(&arg0.product_balances, arg2)) {
            0x2::table::add<address, 0x2::vec_map::VecMap<u64, u64>>(&mut arg0.product_balances, arg2, 0x2::vec_map::empty<u64, u64>());
        };
        let v0 = get_id(arg3, arg1);
        if (!0x2::table::contains<u128, 0x2::table::Table<u64, vector<address>>>(&arg0.products_index, v0)) {
            0x2::table::add<u128, 0x2::table::Table<u64, vector<address>>>(&mut arg0.products_index, v0, 0x2::table::new<u64, vector<address>>(arg4));
        };
        let v1 = 0x2::table::borrow_mut<u128, 0x2::table::Table<u64, vector<address>>>(&mut arg0.products_index, v0);
        let v2 = 0x2::table::length<u64, vector<address>>(v1);
        let v3 = if (v2 == 0) {
            true
        } else if (!0x2::table::contains<u64, vector<address>>(v1, v2)) {
            true
        } else {
            0x1::vector::length<address>(0x2::table::borrow<u64, vector<address>>(v1, v2 - 1)) == 4000
        };
        if (v3) {
            0x2::table::add<u64, vector<address>>(v1, v2, 0x1::vector::empty<address>());
        };
        0x1::vector::push_back<address>(0x2::table::borrow_mut<u64, vector<address>>(v1, v2), arg2);
    }

    public(friend) fun reset_fee<T0>(arg0: &mut BalancesRegistry, arg1: &0x1269ebf4edc63a9d4df8469bfd386938f4d71543734ae0cf0398630461085f02::asset_registry::AssetRegistry, arg2: address) {
        let v0 = 0x1269ebf4edc63a9d4df8469bfd386938f4d71543734ae0cf0398630461085f02::asset_registry::get_asset_id<T0>(arg1);
        *0x2::vec_map::get_mut<u64, u64>(0x2::table::borrow_mut<address, 0x2::vec_map::VecMap<u64, u64>>(&mut arg0.product_fees, arg2), &v0) = 0;
    }

    public(friend) fun set_balance<T0>(arg0: &mut BalancesRegistry, arg1: &0x1269ebf4edc63a9d4df8469bfd386938f4d71543734ae0cf0398630461085f02::asset_registry::AssetRegistry, arg2: u64, arg3: address, arg4: u64, arg5: &0x2::clock::Clock, arg6: &mut 0x2::tx_context::TxContext) {
        let v0 = 0x1269ebf4edc63a9d4df8469bfd386938f4d71543734ae0cf0398630461085f02::asset_registry::get_asset_id<T0>(arg1);
        if (!0x2::table::contains<address, 0x2::vec_map::VecMap<u64, u64>>(&arg0.product_balances, arg3) || !product_asset_category_exists(arg0, arg4, v0)) {
            register_product(arg0, v0, arg3, arg4, arg6);
        };
        let v1 = 0x2::table::borrow_mut<address, 0x2::vec_map::VecMap<u64, u64>>(&mut arg0.product_balances, arg3);
        let v2 = 0x2::vec_map::try_get<u64, u64>(v1, &v0);
        let v3 = get_id(arg4, v0);
        let v4 = if (!0x2::table::contains<u128, u64>(&arg0.totals, v3)) {
            0x2::table::add<u128, u64>(&mut arg0.totals, v3, arg2);
            arg2
        } else {
            let v5 = 0x1::option::get_with_default<u64>(&v2, 0);
            let v6 = 0x2::table::borrow_mut<u128, u64>(&mut arg0.totals, v3);
            if (v5 <= arg2) {
                *v6 = *v6 + arg2 - v5;
            } else {
                *v6 = *v6 - v5 - arg2;
            };
            *v6
        };
        let v7 = if (0x1::option::is_some<u64>(&v2)) {
            let v8 = 0x2::vec_map::get_mut<u64, u64>(v1, &v0);
            *v8 = arg2;
            *v8
        } else {
            0x2::vec_map::insert<u64, u64>(v1, v0, arg2);
            arg2
        };
        let v9 = 0;
        while (v9 < 0x1::vector::length<u32>(&arg0.historical_checkpoints)) {
            let v10 = 0x1::vector::borrow<u32>(&arg0.historical_checkpoints, v9);
            assert!(0x2::table::contains<u32, AverageBalances>(&arg0.historical_balances, *v10), 400);
            let v11 = 0x2::table::borrow_mut<u32, AverageBalances>(&mut arg0.historical_balances, *v10);
            update_average_balances<T0>(v11, arg1, arg3, arg4, v7, v4, arg5);
            v9 = v9 + 1;
        };
    }

    public(friend) fun total(arg0: &BalancesRegistry, arg1: u64, arg2: u64) : u64 {
        let v0 = get_id(arg1, arg2);
        if (0x2::table::contains<u128, u64>(&arg0.totals, v0)) {
            return *0x2::table::borrow<u128, u64>(&arg0.totals, v0)
        };
        0
    }

    fun unpack_acc_minute(arg0: u128) : (u128, u32) {
        (arg0 >> 32, ((arg0 & 4294967295) as u32))
    }

    fun update_accumulator_minute(arg0: u128, arg1: u32, arg2: u32, arg3: u64) : u128 {
        let v0 = if (arg2 > arg1) {
            arg2 - arg1
        } else {
            0
        };
        pack_acc_minute(arg0 + (arg3 as u128) * (v0 as u128), arg2)
    }

    fun update_average_balances<T0>(arg0: &mut AverageBalances, arg1: &0x1269ebf4edc63a9d4df8469bfd386938f4d71543734ae0cf0398630461085f02::asset_registry::AssetRegistry, arg2: address, arg3: u64, arg4: u64, arg5: u64, arg6: &0x2::clock::Clock) {
        let v0 = 0x1269ebf4edc63a9d4df8469bfd386938f4d71543734ae0cf0398630461085f02::asset_registry::get_asset_id<T0>(arg1);
        let v1 = 0x2::clock::timestamp_ms(arg6) / 1000 / 60;
        if (!0x2::table::contains<address, 0x2::vec_map::VecMap<u64, u128>>(&arg0.balances, arg2)) {
            0x2::table::add<address, 0x2::vec_map::VecMap<u64, u128>>(&mut arg0.balances, arg2, 0x2::vec_map::empty<u64, u128>());
        };
        let v2 = 0x2::table::borrow_mut<address, 0x2::vec_map::VecMap<u64, u128>>(&mut arg0.balances, arg2);
        let v3 = 0x2::vec_map::try_get<u64, u128>(v2, &v0);
        if (0x1::option::is_some<u128>(&v3)) {
            let (v4, v5) = unpack_acc_minute(*0x1::option::borrow<u128>(&v3));
            *0x1::option::borrow_mut<u128>(&mut v3) = update_accumulator_minute(v4, v5, (v1 as u32), arg4);
        } else {
            0x2::vec_map::insert<u64, u128>(v2, v0, pack_acc_minute((arg4 as u128), (v1 as u32)));
        };
        let v6 = get_id(arg3, v0);
        if (0x2::table::contains<u128, u128>(&arg0.totals, v6)) {
            let (v7, v8) = unpack_acc_minute(*0x2::table::borrow<u128, u128>(&arg0.totals, v6));
            *0x2::table::borrow_mut<u128, u128>(&mut arg0.totals, v6) = update_accumulator_minute(v7, v8, (v1 as u32), arg5);
        } else {
            0x2::table::add<u128, u128>(&mut arg0.totals, v6, pack_acc_minute((arg5 as u128), (v1 as u32)));
        };
    }

    // decompiled from Move bytecode v6
}

