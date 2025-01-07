module 0x8398caa20163d9ffcaf2ba4be01e5cf5648d2f1717c7d14b94413f40a7eb5143::magatrmp {
    struct MAGATRMP has drop {
        dummy_field: bool,
    }

    fun init(arg0: MAGATRMP, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<MAGATRMP>(arg0, 9, b"MAGATRMP", b"MAGATRUMP", b"Trump 2024 baby!!!!", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://file-walletapp.waveonsui.com/images/wave-pumps/97a1bcee-aa57-4cee-b781-fbeadf437ab6.webp")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<MAGATRMP>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<MAGATRMP>>(v1);
    }

    // decompiled from Move bytecode v6
}

