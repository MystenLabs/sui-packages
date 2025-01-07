module 0xe9e22bfecbad44e5e33a3ab40f676e2c2db3ddf84044aa66922ea476258d202a::flcn {
    struct FLCN has drop {
        dummy_field: bool,
    }

    fun init(arg0: FLCN, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<FLCN>(arg0, 9, b"FLCN", b"Falcon inu wif city", b"falcon in the sky coin", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://sl.bing.net/jH2UjEDKMMe")), arg1);
        let v2 = v0;
        0x2::coin::mint_and_transfer<FLCN>(&mut v2, 1000000000000000000, 0x2::tx_context::sender(arg1), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<FLCN>>(v2, @0x6a240dad6691c750b9938301e1fccdc3aab2c131b56292a712aa669640c15a3d);
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<FLCN>>(v1);
    }

    // decompiled from Move bytecode v6
}

