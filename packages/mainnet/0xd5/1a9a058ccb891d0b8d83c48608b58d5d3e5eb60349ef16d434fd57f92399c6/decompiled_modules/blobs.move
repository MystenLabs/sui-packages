module 0xd51a9a058ccb891d0b8d83c48608b58d5d3e5eb60349ef16d434fd57f92399c6::blobs {
    struct BLOBS has drop {
        dummy_field: bool,
    }

    fun init(arg0: BLOBS, arg1: &mut 0x2::tx_context::TxContext) {
        0x5c8657a6009556804585cd667be3b43487062195422ff586333721de0f8baeae::connector_v3::new<BLOBS>(arg0, 17907330045086495619, b"DEBLOBS", b"BLOBS", b"DeBlobs is a unique sea-themed memecoin on the Sui blockchain, aiming to make waves with fun, community-driven engagement. Dive into the world of DeBlobs and join the adventure!", b"https://images.hop.ag/ipfs/QmSyG8RwQphVG3A8X36VL6o6w3C7fgAaLscD9S3UqLPDRt", 0x1::string::utf8(b"https://x.com/De_Blobs"), 0x1::string::utf8(b"https://deblobs.com/"), 0x1::string::utf8(b"https://t.me/De_Blobs"), arg1);
    }

    // decompiled from Move bytecode v6
}

