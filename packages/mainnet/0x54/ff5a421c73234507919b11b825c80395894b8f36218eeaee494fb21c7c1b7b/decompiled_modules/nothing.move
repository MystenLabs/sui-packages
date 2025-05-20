module 0x54ff5a421c73234507919b11b825c80395894b8f36218eeaee494fb21c7c1b7b::nothing {
    struct NOTHING has drop {
        dummy_field: bool,
    }

    fun init(arg0: NOTHING, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<NOTHING>(arg0, 6, b"Nothing", b"Just a nothing name", b"Doing nothing", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://ipfs.io/ipfs/bafkreie2pei4yhctpay6ra4qzjbpoizwdwhy5uukqpi3ysrlstajdw556i")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<NOTHING>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_transfer<0x2::coin::CoinMetadata<NOTHING>>(v1, 0x2::tx_context::sender(arg1));
    }

    // decompiled from Move bytecode v6
}

