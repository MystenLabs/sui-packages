module 0x5fe652794877c5b55e7c0ff6ad8ab9db556f5582f8ab4e1a64bdac2ba27e062c::axolsui {
    struct AXOLSUI has drop {
        dummy_field: bool,
    }

    fun init(arg0: AXOLSUI, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<AXOLSUI>(arg0, 6, b"AXOLSUI", b"AXOL", b"AXOL ARRIVED AT MOVEPUMP", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/imagem_2024_10_12_011503607_62705c5756.png")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<AXOLSUI>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<AXOLSUI>>(v1);
    }

    // decompiled from Move bytecode v6
}

