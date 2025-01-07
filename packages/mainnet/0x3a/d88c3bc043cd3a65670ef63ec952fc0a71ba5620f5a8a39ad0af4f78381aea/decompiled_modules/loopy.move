module 0x3ad88c3bc043cd3a65670ef63ec952fc0a71ba5620f5a8a39ad0af4f78381aea::loopy {
    struct LOOPY has drop {
        dummy_field: bool,
    }

    fun init(arg0: LOOPY, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<LOOPY>(arg0, 6, b"LOOPY", b"aaa loopy", b"AAAAAAAAAA Can't stop, won't stop (cheering for Sui)!", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/0_7ca6cf3cb4.png")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<LOOPY>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<LOOPY>>(v1);
    }

    // decompiled from Move bytecode v6
}

