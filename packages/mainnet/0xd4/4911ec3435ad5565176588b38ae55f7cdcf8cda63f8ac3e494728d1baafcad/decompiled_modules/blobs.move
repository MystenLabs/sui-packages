module 0xd44911ec3435ad5565176588b38ae55f7cdcf8cda63f8ac3e494728d1baafcad::blobs {
    struct BLOBS has drop {
        dummy_field: bool,
    }

    fun init(arg0: BLOBS, arg1: &mut 0x2::tx_context::TxContext) {
        0x5c8657a6009556804585cd667be3b43487062195422ff586333721de0f8baeae::connector_v3::new<BLOBS>(arg0, 10687927854375815638, b"DE BLOBS", b"BLOBS", x"24426c6f6273206973206d6f7265207468616e206a7573742061206d656d65636f696e0a57652072656c61756e6368696e67206e6f77", b"https://images.hop.ag/ipfs/QmSyG8RwQphVG3A8X36VL6o6w3C7fgAaLscD9S3UqLPDRt", 0x1::string::utf8(b"https://x.com/De__Blobs"), 0x1::string::utf8(b"https://deblobs.com/"), 0x1::string::utf8(b"https://t.me/De_Blobs"), arg1);
    }

    // decompiled from Move bytecode v6
}

