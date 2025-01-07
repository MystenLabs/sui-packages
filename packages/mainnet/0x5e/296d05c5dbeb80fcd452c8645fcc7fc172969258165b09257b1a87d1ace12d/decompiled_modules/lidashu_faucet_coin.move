module 0x5e296d05c5dbeb80fcd452c8645fcc7fc172969258165b09257b1a87d1ace12d::lidashu_faucet_coin {
    struct LIDASHU_FAUCET_COIN has drop {
        dummy_field: bool,
    }

    struct Faucet has key {
        id: 0x2::object::UID,
        amount: u64,
        balance: 0x2::balance::Balance<LIDASHU_FAUCET_COIN>,
    }

    public fun burn(arg0: &mut 0x2::coin::TreasuryCap<LIDASHU_FAUCET_COIN>, arg1: 0x2::coin::Coin<LIDASHU_FAUCET_COIN>) {
        0x2::coin::burn<LIDASHU_FAUCET_COIN>(arg0, arg1);
    }

    public fun mint(arg0: &mut 0x2::coin::TreasuryCap<LIDASHU_FAUCET_COIN>, arg1: u64, arg2: address, arg3: &mut 0x2::tx_context::TxContext) {
        0x2::coin::mint_and_transfer<LIDASHU_FAUCET_COIN>(arg0, arg1, arg2, arg3);
    }

    public fun faucet_create(arg0: &mut 0x2::coin::TreasuryCap<LIDASHU_FAUCET_COIN>, arg1: &mut Faucet, arg2: &mut 0x2::tx_context::TxContext) {
        let v0 = 0x2::coin::mint<LIDASHU_FAUCET_COIN>(arg0, 1000000000, arg2);
        0x2::balance::join<LIDASHU_FAUCET_COIN>(&mut arg1.balance, 0x2::balance::split<LIDASHU_FAUCET_COIN>(0x2::coin::balance_mut<LIDASHU_FAUCET_COIN>(&mut v0), 1000000000));
        0x2::transfer::public_transfer<0x2::coin::Coin<LIDASHU_FAUCET_COIN>>(v0, 0x2::tx_context::sender(arg2));
    }

    public entry fun faucet_mint(arg0: &mut Faucet, arg1: &mut 0x2::tx_context::TxContext) {
        0x2::transfer::public_transfer<0x2::coin::Coin<LIDASHU_FAUCET_COIN>>(0x2::coin::take<LIDASHU_FAUCET_COIN>(&mut arg0.balance, arg0.amount, arg1), 0x2::tx_context::sender(arg1));
    }

    fun init(arg0: LIDASHU_FAUCET_COIN, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<LIDASHU_FAUCET_COIN>(arg0, 6, b"LDSF", b"LIDASHU faucet coin", b"LDSF mint for all", 0x1::option::none<0x2::url::Url>(), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<LIDASHU_FAUCET_COIN>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<LIDASHU_FAUCET_COIN>>(v1);
        let v2 = Faucet{
            id      : 0x2::object::new(arg1),
            amount  : 10000000,
            balance : 0x2::balance::zero<LIDASHU_FAUCET_COIN>(),
        };
        0x2::transfer::share_object<Faucet>(v2);
    }

    // decompiled from Move bytecode v6
}

