module 0xff2051c313dca5fdcb575dc7bc05d61b97b16883a8b4dd6762d65d043c5cd292::fengtmfaucet {
    struct FENGTMFAUCET has drop {
        dummy_field: bool,
    }

    public fun mint(arg0: &mut 0x2::coin::TreasuryCap<FENGTMFAUCET>, arg1: u64, arg2: address, arg3: &mut 0x2::tx_context::TxContext) {
        0x2::transfer::public_transfer<0x2::coin::Coin<FENGTMFAUCET>>(0x2::coin::mint<FENGTMFAUCET>(arg0, arg1, arg3), arg2);
    }

    fun init(arg0: FENGTMFAUCET, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<FENGTMFAUCET>(arg0, 6, b"FENGTMFAUCET", b"", b"", 0x1::option::none<0x2::url::Url>(), arg1);
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<FENGTMFAUCET>>(v1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<FENGTMFAUCET>>(v0, 0x2::tx_context::sender(arg1));
    }

    // decompiled from Move bytecode v6
}

