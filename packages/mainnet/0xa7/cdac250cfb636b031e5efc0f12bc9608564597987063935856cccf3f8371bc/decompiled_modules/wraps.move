module 0xa7cdac250cfb636b031e5efc0f12bc9608564597987063935856cccf3f8371bc::wraps {
    struct WRAPS has drop {
        dummy_field: bool,
    }

    fun init(arg0: WRAPS, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<WRAPS>(arg0, 6, b"WRAPS", b"It's WRAPS", b"It's Wraps.", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/pfp_d3e08750fa.jpg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<WRAPS>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<WRAPS>>(v1);
    }

    // decompiled from Move bytecode v6
}

