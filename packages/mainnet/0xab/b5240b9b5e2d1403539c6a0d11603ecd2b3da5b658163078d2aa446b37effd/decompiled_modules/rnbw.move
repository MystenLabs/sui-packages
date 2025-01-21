module 0xabb5240b9b5e2d1403539c6a0d11603ecd2b3da5b658163078d2aa446b37effd::rnbw {
    struct RNBW has drop {
        dummy_field: bool,
    }

    fun init(arg0: RNBW, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<RNBW>(arg0, 6, b"RNBW", b"Rainbow AI", b"$RNBW is official token from Rainbow AI, Rainbow AI come to make the cheapest API on SUI, we moving the launch from Suai to turbos", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://r.turbos.finance/icon/1737472811823.png")), arg1);
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<RNBW>>(v1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<RNBW>>(v0, 0x2::tx_context::sender(arg1));
    }

    // decompiled from Move bytecode v6
}

