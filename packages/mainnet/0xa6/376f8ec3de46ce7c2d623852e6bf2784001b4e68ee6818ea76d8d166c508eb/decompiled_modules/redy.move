module 0xa6376f8ec3de46ce7c2d623852e6bf2784001b4e68ee6818ea76d8d166c508eb::redy {
    struct REDY has drop {
        dummy_field: bool,
    }

    fun init(arg0: REDY, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<REDY>(arg0, 6, b"REDY", b"Redy Sui", b"Redy - Your sweet gateway to the crypto world", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/1000001068_ffa74948b2.png")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<REDY>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<REDY>>(v1);
    }

    // decompiled from Move bytecode v6
}

