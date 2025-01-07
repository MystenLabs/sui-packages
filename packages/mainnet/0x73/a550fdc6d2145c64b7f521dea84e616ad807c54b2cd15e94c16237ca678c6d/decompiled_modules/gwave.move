module 0x73a550fdc6d2145c64b7f521dea84e616ad807c54b2cd15e94c16237ca678c6d::gwave {
    struct GWAVE has drop {
        dummy_field: bool,
    }

    fun init(arg0: GWAVE, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<GWAVE>(arg0, 9, b"GWAVE", b"Ghost Wave", b"Meme hailed from wave wallet ", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://file-walletapp.waveonsui.com/images/wave-pumps/0025bfbc-3e17-4055-b660-45f54cba17f6.webp")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<GWAVE>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<GWAVE>>(v1);
    }

    // decompiled from Move bytecode v6
}

