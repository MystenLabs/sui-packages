module 0x3c8fcfc897010284d4809a6fbe339584f125dc0802f86431b502eef727c3383::robobosuip {
    struct ROBOBOSUIP has drop {
        dummy_field: bool,
    }

    fun init(arg0: ROBOBOSUIP, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<ROBOBOSUIP>(arg0, 6, b"ROBOBOSUIP", b"ROBO SUI PEPE", x"524f424f2053554920504550450a", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/73f150eeb1be62951e7e6bca5773d23c_1_09b1933e5c.png")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<ROBOBOSUIP>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<ROBOBOSUIP>>(v1);
    }

    // decompiled from Move bytecode v6
}

