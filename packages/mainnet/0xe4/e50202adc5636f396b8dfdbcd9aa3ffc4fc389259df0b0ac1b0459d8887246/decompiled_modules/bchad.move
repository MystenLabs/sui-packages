module 0xe4e50202adc5636f396b8dfdbcd9aa3ffc4fc389259df0b0ac1b0459d8887246::bchad {
    struct BCHAD has drop {
        dummy_field: bool,
    }

    fun init(arg0: BCHAD, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<BCHAD>(arg0, 6, b"BCHAD", b"BABY CHAD HAS BEEN BORN", b"Baby Chad has come into the world of Chads. From his bloodline of being the greatest to ape. He pursue to be like his father - A CHAD!", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://ipfs.io/ipfs/bafybeig4cucdgj6gqkgvvarv2jzl2axanubeq5tad6cu5s4wugwheugkoa")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<BCHAD>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_transfer<0x2::coin::CoinMetadata<BCHAD>>(v1, 0x2::tx_context::sender(arg1));
    }

    // decompiled from Move bytecode v6
}

