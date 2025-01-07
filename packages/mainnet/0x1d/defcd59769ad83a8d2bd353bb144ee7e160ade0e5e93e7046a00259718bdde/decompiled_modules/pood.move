module 0x1ddefcd59769ad83a8d2bd353bb144ee7e160ade0e5e93e7046a00259718bdde::pood {
    struct POOD has drop {
        dummy_field: bool,
    }

    fun init(arg0: POOD, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<POOD>(arg0, 6, b"Pood", b"Poodle", x"0a506f6f646c65206d656d65206c6f76657273", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://r.turbos.finance/icon/1734536157383.png")), arg1);
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<POOD>>(v1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<POOD>>(v0, 0x2::tx_context::sender(arg1));
    }

    // decompiled from Move bytecode v6
}

