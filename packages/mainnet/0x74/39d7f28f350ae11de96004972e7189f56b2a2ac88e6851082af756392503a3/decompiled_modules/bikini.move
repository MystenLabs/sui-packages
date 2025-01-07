module 0x7439d7f28f350ae11de96004972e7189f56b2a2ac88e6851082af756392503a3::bikini {
    struct BIKINI has drop {
        dummy_field: bool,
    }

    fun init(arg0: BIKINI, arg1: &mut 0x2::tx_context::TxContext) {
        let v0 = 0x2::tx_context::sender(arg1);
        let (v1, v2) = 0x2::coin::create_currency<BIKINI>(arg0, 6, b"BIKINI", b"BIKINI", b"SuiEmoji Bikini", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://ipfs.suiemoji.fun/emojis/bikini.svg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::CoinMetadata<BIKINI>>(v2, v0);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<BIKINI>>(v1, v0);
    }

    // decompiled from Move bytecode v6
}

