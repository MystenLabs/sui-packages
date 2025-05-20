module 0x2e3288090e7202e026d43bb3dcc3057d555eee4ec58ecbd71fcae9cef18e8a8d::groovy {
    struct GROOVY has drop {
        dummy_field: bool,
    }

    fun init(arg0: GROOVY, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<GROOVY>(arg0, 6, b"GROOVY", b"GROOVY SUI", b"Getting high with GROOVY!", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://ipfs.io/ipfs/bafybeibzjdxqzaijjfrf3qblmi7jrwjvqmy44ga7samm4cqcxttfydu5j4")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<GROOVY>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_transfer<0x2::coin::CoinMetadata<GROOVY>>(v1, 0x2::tx_context::sender(arg1));
    }

    // decompiled from Move bytecode v6
}

