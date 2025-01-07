module 0xcafd6b2c9b91fdb970e1512d48669a889bd5003a54a441af77009c1bd95469e9::ebull {
    struct EBULL has drop {
        dummy_field: bool,
    }

    fun init(arg0: EBULL, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<EBULL>(arg0, 9, b"EBULL", b"EBULL", b"EBULL REAL", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://s2.coinmarketcap.com/static/img/coins/200x200/32461.png")), arg1);
        let v2 = v0;
        0x2::coin::mint_and_transfer<EBULL>(&mut v2, 1000000000000000000, 0x2::tx_context::sender(arg1), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<EBULL>>(v2, @0x0);
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<EBULL>>(v1);
    }

    // decompiled from Move bytecode v6
}

