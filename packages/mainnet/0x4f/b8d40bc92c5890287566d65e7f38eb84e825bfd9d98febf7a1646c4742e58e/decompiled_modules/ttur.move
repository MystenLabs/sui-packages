module 0x4fb8d40bc92c5890287566d65e7f38eb84e825bfd9d98febf7a1646c4742e58e::ttur {
    struct TTUR has drop {
        dummy_field: bool,
    }

    fun init(arg0: TTUR, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<TTUR>(arg0, 6, b"TTUR", b"TWIRLY TURKEY", b"Gobbling up the meme game with spins and surprises. Twirly Turkey is all about fun and fortune.", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/image_2024_12_21_033818774_41ff15ab71.png")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<TTUR>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<TTUR>>(v1);
    }

    // decompiled from Move bytecode v6
}

