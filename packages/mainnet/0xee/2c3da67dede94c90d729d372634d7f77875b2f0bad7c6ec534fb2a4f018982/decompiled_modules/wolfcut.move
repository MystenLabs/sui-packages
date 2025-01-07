module 0xee2c3da67dede94c90d729d372634d7f77875b2f0bad7c6ec534fb2a4f018982::wolfcut {
    struct WOLFCUT has drop {
        dummy_field: bool,
    }

    fun init(arg0: WOLFCUT, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<WOLFCUT>(arg0, 9, b"WOLFCUT", b"Wolfcut", b"Wolfcut: An innovative token in the crypto world that combines advanced technology with a strong community. Join our journey to build a secure and profitable ecosystem. Be part of the digital revolution with Wolfcut!", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://file-walletapp.waveonsui.com/images/wave-pumps/533c9a4a-6e18-406a-bc9a-e963bfd8fbb8.webp")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<WOLFCUT>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<WOLFCUT>>(v1);
    }

    // decompiled from Move bytecode v6
}

