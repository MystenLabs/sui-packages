module 0xab22f4f8d2d80d83d33cd7dd3980c25fee6e99ad2a90459851af66961f189b22::rock_paper_scissors {
    struct Game has key {
        id: 0x2::object::UID,
        balance: 0x2::balance::Balance<0x6c4332ec49ac2262615fa10432a598a5aea2bf0bc35679bdafbe2720c49921d6::faucet_coin::FAUCET_COIN>,
        game_name: vector<u8>,
    }

    struct Admin has key {
        id: 0x2::object::UID,
    }

    public entry fun Play(arg0: &mut Game, arg1: &0x2::random::Random, arg2: u8, arg3: &mut 0x2::coin::Coin<0x6c4332ec49ac2262615fa10432a598a5aea2bf0bc35679bdafbe2720c49921d6::faucet_coin::FAUCET_COIN>, arg4: u64, arg5: &mut 0x2::tx_context::TxContext) {
        assert!(0x2::balance::value<0x6c4332ec49ac2262615fa10432a598a5aea2bf0bc35679bdafbe2720c49921d6::faucet_coin::FAUCET_COIN>(&arg0.balance) >= arg4, 1001);
        assert!(0x2::coin::value<0x6c4332ec49ac2262615fa10432a598a5aea2bf0bc35679bdafbe2720c49921d6::faucet_coin::FAUCET_COIN>(arg3) >= arg4, 1000);
        let v0 = 0x2::random::new_generator(arg1, arg5);
        let v1 = 0x2::random::generate_u8(&mut v0) % 3;
        let v2 = if (arg2 == 0 && v1 == 1) {
            true
        } else if (arg2 == 1 && v1 == 2) {
            true
        } else {
            arg2 == 2 && v1 == 0
        };
        if (v2) {
            0x2::coin::join<0x6c4332ec49ac2262615fa10432a598a5aea2bf0bc35679bdafbe2720c49921d6::faucet_coin::FAUCET_COIN>(arg3, 0x2::coin::take<0x6c4332ec49ac2262615fa10432a598a5aea2bf0bc35679bdafbe2720c49921d6::faucet_coin::FAUCET_COIN>(&mut arg0.balance, arg4, arg5));
        } else if (arg2 == v1) {
        } else {
            deposit(arg0, arg3, arg4, arg5);
        };
    }

    public entry fun deposit(arg0: &mut Game, arg1: &mut 0x2::coin::Coin<0x6c4332ec49ac2262615fa10432a598a5aea2bf0bc35679bdafbe2720c49921d6::faucet_coin::FAUCET_COIN>, arg2: u64, arg3: &mut 0x2::tx_context::TxContext) {
        assert!(0x2::coin::value<0x6c4332ec49ac2262615fa10432a598a5aea2bf0bc35679bdafbe2720c49921d6::faucet_coin::FAUCET_COIN>(arg1) >= arg2, 1000);
        0x2::balance::join<0x6c4332ec49ac2262615fa10432a598a5aea2bf0bc35679bdafbe2720c49921d6::faucet_coin::FAUCET_COIN>(&mut arg0.balance, 0x2::balance::split<0x6c4332ec49ac2262615fa10432a598a5aea2bf0bc35679bdafbe2720c49921d6::faucet_coin::FAUCET_COIN>(0x2::coin::balance_mut<0x6c4332ec49ac2262615fa10432a598a5aea2bf0bc35679bdafbe2720c49921d6::faucet_coin::FAUCET_COIN>(arg1), arg2));
    }

    fun init(arg0: &mut 0x2::tx_context::TxContext) {
        let v0 = Game{
            id        : 0x2::object::new(arg0),
            balance   : 0x2::balance::zero<0x6c4332ec49ac2262615fa10432a598a5aea2bf0bc35679bdafbe2720c49921d6::faucet_coin::FAUCET_COIN>(),
            game_name : b"y_v's rock_paper_scissors GAME",
        };
        0x2::transfer::share_object<Game>(v0);
        let v1 = Admin{id: 0x2::object::new(arg0)};
        0x2::transfer::transfer<Admin>(v1, 0x2::tx_context::sender(arg0));
    }

    public entry fun withdraw(arg0: &mut Game, arg1: &Admin, arg2: u64, arg3: &mut 0x2::tx_context::TxContext) {
        assert!(0x2::balance::value<0x6c4332ec49ac2262615fa10432a598a5aea2bf0bc35679bdafbe2720c49921d6::faucet_coin::FAUCET_COIN>(&arg0.balance) >= arg2, 1001);
        0x2::transfer::public_transfer<0x2::coin::Coin<0x6c4332ec49ac2262615fa10432a598a5aea2bf0bc35679bdafbe2720c49921d6::faucet_coin::FAUCET_COIN>>(0x2::coin::take<0x6c4332ec49ac2262615fa10432a598a5aea2bf0bc35679bdafbe2720c49921d6::faucet_coin::FAUCET_COIN>(&mut arg0.balance, arg2, arg3), 0x2::tx_context::sender(arg3));
    }

    // decompiled from Move bytecode v6
}

