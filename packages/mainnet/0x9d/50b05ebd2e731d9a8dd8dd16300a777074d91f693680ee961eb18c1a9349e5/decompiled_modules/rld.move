module 0x9d50b05ebd2e731d9a8dd8dd16300a777074d91f693680ee961eb18c1a9349e5::rld {
    struct RLD has drop {
        dummy_field: bool,
    }

    fun init(arg0: RLD, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<RLD>(arg0, 9, b"RLD", b"Trident ", b"Di is a good player but w", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://file-walletapp.waveonsui.com/images/wave-pumps/f526729d-25f3-428f-8f37-b1995bae260c.webp")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<RLD>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<RLD>>(v1);
    }

    // decompiled from Move bytecode v6
}

