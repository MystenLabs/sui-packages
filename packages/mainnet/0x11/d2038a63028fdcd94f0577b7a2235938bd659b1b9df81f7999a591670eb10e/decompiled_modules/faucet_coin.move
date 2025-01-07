module 0x11d2038a63028fdcd94f0577b7a2235938bd659b1b9df81f7999a591670eb10e::faucet_coin {
    struct FAUCET_COIN has drop {
        dummy_field: bool,
    }

    public fun burn(arg0: &mut 0x2::coin::TreasuryCap<FAUCET_COIN>, arg1: 0x2::coin::Coin<FAUCET_COIN>) {
        let v0 = 0x1::ascii::string(b"burn");
        0x1::debug::print<0x1::ascii::String>(&v0);
        0x2::coin::burn<FAUCET_COIN>(arg0, arg1);
    }

    public fun mint(arg0: &mut 0x2::coin::TreasuryCap<FAUCET_COIN>, arg1: u64, arg2: address, arg3: &mut 0x2::tx_context::TxContext) {
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

