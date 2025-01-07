module 0x71305e58b861320e44e26d54c4ffe2bafa380275fcec520f86c3b2ffd8d33fca::suijoker {
    struct SUIJOKER has drop {
        dummy_field: bool,
    }

    fun init(arg0: SUIJOKER, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<SUIJOKER>(arg0, 6, b"SUIJOKER", b"Joke  in  the  sui", x"496d2061206a6f6b65722c20686f772061626f757420796f753f0a4a6f6b6572732074616b652063617265206f66204a6f6b65727320", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/a_a_ae_a_2024_10_01_004939_f1fedfdba3.png")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<SUIJOKER>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<SUIJOKER>>(v1);
    }

    // decompiled from Move bytecode v6
}

