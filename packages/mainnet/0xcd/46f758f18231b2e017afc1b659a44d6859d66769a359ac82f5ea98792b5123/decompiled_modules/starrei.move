module 0xcd46f758f18231b2e017afc1b659a44d6859d66769a359ac82f5ea98792b5123::starrei {
    struct STARREI has drop {
        dummy_field: bool,
    }

    fun init(arg0: STARREI, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<STARREI>(arg0, 6, b"STARREI", b"REI THE STAR FACE OF SUI", x"4d4f54495641544544204259205448452053554343455353204f4620424f595320434c55422e204e4f572c2048452057414e545320544f204155444954494f4e2e200a4245484f4c442054484520504f574552204f46205448452053544152204f46205355492e", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/1234125123112_ebb551b683.jpg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<STARREI>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<STARREI>>(v1);
    }

    // decompiled from Move bytecode v6
}

