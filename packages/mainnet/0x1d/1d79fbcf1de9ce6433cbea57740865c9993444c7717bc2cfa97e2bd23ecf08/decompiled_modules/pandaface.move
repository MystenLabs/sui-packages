module 0x1d1d79fbcf1de9ce6433cbea57740865c9993444c7717bc2cfa97e2bd23ecf08::pandaface {
    struct PANDAFACE has drop {
        dummy_field: bool,
    }

    fun init(arg0: PANDAFACE, arg1: &mut 0x2::tx_context::TxContext) {
        let v0 = 0x2::tx_context::sender(arg1);
        let (v1, v2) = 0x2::coin::create_currency<PANDAFACE>(arg0, 6, b"PANDAFACE", b"PANDA", b"SuiEmoji Panda", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://ipfs.suiemoji.fun/emojis/pandaface.svg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::CoinMetadata<PANDAFACE>>(v2, v0);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<PANDAFACE>>(v1, v0);
    }

    // decompiled from Move bytecode v6
}

