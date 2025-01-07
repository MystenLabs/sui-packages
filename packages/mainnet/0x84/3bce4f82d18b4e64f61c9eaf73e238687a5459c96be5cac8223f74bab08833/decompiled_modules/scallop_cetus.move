module 0x843bce4f82d18b4e64f61c9eaf73e238687a5459c96be5cac8223f74bab08833::scallop_cetus {
    struct SCALLOP_CETUS has drop {
        dummy_field: bool,
    }

    fun init(arg0: SCALLOP_CETUS, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<SCALLOP_CETUS>(arg0, 9, b"sCETUS", b"sCETUS", b"Scallop interest-bearing token for CETUS", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"ipfs://bafkreibaercu3fplp3k4qd3rnvbuotndy3upykeajirfiba2ueu3tnc7ki")), arg1);
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<SCALLOP_CETUS>>(v1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<SCALLOP_CETUS>>(v0, 0x2::tx_context::sender(arg1));
    }

    // decompiled from Move bytecode v6
}

