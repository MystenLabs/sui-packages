module 0x7ae957eda5b65cd1f7b6b7e3cb082a067a165cd3a2f6b0893ab0e56fe4026e4f::super {
    struct SUPER has drop {
        dummy_field: bool,
    }

    fun init(arg0: SUPER, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<SUPER>(arg0, 6, b"SUPER", b"Super Suiyajin", b"Super Suiyajin on sui", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/dragon_ball_dragon_ball_super_son_goku_super_saiyan_blue_wallpaper_preview_7bf00a2a38.jpg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<SUPER>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<SUPER>>(v1);
    }

    // decompiled from Move bytecode v6
}

