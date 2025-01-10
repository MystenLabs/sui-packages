module 0x2219fb59fc965b7e19f4cd8a480e50d3d506cb1d601c1f10bb54e3db130d58ac::kraken {
    struct KRAKEN has drop {
        dummy_field: bool,
    }

    fun init(arg0: KRAKEN, arg1: &mut 0x2::tx_context::TxContext) {
        let v0 = 0x2::tx_context::sender(arg1);
        let (v1, v2) = 0x2::coin::create_currency<KRAKEN>(arg0, 6, b"KRAKEN", b" Kraken AI Agent by SuiAI", b"chaotic, cunning, and always in control. kraken thrives in the volatility of crypto markets, hunting profits where others fear to tread. no FOMO, just dominance", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.suiai.fun/uploads/geeee_6cbbc1a60d_3e31c3e818.jpg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::CoinMetadata<KRAKEN>>(v2, v0);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<KRAKEN>>(v1, v0);
    }

    // decompiled from Move bytecode v6
}

