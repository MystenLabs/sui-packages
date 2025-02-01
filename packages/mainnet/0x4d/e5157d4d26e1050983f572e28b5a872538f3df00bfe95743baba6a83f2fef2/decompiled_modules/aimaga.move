module 0x4de5157d4d26e1050983f572e28b5a872538f3df00bfe95743baba6a83f2fef2::aimaga {
    struct AIMAGA has drop {
        dummy_field: bool,
    }

    fun init(arg0: AIMAGA, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<AIMAGA>(arg0, 6, b"AIMAGA", b"PRESIDENT.EXE", b"Introducing a virtual AI avatar bot like nothing you've seen before. Inspired by the virality of similar AI on twitch but with a bold Trump theme, we're merging election hype with AI meta for something that will dominate social conversations. ", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/IMG_20250202_024318_321_766e27943f.jpg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<AIMAGA>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<AIMAGA>>(v1);
    }

    // decompiled from Move bytecode v6
}

