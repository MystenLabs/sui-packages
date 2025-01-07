module 0x77ae37d76118b3ee628ca990f3776688b2b700566d13a9391918eaea182a6541::dby {
    struct DBY has drop {
        dummy_field: bool,
    }

    fun init(arg0: DBY, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<DBY>(arg0, 6, b"DBY", b"DINOBYTE ON SUI", x"45766572796f6e652077616e747320746f206f776e207468697320737469636b65722073657420746f2073686f77207468656972206c6f766520666f72207468650a6c6567656e64617279206d6f6e737465722e0a0a2042757420626568696e642074686f7365206c6f76656c7920737469636b65727320697320612073746f72792061626f7574206120706f74656e7469616c206d656d650a636f696e2e22", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/Happy_1_e9ca1b0907.png")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<DBY>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<DBY>>(v1);
    }

    // decompiled from Move bytecode v6
}

