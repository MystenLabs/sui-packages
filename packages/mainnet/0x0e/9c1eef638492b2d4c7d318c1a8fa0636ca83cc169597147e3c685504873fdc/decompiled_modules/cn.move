module 0xe9c1eef638492b2d4c7d318c1a8fa0636ca83cc169597147e3c685504873fdc::cn {
    struct CN has drop {
        dummy_field: bool,
    }

    fun init(arg0: CN, arg1: &mut 0x2::tx_context::TxContext) {
        let v0 = 0x2::tx_context::sender(arg1);
        let (v1, v2) = 0x2::coin::create_currency<CN>(arg0, 6, b"CN", b"CHINA FLAG", b"SuiEmoji China Flag", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://ipfs.suiemoji.fun/emojis/cn.svg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::CoinMetadata<CN>>(v2, v0);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<CN>>(v1, v0);
    }

    // decompiled from Move bytecode v6
}

