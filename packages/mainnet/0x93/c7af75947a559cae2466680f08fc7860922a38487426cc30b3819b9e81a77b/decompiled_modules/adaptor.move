module 0x93c7af75947a559cae2466680f08fc7860922a38487426cc30b3819b9e81a77b::adaptor {
    struct PythRegistry has key {
        id: 0x2::object::UID,
        table: 0x2::table::Table<0x1::type_name::TypeName, 0x2::object::ID>,
        id_table: 0x2::table::Table<0x2::object::ID, u8>,
    }

    struct PythRegistryCap has store, key {
        id: 0x2::object::UID,
        for: 0x2::object::ID,
    }

    struct RegisterTokenEvent has copy, drop {
        admin: address,
        type_name: 0x1::ascii::String,
        price_info_object: 0x2::object::ID,
        index: u8,
    }

    fun assert_pyth_price_info_object<T0>(arg0: &PythRegistry, arg1: &0xb53b0f4174108627fbee72e2498b58d6a2714cded53fac537034c220d26302::price_info::PriceInfoObject) {
        assert!(0x2::object::id<0xb53b0f4174108627fbee72e2498b58d6a2714cded53fac537034c220d26302::price_info::PriceInfoObject>(arg1) == *0x2::table::borrow<0x1::type_name::TypeName, 0x2::object::ID>(&arg0.table, 0x1::type_name::get<T0>()), 20002);
    }

    fun get_each_price(arg0: &PythRegistry, arg1: &0xb53b0f4174108627fbee72e2498b58d6a2714cded53fac537034c220d26302::price_info::PriceInfoObject, arg2: &mut 0x21037ecd2691914fda192b3dab827b0e2dcbbe874be210cf3deca453f8cd9622::navi_aggregator::NaviAggregator) : (u256, u64) {
        assert!(0x2::table::contains<0x2::object::ID, u8>(&arg0.id_table, 0x2::object::id<0xb53b0f4174108627fbee72e2498b58d6a2714cded53fac537034c220d26302::price_info::PriceInfoObject>(arg1)), 20002);
        let (v0, v1) = 0x21037ecd2691914fda192b3dab827b0e2dcbbe874be210cf3deca453f8cd9622::navi_aggregator::get_token_decimal(arg2, *0x2::table::borrow<0x2::object::ID, u8>(&arg0.id_table, 0x2::object::id<0xb53b0f4174108627fbee72e2498b58d6a2714cded53fac537034c220d26302::price_info::PriceInfoObject>(arg1)));
        assert!(v0, 20004);
        let (v2, v3, v4) = get_pyth_price_unsafe(arg1);
        assert!(v2 > 0, 20001);
        let v5 = if (v3 < v1) {
            v2 * 0x2::math::pow(10, v1 - v3)
        } else {
            v2 / 0x2::math::pow(10, v3 - v1)
        };
        ((v5 as u256), v4)
    }

    public fun get_pyth_price(arg0: &0x5306f64e312b581766351c07af79c72fcb1cd25147157fdc2f8ad76de9a3fb6a::state::State, arg1: &0xb53b0f4174108627fbee72e2498b58d6a2714cded53fac537034c220d26302::state::State, arg2: &mut 0xb53b0f4174108627fbee72e2498b58d6a2714cded53fac537034c220d26302::price_info::PriceInfoObject, arg3: vector<u8>, arg4: 0x2::coin::Coin<0x2::sui::SUI>, arg5: &0x2::clock::Clock) : (u64, u8, u64) {
        update_price(arg0, arg1, arg2, arg3, arg4, arg5);
        let v0 = 0xb53b0f4174108627fbee72e2498b58d6a2714cded53fac537034c220d26302::pyth::get_price(arg1, arg2, arg5);
        let v1 = 0xb53b0f4174108627fbee72e2498b58d6a2714cded53fac537034c220d26302::price::get_price(&v0);
        let v2 = 0xb53b0f4174108627fbee72e2498b58d6a2714cded53fac537034c220d26302::price::get_expo(&v0);
        let v3 = 0xb53b0f4174108627fbee72e2498b58d6a2714cded53fac537034c220d26302::i64::get_magnitude_if_negative(&v2);
        assert!(v3 <= 255, 20001);
        (0xb53b0f4174108627fbee72e2498b58d6a2714cded53fac537034c220d26302::i64::get_magnitude_if_positive(&v1), (v3 as u8), 0xb53b0f4174108627fbee72e2498b58d6a2714cded53fac537034c220d26302::price::get_timestamp(&v0) * 1000)
    }

    public fun get_pyth_price_unsafe(arg0: &0xb53b0f4174108627fbee72e2498b58d6a2714cded53fac537034c220d26302::price_info::PriceInfoObject) : (u64, u8, u64) {
        let v0 = 0xb53b0f4174108627fbee72e2498b58d6a2714cded53fac537034c220d26302::pyth::get_price_unsafe(arg0);
        let v1 = 0xb53b0f4174108627fbee72e2498b58d6a2714cded53fac537034c220d26302::price::get_price(&v0);
        let v2 = 0xb53b0f4174108627fbee72e2498b58d6a2714cded53fac537034c220d26302::price::get_expo(&v0);
        let v3 = 0xb53b0f4174108627fbee72e2498b58d6a2714cded53fac537034c220d26302::i64::get_magnitude_if_negative(&v2);
        assert!(v3 <= 255, 20001);
        (0xb53b0f4174108627fbee72e2498b58d6a2714cded53fac537034c220d26302::i64::get_magnitude_if_positive(&v1), (v3 as u8), 0xb53b0f4174108627fbee72e2498b58d6a2714cded53fac537034c220d26302::price::get_timestamp(&v0) * 1000)
    }

    fun init(arg0: &mut 0x2::tx_context::TxContext) {
        let v0 = PythRegistry{
            id       : 0x2::object::new(arg0),
            table    : 0x2::table::new<0x1::type_name::TypeName, 0x2::object::ID>(arg0),
            id_table : 0x2::table::new<0x2::object::ID, u8>(arg0),
        };
        let v1 = PythRegistryCap{
            id  : 0x2::object::new(arg0),
            for : 0x2::object::id<PythRegistry>(&v0),
        };
        0x2::transfer::share_object<PythRegistry>(v0);
        0x2::transfer::transfer<PythRegistryCap>(v1, 0x2::tx_context::sender(arg0));
    }

    public entry fun register_pyth_price_info_object<T0>(arg0: &mut PythRegistry, arg1: &PythRegistryCap, arg2: &0xb53b0f4174108627fbee72e2498b58d6a2714cded53fac537034c220d26302::price_info::PriceInfoObject, arg3: &0x21037ecd2691914fda192b3dab827b0e2dcbbe874be210cf3deca453f8cd9622::navi_aggregator::NaviAggregator, arg4: &mut 0x2::tx_context::TxContext) {
        assert!(0x2::object::id<PythRegistry>(arg0) == arg1.for, 20003);
        let v0 = 0x1::type_name::get<T0>();
        let (v1, v2, _) = 0x21037ecd2691914fda192b3dab827b0e2dcbbe874be210cf3deca453f8cd9622::navi_aggregator::get_token_info<T0>(arg3);
        assert!(v1, 20004);
        if (0x2::table::contains<0x1::type_name::TypeName, 0x2::object::ID>(&arg0.table, v0)) {
            0x2::table::remove<0x1::type_name::TypeName, 0x2::object::ID>(&mut arg0.table, v0);
            0x2::table::remove<0x2::object::ID, u8>(&mut arg0.id_table, 0x2::object::id<0xb53b0f4174108627fbee72e2498b58d6a2714cded53fac537034c220d26302::price_info::PriceInfoObject>(arg2));
        };
        0x2::table::add<0x1::type_name::TypeName, 0x2::object::ID>(&mut arg0.table, v0, 0x2::object::id<0xb53b0f4174108627fbee72e2498b58d6a2714cded53fac537034c220d26302::price_info::PriceInfoObject>(arg2));
        0x2::table::add<0x2::object::ID, u8>(&mut arg0.id_table, 0x2::object::id<0xb53b0f4174108627fbee72e2498b58d6a2714cded53fac537034c220d26302::price_info::PriceInfoObject>(arg2), v2);
        let v4 = RegisterTokenEvent{
            admin             : 0x2::tx_context::sender(arg4),
            type_name         : 0x1::type_name::into_string(v0),
            price_info_object : 0x2::object::id<0xb53b0f4174108627fbee72e2498b58d6a2714cded53fac537034c220d26302::price_info::PriceInfoObject>(arg2),
            index             : v2,
        };
        0x2::event::emit<RegisterTokenEvent>(v4);
    }

    public entry fun set_pyth_price<T0>(arg0: &0x5306f64e312b581766351c07af79c72fcb1cd25147157fdc2f8ad76de9a3fb6a::state::State, arg1: &0xb53b0f4174108627fbee72e2498b58d6a2714cded53fac537034c220d26302::state::State, arg2: &mut 0xb53b0f4174108627fbee72e2498b58d6a2714cded53fac537034c220d26302::price_info::PriceInfoObject, arg3: &PythRegistry, arg4: vector<u8>, arg5: 0x2::coin::Coin<0x2::sui::SUI>, arg6: &0x2::clock::Clock, arg7: &0x21037ecd2691914fda192b3dab827b0e2dcbbe874be210cf3deca453f8cd9622::navi_aggregator::NaviAggregatorCap, arg8: &mut 0x21037ecd2691914fda192b3dab827b0e2dcbbe874be210cf3deca453f8cd9622::navi_aggregator::NaviAggregator, arg9: &mut 0x2::tx_context::TxContext) {
        assert_pyth_price_info_object<T0>(arg3, arg2);
        let (v0, _, v2) = 0x21037ecd2691914fda192b3dab827b0e2dcbbe874be210cf3deca453f8cd9622::navi_aggregator::get_token_info<T0>(arg8);
        assert!(v0, 20004);
        let (v3, v4, v5) = get_pyth_price(arg0, arg1, arg2, arg4, arg5, arg6);
        assert!(v3 > 0, 20001);
        let v6 = if (v4 < v2) {
            v3 * 0x2::math::pow(10, v2 - v4)
        } else {
            v3 / 0x2::math::pow(10, v4 - v2)
        };
        0x21037ecd2691914fda192b3dab827b0e2dcbbe874be210cf3deca453f8cd9622::navi_aggregator::update_token_price<T0>(arg7, arg8, 1, (v6 as u256), v5, arg9);
    }

    public entry fun set_pyth_price_batch(arg0: &PythRegistry, arg1: &0xb53b0f4174108627fbee72e2498b58d6a2714cded53fac537034c220d26302::price_info::PriceInfoObject, arg2: &0xb53b0f4174108627fbee72e2498b58d6a2714cded53fac537034c220d26302::price_info::PriceInfoObject, arg3: &0xb53b0f4174108627fbee72e2498b58d6a2714cded53fac537034c220d26302::price_info::PriceInfoObject, arg4: &0xb53b0f4174108627fbee72e2498b58d6a2714cded53fac537034c220d26302::price_info::PriceInfoObject, arg5: &0xb53b0f4174108627fbee72e2498b58d6a2714cded53fac537034c220d26302::price_info::PriceInfoObject, arg6: &0x21037ecd2691914fda192b3dab827b0e2dcbbe874be210cf3deca453f8cd9622::navi_aggregator::NaviAggregatorCap, arg7: &mut 0x21037ecd2691914fda192b3dab827b0e2dcbbe874be210cf3deca453f8cd9622::navi_aggregator::NaviAggregator, arg8: &mut 0x2::tx_context::TxContext) {
        let v0 = 0x1::vector::empty<u256>();
        let v1 = 0x1::vector::empty<u64>();
        let (v2, v3) = get_each_price(arg0, arg1, arg7);
        0x1::vector::push_back<u256>(&mut v0, v2);
        0x1::vector::push_back<u64>(&mut v1, v3);
        let (v4, v5) = get_each_price(arg0, arg2, arg7);
        0x1::vector::push_back<u256>(&mut v0, v4);
        0x1::vector::push_back<u64>(&mut v1, v5);
        let (v6, v7) = get_each_price(arg0, arg3, arg7);
        0x1::vector::push_back<u256>(&mut v0, v6);
        0x1::vector::push_back<u64>(&mut v1, v7);
        let (v8, v9) = get_each_price(arg0, arg4, arg7);
        0x1::vector::push_back<u256>(&mut v0, v8);
        0x1::vector::push_back<u64>(&mut v1, v9);
        let (v10, v11) = get_each_price(arg0, arg5, arg7);
        0x1::vector::push_back<u256>(&mut v0, v10);
        0x1::vector::push_back<u64>(&mut v1, v11);
        0x21037ecd2691914fda192b3dab827b0e2dcbbe874be210cf3deca453f8cd9622::navi_aggregator::update_internal_token_price_batch(arg6, arg7, 1, x"0001020304", v0, v1, arg8);
    }

    public entry fun set_pyth_price_v2<T0>(arg0: &PythRegistry, arg1: &0xb53b0f4174108627fbee72e2498b58d6a2714cded53fac537034c220d26302::price_info::PriceInfoObject, arg2: &0x21037ecd2691914fda192b3dab827b0e2dcbbe874be210cf3deca453f8cd9622::navi_aggregator::NaviAggregatorCap, arg3: &mut 0x21037ecd2691914fda192b3dab827b0e2dcbbe874be210cf3deca453f8cd9622::navi_aggregator::NaviAggregator, arg4: &mut 0x2::tx_context::TxContext) {
        assert_pyth_price_info_object<T0>(arg0, arg1);
        let (v0, _, v2) = 0x21037ecd2691914fda192b3dab827b0e2dcbbe874be210cf3deca453f8cd9622::navi_aggregator::get_token_info<T0>(arg3);
        assert!(v0, 20004);
        let (v3, v4, v5) = get_pyth_price_unsafe(arg1);
        assert!(v3 > 0, 20001);
        let v6 = if (v4 < v2) {
            v3 * 0x2::math::pow(10, v2 - v4)
        } else {
            v3 / 0x2::math::pow(10, v4 - v2)
        };
        0x21037ecd2691914fda192b3dab827b0e2dcbbe874be210cf3deca453f8cd9622::navi_aggregator::update_token_price<T0>(arg2, arg3, 1, (v6 as u256), v5, arg4);
    }

    fun update_price(arg0: &0x5306f64e312b581766351c07af79c72fcb1cd25147157fdc2f8ad76de9a3fb6a::state::State, arg1: &0xb53b0f4174108627fbee72e2498b58d6a2714cded53fac537034c220d26302::state::State, arg2: &mut 0xb53b0f4174108627fbee72e2498b58d6a2714cded53fac537034c220d26302::price_info::PriceInfoObject, arg3: vector<u8>, arg4: 0x2::coin::Coin<0x2::sui::SUI>, arg5: &0x2::clock::Clock) {
        0xb53b0f4174108627fbee72e2498b58d6a2714cded53fac537034c220d26302::hot_potato_vector::destroy<0xb53b0f4174108627fbee72e2498b58d6a2714cded53fac537034c220d26302::price_info::PriceInfo>(0xb53b0f4174108627fbee72e2498b58d6a2714cded53fac537034c220d26302::pyth::update_single_price_feed(arg1, 0xb53b0f4174108627fbee72e2498b58d6a2714cded53fac537034c220d26302::pyth::create_price_infos_hot_potato(arg1, 0x1::vector::singleton<0x5306f64e312b581766351c07af79c72fcb1cd25147157fdc2f8ad76de9a3fb6a::vaa::VAA>(0x5306f64e312b581766351c07af79c72fcb1cd25147157fdc2f8ad76de9a3fb6a::vaa::parse_and_verify(arg0, arg3, arg5)), arg5), arg2, arg4, arg5));
    }

    // decompiled from Move bytecode v6
}

