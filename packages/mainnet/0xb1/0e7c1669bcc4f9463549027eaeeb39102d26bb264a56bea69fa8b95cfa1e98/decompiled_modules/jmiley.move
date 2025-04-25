module 0xb10e7c1669bcc4f9463549027eaeeb39102d26bb264a56bea69fa8b95cfa1e98::jmiley {
    struct JMILEY has drop {
        dummy_field: bool,
    }

    fun init(arg0: JMILEY, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<JMILEY>(arg0, 6, b"JMILEY", b"JAIL MILEY", b"ARGENTINA PRESIDENT RUGGING MEME COIN FOR PAY LOAN TO ELON MUSK", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://ipfs.io/ipfs/bafkreifmwlv4ny6imlpozx5d5r3rcagv46ypfg7pu5nglobrvfrqqpt5ki")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<JMILEY>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_transfer<0x2::coin::CoinMetadata<JMILEY>>(v1, 0x2::tx_context::sender(arg1));
    }

    // decompiled from Move bytecode v6
}

