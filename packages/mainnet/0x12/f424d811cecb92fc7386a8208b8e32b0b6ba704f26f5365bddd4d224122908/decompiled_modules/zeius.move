module 0x12f424d811cecb92fc7386a8208b8e32b0b6ba704f26f5365bddd4d224122908::zeius {
    struct ZEIUS has drop {
        dummy_field: bool,
    }

    fun init(arg0: ZEIUS, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<ZEIUS>(arg0, 6, b"ZEIUS", b"ZeiusOnSui", b"The leading meme coin on sui", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/20241004_133752_236956ec08.jpg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<ZEIUS>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<ZEIUS>>(v1);
    }

    // decompiled from Move bytecode v6
}

