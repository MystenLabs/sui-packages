module 0xc87d4122f40d4e71291af2839a19f3ea609381102ca6e51431d68cf94aa30a66::lopsui {
    struct LOPSUI has drop {
        dummy_field: bool,
    }

    fun init(arg0: LOPSUI, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<LOPSUI>(arg0, 9, b"LOPSUI", b"LOPSUI SUI", b"Your love sui...? ", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://file-walletapp.waveonsui.com/images/wave-pumps/a5bd0127-5c26-4797-8510-cf0f07bc4d82.webp")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<LOPSUI>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<LOPSUI>>(v1);
    }

    // decompiled from Move bytecode v6
}

