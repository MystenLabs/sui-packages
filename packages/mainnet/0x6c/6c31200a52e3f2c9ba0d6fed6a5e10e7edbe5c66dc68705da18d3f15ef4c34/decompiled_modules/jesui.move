module 0x6c6c31200a52e3f2c9ba0d6fed6a5e10e7edbe5c66dc68705da18d3f15ef4c34::jesui {
    struct JESUI has drop {
        dummy_field: bool,
    }

    fun init(arg0: JESUI, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<JESUI>(arg0, 6, b"JESUI", b"Jesui", b"Jesui, the god of water has come to Sui to convert all into believers!", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/Dise_A_o_sin_t_A_tulo_3_1a911a0d20.png")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<JESUI>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<JESUI>>(v1);
    }

    // decompiled from Move bytecode v6
}

