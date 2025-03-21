module 0xa67d9ab09255c9c538de584b45d3e9c0f65a4b8f5c31ae64dd87e9a124d9c68::gameMoudle {
    struct GamePool has store, key {
        id: 0x2::object::UID,
        balance: 0x2::balance::Balance<0x5bfc7604744180b2555ad6031bd3a381441a5aaad883ea7618ca200dd4a462f6::faucet_coin::FAUCET_COIN>,
        github_id: 0x1::string::String,
    }

    public entry fun deposit(arg0: &mut GamePool, arg1: 0x2::coin::Coin<0x5bfc7604744180b2555ad6031bd3a381441a5aaad883ea7618ca200dd4a462f6::faucet_coin::FAUCET_COIN>) {
        0x2::balance::join<0x5bfc7604744180b2555ad6031bd3a381441a5aaad883ea7618ca200dd4a462f6::faucet_coin::FAUCET_COIN>(&mut arg0.balance, 0x2::coin::into_balance<0x5bfc7604744180b2555ad6031bd3a381441a5aaad883ea7618ca200dd4a462f6::faucet_coin::FAUCET_COIN>(arg1));
    }

    public fun new_game_pool(arg0: &0x2::coin::TreasuryCap<0x5bfc7604744180b2555ad6031bd3a381441a5aaad883ea7618ca200dd4a462f6::faucet_coin::FAUCET_COIN>, arg1: &mut 0x2::tx_context::TxContext) {
        let v0 = GamePool{
            id        : 0x2::object::new(arg1),
            balance   : 0x2::balance::zero<0x5bfc7604744180b2555ad6031bd3a381441a5aaad883ea7618ca200dd4a462f6::faucet_coin::FAUCET_COIN>(),
            github_id : 0x1::string::utf8(b"lifejwang11"),
        };
        0x2::transfer::share_object<GamePool>(v0);
    }

    public entry fun play_game(arg0: &mut GamePool, arg1: &0x2::random::Random, arg2: u8, arg3: 0x2::coin::Coin<0x5bfc7604744180b2555ad6031bd3a381441a5aaad883ea7618ca200dd4a462f6::faucet_coin::FAUCET_COIN>, arg4: &mut 0x2::tx_context::TxContext) {
        let v0 = 0x2::coin::value<0x5bfc7604744180b2555ad6031bd3a381441a5aaad883ea7618ca200dd4a462f6::faucet_coin::FAUCET_COIN>(&arg3);
        assert!(v0 <= 0x2::balance::value<0x5bfc7604744180b2555ad6031bd3a381441a5aaad883ea7618ca200dd4a462f6::faucet_coin::FAUCET_COIN>(&arg0.balance), 100);
        let v1 = 0x2::random::new_generator(arg1, arg4);
        if (0x2::random::generate_u8_in_range(&mut v1, 1, 2) == arg2) {
            0x2::transfer::public_transfer<0x2::coin::Coin<0x5bfc7604744180b2555ad6031bd3a381441a5aaad883ea7618ca200dd4a462f6::faucet_coin::FAUCET_COIN>>(0x2::coin::from_balance<0x5bfc7604744180b2555ad6031bd3a381441a5aaad883ea7618ca200dd4a462f6::faucet_coin::FAUCET_COIN>(0x2::balance::split<0x5bfc7604744180b2555ad6031bd3a381441a5aaad883ea7618ca200dd4a462f6::faucet_coin::FAUCET_COIN>(&mut arg0.balance, v0), arg4), 0x2::tx_context::sender(arg4));
            0x2::transfer::public_transfer<0x2::coin::Coin<0x5bfc7604744180b2555ad6031bd3a381441a5aaad883ea7618ca200dd4a462f6::faucet_coin::FAUCET_COIN>>(arg3, 0x2::tx_context::sender(arg4));
        } else {
            deposit(arg0, arg3);
        };
    }

    public entry fun withdraw(arg0: &mut GamePool, arg1: u64, arg2: &mut 0x2::tx_context::TxContext) {
        0x2::transfer::public_transfer<0x2::coin::Coin<0x5bfc7604744180b2555ad6031bd3a381441a5aaad883ea7618ca200dd4a462f6::faucet_coin::FAUCET_COIN>>(0x2::coin::from_balance<0x5bfc7604744180b2555ad6031bd3a381441a5aaad883ea7618ca200dd4a462f6::faucet_coin::FAUCET_COIN>(0x2::balance::split<0x5bfc7604744180b2555ad6031bd3a381441a5aaad883ea7618ca200dd4a462f6::faucet_coin::FAUCET_COIN>(&mut arg0.balance, arg1), arg2), 0x2::tx_context::sender(arg2));
    }

    // decompiled from Move bytecode v6
}

