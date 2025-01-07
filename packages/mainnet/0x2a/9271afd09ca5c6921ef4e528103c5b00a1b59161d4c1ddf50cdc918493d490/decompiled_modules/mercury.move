module 0x2a9271afd09ca5c6921ef4e528103c5b00a1b59161d4c1ddf50cdc918493d490::mercury {
    struct MERCURY has drop {
        dummy_field: bool,
    }

    fun init(arg0: MERCURY, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<MERCURY>(arg0, 6, b"Mercury", b"Mercury coin", b"Welcome to Mercury, the world of Sui, the blue ocean.", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/333_a3cf4ab935.jpg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<MERCURY>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<MERCURY>>(v1);
    }

    // decompiled from Move bytecode v6
}

