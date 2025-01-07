module 0x1b6d787e6bb158468ef48f46ba486b03e4d386d7f0a5611b90edda28bc3b8c30::lindappi_faucet_coin {
    struct LINDAPPI_FAUCET_COIN has drop {
        dummy_field: bool,
    }

    fun init(arg0: LINDAPPI_FAUCET_COIN, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<LINDAPPI_FAUCET_COIN>(arg0, 8, b"LINDAPPI_PUBLIC", b"lindappi Faucet coin", b"test faucet coin", 0x1::option::none<0x2::url::Url>(), arg1);
        0x2::transfer::public_share_object<0x2::coin::TreasuryCap<LINDAPPI_FAUCET_COIN>>(v0);
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<LINDAPPI_FAUCET_COIN>>(v1);
    }

    public entry fun mint(arg0: &mut 0x2::coin::TreasuryCap<LINDAPPI_FAUCET_COIN>, arg1: u64, arg2: address, arg3: &mut 0x2::tx_context::TxContext) {
        0x2::coin::mint_and_transfer<LINDAPPI_FAUCET_COIN>(arg0, arg1, arg2, arg3);
    }

    // decompiled from Move bytecode v6
}

