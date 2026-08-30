module 0xae50549a364223612076372e71d3ccd872dc0cda69f2bbc16559deb30f50c8cb::ug8bq16 {
    struct UG8BQ16 has drop {
        dummy_field: bool,
    }

    fun init(arg0: UG8BQ16, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<UG8BQ16>(arg0, 0, b"UG8BQ16", b"Sui Blue Gift User G8BQ16", b"Sui Blue Gift mainnet user-flow smoke token", 0x1::option::none<0x2::url::Url>(), arg1);
        let v2 = v0;
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<UG8BQ16>>(v1);
        0x2::transfer::public_transfer<0x2::coin::Coin<UG8BQ16>>(0x2::coin::mint<UG8BQ16>(&mut v2, 1000000000000000, arg1), 0x2::tx_context::sender(arg1));
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<UG8BQ16>>(v2, 0x2::tx_context::sender(arg1));
    }

    // decompiled from Move bytecode v7
}

