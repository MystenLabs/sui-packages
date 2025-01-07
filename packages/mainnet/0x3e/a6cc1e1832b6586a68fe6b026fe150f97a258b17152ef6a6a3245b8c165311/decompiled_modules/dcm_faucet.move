module 0x3ea6cc1e1832b6586a68fe6b026fe150f97a258b17152ef6a6a3245b8c165311::dcm_faucet {
    struct DCM_FAUCET has drop {
        dummy_field: bool,
    }

    public fun burn(arg0: &mut 0x2::coin::TreasuryCap<DCM_FAUCET>, arg1: 0x2::coin::Coin<DCM_FAUCET>) {
        0x2::coin::burn<DCM_FAUCET>(arg0, arg1);
    }

    fun init(arg0: DCM_FAUCET, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<DCM_FAUCET>(arg0, 6, b"DCMFA", b"DCMFA Coin", b"dcm_faucet", 0x1::option::none<0x2::url::Url>(), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<DCM_FAUCET>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<DCM_FAUCET>>(v1);
    }

    public fun mint(arg0: &mut 0x2::coin::TreasuryCap<DCM_FAUCET>, arg1: u64, arg2: address, arg3: &mut 0x2::tx_context::TxContext) {
        0x2::coin::mint_and_transfer<DCM_FAUCET>(arg0, arg1, arg2, arg3);
    }

    // decompiled from Move bytecode v6
}

