module 0xc4e2f27581ac9ca7b26ecc5dd392ae857039979883113f072ce878db84de5789::lala {
    struct LALA has drop {
        dummy_field: bool,
    }

    fun init(arg0: LALA, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<LALA>(arg0, 2, b"Lala", b"Lala", b"Lala memecoin", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://s2.coinmarketcap.com/static/img/coins/64x64/2582.png")), arg1);
        let v2 = v0;
        0x2::coin::mint_and_transfer<LALA>(&mut v2, 50000000000000, 0x2::tx_context::sender(arg1), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<LALA>>(v2, @0x0);
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<LALA>>(v1);
    }

    // decompiled from Move bytecode v6
}

