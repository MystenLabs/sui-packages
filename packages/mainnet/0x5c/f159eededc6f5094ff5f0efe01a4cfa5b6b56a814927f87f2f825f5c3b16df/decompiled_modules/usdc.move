module 0x5cf159eededc6f5094ff5f0efe01a4cfa5b6b56a814927f87f2f825f5c3b16df::usdc {
    struct USDC has drop {
        dummy_field: bool,
    }

    struct USDCGlobal has key {
        id: 0x2::object::UID,
        supply: 0x2::balance::Supply<USDC>,
    }

    public entry fun burn(arg0: &mut USDCGlobal, arg1: 0x2::coin::Coin<USDC>) {
        0x2::balance::decrease_supply<USDC>(&mut arg0.supply, 0x2::coin::into_balance<USDC>(arg1));
    }

    fun init(arg0: USDC, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<USDC>(arg0, 6, b"MOCK USDC TOKEN", b"MOCK-USDC", b"", 0x1::option::none<0x2::url::Url>(), arg1);
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<USDC>>(v1);
        let v2 = USDCGlobal{
            id     : 0x2::object::new(arg1),
            supply : 0x2::coin::treasury_into_supply<USDC>(v0),
        };
        0x2::transfer::share_object<USDCGlobal>(v2);
    }

    public entry fun mint(arg0: &mut USDCGlobal, arg1: u64, arg2: address, arg3: &mut 0x2::tx_context::TxContext) {
        0x2::transfer::public_transfer<0x2::coin::Coin<USDC>>(0x2::coin::from_balance<USDC>(0x2::balance::increase_supply<USDC>(&mut arg0.supply, arg1), arg3), arg2);
    }

    // decompiled from Move bytecode v6
}

