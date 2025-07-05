module 0x1269ebf4edc63a9d4df8469bfd386938f4d71543734ae0cf0398630461085f02::price_registry {
    struct Price has drop, store {
        timestamp_secs: u64,
        price: u64,
        decimals: u8,
    }

    struct PriceRegistry has store, key {
        id: 0x2::object::UID,
        price_registry: 0x2::vec_map::VecMap<u64, Price>,
    }

    public(friend) fun new(arg0: &mut 0x2::tx_context::TxContext) {
        let v0 = PriceRegistry{
            id             : 0x2::object::new(arg0),
            price_registry : 0x2::vec_map::empty<u64, Price>(),
        };
        0x2::transfer::public_share_object<PriceRegistry>(v0);
    }

    public fun get_price_by_asset<T0>(arg0: &PriceRegistry, arg1: &0x1269ebf4edc63a9d4df8469bfd386938f4d71543734ae0cf0398630461085f02::asset_registry::AssetRegistry, arg2: &0x2::clock::Clock) : 0x1269ebf4edc63a9d4df8469bfd386938f4d71543734ae0cf0398630461085f02::decimals::Decimal {
        let v0 = 0x1::type_name::get<T0>();
        get_price_by_asset_unsafe(arg0, arg1, *0x1::type_name::borrow_string(&v0), arg2)
    }

    public(friend) fun get_price_by_asset_id(arg0: &PriceRegistry, arg1: u64, arg2: &0x2::clock::Clock) : 0x1269ebf4edc63a9d4df8469bfd386938f4d71543734ae0cf0398630461085f02::decimals::Decimal {
        let v0 = 0x2::vec_map::get<u64, Price>(&arg0.price_registry, &arg1);
        assert!(0x2::clock::timestamp_ms(arg2) / 1000 - v0.timestamp_secs < 10, 1400);
        0x1269ebf4edc63a9d4df8469bfd386938f4d71543734ae0cf0398630461085f02::decimals::from_u64(v0.price, v0.decimals)
    }

    public(friend) fun get_price_by_asset_unsafe(arg0: &PriceRegistry, arg1: &0x1269ebf4edc63a9d4df8469bfd386938f4d71543734ae0cf0398630461085f02::asset_registry::AssetRegistry, arg2: 0x1::ascii::String, arg3: &0x2::clock::Clock) : 0x1269ebf4edc63a9d4df8469bfd386938f4d71543734ae0cf0398630461085f02::decimals::Decimal {
        let v0 = 0x1269ebf4edc63a9d4df8469bfd386938f4d71543734ae0cf0398630461085f02::asset_registry::get_asset_id_unsafe(arg1, &arg2);
        let v1 = 0x2::vec_map::get<u64, Price>(&arg0.price_registry, &v0);
        assert!(0x2::clock::timestamp_ms(arg3) / 1000 - v1.timestamp_secs < 10, 1400);
        0x1269ebf4edc63a9d4df8469bfd386938f4d71543734ae0cf0398630461085f02::decimals::from_u64(v1.price, v1.decimals)
    }

    public fun index_nav<T0>(arg0: &0x1269ebf4edc63a9d4df8469bfd386938f4d71543734ae0cf0398630461085f02::index::Index<T0>, arg1: &0x1269ebf4edc63a9d4df8469bfd386938f4d71543734ae0cf0398630461085f02::balances_registry::BalancesRegistry, arg2: &PriceRegistry, arg3: &0x1269ebf4edc63a9d4df8469bfd386938f4d71543734ae0cf0398630461085f02::asset_registry::AssetRegistry, arg4: &0x2::clock::Clock) : 0x1269ebf4edc63a9d4df8469bfd386938f4d71543734ae0cf0398630461085f02::decimals::Decimal {
        let v0 = 0x2::object::id<0x1269ebf4edc63a9d4df8469bfd386938f4d71543734ae0cf0398630461085f02::index::Index<T0>>(arg0);
        let v1 = 0x1269ebf4edc63a9d4df8469bfd386938f4d71543734ae0cf0398630461085f02::balances_registry::product_balance(arg1, 0x2::object::id_to_address(&v0));
        let v2 = 0x2::object::id<0x1269ebf4edc63a9d4df8469bfd386938f4d71543734ae0cf0398630461085f02::index::Index<T0>>(arg0);
        let v3 = 0x1269ebf4edc63a9d4df8469bfd386938f4d71543734ae0cf0398630461085f02::balances_registry::product_fee(arg1, 0x2::object::id_to_address(&v2));
        let v4 = 0x1::vector::empty<0x1269ebf4edc63a9d4df8469bfd386938f4d71543734ae0cf0398630461085f02::decimals::Decimal>();
        let v5 = 0x1269ebf4edc63a9d4df8469bfd386938f4d71543734ae0cf0398630461085f02::index::assets<T0>(arg0);
        0x1::vector::reverse<u64>(&mut v5);
        let v6 = 0;
        while (v6 < 0x1::vector::length<u64>(&v5)) {
            let v7 = 0x1::vector::pop_back<u64>(&mut v5);
            let v8 = 0x1269ebf4edc63a9d4df8469bfd386938f4d71543734ae0cf0398630461085f02::asset_registry::get_asset_unsafe(arg3, v7);
            let v9 = if (0x2::vec_map::contains<u64, u64>(v1, &v7)) {
                0x1269ebf4edc63a9d4df8469bfd386938f4d71543734ae0cf0398630461085f02::decimals::sub(0x1269ebf4edc63a9d4df8469bfd386938f4d71543734ae0cf0398630461085f02::decimals::from_u64(*0x2::vec_map::get<u64, u64>(v1, &v7), 0x1269ebf4edc63a9d4df8469bfd386938f4d71543734ae0cf0398630461085f02::asset_registry::decimals(v8)), 0x1269ebf4edc63a9d4df8469bfd386938f4d71543734ae0cf0398630461085f02::decimals::from_u64(*0x2::vec_map::get<u64, u64>(v3, &v7), 0x1269ebf4edc63a9d4df8469bfd386938f4d71543734ae0cf0398630461085f02::asset_registry::decimals(v8)))
            } else {
                0x1269ebf4edc63a9d4df8469bfd386938f4d71543734ae0cf0398630461085f02::decimals::zero()
            };
            0x1::vector::push_back<0x1269ebf4edc63a9d4df8469bfd386938f4d71543734ae0cf0398630461085f02::decimals::Decimal>(&mut v4, 0x1269ebf4edc63a9d4df8469bfd386938f4d71543734ae0cf0398630461085f02::decimals::mul(0x1269ebf4edc63a9d4df8469bfd386938f4d71543734ae0cf0398630461085f02::decimals::sub(v9, 0x1269ebf4edc63a9d4df8469bfd386938f4d71543734ae0cf0398630461085f02::decimals::mul(v9, 0x1269ebf4edc63a9d4df8469bfd386938f4d71543734ae0cf0398630461085f02::streaming_fee::percentage(0x1269ebf4edc63a9d4df8469bfd386938f4d71543734ae0cf0398630461085f02::index::streaming_fee<T0>(arg0), arg4))), get_price_by_asset_id(arg2, v7, arg4)));
            v6 = v6 + 1;
        };
        0x1::vector::destroy_empty<u64>(v5);
        let v10 = 0x1269ebf4edc63a9d4df8469bfd386938f4d71543734ae0cf0398630461085f02::decimals::zero();
        let v11 = 0;
        while (v11 < 0x1::vector::length<0x1269ebf4edc63a9d4df8469bfd386938f4d71543734ae0cf0398630461085f02::decimals::Decimal>(&v4)) {
            v10 = 0x1269ebf4edc63a9d4df8469bfd386938f4d71543734ae0cf0398630461085f02::decimals::add(v10, *0x1::vector::borrow<0x1269ebf4edc63a9d4df8469bfd386938f4d71543734ae0cf0398630461085f02::decimals::Decimal>(&v4, v11));
            v11 = v11 + 1;
        };
        v10
    }

    public fun refresh_index_price<T0>(arg0: &mut PriceRegistry, arg1: &0x1269ebf4edc63a9d4df8469bfd386938f4d71543734ae0cf0398630461085f02::asset_registry::AssetRegistry, arg2: &0x1269ebf4edc63a9d4df8469bfd386938f4d71543734ae0cf0398630461085f02::balances_registry::BalancesRegistry, arg3: &0x1269ebf4edc63a9d4df8469bfd386938f4d71543734ae0cf0398630461085f02::index::Index<T0>, arg4: &0x2::clock::Clock) : 0x1269ebf4edc63a9d4df8469bfd386938f4d71543734ae0cf0398630461085f02::decimals::Decimal {
        assert!(0x1269ebf4edc63a9d4df8469bfd386938f4d71543734ae0cf0398630461085f02::asset_registry::kind(0x1269ebf4edc63a9d4df8469bfd386938f4d71543734ae0cf0398630461085f02::asset_registry::get_asset<T0>(arg1)) == 1, 1401);
        let v0 = if (0x2::coin::total_supply<T0>(0x1269ebf4edc63a9d4df8469bfd386938f4d71543734ae0cf0398630461085f02::index::treasury_cap<T0>(arg3)) == 0) {
            0x1269ebf4edc63a9d4df8469bfd386938f4d71543734ae0cf0398630461085f02::index::initial_price<T0>(arg3)
        } else {
            0x1269ebf4edc63a9d4df8469bfd386938f4d71543734ae0cf0398630461085f02::decimals::div(index_nav<T0>(arg3, arg2, arg0, arg1, arg4), 0x1269ebf4edc63a9d4df8469bfd386938f4d71543734ae0cf0398630461085f02::decimals::from_u64(0x2::coin::total_supply<T0>(0x1269ebf4edc63a9d4df8469bfd386938f4d71543734ae0cf0398630461085f02::index::treasury_cap<T0>(arg3)), 0x1269ebf4edc63a9d4df8469bfd386938f4d71543734ae0cf0398630461085f02::index::decimals<T0>(arg3)))
        };
        update_price(arg0, 0x1269ebf4edc63a9d4df8469bfd386938f4d71543734ae0cf0398630461085f02::asset_registry::get_asset_id<T0>(arg1), 0x1269ebf4edc63a9d4df8469bfd386938f4d71543734ae0cf0398630461085f02::decimals::to_u64(v0, 0x1269ebf4edc63a9d4df8469bfd386938f4d71543734ae0cf0398630461085f02::index::price_decimals<T0>(arg3)), 0x1269ebf4edc63a9d4df8469bfd386938f4d71543734ae0cf0398630461085f02::index::price_decimals<T0>(arg3), arg4);
        v0
    }

    public fun refresh_price_with_pyth<T0>(arg0: &mut PriceRegistry, arg1: &0x1269ebf4edc63a9d4df8469bfd386938f4d71543734ae0cf0398630461085f02::asset_registry::AssetRegistry, arg2: &0x2::clock::Clock, arg3: &0x8d97f1cd6ac663735be08d1d2b6d02a159e711586461306ce60a2b7a6a565a9e::state::State, arg4: &0x8d97f1cd6ac663735be08d1d2b6d02a159e711586461306ce60a2b7a6a565a9e::price_info::PriceInfoObject) {
        assert!(0x1269ebf4edc63a9d4df8469bfd386938f4d71543734ae0cf0398630461085f02::asset_registry::kind(0x1269ebf4edc63a9d4df8469bfd386938f4d71543734ae0cf0398630461085f02::asset_registry::get_asset<T0>(arg1)) == 0, 1401);
        let v0 = 0x8d97f1cd6ac663735be08d1d2b6d02a159e711586461306ce60a2b7a6a565a9e::pyth::get_price(arg3, arg4, arg2);
        let v1 = 0x8d97f1cd6ac663735be08d1d2b6d02a159e711586461306ce60a2b7a6a565a9e::price::get_expo(&v0);
        let v2 = 0x8d97f1cd6ac663735be08d1d2b6d02a159e711586461306ce60a2b7a6a565a9e::price::get_price(&v0);
        update_price(arg0, 0x1269ebf4edc63a9d4df8469bfd386938f4d71543734ae0cf0398630461085f02::asset_registry::get_asset_id<T0>(arg1), 0x8d97f1cd6ac663735be08d1d2b6d02a159e711586461306ce60a2b7a6a565a9e::i64::get_magnitude_if_positive(&v2), (0x8d97f1cd6ac663735be08d1d2b6d02a159e711586461306ce60a2b7a6a565a9e::i64::get_magnitude_if_negative(&v1) as u8), arg2);
    }

    fun update_price(arg0: &mut PriceRegistry, arg1: u64, arg2: u64, arg3: u8, arg4: &0x2::clock::Clock) {
        if (!0x2::vec_map::contains<u64, Price>(&arg0.price_registry, &arg1)) {
            let v0 = Price{
                timestamp_secs : 0x2::clock::timestamp_ms(arg4) / 1000,
                price          : arg2,
                decimals       : arg3,
            };
            0x2::vec_map::insert<u64, Price>(&mut arg0.price_registry, arg1, v0);
        } else {
            let v1 = 0x2::vec_map::get_mut<u64, Price>(&mut arg0.price_registry, &arg1);
            v1.price = arg2;
            v1.decimals = arg3;
            v1.timestamp_secs = 0x2::clock::timestamp_ms(arg4) / 1000;
        };
    }

    // decompiled from Move bytecode v6
}

