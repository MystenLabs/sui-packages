module 0xafd27b026eaaa662c70f648628bba49df81e26444ed736a397fbecc17a2345cd::nakamoto_ {
    struct NAKAMOTO_ has drop {
        dummy_field: bool,
    }

    fun init(arg0: NAKAMOTO_, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<NAKAMOTO_>(arg0, 9, b"NAKAMOTO_", b"Satoshi", b"It's just a secret coin", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://file-walletapp.waveonsui.com/images/wave-pumps/de289102-7380-40ba-b407-634167fbf407.webp")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<NAKAMOTO_>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<NAKAMOTO_>>(v1);
    }

    // decompiled from Move bytecode v6
}

