module 0x21aa66ee1a0cb553ddb3f6e39cd3bd6e779a116d05c9aa956426cd4b312c71fd::sabuo {
    struct SABUO has drop {
        dummy_field: bool,
    }

    fun init(arg0: SABUO, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<SABUO>(arg0, 9, b"SABUO", b"Sabuo meme", b"Memecoin to commemorate the SABUO brand ", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://file-walletapp.waveonsui.com/images/wave-pumps/8237b8a8-f4cc-4646-a1c8-f87ae0f84d5c.webp")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<SABUO>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<SABUO>>(v1);
    }

    // decompiled from Move bytecode v6
}

