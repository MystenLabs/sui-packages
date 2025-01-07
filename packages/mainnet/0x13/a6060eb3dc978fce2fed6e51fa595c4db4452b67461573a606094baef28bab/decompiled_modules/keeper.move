module 0x13a6060eb3dc978fce2fed6e51fa595c4db4452b67461573a606094baef28bab::keeper {
    struct KEEPER has drop {
        dummy_field: bool,
    }

    fun init(arg0: KEEPER, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<KEEPER>(arg0, 9, b"KEEPER", b"KEEPER AI", b"Create, test, and deploy intelligent agents without complexity. Whether you're building a simple chatbot or complex autonomous systems, KEEPER provides the infrastructure you need.", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://ipfs.io/ipfs/QmawdCjCm9zLjW1YgYFQtDCLKWRp2CMTazkX5uWdG3gqoK")), arg1);
        let v2 = v0;
        0x2::coin::mint_and_transfer<KEEPER>(&mut v2, 1000000000000000000, 0x2::tx_context::sender(arg1), arg1);
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<KEEPER>>(v1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<KEEPER>>(v2, 0x2::tx_context::sender(arg1));
    }

    // decompiled from Move bytecode v6
}

