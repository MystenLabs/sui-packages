module 0x9fe59b249786476866b87d66fb6ad430bcf12d30b19ef6505a2a3f9cc7d21b6b::meme {
    struct MEME has drop {
        dummy_field: bool,
    }

    fun init(arg0: MEME, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<MEME>(arg0, 18, b"MEME", b"MEME Exchange", b"", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe(0x1::ascii::string(b"https://ipfs.io/ipfs/QmXMbXkXpFqNArihgHaTYVM8ZPzvHa7EabZVA2dxGNR694/"))), arg1);
        let v2 = v0;
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<MEME>>(v1);
        0x2::coin::mint_and_transfer<MEME>(&mut v2, 100000000000, 0x2::tx_context::sender(arg1), arg1);
        0x2::transfer::public_freeze_object<0x2::coin::TreasuryCap<MEME>>(v2);
    }

    // decompiled from Move bytecode v6
}

