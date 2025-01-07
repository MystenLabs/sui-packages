module 0x2a6acc6295f89f9b4c8b93fd84dfe29f010e9fd279265d93d8ab51fd3fb5338d::faucet_coin {
    struct FAUCET_COIN has drop {
        dummy_field: bool,
    }

    public entry fun burn(arg0: &mut 0x2::coin::TreasuryCap<FAUCET_COIN>, arg1: 0x2::coin::Coin<FAUCET_COIN>) {
        let v0 = 0x1::ascii::string(b"burn");
        0x1::debug::print<0x1::ascii::String>(&v0);
        0x2::coin::burn<FAUCET_COIN>(arg0, arg1);
    }

    public entry fun mint(arg0: &mut 0x2::coin::TreasuryCap<FAUCET_COIN>, arg1: u64, arg2: address, arg3: &mut 0x2::tx_context::TxContext) {
        let v0 = 0x1::ascii::string(b"faucet_coin mint");
        0x1::debug::print<0x1::ascii::String>(&v0);
        0x2::transfer::public_transfer<0x2::coin::Coin<FAUCET_COIN>>(0x2::coin::mint<FAUCET_COIN>(arg0, arg1, arg3), arg2);
    }

    fun init(arg0: FAUCET_COIN, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<FAUCET_COIN>(arg0, 6, b"MOON", b"CTIANMING_FAUCET_COIN", b"MOON_COIN", 0x1::option::none<0x2::url::Url>(), arg1);
        let v2 = 0x1::ascii::string(b"init FAUCET_COIN");
        0x1::debug::print<0x1::ascii::String>(&v2);
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<FAUCET_COIN>>(v1);
        0x2::transfer::public_share_object<0x2::coin::TreasuryCap<FAUCET_COIN>>(v0);
    }

    // decompiled from Move bytecode v6
}

