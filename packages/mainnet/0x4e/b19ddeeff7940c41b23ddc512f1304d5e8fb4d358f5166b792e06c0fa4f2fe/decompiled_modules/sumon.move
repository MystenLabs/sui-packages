module 0x4eb19ddeeff7940c41b23ddc512f1304d5e8fb4d358f5166b792e06c0fa4f2fe::sumon {
    struct SUMON has drop {
        dummy_field: bool,
    }

    fun init(arg0: SUMON, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<SUMON>(arg0, 6, b"SUMON", b"Sumon", b"Sumon is the most unique Pokemon in Sui, with its running speed it can surpass all other Pokemon.", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/1000072032_8b1f73ad38.jpg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<SUMON>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<SUMON>>(v1);
    }

    // decompiled from Move bytecode v6
}

