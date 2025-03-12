module 0x60b2e8e63d77b8e743f6a4496cdadcc1e48a60ca1f680d459b54696703b144eb::task4 {
    struct Game has key {
        id: 0x2::object::UID,
        balance: 0x2::balance::Balance<0x7bf8b3f969a6964569a3664c8d82c7495203272a81d5ec7c7ea62d2a3d001af8::ydamwfaucet::YDAMWFAUCET>,
    }

    struct AdminCap has key {
        id: 0x2::object::UID,
    }

    public entry fun add_coin(arg0: &mut Game, arg1: 0x2::coin::Coin<0x7bf8b3f969a6964569a3664c8d82c7495203272a81d5ec7c7ea62d2a3d001af8::ydamwfaucet::YDAMWFAUCET>, arg2: &mut 0x2::tx_context::TxContext) {
        0x2::balance::join<0x7bf8b3f969a6964569a3664c8d82c7495203272a81d5ec7c7ea62d2a3d001af8::ydamwfaucet::YDAMWFAUCET>(&mut arg0.balance, 0x2::coin::into_balance<0x7bf8b3f969a6964569a3664c8d82c7495203272a81d5ec7c7ea62d2a3d001af8::ydamwfaucet::YDAMWFAUCET>(arg1));
    }

    fun init(arg0: &mut 0x2::tx_context::TxContext) {
        let v0 = Game{
            id      : 0x2::object::new(arg0),
            balance : 0x2::balance::zero<0x7bf8b3f969a6964569a3664c8d82c7495203272a81d5ec7c7ea62d2a3d001af8::ydamwfaucet::YDAMWFAUCET>(),
        };
        0x2::transfer::share_object<Game>(v0);
        let v1 = AdminCap{id: 0x2::object::new(arg0)};
        0x2::transfer::transfer<AdminCap>(v1, 0x2::tx_context::sender(arg0));
    }

    entry fun play(arg0: &mut Game, arg1: u8, arg2: 0x2::coin::Coin<0x7bf8b3f969a6964569a3664c8d82c7495203272a81d5ec7c7ea62d2a3d001af8::ydamwfaucet::YDAMWFAUCET>, arg3: &0x2::random::Random, arg4: &mut 0x2::tx_context::TxContext) {
        let v0 = 0x2::coin::value<0x7bf8b3f969a6964569a3664c8d82c7495203272a81d5ec7c7ea62d2a3d001af8::ydamwfaucet::YDAMWFAUCET>(&arg2);
        assert!(0x2::balance::value<0x7bf8b3f969a6964569a3664c8d82c7495203272a81d5ec7c7ea62d2a3d001af8::ydamwfaucet::YDAMWFAUCET>(&arg0.balance) >= v0 * 10, 100);
        if (arg1 < 1 || arg1 > 3) {
            abort 101
        };
        let v1 = 0x2::random::new_generator(arg3, arg4);
        if (arg1 == 0x2::random::generate_u8_in_range(&mut v1, 1, 3)) {
            0x2::transfer::public_transfer<0x2::coin::Coin<0x7bf8b3f969a6964569a3664c8d82c7495203272a81d5ec7c7ea62d2a3d001af8::ydamwfaucet::YDAMWFAUCET>>(0x2::coin::from_balance<0x7bf8b3f969a6964569a3664c8d82c7495203272a81d5ec7c7ea62d2a3d001af8::ydamwfaucet::YDAMWFAUCET>(0x2::balance::split<0x7bf8b3f969a6964569a3664c8d82c7495203272a81d5ec7c7ea62d2a3d001af8::ydamwfaucet::YDAMWFAUCET>(&mut arg0.balance, v0), arg4), 0x2::tx_context::sender(arg4));
            0x2::transfer::public_transfer<0x2::coin::Coin<0x7bf8b3f969a6964569a3664c8d82c7495203272a81d5ec7c7ea62d2a3d001af8::ydamwfaucet::YDAMWFAUCET>>(arg2, 0x2::tx_context::sender(arg4));
        } else {
            0x2::balance::join<0x7bf8b3f969a6964569a3664c8d82c7495203272a81d5ec7c7ea62d2a3d001af8::ydamwfaucet::YDAMWFAUCET>(&mut arg0.balance, 0x2::coin::into_balance<0x7bf8b3f969a6964569a3664c8d82c7495203272a81d5ec7c7ea62d2a3d001af8::ydamwfaucet::YDAMWFAUCET>(arg2));
        };
    }

    public entry fun remove_coin(arg0: &AdminCap, arg1: &mut Game, arg2: u64, arg3: &mut 0x2::tx_context::TxContext) {
        0x2::transfer::public_transfer<0x2::coin::Coin<0x7bf8b3f969a6964569a3664c8d82c7495203272a81d5ec7c7ea62d2a3d001af8::ydamwfaucet::YDAMWFAUCET>>(0x2::coin::from_balance<0x7bf8b3f969a6964569a3664c8d82c7495203272a81d5ec7c7ea62d2a3d001af8::ydamwfaucet::YDAMWFAUCET>(0x2::balance::split<0x7bf8b3f969a6964569a3664c8d82c7495203272a81d5ec7c7ea62d2a3d001af8::ydamwfaucet::YDAMWFAUCET>(&mut arg1.balance, arg2), arg3), 0x2::tx_context::sender(arg3));
    }

    // decompiled from Move bytecode v6
}

