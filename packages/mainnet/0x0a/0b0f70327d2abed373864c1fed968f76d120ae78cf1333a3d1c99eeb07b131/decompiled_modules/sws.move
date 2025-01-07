module 0xa0b0f70327d2abed373864c1fed968f76d120ae78cf1333a3d1c99eeb07b131::sws {
    struct SWS has drop {
        dummy_field: bool,
    }

    fun init(arg0: SWS, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<SWS>(arg0, 9, b"SWS", b"suiwifsuiman", b"sui wif suiman", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"")), arg1);
        let v2 = v0;
        0x2::coin::mint_and_transfer<SWS>(&mut v2, 10000000000000000000, 0x2::tx_context::sender(arg1), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<SWS>>(v2, @0x0);
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<SWS>>(v1);
    }

    // decompiled from Move bytecode v6
}

