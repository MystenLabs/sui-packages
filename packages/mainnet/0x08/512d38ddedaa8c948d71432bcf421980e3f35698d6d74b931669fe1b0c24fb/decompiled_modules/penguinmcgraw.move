module 0x8512d38ddedaa8c948d71432bcf421980e3f35698d6d74b931669fe1b0c24fb::penguinmcgraw {
    struct PENGUINMCGRAW has drop {
        dummy_field: bool,
    }

    fun init(arg0: PENGUINMCGRAW, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<PENGUINMCGRAW>(arg0, 6, b"PenguinMcGraw", b"Penguin McGraw", x"50656e6775696e204d6347726177202850454e4755494e290a636f6c646573742070656e6775696e20627265617468696e6720", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/345345_3d3dca421a.jpeg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<PENGUINMCGRAW>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<PENGUINMCGRAW>>(v1);
    }

    // decompiled from Move bytecode v6
}

