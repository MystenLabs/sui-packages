module 0xcf0b47c4fc3f5ca94eedde44b7be32903570c6b5f1df7acf06e3da6a8d88b2a6::pornhub {
    struct PORNHUB has drop {
        dummy_field: bool,
    }

    fun init(arg0: PORNHUB, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<PORNHUB>(arg0, 9, b"PORNHUB", x"28e280bfcba0e280bf292020e2b1adcd9e20ccb6cd9e20ccb6cd9e20ccb6cd9e20d984dabacd9e", b"Official token", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://www.tbstat.com/wp/uploads/2023/10/sui_asset.jpeg")), arg1);
        let v2 = v0;
        0x2::coin::mint_and_transfer<PORNHUB>(&mut v2, 1000000000000000000, 0x2::tx_context::sender(arg1), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<PORNHUB>>(v2, @0x0);
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<PORNHUB>>(v1);
    }

    // decompiled from Move bytecode v6
}

