module 0x7cf567c18ff82ba20251af3d8680e0b1e717b5a3dd3fa20f829936f57846b22c::my_awesome_coin {
    struct MY_AWESOME_COIN has drop {
        dummy_field: bool,
    }

    fun init(arg0: MY_AWESOME_COIN, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<MY_AWESOME_COIN>(arg0, 9, b"MY_AWESOME_COIN", b"My Awesome Coin", b"", 0x1::option::none<0x2::url::Url>(), arg1);
        let v2 = v0;
        let v3 = 0x2::tx_context::sender(arg1);
        0x2::coin::mint_and_transfer<MY_AWESOME_COIN>(&mut v2, 9999999999000000000, v3, arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<MY_AWESOME_COIN>>(v2, v3);
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<MY_AWESOME_COIN>>(v1);
    }

    // decompiled from Move bytecode v6
}

