module 0xb2167a378a72d98ceeebb73ace9b0f28c41067ba5f0f2e9112826943fa9f894b::FAUCET {
    struct FAUCET has drop {
        dummy_field: bool,
    }

    public entry fun mint(arg0: &mut 0x2::coin::TreasuryCap<FAUCET>, arg1: &mut 0x2::tx_context::TxContext) {
        0x2::transfer::public_transfer<0x2::coin::Coin<FAUCET>>(0x2::coin::mint<FAUCET>(arg0, 10000000, arg1), 0x2::tx_context::sender(arg1));
    }

    fun init(arg0: FAUCET, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<FAUCET>(arg0, 6, b"FAUCET", b"", b"", 0x1::option::none<0x2::url::Url>(), arg1);
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<FAUCET>>(v1);
        0x2::transfer::public_share_object<0x2::coin::TreasuryCap<FAUCET>>(v0);
    }

    // decompiled from Move bytecode v6
}

