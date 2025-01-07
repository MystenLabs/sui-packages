module 0x3fd9c2ff46850b9bdf4695b0da6e79e912095c9cb34976c16d8e8221895c439a::my_game {
    struct RewardPool has store, key {
        id: 0x2::object::UID,
        balance: 0x2::balance::Balance<0x32de70fc2e92a7abddf1675afc56b37c5403a4a846d68de328c44d528450754e::faucet_coin::FAUCET_COIN>,
    }

    struct Owner has key {
        id: 0x2::object::UID,
    }

    public entry fun deposit(arg0: &mut RewardPool, arg1: &mut 0x2::coin::Coin<0x32de70fc2e92a7abddf1675afc56b37c5403a4a846d68de328c44d528450754e::faucet_coin::FAUCET_COIN>, arg2: u64) {
        assert!(0x2::coin::value<0x32de70fc2e92a7abddf1675afc56b37c5403a4a846d68de328c44d528450754e::faucet_coin::FAUCET_COIN>(arg1) >= arg2, 1000);
        0x2::balance::join<0x32de70fc2e92a7abddf1675afc56b37c5403a4a846d68de328c44d528450754e::faucet_coin::FAUCET_COIN>(&mut arg0.balance, 0x2::balance::split<0x32de70fc2e92a7abddf1675afc56b37c5403a4a846d68de328c44d528450754e::faucet_coin::FAUCET_COIN>(0x2::coin::balance_mut<0x32de70fc2e92a7abddf1675afc56b37c5403a4a846d68de328c44d528450754e::faucet_coin::FAUCET_COIN>(arg1), arg2));
    }

    public entry fun game(arg0: &mut RewardPool, arg1: &mut 0x2::coin::Coin<0x32de70fc2e92a7abddf1675afc56b37c5403a4a846d68de328c44d528450754e::faucet_coin::FAUCET_COIN>, arg2: u64, arg3: bool, arg4: &0x2::random::Random, arg5: &mut 0x2::tx_context::TxContext) {
        assert!(0x2::coin::value<0x32de70fc2e92a7abddf1675afc56b37c5403a4a846d68de328c44d528450754e::faucet_coin::FAUCET_COIN>(arg1) >= arg2, 1000);
        let v0 = 0x2::random::new_generator(arg4, arg5);
        if (0x2::random::generate_u8_in_range(&mut v0, 0, 1) == 1 == arg3) {
            0x2::coin::join<0x32de70fc2e92a7abddf1675afc56b37c5403a4a846d68de328c44d528450754e::faucet_coin::FAUCET_COIN>(arg1, 0x2::coin::take<0x32de70fc2e92a7abddf1675afc56b37c5403a4a846d68de328c44d528450754e::faucet_coin::FAUCET_COIN>(&mut arg0.balance, arg2, arg5));
        } else {
            deposit(arg0, arg1, arg2);
        };
    }

    fun init(arg0: &mut 0x2::tx_context::TxContext) {
        let v0 = RewardPool{
            id      : 0x2::object::new(arg0),
            balance : 0x2::balance::zero<0x32de70fc2e92a7abddf1675afc56b37c5403a4a846d68de328c44d528450754e::faucet_coin::FAUCET_COIN>(),
        };
        0x2::transfer::share_object<RewardPool>(v0);
        let v1 = Owner{id: 0x2::object::new(arg0)};
        0x2::transfer::transfer<Owner>(v1, 0x2::tx_context::sender(arg0));
    }

    entry fun withdraw(arg0: &mut RewardPool, arg1: u64, arg2: &mut Owner, arg3: &mut 0x2::tx_context::TxContext) {
        assert!(0x2::balance::value<0x32de70fc2e92a7abddf1675afc56b37c5403a4a846d68de328c44d528450754e::faucet_coin::FAUCET_COIN>(&arg0.balance) >= arg1, 1000);
        0x2::transfer::public_transfer<0x2::coin::Coin<0x32de70fc2e92a7abddf1675afc56b37c5403a4a846d68de328c44d528450754e::faucet_coin::FAUCET_COIN>>(0x2::coin::take<0x32de70fc2e92a7abddf1675afc56b37c5403a4a846d68de328c44d528450754e::faucet_coin::FAUCET_COIN>(&mut arg0.balance, arg1, arg3), 0x2::tx_context::sender(arg3));
    }

    // decompiled from Move bytecode v6
}

