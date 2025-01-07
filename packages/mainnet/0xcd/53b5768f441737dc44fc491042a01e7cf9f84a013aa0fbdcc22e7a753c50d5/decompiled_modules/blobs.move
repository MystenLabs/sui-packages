module 0xcd53b5768f441737dc44fc491042a01e7cf9f84a013aa0fbdcc22e7a753c50d5::blobs {
    struct BLOBS has drop {
        dummy_field: bool,
    }

    fun init(arg0: BLOBS, arg1: &mut 0x2::tx_context::TxContext) {
        0x5c8657a6009556804585cd667be3b43487062195422ff586333721de0f8baeae::connector_v3::new<BLOBS>(arg0, 12686777309317829810, b"DeBlobs", b"blobs", b"coming", b"https://images.hop.ag/ipfs/QmUaiF1bzoQ5S1QUAv7eBBg8N3ACywDZnCyHFiHPvaNBs3", 0x1::string::utf8(b"https://x.com/De_Blobs"), 0x1::string::utf8(b"https://deblobs.com/"), 0x1::string::utf8(b"https://t.me/De_Blobs"), arg1);
    }

    // decompiled from Move bytecode v6
}

