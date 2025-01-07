module 0x250839eb4937b6041ae42f95e011e14c1f77730bb50d9575e486d13e67b93939::suuiii {
    struct SUUIII has drop {
        dummy_field: bool,
    }

    fun init(arg0: SUUIII, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<SUUIII>(arg0, 6, b"SUUIII", b"suuuuiiii", b"SUUUUUUUUUUUUUUUIIIIIIIIIIIIIIIIIII!!", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/suiiiiiiiiiiiiiiiiii_d866ffde85.png")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<SUUIII>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<SUUIII>>(v1);
    }

    // decompiled from Move bytecode v6
}

