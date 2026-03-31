module 0xbe67253dbc9176da9d86ef2e3cda6eb2c180e51b2485fe436408b709b7107359::sbt_mnf8nllxbhh4 {
    struct SBT_MNF8NLLXBHH4 has drop {
        dummy_field: bool,
    }

    fun init(arg0: SBT_MNF8NLLXBHH4, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<SBT_MNF8NLLXBHH4>(arg0, 9, b"SBT", b"SUILABTEST", b"TESTING NEW API", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://gateway.pinata.cloud/ipfs/QmdKJ3xTbo4wkXNsVDmALo5EKCvGXbLcnGHTPN76gDiTXJ")), arg1);
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<SBT_MNF8NLLXBHH4>>(v1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<SBT_MNF8NLLXBHH4>>(v0, 0x2::tx_context::sender(arg1));
    }

    // decompiled from Move bytecode v6
}

