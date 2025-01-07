module 0xaa7e9f16939bc037d58a5bb3c589263f6697a14bf0aef1e049df767c1fd84544::hopdelay {
    struct HOPDELAY has drop {
        dummy_field: bool,
    }

    fun init(arg0: HOPDELAY, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<HOPDELAY>(arg0, 6, b"Hopdelay", b"Hop Dot Delay", b"Hop is king", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://r.turbos.finance/icon/1730979935274.jpg")), arg1);
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<HOPDELAY>>(v1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<HOPDELAY>>(v0, 0x2::tx_context::sender(arg1));
    }

    // decompiled from Move bytecode v6
}

