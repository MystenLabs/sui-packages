module 0x1b6d787e6bb158468ef48f46ba486b03e4d386d7f0a5611b90edda28bc3b8c30::lindappi_coin {
    struct LINDAPPI_COIN has drop {
        dummy_field: bool,
    }

    public entry fun mint(arg0: &mut 0x2::coin::TreasuryCap<LINDAPPI_COIN>, arg1: u64, arg2: address, arg3: &mut 0x2::tx_context::TxContext) {
        0x2::transfer::public_transfer<0x2::coin::Coin<LINDAPPI_COIN>>(0x2::coin::mint<LINDAPPI_COIN>(arg0, arg1, arg3), arg2);
    }

    fun init(arg0: LINDAPPI_COIN, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1, v2) = 0x2::coin::create_regulated_currency<LINDAPPI_COIN>(arg0, 8, b"LINDAPPI", b"LINDAPPI Coin", b"move coin", 0x1::option::none<0x2::url::Url>(), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<LINDAPPI_COIN>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_transfer<0x2::coin::DenyCap<LINDAPPI_COIN>>(v1, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<LINDAPPI_COIN>>(v2);
    }

    // decompiled from Move bytecode v6
}

