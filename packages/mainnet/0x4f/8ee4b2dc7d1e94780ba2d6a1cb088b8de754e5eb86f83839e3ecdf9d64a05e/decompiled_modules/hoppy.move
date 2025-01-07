module 0x4f8ee4b2dc7d1e94780ba2d6a1cb088b8de754e5eb86f83839e3ecdf9d64a05e::hoppy {
    struct HOPPY has drop {
        dummy_field: bool,
    }

    fun init(arg0: HOPPY, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<HOPPY>(arg0, 6, b"HOPPY", b"HOPPY on SUI", b"An immortal joyful rabbit bringing SUI szn back on track", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://r.turbos.finance/icon/1730969878585.jpg")), arg1);
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<HOPPY>>(v1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<HOPPY>>(v0, 0x2::tx_context::sender(arg1));
    }

    // decompiled from Move bytecode v6
}

