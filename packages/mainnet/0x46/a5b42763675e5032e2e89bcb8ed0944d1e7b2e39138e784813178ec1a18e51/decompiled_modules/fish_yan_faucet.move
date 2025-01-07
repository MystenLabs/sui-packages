module 0x46a5b42763675e5032e2e89bcb8ed0944d1e7b2e39138e784813178ec1a18e51::fish_yan_faucet {
    struct FISH_YAN_FAUCET has drop {
        dummy_field: bool,
    }

    fun init(arg0: FISH_YAN_FAUCET, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<FISH_YAN_FAUCET>(arg0, 9, b"Fish Yan Faucet", b"Fish Yan Faucet Coin", b"Fish Yan faucet coin", 0x1::option::none<0x2::url::Url>(), arg1);
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<FISH_YAN_FAUCET>>(v1);
        0x2::transfer::public_share_object<0x2::coin::TreasuryCap<FISH_YAN_FAUCET>>(v0);
    }

    // decompiled from Move bytecode v6
}

