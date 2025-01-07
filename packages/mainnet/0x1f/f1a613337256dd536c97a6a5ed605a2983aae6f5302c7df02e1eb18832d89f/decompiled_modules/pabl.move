module 0x1ff1a613337256dd536c97a6a5ed605a2983aae6f5302c7df02e1eb18832d89f::pabl {
    struct PABL has drop {
        dummy_field: bool,
    }

    fun init(arg0: PABL, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<PABL>(arg0, 6, b"PABL", b"Pablo", b"Say hello to your little friend! Pablo Coin brings the audacious spirit of the legendary Pablo Escobar into the blockchain world. Built on the fast, scalable, and secure Sui Network. Lets bring this coin to 100x. ", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://r.turbos.finance/icon/1734884041704.png")), arg1);
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<PABL>>(v1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<PABL>>(v0, 0x2::tx_context::sender(arg1));
    }

    // decompiled from Move bytecode v6
}

