module 0x24fe2b120ed67ea12c52cc9860df089ac89965a1b9a2b6061f5b5f869de5e421::b_test07 {
    struct B_TEST07 has drop {
        dummy_field: bool,
    }

    fun init(arg0: B_TEST07, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<B_TEST07>(arg0, 9, b"bTEST07", b"bToken TEST07", b"STEAMM bToken", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://d29k09wtkr1a3e.cloudfront.net/steamm/STEAMM+bToken.svg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<B_TEST07>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<B_TEST07>>(v1);
    }

    // decompiled from Move bytecode v6
}

