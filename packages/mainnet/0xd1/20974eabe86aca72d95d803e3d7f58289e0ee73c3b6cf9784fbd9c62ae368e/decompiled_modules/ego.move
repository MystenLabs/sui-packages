module 0xd120974eabe86aca72d95d803e3d7f58289e0ee73c3b6cf9784fbd9c62ae368e::ego {
    struct EGO has drop {
        dummy_field: bool,
    }

    fun init(arg0: EGO, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<EGO>(arg0, 6, b"EGO", b"Sui EGO", b"hope you not missing $EGO anons", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/EGO_1_22e8c169c9.jpeg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<EGO>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<EGO>>(v1);
    }

    // decompiled from Move bytecode v6
}

