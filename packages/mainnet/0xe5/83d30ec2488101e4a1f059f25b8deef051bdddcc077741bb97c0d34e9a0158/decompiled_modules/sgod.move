module 0xe583d30ec2488101e4a1f059f25b8deef051bdddcc077741bb97c0d34e9a0158::sgod {
    struct SGOD has drop {
        dummy_field: bool,
    }

    fun init(arg0: SGOD, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<SGOD>(arg0, 6, b"SGOD", b"sgod", x"53474f44200a526573657276656420646f67206f6e207375690a0a41726520796f7520726561647920746f20666c6970207468696e67732075707369646520646f776e3f", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/Whats_App_Image_2024_10_16_at_10_05_42_94ce09e3eb.jpeg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<SGOD>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<SGOD>>(v1);
    }

    // decompiled from Move bytecode v6
}

