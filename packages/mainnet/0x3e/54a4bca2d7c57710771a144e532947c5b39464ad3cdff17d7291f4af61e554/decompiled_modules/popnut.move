module 0x3e54a4bca2d7c57710771a144e532947c5b39464ad3cdff17d7291f4af61e554::popnut {
    struct POPNUT has drop {
        dummy_field: bool,
    }

    fun init(arg0: POPNUT, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<POPNUT>(arg0, 6, b"POPNUT", b"First Pop Peanut On Sui", b"First Pop Peanut On Sui: poppnutsui.fun", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/POPPNUT_ezgif_com_gif_maker_b933b8f819.gif")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<POPNUT>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<POPNUT>>(v1);
    }

    // decompiled from Move bytecode v6
}

