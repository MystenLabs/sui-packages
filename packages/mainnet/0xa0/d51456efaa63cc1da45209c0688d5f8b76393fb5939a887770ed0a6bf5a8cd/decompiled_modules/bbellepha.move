module 0xa0d51456efaa63cc1da45209c0688d5f8b76393fb5939a887770ed0a6bf5a8cd::bbellepha {
    struct BBELLEPHA has drop {
        dummy_field: bool,
    }

    fun init(arg0: BBELLEPHA, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<BBELLEPHA>(arg0, 6, b"Bbellepha", b"baby ellephant", b"The meme coin with big dreams and even BIGGER ears!", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://r.turbos.finance/icon/1736619656507.png")), arg1);
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<BBELLEPHA>>(v1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<BBELLEPHA>>(v0, 0x2::tx_context::sender(arg1));
    }

    // decompiled from Move bytecode v6
}

