module 0x3bde4fb7177d77dd019e92f673f77ca9f972a4bce5f4868d9b4b75969e886011::msol {
    struct MSOL has drop {
        dummy_field: bool,
    }

    fun init(arg0: MSOL, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<MSOL>(arg0, 9, b"MSOL", b"Foreign token represent Marinade staked SOL", b"Foreign token represent Marinade staked SOL", 0x1::option::none<0x2::url::Url>(), arg1);
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<MSOL>>(v1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<MSOL>>(v0, 0x2::tx_context::sender(arg1));
    }

    // decompiled from Move bytecode v6
}

