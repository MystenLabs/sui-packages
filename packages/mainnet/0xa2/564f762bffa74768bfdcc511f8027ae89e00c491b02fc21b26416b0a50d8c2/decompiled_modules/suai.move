module 0xa2564f762bffa74768bfdcc511f8027ae89e00c491b02fc21b26416b0a50d8c2::suai {
    struct SUAI has drop {
        dummy_field: bool,
    }

    fun init(arg0: SUAI, arg1: &mut 0x2::tx_context::TxContext) {
        let v0 = 0x2::tx_context::sender(arg1);
        let (v1, v2) = 0x2::coin::create_currency<SUAI>(arg0, 6, b"SUAI", b"SuiAI by SuiAI", b"Launch and Co-Create Onchain AI Agents @SuiNetwork", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.suiai.fun/uploads/suai_logo_5c8fcdec58.png")), arg1);
        0x2::transfer::public_transfer<0x2::coin::CoinMetadata<SUAI>>(v2, v0);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<SUAI>>(v1, v0);
    }

    // decompiled from Move bytecode v6
}

