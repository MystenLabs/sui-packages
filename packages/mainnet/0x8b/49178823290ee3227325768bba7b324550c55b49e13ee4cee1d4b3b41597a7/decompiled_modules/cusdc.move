module 0x8b49178823290ee3227325768bba7b324550c55b49e13ee4cee1d4b3b41597a7::cusdc {
    struct CUSDC has drop {
        dummy_field: bool,
    }

    struct CUSDCTreasuryCoinfig has store, key {
        id: 0x2::object::UID,
        treasuryCap: 0x2::coin::TreasuryCap<CUSDC>,
    }

    public(friend) fun burn_csui(arg0: &mut CUSDCTreasuryCoinfig, arg1: 0x2::coin::Coin<CUSDC>) {
        0x2::coin::burn<CUSDC>(&mut arg0.treasuryCap, arg1);
    }

    fun init(arg0: CUSDC, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<CUSDC>(arg0, 6, b"cUSDC", b"cUSDC", b"cUSDC is a staking token of USDC", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe(0x1::ascii::string(b"https://cro-ag.pages.dev/cusdc.png"))), arg1);
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<CUSDC>>(v1);
        let v2 = CUSDCTreasuryCoinfig{
            id          : 0x2::object::new(arg1),
            treasuryCap : v0,
        };
        0x2::transfer::public_share_object<CUSDCTreasuryCoinfig>(v2);
    }

    public(friend) fun mint_csui(arg0: &mut CUSDCTreasuryCoinfig, arg1: u64, arg2: &mut 0x2::tx_context::TxContext) : 0x2::coin::Coin<CUSDC> {
        0x2::coin::mint<CUSDC>(&mut arg0.treasuryCap, arg1, arg2)
    }

    // decompiled from Move bytecode v6
}

