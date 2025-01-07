module 0xeefcea81ca155a091d48b72ea88f5eb9f3bd8d44aa5b64b476de66a28edaa55f::adaptor {
    struct PythRegistry has key {
        id: 0x2::object::UID,
        table: 0x2::table::Table<0x1::type_name::TypeName, 0x2::object::ID>,
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

    public fun assert_pyth_price_info_object<T0>(arg0: &PythRegistry, arg1: &0xb53b0f4174108627fbee72e2498b58d6a2714cded53fac537034c220d26302::price_info::PriceInfoObject) {
        assert!(0x2::object::id<0xb53b0f4174108627fbee72e2498b58d6a2714cded53fac537034c220d26302::price_info::PriceInfoObject>(arg1) == *0x2::table::borrow<0x1::type_name::TypeName, 0x2::object::ID>(&arg0.table, 0x1::type_name::get<T0>()), 20002);
    }

    public entry fun get_pyth_price(arg0: &0x5306f64e312b581766351c07af79c72fcb1cd25147157fdc2f8ad76de9a3fb6a::state::State, arg1: &0xb53b0f4174108627fbee72e2498b58d6a2714cded53fac537034c220d26302::state::State, arg2: &mut 0xb53b0f4174108627fbee72e2498b58d6a2714cded53fac537034c220d26302::price_info::PriceInfoObject, arg3: vector<u8>, arg4: 0x2::coin::Coin<0x2::sui::SUI>, arg5: &0x2::clock::Clock) : (u64, u8, u64) {
        update_price(arg0, arg1, arg2, arg3, arg4, arg5);
        let v0 = 0xb53b0f4174108627fbee72e2498b58d6a2714cded53fac537034c220d26302::pyth::get_price(arg1, arg2, arg5);
        let v1 = 0xb53b0f4174108627fbee72e2498b58d6a2714cded53fac537034c220d26302::price::get_price(&v0);
        let v2 = 0xb53b0f4174108627fbee72e2498b58d6a2714cded53fac537034c220d26302::price::get_expo(&v0);
        let v3 = 0xb53b0f4174108627fbee72e2498b58d6a2714cded53fac537034c220d26302::i64::get_magnitude_if_negative(&v2);
        assert!(v3 <= 255, 20001);
        (0xb53b0f4174108627fbee72e2498b58d6a2714cded53fac537034c220d26302::i64::get_magnitude_if_positive(&v1), (v3 as u8), 0xb53b0f4174108627fbee72e2498b58d6a2714cded53fac537034c220d26302::price::get_timestamp(&v0))
    }

    public entry fun get_pyth_price_unsafe(arg0: &0xb53b0f4174108627fbee72e2498b58d6a2714cded53fac537034c220d26302::price_info::PriceInfoObject) : (u64, u8, u64) {
        let v0 = 0xb53b0f4174108627fbee72e2498b58d6a2714cded53fac537034c220d26302::pyth::get_price_unsafe(arg0);
        let v1 = 0xb53b0f4174108627fbee72e2498b58d6a2714cded53fac537034c220d26302::price::get_price(&v0);
        let v2 = 0xb53b0f4174108627fbee72e2498b58d6a2714cded53fac537034c220d26302::price::get_expo(&v0);
        let v3 = 0xb53b0f4174108627fbee72e2498b58d6a2714cded53fac537034c220d26302::i64::get_magnitude_if_negative(&v2);
        assert!(v3 <= 255, 20001);
        (0xb53b0f4174108627fbee72e2498b58d6a2714cded53fac537034c220d26302::i64::get_magnitude_if_positive(&v1), (v3 as u8), 0xb53b0f4174108627fbee72e2498b58d6a2714cded53fac537034c220d26302::price::get_timestamp(&v0))
    }

    public entry fun get_pyth_price_unsafe_test(arg0: &0xb53b0f4174108627fbee72e2498b58d6a2714cded53fac537034c220d26302::price_info::PriceInfoObject) : (u64, u8, u64) {
        let v0 = 0xb53b0f4174108627fbee72e2498b58d6a2714cded53fac537034c220d26302::pyth::get_price_unsafe(arg0);
        let v1 = 0xb53b0f4174108627fbee72e2498b58d6a2714cded53fac537034c220d26302::price::get_price(&v0);
        let v2 = 0xb53b0f4174108627fbee72e2498b58d6a2714cded53fac537034c220d26302::price::get_expo(&v0);
        let v3 = 0xb53b0f4174108627fbee72e2498b58d6a2714cded53fac537034c220d26302::i64::get_magnitude_if_negative(&v2);
        assert!(v3 <= 255, 20001);
        (0xb53b0f4174108627fbee72e2498b58d6a2714cded53fac537034c220d26302::i64::get_magnitude_if_positive(&v1), (v3 as u8), 0xb53b0f4174108627fbee72e2498b58d6a2714cded53fac537034c220d26302::price::get_timestamp(&v0))
    }

    fun init(arg0: &mut 0x2::tx_context::TxContext) {
        let v0 = PythRegistry{
            id    : 0x2::object::new(arg0),
            table : 0x2::table::new<0x1::type_name::TypeName, 0x2::object::ID>(arg0),
        };
        let v1 = PythRegistryCap{
            id  : 0x2::object::new(arg0),
            for : 0x2::object::id<PythRegistry>(&v0),
        };
        0x2::transfer::share_object<PythRegistry>(v0);
        0x2::transfer::transfer<PythRegistryCap>(v1, 0x2::tx_context::sender(arg0));
    }

    public entry fun register_pyth_price_info_object<T0>(arg0: &mut PythRegistry, arg1: &PythRegistryCap, arg2: &0xb53b0f4174108627fbee72e2498b58d6a2714cded53fac537034c220d26302::price_info::PriceInfoObject, arg3: &0x875803bb5915f264d6f0cfdebd6538e3e6b96310847b1dd63a68ff013fdd54f9::navi_aggregator::NaviAggregator, arg4: &mut 0x2::tx_context::TxContext) {
        assert!(0x2::object::id<PythRegistry>(arg0) == arg1.for, 20003);
        let v0 = 0x1::type_name::get<T0>();
        let (v1, v2, _) = 0x875803bb5915f264d6f0cfdebd6538e3e6b96310847b1dd63a68ff013fdd54f9::navi_aggregator::get_token_info<T0>(arg3);
        assert!(v1, 20004);
        if (0x2::table::contains<0x1::type_name::TypeName, 0x2::object::ID>(&arg0.table, v0)) {
            0x2::table::remove<0x1::type_name::TypeName, 0x2::object::ID>(&mut arg0.table, v0);
        };
        0x2::table::add<0x1::type_name::TypeName, 0x2::object::ID>(&mut arg0.table, v0, 0x2::object::id<0xb53b0f4174108627fbee72e2498b58d6a2714cded53fac537034c220d26302::price_info::PriceInfoObject>(arg2));
        let v4 = RegisterTokenEvent{
            admin             : 0x2::tx_context::sender(arg4),
            type_name         : 0x1::type_name::into_string(v0),
            price_info_object : 0x2::object::id<0xb53b0f4174108627fbee72e2498b58d6a2714cded53fac537034c220d26302::price_info::PriceInfoObject>(arg2),
            index             : v2,
        };
        0x2::event::emit<RegisterTokenEvent>(v4);
    }

    public entry fun set_pyth_price<T0>(arg0: &0x5306f64e312b581766351c07af79c72fcb1cd25147157fdc2f8ad76de9a3fb6a::state::State, arg1: &0xb53b0f4174108627fbee72e2498b58d6a2714cded53fac537034c220d26302::state::State, arg2: &mut 0xb53b0f4174108627fbee72e2498b58d6a2714cded53fac537034c220d26302::price_info::PriceInfoObject, arg3: &PythRegistry, arg4: vector<u8>, arg5: 0x2::coin::Coin<0x2::sui::SUI>, arg6: &0x2::clock::Clock, arg7: &0x875803bb5915f264d6f0cfdebd6538e3e6b96310847b1dd63a68ff013fdd54f9::navi_aggregator::NaviAggregatorCap, arg8: &mut 0x875803bb5915f264d6f0cfdebd6538e3e6b96310847b1dd63a68ff013fdd54f9::navi_aggregator::NaviAggregator, arg9: &mut 0x2::tx_context::TxContext) {
        assert_pyth_price_info_object<T0>(arg3, arg2);
        let (v0, _, v2) = 0x875803bb5915f264d6f0cfdebd6538e3e6b96310847b1dd63a68ff013fdd54f9::navi_aggregator::get_token_info<T0>(arg8);
        assert!(v0, 20004);
        let (v3, v4, v5) = get_pyth_price(arg0, arg1, arg2, arg4, arg5, arg6);
        let v6 = if (v4 < v2) {
            v3 * 0x2::math::pow(10, v2 - v4)
        } else {
            v3 / 0x2::math::pow(10, v4 - v2)
        };
        assert!(v3 > 0, 20001);
        0x875803bb5915f264d6f0cfdebd6538e3e6b96310847b1dd63a68ff013fdd54f9::navi_aggregator::update_token_price<T0>(arg7, arg8, 1, (v6 as u256), v5, arg9);
    }

    public entry fun set_pyth_price_v2<T0>(arg0: &PythRegistry, arg1: &0xb53b0f4174108627fbee72e2498b58d6a2714cded53fac537034c220d26302::price_info::PriceInfoObject, arg2: &0x875803bb5915f264d6f0cfdebd6538e3e6b96310847b1dd63a68ff013fdd54f9::navi_aggregator::NaviAggregatorCap, arg3: &mut 0x875803bb5915f264d6f0cfdebd6538e3e6b96310847b1dd63a68ff013fdd54f9::navi_aggregator::NaviAggregator, arg4: &mut 0x2::tx_context::TxContext) {
        assert_pyth_price_info_object<T0>(arg0, arg1);
        let (v0, _, v2) = 0x875803bb5915f264d6f0cfdebd6538e3e6b96310847b1dd63a68ff013fdd54f9::navi_aggregator::get_token_info<T0>(arg3);
        assert!(v0, 20004);
        let (v3, v4, v5) = get_pyth_price_unsafe(arg1);
        let v6 = if (v4 < v2) {
            v3 * 0x2::math::pow(10, v2 - v4)
        } else {
            v3 / 0x2::math::pow(10, v4 - v2)
        };
        assert!(v3 > 0, 20001);
        0x875803bb5915f264d6f0cfdebd6538e3e6b96310847b1dd63a68ff013fdd54f9::navi_aggregator::update_token_price<T0>(arg2, arg3, 1, (v6 as u256), v5, arg4);
    }

    fun update_price(arg0: &0x5306f64e312b581766351c07af79c72fcb1cd25147157fdc2f8ad76de9a3fb6a::state::State, arg1: &0xb53b0f4174108627fbee72e2498b58d6a2714cded53fac537034c220d26302::state::State, arg2: &mut 0xb53b0f4174108627fbee72e2498b58d6a2714cded53fac537034c220d26302::price_info::PriceInfoObject, arg3: vector<u8>, arg4: 0x2::coin::Coin<0x2::sui::SUI>, arg5: &0x2::clock::Clock) {
        0xb53b0f4174108627fbee72e2498b58d6a2714cded53fac537034c220d26302::hot_potato_vector::destroy<0xb53b0f4174108627fbee72e2498b58d6a2714cded53fac537034c220d26302::price_info::PriceInfo>(0xb53b0f4174108627fbee72e2498b58d6a2714cded53fac537034c220d26302::pyth::update_single_price_feed(arg1, 0xb53b0f4174108627fbee72e2498b58d6a2714cded53fac537034c220d26302::pyth::create_price_infos_hot_potato(arg1, 0x1::vector::singleton<0x5306f64e312b581766351c07af79c72fcb1cd25147157fdc2f8ad76de9a3fb6a::vaa::VAA>(0x5306f64e312b581766351c07af79c72fcb1cd25147157fdc2f8ad76de9a3fb6a::vaa::parse_and_verify(arg0, arg3, arg5)), arg5), arg2, arg4, arg5));
    }

    // decompiled from Move bytecode v6
}

