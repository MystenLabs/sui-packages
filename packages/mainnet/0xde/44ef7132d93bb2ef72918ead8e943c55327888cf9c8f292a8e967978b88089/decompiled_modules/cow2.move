module 0xde44ef7132d93bb2ef72918ead8e943c55327888cf9c8f292a8e967978b88089::cow2 {
    struct COW2 has drop {
        dummy_field: bool,
    }

    fun init(arg0: COW2, arg1: &mut 0x2::tx_context::TxContext) {
        let v0 = 0x2::tx_context::sender(arg1);
        let (v1, v2) = 0x2::coin::create_currency<COW2>(arg0, 6, b"COW2", b"COW", b"SuiEmoji Cow", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://ipfs.suiemoji.fun/emojis/cow2.svg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::CoinMetadata<COW2>>(v2, v0);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<COW2>>(v1, v0);
    }

    // decompiled from Move bytecode v6
}

