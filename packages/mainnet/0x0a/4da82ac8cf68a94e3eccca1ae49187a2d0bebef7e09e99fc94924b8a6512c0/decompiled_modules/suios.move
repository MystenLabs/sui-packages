module 0xa4da82ac8cf68a94e3eccca1ae49187a2d0bebef7e09e99fc94924b8a6512c0::suios {
    struct SUIOS has drop {
        dummy_field: bool,
    }

    fun init(arg0: SUIOS, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<SUIOS>(arg0, 6, b"Suios", b"$SUIOS", b"Suios is a token that combines Sui and iPhones. As Sui is now becoming a powerful wave spreading in all directions, it will certainly dominate everything in the world of technology", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/logo_token_ca2c67c2f2.gif")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<SUIOS>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<SUIOS>>(v1);
    }

    // decompiled from Move bytecode v6
}

