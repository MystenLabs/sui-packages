module 0xab18e6280127d8a4b70f32fb52bde6f971d6acd993e835e2fe37476097a0e4c::spaced {
    struct SPACED has drop {
        dummy_field: bool,
    }

    fun init(arg0: SPACED, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<SPACED>(arg0, 6, b"SPACED", b"SPACESHIBA", b"SPACE SHIBA", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/ASTEROID_TTQ_9kk_ZDA_Sh_Bp0_Xb0y_1ae2b0545e.jpg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<SPACED>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<SPACED>>(v1);
    }

    // decompiled from Move bytecode v6
}

