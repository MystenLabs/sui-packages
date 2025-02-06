module 0x8c0fe357d3a138f4552bee393ce3a28a45bebcca43373d6a90bc44ab76f82e2::scallop_sb_wbtc {
    struct SCALLOP_SB_WBTC has drop {
        dummy_field: bool,
    }

    fun init(arg0: SCALLOP_SB_WBTC, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<SCALLOP_SB_WBTC>(arg0, 8, b"sSBWBTC", b"sSBWBTC", b"Scallop interest-bearing token for sbWBTC", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://ferq2danvxy5xrhvml37sv3nlwaraso6iwfjtdops7rscscy7zba.arweave.net/KSMNDA2t8dvE9WL3-VdtXYEQSd5FipmNz5fjIUhY_kI")), arg1);
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<SCALLOP_SB_WBTC>>(v1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<SCALLOP_SB_WBTC>>(v0, 0x2::tx_context::sender(arg1));
    }

    // decompiled from Move bytecode v6
}

