module 0xc61df5c90f836d8bbb692ab4c14adc2627ff2a7236810c7c9b07ac1a34c965a5::jay {
    struct JAY has drop {
        dummy_field: bool,
    }

    fun init(arg0: JAY, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<JAY>(arg0, 9, b"JAY", b"JayCoin", b"A test coin", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"")), arg1);
        let v2 = v0;
        0x2::coin::mint_and_transfer<JAY>(&mut v2, 1000000000000000000, 0x2::tx_context::sender(arg1), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<JAY>>(v2, @0x0);
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<JAY>>(v1);
    }

    // decompiled from Move bytecode v6
}

