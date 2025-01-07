module 0x2000435975a46dcde3fa8770098a711e0fc8d0f8c8d131fe1656d26a4bf99acc::hunter {
    struct HUNTER has drop {
        dummy_field: bool,
    }

    fun init(arg0: HUNTER, arg1: &mut 0x2::tx_context::TxContext) {
        let v0 = 0x2::tx_context::sender(arg1);
        let (v1, v2) = 0x2::coin::create_currency<HUNTER>(arg0, 6, b"HUNTER", b"SUI Hunter by SuiAI", b"sui will go to moon. just hold", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.suiai.fun/uploads/cat_765c1563e9.jpg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::CoinMetadata<HUNTER>>(v2, v0);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<HUNTER>>(v1, v0);
    }

    // decompiled from Move bytecode v6
}

