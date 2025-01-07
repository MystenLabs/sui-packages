module 0x9b806b50c55a592fceda590a8915fc6199bc68077994f21031c98ef1b4d9313d::brett20 {
    struct BRETT20 has drop {
        dummy_field: bool,
    }

    fun init(arg0: BRETT20, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<BRETT20>(arg0, 6, b"BRETT20", b"BRETT 2.0 SUI", b"just $brett20", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/bret_510173b5d2.png")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<BRETT20>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<BRETT20>>(v1);
    }

    // decompiled from Move bytecode v6
}

