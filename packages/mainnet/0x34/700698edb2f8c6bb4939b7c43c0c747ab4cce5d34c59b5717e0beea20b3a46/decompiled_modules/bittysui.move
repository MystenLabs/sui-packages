module 0x34700698edb2f8c6bb4939b7c43c0c747ab4cce5d34c59b5717e0beea20b3a46::bittysui {
    struct BITTYSUI has drop {
        dummy_field: bool,
    }

    fun init(arg0: BITTYSUI, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<BITTYSUI>(arg0, 6, b"BITTYSUI", b"BITTY ON SUI", b"BITTY The OG 2015 Bitcoin Mascot.", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://ipfs.io/ipfs/bafkreiambxnxr36epf3fvnselorlkhiuvcfzdfnl4nig42ncxkfqdxzdze")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<BITTYSUI>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_transfer<0x2::coin::CoinMetadata<BITTYSUI>>(v1, 0x2::tx_context::sender(arg1));
    }

    // decompiled from Move bytecode v6
}

