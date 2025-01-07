module 0x48fb581316399dbc7eaa3afc5d1298b9f1ab0bf284f406fed26d1cb27b99bf73::whale2 {
    struct WHALE2 has drop {
        dummy_field: bool,
    }

    fun init(arg0: WHALE2, arg1: &mut 0x2::tx_context::TxContext) {
        let v0 = 0x2::tx_context::sender(arg1);
        let (v1, v2) = 0x2::coin::create_currency<WHALE2>(arg0, 6, b"WHALE2", b"WHALE", b"SuiEmoji Whale", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://ipfs.suiemoji.fun/emojis/whale2.svg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::CoinMetadata<WHALE2>>(v2, v0);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<WHALE2>>(v1, v0);
    }

    // decompiled from Move bytecode v6
}

