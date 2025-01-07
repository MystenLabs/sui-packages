module 0x987ac188c89ebe135005e920a47648e5ce74a389f6e61b2a4294170e82909b03::suibosu {
    struct SUIBOSU has drop {
        dummy_field: bool,
    }

    fun init(arg0: SUIBOSU, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<SUIBOSU>(arg0, 6, b"Suibosu", b"SuiKabosu", b"kabosu", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/suikobsu_01076d702b.jpg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<SUIBOSU>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<SUIBOSU>>(v1);
    }

    // decompiled from Move bytecode v6
}

