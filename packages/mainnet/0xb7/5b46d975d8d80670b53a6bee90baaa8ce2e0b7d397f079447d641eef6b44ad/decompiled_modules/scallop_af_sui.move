module 0xb75b46d975d8d80670b53a6bee90baaa8ce2e0b7d397f079447d641eef6b44ad::scallop_af_sui {
    struct SCALLOP_AF_SUI has drop {
        dummy_field: bool,
    }

    fun init(arg0: SCALLOP_AF_SUI, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<SCALLOP_AF_SUI>(arg0, 9, b"sAfSUI", b"sAfSUI", b"Scallop interest-bearing token for afSUI", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"ipfs://bafkreibaercu3fplp3k4qd3rnvbuotndy3upykeajirfiba2ueu3tnc7ki")), arg1);
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<SCALLOP_AF_SUI>>(v1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<SCALLOP_AF_SUI>>(v0, 0x2::tx_context::sender(arg1));
    }

    // decompiled from Move bytecode v6
}

