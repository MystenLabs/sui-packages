module 0x8a50e01682872b03e4c171bd0470f016981092c635fb7447604ed15030082aef::laika {
    struct LAIKA has drop {
        dummy_field: bool,
    }

    fun init(arg0: LAIKA, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<LAIKA>(arg0, 6, b"LAIKA", b"Laika Space Dog", b"Laika is the most famous dog in the world. the first living creature to be sent into space.", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/fi3b8_i_A_400x400_4dd26c4591.png")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<LAIKA>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<LAIKA>>(v1);
    }

    // decompiled from Move bytecode v6
}

