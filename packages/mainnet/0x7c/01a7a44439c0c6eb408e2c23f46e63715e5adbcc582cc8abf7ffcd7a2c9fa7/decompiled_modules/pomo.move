module 0x7c01a7a44439c0c6eb408e2c23f46e63715e5adbcc582cc8abf7ffcd7a2c9fa7::pomo {
    struct POMO has drop {
        dummy_field: bool,
    }

    fun init(arg0: POMO, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<POMO>(arg0, 6, b"POMO", b"First Bitcoin Cat", b"First Bitcoin Cat, not Sasha!", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/photo_2024_10_05_16_42_01_b225c8bd22.jpg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<POMO>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<POMO>>(v1);
    }

    // decompiled from Move bytecode v6
}

