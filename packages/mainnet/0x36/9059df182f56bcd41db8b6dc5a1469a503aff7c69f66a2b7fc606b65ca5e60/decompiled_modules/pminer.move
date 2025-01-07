module 0x369059df182f56bcd41db8b6dc5a1469a503aff7c69f66a2b7fc606b65ca5e60::pminer {
    struct PMINER has drop {
        dummy_field: bool,
    }

    fun init(arg0: PMINER, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<PMINER>(arg0, 6, b"PMINER", b"MinerPEPE on Sui", b"$PMINER digging deep for laughs and lambo dreams! This Pepes mining mojo on Suistack coins, strike memes, and let the FOMO flow! ", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/miner_3df736a06c.jpg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<PMINER>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<PMINER>>(v1);
    }

    // decompiled from Move bytecode v6
}

