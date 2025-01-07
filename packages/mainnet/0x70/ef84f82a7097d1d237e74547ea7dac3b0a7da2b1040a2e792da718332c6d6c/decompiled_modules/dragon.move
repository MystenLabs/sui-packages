module 0x70ef84f82a7097d1d237e74547ea7dac3b0a7da2b1040a2e792da718332c6d6c::dragon {
    struct DRAGON has drop {
        dummy_field: bool,
    }

    fun init(arg0: DRAGON, arg1: &mut 0x2::tx_context::TxContext) {
        let v0 = 0x2::tx_context::sender(arg1);
        let (v1, v2) = 0x2::coin::create_currency<DRAGON>(arg0, 6, b"DRAGON", b"DRAGON", b"SuiEmoji Dragon", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://ipfs.suiemoji.fun/emojis/dragon.svg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::CoinMetadata<DRAGON>>(v2, v0);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<DRAGON>>(v1, v0);
    }

    // decompiled from Move bytecode v6
}

