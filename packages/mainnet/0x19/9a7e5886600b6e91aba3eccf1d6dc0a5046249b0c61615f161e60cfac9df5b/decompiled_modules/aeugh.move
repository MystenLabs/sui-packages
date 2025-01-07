module 0x199a7e5886600b6e91aba3eccf1d6dc0a5046249b0c61615f161e60cfac9df5b::aeugh {
    struct AEUGH has drop {
        dummy_field: bool,
    }

    fun init(arg0: AEUGH, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<AEUGH>(arg0, 6, b"AEUGH", b"pufferfish wif carrot", b"feed me carrot", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/1000010264_61c5f3acf5.jpg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<AEUGH>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<AEUGH>>(v1);
    }

    // decompiled from Move bytecode v6
}

