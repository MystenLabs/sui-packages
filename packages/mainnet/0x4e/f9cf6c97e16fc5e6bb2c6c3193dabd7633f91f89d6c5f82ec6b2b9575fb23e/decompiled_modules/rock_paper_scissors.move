module 0x4ef9cf6c97e16fc5e6bb2c6c3193dabd7633f91f89d6c5f82ec6b2b9575fb23e::rock_paper_scissors {
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

    fun generate_random_number(arg0: &0x2::tx_context::TxContext, arg1: &0x2::clock::Clock) : u8 {
        (((0x2::clock::timestamp_ms(arg1) ^ (*0x1::vector::borrow<u8>(0x2::tx_context::digest(arg0), 0) as u64)) % 3) as u8)
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

    public entry fun play(arg0: &mut GamePool, arg1: u8, arg2: u64, arg3: &0x2::clock::Clock, arg4: &mut 0x2::tx_context::TxContext) {
        assert!(arg1 <= 2, 0);
        assert!(arg2 > 0, 1);
        assert!(0x2::balance::value<0xccb69f4b847c308b24ae2bae1dac2454822a091bccb87fbf1f7e910cdde9405e::tianhun_faucet_coin::TIANHUN_FAUCET_COIN>(&arg0.balance) * 2 >= arg2, 2);
        let v0 = generate_random_number(arg4, arg3);
        let v1 = if (arg1 == v0) {
            3
        } else if (arg1 == 0 && v0 == 2 || arg1 == 1 && v0 == 0 || arg1 == 2 && v0 == 1) {
            1
        } else {
            2
        };
        if (v1 == 1) {
            0x2::transfer::public_transfer<0x2::coin::Coin<0xccb69f4b847c308b24ae2bae1dac2454822a091bccb87fbf1f7e910cdde9405e::tianhun_faucet_coin::TIANHUN_FAUCET_COIN>>(0x2::coin::take<0xccb69f4b847c308b24ae2bae1dac2454822a091bccb87fbf1f7e910cdde9405e::tianhun_faucet_coin::TIANHUN_FAUCET_COIN>(&mut arg0.balance, arg2 * 2, arg4), 0x2::tx_context::sender(arg4));
        } else if (v1 == 2) {
            0x2::transfer::public_transfer<0x2::coin::Coin<0xccb69f4b847c308b24ae2bae1dac2454822a091bccb87fbf1f7e910cdde9405e::tianhun_faucet_coin::TIANHUN_FAUCET_COIN>>(0x2::coin::from_balance<0xccb69f4b847c308b24ae2bae1dac2454822a091bccb87fbf1f7e910cdde9405e::tianhun_faucet_coin::TIANHUN_FAUCET_COIN>(0x2::balance::split<0xccb69f4b847c308b24ae2bae1dac2454822a091bccb87fbf1f7e910cdde9405e::tianhun_faucet_coin::TIANHUN_FAUCET_COIN>(&mut arg0.balance, arg2), arg4), 0x2::tx_context::sender(arg4));
        };
        let v2 = GameResult{
            player          : 0x2::tx_context::sender(arg4),
            player_choice   : arg1,
            computer_choice : v0,
            result          : v1,
            amount          : arg2,
        };
        0x2::event::emit<GameResult>(v2);
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

