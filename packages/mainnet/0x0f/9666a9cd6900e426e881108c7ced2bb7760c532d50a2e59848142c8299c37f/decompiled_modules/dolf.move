module 0xf9666a9cd6900e426e881108c7ced2bb7760c532d50a2e59848142c8299c37f::dolf {
    struct DOLF has drop {
        dummy_field: bool,
    }

    fun init(arg0: DOLF, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<DOLF>(arg0, 6, b"Dolf", b"BLUE DOLF", b"Dive into ocean, shark $Dolf", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/IMG_3875_43b542107e.jpeg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<DOLF>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<DOLF>>(v1);
    }

    // decompiled from Move bytecode v6
}

