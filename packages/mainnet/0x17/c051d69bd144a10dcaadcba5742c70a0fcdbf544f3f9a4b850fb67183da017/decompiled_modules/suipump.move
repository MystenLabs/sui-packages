module 0x17c051d69bd144a10dcaadcba5742c70a0fcdbf544f3f9a4b850fb67183da017::suipump {
    struct SUIPUMP has drop {
        dummy_field: bool,
    }

    fun init(arg0: SUIPUMP, arg1: &mut 0x2::tx_context::TxContext) {
        let v0 = 0x2::bcs::new(x"065245424f4f54065245424f4f54a301e2809c776520617265207265626f6f74696e6720746865207472656e63686573206f6e205375692c207374617274696e67207769746820736f6d65206d756368206e656564656420636c65616e75702ee2809d207e204164656e6979697c7c7b2274776974746572223a2268747470733a2f2f782e636f6d2f656d616e6162696f2f7374617475732f323039383531353037373139363539353335353f733d3436227d1f68747470733a2f2f692e696d6775722e636f6d2f303953396c69332e706e67");
        let v1 = 0x2::bcs::into_remainder_bytes(v0);
        assert!(0x1::vector::is_empty<u8>(&v1), 0);
        let (v2, v3) = 0x2::coin::create_currency<SUIPUMP>(arg0, 6, 0x2::bcs::peel_vec_u8(&mut v0), 0x2::bcs::peel_vec_u8(&mut v0), 0x2::bcs::peel_vec_u8(&mut v0), 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(0x2::bcs::peel_vec_u8(&mut v0))), arg1);
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<SUIPUMP>>(v3);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<SUIPUMP>>(v2, 0x2::tx_context::sender(arg1));
    }

    // decompiled from Move bytecode v7
}

