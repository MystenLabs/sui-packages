module 0xd0df9856e86581018943e6ad67f44105abc4109f42813e306591bdc265a1462d::anonymousui {
    struct ANONYMOUSUI has drop {
        dummy_field: bool,
    }

    fun init(arg0: ANONYMOUSUI, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<ANONYMOUSUI>(arg0, 6, b"AnonymouSui", b"Anonymous on Sui", x"416e6f6e796d6f757320616e642050726976617465204d656d6520436f696e206f6e205375690a457870657269656e63652074727565206469676974616c20707269766163792077697468206f757220616e6f6e796d6f7573206d656d6520636f696e206f6e205375692e20456e6a6f792073656375726520616e6420756e747261636561626c65207472616e73616374696f6e732c20656d706f776572696e6720796f7520746f2074616b6520636f6e74726f6c206f6620796f75722066696e616e6369616c2066726565646f6d2e", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/IMG_7439_2297a8a993.jpeg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<ANONYMOUSUI>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<ANONYMOUSUI>>(v1);
    }

    // decompiled from Move bytecode v6
}

