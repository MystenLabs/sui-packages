module 0x36462c678cc6c97e7810b04c53b6d0f07dacb17f1774c1d97c4b9dab9fdede4a::csplo {
    struct CSPLO has drop {
        dummy_field: bool,
    }

    fun init(arg0: CSPLO, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<CSPLO>(arg0, 6, b"CSPLO", b"SPLOCTO", b"SPLO CTO", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/Jd_U_Fof_Q6_400x400_7c823a5ea5.jpg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<CSPLO>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<CSPLO>>(v1);
    }

    // decompiled from Move bytecode v6
}

