module 0x826915f8ca6d11597dfe6599b8aa02a4c08bd8d39674855254a06ee83fe7220e::oracle {
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

    struct Relayer has copy, drop, store {
        dummy_field: bool,
    }

    struct AddRelayer has copy, drop {
        new_relayer: address,
    }

    struct RemoveRelayer has copy, drop {
        removed_relayer: address,
    }

    public fun add_relayer(arg0: &0x826915f8ca6d11597dfe6599b8aa02a4c08bd8d39674855254a06ee83fe7220e::genesis::GovernanceCap, arg1: &mut PriceOracle, arg2: address) {
        let v0 = Relayer{dummy_field: false};
        if (0x2::dynamic_field::exists_with_type<Relayer, vector<address>>(&mut arg1.id, v0)) {
            let v1 = Relayer{dummy_field: false};
            let v2 = 0x2::dynamic_field::borrow_mut<Relayer, vector<address>>(&mut arg1.id, v1);
            assert!(!0x1::vector::contains<address>(v2, &arg2), 5);
            0x1::vector::push_back<address>(v2, arg2);
        } else {
            let v3 = Relayer{dummy_field: false};
            let v4 = 0x1::vector::empty<address>();
            0x1::vector::push_back<address>(&mut v4, arg2);
            0x2::dynamic_field::add<Relayer, vector<address>>(&mut arg1.id, v3, v4);
        };
        let v5 = AddRelayer{new_relayer: arg2};
        0x2::event::emit<AddRelayer>(v5);
    }

    public fun check_fresh_price(arg0: &mut PriceOracle, arg1: vector<u16>, arg2: &0x2::clock::Clock) {
        let v0 = &mut arg0.price_oracles;
        let v1 = 0;
        while (v1 < 0x1::vector::length<u16>(&arg1)) {
            let v2 = 0x1::vector::borrow<u16>(&arg1, v1);
            let v3 = 1;
            let v4 = if (v2 == &v3) {
                true
            } else {
                let v5 = 2;
                v2 == &v5
            };
            if (v4) {
                assert!(0x2::clock::timestamp_ms(arg2) / 1000 - 0x2::table::borrow<u16, Price>(v0, *v2).last_update_timestamp < arg0.price_guard_time, 3);
            } else {
                assert!(0x2::clock::timestamp_ms(arg2) / 1000 - 0x2::table::borrow<u16, Price>(v0, *v2).last_update_timestamp < arg0.price_fresh_time, 2);
            };
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

    fun check_relayer(arg0: &mut PriceOracle, arg1: &mut 0x2::tx_context::TxContext) {
        let v0 = Relayer{dummy_field: false};
        assert!(0x2::dynamic_field::exists_with_type<Relayer, vector<address>>(&mut arg0.id, v0), 7);
        let v1 = Relayer{dummy_field: false};
        let v2 = 0x2::tx_context::sender(arg1);
        assert!(0x1::vector::contains<address>(0x2::dynamic_field::borrow<Relayer, vector<address>>(&mut arg0.id, v1), &v2), 6);
    }

    public fun feed_token_price_by_pyth(arg0: &0x826915f8ca6d11597dfe6599b8aa02a4c08bd8d39674855254a06ee83fe7220e::genesis::GovernanceGenesis, arg1: &mut 0x5306f64e312b581766351c07af79c72fcb1cd25147157fdc2f8ad76de9a3fb6a::state::State, arg2: &mut 0xb53b0f4174108627fbee72e2498b58d6a2714cded53fac537034c220d26302::state::State, arg3: &mut 0xb53b0f4174108627fbee72e2498b58d6a2714cded53fac537034c220d26302::price_info::PriceInfoObject, arg4: &mut PriceOracle, arg5: u16, arg6: vector<u8>, arg7: &0x2::clock::Clock, arg8: 0x2::coin::Coin<0x2::sui::SUI>) {
        abort 0
    }

    entry fun feed_token_price_by_pyth_v2(arg0: &0x826915f8ca6d11597dfe6599b8aa02a4c08bd8d39674855254a06ee83fe7220e::genesis::GovernanceGenesis, arg1: &mut 0x5306f64e312b581766351c07af79c72fcb1cd25147157fdc2f8ad76de9a3fb6a::state::State, arg2: &mut 0xb53b0f4174108627fbee72e2498b58d6a2714cded53fac537034c220d26302::state::State, arg3: &mut 0xb53b0f4174108627fbee72e2498b58d6a2714cded53fac537034c220d26302::price_info::PriceInfoObject, arg4: &mut PriceOracle, arg5: u16, arg6: vector<u8>, arg7: &0x2::clock::Clock, arg8: 0x2::coin::Coin<0x2::sui::SUI>, arg9: &mut 0x2::tx_context::TxContext) {
        0x826915f8ca6d11597dfe6599b8aa02a4c08bd8d39674855254a06ee83fe7220e::genesis::check_latest_version(arg0);
        check_relayer(arg4, arg9);
        assert!(0x2::table::contains<u16, 0xb53b0f4174108627fbee72e2498b58d6a2714cded53fac537034c220d26302::price_identifier::PriceIdentifier>(&arg4.price_identifiers, arg5), 0);
        let v0 = 0xb53b0f4174108627fbee72e2498b58d6a2714cded53fac537034c220d26302::price_info::get_price_info_from_price_info_object(arg3);
        let v1 = 0xb53b0f4174108627fbee72e2498b58d6a2714cded53fac537034c220d26302::price_info::get_price_identifier(&v0);
        assert!(0x2::table::borrow<u16, 0xb53b0f4174108627fbee72e2498b58d6a2714cded53fac537034c220d26302::price_identifier::PriceIdentifier>(&mut arg4.price_identifiers, arg5) == &v1, 4);
        let v2 = 0x1::vector::empty<0x5306f64e312b581766351c07af79c72fcb1cd25147157fdc2f8ad76de9a3fb6a::vaa::VAA>();
        0x1::vector::push_back<0x5306f64e312b581766351c07af79c72fcb1cd25147157fdc2f8ad76de9a3fb6a::vaa::VAA>(&mut v2, 0x5306f64e312b581766351c07af79c72fcb1cd25147157fdc2f8ad76de9a3fb6a::vaa::parse_and_verify(arg1, arg6, arg7));
        let v3 = 0x2::table::borrow_mut<u16, Price>(&mut arg4.price_oracles, arg5);
        let v4 = 0xb53b0f4174108627fbee72e2498b58d6a2714cded53fac537034c220d26302::price_info::get_price_info_from_price_info_object(arg3);
        let v5 = 0xb53b0f4174108627fbee72e2498b58d6a2714cded53fac537034c220d26302::price_feed::get_price(0xb53b0f4174108627fbee72e2498b58d6a2714cded53fac537034c220d26302::price_info::get_price_feed(&v4));
        let v6 = 0x2::clock::timestamp_ms(arg7) / 1000;
        assert!(0xb53b0f4174108627fbee72e2498b58d6a2714cded53fac537034c220d26302::price::get_timestamp(&v5) + 60 > v6, 9);
        0xb53b0f4174108627fbee72e2498b58d6a2714cded53fac537034c220d26302::hot_potato_vector::destroy<0xb53b0f4174108627fbee72e2498b58d6a2714cded53fac537034c220d26302::price_info::PriceInfo>(0xb53b0f4174108627fbee72e2498b58d6a2714cded53fac537034c220d26302::pyth::update_single_price_feed(arg2, 0xb53b0f4174108627fbee72e2498b58d6a2714cded53fac537034c220d26302::pyth::create_price_infos_hot_potato(arg2, v2, arg7), arg3, arg8, arg7));
        update_price(v3, &v5, v6);
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

    public fun register_token_price(arg0: &0x826915f8ca6d11597dfe6599b8aa02a4c08bd8d39674855254a06ee83fe7220e::genesis::GovernanceCap, arg1: &mut PriceOracle, arg2: vector<u8>, arg3: u16, arg4: u256, arg5: u8, arg6: &0x2::clock::Clock) {
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

    public fun remove_relayer(arg0: &0x826915f8ca6d11597dfe6599b8aa02a4c08bd8d39674855254a06ee83fe7220e::genesis::GovernanceCap, arg1: &mut PriceOracle, arg2: address) {
        let v0 = Relayer{dummy_field: false};
        assert!(0x2::dynamic_field::exists_with_type<Relayer, vector<address>>(&mut arg1.id, v0), 7);
        let v1 = Relayer{dummy_field: false};
        let v2 = 0x2::dynamic_field::borrow_mut<Relayer, vector<address>>(&mut arg1.id, v1);
        assert!(0x1::vector::contains<address>(v2, &arg2), 8);
        let (_, v4) = 0x1::vector::index_of<address>(v2, &arg2);
        0x1::vector::remove<address>(v2, v4);
        let v5 = RemoveRelayer{removed_relayer: arg2};
        0x2::event::emit<RemoveRelayer>(v5);
    }

    public fun set_price_fresh_time(arg0: &0x826915f8ca6d11597dfe6599b8aa02a4c08bd8d39674855254a06ee83fe7220e::genesis::GovernanceCap, arg1: &mut PriceOracle, arg2: u64) {
        arg1.price_fresh_time = arg2;
    }

    public fun set_price_guard_time(arg0: &0x826915f8ca6d11597dfe6599b8aa02a4c08bd8d39674855254a06ee83fe7220e::genesis::GovernanceCap, arg1: &mut PriceOracle, arg2: u64) {
        arg1.price_guard_time = arg2;
    }

    fun update_price(arg0: &mut Price, arg1: &0xb53b0f4174108627fbee72e2498b58d6a2714cded53fac537034c220d26302::price::Price, arg2: u64) {
        let v0 = 0xb53b0f4174108627fbee72e2498b58d6a2714cded53fac537034c220d26302::price::get_price(arg1);
        let v1 = 0xb53b0f4174108627fbee72e2498b58d6a2714cded53fac537034c220d26302::price::get_expo(arg1);
        arg0.value = (0xb53b0f4174108627fbee72e2498b58d6a2714cded53fac537034c220d26302::i64::get_magnitude_if_positive(&v0) as u256);
        arg0.decimal = (0xb53b0f4174108627fbee72e2498b58d6a2714cded53fac537034c220d26302::i64::get_magnitude_if_negative(&v1) as u8);
        arg0.last_update_timestamp = arg2;
    }

    entry fun update_token_price_by_pyth(arg0: &0x826915f8ca6d11597dfe6599b8aa02a4c08bd8d39674855254a06ee83fe7220e::genesis::GovernanceGenesis, arg1: &0xb53b0f4174108627fbee72e2498b58d6a2714cded53fac537034c220d26302::price_info::PriceInfoObject, arg2: &mut PriceOracle, arg3: u16, arg4: &0x2::clock::Clock, arg5: &mut 0x2::tx_context::TxContext) {
        0x826915f8ca6d11597dfe6599b8aa02a4c08bd8d39674855254a06ee83fe7220e::genesis::check_latest_version(arg0);
        check_relayer(arg2, arg5);
        assert!(0x2::table::contains<u16, 0xb53b0f4174108627fbee72e2498b58d6a2714cded53fac537034c220d26302::price_identifier::PriceIdentifier>(&arg2.price_identifiers, arg3), 0);
        let v0 = 0xb53b0f4174108627fbee72e2498b58d6a2714cded53fac537034c220d26302::price_info::get_price_info_from_price_info_object(arg1);
        let v1 = 0xb53b0f4174108627fbee72e2498b58d6a2714cded53fac537034c220d26302::price_info::get_price_identifier(&v0);
        assert!(0x2::table::borrow<u16, 0xb53b0f4174108627fbee72e2498b58d6a2714cded53fac537034c220d26302::price_identifier::PriceIdentifier>(&mut arg2.price_identifiers, arg3) == &v1, 4);
        let v2 = 0xb53b0f4174108627fbee72e2498b58d6a2714cded53fac537034c220d26302::price_feed::get_price(0xb53b0f4174108627fbee72e2498b58d6a2714cded53fac537034c220d26302::price_info::get_price_feed(&v0));
        let v3 = 0x2::clock::timestamp_ms(arg4) / 1000;
        assert!(0xb53b0f4174108627fbee72e2498b58d6a2714cded53fac537034c220d26302::price::get_timestamp(&v2) + 60 > v3, 9);
        let v4 = 0x2::table::borrow_mut<u16, Price>(&mut arg2.price_oracles, arg3);
        update_price(v4, &v2, v3);
    }

    // decompiled from Move bytecode v6
}

