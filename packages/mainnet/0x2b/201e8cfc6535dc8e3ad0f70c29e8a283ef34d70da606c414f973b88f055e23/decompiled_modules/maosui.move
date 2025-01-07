module 0x2b201e8cfc6535dc8e3ad0f70c29e8a283ef34d70da606c414f973b88f055e23::maosui {
    struct MAOSUI has drop {
        dummy_field: bool,
    }

    fun init(arg0: MAOSUI, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<MAOSUI>(arg0, 6, b"MAOSUI", b"MAOSUI THE CAT", b"Join the community: https://t.me/MaoCatSui_Portal - https://x.com/MaoCat_Sui - https://www.maosui.pro/", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/logo_2_6_9c4ef8c48f.png")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<MAOSUI>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<MAOSUI>>(v1);
    }

    // decompiled from Move bytecode v6
}

