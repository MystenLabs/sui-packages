module 0x705c6e3fcb1326fb826275529032c96481941df214d74c2cc5f8056eaaf0c104::blinkey {
    struct BLINKEY has drop {
        dummy_field: bool,
    }

    fun init(arg0: BLINKEY, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<BLINKEY>(arg0, 6, b"Blinkey", b"Blinkey Dog", b"This cheerful  Blinkey is here to greet you with wagging joy and a heart full of happiness!", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://ipfs.io/ipfs/bafybeic7ip7frjvdv646fh3aqja55dr5qubdxjvygdycsfya3ivsxul6s4")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<BLINKEY>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_transfer<0x2::coin::CoinMetadata<BLINKEY>>(v1, 0x2::tx_context::sender(arg1));
    }

    // decompiled from Move bytecode v6
}

