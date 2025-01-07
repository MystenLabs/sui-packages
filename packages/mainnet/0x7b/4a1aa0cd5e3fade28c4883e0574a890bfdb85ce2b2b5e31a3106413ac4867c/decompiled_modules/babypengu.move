module 0x7b4a1aa0cd5e3fade28c4883e0574a890bfdb85ce2b2b5e31a3106413ac4867c::babypengu {
    struct BABYPENGU has drop {
        dummy_field: bool,
    }

    fun init(arg0: BABYPENGU, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<BABYPENGU>(arg0, 6, b"BABYPENGU", b"BABY PENGU", x"4241425950454e47553a20f09f90a7e29ca82054686520637574657374206d656d6520636f696e206f6e206963652e204a6f696e2074686520244241425950454e47552066616d696c7920616e642062652070617274206f6620612066756e2c2076696272616e742c20616e6420656e6572676574696320636f6d6d756e6974792120f09f9a80e29d84efb88f20596f7572207061746820696e746f2074686520776f726c64206f66206d656d657320616e642063727970746f63757272656e636965732073746172747320686572652e20f09f8c9f", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://r.turbos.finance/icon/1736082520893.35")), arg1);
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<BABYPENGU>>(v1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<BABYPENGU>>(v0, 0x2::tx_context::sender(arg1));
    }

    // decompiled from Move bytecode v6
}

