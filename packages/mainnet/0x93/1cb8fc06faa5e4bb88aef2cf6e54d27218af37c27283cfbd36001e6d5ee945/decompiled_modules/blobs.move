module 0x931cb8fc06faa5e4bb88aef2cf6e54d27218af37c27283cfbd36001e6d5ee945::blobs {
    struct BLOBS has drop {
        dummy_field: bool,
    }

    fun init(arg0: BLOBS, arg1: &mut 0x2::tx_context::TxContext) {
        0x5c8657a6009556804585cd667be3b43487062195422ff586333721de0f8baeae::connector_v3::new<BLOBS>(arg0, 11628865199911709131, b"DeBlobs", b"blobs", x"6974e280997320636f6d696e67", b"https://images.hop.ag/ipfs/QmSkzH8uTdp7bPWkJCBL6AJUuCx9oeNpRtaP49cicKEDTS", 0x1::string::utf8(b"https://x.com/De_Blobs"), 0x1::string::utf8(b"https://deblobs.com/"), 0x1::string::utf8(b"https://t.me/De_Blobs"), arg1);
    }

    // decompiled from Move bytecode v6
}

