module 0xdd2c9f1bc2ade904dcbd0dc03087bd663fe3fe33cee33be040bdb5ec4ec11fa8::lfg {
    struct LFG has drop {
        dummy_field: bool,
    }

    fun init(arg0: LFG, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<LFG>(arg0, 6, b"LFG", b"Lets Fart And Go", x"4a5553542041204755592052554e4e494e472046524f4d204f4345414e20574156452043415553452054484520464152540a4c41554e4348204f4e204d4f4f4e42414753", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://ipfs.io/ipfs/bafkreieivkt5esatkborbzgwugfsy7uoxwzbzhrc4nwawliuatkxjduywa")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<LFG>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_transfer<0x2::coin::CoinMetadata<LFG>>(v1, 0x2::tx_context::sender(arg1));
    }

    // decompiled from Move bytecode v6
}

