module 0xd6951a509e6f7566ec826d4b48aba6b3ddc9f96dae4fecdd6957437883cb88a5::aigr0k {
    struct AIGR0K has drop {
        dummy_field: bool,
    }

    fun init(arg0: AIGR0K, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<AIGR0K>(arg0, 6, b"AIGR0k", b"AI GR0K", b"AI GROK is AI Inside AI,Super Powered Artificial", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://ipfs.io/ipfs/bafkreigonflznvktms3r3jmbdouzszrkcr7imra3sv3egr6bygudqvja3e")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<AIGR0K>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_transfer<0x2::coin::CoinMetadata<AIGR0K>>(v1, 0x2::tx_context::sender(arg1));
    }

    // decompiled from Move bytecode v6
}

