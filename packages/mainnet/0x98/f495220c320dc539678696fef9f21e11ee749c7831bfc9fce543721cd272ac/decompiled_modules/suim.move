module 0x98f495220c320dc539678696fef9f21e11ee749c7831bfc9fce543721cd272ac::suim {
    struct SUIM has drop {
        dummy_field: bool,
    }

    fun init(arg0: SUIM, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<SUIM>(arg0, 6, b"SUIM", b"SUIMURAI", b"The only true and last Suimurai of Japan still alive. Yes, he's black, but that's because we live in an interconnected world, which makes his role as a Suimurai less noticeable.", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"http://movepump.xyz/uploads/mikael_andersson_mikaelandersson_blade_10_b61e06b5a3.jpg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<SUIM>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<SUIM>>(v1);
    }

    // decompiled from Move bytecode v6
}

