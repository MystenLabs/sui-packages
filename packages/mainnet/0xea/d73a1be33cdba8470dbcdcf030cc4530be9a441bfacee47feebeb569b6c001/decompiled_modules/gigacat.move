module 0xead73a1be33cdba8470dbcdcf030cc4530be9a441bfacee47feebeb569b6c001::gigacat {
    struct GIGACAT has drop {
        dummy_field: bool,
    }

    fun init(arg0: GIGACAT, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<GIGACAT>(arg0, 6, b"GIGACAT", b"GigaCat", b"Gigacat envisions a world where strength meets sophistication, where cats are more than just cute - they`re powerful. We aim to buid a community that embodies the spirit of the GIGCATT: resilient, confident, and always ahead of the curve. Our goal is t not only be a top meme coin on Sui but to create a lasting legay tha redefines what it means to be a meme coin. ", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/a_a_ae_a_2024_10_06_171031_8ae1a9290f.png")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<GIGACAT>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<GIGACAT>>(v1);
    }

    // decompiled from Move bytecode v6
}

