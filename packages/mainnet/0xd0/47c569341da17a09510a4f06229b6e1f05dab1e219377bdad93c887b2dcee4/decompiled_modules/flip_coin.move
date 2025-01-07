module 0xd047c569341da17a09510a4f06229b6e1f05dab1e219377bdad93c887b2dcee4::flip_coin {
    struct Game has key {
        id: 0x2::object::UID,
        val: 0x2::balance::Balance<0x8ee56689c2e689b501efdcfd74a0a1db4e87aa9a50eba47057cc1322a16d8d0e::faucet_coin::FAUCET_COIN>,
    }

    struct AdminCap has key {
        id: 0x2::object::UID,
    }

    public entry fun add_sui(arg0: &mut Game, arg1: 0x2::coin::Coin<0x8ee56689c2e689b501efdcfd74a0a1db4e87aa9a50eba47057cc1322a16d8d0e::faucet_coin::FAUCET_COIN>, arg2: &0x2::tx_context::TxContext) {
        0x2::balance::join<0x8ee56689c2e689b501efdcfd74a0a1db4e87aa9a50eba47057cc1322a16d8d0e::faucet_coin::FAUCET_COIN>(&mut arg0.val, 0x2::coin::into_balance<0x8ee56689c2e689b501efdcfd74a0a1db4e87aa9a50eba47057cc1322a16d8d0e::faucet_coin::FAUCET_COIN>(arg1));
    }

    fun init(arg0: &mut 0x2::tx_context::TxContext) {
        let v0 = Game{
            id  : 0x2::object::new(arg0),
            val : 0x2::balance::zero<0x8ee56689c2e689b501efdcfd74a0a1db4e87aa9a50eba47057cc1322a16d8d0e::faucet_coin::FAUCET_COIN>(),
        };
        0x2::transfer::share_object<Game>(v0);
        let v1 = AdminCap{id: 0x2::object::new(arg0)};
        0x2::transfer::transfer<AdminCap>(v1, 0x2::tx_context::sender(arg0));
    }

    public entry fun play(arg0: &mut Game, arg1: bool, arg2: 0x2::coin::Coin<0x8ee56689c2e689b501efdcfd74a0a1db4e87aa9a50eba47057cc1322a16d8d0e::faucet_coin::FAUCET_COIN>, arg3: &0x2::random::Random, arg4: &mut 0x2::tx_context::TxContext) {
        let v0 = 0x2::coin::value<0x8ee56689c2e689b501efdcfd74a0a1db4e87aa9a50eba47057cc1322a16d8d0e::faucet_coin::FAUCET_COIN>(&arg2);
        assert!(0x2::balance::value<0x8ee56689c2e689b501efdcfd74a0a1db4e87aa9a50eba47057cc1322a16d8d0e::faucet_coin::FAUCET_COIN>(&arg0.val) > v0, 256);
        let v1 = 0x2::random::new_generator(arg3, arg4);
        if (arg1 == 0x2::random::generate_bool(&mut v1)) {
            0x2::transfer::public_transfer<0x2::coin::Coin<0x8ee56689c2e689b501efdcfd74a0a1db4e87aa9a50eba47057cc1322a16d8d0e::faucet_coin::FAUCET_COIN>>(0x2::coin::from_balance<0x8ee56689c2e689b501efdcfd74a0a1db4e87aa9a50eba47057cc1322a16d8d0e::faucet_coin::FAUCET_COIN>(0x2::balance::split<0x8ee56689c2e689b501efdcfd74a0a1db4e87aa9a50eba47057cc1322a16d8d0e::faucet_coin::FAUCET_COIN>(&mut arg0.val, v0), arg4), 0x2::tx_context::sender(arg4));
            0x2::transfer::public_transfer<0x2::coin::Coin<0x8ee56689c2e689b501efdcfd74a0a1db4e87aa9a50eba47057cc1322a16d8d0e::faucet_coin::FAUCET_COIN>>(arg2, 0x2::tx_context::sender(arg4));
        } else {
            0x2::balance::join<0x8ee56689c2e689b501efdcfd74a0a1db4e87aa9a50eba47057cc1322a16d8d0e::faucet_coin::FAUCET_COIN>(&mut arg0.val, 0x2::coin::into_balance<0x8ee56689c2e689b501efdcfd74a0a1db4e87aa9a50eba47057cc1322a16d8d0e::faucet_coin::FAUCET_COIN>(arg2));
        };
    }

    public entry fun remove_sui(arg0: &AdminCap, arg1: &mut Game, arg2: u64, arg3: &mut 0x2::tx_context::TxContext) {
        0x2::transfer::public_transfer<0x2::coin::Coin<0x8ee56689c2e689b501efdcfd74a0a1db4e87aa9a50eba47057cc1322a16d8d0e::faucet_coin::FAUCET_COIN>>(0x2::coin::from_balance<0x8ee56689c2e689b501efdcfd74a0a1db4e87aa9a50eba47057cc1322a16d8d0e::faucet_coin::FAUCET_COIN>(0x2::balance::split<0x8ee56689c2e689b501efdcfd74a0a1db4e87aa9a50eba47057cc1322a16d8d0e::faucet_coin::FAUCET_COIN>(&mut arg1.val, arg2), arg3), 0x2::tx_context::sender(arg3));
    }

    // decompiled from Move bytecode v6
}

