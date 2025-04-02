module 0x469acdfadaff71e26d2355fb0121a9696ad9aa0b86b0b4f333046bb6c76e5cdf::liazard {
    struct LIAZARD has drop {
        dummy_field: bool,
    }

    fun init(arg0: LIAZARD, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<LIAZARD>(arg0, 6, b"LIAZARD", b"lizard TOKEN", b"Welcome to the next generation of meme coin, a cute lizard that gives everyone a sense of security", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/487009055_649127611173117_3710231808858901699_n_945a2791b5.jpg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<LIAZARD>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<LIAZARD>>(v1);
    }

    // decompiled from Move bytecode v6
}

