module 0x31517c9023c310e977ab765e6d46320f2f17a633df9b9e04420a051cbbd3b5fb::mycoin {
    struct MYCOIN has drop {
        dummy_field: bool,
    }

    struct Faucet has key {
        id: 0x2::object::UID,
        treasury_cap: 0x2::coin::TreasuryCap<MYCOIN>,
    }

    public entry fun burn(arg0: &mut Faucet, arg1: 0x2::coin::Coin<MYCOIN>) {
        0x2::coin::burn<MYCOIN>(&mut arg0.treasury_cap, arg1);
    }

    fun init(arg0: MYCOIN, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<MYCOIN>(arg0, 6, b"WETH", b"WETH", b"Wrapped Ether", 0x1::option::none<0x2::url::Url>(), arg1);
        let v2 = Faucet{
            id           : 0x2::object::new(arg1),
            treasury_cap : v0,
        };
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<MYCOIN>>(v1);
        0x2::transfer::share_object<Faucet>(v2);
    }

    public entry fun mint_from_faucet(arg0: &mut Faucet, arg1: u64, arg2: address, arg3: &mut 0x2::tx_context::TxContext) {
        0x2::coin::mint_and_transfer<MYCOIN>(&mut arg0.treasury_cap, arg1, arg2, arg3);
    }

    // decompiled from Move bytecode v6
}

