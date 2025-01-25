module 0xf0fa01da462fdfe370ab9d271d1990f64c17842056a544f4420a444c24c6d8a9::twitter {
    struct TWITTER has drop {
        dummy_field: bool,
    }

    fun init(arg0: TWITTER, arg1: &mut 0x2::tx_context::TxContext) {
        let v0 = 0x2::tx_context::sender(arg1);
        let (v1, v2) = 0x2::coin::create_currency<TWITTER>(arg0, 6, b"TWITTER", b"Twitter AI by SuiAI", b"Twitter AI", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.suiai.fun/uploads/twitter_9c1d101934.png")), arg1);
        0x2::transfer::public_transfer<0x2::coin::CoinMetadata<TWITTER>>(v2, v0);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<TWITTER>>(v1, v0);
    }

    // decompiled from Move bytecode v6
}

