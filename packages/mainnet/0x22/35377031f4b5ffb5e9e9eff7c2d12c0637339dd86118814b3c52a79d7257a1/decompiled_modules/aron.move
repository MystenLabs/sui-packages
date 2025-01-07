module 0x2235377031f4b5ffb5e9e9eff7c2d12c0637339dd86118814b3c52a79d7257a1::aron {
    struct ARON has drop {
        dummy_field: bool,
    }

    fun init(arg0: ARON, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<ARON>(arg0, 6, b"ARON", x"41726f6ee2809973205661756c74", x"41726f6ee2809973205661756c742069732061206d656d65636f696e20696e73706972656420627920746865206a6f75726e6579206f662041726f6e20616e6420546f726f204d6178696d75732e20497420726570726573656e74732074686520717565737420666f722066696e616e6369616c2066726565646f6d20616e642074686520756e697479206f66207468652063727970746f20636f6d6d756e6974792e", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://r.turbos.finance/icon/1735154048365.png")), arg1);
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<ARON>>(v1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<ARON>>(v0, 0x2::tx_context::sender(arg1));
    }

    // decompiled from Move bytecode v6
}

