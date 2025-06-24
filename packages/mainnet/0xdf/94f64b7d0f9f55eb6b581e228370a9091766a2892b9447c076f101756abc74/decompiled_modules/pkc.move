module 0xdf94f64b7d0f9f55eb6b581e228370a9091766a2892b9447c076f101756abc74::pkc {
    struct PKC has drop {
        dummy_field: bool,
    }

    fun init(arg0: PKC, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<PKC>(arg0, 6, b"PKC", b"PIKACHU", b"Pika Pika Chu", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://ipfs.io/ipfs/bafkreiej5glubk3oqm2z4smy7nktb3jdi272w5t2uwde6xz5yawrldtrwu")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<PKC>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_transfer<0x2::coin::CoinMetadata<PKC>>(v1, 0x2::tx_context::sender(arg1));
    }

    // decompiled from Move bytecode v6
}

