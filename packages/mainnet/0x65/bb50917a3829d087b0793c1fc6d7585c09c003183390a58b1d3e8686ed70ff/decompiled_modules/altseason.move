module 0x65bb50917a3829d087b0793c1fc6d7585c09c003183390a58b1d3e8686ed70ff::altseason {
    struct ALTSEASON has drop {
        dummy_field: bool,
    }

    fun init(arg0: ALTSEASON, arg1: &mut 0x2::tx_context::TxContext) {
        let v0 = 0x2::tx_context::sender(arg1);
        let (v1, v2) = 0x2::coin::create_currency<ALTSEASON>(arg0, 6, b"ALTSEASON", b"ALTSEASON", b"@suilaunchcoin $altseason + ALTSEASON COIN", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.suiai.fun/uploads/altseason-nxoxv6.png")), arg1);
        0x2::transfer::public_transfer<0x2::coin::CoinMetadata<ALTSEASON>>(v2, v0);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<ALTSEASON>>(v1, v0);
    }

    // decompiled from Move bytecode v6
}

