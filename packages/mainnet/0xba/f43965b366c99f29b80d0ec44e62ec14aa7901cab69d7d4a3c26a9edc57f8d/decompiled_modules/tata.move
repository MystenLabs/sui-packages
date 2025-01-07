module 0xbaf43965b366c99f29b80d0ec44e62ec14aa7901cab69d7d4a3c26a9edc57f8d::tata {
    struct TATA has drop {
        dummy_field: bool,
    }

    fun init(arg0: TATA, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<TATA>(arg0, 9, b"TATA", b"Ratan tata", b"A tribute to Ratan Tata ji", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://file-walletapp.waveonsui.com/images/wave-pumps/9755f6af-7506-4648-b4a1-aa3fc75ab429.webp")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<TATA>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<TATA>>(v1);
    }

    // decompiled from Move bytecode v6
}

