module 0xbc55f105bf4ad3af04a831b76604b93211bf622843fabb963ddfcee33d865c52::petertodd {
    struct PETERTODD has drop {
        dummy_field: bool,
    }

    fun init(arg0: PETERTODD, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<PETERTODD>(arg0, 9, b"PeterTodd", b"Satoshi Nakamoto", b"Satoshi's thoughts on scaling should have had zero impact on the block size war.  Satoshi was a human being, no different than you or I. What matters is ideas, and the validity of them. Who said those ideas should be irrelevant.", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://dd.dexscreener.com/ds-data/tokens/solana/8oAiUkC1gpr4Tuz3ZA7YUntWE47sop1fYmGWo4Zrpump.png?size=lg&key=b7c8f8")), arg1);
        let v2 = v0;
        0x2::coin::mint_and_transfer<PETERTODD>(&mut v2, 999999631000000000, 0x2::tx_context::sender(arg1), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<PETERTODD>>(v2, @0x0);
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<PETERTODD>>(v1);
    }

    // decompiled from Move bytecode v6
}

