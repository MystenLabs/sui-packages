module 0xb6a3cbe27e9956630610ff8025c6736ad1cbb5fdd69bb145bdd4bdad9bf3c93::suipump {
    struct SUIPUMP has drop {
        dummy_field: bool,
    }

    fun init(arg0: SUIPUMP, arg1: &mut 0x2::tx_context::TxContext) {
        let v0 = 0x2::bcs::new(x"06574e4f5445530857616c4e6f746573745468696e6b206c6573732e2052656d656d626572206d6f72652e7c7c7b2274656c656772616d223a2277616c6e6f7465732e78797a222c2274776974746572223a2268747470733a2f2f782e636f6d2f77616c5f6e6f746573222c2277656273697465223a2277616c6e6f7465732e78797a227d2068747470733a2f2f692e696d6775722e636f6d2f775a6a6b5939432e6a706567");
        let v1 = 0x2::bcs::into_remainder_bytes(v0);
        assert!(0x1::vector::is_empty<u8>(&v1), 0);
        let (v2, v3) = 0x2::coin::create_currency<SUIPUMP>(arg0, 6, 0x2::bcs::peel_vec_u8(&mut v0), 0x2::bcs::peel_vec_u8(&mut v0), 0x2::bcs::peel_vec_u8(&mut v0), 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(0x2::bcs::peel_vec_u8(&mut v0))), arg1);
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<SUIPUMP>>(v3);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<SUIPUMP>>(v2, 0x2::tx_context::sender(arg1));
    }

    // decompiled from Move bytecode v7
}

