module 0x51c1db9f30d45fc67c907e91f90d865109977cb10dbc3b7c86a43a36207b7a00::blobs {
    struct BLOBS has drop {
        dummy_field: bool,
    }

    fun init(arg0: BLOBS, arg1: &mut 0x2::tx_context::TxContext) {
        0x5c8657a6009556804585cd667be3b43487062195422ff586333721de0f8baeae::connector_v3::new<BLOBS>(arg0, 10933299524215752427, b"DeBlobs", b"BLOBS", b"De $blobs coming on SUI ecosystem", b"https://images.hop.ag/ipfs/QmSkzH8uTdp7bPWkJCBL6AJUuCx9oeNpRtaP49cicKEDTS", 0x1::string::utf8(b"https://x.com/De_Blobs"), 0x1::string::utf8(b"https://deblobs.com/"), 0x1::string::utf8(b"https://t.me/De_Blobs"), arg1);
    }

    // decompiled from Move bytecode v6
}

