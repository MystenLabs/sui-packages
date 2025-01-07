module 0xa0aa3aafe210b360a26b25149dca062defbc00911191e32912caf9ef1e000980::bamala {
    struct BAMALA has drop {
        dummy_field: bool,
    }

    fun init(arg0: BAMALA, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<BAMALA>(arg0, 6, b"BAMALA", b"Bamala", b"$BAMALA for President 2024. Show your support and join TG.", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/Dise_A_o_sin_t_A_tulo_10_2f3fa4f3cb.png")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<BAMALA>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<BAMALA>>(v1);
    }

    // decompiled from Move bytecode v6
}

