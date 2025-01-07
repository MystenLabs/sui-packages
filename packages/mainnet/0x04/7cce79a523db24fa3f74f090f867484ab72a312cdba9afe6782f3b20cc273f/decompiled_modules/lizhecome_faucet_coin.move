module 0x47cce79a523db24fa3f74f090f867484ab72a312cdba9afe6782f3b20cc273f::lizhecome_faucet_coin {
    struct LIZHECOME_FAUCET_COIN has drop {
        dummy_field: bool,
    }

    fun init(arg0: LIZHECOME_FAUCET_COIN, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<LIZHECOME_FAUCET_COIN>(arg0, 6, b"LizhecomeFaucet", b"lizhecome faucet coin", b"faucet_token", 0x1::option::none<0x2::url::Url>(), arg1);
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<LIZHECOME_FAUCET_COIN>>(v1);
        0x2::transfer::public_share_object<0x2::coin::TreasuryCap<LIZHECOME_FAUCET_COIN>>(v0);
    }

    public fun mint_faucet_module(arg0: &mut 0x2::coin::TreasuryCap<LIZHECOME_FAUCET_COIN>, arg1: u64, arg2: address, arg3: &mut 0x2::tx_context::TxContext) {
        0x2::transfer::public_transfer<0x2::coin::Coin<LIZHECOME_FAUCET_COIN>>(0x2::coin::mint<LIZHECOME_FAUCET_COIN>(arg0, arg1, arg3), arg2);
    }

    // decompiled from Move bytecode v6
}

