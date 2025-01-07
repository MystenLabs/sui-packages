module 0x2f9a12bffac6153e2f98a69a1fbfa4f9a6065de78286005ee5b26b0b8436d5b4::s0sfrancia {
    struct S0SFRANCIA has drop {
        dummy_field: bool,
    }

    fun init(arg0: S0SFRANCIA, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<S0SFRANCIA>(arg0, 6, b"S0SFRANCIA", b"SOSFRANCIA", b"only one goal=FART BIIIG", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/qzt29qc2mehd78y8ooa7ot2odxou_8df694e393.png")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<S0SFRANCIA>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<S0SFRANCIA>>(v1);
    }

    // decompiled from Move bytecode v6
}

