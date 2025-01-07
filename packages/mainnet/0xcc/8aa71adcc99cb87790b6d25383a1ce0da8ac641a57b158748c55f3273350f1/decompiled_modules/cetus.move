module 0xcc8aa71adcc99cb87790b6d25383a1ce0da8ac641a57b158748c55f3273350f1::cetus {
    struct CETUS has drop {
        dummy_field: bool,
    }

    struct CETUSSupply has key {
        id: 0x2::object::UID,
        cetus_supply: 0x2::balance::Supply<CETUS>,
    }

    struct InitEvent has copy, drop {
        sender: address,
        suplyID: 0x2::object::ID,
        decimals: u8,
    }

    public entry fun faucet(arg0: &mut CETUSSupply, arg1: &mut 0x2::tx_context::TxContext) {
        0x2::transfer::public_transfer<0x2::coin::Coin<CETUS>>(0x2::coin::from_balance<CETUS>(0x2::balance::increase_supply<CETUS>(&mut arg0.cetus_supply, 90000000000000000), arg1), 0x2::tx_context::sender(arg1));
    }

    fun init(arg0: CETUS, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<CETUS>(arg0, 9, b"CETUS", b"Cetus Token", b"", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe(0x1::ascii::string(b"https://uxcdefo3r2uemooidt2kk2stykakvwd2m6nasg5lhbfaxemm4i3a.arweave.net/pcQyFduOqEY5yBz0pWpTwoCq2HpnmgkbqzhKC5GM4jY"))), arg1);
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<CETUS>>(v1);
        let v2 = CETUSSupply{
            id           : 0x2::object::new(arg1),
            cetus_supply : 0x2::coin::treasury_into_supply<CETUS>(v0),
        };
        let v3 = InitEvent{
            sender   : 0x2::tx_context::sender(arg1),
            suplyID  : 0x2::object::id<CETUSSupply>(&v2),
            decimals : 8,
        };
        0x2::event::emit<InitEvent>(v3);
        let v4 = &mut v2;
        faucet(v4, arg1);
        0x2::transfer::share_object<CETUSSupply>(v2);
    }

    // decompiled from Move bytecode v6
}

