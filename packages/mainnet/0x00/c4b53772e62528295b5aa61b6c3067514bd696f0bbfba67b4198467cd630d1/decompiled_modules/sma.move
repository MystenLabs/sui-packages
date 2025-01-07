module 0xc4b53772e62528295b5aa61b6c3067514bd696f0bbfba67b4198467cd630d1::sma {
    struct SMA has drop {
        dummy_field: bool,
    }

    fun init(arg0: SMA, arg1: &mut 0x2::tx_context::TxContext) {
        let v0 = 0x2::tx_context::sender(arg1);
        let (v1, v2) = 0x2::coin::create_currency<SMA>(arg0, 6, b"SMA", b"Smartest AI Ever by SuiAI", x"4c616469657320616e642067656e746c656d656e2c207361792068656c6c6f20746f2074686520636f696e2074686174e280997320736f20736d6172742c2069742070726f6261626c79206a757374207265616420796f7572206d696e642e204149204167656e74206973206865726520746f2070726f76652074686174206e6f7420616c6c2063727970746f2070726f6a656374732077657265206c61756e6368656420647572696e672061206361666665696e652d6675656c6564203320612e6d2e20627261696e73746f726d696e672073657373696f6e20286578636570742074686973206f6e6520746f74616c6c7920776173292e", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.suiai.fun/uploads/Smart_AI_4ae2aa801f.jpg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::CoinMetadata<SMA>>(v2, v0);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<SMA>>(v1, v0);
    }

    // decompiled from Move bytecode v6
}

