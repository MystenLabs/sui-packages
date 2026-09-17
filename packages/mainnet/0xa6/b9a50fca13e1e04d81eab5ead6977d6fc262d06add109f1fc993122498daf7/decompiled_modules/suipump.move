module 0xa6b9a50fca13e1e04d81eab5ead6977d6fc262d06add109f1fc993122498daf7::suipump {
    struct SUIPUMP has drop {
        dummy_field: bool,
    }

    fun init(arg0: SUIPUMP, arg1: &mut 0x2::tx_context::TxContext) {
        let v0 = 0x2::bcs::new(x"07434153484341540843617368204361748301526f62696e686f6f64206f726967696e616c20636861696e206e616d652077617320436173682043617420746f205355492e7c7c7b2274776974746572223a2268747470733a2f2f782e636f6d2f636173686361745f746f6b656e222c2277656273697465223a2268747470733a2f2f63617368636174746f6b656e2e78797a2f227d5868747470733a2f2f6173736574732e636f696e6765636b6f2e636f6d2f636f696e732f696d616765732f3130323137343238302f7374616e646172642f636173686361742d6c6f676f2e6a70673f31373832393232373635");
        let v1 = 0x2::bcs::into_remainder_bytes(v0);
        assert!(0x1::vector::is_empty<u8>(&v1), 0);
        let (v2, v3) = 0x2::coin::create_currency<SUIPUMP>(arg0, 6, 0x2::bcs::peel_vec_u8(&mut v0), 0x2::bcs::peel_vec_u8(&mut v0), 0x2::bcs::peel_vec_u8(&mut v0), 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(0x2::bcs::peel_vec_u8(&mut v0))), arg1);
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<SUIPUMP>>(v3);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<SUIPUMP>>(v2, 0x2::tx_context::sender(arg1));
    }

    // decompiled from Move bytecode v7
}

