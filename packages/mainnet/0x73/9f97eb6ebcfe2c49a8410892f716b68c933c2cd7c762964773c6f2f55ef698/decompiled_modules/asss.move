module 0x739f97eb6ebcfe2c49a8410892f716b68c933c2cd7c762964773c6f2f55ef698::asss {
    struct ASSS has drop {
        dummy_field: bool,
    }

    fun init(arg0: ASSS, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<ASSS>(arg0, 9, b"ASSS", b"ASS", b"ASSSS", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://dev-file-walletapp.waveonsui.com/images/wave-pumps/bcf7da91-1b58-488f-a987-26d0ae583f64.webp")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<ASSS>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<ASSS>>(v1);
    }

    // decompiled from Move bytecode v6
}

