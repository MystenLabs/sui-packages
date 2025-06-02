module 0xb531ee067e5ceaf508ae4b4721e3e50c7b5df7e0ef077a81d9bb4f49d981d764::suilly {
    struct SUILLY has drop {
        dummy_field: bool,
    }

    fun init(arg0: SUILLY, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<SUILLY>(arg0, 6, b"Suilly", b"Suilly_Launch", x"5472616e73666f726d696e672074776565747320696e746f20636f696e732e205265706c7920746f20616e792074776565742077697468200a5375696c6c79202b206e616d6520616e64207469636b657220746f206d696e7420796f7572206f776e20636f696e206f6e20737569206e6574776f726b20200a0a202820556e6f6666696369616c20636f6d6d756e697479206c61756e63682073696e6365207375696c6c79206c61756e636820697320612070726f6475637420616e642077696c6c206e6f74206861766520616e7920636f696e20696e20746865206675747572652029", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://ipfs.io/ipfs/bafkreifnelxyzwjkjzxgdhqz7pkg32toc63xu7iwj5nd7q4g6xwwhvyx6m")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<SUILLY>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_transfer<0x2::coin::CoinMetadata<SUILLY>>(v1, 0x2::tx_context::sender(arg1));
    }

    // decompiled from Move bytecode v6
}

