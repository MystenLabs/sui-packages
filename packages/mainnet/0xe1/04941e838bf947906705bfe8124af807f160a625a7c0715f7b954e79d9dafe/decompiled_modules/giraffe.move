module 0xe104941e838bf947906705bfe8124af807f160a625a7c0715f7b954e79d9dafe::giraffe {
    struct GIRAFFE has drop {
        dummy_field: bool,
    }

    fun init(arg0: GIRAFFE, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<GIRAFFE>(arg0, 6, b"GIRAFFE", b"Giraffe Sui", b"Always #GIRAFFE", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://ipfs.io/ipfs/bafkreibxob2uodjaaz6y3sapedjobexcqh572237nepl7t2vsjmghpxgjm")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<GIRAFFE>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_transfer<0x2::coin::CoinMetadata<GIRAFFE>>(v1, 0x2::tx_context::sender(arg1));
    }

    // decompiled from Move bytecode v6
}

