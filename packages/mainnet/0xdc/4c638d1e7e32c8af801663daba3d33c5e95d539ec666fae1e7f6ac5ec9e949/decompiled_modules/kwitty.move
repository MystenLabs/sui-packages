module 0xdc4c638d1e7e32c8af801663daba3d33c5e95d539ec666fae1e7f6ac5ec9e949::kwitty {
    struct KWITTY has drop {
        dummy_field: bool,
    }

    fun init(arg0: KWITTY, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<KWITTY>(arg0, 6, b"Kwitty", b"Kawaii Cat", b"Come and Play with me, Join our TG for fun and games", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/64e701b7df7ad8b_30042a33fb.jpg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<KWITTY>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<KWITTY>>(v1);
    }

    // decompiled from Move bytecode v6
}

