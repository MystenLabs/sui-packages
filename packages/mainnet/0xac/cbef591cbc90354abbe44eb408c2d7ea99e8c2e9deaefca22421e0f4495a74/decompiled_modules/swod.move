module 0xaccbef591cbc90354abbe44eb408c2d7ea99e8c2e9deaefca22421e0f4495a74::swod {
    struct SWOD has drop {
        dummy_field: bool,
    }

    fun init(arg0: SWOD, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<SWOD>(arg0, 6, b"Swod", b"SuiWorldOrder", b"Stay hydrated, swim deeper", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/IMG_3229_7c20bfd6ed.png")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<SWOD>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<SWOD>>(v1);
    }

    // decompiled from Move bytecode v6
}

