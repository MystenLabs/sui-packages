module 0x3bf917c84eda370200508f27341c3df2f0bb5bd65d93283b4d1e05f2c51643a4::pikai {
    struct PIKAI has drop {
        dummy_field: bool,
    }

    fun init(arg0: PIKAI, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<PIKAI>(arg0, 6, b"PIKAI", b"PikAI Agent on SUI", b"KAI is an AI Agent that grows with its market cap. The more it evolves, the higher its power soars, until it shakes the SUI blockchain.", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://ipfs.io/ipfs/bafkreia2vgs5v3rlqgyqfiewig6mst4j4fanguy3uq42jlcpjzgl5usaee")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<PIKAI>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_transfer<0x2::coin::CoinMetadata<PIKAI>>(v1, 0x2::tx_context::sender(arg1));
    }

    // decompiled from Move bytecode v6
}

