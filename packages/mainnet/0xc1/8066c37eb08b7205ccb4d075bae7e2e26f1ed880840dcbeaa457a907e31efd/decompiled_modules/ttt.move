module 0xc18066c37eb08b7205ccb4d075bae7e2e26f1ed880840dcbeaa457a907e31efd::ttt {
    struct TTT has drop {
        dummy_field: bool,
    }

    fun init(arg0: TTT, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<TTT>(arg0, 6, b"TTT", b"testoingks", b"ttt", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/maxresdefault_6e2fc9953a.jpg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<TTT>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<TTT>>(v1);
    }

    // decompiled from Move bytecode v6
}

