module 0x110fe9816b3e833c11eace90eb8df3186e6f09df8b2b4104feb23a9f41bf789b::pill {
    struct PILL has drop {
        dummy_field: bool,
    }

    fun init(arg0: PILL, arg1: &mut 0x2::tx_context::TxContext) {
        let v0 = 0x2::tx_context::sender(arg1);
        let (v1, v2) = 0x2::coin::create_currency<PILL>(arg0, 6, b"PILL", b"PILL", b"SuiEmoji Pill", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://ipfs.suiemoji.fun/emojis/pill.svg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::CoinMetadata<PILL>>(v2, v0);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<PILL>>(v1, v0);
    }

    // decompiled from Move bytecode v6
}

