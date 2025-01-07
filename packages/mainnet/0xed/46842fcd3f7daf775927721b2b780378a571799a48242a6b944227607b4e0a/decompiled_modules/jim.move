module 0xed46842fcd3f7daf775927721b2b780378a571799a48242a6b944227607b4e0a::jim {
    struct JIM has drop {
        dummy_field: bool,
    }

    fun init(arg0: JIM, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<JIM>(arg0, 6, b"JIM", b"Naked Jim", b"An original memecoin bearing it all on Solana (and beyond).", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe(0x1::ascii::string(b"https://dd.dexscreener.com/ds-data/tokens/solana/jimBqijNp9yZwgMmxFaLECr5rFypPGZQNEqL9YU4UjT.png?size=lg&key=4cfa61"))), arg1);
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<JIM>>(v1);
        let v2 = v0;
        0x2::coin::mint_and_transfer<JIM>(&mut v2, 100000000000000, 0x2::tx_context::sender(arg1), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<JIM>>(v2, @0x0);
    }

    // decompiled from Move bytecode v6
}

