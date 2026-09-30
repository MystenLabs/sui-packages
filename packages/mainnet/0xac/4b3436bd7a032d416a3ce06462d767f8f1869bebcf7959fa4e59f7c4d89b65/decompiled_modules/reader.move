module 0xac4b3436bd7a032d416a3ce06462d767f8f1869bebcf7959fa4e59f7c4d89b65::reader {
    public fun current<T0, T1>(arg0: &0xca653d2fac70a49549c7ff8792027fa4fa418fd6619954ea0f45d6fd0d081b8e::vault::Vault<T0>, arg1: &0x5a6df33a03a69959065b5e87aecac72d0afff893a1923833a77dcfb0d2f42980::pyth::MetaVaultPythIntegration, arg2: &0x55300367a2d40813727ccac4ecee977a39fb9cdb46f2e6b2c354b9798f5de2c0::price_info::PriceInfoObject, arg3: &0x2::clock::Clock) : (vector<u128>, u8) {
        let v0 = 0xca653d2fac70a49549c7ff8792027fa4fa418fd6619954ea0f45d6fd0d081b8e::vault::borrow<T0>(arg0, 0x1::type_name::get<T1>());
        assert!(0xca653d2fac70a49549c7ff8792027fa4fa418fd6619954ea0f45d6fd0d081b8e::vault::whitelisted_app_id(v0) == 0x2::object::id<0x5a6df33a03a69959065b5e87aecac72d0afff893a1923833a77dcfb0d2f42980::pyth::MetaVaultPythIntegration>(arg1), 3);
        assert!(0x5a6df33a03a69959065b5e87aecac72d0afff893a1923833a77dcfb0d2f42980::pyth::price_feed_id<T1>(arg1) == 0x2::object::id<0x55300367a2d40813727ccac4ecee977a39fb9cdb46f2e6b2c354b9798f5de2c0::price_info::PriceInfoObject>(arg2), 2);
        let v1 = 0x1::bcs::to_bytes<0xca653d2fac70a49549c7ff8792027fa4fa418fd6619954ea0f45d6fd0d081b8e::vault::Vault<T0>>(arg0);
        let v2 = 0x1::bcs::to_bytes<0x5a6df33a03a69959065b5e87aecac72d0afff893a1923833a77dcfb0d2f42980::pyth::MetaVaultPythIntegration>(arg1);
        assert!(0x1::vector::length<u8>(&v1) == 201 && 0x1::vector::length<u8>(&v2) == 120, 1);
        assert!(read_u64(&v1, 32) == 0xca653d2fac70a49549c7ff8792027fa4fa418fd6619954ea0f45d6fd0d081b8e::vault::supply_value<T0>(arg0), 1);
        if (read_u64(&v2, 104) != 0) {
            return (vector[], 5)
        };
        let v3 = 0x55300367a2d40813727ccac4ecee977a39fb9cdb46f2e6b2c354b9798f5de2c0::pyth::get_price_unsafe(arg2);
        let v4 = 0x55300367a2d40813727ccac4ecee977a39fb9cdb46f2e6b2c354b9798f5de2c0::price::get_price(&v3);
        let v5 = 0x55300367a2d40813727ccac4ecee977a39fb9cdb46f2e6b2c354b9798f5de2c0::price::get_expo(&v3);
        let v6 = 0x2::clock::timestamp_ms(arg3) / 1000;
        let v7 = 0x55300367a2d40813727ccac4ecee977a39fb9cdb46f2e6b2c354b9798f5de2c0::price::get_timestamp(&v3);
        let v8 = if (v6 >= v7) {
            v6 - v7
        } else {
            v7 - v6
        };
        let v9 = if (v8 >= read_u64(&v2, 112)) {
            true
        } else if (0x55300367a2d40813727ccac4ecee977a39fb9cdb46f2e6b2c354b9798f5de2c0::i64::get_is_negative(&v4)) {
            true
        } else {
            !0x55300367a2d40813727ccac4ecee977a39fb9cdb46f2e6b2c354b9798f5de2c0::i64::get_is_negative(&v5)
        };
        if (v9) {
            return (vector[], 2)
        };
        let v10 = 0x55300367a2d40813727ccac4ecee977a39fb9cdb46f2e6b2c354b9798f5de2c0::i64::get_magnitude_if_positive(&v4);
        let v11 = 0x55300367a2d40813727ccac4ecee977a39fb9cdb46f2e6b2c354b9798f5de2c0::i64::get_magnitude_if_negative(&v5);
        if (v10 == 0 || v11 > 18) {
            return (vector[], 2)
        };
        let v12 = if (0xca653d2fac70a49549c7ff8792027fa4fa418fd6619954ea0f45d6fd0d081b8e::vault::is_yield_bearing<T0>(arg0)) {
            1
        } else {
            0
        };
        let v13 = 0x1::vector::empty<u128>();
        let v14 = &mut v13;
        0x1::vector::push_back<u128>(v14, (0xca653d2fac70a49549c7ff8792027fa4fa418fd6619954ea0f45d6fd0d081b8e::vault::balance(v0) as u128));
        0x1::vector::push_back<u128>(v14, (0xca653d2fac70a49549c7ff8792027fa4fa418fd6619954ea0f45d6fd0d081b8e::vault::deposit_cap(v0) as u128));
        0x1::vector::push_back<u128>(v14, (0xca653d2fac70a49549c7ff8792027fa4fa418fd6619954ea0f45d6fd0d081b8e::vault::supply_value<T0>(arg0) as u128));
        0x1::vector::push_back<u128>(v14, (v10 as u128) * 0x1::u128::pow(10, ((18 - v11) as u8)));
        0x1::vector::push_back<u128>(v14, (0xca653d2fac70a49549c7ff8792027fa4fa418fd6619954ea0f45d6fd0d081b8e::vault::min_fee(v0) as u128));
        0x1::vector::push_back<u128>(v14, (0xca653d2fac70a49549c7ff8792027fa4fa418fd6619954ea0f45d6fd0d081b8e::vault::max_fee(v0) as u128));
        0x1::vector::push_back<u128>(v14, (0xca653d2fac70a49549c7ff8792027fa4fa418fd6619954ea0f45d6fd0d081b8e::vault::priority(v0) as u128));
        0x1::vector::push_back<u128>(v14, (read_u64(&v1, 113) as u128));
        0x1::vector::push_back<u128>(v14, (*0x1::vector::borrow<u8>(&v1, 40) as u128));
        0x1::vector::push_back<u128>(v14, (0xca653d2fac70a49549c7ff8792027fa4fa418fd6619954ea0f45d6fd0d081b8e::vault::decimals(v0) as u128));
        0x1::vector::push_back<u128>(v14, v12);
        (v13, 0)
    }

    public fun current_denominated<T0, T1>(arg0: &0xca653d2fac70a49549c7ff8792027fa4fa418fd6619954ea0f45d6fd0d081b8e::vault::Vault<T0>, arg1: &0x834394c96ffa45c135a8c1459207ca3282c2db63875da63f46d5fb083eb3d921::pyth::MetaVaultPythIntegrationDenominatedFeed, arg2: &0x55300367a2d40813727ccac4ecee977a39fb9cdb46f2e6b2c354b9798f5de2c0::price_info::PriceInfoObject, arg3: &0x55300367a2d40813727ccac4ecee977a39fb9cdb46f2e6b2c354b9798f5de2c0::price_info::PriceInfoObject, arg4: &0x2::clock::Clock) : (vector<u128>, u8) {
        let v0 = 0xca653d2fac70a49549c7ff8792027fa4fa418fd6619954ea0f45d6fd0d081b8e::vault::borrow<T0>(arg0, 0x1::type_name::get<T1>());
        assert!(0xca653d2fac70a49549c7ff8792027fa4fa418fd6619954ea0f45d6fd0d081b8e::vault::whitelisted_app_id(v0) == 0x2::object::id<0x834394c96ffa45c135a8c1459207ca3282c2db63875da63f46d5fb083eb3d921::pyth::MetaVaultPythIntegrationDenominatedFeed>(arg1), 3);
        assert!(0x834394c96ffa45c135a8c1459207ca3282c2db63875da63f46d5fb083eb3d921::pyth::price_feed_id<T1>(arg1) == 0x2::object::id<0x55300367a2d40813727ccac4ecee977a39fb9cdb46f2e6b2c354b9798f5de2c0::price_info::PriceInfoObject>(arg2) && 0x834394c96ffa45c135a8c1459207ca3282c2db63875da63f46d5fb083eb3d921::pyth::base_usd_price_feed_id(arg1) == 0x2::object::id<0x55300367a2d40813727ccac4ecee977a39fb9cdb46f2e6b2c354b9798f5de2c0::price_info::PriceInfoObject>(arg3), 2);
        let (v1, v2) = normalized_price(arg2, arg4, 0x834394c96ffa45c135a8c1459207ca3282c2db63875da63f46d5fb083eb3d921::pyth::stale_price_threshold_secs_v2(arg1, arg2));
        let (v3, v4) = normalized_price(arg3, arg4, 0x834394c96ffa45c135a8c1459207ca3282c2db63875da63f46d5fb083eb3d921::pyth::stale_price_threshold_secs_v2(arg1, arg3));
        if (!v2 || !v4) {
            return (vector[], 2)
        };
        let v5 = (v1 as u256) * 1000000000000000000 / (v3 as u256);
        if (v5 == 0 || v5 > 340282366920938463463374607431768211455) {
            return (vector[], 12)
        };
        (state<T0>(arg0, v0, (v5 as u128)), 0)
    }

    public fun current_registry<T0, T1, T2: key>(arg0: &0xca653d2fac70a49549c7ff8792027fa4fa418fd6619954ea0f45d6fd0d081b8e::vault::Vault<T0>, arg1: &T2, arg2: &0x546b4c792de9744e08cb89f8f52b25cf5384db0af44f613db6d383234f009bb9::registry::Registry) : (vector<u128>, u8) {
        let v0 = 0xca653d2fac70a49549c7ff8792027fa4fa418fd6619954ea0f45d6fd0d081b8e::vault::borrow<T0>(arg0, 0x1::type_name::get<T1>());
        assert!(0xca653d2fac70a49549c7ff8792027fa4fa418fd6619954ea0f45d6fd0d081b8e::vault::whitelisted_app_id(v0) == 0x2::object::id<T2>(arg1), 3);
        let v1 = 0x546b4c792de9744e08cb89f8f52b25cf5384db0af44f613db6d383234f009bb9::registry::coin_to_meta_coin_exchange_rate<T0, T1>(arg2, arg0);
        if (v1 == 0) {
            return (vector[], 12)
        };
        (state<T0>(arg0, v0, v1), 0)
    }

    fun normalized_price(arg0: &0x55300367a2d40813727ccac4ecee977a39fb9cdb46f2e6b2c354b9798f5de2c0::price_info::PriceInfoObject, arg1: &0x2::clock::Clock, arg2: u64) : (u128, bool) {
        let v0 = 0x55300367a2d40813727ccac4ecee977a39fb9cdb46f2e6b2c354b9798f5de2c0::pyth::get_price_unsafe(arg0);
        let v1 = 0x55300367a2d40813727ccac4ecee977a39fb9cdb46f2e6b2c354b9798f5de2c0::price::get_price(&v0);
        let v2 = 0x55300367a2d40813727ccac4ecee977a39fb9cdb46f2e6b2c354b9798f5de2c0::price::get_expo(&v0);
        let v3 = 0x2::clock::timestamp_ms(arg1) / 1000;
        let v4 = 0x55300367a2d40813727ccac4ecee977a39fb9cdb46f2e6b2c354b9798f5de2c0::price::get_timestamp(&v0);
        let v5 = if (v3 >= v4) {
            v3 - v4
        } else {
            v4 - v3
        };
        let v6 = if (v5 >= arg2) {
            true
        } else if (0x55300367a2d40813727ccac4ecee977a39fb9cdb46f2e6b2c354b9798f5de2c0::i64::get_is_negative(&v1)) {
            true
        } else {
            !0x55300367a2d40813727ccac4ecee977a39fb9cdb46f2e6b2c354b9798f5de2c0::i64::get_is_negative(&v2)
        };
        if (v6) {
            return (0, false)
        };
        let v7 = 0x55300367a2d40813727ccac4ecee977a39fb9cdb46f2e6b2c354b9798f5de2c0::i64::get_magnitude_if_positive(&v1);
        let v8 = 0x55300367a2d40813727ccac4ecee977a39fb9cdb46f2e6b2c354b9798f5de2c0::i64::get_magnitude_if_negative(&v2);
        if (v7 == 0 || v8 > 18) {
            return (0, false)
        };
        ((v7 as u128) * 0x1::u128::pow(10, ((18 - v8) as u8)), true)
    }

    fun read_u64(arg0: &vector<u8>, arg1: u64) : u64 {
        let v0 = 0;
        let v1 = 0;
        while (v1 < 8) {
            v0 = v0 | (*0x1::vector::borrow<u8>(arg0, arg1 + v1) as u64) << ((v1 * 8) as u8);
            v1 = v1 + 1;
        };
        v0
    }

    fun state<T0>(arg0: &0xca653d2fac70a49549c7ff8792027fa4fa418fd6619954ea0f45d6fd0d081b8e::vault::Vault<T0>, arg1: &0xca653d2fac70a49549c7ff8792027fa4fa418fd6619954ea0f45d6fd0d081b8e::vault::Metadata, arg2: u128) : vector<u128> {
        let v0 = 0x1::bcs::to_bytes<0xca653d2fac70a49549c7ff8792027fa4fa418fd6619954ea0f45d6fd0d081b8e::vault::Vault<T0>>(arg0);
        assert!(0x1::vector::length<u8>(&v0) == 201, 1);
        let v1 = if (0xca653d2fac70a49549c7ff8792027fa4fa418fd6619954ea0f45d6fd0d081b8e::vault::is_yield_bearing<T0>(arg0)) {
            1
        } else {
            0
        };
        let v2 = 0x1::vector::empty<u128>();
        let v3 = &mut v2;
        0x1::vector::push_back<u128>(v3, (0xca653d2fac70a49549c7ff8792027fa4fa418fd6619954ea0f45d6fd0d081b8e::vault::balance(arg1) as u128));
        0x1::vector::push_back<u128>(v3, (0xca653d2fac70a49549c7ff8792027fa4fa418fd6619954ea0f45d6fd0d081b8e::vault::deposit_cap(arg1) as u128));
        0x1::vector::push_back<u128>(v3, (0xca653d2fac70a49549c7ff8792027fa4fa418fd6619954ea0f45d6fd0d081b8e::vault::supply_value<T0>(arg0) as u128));
        0x1::vector::push_back<u128>(v3, arg2);
        0x1::vector::push_back<u128>(v3, (0xca653d2fac70a49549c7ff8792027fa4fa418fd6619954ea0f45d6fd0d081b8e::vault::min_fee(arg1) as u128));
        0x1::vector::push_back<u128>(v3, (0xca653d2fac70a49549c7ff8792027fa4fa418fd6619954ea0f45d6fd0d081b8e::vault::max_fee(arg1) as u128));
        0x1::vector::push_back<u128>(v3, (0xca653d2fac70a49549c7ff8792027fa4fa418fd6619954ea0f45d6fd0d081b8e::vault::priority(arg1) as u128));
        0x1::vector::push_back<u128>(v3, (read_u64(&v0, 113) as u128));
        0x1::vector::push_back<u128>(v3, (*0x1::vector::borrow<u8>(&v0, 40) as u128));
        0x1::vector::push_back<u128>(v3, (0xca653d2fac70a49549c7ff8792027fa4fa418fd6619954ea0f45d6fd0d081b8e::vault::decimals(arg1) as u128));
        0x1::vector::push_back<u128>(v3, v1);
        v2
    }

    // decompiled from Move bytecode v7
}

