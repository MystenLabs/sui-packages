module 0xc2c2addbdfba72538910f8f96b31c2b942ec129dd5ac14c15b145349d849644b::suivenir {
    struct SUIVENIR has drop {
        dummy_field: bool,
    }

    fun init(arg0: SUIVENIR, arg1: &mut 0x2::tx_context::TxContext) {
        let v0 = 0x2::tx_context::sender(arg1);
        let (v1, v2) = 0x2::coin::create_currency<SUIVENIR>(arg0, 6, b"SUIVENIR", b"Suivenir", b"Suivenir for everyone in 2025! Make Suivenirs great!", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.suiai.fun/uploads/ai_therium_2_a8b8204ed0.png")), arg1);
        0x2::transfer::public_transfer<0x2::coin::CoinMetadata<SUIVENIR>>(v2, v0);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<SUIVENIR>>(v1, v0);
    }

    // decompiled from Move bytecode v6
}

