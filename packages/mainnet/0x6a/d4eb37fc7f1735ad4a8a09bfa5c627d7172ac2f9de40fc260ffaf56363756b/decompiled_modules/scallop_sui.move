module 0x6ad4eb37fc7f1735ad4a8a09bfa5c627d7172ac2f9de40fc260ffaf56363756b::scallop_sui {
    struct SCALLOP_SUI has drop {
        dummy_field: bool,
    }

    fun init(arg0: SCALLOP_SUI, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<SCALLOP_SUI>(arg0, 9, b"sSUI", b"sSUI", b"Scallop interest-bearing token for SUI", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"ipfs://bafkreibaercu3fplp3k4qd3rnvbuotndy3upykeajirfiba2ueu3tnc7ki")), arg1);
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<SCALLOP_SUI>>(v1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<SCALLOP_SUI>>(v0, 0x2::tx_context::sender(arg1));
    }

    // decompiled from Move bytecode v6
}

