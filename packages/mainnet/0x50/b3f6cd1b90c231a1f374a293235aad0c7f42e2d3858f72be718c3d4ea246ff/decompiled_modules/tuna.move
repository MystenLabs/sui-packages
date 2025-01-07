module 0x50b3f6cd1b90c231a1f374a293235aad0c7f42e2d3858f72be718c3d4ea246ff::tuna {
    struct TUNA has drop {
        dummy_field: bool,
    }

    fun init(arg0: TUNA, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<TUNA>(arg0, 6, b"TUNA", b"Tuna Turner", b"Tuna Turner commands the waves with her captivating voice and unstoppable energy. Her mesmerizing performances transform the ocean into her stage, leaving everyone in awe.", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/tuna_1210f3439d.jpg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<TUNA>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<TUNA>>(v1);
    }

    // decompiled from Move bytecode v6
}

