module 0x81979e59649b57673d54fb0cef641b7f6a195c04c8a6d0dedd85dc87db1eeecb::bluechip {
    struct BLUECHIP has drop {
        dummy_field: bool,
    }

    fun init(arg0: BLUECHIP, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<BLUECHIP>(arg0, 6, b"BLUECHIP", b"POTATO BLUE CHIP", x"4120626c756520706f7461746f206d666572207374616e647320616c6f6e652061732074686520736f6c6520626c75652d63686970206d656d65636f696e206f6e2024535549200a0a436f6d65206765742061207069656365206f6620746869732024424c55454348495020", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/IMG_3633_bc6f591ede.jpeg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<BLUECHIP>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<BLUECHIP>>(v1);
    }

    // decompiled from Move bytecode v6
}

