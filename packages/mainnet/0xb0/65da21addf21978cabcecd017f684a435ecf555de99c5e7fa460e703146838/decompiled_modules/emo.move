module 0xb065da21addf21978cabcecd017f684a435ecf555de99c5e7fa460e703146838::emo {
    struct EMO has drop {
        dummy_field: bool,
    }

    fun init(arg0: EMO, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<EMO>(arg0, 6, b"EMO", b"EMOGLA", x"456d6f6c6761206973206120776869746520726f64656e74206c696b6520506f6bc3a96d6f6e20726573656d626c696e67206120666c79696e6720737175697272656c2e2049742068617320626c61636b206579657320612074696e79206e6f736520616e642079656c6c6f7720656c6563747269632073616373206f6e2069747320636865656b73", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://ipfs.io/ipfs/bafkreielzsshc2hcxnrtr2sgil7dstuobvxbbagfz22kahfa5k7nc67mfq")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<EMO>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_transfer<0x2::coin::CoinMetadata<EMO>>(v1, 0x2::tx_context::sender(arg1));
    }

    // decompiled from Move bytecode v6
}

