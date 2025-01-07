module 0x6544bf802a9238d5c687afad1cb7f5815fc5c86bb0ce2a1c51506594db732233::suirtle {
    struct SUIRTLE has drop {
        dummy_field: bool,
    }

    fun init(arg0: SUIRTLE, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<SUIRTLE>(arg0, 6, b"SUIRTLE", b"suirtle", b"Suirtle is landing on Sui to become the number one mascot!", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/suirtle_74763b7502.jpg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<SUIRTLE>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<SUIRTLE>>(v1);
    }

    // decompiled from Move bytecode v6
}

