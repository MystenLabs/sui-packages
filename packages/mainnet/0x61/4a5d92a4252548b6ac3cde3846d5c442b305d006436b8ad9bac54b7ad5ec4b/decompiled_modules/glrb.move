module 0x614a5d92a4252548b6ac3cde3846d5c442b305d006436b8ad9bac54b7ad5ec4b::glrb {
    struct GLRB has drop {
        dummy_field: bool,
    }

    fun init(arg0: GLRB, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<GLRB>(arg0, 6, b"GLRB", b"GLORBO", b"I'm Samantha - and this is a transforming plastic creature GLORBO. The page in the link will be available soon.", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://ipfs.io/ipfs/bafkreiguenefkucgsdlqauypn2raonwhigyg4y76doq23e5f7u63r32iq4")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<GLRB>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_transfer<0x2::coin::CoinMetadata<GLRB>>(v1, 0x2::tx_context::sender(arg1));
    }

    // decompiled from Move bytecode v6
}

