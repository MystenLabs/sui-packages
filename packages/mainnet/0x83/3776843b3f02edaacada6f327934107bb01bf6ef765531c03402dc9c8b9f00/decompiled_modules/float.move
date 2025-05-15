module 0x833776843b3f02edaacada6f327934107bb01bf6ef765531c03402dc9c8b9f00::float {
    struct FLOAT has drop {
        dummy_field: bool,
    }

    fun init(arg0: FLOAT, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<FLOAT>(arg0, 6, b"FLOAT", b"Float on sui", b"FLOA is a viral social-financial experiment blending memecoins, NFTs, and user-generated content into a community-driven movement.", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://ipfs.io/ipfs/bafkreibxml5yxgh4pkwbmue3ogov6nxrxwlopvknbqktcldllvlc5qvwuy")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<FLOAT>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_transfer<0x2::coin::CoinMetadata<FLOAT>>(v1, 0x2::tx_context::sender(arg1));
    }

    // decompiled from Move bytecode v6
}

