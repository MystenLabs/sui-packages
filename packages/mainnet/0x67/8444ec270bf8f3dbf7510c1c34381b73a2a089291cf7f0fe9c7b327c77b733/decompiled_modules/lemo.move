module 0x678444ec270bf8f3dbf7510c1c34381b73a2a089291cf7f0fe9c7b327c77b733::lemo {
    struct LEMO has drop {
        dummy_field: bool,
    }

    fun init(arg0: LEMO, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<LEMO>(arg0, 6, b"LEMO", b"Lemo on SUI", b"Your refreshing friend for the summer", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://ipfs.io/ipfs/bafkreidblybg5rr2zkargftk7r27wg4cwr2dahhbirztgblte42i46zspu")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<LEMO>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_transfer<0x2::coin::CoinMetadata<LEMO>>(v1, 0x2::tx_context::sender(arg1));
    }

    // decompiled from Move bytecode v6
}

