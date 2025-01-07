module 0x656e448879c3be1cd647259c146bd7febff40486f28b04bfb9dbb1d9990142b8::cha {
    struct CHA has drop {
        dummy_field: bool,
    }

    fun init(arg0: CHA, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<CHA>(arg0, 8, b"CHA", b"CHARIZARD", b"charizard is the best pokemon", 0x1::option::none<0x2::url::Url>(), arg1);
        let v2 = v0;
        0x2::coin::mint_and_transfer<CHA>(&mut v2, 10000000000000000, 0x2::tx_context::sender(arg1), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<CHA>>(v2, @0x0);
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<CHA>>(v1);
    }

    // decompiled from Move bytecode v6
}

