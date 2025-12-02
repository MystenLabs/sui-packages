module 0x914e87baac9caa40c75d3f36bf2eba47597628b30793b1b483d89be65e07d63d::poo {
    struct POO has drop {
        dummy_field: bool,
    }

    fun init(arg0: POO, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<POO>(arg0, 6, b"Poo", b"Poo of a viking", b"A poo of viking measuring 20 centimetres (8 in) long and 5 centimetres (2 in) wide dated 9th century", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://ipfs.io/ipfs/bafkreigmnkk4rns7dcmryfuvtehiljlax23a63w43smhc4vxi5srdjdyl4")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<POO>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_transfer<0x2::coin::CoinMetadata<POO>>(v1, 0x2::tx_context::sender(arg1));
    }

    // decompiled from Move bytecode v6
}

