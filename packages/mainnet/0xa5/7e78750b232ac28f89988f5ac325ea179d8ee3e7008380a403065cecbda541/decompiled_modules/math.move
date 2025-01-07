module 0xa57e78750b232ac28f89988f5ac325ea179d8ee3e7008380a403065cecbda541::math {
    struct MATH has drop {
        dummy_field: bool,
    }

    fun init(arg0: MATH, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<MATH>(arg0, 9, b"MATH", b"Mathematic", b"Math is an exact science and is always used in life.", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://file-walletapp.waveonsui.com/images/wave-pumps/2663083b-29b1-49de-8921-c85e159dbb78.webp")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<MATH>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<MATH>>(v1);
    }

    // decompiled from Move bytecode v6
}

