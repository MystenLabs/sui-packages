module 0x66089d294d079c86a3fa2e48ea4021e8d6afebc8acc4e081cbbc54bf32079cb0::turtl {
    struct TURTL has drop {
        dummy_field: bool,
    }

    fun init(arg0: TURTL, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<TURTL>(arg0, 6, b"TURTL", b"TURTLE", b"The Ticker is Photo taken of cute turtles natural pose in the sea by sea diver @gian_carlin0 on Instagram. will immortalize the turtle in the Sui Sea ", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://r.turbos.finance/icon/1731377230543.jpeg")), arg1);
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<TURTL>>(v1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<TURTL>>(v0, 0x2::tx_context::sender(arg1));
    }

    // decompiled from Move bytecode v6
}

