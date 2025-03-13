module 0xaaeb55e0f2fe334931742b4602a30c6d8a96707991073b578cae1b365dec4b5e::sFDUSD {
    struct SFDUSD has drop {
        dummy_field: bool,
    }

    fun init(arg0: SFDUSD, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<SFDUSD>(arg0, 6, b"sysFDUSD", b"SY sFDUSD", b"SY scallop sFDUSD", 0x1::option::none<0x2::url::Url>(), arg1);
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<SFDUSD>>(v1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<SFDUSD>>(v0, 0x2::tx_context::sender(arg1));
    }

    // decompiled from Move bytecode v6
}

