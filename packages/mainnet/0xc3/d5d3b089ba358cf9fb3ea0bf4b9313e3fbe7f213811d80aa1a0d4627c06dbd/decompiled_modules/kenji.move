module 0xc3d5d3b089ba358cf9fb3ea0bf4b9313e3fbe7f213811d80aa1a0d4627c06dbd::kenji {
    struct KENJI has drop {
        dummy_field: bool,
    }

    fun init(arg0: KENJI, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<KENJI>(arg0, 6, b"KENJI", b"KENJISUI", b"Rocket is being fueled up  Dont fade the Alpha", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/6_Ya_Bg_A_N_400x400_b81c05a1db.jpg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<KENJI>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<KENJI>>(v1);
    }

    // decompiled from Move bytecode v6
}

