module 0x1217d5c65d23488dc7f69af23a3fc751ef823f48eb604c356ed925d79cb66e39::principal_token {
    struct PRINCIPAL_TOKEN has drop {
        dummy_field: bool,
    }

    struct MintAuthority has key {
        id: 0x2::object::UID,
        treasury: 0x2::coin::TreasuryCap<PRINCIPAL_TOKEN>,
    }

    public(friend) fun burn(arg0: &mut MintAuthority, arg1: 0x2::coin::Coin<PRINCIPAL_TOKEN>) : u64 {
        0x2::coin::burn<PRINCIPAL_TOKEN>(&mut arg0.treasury, arg1)
    }

    public(friend) fun mint(arg0: &mut MintAuthority, arg1: u64, arg2: &mut 0x2::tx_context::TxContext) : 0x2::coin::Coin<PRINCIPAL_TOKEN> {
        0x2::coin::mint<PRINCIPAL_TOKEN>(&mut arg0.treasury, arg1, arg2)
    }

    fun init(arg0: PRINCIPAL_TOKEN, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<PRINCIPAL_TOKEN>(arg0, 9, b"PT", b"Principal Token", b"Redeemable for finalized SUI principal at maturity", 0x1::option::none<0x2::url::Url>(), arg1);
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<PRINCIPAL_TOKEN>>(v1);
        let v2 = MintAuthority{
            id       : 0x2::object::new(arg1),
            treasury : v0,
        };
        0x2::transfer::share_object<MintAuthority>(v2);
    }

    // decompiled from Move bytecode v7
}

