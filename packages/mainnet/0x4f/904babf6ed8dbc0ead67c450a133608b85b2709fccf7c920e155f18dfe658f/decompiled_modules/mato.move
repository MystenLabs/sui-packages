module 0x4f904babf6ed8dbc0ead67c450a133608b85b2709fccf7c920e155f18dfe658f::mato {
    struct MATO has drop {
        dummy_field: bool,
    }

    fun init(arg0: MATO, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<MATO>(arg0, 6, b"MATO", b"Suimato", b"T only tomato on SUI blockchain. Puff puff pass $MATO", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/GZ_3_VEMWIAAD_29x_342f6847ad.jfif")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<MATO>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<MATO>>(v1);
    }

    // decompiled from Move bytecode v6
}

