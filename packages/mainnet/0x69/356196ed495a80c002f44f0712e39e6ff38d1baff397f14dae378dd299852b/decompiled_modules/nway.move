module 0x69356196ed495a80c002f44f0712e39e6ff38d1baff397f14dae378dd299852b::nway {
    struct NWAY has drop {
        dummy_field: bool,
    }

    fun init(arg0: NWAY, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<NWAY>(arg0, 6, b"NWAY", b"NWAY ON SUI", b"Beliver Yawn Never Walk Alone", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/yawn_993483b358.jpeg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<NWAY>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<NWAY>>(v1);
    }

    // decompiled from Move bytecode v6
}

