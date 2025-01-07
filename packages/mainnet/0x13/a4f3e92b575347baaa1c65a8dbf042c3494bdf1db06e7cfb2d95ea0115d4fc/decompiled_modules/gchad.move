module 0x13a4f3e92b575347baaa1c65a8dbf042c3494bdf1db06e7cfb2d95ea0115d4fc::gchad {
    struct GCHAD has drop {
        dummy_field: bool,
    }

    fun init(arg0: GCHAD, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<GCHAD>(arg0, 6, b"GCHAD", b"Giga Chad", x"476967612043686164206172726976656420746f205375692e0a4c657473207370616e6b20736f6d652073686974746572730a", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/Y1x_C_Ikwo_400x400_a15f56dea2.jpg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<GCHAD>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<GCHAD>>(v1);
    }

    // decompiled from Move bytecode v6
}

