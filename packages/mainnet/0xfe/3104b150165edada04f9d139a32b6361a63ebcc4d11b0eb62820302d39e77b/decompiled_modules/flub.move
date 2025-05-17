module 0xfe3104b150165edada04f9d139a32b6361a63ebcc4d11b0eb62820302d39e77b::flub {
    struct FLUB has drop {
        dummy_field: bool,
    }

    fun init(arg0: FLUB, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<FLUB>(arg0, 6, b"FLUB", b"FLUB THE FISH", b"Fish and water, Hand in glove-a perfect mariage with sui network", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://ipfs.io/ipfs/bafkreiewtuzjeuig5f4mlzqbxwou2tfmyjrrinux5gntf5q6bes2wjgeoi")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<FLUB>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_transfer<0x2::coin::CoinMetadata<FLUB>>(v1, 0x2::tx_context::sender(arg1));
    }

    // decompiled from Move bytecode v6
}

