module 0xe7793edabc530b469ae4dae1f31d3fd9850d15b8ea8a64761ad6c54d8df9dfcf::pdog {
    struct PDOG has drop {
        dummy_field: bool,
    }

    fun init(arg0: PDOG, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<PDOG>(arg0, 6, b"PDOG", b"PokeDog", b"Socials Coming soon", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://ipfs.io/ipfs/bafybeibi2ajpnl3pxoh2fvljh5kra5ac2hkyqn3pkp5e25cm5kibs2rtoi")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<PDOG>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_transfer<0x2::coin::CoinMetadata<PDOG>>(v1, 0x2::tx_context::sender(arg1));
    }

    // decompiled from Move bytecode v6
}

