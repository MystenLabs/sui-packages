module 0xce499205154fc3c4eeea34318f13cef9b24eea00b24d091eafc138201c198338::memecats {
    struct MEMECATS has drop {
        dummy_field: bool,
    }

    fun init(arg0: MEMECATS, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<MEMECATS>(arg0, 9, b"MEMECATS", b"Cats", b"Like cats in home", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://file-walletapp.waveonsui.com/images/wave-pumps/38b84df4-8cbe-49cc-bfd9-aa3761fa2f77.webp")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<MEMECATS>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<MEMECATS>>(v1);
    }

    // decompiled from Move bytecode v6
}

