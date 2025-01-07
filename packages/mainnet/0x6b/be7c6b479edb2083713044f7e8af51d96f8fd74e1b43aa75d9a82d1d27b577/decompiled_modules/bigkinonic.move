module 0x6bbe7c6b479edb2083713044f7e8af51d96f8fd74e1b43aa75d9a82d1d27b577::bigkinonic {
    struct BIGKINONIC has drop {
        dummy_field: bool,
    }

    fun init(arg0: BIGKINONIC, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<BIGKINONIC>(arg0, 9, b"BIGKINONIC", b"Banbs", x"4920646f6ee2809974206861766520737569", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://file-walletapp.waveonsui.com/images/wave-pumps/88eddffc-651d-48c9-b158-1c49c0b680dc.webp")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<BIGKINONIC>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<BIGKINONIC>>(v1);
    }

    // decompiled from Move bytecode v6
}

