module 0xb14f82d8506d139eacef109688d1b71e7236bcce9b2c0ad526abcd6aa5be7de0::scallop_sb_eth {
    struct SCALLOP_SB_ETH has drop {
        dummy_field: bool,
    }

    fun init(arg0: SCALLOP_SB_ETH, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<SCALLOP_SB_ETH>(arg0, 8, b"sSBETH", b"sSBETH", b"Scallop interest-bearing token for SUI bridge ETH", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://jhng3zbssnnpgkupluczr6x7gholyzj4icqb4rlf5zhrehexok7q.arweave.net/Sdpt5DKTWvMqj10FmPr_Mdy8ZTxAoB5FZe5PEhyXcr8")), arg1);
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<SCALLOP_SB_ETH>>(v1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<SCALLOP_SB_ETH>>(v0, 0x2::tx_context::sender(arg1));
    }

    // decompiled from Move bytecode v6
}

