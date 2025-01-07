module 0x3bf41df0034bccb1f7f98c8fb3a0e0ef546253703d493e6514d26701a45dca4::timmy {
    struct TIMMY has drop {
        dummy_field: bool,
    }

    fun init(arg0: TIMMY, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<TIMMY>(arg0, 6, b"TIMMY", b"TIMMY!", b"TIMMY, TIMMY ?!? TIMMY !!!", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/Captura_de_Tela_2024_10_15_a_I_s_10_19_59_ef299bf460.png")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<TIMMY>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<TIMMY>>(v1);
    }

    // decompiled from Move bytecode v6
}

