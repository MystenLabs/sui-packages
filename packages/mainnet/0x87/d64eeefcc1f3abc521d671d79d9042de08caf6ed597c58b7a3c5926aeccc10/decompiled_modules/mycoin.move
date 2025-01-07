module 0x87d64eeefcc1f3abc521d671d79d9042de08caf6ed597c58b7a3c5926aeccc10::mycoin {
    struct MYCOIN has drop {
        dummy_field: bool,
    }

    struct SupplyHold has key {
        id: 0x2::object::UID,
        supply: 0x2::balance::Supply<MYCOIN>,
    }

    fun init(arg0: MYCOIN, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<MYCOIN>(arg0, 6, b"MYCOIN", b"", b"", 0x1::option::none<0x2::url::Url>(), arg1);
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<MYCOIN>>(v1);
        let v2 = SupplyHold{
            id     : 0x2::object::new(arg1),
            supply : 0x2::coin::treasury_into_supply<MYCOIN>(v0),
        };
        0x2::transfer::transfer<SupplyHold>(v2, 0x2::tx_context::sender(arg1));
    }

    public fun mint(arg0: &mut SupplyHold, arg1: u64, arg2: &mut 0x2::tx_context::TxContext) : 0x2::coin::Coin<MYCOIN> {
        0x2::coin::from_balance<MYCOIN>(0x2::balance::increase_supply<MYCOIN>(&mut arg0.supply, arg1), arg2)
    }

    public entry fun mint_to(arg0: &mut SupplyHold, arg1: u64, arg2: address, arg3: &mut 0x2::tx_context::TxContext) {
        0x2::transfer::public_transfer<0x2::coin::Coin<MYCOIN>>(mint(arg0, arg1, arg3), arg2);
    }

    // decompiled from Move bytecode v6
}

