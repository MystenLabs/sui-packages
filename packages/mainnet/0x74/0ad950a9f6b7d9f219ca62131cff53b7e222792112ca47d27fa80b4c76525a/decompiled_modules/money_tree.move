module 0x740ad950a9f6b7d9f219ca62131cff53b7e222792112ca47d27fa80b4c76525a::money_tree {
    struct MONEY_TREE has drop {
        dummy_field: bool,
    }

    fun init(arg0: MONEY_TREE, arg1: &mut 0x2::tx_context::TxContext) {
        assert!(0x2::tx_context::epoch(arg1) == 630 || 0x2::tx_context::epoch(arg1) == 631, 1);
        let (v0, v1) = 0x2::coin::create_currency<MONEY_TREE>(arg0, 9, b"MTREE", b"MONEY TREE", b"Stack Up Long Money on Sui w The Money Tree by Matt Furie seen in his Book Mindviscosity & Hed Nft Art Collection.", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe(0x1::ascii::string(b"https://bafkreiapada6rrk365vz372hkoy4qhb67h2hwknm73qdgc7ciz6eikk5ty.ipfs.w3s.link/"))), arg1);
        let v2 = v0;
        0x2::coin::mint_and_transfer<MONEY_TREE>(&mut v2, 1000000000000000000, @0xe1dad13b3eb752ffa54e8d6637df725905e51abe0aa98304ece87758113c7f03, arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<MONEY_TREE>>(v2, @0xe1dad13b3eb752ffa54e8d6637df725905e51abe0aa98304ece87758113c7f03);
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<MONEY_TREE>>(v1);
    }

    // decompiled from Move bytecode v6
}

