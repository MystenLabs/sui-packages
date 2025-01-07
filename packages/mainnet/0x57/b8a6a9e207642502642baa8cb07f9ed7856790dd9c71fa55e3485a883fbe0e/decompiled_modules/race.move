module 0x57b8a6a9e207642502642baa8cb07f9ed7856790dd9c71fa55e3485a883fbe0e::race {
    struct RACE has drop {
        dummy_field: bool,
    }

    fun init(arg0: RACE, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<RACE>(arg0, 6, b"RACE", b"Racer", x"4c657427732052616365207769746820547572626f0a77652077696c6c2062652074686520526163696e67204b696e670a0a6c65742773207261636520746f6765746865720a0a536f6369616c732077696c6c2075706461746520736f6f6e", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://r.turbos.finance/icon/1730953762380.jpg")), arg1);
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<RACE>>(v1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<RACE>>(v0, 0x2::tx_context::sender(arg1));
    }

    // decompiled from Move bytecode v6
}

