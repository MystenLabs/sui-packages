module 0x6f800c57dc23c8040deda2190678ed0c12ee8037a6fba23bcd6b9b20b3fd9293::umbre {
    struct UMBRE has drop {
        dummy_field: bool,
    }

    fun init(arg0: UMBRE, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<UMBRE>(arg0, 6, b"UMBRE", b"Umbreon", b"In the Pokemon universe UMBREON is a Pokemon that is super loved by the community and on SUI it has become the main meme on the network.", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://ipfs.io/ipfs/bafybeihp2xazqir7ql43cv34jtfjmsx7cduhiau3uh7zm4mxfglpoy27p4")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<UMBRE>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_transfer<0x2::coin::CoinMetadata<UMBRE>>(v1, 0x2::tx_context::sender(arg1));
    }

    // decompiled from Move bytecode v6
}

