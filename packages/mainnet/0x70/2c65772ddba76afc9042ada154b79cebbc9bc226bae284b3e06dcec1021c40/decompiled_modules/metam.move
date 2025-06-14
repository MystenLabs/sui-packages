module 0x702c65772ddba76afc9042ada154b79cebbc9bc226bae284b3e06dcec1021c40::metam {
    struct METAM has drop {
        dummy_field: bool,
    }

    fun init(arg0: METAM, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<METAM>(arg0, 6, b"METAM", b"meta monster", b"meta monster the SUI pokemon revolution starts now", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://ipfs.io/ipfs/bafkreihjfnaa4svy3tf4t3vizzrkzyvmjpzqbkejdqnz3ziy7dpiiag5qu")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<METAM>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_transfer<0x2::coin::CoinMetadata<METAM>>(v1, 0x2::tx_context::sender(arg1));
    }

    // decompiled from Move bytecode v6
}

