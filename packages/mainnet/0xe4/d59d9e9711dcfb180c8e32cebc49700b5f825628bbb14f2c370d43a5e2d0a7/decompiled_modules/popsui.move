module 0xe4d59d9e9711dcfb180c8e32cebc49700b5f825628bbb14f2c370d43a5e2d0a7::popsui {
    struct POPSUI has drop {
        dummy_field: bool,
    }

    fun init(arg0: POPSUI, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<POPSUI>(arg0, 6, b"POPSUI", b"PoPcaT", x"506f70737569206973206120706c617966756c206d656d6520636f696e2070726f6a656374206f6e207468652053756920626c6f636b636861696e2c2064657369676e656420746f206272696e6720612066726573682c20e2809c706f70e2809d206f662066756e20616e6420656e6572677920746f207468652063727970746f20636f6d6d756e6974792e20496e73706972656420627920706f702063756c7475726520616e642063617375616c20656e676167656d656e742c20506f7073756920697320616c6c2061626f7574206163636573736962696c6974792e", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://r.turbos.finance/icon/1730952057848.jpg")), arg1);
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<POPSUI>>(v1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<POPSUI>>(v0, 0x2::tx_context::sender(arg1));
    }

    // decompiled from Move bytecode v6
}

