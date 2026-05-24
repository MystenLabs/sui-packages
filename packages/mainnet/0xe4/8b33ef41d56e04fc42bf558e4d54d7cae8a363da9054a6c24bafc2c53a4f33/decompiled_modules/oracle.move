module 0xd631cd66138909636fc3f73ed75820d0c5b76332d1644608ed1c85ea2b8219b4::oracle {
    struct PriceIdentifier has copy, drop, store {
        coin_type: 0x1::type_name::TypeName,
    }

    struct Oracle has store, key {
        id: 0x2::object::UID,
        price_identifiers: vector<PriceIdentifier>,
        price_staleness_threshold: u64,
    }

    struct PriceInfo has store, key {
        id: 0x2::object::UID,
        coin_type: 0x1::type_name::TypeName,
        price: 0x4b591bbc246c9fadd28e7ac895e0778fb0e102f1b0d9f441e78d35f0d1ea1fcc::math::Number,
        ema_price: 0x4b591bbc246c9fadd28e7ac895e0778fb0e102f1b0d9f441e78d35f0d1ea1fcc::math::Number,
        last_updated: u64,
    }

    struct OracleIdentityKey has copy, drop, store {
        dummy_field: bool,
    }

    struct OracleIdentity has store, key {
        id: 0x2::object::UID,
    }

    public(friend) fun get_ema_price(arg0: &Oracle, arg1: &PriceIdentifier) : 0x4b591bbc246c9fadd28e7ac895e0778fb0e102f1b0d9f441e78d35f0d1ea1fcc::math::Number {
        get_price_info(arg0, arg1).ema_price
    }

    public(friend) fun get_price(arg0: &Oracle, arg1: &PriceIdentifier) : (0x4b591bbc246c9fadd28e7ac895e0778fb0e102f1b0d9f441e78d35f0d1ea1fcc::math::Number, 0x4b591bbc246c9fadd28e7ac895e0778fb0e102f1b0d9f441e78d35f0d1ea1fcc::math::Number) {
        let v0 = get_price_info(arg0, arg1);
        (v0.price, v0.ema_price)
    }

    public(friend) fun add_coin_to_oracle(arg0: &mut Oracle, arg1: 0x1::type_name::TypeName, arg2: &mut 0x2::tx_context::TxContext) : PriceIdentifier {
        let v0 = OracleIdentityKey{dummy_field: false};
        if (!0x2::dynamic_field::exists_<OracleIdentityKey>(&arg0.id, v0)) {
            let v1 = OracleIdentity{id: 0x2::object::new(arg2)};
            let v2 = OracleIdentityKey{dummy_field: false};
            0x2::dynamic_field::add<OracleIdentityKey, OracleIdentity>(&mut arg0.id, v2, v1);
        };
        if (0x2::dynamic_field::exists_<0x1::type_name::TypeName>(&arg0.id, arg1)) {
            let PriceInfo {
                id           : v3,
                coin_type    : _,
                price        : _,
                ema_price    : _,
                last_updated : _,
            } = 0x2::dynamic_field::remove<0x1::type_name::TypeName, PriceInfo>(&mut arg0.id, arg1);
            0x2::object::delete(v3);
        };
        let v8 = PriceInfo{
            id           : 0x2::object::new(arg2),
            coin_type    : arg1,
            price        : 0x4b591bbc246c9fadd28e7ac895e0778fb0e102f1b0d9f441e78d35f0d1ea1fcc::math::from(0),
            ema_price    : 0x4b591bbc246c9fadd28e7ac895e0778fb0e102f1b0d9f441e78d35f0d1ea1fcc::math::from(0),
            last_updated : 0,
        };
        let v9 = PriceIdentifier{coin_type: arg1};
        let v10 = OracleIdentityKey{dummy_field: false};
        0x2::dynamic_field::add<0x1::type_name::TypeName, PriceInfo>(&mut 0x2::dynamic_field::borrow_mut<OracleIdentityKey, OracleIdentity>(&mut arg0.id, v10).id, v9.coin_type, v8);
        v9
    }

    public(friend) fun create_oracle(arg0: &mut 0x2::tx_context::TxContext) : Oracle {
        Oracle{
            id                        : 0x2::object::new(arg0),
            price_identifiers         : 0x1::vector::empty<PriceIdentifier>(),
            price_staleness_threshold : 20,
        }
    }

    public fun get_last_updated(arg0: &Oracle, arg1: &PriceIdentifier) : u64 {
        get_price_info(arg0, arg1).last_updated
    }

    public(friend) fun get_price_identifier(arg0: &Oracle, arg1: 0x1::type_name::TypeName) : PriceIdentifier {
        let v0 = OracleIdentityKey{dummy_field: false};
        assert!(0x2::dynamic_field::exists_<0x1::type_name::TypeName>(&0x2::dynamic_field::borrow<OracleIdentityKey, OracleIdentity>(&arg0.id, v0).id, arg1), 13906834569480372223);
        PriceIdentifier{coin_type: arg1}
    }

    fun get_price_info(arg0: &Oracle, arg1: &PriceIdentifier) : &PriceInfo {
        let v0 = OracleIdentityKey{dummy_field: false};
        0x2::dynamic_field::borrow<0x1::type_name::TypeName, PriceInfo>(&0x2::dynamic_field::borrow<OracleIdentityKey, OracleIdentity>(&arg0.id, v0).id, arg1.coin_type)
    }

    public(friend) fun is_coin_in_oracle(arg0: &Oracle, arg1: 0x1::type_name::TypeName) : bool {
        let v0 = OracleIdentityKey{dummy_field: false};
        0x2::dynamic_field::exists_<0x1::type_name::TypeName>(&0x2::dynamic_field::borrow<OracleIdentityKey, OracleIdentity>(&arg0.id, v0).id, arg1)
    }

    public fun match_coin_type(arg0: &PriceIdentifier, arg1: 0x1::type_name::TypeName) {
        assert!(arg0.coin_type == arg1, 1);
    }

    public(friend) fun set_price_staleness_threshold(arg0: &mut Oracle, arg1: u64) {
        assert!(arg1 < 120, 0);
        arg0.price_staleness_threshold = arg1;
    }

    public fun update_price(arg0: &mut Oracle, arg1: &0x378b2a104e8bcd7ed0317f5e6a0ec4fd271d4d12e2fe6c99bcd1f12be725cf4f::oracle::PriceInfo) {
        abort 4
    }

    public(friend) fun update_price_internal(arg0: &mut Oracle, arg1: &0x378b2a104e8bcd7ed0317f5e6a0ec4fd271d4d12e2fe6c99bcd1f12be725cf4f::oracle::PriceInfo) {
        let v0 = OracleIdentityKey{dummy_field: false};
        let v1 = 0x2::dynamic_field::borrow_mut<OracleIdentityKey, OracleIdentity>(&mut arg0.id, v0);
        assert!(0x2::dynamic_field::exists_<0x1::type_name::TypeName>(&v1.id, 0x378b2a104e8bcd7ed0317f5e6a0ec4fd271d4d12e2fe6c99bcd1f12be725cf4f::oracle::coin_type(arg1)), 3);
        let v2 = 0x2::dynamic_field::borrow_mut<0x1::type_name::TypeName, PriceInfo>(&mut v1.id, 0x378b2a104e8bcd7ed0317f5e6a0ec4fd271d4d12e2fe6c99bcd1f12be725cf4f::oracle::coin_type(arg1));
        if (v2.last_updated >= 0x378b2a104e8bcd7ed0317f5e6a0ec4fd271d4d12e2fe6c99bcd1f12be725cf4f::oracle::get_updated_time(arg1)) {
            return
        };
        v2.price = 0x378b2a104e8bcd7ed0317f5e6a0ec4fd271d4d12e2fe6c99bcd1f12be725cf4f::oracle::get_price(arg1);
        v2.ema_price = 0x378b2a104e8bcd7ed0317f5e6a0ec4fd271d4d12e2fe6c99bcd1f12be725cf4f::oracle::get_ema_price(arg1);
        v2.last_updated = 0x378b2a104e8bcd7ed0317f5e6a0ec4fd271d4d12e2fe6c99bcd1f12be725cf4f::oracle::get_updated_time(arg1);
    }

    public fun verify_price(arg0: &Oracle, arg1: &PriceIdentifier, arg2: &0x2::clock::Clock) {
        assert!(0x2::clock::timestamp_ms(arg2) / 1000 - get_last_updated(arg0, arg1) <= arg0.price_staleness_threshold, 5);
    }

    // decompiled from Move bytecode v7
}

