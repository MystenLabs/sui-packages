module 0xf9a896e6c249c8501c7ed8a360143a0e21cdc58886d25d8f789f0d817782f28b::ban {
    struct BAN has drop {
        dummy_field: bool,
    }

    fun init(arg0: BAN, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<BAN>(arg0, 6, b"BAN", b"ban", b"$Banana - About Banana: is a fun and quirky MEME", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/1000000349_1752eb86fe.jpg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<BAN>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<BAN>>(v1);
    }

    // decompiled from Move bytecode v6
}

