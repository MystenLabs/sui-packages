module 0x4f4a82e1162648746f1688625dabeef282b726865d1743d950ae72b2c19b54f3::muudeng {
    struct MUUDENG has drop {
        dummy_field: bool,
    }

    fun init(arg0: MUUDENG, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<MUUDENG>(arg0, 6, b"MUUDENG", b"MUUDENG SUI", b"joost a virul wittl hippo!", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/modeeng_8f18625c40.jpg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<MUUDENG>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<MUUDENG>>(v1);
    }

    // decompiled from Move bytecode v6
}

