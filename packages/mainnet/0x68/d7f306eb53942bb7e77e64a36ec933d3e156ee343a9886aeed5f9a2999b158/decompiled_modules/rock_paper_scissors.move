module 0x68d7f306eb53942bb7e77e64a36ec933d3e156ee343a9886aeed5f9a2999b158::rock_paper_scissors {
    struct GamePool has key {
        id: 0x2::object::UID,
        balance: 0x2::balance::Balance<0xccb69f4b847c308b24ae2bae1dac2454822a091bccb87fbf1f7e910cdde9405e::tianhun_faucet_coin::TIANHUN_FAUCET_COIN>,
    }

    struct GameResult has copy, drop {
        player: address,
        player_choice: u8,
        computer_choice: u8,
        result: u8,
        amount: u64,
    }

    struct AdminCap has key {
        id: 0x2::object::UID,
    }

    struct DepositEvent has copy, drop {
        user: address,
        amount: u64,
    }

    struct WithdrawEvent has copy, drop {
        user: address,
        amount: u64,
    }

    public entry fun deposit(arg0: &mut GamePool, arg1: 0x2::coin::Coin<0xccb69f4b847c308b24ae2bae1dac2454822a091bccb87fbf1f7e910cdde9405e::tianhun_faucet_coin::TIANHUN_FAUCET_COIN>, arg2: &mut 0x2::tx_context::TxContext) {
        0x2::balance::join<0xccb69f4b847c308b24ae2bae1dac2454822a091bccb87fbf1f7e910cdde9405e::tianhun_faucet_coin::TIANHUN_FAUCET_COIN>(&mut arg0.balance, 0x2::coin::into_balance<0xccb69f4b847c308b24ae2bae1dac2454822a091bccb87fbf1f7e910cdde9405e::tianhun_faucet_coin::TIANHUN_FAUCET_COIN>(arg1));
        let v0 = DepositEvent{
            user   : 0x2::tx_context::sender(arg2),
            amount : 0x2::coin::value<0xccb69f4b847c308b24ae2bae1dac2454822a091bccb87fbf1f7e910cdde9405e::tianhun_faucet_coin::TIANHUN_FAUCET_COIN>(&arg1),
        };
        0x2::event::emit<DepositEvent>(v0);
    }

    fun init(arg0: &mut 0x2::tx_context::TxContext) {
        let v0 = GamePool{
            id      : 0x2::object::new(arg0),
            balance : 0x2::balance::zero<0xccb69f4b847c308b24ae2bae1dac2454822a091bccb87fbf1f7e910cdde9405e::tianhun_faucet_coin::TIANHUN_FAUCET_COIN>(),
        };
        let v1 = AdminCap{id: 0x2::object::new(arg0)};
        0x2::transfer::share_object<GamePool>(v0);
        0x2::transfer::transfer<AdminCap>(v1, 0x2::tx_context::sender(arg0));
    }

    public entry fun play(arg0: &mut GamePool, arg1: u8, arg2: u64, arg3: &0x2::random::Random, arg4: &mut 0x2::tx_context::TxContext) {
        assert!(arg1 <= 2, 0);
        assert!(arg2 > 0, 1);
        assert!(0x2::balance::value<0xccb69f4b847c308b24ae2bae1dac2454822a091bccb87fbf1f7e910cdde9405e::tianhun_faucet_coin::TIANHUN_FAUCET_COIN>(&arg0.balance) * 2 >= arg2, 2);
        let v0 = 0x2::random::new_generator(arg3, arg4);
        let v1 = 0x2::random::generate_u8_in_range(&mut v0, 0, 2);
        let v2 = if (arg1 == v1) {
            3
        } else if (arg1 == 0 && v1 == 2 || arg1 == 1 && v1 == 0 || arg1 == 2 && v1 == 1) {
            1
        } else {
            2
        };
        if (v2 == 1) {
            0x2::transfer::public_transfer<0x2::coin::Coin<0xccb69f4b847c308b24ae2bae1dac2454822a091bccb87fbf1f7e910cdde9405e::tianhun_faucet_coin::TIANHUN_FAUCET_COIN>>(0x2::coin::take<0xccb69f4b847c308b24ae2bae1dac2454822a091bccb87fbf1f7e910cdde9405e::tianhun_faucet_coin::TIANHUN_FAUCET_COIN>(&mut arg0.balance, arg2 * 2, arg4), 0x2::tx_context::sender(arg4));
        } else if (v2 == 2) {
            0x2::transfer::public_transfer<0x2::coin::Coin<0xccb69f4b847c308b24ae2bae1dac2454822a091bccb87fbf1f7e910cdde9405e::tianhun_faucet_coin::TIANHUN_FAUCET_COIN>>(0x2::coin::from_balance<0xccb69f4b847c308b24ae2bae1dac2454822a091bccb87fbf1f7e910cdde9405e::tianhun_faucet_coin::TIANHUN_FAUCET_COIN>(0x2::balance::split<0xccb69f4b847c308b24ae2bae1dac2454822a091bccb87fbf1f7e910cdde9405e::tianhun_faucet_coin::TIANHUN_FAUCET_COIN>(&mut arg0.balance, arg2), arg4), 0x2::tx_context::sender(arg4));
        };
        let v3 = GameResult{
            player          : 0x2::tx_context::sender(arg4),
            player_choice   : arg1,
            computer_choice : v1,
            result          : v2,
            amount          : arg2,
        };
        0x2::event::emit<GameResult>(v3);
    }

    public entry fun withdraw(arg0: &AdminCap, arg1: &mut GamePool, arg2: u64, arg3: &mut 0x2::tx_context::TxContext) {
        0x2::transfer::public_transfer<0x2::coin::Coin<0xccb69f4b847c308b24ae2bae1dac2454822a091bccb87fbf1f7e910cdde9405e::tianhun_faucet_coin::TIANHUN_FAUCET_COIN>>(0x2::coin::take<0xccb69f4b847c308b24ae2bae1dac2454822a091bccb87fbf1f7e910cdde9405e::tianhun_faucet_coin::TIANHUN_FAUCET_COIN>(&mut arg1.balance, arg2, arg3), 0x2::tx_context::sender(arg3));
        let v0 = WithdrawEvent{
            user   : 0x2::tx_context::sender(arg3),
            amount : arg2,
        };
        0x2::event::emit<WithdrawEvent>(v0);
    }

    // decompiled from Move bytecode v6
}

