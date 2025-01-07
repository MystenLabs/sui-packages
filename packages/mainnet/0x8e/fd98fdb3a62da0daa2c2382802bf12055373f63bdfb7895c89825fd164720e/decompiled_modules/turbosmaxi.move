module 0x8efd98fdb3a62da0daa2c2382802bf12055373f63bdfb7895c89825fd164720e::turbosmaxi {
    struct TURBOSMAXI has drop {
        dummy_field: bool,
    }

    fun init(arg0: TURBOSMAXI, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<TURBOSMAXI>(arg0, 6, b"TURBOSMAXI", b"TurbosMaxi", b"Probably nothing~", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://r.turbos.finance/icon/1730966035537.jpg")), arg1);
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<TURBOSMAXI>>(v1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<TURBOSMAXI>>(v0, 0x2::tx_context::sender(arg1));
    }

    // decompiled from Move bytecode v6
}

