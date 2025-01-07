module 0x7876c96e9a428c1008c1557fec790c714c39f5426a566c19d1075228c85fa049::pep {
    struct PEP has drop {
        dummy_field: bool,
    }

    fun init(arg0: PEP, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<PEP>(arg0, 6, b"PEP", b"PEPSUI", b"\"Pepsui: Pop of Flavor, Sui-per Refreshing!\"", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/PEP_ca20dd7ccc.jpg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<PEP>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<PEP>>(v1);
    }

    // decompiled from Move bytecode v6
}

