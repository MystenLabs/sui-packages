module 0x5e281293c2fd4debdb6bfb92553c28b0b48ec9ecc1955e4aeb599c9e3e16d671::huisqfaucet {
    struct HUISQFAUCET has drop {
        dummy_field: bool,
    }

    struct Wallet has key {
        id: 0x2::object::UID,
        coin: 0x2::balance::Balance<HUISQFAUCET>,
    }

    public entry fun mint(arg0: &mut 0x2::coin::TreasuryCap<HUISQFAUCET>, arg1: &mut Wallet, arg2: u64, arg3: &mut 0x2::tx_context::TxContext) {
        0x2::balance::join<HUISQFAUCET>(&mut arg1.coin, 0x2::coin::into_balance<HUISQFAUCET>(0x2::coin::mint<HUISQFAUCET>(arg0, arg2, arg3)));
    }

    public entry fun faucet(arg0: &mut Wallet, arg1: u64, arg2: &mut 0x2::tx_context::TxContext) {
        0x2::transfer::public_transfer<0x2::coin::Coin<HUISQFAUCET>>(0x2::coin::take<HUISQFAUCET>(&mut arg0.coin, arg1, arg2), 0x2::tx_context::sender(arg2));
    }

    fun init(arg0: HUISQFAUCET, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<HUISQFAUCET>(arg0, 6, b"HUISQFAUCET", b"", b"", 0x1::option::none<0x2::url::Url>(), arg1);
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<HUISQFAUCET>>(v1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<HUISQFAUCET>>(v0, 0x2::tx_context::sender(arg1));
        let v2 = Wallet{
            id   : 0x2::object::new(arg1),
            coin : 0x2::balance::zero<HUISQFAUCET>(),
        };
        0x2::transfer::share_object<Wallet>(v2);
    }

    // decompiled from Move bytecode v6
}

