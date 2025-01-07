module 0xceda788b335ec0a5cb74322445a996dcd1dae7edeb815618d09bca8f886dbc3c::suiala {
    struct SUIALA has drop {
        dummy_field: bool,
    }

    fun init(arg0: SUIALA, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<SUIALA>(arg0, 6, b"SUIALA", b"Suiala", b"A legendary Sui Koala character inspired by Mat Furie's Boy's Club comic. The mascot of SUI", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/Suiala_Logo_8ffe4ec47b.jpg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<SUIALA>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<SUIALA>>(v1);
    }

    // decompiled from Move bytecode v6
}

