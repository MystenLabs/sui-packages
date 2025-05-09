module 0x7bd673d1b980fc2f1c922f91395c325561a675fc2f349c8ffcff7d03bdbeadc8::boost {
    struct BOOST has drop {
        dummy_field: bool,
    }

    fun init(arg0: BOOST, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<BOOST>(arg0, 6, b"BOOST", b"Sui Booster DAO", x"4669727374204e46542044414f2077697468206d756c7469706c6520746f6f6c73206f6e2077616c727573200a0a737569626f6f737465722e77616c2e6170700a537569536e617073686f742e77616c2e617070", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://ipfs.io/ipfs/bafkreid7k5qk4nafu2jqv52vqm66w6wsiiuxv2hqzcsgb3zh5guhvekgxq")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<BOOST>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_transfer<0x2::coin::CoinMetadata<BOOST>>(v1, 0x2::tx_context::sender(arg1));
    }

    // decompiled from Move bytecode v6
}

