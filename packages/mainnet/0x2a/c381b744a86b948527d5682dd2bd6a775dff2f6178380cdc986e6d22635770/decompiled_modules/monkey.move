module 0x2ac381b744a86b948527d5682dd2bd6a775dff2f6178380cdc986e6d22635770::monkey {
    struct MONKEY has drop {
        dummy_field: bool,
    }

    fun init(arg0: MONKEY, arg1: &mut 0x2::tx_context::TxContext) {
        let v0 = 0x2::tx_context::sender(arg1);
        let (v1, v2) = 0x2::coin::create_currency<MONKEY>(arg0, 6, b"MONKEY", b"MONKEY", b"SuiEmoji Monkey", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.suiemoji.fun/emojis/monkey.svg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::CoinMetadata<MONKEY>>(v2, v0);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<MONKEY>>(v1, v0);
    }

    // decompiled from Move bytecode v6
}

