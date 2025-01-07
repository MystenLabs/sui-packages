module 0x42a5d596cb9cd26a434423cffd3e5a9e636a5d3d802f0df7166b62f04caf7002::adaptor {
    struct PythRegistry has key {
        id: 0x2::object::UID,
        table: 0x2::table::Table<0x1::type_name::TypeName, 0x2::object::ID>,
    }

    struct PythRegistryCap has store, key {
        id: 0x2::object::UID,
        for: 0x2::object::ID,
    }

    struct Rule has drop {
        dummy_field: bool,
    }

    public fun assert_pyth_price_info_object<T0>(arg0: &PythRegistry, arg1: &0xb53b0f4174108627fbee72e2498b58d6a2714cded53fac537034c220d26302::price_info::PriceInfoObject) {
        assert!(0x2::object::id<0xb53b0f4174108627fbee72e2498b58d6a2714cded53fac537034c220d26302::price_info::PriceInfoObject>(arg1) == *0x2::table::borrow<0x1::type_name::TypeName, 0x2::object::ID>(&arg0.table, 0x1::type_name::get<T0>()), 20002);
    }

    public entry fun get_pyth_price(arg0: &0x5306f64e312b581766351c07af79c72fcb1cd25147157fdc2f8ad76de9a3fb6a::state::State, arg1: &0xb53b0f4174108627fbee72e2498b58d6a2714cded53fac537034c220d26302::state::State, arg2: &mut 0xb53b0f4174108627fbee72e2498b58d6a2714cded53fac537034c220d26302::price_info::PriceInfoObject, arg3: vector<u8>, arg4: 0x2::coin::Coin<0x2::sui::SUI>, arg5: &0x2::clock::Clock, arg6: bool, arg7: &mut 0x2::tx_context::TxContext) : (u64, u8, u64) {
        let v0 = if (arg6) {
            0x2::transfer::public_transfer<0x2::coin::Coin<0x2::sui::SUI>>(arg4, 0x2::tx_context::sender(arg7));
            0xb53b0f4174108627fbee72e2498b58d6a2714cded53fac537034c220d26302::pyth::get_price_unsafe(arg2)
        } else {
            update_price(arg0, arg1, arg2, arg3, arg4, arg5);
            0xb53b0f4174108627fbee72e2498b58d6a2714cded53fac537034c220d26302::pyth::get_price(arg1, arg2, arg5)
        };
        let v1 = v0;
        let v2 = 0xb53b0f4174108627fbee72e2498b58d6a2714cded53fac537034c220d26302::price::get_price(&v1);
        let v3 = 0xb53b0f4174108627fbee72e2498b58d6a2714cded53fac537034c220d26302::price::get_expo(&v1);
        let v4 = 0xb53b0f4174108627fbee72e2498b58d6a2714cded53fac537034c220d26302::i64::get_magnitude_if_negative(&v3);
        assert!(v4 <= 255, 20001);
        (0xb53b0f4174108627fbee72e2498b58d6a2714cded53fac537034c220d26302::i64::get_magnitude_if_positive(&v2), (v4 as u8), 0xb53b0f4174108627fbee72e2498b58d6a2714cded53fac537034c220d26302::price::get_timestamp(&v1))
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

    public entry fun register_pyth_price_info_object<T0>(arg0: &mut PythRegistry, arg1: &PythRegistryCap, arg2: &0xb53b0f4174108627fbee72e2498b58d6a2714cded53fac537034c220d26302::price_info::PriceInfoObject, arg3: &0x7b9325c52f10906dfb260533709e257ffc9540ade62e5f65e4852565de0c4bed::navi_aggregator::NaviAggregator) {
        assert!(0x2::object::id<PythRegistry>(arg0) == arg1.for, 20003);
        let v0 = 0x1::type_name::get<T0>();
        let (v1, _, _) = 0x7b9325c52f10906dfb260533709e257ffc9540ade62e5f65e4852565de0c4bed::navi_aggregator::get_token_info<T0>(arg3);
        assert!(v1, 20004);
        if (0x2::table::contains<0x1::type_name::TypeName, 0x2::object::ID>(&arg0.table, v0)) {
            0x2::table::remove<0x1::type_name::TypeName, 0x2::object::ID>(&mut arg0.table, v0);
        };
        0x2::table::add<0x1::type_name::TypeName, 0x2::object::ID>(&mut arg0.table, v0, 0x2::object::id<0xb53b0f4174108627fbee72e2498b58d6a2714cded53fac537034c220d26302::price_info::PriceInfoObject>(arg2));
    }

    public entry fun set_pyth_price<T0>(arg0: &0x5306f64e312b581766351c07af79c72fcb1cd25147157fdc2f8ad76de9a3fb6a::state::State, arg1: &0xb53b0f4174108627fbee72e2498b58d6a2714cded53fac537034c220d26302::state::State, arg2: &mut 0xb53b0f4174108627fbee72e2498b58d6a2714cded53fac537034c220d26302::price_info::PriceInfoObject, arg3: &PythRegistry, arg4: vector<u8>, arg5: 0x2::coin::Coin<0x2::sui::SUI>, arg6: &0x2::clock::Clock, arg7: bool, arg8: &0x7b9325c52f10906dfb260533709e257ffc9540ade62e5f65e4852565de0c4bed::navi_aggregator::NaviAggregatorCap, arg9: &mut 0x7b9325c52f10906dfb260533709e257ffc9540ade62e5f65e4852565de0c4bed::navi_aggregator::NaviAggregator, arg10: &mut 0x2::tx_context::TxContext) {
        assert_pyth_price_info_object<T0>(arg3, arg2);
        let (v0, v1, v2) = get_pyth_price(arg0, arg1, arg2, arg4, arg5, arg6, arg7, arg10);
        let (v3, _, v5) = 0x7b9325c52f10906dfb260533709e257ffc9540ade62e5f65e4852565de0c4bed::navi_aggregator::get_token_info<T0>(arg9);
        assert!(v3, 20004);
        let v6 = if (v1 < v5) {
            v0 * 0x2::math::pow(10, v5 - v1)
        } else {
            v0 / 0x2::math::pow(10, v1 - v5)
        };
        assert!(v0 > 0, 20001);
        0x7b9325c52f10906dfb260533709e257ffc9540ade62e5f65e4852565de0c4bed::navi_aggregator::update_token_price<Rule, T0>(arg8, arg9, (v6 as u256), v2, arg10);
    }

    fun update_price(arg0: &0x5306f64e312b581766351c07af79c72fcb1cd25147157fdc2f8ad76de9a3fb6a::state::State, arg1: &0xb53b0f4174108627fbee72e2498b58d6a2714cded53fac537034c220d26302::state::State, arg2: &mut 0xb53b0f4174108627fbee72e2498b58d6a2714cded53fac537034c220d26302::price_info::PriceInfoObject, arg3: vector<u8>, arg4: 0x2::coin::Coin<0x2::sui::SUI>, arg5: &0x2::clock::Clock) {
        0xb53b0f4174108627fbee72e2498b58d6a2714cded53fac537034c220d26302::hot_potato_vector::destroy<0xb53b0f4174108627fbee72e2498b58d6a2714cded53fac537034c220d26302::price_info::PriceInfo>(0xb53b0f4174108627fbee72e2498b58d6a2714cded53fac537034c220d26302::pyth::update_single_price_feed(arg1, 0xb53b0f4174108627fbee72e2498b58d6a2714cded53fac537034c220d26302::pyth::create_price_infos_hot_potato(arg1, 0x1::vector::singleton<0x5306f64e312b581766351c07af79c72fcb1cd25147157fdc2f8ad76de9a3fb6a::vaa::VAA>(0x5306f64e312b581766351c07af79c72fcb1cd25147157fdc2f8ad76de9a3fb6a::vaa::parse_and_verify(arg0, arg3, arg5)), arg5), arg2, arg4, arg5));
    }

    // decompiled from Move bytecode v6
}

