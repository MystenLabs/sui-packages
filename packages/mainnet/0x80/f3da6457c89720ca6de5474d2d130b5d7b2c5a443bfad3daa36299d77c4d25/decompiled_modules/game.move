module 0x80f3da6457c89720ca6de5474d2d130b5d7b2c5a443bfad3daa36299d77c4d25::game {
    struct GameStorage has key {
        id: 0x2::object::UID,
        playerBalance: 0x2::balance::Balance<0x5004eab7e42fd66ad3b7475632ae3070e9a4015f8f8976009e7e8637592e9d76::jp::JP>,
        admin_id: 0x2::object::ID,
    }

    struct PlayerEvent has copy, drop {
        player_address: address,
        pay_amount: u64,
        gain_amount: u64,
        fee: u64,
        guess: u8,
        result: u8,
    }

    struct DepositEvent has copy, drop {
        sender: address,
        from: u64,
        to: u64,
    }

    struct AdminCap has key {
        id: 0x2::object::UID,
    }

    public fun deposit(arg0: &mut GameStorage, arg1: 0x2::coin::Coin<0x5004eab7e42fd66ad3b7475632ae3070e9a4015f8f8976009e7e8637592e9d76::jp::JP>, arg2: u64, arg3: &mut 0x2::tx_context::TxContext) {
        let v0 = 0x2::tx_context::sender(arg3);
        if (0x2::coin::value<0x5004eab7e42fd66ad3b7475632ae3070e9a4015f8f8976009e7e8637592e9d76::jp::JP>(&arg1) == 0) {
            0x2::coin::destroy_zero<0x5004eab7e42fd66ad3b7475632ae3070e9a4015f8f8976009e7e8637592e9d76::jp::JP>(arg1);
        } else {
            0x2::transfer::public_transfer<0x2::coin::Coin<0x5004eab7e42fd66ad3b7475632ae3070e9a4015f8f8976009e7e8637592e9d76::jp::JP>>(arg1, v0);
        };
        0x2::balance::join<0x5004eab7e42fd66ad3b7475632ae3070e9a4015f8f8976009e7e8637592e9d76::jp::JP>(&mut arg0.playerBalance, 0x2::coin::into_balance<0x5004eab7e42fd66ad3b7475632ae3070e9a4015f8f8976009e7e8637592e9d76::jp::JP>(0x2::coin::split<0x5004eab7e42fd66ad3b7475632ae3070e9a4015f8f8976009e7e8637592e9d76::jp::JP>(&mut arg1, arg2, arg3)));
        let v1 = DepositEvent{
            sender : v0,
            from   : 0x2::balance::value<0x5004eab7e42fd66ad3b7475632ae3070e9a4015f8f8976009e7e8637592e9d76::jp::JP>(&arg0.playerBalance),
            to     : 0x2::balance::value<0x5004eab7e42fd66ad3b7475632ae3070e9a4015f8f8976009e7e8637592e9d76::jp::JP>(&arg0.playerBalance),
        };
        0x2::event::emit<DepositEvent>(v1);
    }

    public(friend) fun dice(arg0: &0x2::random::Random, arg1: &mut 0x2::tx_context::TxContext) : u8 {
        let v0 = 0x2::random::new_generator(arg0, arg1);
        0x2::random::generate_u8_in_range(&mut v0, 1, 3)
    }

    public fun get_balance(arg0: &GameStorage) : u64 {
        0x2::balance::value<0x5004eab7e42fd66ad3b7475632ae3070e9a4015f8f8976009e7e8637592e9d76::jp::JP>(&arg0.playerBalance)
    }

    fun init(arg0: &mut 0x2::tx_context::TxContext) {
        let v0 = AdminCap{id: 0x2::object::new(arg0)};
        let v1 = GameStorage{
            id            : 0x2::object::new(arg0),
            playerBalance : 0x2::balance::zero<0x5004eab7e42fd66ad3b7475632ae3070e9a4015f8f8976009e7e8637592e9d76::jp::JP>(),
            admin_id      : *0x2::object::uid_as_inner(&v0.id),
        };
        0x2::transfer::transfer<AdminCap>(v0, 0x2::tx_context::sender(arg0));
        0x2::transfer::share_object<GameStorage>(v1);
    }

    entry fun play(arg0: &mut GameStorage, arg1: &0x2::random::Random, arg2: 0x2::coin::Coin<0x5004eab7e42fd66ad3b7475632ae3070e9a4015f8f8976009e7e8637592e9d76::jp::JP>, arg3: u64, arg4: u8, arg5: &mut 0x2::tx_context::TxContext) {
        assert!(arg3 >= 20, 2);
        assert!(0x2::coin::value<0x5004eab7e42fd66ad3b7475632ae3070e9a4015f8f8976009e7e8637592e9d76::jp::JP>(&arg2) >= arg3, 3);
        let v0 = arg3 * 3;
        let v1 = v0 * 10 / 100;
        let v2 = v0 - v1;
        let v3 = v2 - arg3;
        let v4 = 0;
        let v5 = 0;
        let v6 = 0x2::balance::value<0x5004eab7e42fd66ad3b7475632ae3070e9a4015f8f8976009e7e8637592e9d76::jp::JP>(&arg0.playerBalance);
        0x80f3da6457c89720ca6de5474d2d130b5d7b2c5a443bfad3daa36299d77c4d25::utils::log<u64>(b"storage balance :", &v6);
        0x80f3da6457c89720ca6de5474d2d130b5d7b2c5a443bfad3daa36299d77c4d25::utils::log<u64>(b"add amount", &v3);
        assert!(0x2::balance::value<0x5004eab7e42fd66ad3b7475632ae3070e9a4015f8f8976009e7e8637592e9d76::jp::JP>(&arg0.playerBalance) >= v3, 1);
        let v7 = dice(arg1, arg5);
        if (arg4 == v7) {
            v4 = v2;
            v5 = v1;
            0x2::coin::join<0x5004eab7e42fd66ad3b7475632ae3070e9a4015f8f8976009e7e8637592e9d76::jp::JP>(&mut arg2, 0x2::coin::from_balance<0x5004eab7e42fd66ad3b7475632ae3070e9a4015f8f8976009e7e8637592e9d76::jp::JP>(0x2::balance::split<0x5004eab7e42fd66ad3b7475632ae3070e9a4015f8f8976009e7e8637592e9d76::jp::JP>(&mut arg0.playerBalance, v3), arg5));
        } else {
            0x2::balance::join<0x5004eab7e42fd66ad3b7475632ae3070e9a4015f8f8976009e7e8637592e9d76::jp::JP>(&mut arg0.playerBalance, 0x2::coin::into_balance<0x5004eab7e42fd66ad3b7475632ae3070e9a4015f8f8976009e7e8637592e9d76::jp::JP>(0x2::coin::split<0x5004eab7e42fd66ad3b7475632ae3070e9a4015f8f8976009e7e8637592e9d76::jp::JP>(&mut arg2, arg3, arg5)));
        };
        if (0x2::coin::value<0x5004eab7e42fd66ad3b7475632ae3070e9a4015f8f8976009e7e8637592e9d76::jp::JP>(&arg2) > 0) {
            0x2::transfer::public_transfer<0x2::coin::Coin<0x5004eab7e42fd66ad3b7475632ae3070e9a4015f8f8976009e7e8637592e9d76::jp::JP>>(arg2, 0x2::tx_context::sender(arg5));
        } else {
            0x2::coin::destroy_zero<0x5004eab7e42fd66ad3b7475632ae3070e9a4015f8f8976009e7e8637592e9d76::jp::JP>(arg2);
        };
        let v8 = PlayerEvent{
            player_address : 0x2::tx_context::sender(arg5),
            pay_amount     : arg3,
            gain_amount    : v4,
            fee            : v5,
            guess          : arg4,
            result         : v7,
        };
        0x2::event::emit<PlayerEvent>(v8);
    }

    entry fun withdraw(arg0: &AdminCap, arg1: &mut GameStorage, arg2: &mut 0x2::tx_context::TxContext) {
        assert!(0x2::object::uid_to_address(&arg0.id) == 0x2::object::id_to_address(&arg1.admin_id), 4);
        0x2::transfer::public_transfer<0x2::coin::Coin<0x5004eab7e42fd66ad3b7475632ae3070e9a4015f8f8976009e7e8637592e9d76::jp::JP>>(0x2::coin::from_balance<0x5004eab7e42fd66ad3b7475632ae3070e9a4015f8f8976009e7e8637592e9d76::jp::JP>(0x2::balance::split<0x5004eab7e42fd66ad3b7475632ae3070e9a4015f8f8976009e7e8637592e9d76::jp::JP>(&mut arg1.playerBalance, 0x2::balance::value<0x5004eab7e42fd66ad3b7475632ae3070e9a4015f8f8976009e7e8637592e9d76::jp::JP>(&arg1.playerBalance)), arg2), 0x2::tx_context::sender(arg2));
    }

    // decompiled from Move bytecode v6
}

