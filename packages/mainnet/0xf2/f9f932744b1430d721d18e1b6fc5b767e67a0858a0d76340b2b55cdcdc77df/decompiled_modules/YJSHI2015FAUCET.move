module 0xf2f9f932744b1430d721d18e1b6fc5b767e67a0858a0d76340b2b55cdcdc77df::YJSHI2015FAUCET {
    struct YJSHI2015FAUCET has drop {
        dummy_field: bool,
    }

    struct MintEvent has copy, drop {
        recipient: address,
        amount: u64,
    }

    public fun mint(arg0: &mut 0x2::coin::TreasuryCap<YJSHI2015FAUCET>, arg1: u64, arg2: address, arg3: &mut 0x2::tx_context::TxContext) {
        0x2::transfer::public_transfer<0x2::coin::Coin<YJSHI2015FAUCET>>(0x2::coin::mint<YJSHI2015FAUCET>(arg0, arg1, arg3), arg2);
        let v0 = MintEvent{
            recipient : arg2,
            amount    : arg1,
        };
        0x2::event::emit<MintEvent>(v0);
    }

    fun init(arg0: YJSHI2015FAUCET, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<YJSHI2015FAUCET>(arg0, 9, b"YJSHI2015FAUCET", b"YJSHI2015FAUCET", b"yjshi2015's faucet coin", 0x1::option::none<0x2::url::Url>(), arg1);
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<YJSHI2015FAUCET>>(v1);
        0x2::transfer::public_share_object<0x2::coin::TreasuryCap<YJSHI2015FAUCET>>(v0);
    }

    // decompiled from Move bytecode v6
}

