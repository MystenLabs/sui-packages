module 0x970c82737183aa91e4c7a8564a756d1c2ef55e0d61549bed6c8ce07fb8eaa6ac::my_game {
    struct Game has key {
        id: 0x2::object::UID,
        creator: address,
        epoch: u64,
        bal: 0x2::balance::Balance<0x388ecc0ef7261e40f7be055c723e4bf275d3eeb33eae3525e4b7096065b19b73::faucet_coin::FAUCET_COIN>,
    }

    struct MY_GAME has drop {
        dummy_field: bool,
    }

    struct GameAdminCap has key {
        id: 0x2::object::UID,
    }

    public entry fun create_game(arg0: &GameAdminCap, arg1: &mut 0x2::coin::TreasuryCap<0x388ecc0ef7261e40f7be055c723e4bf275d3eeb33eae3525e4b7096065b19b73::faucet_coin::FAUCET_COIN>, arg2: &mut 0x2::tx_context::TxContext) {
        let v0 = Game{
            id      : 0x2::object::new(arg2),
            creator : 0x2::tx_context::sender(arg2),
            epoch   : 0x2::tx_context::epoch(arg2),
            bal     : 0x2::coin::mint_balance<0x388ecc0ef7261e40f7be055c723e4bf275d3eeb33eae3525e4b7096065b19b73::faucet_coin::FAUCET_COIN>(arg1, 1000000),
        };
        0x2::transfer::share_object<Game>(v0);
    }

    fun init(arg0: MY_GAME, arg1: &mut 0x2::tx_context::TxContext) {
        let v0 = GameAdminCap{id: 0x2::object::new(arg1)};
        0x2::transfer::transfer<GameAdminCap>(v0, 0x2::tx_context::sender(arg1));
    }

    public entry fun play(arg0: &mut 0x2::coin::TreasuryCap<0x388ecc0ef7261e40f7be055c723e4bf275d3eeb33eae3525e4b7096065b19b73::faucet_coin::FAUCET_COIN>, arg1: u64, arg2: &mut Game, arg3: &0x2::random::Random, arg4: &mut 0x2::tx_context::TxContext) {
        assert!(0x2::tx_context::epoch(arg4) == arg2.epoch, 2);
        assert!(arg1 > 0, 0);
        let v0 = 0x2::coin::mint<0x388ecc0ef7261e40f7be055c723e4bf275d3eeb33eae3525e4b7096065b19b73::faucet_coin::FAUCET_COIN>(arg0, 1000000, arg4);
        0x2::coin::put<0x388ecc0ef7261e40f7be055c723e4bf275d3eeb33eae3525e4b7096065b19b73::faucet_coin::FAUCET_COIN>(&mut arg2.bal, 0x2::coin::split<0x388ecc0ef7261e40f7be055c723e4bf275d3eeb33eae3525e4b7096065b19b73::faucet_coin::FAUCET_COIN>(&mut v0, arg1, arg4));
        let v1 = 0x2::random::new_generator(arg3, arg4);
        0x2::coin::join<0x388ecc0ef7261e40f7be055c723e4bf275d3eeb33eae3525e4b7096065b19b73::faucet_coin::FAUCET_COIN>(&mut v0, 0x2::coin::take<0x388ecc0ef7261e40f7be055c723e4bf275d3eeb33eae3525e4b7096065b19b73::faucet_coin::FAUCET_COIN>(&mut arg2.bal, 2 * (((2 - 0x2::random::generate_u8_in_range(&mut v1, 1, 100) / 50) / 2) as u64) * arg1, arg4));
        0x2::transfer::public_transfer<0x2::coin::Coin<0x388ecc0ef7261e40f7be055c723e4bf275d3eeb33eae3525e4b7096065b19b73::faucet_coin::FAUCET_COIN>>(v0, 0x2::tx_context::sender(arg4));
    }

    // decompiled from Move bytecode v6
}

