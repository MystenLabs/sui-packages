module 0xbb9f9241c366322c92055c091ba5ffad6b67fe7749bea08307979f6a34097188::counter {
    struct HELLO_COIN has drop {
        dummy_field: bool,
    }

    struct TreasuryCapStorage has key {
        id: 0x2::object::UID,
        treasury_cap: 0x2::coin::TreasuryCap<HELLO_COIN>,
    }

    public entry fun create_coin(arg0: &mut 0x2::tx_context::TxContext) {
        let v0 = HELLO_COIN{dummy_field: false};
        let (v1, v2) = 0x2::coin::create_currency<HELLO_COIN>(v0, 9, b"HELLO", b"Hello World Coin", b"A coin for the Hello World project", 0x1::option::none<0x2::url::Url>(), arg0);
        let v3 = TreasuryCapStorage{
            id           : 0x2::object::new(arg0),
            treasury_cap : v1,
        };
        0x2::transfer::share_object<TreasuryCapStorage>(v3);
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<HELLO_COIN>>(v2);
    }

    // decompiled from Move bytecode v6
}

