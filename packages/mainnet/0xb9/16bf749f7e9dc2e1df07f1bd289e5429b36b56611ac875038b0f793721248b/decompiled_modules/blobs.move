module 0xb916bf749f7e9dc2e1df07f1bd289e5429b36b56611ac875038b0f793721248b::blobs {
    struct BLOBS has drop {
        dummy_field: bool,
    }

    fun init(arg0: BLOBS, arg1: &mut 0x2::tx_context::TxContext) {
        0x5c8657a6009556804585cd667be3b43487062195422ff586333721de0f8baeae::connector_v3::new<BLOBS>(arg0, 16342731612320575616, b"DeBlobs", b"BLOBS", b"$blobs isn't just another memecoin; it's the beginning of a new movement on the Sui blockchain. With fun, creativity, and a strong community spirit at its core, $blobs is set to make waves in the crypto world.", b"https://images.hop.ag/ipfs/QmSyG8RwQphVG3A8X36VL6o6w3C7fgAaLscD9S3UqLPDRt", 0x1::string::utf8(b"https://x.com/De_Blobs"), 0x1::string::utf8(b"https://deblobs.com/"), 0x1::string::utf8(b"https://t.me/De_Blobs"), arg1);
    }

    // decompiled from Move bytecode v6
}

