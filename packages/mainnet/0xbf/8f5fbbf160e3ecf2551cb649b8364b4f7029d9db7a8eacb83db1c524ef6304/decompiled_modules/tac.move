module 0xbf8f5fbbf160e3ecf2551cb649b8364b4f7029d9db7a8eacb83db1c524ef6304::tac {
    struct TAC has drop {
        dummy_field: bool,
    }

    fun init(arg0: TAC, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<TAC>(arg0, 9, b"TAC", b"Tac", b"Tac Token", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"")), arg1);
        let v2 = v0;
        0x2::coin::mint_and_transfer<TAC>(&mut v2, 1000000000000000000, 0x2::tx_context::sender(arg1), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<TAC>>(v2, @0x0);
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<TAC>>(v1);
    }

    // decompiled from Move bytecode v6
}

