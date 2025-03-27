module 0x67f5f21fee109b935ddca5d1ca2881e20d3834d957227172b0f78c6a4fc77e78::social {
    struct SOCIAL has drop {
        dummy_field: bool,
    }

    fun init(arg0: SOCIAL, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<SOCIAL>(arg0, 6, b"SOCIAL", b"SOCIAL GROW AI", b"Enabling multi-chain trading, launching and earning tokens all in one place!", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/27e_NR_0o_K_400x400_7f84f1e5d1.jpg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<SOCIAL>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<SOCIAL>>(v1);
    }

    // decompiled from Move bytecode v6
}

