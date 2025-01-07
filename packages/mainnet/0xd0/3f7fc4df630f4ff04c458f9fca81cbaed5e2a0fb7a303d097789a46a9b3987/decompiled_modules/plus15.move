module 0xd03f7fc4df630f4ff04c458f9fca81cbaed5e2a0fb7a303d097789a46a9b3987::plus15 {
    struct PLUS15 has drop {
        dummy_field: bool,
    }

    fun init(arg0: PLUS15, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<PLUS15>(arg0, 6, b"PLUS15", b"+15%", b"Stop watching the market fall. 15% for everyone from today. It's time to become rich and happy. Jump into our spaceship and go to the moon to conquer the treasure of the universe.", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/goldher_2519e12e24.png")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<PLUS15>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<PLUS15>>(v1);
    }

    // decompiled from Move bytecode v6
}

