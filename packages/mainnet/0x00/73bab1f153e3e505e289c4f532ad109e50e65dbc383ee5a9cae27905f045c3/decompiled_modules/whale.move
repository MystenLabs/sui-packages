module 0x73bab1f153e3e505e289c4f532ad109e50e65dbc383ee5a9cae27905f045c3::whale {
    struct WHALE has drop {
        dummy_field: bool,
    }

    fun init(arg0: WHALE, arg1: &mut 0x2::tx_context::TxContext) {
        let v0 = 0x2::tx_context::sender(arg1);
        let (v1, v2) = 0x2::coin::create_currency<WHALE>(arg0, 6, b"WHALE", b"SPOUTING WHALE", b"SuiEmoji Spouting Whale", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://ipfs.suiemoji.fun/emojis/whale.svg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::CoinMetadata<WHALE>>(v2, v0);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<WHALE>>(v1, v0);
    }

    // decompiled from Move bytecode v6
}

