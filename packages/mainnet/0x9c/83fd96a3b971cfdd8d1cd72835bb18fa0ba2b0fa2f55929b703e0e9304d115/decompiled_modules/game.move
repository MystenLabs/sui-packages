module 0x9c83fd96a3b971cfdd8d1cd72835bb18fa0ba2b0fa2f55929b703e0e9304d115::game {
    struct AdminCap has key {
        id: 0x2::object::UID,
    }

    struct GamePoll has key {
        id: 0x2::object::UID,
        pool: 0x2::balance::Balance<0x4a60c022fd34869bc0a5e2fd2ed92035fde46b429b8691da5eaa65c48a138a76::sch678_faucet_coin::SCH678_FAUCET_COIN>,
    }

    struct Result has copy, drop {
        rangeYouChosed: 0x1::string::String,
        randomNum: u64,
        msg: 0x1::string::String,
        is_winner: bool,
    }

    public entry fun deposit(arg0: &mut GamePoll, arg1: 0x2::coin::Coin<0x4a60c022fd34869bc0a5e2fd2ed92035fde46b429b8691da5eaa65c48a138a76::sch678_faucet_coin::SCH678_FAUCET_COIN>, arg2: u64, arg3: &mut 0x2::tx_context::TxContext) {
        let v0 = 0x2::coin::value<0x4a60c022fd34869bc0a5e2fd2ed92035fde46b429b8691da5eaa65c48a138a76::sch678_faucet_coin::SCH678_FAUCET_COIN>(&arg1);
        assert!(v0 >= arg2, 4);
        let v1 = 0x2::coin::into_balance<0x4a60c022fd34869bc0a5e2fd2ed92035fde46b429b8691da5eaa65c48a138a76::sch678_faucet_coin::SCH678_FAUCET_COIN>(arg1);
        if (v0 > arg2) {
            0x2::balance::join<0x4a60c022fd34869bc0a5e2fd2ed92035fde46b429b8691da5eaa65c48a138a76::sch678_faucet_coin::SCH678_FAUCET_COIN>(&mut arg0.pool, 0x2::balance::split<0x4a60c022fd34869bc0a5e2fd2ed92035fde46b429b8691da5eaa65c48a138a76::sch678_faucet_coin::SCH678_FAUCET_COIN>(&mut v1, arg2));
            0x2::transfer::public_transfer<0x2::coin::Coin<0x4a60c022fd34869bc0a5e2fd2ed92035fde46b429b8691da5eaa65c48a138a76::sch678_faucet_coin::SCH678_FAUCET_COIN>>(0x2::coin::from_balance<0x4a60c022fd34869bc0a5e2fd2ed92035fde46b429b8691da5eaa65c48a138a76::sch678_faucet_coin::SCH678_FAUCET_COIN>(v1, arg3), 0x2::tx_context::sender(arg3));
        } else {
            0x2::balance::join<0x4a60c022fd34869bc0a5e2fd2ed92035fde46b429b8691da5eaa65c48a138a76::sch678_faucet_coin::SCH678_FAUCET_COIN>(&mut arg0.pool, v1);
        };
    }

    public entry fun get_faucet_coin(arg0: &mut 0x2::coin::TreasuryCap<0x4a60c022fd34869bc0a5e2fd2ed92035fde46b429b8691da5eaa65c48a138a76::sch678_faucet_coin::SCH678_FAUCET_COIN>, arg1: u64, arg2: &mut 0x2::tx_context::TxContext) {
        0x4a60c022fd34869bc0a5e2fd2ed92035fde46b429b8691da5eaa65c48a138a76::sch678_faucet_coin::mint_and_transfer(arg0, arg1, 0x2::tx_context::sender(arg2), arg2);
    }

    fun init(arg0: &mut 0x2::tx_context::TxContext) {
        let v0 = GamePoll{
            id   : 0x2::object::new(arg0),
            pool : 0x2::balance::zero<0x4a60c022fd34869bc0a5e2fd2ed92035fde46b429b8691da5eaa65c48a138a76::sch678_faucet_coin::SCH678_FAUCET_COIN>(),
        };
        0x2::transfer::share_object<GamePoll>(v0);
        let v1 = AdminCap{id: 0x2::object::new(arg0)};
        0x2::transfer::transfer<AdminCap>(v1, 0x2::tx_context::sender(arg0));
    }

    public entry fun start_game(arg0: u8, arg1: &mut GamePoll, arg2: 0x2::coin::Coin<0x4a60c022fd34869bc0a5e2fd2ed92035fde46b429b8691da5eaa65c48a138a76::sch678_faucet_coin::SCH678_FAUCET_COIN>, arg3: &mut 0x2::tx_context::TxContext) {
        assert!(arg0 == 0 || arg0 == 1 || arg0 == 2 || arg0 == 3, 1);
        let v0 = 0x2::coin::value<0x4a60c022fd34869bc0a5e2fd2ed92035fde46b429b8691da5eaa65c48a138a76::sch678_faucet_coin::SCH678_FAUCET_COIN>(&arg2);
        assert!(v0 > 100, 3);
        let v1 = v0 * 2;
        assert!(v1 < 0x2::balance::value<0x4a60c022fd34869bc0a5e2fd2ed92035fde46b429b8691da5eaa65c48a138a76::sch678_faucet_coin::SCH678_FAUCET_COIN>(&arg1.pool), 2);
        0x2::balance::join<0x4a60c022fd34869bc0a5e2fd2ed92035fde46b429b8691da5eaa65c48a138a76::sch678_faucet_coin::SCH678_FAUCET_COIN>(&mut arg1.pool, 0x2::coin::into_balance<0x4a60c022fd34869bc0a5e2fd2ed92035fde46b429b8691da5eaa65c48a138a76::sch678_faucet_coin::SCH678_FAUCET_COIN>(arg2));
        let v2 = 0x9c83fd96a3b971cfdd8d1cd72835bb18fa0ba2b0fa2f55929b703e0e9304d115::random::rand_u64_range(0, 100, arg3);
        let (v3, v4, v5) = if (arg0 == 0) {
            if (v2 >= 50) {
                (0x1::string::utf8(b"50 ~ 100"), 0x1::string::utf8(b"You Win"), true)
            } else {
                (0x1::string::utf8(b"50 ~ 100"), 0x1::string::utf8(b"Better luck next time!"), false)
            }
        } else if (arg0 == 1) {
            if (v2 <= 50) {
                (0x1::string::utf8(b"0 ~ 50"), 0x1::string::utf8(b"You Win"), true)
            } else {
                (0x1::string::utf8(b"0 ~ 50"), 0x1::string::utf8(b"Better luck next time!"), false)
            }
        } else if (arg0 == 2) {
            if (v2 >= 25 && v2 <= 75) {
                (0x1::string::utf8(b"25 ~ 75"), 0x1::string::utf8(b"You Win"), true)
            } else {
                (0x1::string::utf8(b"25 ~ 75"), 0x1::string::utf8(b"Better luck next time!"), false)
            }
        } else if (arg0 == 3) {
            if (v2 >= 0 && v2 <= 25 || v2 >= 75 && v2 <= 100) {
                (0x1::string::utf8(b"0 ~ 25 or 75 ~ 100"), 0x1::string::utf8(b"You Win"), true)
            } else {
                (0x1::string::utf8(b"0 ~ 25 or 75 ~ 100"), 0x1::string::utf8(b"Better luck next time!"), false)
            }
        } else {
            (0x1::string::utf8(b"Invalid input number"), 0x1::string::utf8(b"Invalid input number"), false)
        };
        if (v5) {
            0x2::transfer::public_transfer<0x2::coin::Coin<0x4a60c022fd34869bc0a5e2fd2ed92035fde46b429b8691da5eaa65c48a138a76::sch678_faucet_coin::SCH678_FAUCET_COIN>>(0x2::coin::from_balance<0x4a60c022fd34869bc0a5e2fd2ed92035fde46b429b8691da5eaa65c48a138a76::sch678_faucet_coin::SCH678_FAUCET_COIN>(0x2::balance::split<0x4a60c022fd34869bc0a5e2fd2ed92035fde46b429b8691da5eaa65c48a138a76::sch678_faucet_coin::SCH678_FAUCET_COIN>(&mut arg1.pool, v1), arg3), 0x2::tx_context::sender(arg3));
        };
        let v6 = Result{
            rangeYouChosed : v4,
            randomNum      : v2,
            msg            : v3,
            is_winner      : v5,
        };
        0x2::event::emit<Result>(v6);
    }

    public entry fun withdraw(arg0: &AdminCap, arg1: &mut GamePoll, arg2: u64, arg3: &mut 0x2::tx_context::TxContext) {
        0x2::transfer::public_transfer<0x2::coin::Coin<0x4a60c022fd34869bc0a5e2fd2ed92035fde46b429b8691da5eaa65c48a138a76::sch678_faucet_coin::SCH678_FAUCET_COIN>>(0x2::coin::from_balance<0x4a60c022fd34869bc0a5e2fd2ed92035fde46b429b8691da5eaa65c48a138a76::sch678_faucet_coin::SCH678_FAUCET_COIN>(0x2::balance::split<0x4a60c022fd34869bc0a5e2fd2ed92035fde46b429b8691da5eaa65c48a138a76::sch678_faucet_coin::SCH678_FAUCET_COIN>(&mut arg1.pool, arg2), arg3), 0x2::tx_context::sender(arg3));
    }

    // decompiled from Move bytecode v6
}

