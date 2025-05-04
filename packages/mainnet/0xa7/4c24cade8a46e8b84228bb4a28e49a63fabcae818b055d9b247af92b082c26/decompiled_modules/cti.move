module 0xa74c24cade8a46e8b84228bb4a28e49a63fabcae818b055d9b247af92b082c26::cti {
    struct CTI has drop {
        dummy_field: bool,
    }

    fun init(arg0: CTI, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<CTI>(arg0, 6, b"Cti", b"Carti", b"Play boi carti", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://ipfs.io/ipfs/bafybeietb5wrrc37ail4j7ioaoj4mumthsw6qblm4fvkapn3ovsu5jqjca")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<CTI>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_transfer<0x2::coin::CoinMetadata<CTI>>(v1, 0x2::tx_context::sender(arg1));
    }

    // decompiled from Move bytecode v6
}

