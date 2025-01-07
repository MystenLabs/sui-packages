module 0x44c6d67494dc05636e6fcffb6d4c570a3f06b6810e23d4d4e166421c56e465d2::pos {
    struct POS has drop {
        dummy_field: bool,
    }

    fun init(arg0: POS, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<POS>(arg0, 6, b"POS", b"PLAY ON SUI", b"KEEP PLAY ON SUI", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://r.turbos.finance/icon/1731613098012.jpg")), arg1);
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<POS>>(v1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<POS>>(v0, 0x2::tx_context::sender(arg1));
    }

    // decompiled from Move bytecode v6
}

