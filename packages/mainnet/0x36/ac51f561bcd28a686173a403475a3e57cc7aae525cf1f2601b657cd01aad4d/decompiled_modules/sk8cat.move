module 0x36ac51f561bcd28a686173a403475a3e57cc7aae525cf1f2601b657cd01aad4d::sk8cat {
    struct SK8CAT has drop {
        dummy_field: bool,
    }

    fun init(arg0: SK8CAT, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<SK8CAT>(arg0, 6, b"SK8CAT", b"Skater Potato Cat", b"sk8 4life, ride or die", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://ipfs.io/ipfs/bafybeig3nexyrybiouomkwbxraed45sjbvax22q5qkdalvpejvjxnod2dm")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<SK8CAT>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_transfer<0x2::coin::CoinMetadata<SK8CAT>>(v1, 0x2::tx_context::sender(arg1));
    }

    // decompiled from Move bytecode v6
}

