module 0xa090a6ee6142c63d316953593f7113d9ea0a07ae9dcf594b8d0016653ccd959::mrstoshi {
    struct MRSTOSHI has drop {
        dummy_field: bool,
    }

    fun init(arg0: MRSTOSHI, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<MRSTOSHI>(arg0, 6, b"MRSTOSHI", b"Mrs Toshi", x"4d656f77204d656f77204d656f77204d656f774279652d4279652c20544f78696320426f7973212054686520776f726c642069732061626f757420746f206265206f76657272756e2062792061646f7261626c652e2e2e0a", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/mrst_d0f67aeffb.png")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<MRSTOSHI>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<MRSTOSHI>>(v1);
    }

    // decompiled from Move bytecode v6
}

