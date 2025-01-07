module 0xfe40e15fb138fce7c11fd341b173a8ddc3184c389147f3f7044aa4f1e2677ea::gzliudan_faucet {
    struct GZLIUDAN_FAUCET has drop {
        dummy_field: bool,
    }

    fun init(arg0: GZLIUDAN_FAUCET, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<GZLIUDAN_FAUCET>(arg0, 6, b"GZC", b"gzliuan faucet", b"", 0x1::option::none<0x2::url::Url>(), arg1);
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<GZLIUDAN_FAUCET>>(v1);
        0x2::transfer::public_share_object<0x2::coin::TreasuryCap<GZLIUDAN_FAUCET>>(v0);
    }

    public entry fun mint(arg0: &mut 0x2::coin::TreasuryCap<GZLIUDAN_FAUCET>, arg1: u64, arg2: address, arg3: &mut 0x2::tx_context::TxContext) {
        0x2::coin::mint_and_transfer<GZLIUDAN_FAUCET>(arg0, arg1, arg2, arg3);
    }

    // decompiled from Move bytecode v6
}

