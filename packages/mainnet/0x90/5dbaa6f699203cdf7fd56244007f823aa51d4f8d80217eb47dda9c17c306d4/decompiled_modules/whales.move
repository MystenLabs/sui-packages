module 0x905dbaa6f699203cdf7fd56244007f823aa51d4f8d80217eb47dda9c17c306d4::whales {
    struct WHALES has drop {
        dummy_field: bool,
    }

    fun init(arg0: WHALES, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<WHALES>(arg0, 6, b"WHALES", b"Whale Sui", x"576f726c64206c656164696e67206272616e642e2043727970746f63757272656e636965732e204d656d65636f696e732e0a506f73747320617265206e6f742066696e616e6369616c206164766963652e", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/IMG_9743_044dce4496.jpeg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<WHALES>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<WHALES>>(v1);
    }

    // decompiled from Move bytecode v6
}

