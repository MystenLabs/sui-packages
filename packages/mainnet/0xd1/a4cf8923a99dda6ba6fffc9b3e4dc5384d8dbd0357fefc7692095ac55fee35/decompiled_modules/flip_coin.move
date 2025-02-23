module 0xd1a4cf8923a99dda6ba6fffc9b3e4dc5384d8dbd0357fefc7692095ac55fee35::flip_coin {
    struct Game has key {
        id: 0x2::object::UID,
        balance: 0x2::balance::Balance<0xf9896d706d2461eb997a42f53ef8ddcd1b77e622516ae95166e9cad1e102723e::faucet_coin::FAUCET_COIN>,
    }

    struct AdminCap has key {
        id: 0x2::object::UID,
    }

    public entry fun deposit(arg0: &mut Game, arg1: 0x2::coin::Coin<0xf9896d706d2461eb997a42f53ef8ddcd1b77e622516ae95166e9cad1e102723e::faucet_coin::FAUCET_COIN>, arg2: &mut 0x2::tx_context::TxContext) {
        0x2::balance::join<0xf9896d706d2461eb997a42f53ef8ddcd1b77e622516ae95166e9cad1e102723e::faucet_coin::FAUCET_COIN>(&mut arg0.balance, 0x2::coin::into_balance<0xf9896d706d2461eb997a42f53ef8ddcd1b77e622516ae95166e9cad1e102723e::faucet_coin::FAUCET_COIN>(arg1));
    }

    fun init(arg0: &mut 0x2::tx_context::TxContext) {
        let v0 = Game{
            id      : 0x2::object::new(arg0),
            balance : 0x2::balance::zero<0xf9896d706d2461eb997a42f53ef8ddcd1b77e622516ae95166e9cad1e102723e::faucet_coin::FAUCET_COIN>(),
        };
        0x2::transfer::share_object<Game>(v0);
        let v1 = AdminCap{id: 0x2::object::new(arg0)};
        0x2::transfer::transfer<AdminCap>(v1, 0x2::tx_context::sender(arg0));
    }

    entry fun play(arg0: &mut Game, arg1: &0x2::random::Random, arg2: bool, arg3: 0x2::coin::Coin<0xf9896d706d2461eb997a42f53ef8ddcd1b77e622516ae95166e9cad1e102723e::faucet_coin::FAUCET_COIN>, arg4: &mut 0x2::tx_context::TxContext) {
        let v0 = 0x2::coin::value<0xf9896d706d2461eb997a42f53ef8ddcd1b77e622516ae95166e9cad1e102723e::faucet_coin::FAUCET_COIN>(&arg3);
        assert!(0x2::balance::value<0xf9896d706d2461eb997a42f53ef8ddcd1b77e622516ae95166e9cad1e102723e::faucet_coin::FAUCET_COIN>(&arg0.balance) >= v0 * 10, 1);
        let v1 = 0x2::random::new_generator(arg1, arg4);
        if (arg2 == 0x2::random::generate_bool(&mut v1)) {
            0x2::transfer::public_transfer<0x2::coin::Coin<0xf9896d706d2461eb997a42f53ef8ddcd1b77e622516ae95166e9cad1e102723e::faucet_coin::FAUCET_COIN>>(0x2::coin::from_balance<0xf9896d706d2461eb997a42f53ef8ddcd1b77e622516ae95166e9cad1e102723e::faucet_coin::FAUCET_COIN>(0x2::balance::split<0xf9896d706d2461eb997a42f53ef8ddcd1b77e622516ae95166e9cad1e102723e::faucet_coin::FAUCET_COIN>(&mut arg0.balance, v0), arg4), 0x2::tx_context::sender(arg4));
            0x2::transfer::public_transfer<0x2::coin::Coin<0xf9896d706d2461eb997a42f53ef8ddcd1b77e622516ae95166e9cad1e102723e::faucet_coin::FAUCET_COIN>>(arg3, 0x2::tx_context::sender(arg4));
        } else {
            0x2::balance::join<0xf9896d706d2461eb997a42f53ef8ddcd1b77e622516ae95166e9cad1e102723e::faucet_coin::FAUCET_COIN>(&mut arg0.balance, 0x2::coin::into_balance<0xf9896d706d2461eb997a42f53ef8ddcd1b77e622516ae95166e9cad1e102723e::faucet_coin::FAUCET_COIN>(arg3));
        };
    }

    public entry fun withdraw(arg0: &AdminCap, arg1: &mut Game, arg2: u64, arg3: &mut 0x2::tx_context::TxContext) {
        0x2::transfer::public_transfer<0x2::coin::Coin<0xf9896d706d2461eb997a42f53ef8ddcd1b77e622516ae95166e9cad1e102723e::faucet_coin::FAUCET_COIN>>(0x2::coin::from_balance<0xf9896d706d2461eb997a42f53ef8ddcd1b77e622516ae95166e9cad1e102723e::faucet_coin::FAUCET_COIN>(0x2::balance::split<0xf9896d706d2461eb997a42f53ef8ddcd1b77e622516ae95166e9cad1e102723e::faucet_coin::FAUCET_COIN>(&mut arg1.balance, arg2), arg3), 0x2::tx_context::sender(arg3));
    }

    // decompiled from Move bytecode v6
}

