module 0x9e973e985aa432d5018b1d117062bd90cb08e91a536ebfee300bebc5ad073566::sea {
    struct SEA has drop {
        dummy_field: bool,
    }

    fun init(arg0: SEA, arg1: &mut 0x2::tx_context::TxContext) {
        let v0 = 0x2::tx_context::sender(arg1);
        let (v1, v2) = 0x2::coin::create_currency<SEA>(arg0, 6, b"SEA", b"SEA3PO by SuiAI", b" He is a protocol Agent designed to assist in etiquette and translation, and is fluent in over six million forms of communication. crypto and blockchain expert sea3po always is looking to find the best low cap gems to bring back and relay the information to us. ", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.suiai.fun/uploads/Screenshot_20250111_155034_Google_1_0863dddf88.jpg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::CoinMetadata<SEA>>(v2, v0);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<SEA>>(v1, v0);
    }

    // decompiled from Move bytecode v6
}

