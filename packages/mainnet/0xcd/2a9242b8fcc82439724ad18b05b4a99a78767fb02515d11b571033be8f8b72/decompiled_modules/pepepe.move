module 0xcd2a9242b8fcc82439724ad18b05b4a99a78767fb02515d11b571033be8f8b72::pepepe {
    struct PEPEPE has drop {
        dummy_field: bool,
    }

    fun init(arg0: PEPEPE, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<PEPEPE>(arg0, 6, b"PEPEPE", b"PEPEPE ON SUI", b"Hihihi i'mi'mi'm pepepe", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/0xe38babf1e0f7e549f9d4c0441c9d00c8ffc9dcd34dcc19f3bb12eafe0267e037movepump_MOVEPUMP_1_4fca198594.jpg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<PEPEPE>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<PEPEPE>>(v1);
    }

    // decompiled from Move bytecode v6
}

