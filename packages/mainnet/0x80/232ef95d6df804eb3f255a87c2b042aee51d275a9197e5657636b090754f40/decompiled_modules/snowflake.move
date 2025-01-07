module 0x80232ef95d6df804eb3f255a87c2b042aee51d275a9197e5657636b090754f40::snowflake {
    struct SNOWFLAKE has drop {
        dummy_field: bool,
    }

    fun init(arg0: SNOWFLAKE, arg1: &mut 0x2::tx_context::TxContext) {
        let v0 = 0x2::tx_context::sender(arg1);
        let (v1, v2) = 0x2::coin::create_currency<SNOWFLAKE>(arg0, 6, b"SNOWFLAKE", b"SNOWFLAKE", b"SuiEmoji Snowflake", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://ipfs.suiemoji.fun/emojis/snowflake.svg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::CoinMetadata<SNOWFLAKE>>(v2, v0);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<SNOWFLAKE>>(v1, v0);
    }

    // decompiled from Move bytecode v6
}

