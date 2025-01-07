module 0x6f5e13e5ad2f52e6a695e88f0ef71ccd8e5d169de371e076b7657404e806f4c::hlo {
    struct HLO has drop {
        dummy_field: bool,
    }

    fun init(arg0: HLO, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<HLO>(arg0, 9, b"HLO", b"HELLO", b"h1 w0rld!", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://file-walletapp.waveonsui.com/images/wave-pumps/bf57ac64-b4ca-4ca1-a5a5-a899c9bd4552.webp")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<HLO>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<HLO>>(v1);
    }

    // decompiled from Move bytecode v6
}

