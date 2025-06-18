module 0xb182a5a5cad134e676ced8a5da7dbb8707415dcff1da2c1a2b4cccf77b1acd7::samx {
    struct SAMX has drop {
        dummy_field: bool,
    }

    fun init(arg0: SAMX, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<SAMX>(arg0, 6, b"SAMX", b"Samurai x sui", b"SamuraiX is not just another meme coin. Its a movement inspired by the legendary code of the samurai", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://ipfs.io/ipfs/bafybeicbfntdjcm7mia4bq5rgady64mb4awxikvefmzzzfeuddiddcpkai")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<SAMX>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_transfer<0x2::coin::CoinMetadata<SAMX>>(v1, 0x2::tx_context::sender(arg1));
    }

    // decompiled from Move bytecode v6
}

