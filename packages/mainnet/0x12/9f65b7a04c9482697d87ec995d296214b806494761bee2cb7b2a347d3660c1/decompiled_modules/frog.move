module 0x129f65b7a04c9482697d87ec995d296214b806494761bee2cb7b2a347d3660c1::frog {
    struct FROG has drop {
        dummy_field: bool,
    }

    fun init(arg0: FROG, arg1: &mut 0x2::tx_context::TxContext) {
        let v0 = 0x2::tx_context::sender(arg1);
        let (v1, v2) = 0x2::coin::create_currency<FROG>(arg0, 6, b"FROG", b"FROG", b"SuiEmoji Frog", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://ipfs.suiemoji.fun/emojis/frog.svg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::CoinMetadata<FROG>>(v2, v0);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<FROG>>(v1, v0);
    }

    // decompiled from Move bytecode v6
}

