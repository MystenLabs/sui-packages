module 0x6711551c1e7652a270d9fbf0eee25d99594c157cde3cb5fbb49035eb59b1b001::scallop_fdusd {
    struct SCALLOP_FDUSD has drop {
        dummy_field: bool,
    }

    fun init(arg0: SCALLOP_FDUSD, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<SCALLOP_FDUSD>(arg0, 6, b"sFDUSD", b"sFDUSD", b"Scallop interest-bearing token for FDUSD", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://am6vo2vn4mg2lm7vmajonsipgkat56z75mxe55babpztrbssmb4a.arweave.net/Az1Xaq3jDaWz9WAS5skPMoE--z_rLk70IAvzOIZSYHg")), arg1);
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<SCALLOP_FDUSD>>(v1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<SCALLOP_FDUSD>>(v0, 0x2::tx_context::sender(arg1));
    }

    // decompiled from Move bytecode v6
}

