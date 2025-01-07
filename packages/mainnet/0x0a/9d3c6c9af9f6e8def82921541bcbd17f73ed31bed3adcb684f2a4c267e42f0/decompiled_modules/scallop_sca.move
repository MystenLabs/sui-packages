module 0xa9d3c6c9af9f6e8def82921541bcbd17f73ed31bed3adcb684f2a4c267e42f0::scallop_sca {
    struct SCALLOP_SCA has drop {
        dummy_field: bool,
    }

    fun init(arg0: SCALLOP_SCA, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<SCALLOP_SCA>(arg0, 9, b"sSCA", b"sSCA", b"Scallop interest-bearing token for SCA", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"ipfs://bafkreibaercu3fplp3k4qd3rnvbuotndy3upykeajirfiba2ueu3tnc7ki")), arg1);
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<SCALLOP_SCA>>(v1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<SCALLOP_SCA>>(v0, 0x2::tx_context::sender(arg1));
    }

    // decompiled from Move bytecode v6
}

