module 0x4f4f6861ebc25eab81b6fef6ed69bfde0862511b2e8aed2b5650d79a15ff2c4e::my_coin {
    struct MY_COIN has drop {
        dummy_field: bool,
    }

    fun init(arg0: MY_COIN, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<MY_COIN>(arg0, 9, b"MYC", b"My Coin", b"This is my coin.", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://s2.coinmarketcap.com/static/img/coins/64x64/20947.png")), arg1);
        let v2 = v0;
        0x2::coin::mint_and_transfer<MY_COIN>(&mut v2, 1000000000000000000, 0x2::tx_context::sender(arg1), arg1);
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<MY_COIN>>(v1);
        0x2::transfer::public_freeze_object<0x2::coin::TreasuryCap<MY_COIN>>(v2);
    }

    // decompiled from Move bytecode v6
}

