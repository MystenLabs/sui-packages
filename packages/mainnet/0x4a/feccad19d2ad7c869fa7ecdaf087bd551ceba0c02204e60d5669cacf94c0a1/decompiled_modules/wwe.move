module 0x4afeccad19d2ad7c869fa7ecdaf087bd551ceba0c02204e60d5669cacf94c0a1::wwe {
    struct WWE has drop {
        dummy_field: bool,
    }

    fun init(arg0: WWE, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<WWE>(arg0, 6, b"WWE", b"WE WRESTLE EVERYTHING", b"SUI is our ring, and in it, We Wrestle Everything from hype to FUD, we slam through every challenge in crypto.", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://ipfs.io/ipfs/bafybeibnwbesogsa24pjqzaqspp2oiolamijqgv77mw7i4h4fkohz4wizu")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<WWE>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_transfer<0x2::coin::CoinMetadata<WWE>>(v1, 0x2::tx_context::sender(arg1));
    }

    // decompiled from Move bytecode v6
}

