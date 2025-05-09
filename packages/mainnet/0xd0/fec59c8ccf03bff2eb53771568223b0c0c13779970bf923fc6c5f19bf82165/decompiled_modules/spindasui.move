module 0xd0fec59c8ccf03bff2eb53771568223b0c0c13779970bf923fc6c5f19bf82165::spindasui {
    struct SPINDASUI has drop {
        dummy_field: bool,
    }

    fun init(arg0: SPINDASUI, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<SPINDASUI>(arg0, 6, b"SPINDASUI", b"SPINDA on SUI", b"Spinda stan  | Drunk on Sui chain", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://ipfs.io/ipfs/bafkreibp26ibysbyt34jlaq7x7qrpz255dy3fuaoqjfcrikk7owj2snmfm")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<SPINDASUI>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_transfer<0x2::coin::CoinMetadata<SPINDASUI>>(v1, 0x2::tx_context::sender(arg1));
    }

    // decompiled from Move bytecode v6
}

