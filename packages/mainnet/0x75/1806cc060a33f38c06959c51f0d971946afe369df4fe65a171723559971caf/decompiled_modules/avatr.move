module 0x751806cc060a33f38c06959c51f0d971946afe369df4fe65a171723559971caf::avatr {
    struct AVATR has drop {
        dummy_field: bool,
    }

    fun init(arg0: AVATR, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<AVATR>(arg0, 6, b"AVATR", b"SUI AVATAR", x"415641544152535549204f4e20484953205741590a546865206c6173742061697262656e64657220696e207468652063727970746f20776f726c64", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://ipfs.io/ipfs/bafkreidjcgtfwatwvdo6ubcj65ou7wjb7dsknbf3j5h47gwlop5ani5gwu")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<AVATR>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_transfer<0x2::coin::CoinMetadata<AVATR>>(v1, 0x2::tx_context::sender(arg1));
    }

    // decompiled from Move bytecode v6
}

