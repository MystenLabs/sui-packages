module 0x5df1a0a76660c28d3b4764474cab14037af660160fa5c8fe9a1082cdd89bdbbb::word {
    struct WORD has drop {
        dummy_field: bool,
    }

    fun init(arg0: WORD, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<WORD>(arg0, 9, b"WORD", b"WORD", b"WORD TOKEN", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"")), arg1);
        let v2 = v0;
        0x2::coin::mint_and_transfer<WORD>(&mut v2, 10000000000000000, 0x2::tx_context::sender(arg1), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<WORD>>(v2, @0x0);
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<WORD>>(v1);
    }

    // decompiled from Move bytecode v6
}

