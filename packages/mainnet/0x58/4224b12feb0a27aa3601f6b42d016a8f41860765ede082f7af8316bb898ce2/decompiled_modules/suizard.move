module 0x584224b12feb0a27aa3601f6b42d016a8f41860765ede082f7af8316bb898ce2::suizard {
    struct SUIZARD has drop {
        dummy_field: bool,
    }

    fun init(arg0: SUIZARD, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<SUIZARD>(arg0, 9, b"SUIZD", b"Suizard", b"A fiery dragon with a shimmering Sui coin for a belly, its flame tail shapes into a dripping Sui droplet.", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://silver-urban-aardwolf-425.mypinata.cloud/ipfs/bafkreic7yklxjcqxdviefboyjeppbkjccxmyg76to3e6y4233xoj7ehuqu")), arg1);
        let v2 = v0;
        0x2::coin::mint_and_transfer<SUIZARD>(&mut v2, 1000000000000000000, @0xb0ed1ff98508d0cd74fb515e595ae0879b652d21a6a93eb94a8e707bde83f73b, arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<SUIZARD>>(v2, @0x0);
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<SUIZARD>>(v1);
    }

    // decompiled from Move bytecode v6
}

