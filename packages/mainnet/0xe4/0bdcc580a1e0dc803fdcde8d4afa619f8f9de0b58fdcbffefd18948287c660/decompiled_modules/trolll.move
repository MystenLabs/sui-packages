module 0xe40bdcc580a1e0dc803fdcde8d4afa619f8f9de0b58fdcbffefd18948287c660::trolll {
    struct TROLLL has drop {
        dummy_field: bool,
    }

    fun init(arg0: TROLLL, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<TROLLL>(arg0, 6, b"TROLLL", b"TROLL", b"Elon troll", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://ipfs.io/ipfs/bafkreihvhpfghxq43qfg5ukqlsl7tk735xhhygjpgpbvtjkvcpkceipv3m")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<TROLLL>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_transfer<0x2::coin::CoinMetadata<TROLLL>>(v1, 0x2::tx_context::sender(arg1));
    }

    // decompiled from Move bytecode v6
}

