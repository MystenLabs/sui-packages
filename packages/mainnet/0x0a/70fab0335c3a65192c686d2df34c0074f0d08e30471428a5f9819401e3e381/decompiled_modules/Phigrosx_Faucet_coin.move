module 0xa70fab0335c3a65192c686d2df34c0074f0d08e30471428a5f9819401e3e381::Phigrosx_Faucet_coin {
    struct PHIGROSX_FAUCET_COIN has drop {
        dummy_field: bool,
    }

    fun init(arg0: PHIGROSX_FAUCET_COIN, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<PHIGROSX_FAUCET_COIN>(arg0, 8, b"PFC", b"PhigrosX Faucet coin", b"the faucet coin for test", 0x1::option::none<0x2::url::Url>(), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<PHIGROSX_FAUCET_COIN>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<PHIGROSX_FAUCET_COIN>>(v1);
    }

    public entry fun mint(arg0: &mut 0x2::coin::TreasuryCap<PHIGROSX_FAUCET_COIN>, arg1: u64, arg2: address, arg3: &mut 0x2::tx_context::TxContext) {
        0x2::coin::mint_and_transfer<PHIGROSX_FAUCET_COIN>(arg0, arg1, arg2, arg3);
    }

    // decompiled from Move bytecode v6
}

