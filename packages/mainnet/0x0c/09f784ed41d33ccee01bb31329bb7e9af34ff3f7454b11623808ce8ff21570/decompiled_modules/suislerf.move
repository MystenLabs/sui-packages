module 0xc09f784ed41d33ccee01bb31329bb7e9af34ff3f7454b11623808ce8ff21570::suislerf {
    struct SUISLERF has drop {
        dummy_field: bool,
    }

    fun init(arg0: SUISLERF, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<SUISLERF>(arg0, 6, b"SUISLERF", b"Sui Slerf", b"Hi, Im a Sui Slerf and Im a First Sloth on Movepump.", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/logo_c17784c9e6.png")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<SUISLERF>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<SUISLERF>>(v1);
    }

    // decompiled from Move bytecode v6
}

