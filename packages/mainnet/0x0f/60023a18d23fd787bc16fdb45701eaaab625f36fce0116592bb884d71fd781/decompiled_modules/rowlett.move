module 0xf60023a18d23fd787bc16fdb45701eaaab625f36fce0116592bb884d71fd781::rowlett {
    struct ROWLETT has drop {
        dummy_field: bool,
    }

    fun init(arg0: ROWLETT, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<ROWLETT>(arg0, 6, b"ROWLETT", b"Rowlett Sui", x"526f776c65747420697320612047726173732f466c79696e672d7479706520506f6bc3a96d6f6e2c20526561647920746f20636f6e71756572207468652053756920776174657273", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://ipfs.io/ipfs/bafkreie42oxpsg5xlrb525g6rnzyzd447cuxppehkzhvr577ub5fpkhfoa")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<ROWLETT>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_transfer<0x2::coin::CoinMetadata<ROWLETT>>(v1, 0x2::tx_context::sender(arg1));
    }

    // decompiled from Move bytecode v6
}

