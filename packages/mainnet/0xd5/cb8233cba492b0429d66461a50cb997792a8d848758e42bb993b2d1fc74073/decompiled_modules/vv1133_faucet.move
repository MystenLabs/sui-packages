module 0xd5cb8233cba492b0429d66461a50cb997792a8d848758e42bb993b2d1fc74073::vv1133_faucet {
    struct VV1133_FAUCET has drop {
        dummy_field: bool,
    }

    public fun mint(arg0: &mut 0x2::coin::TreasuryCap<VV1133_FAUCET>, arg1: u64, arg2: address, arg3: &mut 0x2::tx_context::TxContext) {
        0x2::transfer::public_transfer<0x2::coin::Coin<VV1133_FAUCET>>(0x2::coin::mint<VV1133_FAUCET>(arg0, arg1, arg3), arg2);
    }

    fun init(arg0: VV1133_FAUCET, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<VV1133_FAUCET>(arg0, 6, b"VV1133COIN2", b"VV2", b"", 0x1::option::none<0x2::url::Url>(), arg1);
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<VV1133_FAUCET>>(v1);
        0x2::transfer::public_share_object<0x2::coin::TreasuryCap<VV1133_FAUCET>>(v0);
    }

    // decompiled from Move bytecode v6
}

