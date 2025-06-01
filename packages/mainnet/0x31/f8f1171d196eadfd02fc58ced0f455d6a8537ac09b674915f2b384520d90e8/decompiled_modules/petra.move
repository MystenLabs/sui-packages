module 0x31f8f1171d196eadfd02fc58ced0f455d6a8537ac09b674915f2b384520d90e8::petra {
    struct PETRA has drop {
        dummy_field: bool,
    }

    fun init(arg0: PETRA, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<PETRA>(arg0, 6, b"PETRA", b"Petra man", b"Hot!", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://ipfs.io/ipfs/bafkreiejqvlnha3bhngk7ztsos62owyuzsriczcgkrmunzxvqhufjx7tee")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<PETRA>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_transfer<0x2::coin::CoinMetadata<PETRA>>(v1, 0x2::tx_context::sender(arg1));
    }

    // decompiled from Move bytecode v6
}

