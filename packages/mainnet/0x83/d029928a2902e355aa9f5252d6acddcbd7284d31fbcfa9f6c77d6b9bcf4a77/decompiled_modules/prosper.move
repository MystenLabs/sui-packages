module 0x83d029928a2902e355aa9f5252d6acddcbd7284d31fbcfa9f6c77d6b9bcf4a77::prosper {
    struct PROSPER has drop {
        dummy_field: bool,
    }

    fun init(arg0: PROSPER, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<PROSPER>(arg0, 9, b"PROSPER", b"Bee", b"For the people ", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://file-walletapp.waveonsui.com/images/wave-pumps/a065116d-64e5-4f99-b0cd-198688bbbd7a.webp")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<PROSPER>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<PROSPER>>(v1);
    }

    // decompiled from Move bytecode v6
}

