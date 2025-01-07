module 0x763caf00ee2f0e643cc5e1f94db044c4fe191043b0f41d6bf1311b22d4b7b2fb::supsui {
    struct SUPSUI has drop {
        dummy_field: bool,
    }

    fun init(arg0: SUPSUI, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<SUPSUI>(arg0, 6, b"SUPSUI", b"$UPER$UI", b"$UPERSUI: For super gains and power moves, go with SuperSUI!", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/da3ce981_c2b6_479c_98f7_397dda8078ba_06c9126d2d.jpg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<SUPSUI>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<SUPSUI>>(v1);
    }

    // decompiled from Move bytecode v6
}

