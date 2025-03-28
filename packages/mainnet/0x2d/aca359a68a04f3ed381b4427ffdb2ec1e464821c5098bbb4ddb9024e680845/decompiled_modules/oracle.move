module 0x2daca359a68a04f3ed381b4427ffdb2ec1e464821c5098bbb4ddb9024e680845::oracle {
    struct PriceOracle has key {
        id: 0x2::object::UID,
        price_guard_time: u64,
        price_fresh_time: u64,
        price_identifiers: 0x2::table::Table<u16, 0xb53b0f4174108627fbee72e2498b58d6a2714cded53fac537034c220d26302::price_identifier::PriceIdentifier>,
        price_oracles: 0x2::table::Table<u16, Price>,
    }

    struct Price has store {
        value: u256,
        decimal: u8,
        last_update_timestamp: u64,
    }

    public fun check_fresh_price(arg0: &mut PriceOracle, arg1: vector<u16>, arg2: &0x2::clock::Clock) {
        let v0 = &mut arg0.price_oracles;
        let v1 = 0;
        while (v1 < 0x1::vector::length<u16>(&arg1)) {
            assert!(0x2::clock::timestamp_ms(arg2) / 1000 - 0x2::table::borrow<u16, Price>(v0, *0x1::vector::borrow<u16>(&arg1, v1)).last_update_timestamp < arg0.price_fresh_time, 2);
            v1 = v1 + 1;
        };
    }

    public fun check_guard_price(arg0: &mut PriceOracle, arg1: vector<u16>, arg2: &0x2::clock::Clock) {
        let v0 = &mut arg0.price_oracles;
        let v1 = 0;
        while (v1 < 0x1::vector::length<u16>(&arg1)) {
            assert!(0x2::clock::timestamp_ms(arg2) / 1000 - 0x2::table::borrow<u16, Price>(v0, *0x1::vector::borrow<u16>(&arg1, v1)).last_update_timestamp < arg0.price_guard_time, 3);
            v1 = v1 + 1;
        };
    }

    public fun feed_token_price_by_pyth(arg0: &0x2daca359a68a04f3ed381b4427ffdb2ec1e464821c5098bbb4ddb9024e680845::genesis::GovernanceGenesis, arg1: &mut 0x5306f64e312b581766351c07af79c72fcb1cd25147157fdc2f8ad76de9a3fb6a::state::State, arg2: &mut 0xb53b0f4174108627fbee72e2498b58d6a2714cded53fac537034c220d26302::state::State, arg3: &mut 0xb53b0f4174108627fbee72e2498b58d6a2714cded53fac537034c220d26302::price_info::PriceInfoObject, arg4: &mut PriceOracle, arg5: u16, arg6: vector<u8>, arg7: &0x2::clock::Clock, arg8: 0x2::coin::Coin<0x2::sui::SUI>) {
        0x2daca359a68a04f3ed381b4427ffdb2ec1e464821c5098bbb4ddb9024e680845::genesis::check_latest_version(arg0);
        assert!(0x2::table::contains<u16, 0xb53b0f4174108627fbee72e2498b58d6a2714cded53fac537034c220d26302::price_identifier::PriceIdentifier>(&arg4.price_identifiers, arg5), 0);
        let v0 = 0xb53b0f4174108627fbee72e2498b58d6a2714cded53fac537034c220d26302::price_info::get_price_info_from_price_info_object(arg3);
        let v1 = 0xb53b0f4174108627fbee72e2498b58d6a2714cded53fac537034c220d26302::price_info::get_price_identifier(&v0);
        assert!(0x2::table::borrow<u16, 0xb53b0f4174108627fbee72e2498b58d6a2714cded53fac537034c220d26302::price_identifier::PriceIdentifier>(&mut arg4.price_identifiers, arg5) == &v1, 4);
        let v2 = 0x1::vector::empty<0x5306f64e312b581766351c07af79c72fcb1cd25147157fdc2f8ad76de9a3fb6a::vaa::VAA>();
        0x1::vector::push_back<0x5306f64e312b581766351c07af79c72fcb1cd25147157fdc2f8ad76de9a3fb6a::vaa::VAA>(&mut v2, 0x5306f64e312b581766351c07af79c72fcb1cd25147157fdc2f8ad76de9a3fb6a::vaa::parse_and_verify(arg1, arg6, arg7));
        let v3 = 0x2::table::borrow_mut<u16, Price>(&mut arg4.price_oracles, arg5);
        let v4 = 0xb53b0f4174108627fbee72e2498b58d6a2714cded53fac537034c220d26302::pyth::get_price_no_older_than(arg3, arg7, 60);
        0xb53b0f4174108627fbee72e2498b58d6a2714cded53fac537034c220d26302::hot_potato_vector::destroy<0xb53b0f4174108627fbee72e2498b58d6a2714cded53fac537034c220d26302::price_info::PriceInfo>(0xb53b0f4174108627fbee72e2498b58d6a2714cded53fac537034c220d26302::pyth::update_single_price_feed(arg2, 0xb53b0f4174108627fbee72e2498b58d6a2714cded53fac537034c220d26302::pyth::create_price_infos_hot_potato(arg2, v2, arg7), arg3, arg8, arg7));
        let v5 = 0xb53b0f4174108627fbee72e2498b58d6a2714cded53fac537034c220d26302::price::get_price(&v4);
        let v6 = 0xb53b0f4174108627fbee72e2498b58d6a2714cded53fac537034c220d26302::price::get_expo(&v4);
        v3.value = (0xb53b0f4174108627fbee72e2498b58d6a2714cded53fac537034c220d26302::i64::get_magnitude_if_positive(&v5) as u256);
        v3.decimal = (0xb53b0f4174108627fbee72e2498b58d6a2714cded53fac537034c220d26302::i64::get_magnitude_if_negative(&v6) as u8);
        v3.last_update_timestamp = 0x2::clock::timestamp_ms(arg7) / 1000;
    }

    public fun get_token_price(arg0: &mut PriceOracle, arg1: u16) : (u256, u8, u64) {
        let v0 = &mut arg0.price_oracles;
        assert!(0x2::table::contains<u16, Price>(v0, arg1), 0);
        let v1 = 0x2::table::borrow<u16, Price>(v0, arg1);
        (v1.value, v1.decimal, v1.last_update_timestamp)
    }

    fun init(arg0: &mut 0x2::tx_context::TxContext) {
        let v0 = PriceOracle{
            id                : 0x2::object::new(arg0),
            price_guard_time  : 3600,
            price_fresh_time  : 60,
            price_identifiers : 0x2::table::new<u16, 0xb53b0f4174108627fbee72e2498b58d6a2714cded53fac537034c220d26302::price_identifier::PriceIdentifier>(arg0),
            price_oracles     : 0x2::table::new<u16, Price>(arg0),
        };
        0x2::transfer::share_object<PriceOracle>(v0);
    }

    public fun register_token_price(arg0: &0x2daca359a68a04f3ed381b4427ffdb2ec1e464821c5098bbb4ddb9024e680845::genesis::GovernanceCap, arg1: &mut PriceOracle, arg2: vector<u8>, arg3: u16, arg4: u256, arg5: u8, arg6: &0x2::clock::Clock) {
        let v0 = &mut arg1.price_oracles;
        assert!(!0x2::table::contains<u16, Price>(v0, arg3), 1);
        let v1 = &mut arg1.price_identifiers;
        assert!(!0x2::table::contains<u16, 0xb53b0f4174108627fbee72e2498b58d6a2714cded53fac537034c220d26302::price_identifier::PriceIdentifier>(v1, arg3), 1);
        0x2::table::add<u16, 0xb53b0f4174108627fbee72e2498b58d6a2714cded53fac537034c220d26302::price_identifier::PriceIdentifier>(v1, arg3, 0xb53b0f4174108627fbee72e2498b58d6a2714cded53fac537034c220d26302::price_identifier::from_byte_vec(arg2));
        let v2 = Price{
            value                 : arg4,
            decimal               : arg5,
            last_update_timestamp : 0x2::clock::timestamp_ms(arg6) / 1000,
        };
        0x2::table::add<u16, Price>(v0, arg3, v2);
    }

    public fun set_price_fresh_time(arg0: &0x2daca359a68a04f3ed381b4427ffdb2ec1e464821c5098bbb4ddb9024e680845::genesis::GovernanceCap, arg1: &mut PriceOracle, arg2: u64) {
        arg1.price_fresh_time = arg2;
    }

    public fun set_price_guard_time(arg0: &0x2daca359a68a04f3ed381b4427ffdb2ec1e464821c5098bbb4ddb9024e680845::genesis::GovernanceCap, arg1: &mut PriceOracle, arg2: u64) {
        arg1.price_guard_time = arg2;
    }

    // decompiled from Move bytecode v6
}

