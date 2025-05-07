module 0x6756aada73c61434b8523d01285bea614967d0a0a1b9b891fa691b578fe3a2b::cune {
    struct CUNE has drop {
        dummy_field: bool,
    }

    fun init(arg0: CUNE, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<CUNE>(arg0, 6, b"Cune", b"Shiny Suicune", x"53756963756e6520656d626f646965732074686520636f6d70617373696f6e206f662061207075726520737072696e67206f662077617465722e2049742072756e73206163726f737320746865206c616e64207769746820677261636566756c6e6573732e205468697320506f6bc3a96d6f6e206861732074686520706f77657220746f207075726966792064697274792077617465722e", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://ipfs.io/ipfs/bafkreiheauuoev4zccfhs7swuaxjomkfbn6qd5js2ad3fe2whff2h7gy3a")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<CUNE>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_transfer<0x2::coin::CoinMetadata<CUNE>>(v1, 0x2::tx_context::sender(arg1));
    }

    // decompiled from Move bytecode v6
}

