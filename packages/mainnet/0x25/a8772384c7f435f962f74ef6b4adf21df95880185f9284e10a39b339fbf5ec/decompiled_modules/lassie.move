module 0x25a8772384c7f435f962f74ef6b4adf21df95880185f9284e10a39b339fbf5ec::lassie {
    struct LASSIE has drop {
        dummy_field: bool,
    }

    fun init(arg0: LASSIE, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<LASSIE>(arg0, 6, b"LASSIE", b"LASSIESUI", b"lassie SUI", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/7_QM_vv_CF_400x400_9b91ba5be9.jpg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<LASSIE>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<LASSIE>>(v1);
    }

    // decompiled from Move bytecode v6
}

