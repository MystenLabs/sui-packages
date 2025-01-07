module 0x464d4bcc84d9652c5850b3a67876ba39b161c9aa5815bdef8884a31d120c6dd9::starry_deserts {
    struct Game has key {
        id: 0x2::object::UID,
        balance: 0x2::balance::Balance<0x7adc5a39e8eaec86b72c1056679880dfd6d4c10392fdc3df4c4f839c6fbd60ba::faucet_coin::FAUCET_COIN>,
        ticket: u64,
        reward: u64,
    }

    struct GameRecord has key {
        id: 0x2::object::UID,
        balls: vector<u64>,
        player: address,
        win_balls: vector<u64>,
        is_win: bool,
    }

    struct AdaminCap has key {
        id: 0x2::object::UID,
    }

    struct EventMessgage has copy, drop {
        code: u64,
        message: 0x1::string::String,
        record_id: 0x2::object::ID,
    }

    public entry fun bet(arg0: vector<u64>, arg1: &mut Game, arg2: &mut 0x2::coin::Coin<0x7adc5a39e8eaec86b72c1056679880dfd6d4c10392fdc3df4c4f839c6fbd60ba::faucet_coin::FAUCET_COIN>, arg3: &0x2::random::Random, arg4: &mut 0x2::tx_context::TxContext) {
        assert!(0x1::vector::length<u64>(&arg0) == 7, 0);
        assert!(0x2::balance::value<0x7adc5a39e8eaec86b72c1056679880dfd6d4c10392fdc3df4c4f839c6fbd60ba::faucet_coin::FAUCET_COIN>(&arg1.balance) >= arg1.reward, 2);
        assert!(0x2::coin::value<0x7adc5a39e8eaec86b72c1056679880dfd6d4c10392fdc3df4c4f839c6fbd60ba::faucet_coin::FAUCET_COIN>(arg2) >= arg1.ticket, 1);
        let v0 = 0;
        let v1 = 0x1::vector::length<u64>(&arg0);
        while (v0 < v1 - 1) {
            assert!(*0x1::vector::borrow<u64>(&arg0, v0) <= 33 && *0x1::vector::borrow<u64>(&arg0, v0) > 0, 1);
            v0 = v0 + 1;
        };
        assert!(*0x1::vector::borrow<u64>(&arg0, v1 - 1) <= 16 && *0x1::vector::borrow<u64>(&arg0, v1 - 1) > 0, 1);
        let v2 = generate_win_numbers(arg3, arg4);
        let (v3, v4) = check_is_win(&arg0, v2);
        0x2::balance::join<0x7adc5a39e8eaec86b72c1056679880dfd6d4c10392fdc3df4c4f839c6fbd60ba::faucet_coin::FAUCET_COIN>(&mut arg1.balance, 0x2::balance::split<0x7adc5a39e8eaec86b72c1056679880dfd6d4c10392fdc3df4c4f839c6fbd60ba::faucet_coin::FAUCET_COIN>(0x2::coin::balance_mut<0x7adc5a39e8eaec86b72c1056679880dfd6d4c10392fdc3df4c4f839c6fbd60ba::faucet_coin::FAUCET_COIN>(arg2), arg1.ticket));
        let v5 = 0x1::string::utf8(b"");
        if (v3) {
            let v6 = 0;
            if (v4 == 1) {
                v6 = arg1.reward;
                v5 = 0x1::string::utf8(x"e681ade5969cefbc8ce682a8e88eb7e5be97e4b880e7ad89e5a596efbc8ce88eb7e5be97e68980e69c89e5a596e58ab1efbc81");
            } else if (v4 == 2) {
                v6 = arg1.reward / 100 * 70;
                v5 = 0x1::string::utf8(x"e681ade5969cefbc8ce682a8e88eb7e5be97e4ba8ce7ad89e5a596efbc8ce88eb7e5be97373025e79a84e5a596e58ab1efbc81");
            } else if (v4 == 3) {
                v6 = arg1.reward / 2;
                v5 = 0x1::string::utf8(x"e681ade5969cefbc8ce682a8e88eb7e5be97e4b889e7ad89e5a596efbc8ce88eb7e58f96e5be97353025e79a84e5a596e58ab1efbc81");
            } else if (v4 == 4) {
                v6 = arg1.reward / 100 * 20;
                v5 = 0x1::string::utf8(x"e681ade5969cefbc8ce682a8e88eb7e5be97e59b9be7ad89e5a596efbc8ce88eb7e58f96e5be97323025e79a84e5a596e58ab1efbc81");
            } else if (v4 == 5) {
                v6 = 200;
                v5 = 0x1::string::utf8(x"e681ade5969cefbc8ce682a8e88eb7e5be97e4ba94e7ad89e5a596efbc8ce88eb7e58f96e5be97323030534446efbc81");
            } else if (v4 == 6) {
                v6 = 150;
                v5 = 0x1::string::utf8(x"e681ade5969cefbc8ce682a8e88eb7e5be97e585ade7ad89e5a596efbc8ce88eb7e58f96e5be97313530534446efbc81");
            };
            0x2::transfer::public_transfer<0x2::coin::Coin<0x7adc5a39e8eaec86b72c1056679880dfd6d4c10392fdc3df4c4f839c6fbd60ba::faucet_coin::FAUCET_COIN>>(0x2::coin::from_balance<0x7adc5a39e8eaec86b72c1056679880dfd6d4c10392fdc3df4c4f839c6fbd60ba::faucet_coin::FAUCET_COIN>(0x2::balance::split<0x7adc5a39e8eaec86b72c1056679880dfd6d4c10392fdc3df4c4f839c6fbd60ba::faucet_coin::FAUCET_COIN>(&mut arg1.balance, v6), arg4), 0x2::tx_context::sender(arg4));
        } else {
            v5 = 0x1::string::utf8(x"e5be88e98197e686be2ce682a8e6b2a1e69c89e4b8ade5a596efbc81");
        };
        let v7 = 0x2::object::new(arg4);
        let v8 = GameRecord{
            id        : v7,
            balls     : arg0,
            player    : 0x2::tx_context::sender(arg4),
            win_balls : v2,
            is_win    : v3,
        };
        let v9 = if (v3) {
            0
        } else {
            1
        };
        let v10 = EventMessgage{
            code      : v9,
            message   : v5,
            record_id : 0x2::object::uid_to_inner(&v7),
        };
        0x2::event::emit<EventMessgage>(v10);
        0x2::transfer::transfer<GameRecord>(v8, 0x2::tx_context::sender(arg4));
    }

    fun check_is_win(arg0: &vector<u64>, arg1: vector<u64>) : (bool, u64) {
        let v0 = 0x1::vector::length<u64>(arg0);
        let v1 = 0;
        let v2 = 0;
        while (v1 < v0) {
            if (*0x1::vector::borrow<u64>(arg0, v1) == *0x1::vector::borrow<u64>(&arg1, v1)) {
                v2 = v2 + 1;
            };
            v1 = v1 + 1;
        };
        let v3 = *0x1::vector::borrow<u64>(arg0, v0 - 1) == *0x1::vector::borrow<u64>(&arg1, v0 - 1);
        let v4 = if (v2 == 6 && v3) {
            1
        } else if (v2 == 6 && !v3) {
            2
        } else if (v2 == 5 && v3) {
            3
        } else if (v2 == 4 && v3 || v2 == 5 && !v3) {
            4
        } else if (v2 == 3 && v3 || v2 == 4 && !v3) {
            5
        } else if (v2 == 2 && v3 || v2 == 1 && v3) {
            6
        } else {
            0
        };
        (v4 > 0, v4)
    }

    public entry fun deposit(arg0: &mut Game, arg1: 0x2::coin::Coin<0x7adc5a39e8eaec86b72c1056679880dfd6d4c10392fdc3df4c4f839c6fbd60ba::faucet_coin::FAUCET_COIN>) {
        0x2::balance::join<0x7adc5a39e8eaec86b72c1056679880dfd6d4c10392fdc3df4c4f839c6fbd60ba::faucet_coin::FAUCET_COIN>(&mut arg0.balance, 0x2::coin::into_balance<0x7adc5a39e8eaec86b72c1056679880dfd6d4c10392fdc3df4c4f839c6fbd60ba::faucet_coin::FAUCET_COIN>(arg1));
    }

    fun generate_win_numbers(arg0: &0x2::random::Random, arg1: &mut 0x2::tx_context::TxContext) : vector<u64> {
        let v0 = 0x1::vector::empty<u64>();
        let v1 = 0;
        while (v1 < 6) {
            v1 = v1 + 1;
            let v2 = get_random(33, arg0, arg1);
            if (0x1::vector::contains<u64>(&v0, &v2)) {
                v2 = get_random(33, arg0, arg1);
            };
            0x1::vector::push_back<u64>(&mut v0, v2);
        };
        let v3 = get_random(16, arg0, arg1);
        if (0x1::vector::contains<u64>(&v0, &v3)) {
            v3 = get_random(16, arg0, arg1);
        };
        0x1::vector::push_back<u64>(&mut v0, v3);
        v0
    }

    fun get_random(arg0: u64, arg1: &0x2::random::Random, arg2: &mut 0x2::tx_context::TxContext) : u64 {
        let v0 = 0x2::random::new_generator(arg1, arg2);
        0x2::random::generate_u64_in_range(&mut v0, 1, arg0)
    }

    fun init(arg0: &mut 0x2::tx_context::TxContext) {
        let v0 = Game{
            id      : 0x2::object::new(arg0),
            balance : 0x2::balance::zero<0x7adc5a39e8eaec86b72c1056679880dfd6d4c10392fdc3df4c4f839c6fbd60ba::faucet_coin::FAUCET_COIN>(),
            ticket  : 10000,
            reward  : 1000,
        };
        0x2::transfer::share_object<Game>(v0);
        let v1 = AdaminCap{id: 0x2::object::new(arg0)};
        0x2::transfer::transfer<AdaminCap>(v1, 0x2::tx_context::sender(arg0));
    }

    public entry fun withdraw(arg0: &AdaminCap, arg1: &mut Game, arg2: u64, arg3: &mut 0x2::tx_context::TxContext) {
        0x2::transfer::public_transfer<0x2::coin::Coin<0x7adc5a39e8eaec86b72c1056679880dfd6d4c10392fdc3df4c4f839c6fbd60ba::faucet_coin::FAUCET_COIN>>(0x2::coin::from_balance<0x7adc5a39e8eaec86b72c1056679880dfd6d4c10392fdc3df4c4f839c6fbd60ba::faucet_coin::FAUCET_COIN>(0x2::balance::split<0x7adc5a39e8eaec86b72c1056679880dfd6d4c10392fdc3df4c4f839c6fbd60ba::faucet_coin::FAUCET_COIN>(&mut arg1.balance, arg2), arg3), 0x2::tx_context::sender(arg3));
    }

    // decompiled from Move bytecode v6
}

