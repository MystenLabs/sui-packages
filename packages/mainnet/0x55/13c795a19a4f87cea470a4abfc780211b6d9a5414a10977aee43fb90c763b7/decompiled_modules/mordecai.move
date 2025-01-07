module 0x5513c795a19a4f87cea470a4abfc780211b6d9a5414a10977aee43fb90c763b7::mordecai {
    struct MORDECAI has drop {
        dummy_field: bool,
    }

    fun init(arg0: MORDECAI, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<MORDECAI>(arg0, 6, b"Mordecai", b"Mordecai on Sui", b"Meet $MORDECAI, The laid back blue jay from your favorite show has landed on Sui!", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/Morde_PP_6e3a361077.jpg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<MORDECAI>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<MORDECAI>>(v1);
    }

    // decompiled from Move bytecode v6
}

