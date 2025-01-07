module 0x6c0dc18b4dd077b8d4e7f1e87a63c25777fe9a90fb02f0b16d8a1205b27753e6::gbgh {
    struct GBGH has drop {
        dummy_field: bool,
    }

    fun init(arg0: GBGH, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<GBGH>(arg0, 6, b"GBGH", b"Test", b"uyiyuityuitu", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/G_Xp_EI_CWAAA_5z_Xe_35e16700d4.jfif")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<GBGH>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<GBGH>>(v1);
    }

    // decompiled from Move bytecode v6
}

