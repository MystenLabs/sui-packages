module 0xd3affce25eab014825ea99b16017c3bf320fd2bbee6c45848f330bef62cb2149::uhksk9n {
    struct UHKSK9N has drop {
        dummy_field: bool,
    }

    fun init(arg0: UHKSK9N, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<UHKSK9N>(arg0, 0, b"UHKSK9N", b"Sui Blue Gift User HKSK9N", b"Sui Blue Gift mainnet user-flow smoke token", 0x1::option::none<0x2::url::Url>(), arg1);
        let v2 = v0;
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<UHKSK9N>>(v1);
        0x2::transfer::public_transfer<0x2::coin::Coin<UHKSK9N>>(0x2::coin::mint<UHKSK9N>(&mut v2, 1000000000000000, arg1), 0x2::tx_context::sender(arg1));
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<UHKSK9N>>(v2, 0x2::tx_context::sender(arg1));
    }

    // decompiled from Move bytecode v7
}

