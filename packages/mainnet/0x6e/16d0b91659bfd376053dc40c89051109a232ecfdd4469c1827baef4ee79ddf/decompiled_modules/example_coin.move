module 0x6e16d0b91659bfd376053dc40c89051109a232ecfdd4469c1827baef4ee79ddf::example_coin {
    struct EXAMPLE_COIN has drop {
        dummy_field: bool,
    }

    struct Faucet has key {
        id: 0x2::object::UID,
        cap: 0x2::coin::TreasuryCap<EXAMPLE_COIN>,
    }

    public fun faucet_mint(arg0: &mut Faucet, arg1: &mut 0x2::tx_context::TxContext) : 0x2::coin::Coin<EXAMPLE_COIN> {
        0x2::coin::mint<EXAMPLE_COIN>(&mut arg0.cap, 1000000, arg1)
    }

    public fun faucet_mint_balance(arg0: &mut Faucet) : 0x2::balance::Balance<EXAMPLE_COIN> {
        0x2::coin::mint_balance<EXAMPLE_COIN>(&mut arg0.cap, 1000000)
    }

    fun init(arg0: EXAMPLE_COIN, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<EXAMPLE_COIN>(arg0, 6, b"EXAMPLE_COIN", b"Example Coin", b"Example Coin", 0x1::option::none<0x2::url::Url>(), arg1);
        0x2::transfer::public_transfer<0x2::coin::CoinMetadata<EXAMPLE_COIN>>(v1, 0x2::tx_context::sender(arg1));
        let v2 = Faucet{
            id  : 0x2::object::new(arg1),
            cap : v0,
        };
        0x2::transfer::share_object<Faucet>(v2);
    }

    // decompiled from Move bytecode v6
}

