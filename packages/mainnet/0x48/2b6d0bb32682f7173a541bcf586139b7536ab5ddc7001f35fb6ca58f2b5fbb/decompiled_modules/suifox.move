module 0x482b6d0bb32682f7173a541bcf586139b7536ab5ddc7001f35fb6ca58f2b5fbb::suifox {
    struct SUIFOX has drop {
        dummy_field: bool,
    }

    fun init(arg0: SUIFOX, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<SUIFOX>(arg0, 6, b"SUIFOX", b"Suifox", x"4d656d65636f696e20416e616c797469637320616e6420546f6b656e20536e6966666572206f6e205355490a0a576562736974653a2068747470733a2f2f737569666f782e636f6d0a0a547769747465723a2068747470733a2f2f782e636f6d2f537569666f784f6666696369616c0a0a54656c656772616d3a2068747470733a2f2f742e6d652f537569666f784f6666696369616c", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/logo_724515ae36.png")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<SUIFOX>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<SUIFOX>>(v1);
    }

    // decompiled from Move bytecode v6
}

