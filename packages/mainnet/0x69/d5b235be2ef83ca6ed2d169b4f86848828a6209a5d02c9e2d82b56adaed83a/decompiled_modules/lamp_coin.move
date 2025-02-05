module 0x69d5b235be2ef83ca6ed2d169b4f86848828a6209a5d02c9e2d82b56adaed83a::lamp_coin {
    struct LAMP_COIN has drop {
        dummy_field: bool,
    }

    fun init(arg0: LAMP_COIN, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<LAMP_COIN>(arg0, 9, b"Lamp Coin", b"Lamp Coin", b"Lamp coin si the best memecoin built on Sui network", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://images.app.goo.gl/Pmuo7Y994DQ6NtVJ6")), arg1);
        let v2 = v0;
        0x2::coin::mint_and_transfer<LAMP_COIN>(&mut v2, 1000000000000000000, 0x2::tx_context::sender(arg1), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<LAMP_COIN>>(v2, @0x0);
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<LAMP_COIN>>(v1);
    }

    // decompiled from Move bytecode v6
}

