module 0x4d7aca84bd1d6283e0ed783bf5f80d6ffddc8493bf8a238524e0d14c2ac09c6::dt0 {
    struct DT0 has drop {
        dummy_field: bool,
    }

    fun init(arg0: DT0, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<DT0>(arg0, 6, b"DT0", b"DT0", b"", 0x1::option::none<0x2::url::Url>(), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<DT0>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_transfer<0x2::coin::CoinMetadata<DT0>>(v1, 0x2::tx_context::sender(arg1));
    }

    // decompiled from Move bytecode v6
}

