module 0x865f07b88b9eb8b74973e0b85517ee0a83adef11644362f62e6229a30c465b31::hps {
    struct HPS has drop {
        dummy_field: bool,
    }

    struct HpsMinted has copy, drop {
        recipient: address,
        amount_units: u64,
    }

    struct HpsBurned has copy, drop {
        amount_units: u64,
    }

    public fun burn(arg0: &mut 0x2::coin::TreasuryCap<HPS>, arg1: 0x2::coin::Coin<HPS>) {
        let v0 = 0x2::coin::value<HPS>(&arg1);
        assert!(v0 > 0, 1);
        0x2::coin::burn<HPS>(arg0, arg1);
        let v1 = HpsBurned{amount_units: v0};
        0x2::event::emit<HpsBurned>(v1);
    }

    public fun total_supply(arg0: &0x2::coin::TreasuryCap<HPS>) : u64 {
        0x2::coin::total_supply<HPS>(arg0)
    }

    public fun transfer(arg0: 0x2::coin::Coin<HPS>, arg1: address, arg2: &mut 0x2::tx_context::TxContext) {
        0x2::transfer::public_transfer<0x2::coin::Coin<HPS>>(arg0, arg1);
    }

    fun init(arg0: HPS, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<HPS>(arg0, 6, b"HPS", b"HardwarePlay Stablecoin", b"EUR-pegged stablecoin issued by HardwarePlay. 1 HPS = EUR 1.00", 0x1::option::none<0x2::url::Url>(), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<HPS>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<HPS>>(v1);
    }

    public fun mint(arg0: &mut 0x2::coin::TreasuryCap<HPS>, arg1: u64, arg2: address, arg3: &mut 0x2::tx_context::TxContext) {
        assert!(arg1 > 0, 1);
        0x2::coin::mint_and_transfer<HPS>(arg0, arg1, arg2, arg3);
        let v0 = HpsMinted{
            recipient    : arg2,
            amount_units : arg1,
        };
        0x2::event::emit<HpsMinted>(v0);
    }

    // decompiled from Move bytecode v7
}

