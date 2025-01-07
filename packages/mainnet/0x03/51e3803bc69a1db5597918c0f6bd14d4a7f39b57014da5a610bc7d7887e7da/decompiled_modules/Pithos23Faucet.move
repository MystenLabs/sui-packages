module 0x351e3803bc69a1db5597918c0f6bd14d4a7f39b57014da5a610bc7d7887e7da::Pithos23Faucet {
    struct TreasuryCapHolder has key {
        id: 0x2::object::UID,
        treasury: 0x2::coin::TreasuryCap<PITHOS23FAUCET>,
    }

    struct PITHOS23FAUCET has drop {
        dummy_field: bool,
    }

    entry fun mint(arg0: &mut TreasuryCapHolder, arg1: &mut 0x2::tx_context::TxContext) {
        0x2::transfer::public_transfer<0x2::coin::Coin<PITHOS23FAUCET>>(0x2::coin::mint<PITHOS23FAUCET>(&mut arg0.treasury, 100000000, arg1), 0x2::tx_context::sender(arg1));
    }

    fun init(arg0: PITHOS23FAUCET, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<PITHOS23FAUCET>(arg0, 6, b"Pithos23Faucet", b"Pithos23Faucet", b"Pithos23 Faucet des.", 0x1::option::none<0x2::url::Url>(), arg1);
        let v2 = TreasuryCapHolder{
            id       : 0x2::object::new(arg1),
            treasury : v0,
        };
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<PITHOS23FAUCET>>(v1);
        0x2::transfer::share_object<TreasuryCapHolder>(v2);
    }

    // decompiled from Move bytecode v6
}

