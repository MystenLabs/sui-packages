module 0xee86821d2387249accc826d671da8a93c49a09c4b3ca6c330b418e7f75944937::chpepe {
    struct CHPEPE has drop {
        dummy_field: bool,
    }

    fun init(arg0: CHPEPE, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<CHPEPE>(arg0, 6, b"CHPEPE", b"Charizard pepe", x"536b6962696469206f68696f2072697a7a6c6572200a4759415420475941542047594154", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/tumblr_nqoicva_H_Mg1uoefh9o1_250_a2fa47869b.jpg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<CHPEPE>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<CHPEPE>>(v1);
    }

    // decompiled from Move bytecode v6
}

