module 0xd324003f9bd2409e139a24ac0ec2329a6a27e1da847e1dda3927bc78343e940f::jack_751_faucet_coin {
    struct JACK_751_FAUCET_COIN has drop {
        dummy_field: bool,
    }

    public entry fun mint(arg0: &mut 0x2::coin::TreasuryCap<JACK_751_FAUCET_COIN>, arg1: u64, arg2: address, arg3: &mut 0x2::tx_context::TxContext) {
        0x2::transfer::public_transfer<0x2::coin::Coin<JACK_751_FAUCET_COIN>>(0x2::coin::mint<JACK_751_FAUCET_COIN>(arg0, arg1, arg3), arg2);
    }

    fun init(arg0: JACK_751_FAUCET_COIN, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<JACK_751_FAUCET_COIN>(arg0, 6, b"Jack-751", b"Jack_751_FAUCETCOIN", b"Jack_751_FAUCETCOIN_Description", 0x1::option::none<0x2::url::Url>(), arg1);
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<JACK_751_FAUCET_COIN>>(v1);
        0x2::transfer::public_share_object<0x2::coin::TreasuryCap<JACK_751_FAUCET_COIN>>(v0);
    }

    // decompiled from Move bytecode v6
}

