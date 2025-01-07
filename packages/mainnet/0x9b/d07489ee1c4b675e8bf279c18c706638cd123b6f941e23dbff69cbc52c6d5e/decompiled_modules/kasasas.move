module 0x9bd07489ee1c4b675e8bf279c18c706638cd123b6f941e23dbff69cbc52c6d5e::kasasas {
    struct KASASAS has drop {
        dummy_field: bool,
    }

    fun init(arg0: KASASAS, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<KASASAS>(arg0, 9, b"KASASAS", b"hjhjh", b"fdfdf", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://file-walletapp.waveonsui.com/images/wave-pumps/333267c3-3921-4f93-8a46-ddfb91bdd6e2.webp")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<KASASAS>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<KASASAS>>(v1);
    }

    // decompiled from Move bytecode v6
}

