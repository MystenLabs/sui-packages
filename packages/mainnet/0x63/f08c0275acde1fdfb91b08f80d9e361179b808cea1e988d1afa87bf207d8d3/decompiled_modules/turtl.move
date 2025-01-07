module 0x63f08c0275acde1fdfb91b08f80d9e361179b808cea1e988d1afa87bf207d8d3::turtl {
    struct TURTL has drop {
        dummy_field: bool,
    }

    fun init(arg0: TURTL, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<TURTL>(arg0, 6, b"TURTL", b"Turtle Turbos", b"the fastest slowest token on the sui blockchain! This turtle loves speed so much that he secretly considers himself a cheetah", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://r.turbos.finance/icon/1730438944745.jpeg")), arg1);
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<TURTL>>(v1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<TURTL>>(v0, 0x2::tx_context::sender(arg1));
    }

    // decompiled from Move bytecode v6
}

