module 0x9ff2d887a3fd3fbf90a77705d6cd82c6e3b60fcb1ed7a0a1e321acde1a17de2a::depengu {
    struct DEPENGU has drop {
        dummy_field: bool,
    }

    fun init(arg0: DEPENGU, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<DEPENGU>(arg0, 6, b"DEPENGU", b"Detective Pengu", b"Detective Pengu conducting investigation for all the memes deployed in SUI", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://ipfs.io/ipfs/bafybeicdqnikbxl5plnwosv46lvditz4ihmioxmaucshujastynnuo4kye")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<DEPENGU>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_transfer<0x2::coin::CoinMetadata<DEPENGU>>(v1, 0x2::tx_context::sender(arg1));
    }

    // decompiled from Move bytecode v6
}

