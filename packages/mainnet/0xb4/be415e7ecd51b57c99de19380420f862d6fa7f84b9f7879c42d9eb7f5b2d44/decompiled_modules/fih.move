module 0xb4be415e7ecd51b57c99de19380420f862d6fa7f84b9f7879c42d9eb7f5b2d44::fih {
    struct FIH has drop {
        dummy_field: bool,
    }

    fun init(arg0: FIH, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<FIH>(arg0, 6, b"FIH", b"Fox in Hole", b"he wanted to find some buried treasure, but all he got was a lot of \"furry\" fluctuations!", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/20241007_015805_7626798a5a.jpg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<FIH>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<FIH>>(v1);
    }

    // decompiled from Move bytecode v6
}

