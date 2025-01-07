module 0xd41a4deccddd57c067a369f710aac993c302f1b9e24f7d3c0406c77a34b5c248::suimace {
    struct SUIMACE has drop {
        dummy_field: bool,
    }

    fun init(arg0: SUIMACE, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<SUIMACE>(arg0, 6, b"Suimace", b"Suimace Token", x"746865206e6577206772696d6163652e2068747470733a2f2f742e6d652f7375696d6163650a", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/Suimace_Token_2972bb9c40.jpg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<SUIMACE>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<SUIMACE>>(v1);
    }

    // decompiled from Move bytecode v6
}

