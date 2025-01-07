module 0x48623c620a30b2806eacfc51715b012944d58efba3de7a3b990fb69a9a6aec18::sduck {
    struct SDUCK has drop {
        dummy_field: bool,
    }

    fun init(arg0: SDUCK, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<SDUCK>(arg0, 6, b"Sduck", b"Sui Duck", b"sui dock come to sui to sui duck lovr  ", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/aa1_d496fd385c.png")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<SDUCK>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<SDUCK>>(v1);
    }

    // decompiled from Move bytecode v6
}

