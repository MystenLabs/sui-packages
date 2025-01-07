module 0xe9ba9b5b517c0ee1b87bb31df86e782118e0dcab785f4070947bcc50804823c::govt {
    struct GOVT has drop {
        dummy_field: bool,
    }

    fun init(arg0: GOVT, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<GOVT>(arg0, 8, b"GOVT", b"Wrapped token for ISHARES US TREASURY BOND ETF", b"Sudo Virtual Coin for ISHARES US TREASURY BOND ETF", 0x1::option::none<0x2::url::Url>(), arg1);
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<GOVT>>(v1);
        0x2::transfer::public_freeze_object<0x2::coin::TreasuryCap<GOVT>>(v0);
    }

    // decompiled from Move bytecode v6
}

