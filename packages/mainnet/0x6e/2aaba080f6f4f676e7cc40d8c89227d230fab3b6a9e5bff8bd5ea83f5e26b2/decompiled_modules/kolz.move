module 0x6e2aaba080f6f4f676e7cc40d8c89227d230fab3b6a9e5bff8bd5ea83f5e26b2::kolz {
    struct KOLZ has drop {
        dummy_field: bool,
    }

    fun init(arg0: KOLZ, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<KOLZ>(arg0, 6, b"KOLZ", b"KOLZ ON SUI", b"WANNA BE DEV", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://ipfs.io/ipfs/bafkreihiwdvyzfb4irjwy6fttkdrw7xlozmuxs6ows5n57kriwhycq53z4")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<KOLZ>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_transfer<0x2::coin::CoinMetadata<KOLZ>>(v1, 0x2::tx_context::sender(arg1));
    }

    // decompiled from Move bytecode v6
}

