module 0x5115023f1d22978c6f69aebe7a323fed57694cb5a6b5ecccca66dcc53a57f1c9::shower {
    struct SHOWER has drop {
        dummy_field: bool,
    }

    fun init(arg0: SHOWER, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<SHOWER>(arg0, 6, b"SHOWER", b"SUI SHOWER", x"4974c2b4732074696d6520746f206861766520612073686f77657221", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://ipfs.io/ipfs/bafybeibn6kx76tvegg573cjum4iezt6ahmwxisi2537glklqbj7cfwkahy")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<SHOWER>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_transfer<0x2::coin::CoinMetadata<SHOWER>>(v1, 0x2::tx_context::sender(arg1));
    }

    // decompiled from Move bytecode v6
}

