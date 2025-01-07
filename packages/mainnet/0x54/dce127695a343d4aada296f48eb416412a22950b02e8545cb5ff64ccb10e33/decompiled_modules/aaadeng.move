module 0x54dce127695a343d4aada296f48eb416412a22950b02e8545cb5ff64ccb10e33::aaadeng {
    struct AAADENG has drop {
        dummy_field: bool,
    }

    fun init(arg0: AAADENG, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<AAADENG>(arg0, 6, b"AAADENG", b"aaaDeng", b"AAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAA", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/aaadeng_e014b696b4_2ba5ba4e09.webp")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<AAADENG>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<AAADENG>>(v1);
    }

    // decompiled from Move bytecode v6
}

