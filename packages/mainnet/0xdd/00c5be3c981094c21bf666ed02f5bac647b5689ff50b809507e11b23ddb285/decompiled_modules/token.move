module 0xdd00c5be3c981094c21bf666ed02f5bac647b5689ff50b809507e11b23ddb285::token {
    struct TOKEN has drop {
        dummy_field: bool,
    }

    struct Minter has key {
        id: 0x2::object::UID,
        treasury_cap: 0x2::coin::TreasuryCap<TOKEN>,
    }

    public fun mint(arg0: &mut Minter, arg1: u64, arg2: &mut 0x2::tx_context::TxContext) : 0x2::coin::Coin<TOKEN> {
        0x2::coin::mint<TOKEN>(&mut arg0.treasury_cap, arg1, arg2)
    }

    fun init(arg0: TOKEN, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<TOKEN>(arg0, 9, b"TEST", b"Test Inflow Token", b"Token for testing wallet inflow display", 0x1::option::none<0x2::url::Url>(), arg1);
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<TOKEN>>(v1);
        let v2 = Minter{
            id           : 0x2::object::new(arg1),
            treasury_cap : v0,
        };
        0x2::transfer::share_object<Minter>(v2);
    }

    public entry fun mint_and_transfer(arg0: &mut Minter, arg1: u64, arg2: address, arg3: &mut 0x2::tx_context::TxContext) {
        0x2::transfer::public_transfer<0x2::coin::Coin<TOKEN>>(mint(arg0, arg1, arg3), arg2);
    }

    // decompiled from Move bytecode v6
}

