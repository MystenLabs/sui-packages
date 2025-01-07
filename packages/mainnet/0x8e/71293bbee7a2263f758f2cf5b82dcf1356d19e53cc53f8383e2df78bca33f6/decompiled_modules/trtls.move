module 0x8e71293bbee7a2263f758f2cf5b82dcf1356d19e53cc53f8383e2df78bca33f6::trtls {
    struct TRTLS has drop {
        dummy_field: bool,
    }

    fun init(arg0: TRTLS, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<TRTLS>(arg0, 6, b"TRTLS", b"TURTLES", b"Turtles will go to M O O N ! ", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/sui_turtles_acbd4d0152.jpeg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<TRTLS>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<TRTLS>>(v1);
    }

    // decompiled from Move bytecode v6
}

