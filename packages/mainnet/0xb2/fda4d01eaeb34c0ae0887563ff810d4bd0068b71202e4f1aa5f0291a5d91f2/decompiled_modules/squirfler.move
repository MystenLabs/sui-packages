module 0xb2fda4d01eaeb34c0ae0887563ff810d4bd0068b71202e4f1aa5f0291a5d91f2::squirfler {
    struct SQUIRFLER has drop {
        dummy_field: bool,
    }

    fun init(arg0: SQUIRFLER, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<SQUIRFLER>(arg0, 6, b"Squirfler", b"Squirfler on SUI", b"Inspired by your favorite water Pokmon, SQUIRFLER is a new token on the SUI network. Join our community and dive into a fun and sustainable crypto adventure! Lets make waves together!", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/Diseno_sin_titulo_3_6992d0041f.png")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<SQUIRFLER>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<SQUIRFLER>>(v1);
    }

    // decompiled from Move bytecode v6
}

