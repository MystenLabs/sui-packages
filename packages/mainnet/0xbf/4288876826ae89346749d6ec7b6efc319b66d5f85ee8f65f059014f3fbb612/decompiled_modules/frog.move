module 0xbf4288876826ae89346749d6ec7b6efc319b66d5f85ee8f65f059014f3fbb612::frog {
    struct FROG has drop {
        dummy_field: bool,
    }

    struct TreasurySupply has key {
        id: 0x2::object::UID,
        eco_part: 0x2::balance::Balance<FROG>,
        total_supply: 0x2::balance::Supply<FROG>,
    }

    public entry fun transfer(arg0: 0x2::coin::Coin<FROG>, arg1: address) {
        0x2::transfer::public_transfer<0x2::coin::Coin<FROG>>(arg0, arg1);
    }

    fun init(arg0: FROG, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<FROG>(arg0, 9, b"DRG", b"Drog", b"Native Currency of Frog Protocol!", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe(0x1::ascii::string(b"https://i.ibb.co/pvyLdDh/animal.png"))), arg1);
        let v2 = v0;
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<FROG>>(v1);
        0x2::coin::mint_and_transfer<FROG>(&mut v2, 10000000000000000000, @0x8f6ff638438081e30f3c823e83778118947e617f9d8ab08eca8613d724d77335, arg1);
        let v3 = TreasurySupply{
            id           : 0x2::object::new(arg1),
            eco_part     : 0x2::coin::mint_balance<FROG>(&mut v2, 20000000000),
            total_supply : 0x2::coin::treasury_into_supply<FROG>(v2),
        };
        0x2::transfer::freeze_object<TreasurySupply>(v3);
    }

    // decompiled from Move bytecode v6
}

