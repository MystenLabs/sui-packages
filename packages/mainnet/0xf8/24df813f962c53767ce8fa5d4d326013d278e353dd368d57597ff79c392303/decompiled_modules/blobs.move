module 0xf824df813f962c53767ce8fa5d4d326013d278e353dd368d57597ff79c392303::blobs {
    struct BLOBS has drop {
        dummy_field: bool,
    }

    fun init(arg0: BLOBS, arg1: &mut 0x2::tx_context::TxContext) {
        0x5c8657a6009556804585cd667be3b43487062195422ff586333721de0f8baeae::connector_v3::new<BLOBS>(arg0, 4645181988093771925, b"DE BLOBS", b"BLOBS", b"$Blobs is more than just a memecoin; it's the start of a new movement on the Sui blockchain.", b"https://images.hop.ag/ipfs/QmSyG8RwQphVG3A8X36VL6o6w3C7fgAaLscD9S3UqLPDRt", 0x1::string::utf8(b"https://x.com/De_Blobs/photo"), 0x1::string::utf8(b"https://deblobs.com/"), 0x1::string::utf8(b"https://t.me/De_Blobs"), arg1);
    }

    // decompiled from Move bytecode v6
}

