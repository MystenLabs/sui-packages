module 0xa9beea5098039e2ce4a227f343b0d6d516a1e8ccf4fb4a2d14618ea9645cdcc5::faucet_coin {
    struct FAUCET_COIN has drop {
        dummy_field: bool,
    }

    public fun burn(arg0: &mut 0x2::coin::TreasuryCap<FAUCET_COIN>, arg1: 0x2::coin::Coin<FAUCET_COIN>) {
        let v0 = 0x1::ascii::string(b"burn");
        0x1::debug::print<0x1::ascii::String>(&v0);
        0x2::coin::burn<FAUCET_COIN>(arg0, arg1);
    }

    public entry fun mint(arg0: &mut 0x2::coin::TreasuryCap<FAUCET_COIN>, arg1: u64, arg2: address, arg3: &mut 0x2::tx_context::TxContext) {
        let v0 = 0x1::ascii::string(b"faucet mint");
        0x1::debug::print<0x1::ascii::String>(&v0);
        0x2::transfer::public_transfer<0x2::coin::Coin<FAUCET_COIN>>(0x2::coin::mint<FAUCET_COIN>(arg0, arg1, arg3), arg2);
    }

    fun init(arg0: FAUCET_COIN, arg1: &mut 0x2::tx_context::TxContext) {
        let v0 = 0x1::ascii::string(b"init FAUCET_COIN");
        0x1::debug::print<0x1::ascii::String>(&v0);
        let (v1, v2) = 0x2::coin::create_currency<FAUCET_COIN>(arg0, 8, b"FaucetCoin", b"Faucet Coin", b"My faucet coin", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe(0x1::ascii::string(b"https://avatars.githubusercontent.com/u/36093027?v=4"))), arg1);
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<FAUCET_COIN>>(v2);
        0x2::transfer::public_share_object<0x2::coin::TreasuryCap<FAUCET_COIN>>(v1);
    }

    // decompiled from Move bytecode v6
}

