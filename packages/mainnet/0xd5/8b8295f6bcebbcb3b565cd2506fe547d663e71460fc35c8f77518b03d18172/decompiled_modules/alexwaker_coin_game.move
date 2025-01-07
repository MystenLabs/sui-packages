module 0xd58b8295f6bcebbcb3b565cd2506fe547d663e71460fc35c8f77518b03d18172::alexwaker_coin_game {
    struct Bet has drop, store {
        player: address,
        guess: bool,
    }

    struct Game has store, key {
        id: 0x2::object::UID,
        admin: address,
        bets: vector<Bet>,
        val: 0x2::balance::Balance<0x2adc11d7339def7528121fb6302719cc37e588e4ea2672851efa8180c29037e5::alexwaker_faucet_coin::ALEXWAKER_FAUCET_COIN>,
    }

    public fun deposit(arg0: &mut Game, arg1: address, arg2: bool, arg3: 0x2::coin::Coin<0x2adc11d7339def7528121fb6302719cc37e588e4ea2672851efa8180c29037e5::alexwaker_faucet_coin::ALEXWAKER_FAUCET_COIN>, arg4: &mut 0x2::tx_context::TxContext) {
        0x2::balance::join<0x2adc11d7339def7528121fb6302719cc37e588e4ea2672851efa8180c29037e5::alexwaker_faucet_coin::ALEXWAKER_FAUCET_COIN>(&mut arg0.val, 0x2::coin::into_balance<0x2adc11d7339def7528121fb6302719cc37e588e4ea2672851efa8180c29037e5::alexwaker_faucet_coin::ALEXWAKER_FAUCET_COIN>(arg3));
        let v0 = Bet{
            player : arg1,
            guess  : arg2,
        };
        0x1::vector::push_back<Bet>(&mut arg0.bets, v0);
    }

    fun init(arg0: &mut 0x2::tx_context::TxContext) {
        let v0 = Game{
            id    : 0x2::object::new(arg0),
            admin : 0x2::tx_context::sender(arg0),
            bets  : 0x1::vector::empty<Bet>(),
            val   : 0x2::balance::zero<0x2adc11d7339def7528121fb6302719cc37e588e4ea2672851efa8180c29037e5::alexwaker_faucet_coin::ALEXWAKER_FAUCET_COIN>(),
        };
        0x2::transfer::share_object<Game>(v0);
    }

    public fun play(arg0: &mut Game, arg1: &0x2::random::Random, arg2: &mut 0x2::tx_context::TxContext) {
        assert!(0x2::tx_context::sender(arg2) == arg0.admin, 9223372290257846271);
        let v0 = 0x2::random::new_generator(arg1, arg2);
        0x2::random::generate_u64(&mut v0);
        let v1 = @0xda46e2c5f929d6e0e748262137be920601ed7002971388e1de20e02af482e6fa;
        let v2 = 0x1::vector::length<Bet>(&arg0.bets);
        while (v2 > 0) {
            let v3 = 0x1::vector::borrow<Bet>(&arg0.bets, v2 - 1);
            if (v3.guess == 0x2::random::generate_bool(&mut v0)) {
                v1 = v3.player;
            };
            v2 = v2 - 1;
        };
        0x2::transfer::public_transfer<0x2::coin::Coin<0x2adc11d7339def7528121fb6302719cc37e588e4ea2672851efa8180c29037e5::alexwaker_faucet_coin::ALEXWAKER_FAUCET_COIN>>(0x2::coin::from_balance<0x2adc11d7339def7528121fb6302719cc37e588e4ea2672851efa8180c29037e5::alexwaker_faucet_coin::ALEXWAKER_FAUCET_COIN>(0x2::balance::split<0x2adc11d7339def7528121fb6302719cc37e588e4ea2672851efa8180c29037e5::alexwaker_faucet_coin::ALEXWAKER_FAUCET_COIN>(&mut arg0.val, 0x2::balance::value<0x2adc11d7339def7528121fb6302719cc37e588e4ea2672851efa8180c29037e5::alexwaker_faucet_coin::ALEXWAKER_FAUCET_COIN>(&arg0.val)), arg2), v1);
        0x1::vector::pop_back<Bet>(&mut arg0.bets);
        0x1::vector::pop_back<Bet>(&mut arg0.bets);
    }

    public fun withdraw(arg0: &mut Game, arg1: u64, arg2: &mut 0x2::tx_context::TxContext) {
        assert!(0x2::tx_context::sender(arg2) == arg0.admin, 9223372500711243775);
        assert!(0x2::balance::value<0x2adc11d7339def7528121fb6302719cc37e588e4ea2672851efa8180c29037e5::alexwaker_faucet_coin::ALEXWAKER_FAUCET_COIN>(&arg0.val) >= arg1, 9223372505006211071);
        0x2::transfer::public_transfer<0x2::coin::Coin<0x2adc11d7339def7528121fb6302719cc37e588e4ea2672851efa8180c29037e5::alexwaker_faucet_coin::ALEXWAKER_FAUCET_COIN>>(0x2::coin::from_balance<0x2adc11d7339def7528121fb6302719cc37e588e4ea2672851efa8180c29037e5::alexwaker_faucet_coin::ALEXWAKER_FAUCET_COIN>(0x2::balance::split<0x2adc11d7339def7528121fb6302719cc37e588e4ea2672851efa8180c29037e5::alexwaker_faucet_coin::ALEXWAKER_FAUCET_COIN>(&mut arg0.val, arg1), arg2), 0x2::tx_context::sender(arg2));
    }

    // decompiled from Move bytecode v6
}

