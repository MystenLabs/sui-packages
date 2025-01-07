module 0x9ce65f46447812e71ff6ad857c7f427a9e6c1d14d5bac9ccd099d010001fcbb1::hdhfg {
    struct HDHFG has drop {
        dummy_field: bool,
    }

    fun init(arg0: HDHFG, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<HDHFG>(arg0, 6, b"Hdhfg", b"Ape", b"https://suidogai.io", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://r.turbos.finance/icon/1731344432016.png")), arg1);
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<HDHFG>>(v1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<HDHFG>>(v0, 0x2::tx_context::sender(arg1));
    }

    // decompiled from Move bytecode v6
}

