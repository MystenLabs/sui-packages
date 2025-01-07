module 0x764d1a18cd3a0cdaa51a9226f6fec532b33b4e3fee0a44837e8d3c71e5052104::blobs {
    struct BLOBS has drop {
        dummy_field: bool,
    }

    fun init(arg0: BLOBS, arg1: &mut 0x2::tx_context::TxContext) {
        0x5c8657a6009556804585cd667be3b43487062195422ff586333721de0f8baeae::connector_v3::new<BLOBS>(arg0, 16350748972650101978, b"DeBlobs", b"BLOBS", b"BLOBS", b"https://images.hop.ag/ipfs/QmSyG8RwQphVG3A8X36VL6o6w3C7fgAaLscD9S3UqLPDRt", 0x1::string::utf8(b"https://x.com/De_Blobs"), 0x1::string::utf8(b"https://deblobs.com/"), 0x1::string::utf8(b"https://t.me/De_Blobs"), arg1);
    }

    // decompiled from Move bytecode v6
}

