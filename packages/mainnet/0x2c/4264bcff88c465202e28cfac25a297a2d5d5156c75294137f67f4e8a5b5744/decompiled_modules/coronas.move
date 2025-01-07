module 0x2c4264bcff88c465202e28cfac25a297a2d5d5156c75294137f67f4e8a5b5744::coronas {
    struct CORONAS has drop {
        dummy_field: bool,
    }

    fun init(arg0: CORONAS, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<CORONAS>(arg0, 9, b"CORONAS", b"WAWE", b"Sui inspires to go further, develop, catch the waves.", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://file-walletapp.waveonsui.com/images/wave-pumps/fcf69ebd-9691-4e3c-99bb-4e8d9362c171.webp")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<CORONAS>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<CORONAS>>(v1);
    }

    // decompiled from Move bytecode v6
}

