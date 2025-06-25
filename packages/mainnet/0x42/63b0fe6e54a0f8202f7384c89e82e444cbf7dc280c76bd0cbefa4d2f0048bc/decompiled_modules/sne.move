module 0x4263b0fe6e54a0f8202f7384c89e82e444cbf7dc280c76bd0cbefa4d2f0048bc::sne {
    struct SNE has drop {
        dummy_field: bool,
    }

    fun init(arg0: SNE, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<SNE>(arg0, 6, b"SNE", b"SUI NIGERIA EDUCATION", b"SUI NIGERIA EDUCATION blue", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://ipfs.io/ipfs/bafkreictlqdxbjkb5ihs44yqp3kpwc4ib5rvtwb7j6c6mr3fkhttllro7q")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<SNE>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_transfer<0x2::coin::CoinMetadata<SNE>>(v1, 0x2::tx_context::sender(arg1));
    }

    // decompiled from Move bytecode v6
}

