module 0xeca52c64dd381e2960a111e038cc51c012e337b2a677a6effa620e7095b0d52f::ufjczcz {
    struct UFJCZCZ has drop {
        dummy_field: bool,
    }

    fun init(arg0: UFJCZCZ, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<UFJCZCZ>(arg0, 0, b"UFJCZCZ", b"Sui Blue Gift User FJCZCZ", b"Sui Blue Gift mainnet user-flow smoke token", 0x1::option::none<0x2::url::Url>(), arg1);
        let v2 = v0;
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<UFJCZCZ>>(v1);
        0x2::transfer::public_transfer<0x2::coin::Coin<UFJCZCZ>>(0x2::coin::mint<UFJCZCZ>(&mut v2, 1000000000000000, arg1), 0x2::tx_context::sender(arg1));
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<UFJCZCZ>>(v2, 0x2::tx_context::sender(arg1));
    }

    // decompiled from Move bytecode v7
}

