module 0xabc6a86f08136f7600f1b61585c7302c915c13992f233c2b37a92654cf71f24c::alban {
    struct ALBAN has drop {
        dummy_field: bool,
    }

    fun init(arg0: ALBAN, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<ALBAN>(arg0, 9, b"ALBAN", b"Alban", b"Alb", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://file-walletapp.waveonsui.com/images/wave-pumps/276f8e6d-19b2-435d-85e2-ac2363984874.webp")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<ALBAN>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<ALBAN>>(v1);
    }

    // decompiled from Move bytecode v6
}

