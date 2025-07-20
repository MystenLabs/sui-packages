module 0xdeba8c5d077b32ca5bb1876ad7596c5a22614e0c4b6bd719b2de0a33db021ebc::lick {
    struct LICK has drop {
        dummy_field: bool,
    }

    fun init(arg0: LICK, arg1: &mut 0x2::tx_context::TxContext) {
        let v0 = 0x2::tx_context::sender(arg1);
        let (v1, v2) = 0x2::coin::create_currency<LICK>(arg0, 6, b"LICK", b"Lickitung", b"@suilaunchcoin $LICK + Lickitung https://t.co/SGlNNnNTsC", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.suiai.fun/uploads/lick-70i4mf.png")), arg1);
        0x2::transfer::public_transfer<0x2::coin::CoinMetadata<LICK>>(v2, v0);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<LICK>>(v1, v0);
    }

    // decompiled from Move bytecode v6
}

