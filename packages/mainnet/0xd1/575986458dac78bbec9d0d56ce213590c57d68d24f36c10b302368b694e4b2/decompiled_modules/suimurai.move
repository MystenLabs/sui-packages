module 0xd1575986458dac78bbec9d0d56ce213590c57d68d24f36c10b302368b694e4b2::suimurai {
    struct SUIMURAI has drop {
        dummy_field: bool,
    }

    fun init(arg0: SUIMURAI, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<SUIMURAI>(arg0, 6, b"SUIMURAI", b"SAMURAI", b"BLUE SAMURAI", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/SAMURAI_940c3bbfdf.jpg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<SUIMURAI>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<SUIMURAI>>(v1);
    }

    // decompiled from Move bytecode v6
}

