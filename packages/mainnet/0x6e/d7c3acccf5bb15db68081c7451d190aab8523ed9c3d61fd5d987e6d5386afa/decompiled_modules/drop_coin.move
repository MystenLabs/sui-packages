module 0x6ed7c3acccf5bb15db68081c7451d190aab8523ed9c3d61fd5d987e6d5386afa::drop_coin {
    struct DROP_COIN has drop {
        dummy_field: bool,
    }

    fun init(arg0: DROP_COIN, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<DROP_COIN>(arg0, 3, b"DROP", b"DropCoin", b"DropCoin - by dropsoft.org", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://dropsoft.org/coin.png")), arg1);
        let v2 = v0;
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<DROP_COIN>>(v1);
        0x2::coin::mint_and_transfer<DROP_COIN>(&mut v2, 100000000000, 0x2::tx_context::sender(arg1), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<DROP_COIN>>(v2, 0x2::tx_context::sender(arg1));
    }

    // decompiled from Move bytecode v6
}

