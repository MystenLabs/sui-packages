module 0xafc593377fdc56d94f3ff9426bc621006443e4f9969ba6aacc38c8300b3372cd::sbull {
    struct SBULL has drop {
        dummy_field: bool,
    }

    fun init(arg0: SBULL, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<SBULL>(arg0, 6, b"SBULL", b"SUI BULL", x"426f726e20746f206d6f672c206d61646520746f206c617374200a0a546865206d6173636f74206f6620746865205355492062756c6c2d6d61726b657420200a", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/Chad_the_bull_MEMES_03_9911197db1.png")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<SBULL>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<SBULL>>(v1);
    }

    // decompiled from Move bytecode v6
}

