module 0x292daebf557915453c0e90bd319645c3b01e30ee39db071462c7b860e7e83e15::unicornface {
    struct UNICORNFACE has drop {
        dummy_field: bool,
    }

    fun init(arg0: UNICORNFACE, arg1: &mut 0x2::tx_context::TxContext) {
        let v0 = 0x2::tx_context::sender(arg1);
        let (v1, v2) = 0x2::coin::create_currency<UNICORNFACE>(arg0, 6, b"UNICORNFACE", b"UNICORN", b"SuiEmoji Unicorn", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://ipfs.suiemoji.fun/emojis/unicornface.svg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::CoinMetadata<UNICORNFACE>>(v2, v0);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<UNICORNFACE>>(v1, v0);
    }

    // decompiled from Move bytecode v6
}

