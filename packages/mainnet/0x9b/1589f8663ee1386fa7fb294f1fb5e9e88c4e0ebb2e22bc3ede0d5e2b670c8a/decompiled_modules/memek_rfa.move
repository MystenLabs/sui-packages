module 0x9b1589f8663ee1386fa7fb294f1fb5e9e88c4e0ebb2e22bc3ede0d5e2b670c8a::memek_rfa {
    struct MEMEK_RFA has drop {
        dummy_field: bool,
    }

    fun init(arg0: MEMEK_RFA, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<MEMEK_RFA>(arg0, 6, b"MEMEKRFA", b"", b"", 0x1::option::none<0x2::url::Url>(), arg1);
        let v2 = v0;
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<MEMEK_RFA>>(v1);
        0x2::coin::mint_and_transfer<MEMEK_RFA>(&mut v2, 1000000000000000000, 0x2::tx_context::sender(arg1), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<MEMEK_RFA>>(v2, 0x2::tx_context::sender(arg1));
    }

    // decompiled from Move bytecode v6
}

