module 0xbbdd625e105d73b1f1de456f79311b7cff890416ee2cea0185c1d1f322834ff9::hopium {
    struct HOPIUM has drop {
        dummy_field: bool,
    }

    fun init(arg0: HOPIUM, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<HOPIUM>(arg0, 6, b"HOPIUM", b"Hopium", b"Hopium Coin is the ultimate memecoin for those who cling to hope, even in the bleakest market conditions. It's the currency for the optimistic few who hold on, ignoring the red candles, fueled by blind faith and memes.", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://r.turbos.finance/icon/1730957744948.jpeg")), arg1);
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<HOPIUM>>(v1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<HOPIUM>>(v0, 0x2::tx_context::sender(arg1));
    }

    // decompiled from Move bytecode v6
}

