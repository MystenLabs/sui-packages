module 0x67aab514270015e19c1c39be67419afb6e17dba65048d3fce1cce06e54a8a48d::faucet {
    struct FAUCET has drop {
        dummy_field: bool,
    }

    public entry fun faucet(arg0: &mut 0x2::coin::TreasuryCap<FAUCET>, arg1: u64, arg2: address, arg3: &mut 0x2::tx_context::TxContext) {
        0x2::coin::mint_and_transfer<FAUCET>(arg0, arg1, arg2, arg3);
    }

    fun init(arg0: FAUCET, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<FAUCET>(arg0, 8, b"Wtwin", b"Wtwin Faucet", b"Wtwin", 0x1::option::none<0x2::url::Url>(), arg1);
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<FAUCET>>(v1);
        0x2::transfer::public_share_object<0x2::coin::TreasuryCap<FAUCET>>(v0);
    }

    // decompiled from Move bytecode v6
}

