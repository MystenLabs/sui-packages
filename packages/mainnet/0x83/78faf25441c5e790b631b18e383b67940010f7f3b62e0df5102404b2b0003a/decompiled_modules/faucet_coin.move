module 0x8378faf25441c5e790b631b18e383b67940010f7f3b62e0df5102404b2b0003a::faucet_coin {
    struct FAUCET_COIN has drop {
        dummy_field: bool,
    }

    struct FaucetCoin has drop {
        dummy_field: bool,
    }

    public fun mint(arg0: &mut 0x2::coin::TreasuryCap<FAUCET_COIN>, arg1: u64, arg2: address, arg3: &mut 0x2::tx_context::TxContext) {
        assert!(arg1 <= 100000000000, 0);
        0x2::transfer::public_transfer<0x2::coin::Coin<FAUCET_COIN>>(0x2::coin::mint<FAUCET_COIN>(arg0, arg1, arg3), arg2);
    }

    fun init(arg0: FAUCET_COIN, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<FAUCET_COIN>(arg0, 9, b"FAUCET", b"Faucet Coin", b"A faucet coin that anyone can mint", 0x1::option::none<0x2::url::Url>(), arg1);
        0x2::transfer::public_share_object<0x2::coin::TreasuryCap<FAUCET_COIN>>(v0);
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<FAUCET_COIN>>(v1);
    }

    // decompiled from Move bytecode v6
}

