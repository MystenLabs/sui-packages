module 0x3fbfe5c6166882d42dd528fcbde1d2ce33e919dc48bdbad019bbd4cc53e4759c::niga {
    struct NIGA has drop {
        dummy_field: bool,
    }

    fun init(arg0: NIGA, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<NIGA>(arg0, 6, b"NIGA", b"Nigachu", b"nigachusui", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://ipfs.io/ipfs/bafybeihl3dsmivek6drypqnj6n2rorss5ewtysred2rikl4u7lx7pitkvi")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<NIGA>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_transfer<0x2::coin::CoinMetadata<NIGA>>(v1, 0x2::tx_context::sender(arg1));
    }

    // decompiled from Move bytecode v6
}

