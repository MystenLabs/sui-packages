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

    public(friend) fun get_ema_price(arg0: &Oracle, arg1: &PriceIdentifier) : 0x4b591bbc246c9fadd28e7ac895e0778fb0e102f1b0d9f441e78d35f0d1ea1fcc::math::Number {
        0x2::dynamic_field::borrow<0x1::type_name::TypeName, PriceInfo>(&arg0.id, arg1.coin_type).ema_price
    }

    public(friend) fun get_price(arg0: &Oracle, arg1: &PriceIdentifier) : (0x4b591bbc246c9fadd28e7ac895e0778fb0e102f1b0d9f441e78d35f0d1ea1fcc::math::Number, 0x4b591bbc246c9fadd28e7ac895e0778fb0e102f1b0d9f441e78d35f0d1ea1fcc::math::Number) {
        let v0 = 0x2::dynamic_field::borrow<0x1::type_name::TypeName, PriceInfo>(&arg0.id, arg1.coin_type);
        (v0.price, v0.ema_price)
    }

    public(friend) fun add_coin_to_oracle(arg0: &mut Oracle, arg1: 0x1::type_name::TypeName, arg2: &mut 0x2::tx_context::TxContext) : PriceIdentifier {
        assert!(!0x2::dynamic_field::exists_<0x1::type_name::TypeName>(&arg0.id, arg1), 13906834569480372223);
        let v0 = PriceInfo{
            id           : 0x2::object::new(arg2),
            coin_type    : arg1,
            price        : 0x4b591bbc246c9fadd28e7ac895e0778fb0e102f1b0d9f441e78d35f0d1ea1fcc::math::from(0),
            ema_price    : 0x4b591bbc246c9fadd28e7ac895e0778fb0e102f1b0d9f441e78d35f0d1ea1fcc::math::from(0),
            last_updated : 0,
        };
        let v1 = PriceIdentifier{coin_type: arg1};
        0x2::dynamic_field::add<0x1::type_name::TypeName, PriceInfo>(&mut arg0.id, v1.coin_type, v0);
        v1
    }

    public(friend) fun create_oracle(arg0: &mut 0x2::tx_context::TxContext) : Oracle {
        Oracle{
            id                        : 0x2::object::new(arg0),
            price_identifiers         : 0x1::vector::empty<PriceIdentifier>(),
            price_staleness_threshold : 20,
        }
    }

    public fun get_last_updated(arg0: &Oracle, arg1: &PriceIdentifier) : u64 {
        0x2::dynamic_field::borrow<0x1::type_name::TypeName, PriceInfo>(&arg0.id, arg1.coin_type).last_updated
    }

    public(friend) fun get_price_identifier(arg0: &Oracle, arg1: 0x1::type_name::TypeName) : PriceIdentifier {
        assert!(0x2::dynamic_field::exists_<0x1::type_name::TypeName>(&arg0.id, arg1), 13906834500760895487);
        PriceIdentifier{coin_type: arg1}
    }

    public(friend) fun is_coin_in_oracle(arg0: &Oracle, arg1: 0x1::type_name::TypeName) : bool {
        0x2::dynamic_field::exists_<0x1::type_name::TypeName>(&arg0.id, arg1)
    }

    public(friend) fun set_price_staleness_threshold(arg0: &mut Oracle, arg1: u64) {
        arg0.price_staleness_threshold = arg1;
    }

    public fun update_price(arg0: &mut Oracle, arg1: &0x378b2a104e8bcd7ed0317f5e6a0ec4fd271d4d12e2fe6c99bcd1f12be725cf4f::oracle::PriceInfo) {
        let v0 = 0x2::dynamic_field::borrow_mut<0x1::type_name::TypeName, PriceInfo>(&mut arg0.id, 0x378b2a104e8bcd7ed0317f5e6a0ec4fd271d4d12e2fe6c99bcd1f12be725cf4f::oracle::coin_type(arg1));
        v0.price = 0x378b2a104e8bcd7ed0317f5e6a0ec4fd271d4d12e2fe6c99bcd1f12be725cf4f::oracle::get_price(arg1);
        v0.ema_price = 0x378b2a104e8bcd7ed0317f5e6a0ec4fd271d4d12e2fe6c99bcd1f12be725cf4f::oracle::get_ema_price(arg1);
        v0.last_updated = 0x378b2a104e8bcd7ed0317f5e6a0ec4fd271d4d12e2fe6c99bcd1f12be725cf4f::oracle::get_updated_time(arg1);
    }

    public fun verify_price(arg0: &Oracle, arg1: &PriceIdentifier, arg2: &0x2::clock::Clock) {
        assert!(0x2::clock::timestamp_ms(arg2) / 1000 - get_last_updated(arg0, arg1) <= arg0.price_staleness_threshold, 0);
    }

    // decompiled from Move bytecode v6
}

