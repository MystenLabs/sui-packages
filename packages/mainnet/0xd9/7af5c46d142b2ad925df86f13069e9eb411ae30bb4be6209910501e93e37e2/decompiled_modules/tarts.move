module 0xd97af5c46d142b2ad925df86f13069e9eb411ae30bb4be6209910501e93e37e2::tarts {
    struct TARTS has drop {
        dummy_field: bool,
    }

    fun init(arg0: TARTS, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<TARTS>(arg0, 6, b"TARTS", b"Sui Tarts", b"The sweetest candy of the 24'-25' bullrun.  ", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/1000050588_9e2c1d6c47.webp")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<TARTS>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<TARTS>>(v1);
    }

    // decompiled from Move bytecode v6
}

