module 0x43fcca7d4181782f034d4b908322fc41c71ddfaa0472b9f1a6f1679f4b18096c::sasha {
    struct SASHA has drop {
        dummy_field: bool,
    }

    fun init(arg0: SASHA, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<SASHA>(arg0, 9, b"SASHA", b"SashaR1746", b"Sasha Coin", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://file-walletapp.waveonsui.com/images/wave-pumps/fd15094a-d8c3-41b0-a60e-df0d45a9a8cb.webp")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<SASHA>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<SASHA>>(v1);
    }

    // decompiled from Move bytecode v6
}

