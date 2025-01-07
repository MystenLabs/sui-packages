module 0x396c429726a13be629a8449eddf9bbd01af13a995b9072b7590de7abd3257394::ttm {
    struct TTM has drop {
        dummy_field: bool,
    }

    fun init(arg0: TTM, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<TTM>(arg0, 6, b"TTM", b"Tomato AI", b"Meet TomatoAl, Your Crypto Finances on Autopilot.", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://r.turbos.finance/icon/1735777613871.png")), arg1);
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<TTM>>(v1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<TTM>>(v0, 0x2::tx_context::sender(arg1));
    }

    // decompiled from Move bytecode v6
}

