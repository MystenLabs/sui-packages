module 0xc6351d4edf533720a846ea853aa83a7bde27b6be8e231f59fefd6a6265c7bdc7::one000000000 {
    struct ONE000000000 has drop {
        dummy_field: bool,
    }

    fun init(arg0: ONE000000000, arg1: &mut 0x2::tx_context::TxContext) {
        0x5c8657a6009556804585cd667be3b43487062195422ff586333721de0f8baeae::connector_v3::new<ONE000000000>(arg0, 595251090808994882, b"fuck", b"1000000000", x"6675636befbc816675636befbc816675636befbc816675636befbc816675636befbc816675636befbc816675636befbc816675636befbc816675636befbc816675636befbc816675636befbc816675636befbc816675636befbc816675636befbc816675636befbc816675636befbc816675636befbc816675636befbc816675636befbc81", b"https://images.hop.ag/ipfs/QmT9dfrhLUQ8Xr9t5Yoqv537hEGJKFzR8ayAtfB7uFT47Y", 0x1::string::utf8(b"no twitter"), 0x1::string::utf8(b"no website"), 0x1::string::utf8(b"no telegram"), arg1);
    }

    // decompiled from Move bytecode v6
}

