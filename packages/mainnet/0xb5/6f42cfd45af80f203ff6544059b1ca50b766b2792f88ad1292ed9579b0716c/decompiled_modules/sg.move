module 0xb56f42cfd45af80f203ff6544059b1ca50b766b2792f88ad1292ed9579b0716c::sg {
    struct SG has drop {
        dummy_field: bool,
    }

    fun init(arg0: SG, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<SG>(arg0, 6, b"SG", b"SUIGROW", b"Suigrow rides the SUI wave as Uptober approaches, fueling a massive pump to new highs!", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/logo_f3bc05e82a.jpg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<SG>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<SG>>(v1);
    }

    // decompiled from Move bytecode v6
}

