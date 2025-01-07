module 0x7139bcd717ac62b46556fbb7108de847c9677bb0625c297a32cb29daf29ba193::tlt {
    struct TLT has drop {
        dummy_field: bool,
    }

    fun init(arg0: TLT, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<TLT>(arg0, 8, b"TLT", b"Wrapped token for ISHARES 20+ YEAR TREASURY BOND ETF", b"Sudo Virtual Coin for TLT (ISHARES 20+ YEAR TREASURY BOND ETF)", 0x1::option::none<0x2::url::Url>(), arg1);
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<TLT>>(v1);
        0x2::transfer::public_freeze_object<0x2::coin::TreasuryCap<TLT>>(v0);
    }

    // decompiled from Move bytecode v6
}

