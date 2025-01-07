module 0x78fa84b496b4493706fbf3dabfd71594ddd619d479ac80f85cd2484f7c85d738::blobs {
    struct BLOBS has drop {
        dummy_field: bool,
    }

    fun init(arg0: BLOBS, arg1: &mut 0x2::tx_context::TxContext) {
        0x5c8657a6009556804585cd667be3b43487062195422ff586333721de0f8baeae::connector_v3::new<BLOBS>(arg0, 676320832196048319, b"DeBlobs", b"Blobs", b"$BLOBS is more than just a memecoin; it's the start of a new movement on the Sui blockchain.", b"https://images.hop.ag/ipfs/QmZT1gBYYYscEGkHonmg4zsemmWrJRGjfWcNcFzYbPyri1", 0x1::string::utf8(b"https://x.com/De_Blobs"), 0x1::string::utf8(b"https://deblobs.com/"), 0x1::string::utf8(b"https://t.me/De_Blobs"), arg1);
    }

    // decompiled from Move bytecode v6
}

