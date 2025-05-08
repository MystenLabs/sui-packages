module 0x43632ac75e15a510601c09928a9b13049865385c0b6163bcd71501c57ab17f5e::suimander {
    struct SUIMANDER has drop {
        dummy_field: bool,
    }

    fun init(arg0: SUIMANDER, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<SUIMANDER>(arg0, 6, b"SUIMANDER", b"Suimander Cry Pokemon", b"$SUIMANDER IS THE FIRST DRAGON POKEMON MEME ON SUI", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://ipfs.io/ipfs/bafkreig73xz645dfeoqpmtmhtzvhgxgshoef2u256kuanhd7nkwl4skhma")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<SUIMANDER>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_transfer<0x2::coin::CoinMetadata<SUIMANDER>>(v1, 0x2::tx_context::sender(arg1));
    }

    // decompiled from Move bytecode v6
}

