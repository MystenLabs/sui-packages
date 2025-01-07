module 0xcc8aa71adcc99cb87790b6d25383a1ce0da8ac641a57b158748c55f3273350f1::usdc {
    struct USDC has drop {
        dummy_field: bool,
    }

    struct USDCSupply has key {
        id: 0x2::object::UID,
        usdc_supply: 0x2::balance::Supply<USDC>,
    }

    struct InitEvent has copy, drop {
        sender: address,
        suplyID: 0x2::object::ID,
        decimals: u8,
    }

    public entry fun faucet(arg0: &mut USDCSupply, arg1: &mut 0x2::tx_context::TxContext) {
        0x2::transfer::public_transfer<0x2::coin::Coin<USDC>>(0x2::coin::from_balance<USDC>(0x2::balance::increase_supply<USDC>(&mut arg0.usdc_supply, 20000000000000), arg1), 0x2::tx_context::sender(arg1));
    }

    fun init(arg0: USDC, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<USDC>(arg0, 6, b"CUSDC", b"CUSDC", b"", 0x1::option::none<0x2::url::Url>(), arg1);
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<USDC>>(v1);
        let v2 = USDCSupply{
            id          : 0x2::object::new(arg1),
            usdc_supply : 0x2::coin::treasury_into_supply<USDC>(v0),
        };
        let v3 = InitEvent{
            sender   : 0x2::tx_context::sender(arg1),
            suplyID  : 0x2::object::id<USDCSupply>(&v2),
            decimals : 6,
        };
        0x2::event::emit<InitEvent>(v3);
        let v4 = &mut v2;
        faucet(v4, arg1);
        0x2::transfer::share_object<USDCSupply>(v2);
    }

    // decompiled from Move bytecode v6
}

