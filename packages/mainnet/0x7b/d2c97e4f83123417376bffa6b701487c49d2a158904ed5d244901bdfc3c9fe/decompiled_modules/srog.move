module 0x7bd2c97e4f83123417376bffa6b701487c49d2a158904ed5d244901bdfc3c9fe::srog {
    struct SROG has drop {
        dummy_field: bool,
    }

    fun init(arg0: SROG, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<SROG>(arg0, 6, b"SROG", b"SEAL FROG", b"Is it a seal? Is it a frog? Nobody knows", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/IMG_0283_3a805895ea.jpeg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<SROG>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<SROG>>(v1);
    }

    // decompiled from Move bytecode v6
}

