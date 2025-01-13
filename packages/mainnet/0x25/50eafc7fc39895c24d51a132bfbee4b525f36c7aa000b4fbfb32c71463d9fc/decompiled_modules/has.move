module 0x2550eafc7fc39895c24d51a132bfbee4b525f36c7aa000b4fbfb32c71463d9fc::has {
    struct HAS has drop {
        dummy_field: bool,
    }

    fun init(arg0: HAS, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<HAS>(arg0, 6, b"HAS", b"HULKAISUI", b"Hulk is happy to welcome you!", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/7_7623eaa993.jpg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<HAS>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<HAS>>(v1);
    }

    // decompiled from Move bytecode v6
}

