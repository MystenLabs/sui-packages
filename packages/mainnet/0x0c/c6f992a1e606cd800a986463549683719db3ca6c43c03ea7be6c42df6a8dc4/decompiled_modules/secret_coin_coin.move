module 0xcc6f992a1e606cd800a986463549683719db3ca6c43c03ea7be6c42df6a8dc4::secret_coin_coin {
    struct SECRET_COIN_COIN has drop {
        dummy_field: bool,
    }

    fun init(arg0: SECRET_COIN_COIN, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<SECRET_COIN_COIN>(arg0, 6, b"Shhh", b"Secret Coin", b"Fixed-supply coin on Sui", 0x1::option::none<0x2::url::Url>(), arg1);
        let v2 = v0;
        0x2::transfer::public_transfer<0x2::coin::Coin<SECRET_COIN_COIN>>(0x2::coin::mint<SECRET_COIN_COIN>(&mut v2, 1000000000000000, arg1), 0x2::tx_context::sender(arg1));
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<SECRET_COIN_COIN>>(v1);
        0x2::transfer::public_freeze_object<0x2::coin::TreasuryCap<SECRET_COIN_COIN>>(v2);
    }

    // decompiled from Move bytecode v6
}

