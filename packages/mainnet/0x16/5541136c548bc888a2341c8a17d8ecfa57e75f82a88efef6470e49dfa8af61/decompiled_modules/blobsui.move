module 0x165541136c548bc888a2341c8a17d8ecfa57e75f82a88efef6470e49dfa8af61::blobsui {
    struct BLOBSUI has drop {
        dummy_field: bool,
    }

    fun init(arg0: BLOBSUI, arg1: &mut 0x2::tx_context::TxContext) {
        0x5c8657a6009556804585cd667be3b43487062195422ff586333721de0f8baeae::connector_v3::new<BLOBSUI>(arg0, 10010524888404124682, b"The Blobs", b"BLOBSUI", b"These are de blobs, the strangest living creatures, now on SUI", b"https://images.hop.ag/ipfs/QmSyG8RwQphVG3A8X36VL6o6w3C7fgAaLscD9S3UqLPDRt", 0x1::string::utf8(b"https://x.com/De_Blobs"), 0x1::string::utf8(b"https://t.co/AcWeRN5qlT"), 0x1::string::utf8(b"https://t.me/De_Blobs"), arg1);
    }

    // decompiled from Move bytecode v6
}

