module 0x85870292ec87fc8985f6051d74f14011a3ca3f30bed1d1f485d57f408b673924::tiger {
    struct TIGER has drop {
        dummy_field: bool,
    }

    fun init(arg0: TIGER, arg1: &mut 0x2::tx_context::TxContext) {
        let v0 = 0x2::tx_context::sender(arg1);
        let (v1, v2) = 0x2::coin::create_currency<TIGER>(arg0, 6, b"TIGER", b"TIGER FACE", b"SuiEmoji Tiger Face", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://ipfs.suiemoji.fun/emojis/tiger.svg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::CoinMetadata<TIGER>>(v2, v0);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<TIGER>>(v1, v0);
    }

    // decompiled from Move bytecode v6
}

