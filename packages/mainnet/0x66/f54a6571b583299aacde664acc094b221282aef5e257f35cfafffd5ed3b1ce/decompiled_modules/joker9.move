module 0x66f54a6571b583299aacde664acc094b221282aef5e257f35cfafffd5ed3b1ce::joker9 {
    struct JOKER9 has drop {
        dummy_field: bool,
    }

    fun init(arg0: JOKER9, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<JOKER9>(arg0, 9, b"JOKER9", b"A joke", b"How much are you willing to pay to laugh HA Ha Ha Ha Ha Ha Ha Ha Ha", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://file-walletapp.waveonsui.com/images/wave-pumps/e5abbe1d-7f15-4555-8260-51181bd01215.webp")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<JOKER9>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<JOKER9>>(v1);
    }

    // decompiled from Move bytecode v6
}

