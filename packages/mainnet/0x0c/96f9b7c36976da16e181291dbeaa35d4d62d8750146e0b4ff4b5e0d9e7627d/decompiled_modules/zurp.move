module 0xc96f9b7c36976da16e181291dbeaa35d4d62d8750146e0b4ff4b5e0d9e7627d::zurp {
    struct ZURP has drop {
        dummy_field: bool,
    }

    fun init(arg0: ZURP, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<ZURP>(arg0, 6, b"ZURP", b"CORN ZURP", b"https://x.com/JackXBT_/status/1922622804589007130", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://ipfs.io/ipfs/bafkreifj6czkvdk3ilhhn7ia56txjs2jft4tk4cphtrs65knb3gynygz6e")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<ZURP>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_transfer<0x2::coin::CoinMetadata<ZURP>>(v1, 0x2::tx_context::sender(arg1));
    }

    // decompiled from Move bytecode v6
}

