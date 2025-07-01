module 0xc7122e2880fc68c583dd947161d56fa001b44b274dcee79e7bbd1bee5c8a991d::rlofi {
    struct RLOFI has drop {
        dummy_field: bool,
    }

    fun init(arg0: RLOFI, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<RLOFI>(arg0, 6, b"RLOFI", b"ROBOLOFI THE YETI", x"526f626f4c6f666920697320746865206e65772077617920746f2064697665727369667920696e20746865204c4f46492065636f73797374656d2c207468697320697320746865206e657874206c61756e636820696e20612073657269657320666f72206f7572206f6666696369616c204c4f4649204e4654732e0a0a5374617920636f6f6c21202d6579657a656e686f75720a0a416c6c20646f6e6174696f6e732077696c6c20626520706f7374656420617320757375616c21", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://ipfs.io/ipfs/bafybeigktjucqlhbfrkdq4pxyfubannacorqb4z2d2reow7ggyrfgx7bki")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<RLOFI>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_transfer<0x2::coin::CoinMetadata<RLOFI>>(v1, 0x2::tx_context::sender(arg1));
    }

    // decompiled from Move bytecode v6
}

