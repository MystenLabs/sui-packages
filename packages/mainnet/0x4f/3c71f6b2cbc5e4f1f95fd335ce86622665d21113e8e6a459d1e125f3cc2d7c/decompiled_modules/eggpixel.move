module 0x4f3c71f6b2cbc5e4f1f95fd335ce86622665d21113e8e6a459d1e125f3cc2d7c::eggpixel {
    struct EGGPIXEL has drop {
        dummy_field: bool,
    }

    fun init(arg0: EGGPIXEL, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<EGGPIXEL>(arg0, 6, b"EggPixel", b"SuiEggPixel", x"7375692065676720706978656c2061206d656d6520746f6b656e206f6e2074686520737569206e6574776f726b20636f6d696e672020686f7066756e0a656767206567672065676720656767", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/logo_sui_egg_bbc5ef7a5a.png")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<EGGPIXEL>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<EGGPIXEL>>(v1);
    }

    // decompiled from Move bytecode v6
}

