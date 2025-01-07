module 0xaa623b2661cc6faffd7212855237c6798e74ab14a61fee17aef3a14360bfd695::kendn {
    struct KENDN has drop {
        dummy_field: bool,
    }

    fun init(arg0: KENDN, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<KENDN>(arg0, 9, b"KENDN", b"jejdb", b"bebe", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://file-walletapp.waveonsui.com/images/wave-pumps/cace2625-30ae-4649-83c0-5da536b71add.webp")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<KENDN>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<KENDN>>(v1);
    }

    // decompiled from Move bytecode v6
}

