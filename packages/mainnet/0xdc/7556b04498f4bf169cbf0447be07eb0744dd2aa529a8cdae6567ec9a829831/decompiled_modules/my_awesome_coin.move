module 0xdc7556b04498f4bf169cbf0447be07eb0744dd2aa529a8cdae6567ec9a829831::my_awesome_coin {
    struct MY_AWESOME_COIN has drop {
        dummy_field: bool,
    }

    fun init(arg0: MY_AWESOME_COIN, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<MY_AWESOME_COIN>(arg0, 9, b"MY_AWESOME_COIN", b"My Awesome Coin", b"", 0x1::option::none<0x2::url::Url>(), arg1);
        let v2 = v0;
        0x2::coin::mint_and_transfer<MY_AWESOME_COIN>(&mut v2, 1000000000000000, 0x2::tx_context::sender(arg1), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<MY_AWESOME_COIN>>(v2, @0x0);
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<MY_AWESOME_COIN>>(v1);
    }

    // decompiled from Move bytecode v6
}

