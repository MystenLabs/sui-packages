module 0x96a93cda29f3565566767adfee44f42af7a26385c29322acd6b2ca5cffb2136f::eggpixels {
    struct EGGPIXELS has drop {
        dummy_field: bool,
    }

    fun init(arg0: EGGPIXELS, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<EGGPIXELS>(arg0, 6, b"EggPixels", b"SuiEggPixel", x"7375692065676720706978656c2061206d656d6520746f6b656e206f6e2074686520737569206e6574776f726b200a65676720656767206567672065676720", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/logo_sui_egg_3112bf983c.png")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<EGGPIXELS>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<EGGPIXELS>>(v1);
    }

    // decompiled from Move bytecode v6
}

