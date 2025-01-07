module 0xca7c539f9a71aa6c7bb11867df34ad9717a2cb8ab3f3dbe1bbe02f33e725ad55::bubble {
    struct BUBBLE has drop {
        dummy_field: bool,
    }

    fun init(arg0: BUBBLE, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<BUBBLE>(arg0, 6, b"BUBBLE", b"BUBBLEMONSTERS", x"57656c636f6d6520746f20627562626c65206d6f6e73746572730a576520617265206275696c64696e6720757020612066756e20636f6d6d756e6974792077697468206f7267616e69632067726f777468210a596f752063616e206578706563743a0a427562626c65206d6f6e7374657273204e4654730a412066756e20636f6d6d756e6974792074686174206368696c6c20616e64207368696c6c0a42696720706c616e7320616e64206d61726b6574696e67207374726174656769657320666f7220616674657220626f6e64696e67", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://r.turbos.finance/icon/1731026995586.webp")), arg1);
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<BUBBLE>>(v1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<BUBBLE>>(v0, 0x2::tx_context::sender(arg1));
    }

    // decompiled from Move bytecode v6
}

