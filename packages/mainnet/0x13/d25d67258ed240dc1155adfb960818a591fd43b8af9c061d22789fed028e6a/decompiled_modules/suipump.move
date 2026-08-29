module 0x13d25d67258ed240dc1155adfb960818a591fd43b8af9c061d22789fed028e6a::suipump {
    struct SUIPUMP has drop {
        dummy_field: bool,
    }

    fun init(arg0: SUIPUMP, arg1: &mut 0x2::tx_context::TxContext) {
        let v0 = 0x2::bcs::new(x"044b494b49044b494b49ca01f09f90b12041626f7574204b494b490a0a4b494b49206973206120706c617966756c206c6974746c6520636174206f6e205375692c206275696c742061726f756e64206d656d65732c20636f6d6d756e6974792c20616e6420676f6f642076696265732e0a0af09f8eaf204d697373696f6e0a0a4275696c6420612066756e20636f6d6d756e6974792077686572652065766572796f6e652063616e2070617274696369706174652c206372656174652c206d656d652c20616e642067726f7720746f6765746865722e2068747470733a2f2f692e696d6775722e636f6d2f633262344b6e592e6a706567");
        let v1 = 0x2::bcs::into_remainder_bytes(v0);
        assert!(0x1::vector::is_empty<u8>(&v1), 0);
        let (v2, v3) = 0x2::coin::create_currency<SUIPUMP>(arg0, 6, 0x2::bcs::peel_vec_u8(&mut v0), 0x2::bcs::peel_vec_u8(&mut v0), 0x2::bcs::peel_vec_u8(&mut v0), 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(0x2::bcs::peel_vec_u8(&mut v0))), arg1);
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<SUIPUMP>>(v3);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<SUIPUMP>>(v2, 0x2::tx_context::sender(arg1));
    }

    // decompiled from Move bytecode v7
}

