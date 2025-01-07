module 0x81768721207f47d966f1b15328a97977283a5b376262ab08881fa2bdd60b0f7e::a {
    struct A has drop {
        dummy_field: bool,
    }

    fun init(arg0: A, arg1: &mut 0x2::tx_context::TxContext) {
        let v0 = 0x2::tx_context::sender(arg1);
        let (v1, v2) = 0x2::coin::create_currency<A>(arg0, 6, b"A", b"zwyttxs1", b"1", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.suiai.fun/uploads/sols_a6571d4693.png")), arg1);
        0x2::transfer::public_transfer<0x2::coin::CoinMetadata<A>>(v2, v0);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<A>>(v1, v0);
    }

    // decompiled from Move bytecode v6
}

