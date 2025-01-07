module 0x97023a317320c4498cc4cd239dd02fd30c28246e5e8f81325d63f2bd8d70f6b3::scallop_v_sui {
    struct SCALLOP_V_SUI has drop {
        dummy_field: bool,
    }

    fun init(arg0: SCALLOP_V_SUI, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<SCALLOP_V_SUI>(arg0, 9, b"sVSUI", b"sVSUI", b"Scallop interest-bearing token for vSUI", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"ipfs://bafkreibaercu3fplp3k4qd3rnvbuotndy3upykeajirfiba2ueu3tnc7ki")), arg1);
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<SCALLOP_V_SUI>>(v1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<SCALLOP_V_SUI>>(v0, 0x2::tx_context::sender(arg1));
    }

    // decompiled from Move bytecode v6
}

