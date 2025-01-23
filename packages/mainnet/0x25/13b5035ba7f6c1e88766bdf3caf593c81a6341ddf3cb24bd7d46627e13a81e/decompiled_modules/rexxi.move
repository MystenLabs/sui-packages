module 0x2513b5035ba7f6c1e88766bdf3caf593c81a6341ddf3cb24bd7d46627e13a81e::rexxi {
    struct REXXI has drop {
        dummy_field: bool,
    }

    fun init(arg0: REXXI, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<REXXI>(arg0, 6, b"REXXI", b"I'm Rexxi", b"Trying my best to make you laugh ", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/IMG_20250124_021535_696_8492032561.jpg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<REXXI>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<REXXI>>(v1);
    }

    // decompiled from Move bytecode v6
}

