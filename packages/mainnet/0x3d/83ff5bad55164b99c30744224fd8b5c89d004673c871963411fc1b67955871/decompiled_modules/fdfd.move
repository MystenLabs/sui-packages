module 0x3d83ff5bad55164b99c30744224fd8b5c89d004673c871963411fc1b67955871::fdfd {
    struct FDFD has drop {
        dummy_field: bool,
    }

    fun init(arg0: FDFD, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<FDFD>(arg0, 6, b"FDFD", b"sdfxc", b"sdfdscv", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://ipfs.io/ipfs/bafkreihjfnaa4svy3tf4t3vizzrkzyvmjpzqbkejdqnz3ziy7dpiiag5qu")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<FDFD>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_transfer<0x2::coin::CoinMetadata<FDFD>>(v1, 0x2::tx_context::sender(arg1));
    }

    // decompiled from Move bytecode v6
}

