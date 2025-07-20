module 0x1ac7cef5c82a42c32a93bfaa82c867ad2edc93691091d7576cd2e932c5227bac::feathers {
    struct FEATHERS has drop {
        dummy_field: bool,
    }

    fun init(arg0: FEATHERS, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<FEATHERS>(arg0, 6, b"FEATHERS", b"Feathers On Sui", x"4645415448455253204f4e20535549200a496e7370697265642062792074686520554b7320686974205456207365726965732057616c6c61636520616e642067726f6d69740a0a46656174686572732069732061206372696d696e616c206d61737465726d696e6420776974682067656e69757320666f7220656c61626f7261746520706c616e7320616e6420756e7265636f676e697361626c652064697367756973652e0a0a4a6f696e20746865206665617468657273206d697373696f6e", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://ipfs.io/ipfs/bafkreiavpct5yrcvke6p3cff2ktycmmgb5m3pjqznlnemna2glg52icdju")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<FEATHERS>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_transfer<0x2::coin::CoinMetadata<FEATHERS>>(v1, 0x2::tx_context::sender(arg1));
    }

    // decompiled from Move bytecode v6
}

