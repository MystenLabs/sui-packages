module 0xbd101e112c9c11e42b9960b5880a6b8fdb65d2c927730051302dc72cdb4b44a3::ntoys {
    struct NTOYS has drop {
        dummy_field: bool,
    }

    fun init(arg0: NTOYS, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<NTOYS>(arg0, 9, b"NTOYS", b"TOYS", b"SABOTAGE TOY", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://file-walletapp.waveonsui.com/images/wave-pumps/ef6b4981-e29e-428b-b3dd-8797bb089c17.webp")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<NTOYS>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<NTOYS>>(v1);
    }

    // decompiled from Move bytecode v6
}

