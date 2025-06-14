module 0x55121d4424641e21129fbbb1a3a8564397d6cafeb5c67cb6472cc9ec4d1f6ff::pitwhiz {
    struct PITWHIZ has drop {
        dummy_field: bool,
    }

    fun init(arg0: PITWHIZ, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<PITWHIZ>(arg0, 6, b"PITWHIZ", b"Pit Whiz", b"The pitbull whiz designer", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://ipfs.io/ipfs/bafkreiesue2oehcpfnihwseag35mz5asfbmwlbb2d3wprgqsn4jhlqc6ji")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<PITWHIZ>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_transfer<0x2::coin::CoinMetadata<PITWHIZ>>(v1, 0x2::tx_context::sender(arg1));
    }

    // decompiled from Move bytecode v6
}

