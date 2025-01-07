module 0x5efd90e0eaee43ad6482150da8a613e51bb542aedec28114782448d6b57618e2::lala {
    struct LALA has drop {
        dummy_field: bool,
    }

    fun init(arg0: LALA, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<LALA>(arg0, 6, b"LALA", b"Lala On Sui", b"Lala now boarding on Sui Network", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/lalalala_311b3ceabe.png")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<LALA>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<LALA>>(v1);
    }

    // decompiled from Move bytecode v6
}

