module 0xb1d7df34829d1513b73ba17cb7ad90c88d1e104bb65ab8f62f13e0cc103783d3::scallop_sb_usdt {
    struct SCALLOP_SB_USDT has drop {
        dummy_field: bool,
    }

    fun init(arg0: SCALLOP_SB_USDT, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<SCALLOP_SB_USDT>(arg0, 6, b"sSBUSDT", b"sSBUSDT", b"Scallop interest-bearing token for SUI bridge USDT", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://zu6izvoktna456r6pbxg3knacc4bysfalutz25xo6zfkx6x3wvda.arweave.net/zTyM1cqbQc76PnhubamgELgcSKBdJ5127vZKq_r7tUY")), arg1);
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<SCALLOP_SB_USDT>>(v1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<SCALLOP_SB_USDT>>(v0, 0x2::tx_context::sender(arg1));
    }

    // decompiled from Move bytecode v6
}

