module 0x1a1c48bf0b5456a7691928c8b3f2eda2bbd9a38f1e6f7e6cf1b22d7750379184::ldy {
    struct LDY has drop {
        dummy_field: bool,
    }

    fun init(arg0: LDY, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<LDY>(arg0, 9, b"LDY", b"LADY ORANG", b"LADYS BUTIY", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://file-walletapp.waveonsui.com/images/wave-pumps/7240d06c-e44c-463e-bb97-ae8dbc1cb783.webp")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<LDY>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<LDY>>(v1);
    }

    // decompiled from Move bytecode v6
}

