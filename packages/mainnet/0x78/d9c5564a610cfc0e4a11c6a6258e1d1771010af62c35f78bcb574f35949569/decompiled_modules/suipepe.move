module 0x78d9c5564a610cfc0e4a11c6a6258e1d1771010af62c35f78bcb574f35949569::suipepe {
    struct SUIPEPE has drop {
        dummy_field: bool,
    }

    fun init(arg0: SUIPEPE, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<SUIPEPE>(arg0, 6, b"SUIPEPE", b"Sui Pepe", b"The most famous frog in meme history has arrived on Sui. Sui Pepe is here to bring the same degen energy and meme magic to the Sui network.", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/suipepelogo_07685ec788.png")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<SUIPEPE>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<SUIPEPE>>(v1);
    }

    // decompiled from Move bytecode v6
}

