module 0x96d80c6bb01bc909aaf0d2c4d0fb6167142e41680968fc2bf71f9d28d8840886::parchi {
    struct PARCHI has drop {
        dummy_field: bool,
    }

    fun init(arg0: PARCHI, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<PARCHI>(arg0, 6, b"PARCHI", b"Parchi On SUI", b"PARCHI: P2E gaming on SUI|Tournaments| Strategic Gameplay", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/t_U_Ief_Pc5_400x400_1c75dfa184.jpg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<PARCHI>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<PARCHI>>(v1);
    }

    // decompiled from Move bytecode v6
}

