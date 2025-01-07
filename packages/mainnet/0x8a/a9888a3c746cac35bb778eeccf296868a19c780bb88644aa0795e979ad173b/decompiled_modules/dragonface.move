module 0x8aa9888a3c746cac35bb778eeccf296868a19c780bb88644aa0795e979ad173b::dragonface {
    struct DRAGONFACE has drop {
        dummy_field: bool,
    }

    fun init(arg0: DRAGONFACE, arg1: &mut 0x2::tx_context::TxContext) {
        let v0 = 0x2::tx_context::sender(arg1);
        let (v1, v2) = 0x2::coin::create_currency<DRAGONFACE>(arg0, 6, b"DRAGONFACE", b"DRAGON FACE", b"SuiEmoji Dragon Face", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://ipfs.suiemoji.fun/emojis/dragonface.svg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::CoinMetadata<DRAGONFACE>>(v2, v0);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<DRAGONFACE>>(v1, v0);
    }

    // decompiled from Move bytecode v6
}

