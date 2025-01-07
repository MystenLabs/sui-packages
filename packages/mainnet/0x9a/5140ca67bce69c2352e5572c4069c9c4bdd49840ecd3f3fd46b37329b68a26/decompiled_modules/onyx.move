module 0x9a5140ca67bce69c2352e5572c4069c9c4bdd49840ecd3f3fd46b37329b68a26::onyx {
    struct ONYX has drop {
        dummy_field: bool,
    }

    fun init(arg0: ONYX, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<ONYX>(arg0, 9, b"ONYX", b"ONYX", b"The name is Onyx white baby Rhino at Dubai Safari Park", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://tomato-deep-eel-22.mypinata.cloud/ipfs/QmVWKkaBeehMNPCczio7VQMuHgqkPkoqfqdYqseXK8Srdg")), arg1);
        let v2 = v0;
        0x2::coin::mint_and_transfer<ONYX>(&mut v2, 1000000000000000000, 0x2::tx_context::sender(arg1), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<ONYX>>(v2, @0x0);
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<ONYX>>(v1);
    }

    // decompiled from Move bytecode v6
}

