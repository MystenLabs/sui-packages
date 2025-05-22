module 0x3a821a6eb21ff8c327d4ae04d467eedf348eb77b1f28579d50aeeb590b62e461::moow {
    struct MOOW has drop {
        dummy_field: bool,
    }

    fun init(arg0: MOOW, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<MOOW>(arg0, 6, b"Moow", b"Moowhale", b"THE BIGGEST WHALE ON SUI", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://ipfs.io/ipfs/bafkreibueb7ufrj5s674rsp5okflx66c74bhis77yr23pdr5mfgu4lam2q")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<MOOW>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_transfer<0x2::coin::CoinMetadata<MOOW>>(v1, 0x2::tx_context::sender(arg1));
    }

    // decompiled from Move bytecode v6
}

