module 0xdf8b1747690a596ecda760c7a283b0dda4eab34e04280a8381a2232b18c3ee74::baseballcap {
    struct BASEBALLCAP has drop {
        dummy_field: bool,
    }

    fun init(arg0: BASEBALLCAP, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<BASEBALLCAP>(arg0, 6, b"BaseballCap", b"Baseball Cap", b"A regular baseball cap, are you ready to look forward to this story? This is the first blockbuster of the year!!!", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/images_1_01cf3a82fa.jpg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<BASEBALLCAP>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<BASEBALLCAP>>(v1);
    }

    // decompiled from Move bytecode v6
}

