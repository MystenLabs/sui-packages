module 0xf02f926c4c7e0561c81e0dd9b9f6443f113dedb1a049b78999623f7fb1b34750::scallop_sui {
    struct SCALLOP_SUI has drop {
        dummy_field: bool,
    }

    fun init(arg0: SCALLOP_SUI, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<SCALLOP_SUI>(arg0, 9, b"sSUI", b"sSUI", b"Scallop interest-bearing token for SUI", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://wrvc6tdhutnq3wleuhgfiulwp32usm75fpnlucsk5uen3ewlocdq.arweave.net/tGovTGek2w3ZZKHMVFF2fvVJM_0r2roKSu0I3ZLLcIc")), arg1);
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<SCALLOP_SUI>>(v1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<SCALLOP_SUI>>(v0, 0x2::tx_context::sender(arg1));
    }

    // decompiled from Move bytecode v6
}

