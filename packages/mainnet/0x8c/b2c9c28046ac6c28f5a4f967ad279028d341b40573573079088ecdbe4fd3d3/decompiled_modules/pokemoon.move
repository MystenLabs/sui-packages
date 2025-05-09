module 0x8cb2c9c28046ac6c28f5a4f967ad279028d341b40573573079088ecdbe4fd3d3::pokemoon {
    struct POKEMOON has drop {
        dummy_field: bool,
    }

    fun init(arg0: POKEMOON, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<POKEMOON>(arg0, 6, b"POKEMOON", b"POKEMOON MEME", b"POKEMOON $POKEMOON Catch the Meme, Moon the Gains.", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://ipfs.io/ipfs/bafkreiemi7cjanyyiklbb6uhhju3agjsk6uokpktwu5e3whp322yqlm7yu")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<POKEMOON>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_transfer<0x2::coin::CoinMetadata<POKEMOON>>(v1, 0x2::tx_context::sender(arg1));
    }

    // decompiled from Move bytecode v6
}

