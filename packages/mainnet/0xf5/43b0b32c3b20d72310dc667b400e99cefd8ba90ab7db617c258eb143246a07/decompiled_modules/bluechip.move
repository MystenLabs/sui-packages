module 0xf543b0b32c3b20d72310dc667b400e99cefd8ba90ab7db617c258eb143246a07::bluechip {
    struct BLUECHIP has drop {
        dummy_field: bool,
    }

    fun init(arg0: BLUECHIP, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<BLUECHIP>(arg0, 6, b"BLUECHIP", b"POTATO BLUE CHIP", x"4120626c756520706f7461746f206d666572207374616e647320616c6f6e652061732074686520736f6c6520626c75652d63686970206d656d65636f696e206f6e2024535549200a0a436f6d65206765742061207069656365206f6620746869732024424c55454348495020", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/IMG_3633_5450a44c7f.jpeg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<BLUECHIP>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<BLUECHIP>>(v1);
    }

    // decompiled from Move bytecode v6
}

