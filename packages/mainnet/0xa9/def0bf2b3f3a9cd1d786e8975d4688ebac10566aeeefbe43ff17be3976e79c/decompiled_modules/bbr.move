module 0xa9def0bf2b3f3a9cd1d786e8975d4688ebac10566aeeefbe43ff17be3976e79c::bbr {
    struct BBR has drop {
        dummy_field: bool,
    }

    fun init(arg0: BBR, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<BBR>(arg0, 6, b"BBR", b"BOUNCY BEAR", b"Jumping high and roaring louder, Bouncy Bear is all about powerful gains.", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/image_2024_12_19_051014344_844ee0bd27.png")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<BBR>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<BBR>>(v1);
    }

    // decompiled from Move bytecode v6
}

