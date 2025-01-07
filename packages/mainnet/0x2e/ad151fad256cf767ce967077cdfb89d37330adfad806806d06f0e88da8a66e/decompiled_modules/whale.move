module 0x2ead151fad256cf767ce967077cdfb89d37330adfad806806d06f0e88da8a66e::whale {
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

