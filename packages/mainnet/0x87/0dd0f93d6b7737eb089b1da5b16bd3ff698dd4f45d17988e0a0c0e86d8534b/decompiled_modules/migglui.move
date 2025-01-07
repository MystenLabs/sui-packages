module 0x870dd0f93d6b7737eb089b1da5b16bd3ff698dd4f45d17988e0a0c0e86d8534b::migglui {
    struct MIGGLUI has drop {
        dummy_field: bool,
    }

    fun init(arg0: MIGGLUI, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<MIGGLUI>(arg0, 6, b"MIGGLUI", b"MIGGLES", x"496e74726f647563696e67204d6967676c65732121200a0a43727970746f73206661766f7572697465206d697363686965766f7573206b697474792068617320636c6177656420697473207761792066726f6d204261736520636861696e20746f2053756921200a0a4d6967676c65732069736e74206a757374206120636f696e2c20697473206120636861696e2d686f7070696e67206d656d6520636174206f6e2061206d697373696f6e20746f20737072656164206c617567687320616e642061206c6974746c65206368616f732e200a0a526561647920746f206a6f696e20746865206c69747465723f", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/miggles_sui_full_image_404ae98600.jpg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<MIGGLUI>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<MIGGLUI>>(v1);
    }

    // decompiled from Move bytecode v6
}

