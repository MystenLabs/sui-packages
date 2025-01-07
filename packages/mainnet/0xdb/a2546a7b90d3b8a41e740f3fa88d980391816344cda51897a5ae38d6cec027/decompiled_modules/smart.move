module 0xdba2546a7b90d3b8a41e740f3fa88d980391816344cda51897a5ae38d6cec027::smart {
    struct SMART has drop {
        dummy_field: bool,
    }

    fun init(arg0: SMART, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<SMART>(arg0, 9, b"SMART", b"Smart guy", b"Thinking black guy", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://file-walletapp.waveonsui.com/images/wave-pumps/6c5ffcc2-f747-4c35-af33-2f2e9cd71230.webp")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<SMART>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<SMART>>(v1);
    }

    // decompiled from Move bytecode v6
}

