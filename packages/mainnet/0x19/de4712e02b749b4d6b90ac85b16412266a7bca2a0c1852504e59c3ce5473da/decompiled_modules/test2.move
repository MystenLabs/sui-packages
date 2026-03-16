module 0x19de4712e02b749b4d6b90ac85b16412266a7bca2a0c1852504e59c3ce5473da::test2 {
    struct TEST2 has drop {
        dummy_field: bool,
    }

    fun init(arg0: TEST2, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<TEST2>(arg0, 9, b"TEST2", b"Test2", x"546f6173747220747269616c20763220e280942054455354322f53554920436574757320706f6f6c2074657374", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<TEST2>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<TEST2>>(v1);
    }

    // decompiled from Move bytecode v6
}

