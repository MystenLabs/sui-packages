module 0xdbca4db39817306a5fcc67aef9714b5f1ee77d38fc5f4411a75fc5d979aae9dc::scallop_ha_sui {
    struct SCALLOP_HA_SUI has drop {
        dummy_field: bool,
    }

    fun init(arg0: SCALLOP_HA_SUI, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<SCALLOP_HA_SUI>(arg0, 9, b"sHaSUI", b"sHaSUI", b"Scallop interest-bearing token for haSUI", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"ipfs://bafkreibaercu3fplp3k4qd3rnvbuotndy3upykeajirfiba2ueu3tnc7ki")), arg1);
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<SCALLOP_HA_SUI>>(v1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<SCALLOP_HA_SUI>>(v0, 0x2::tx_context::sender(arg1));
    }

    // decompiled from Move bytecode v6
}

