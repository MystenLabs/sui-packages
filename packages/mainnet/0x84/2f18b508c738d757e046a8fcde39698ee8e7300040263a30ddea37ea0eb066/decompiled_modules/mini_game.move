module 0x842f18b508c738d757e046a8fcde39698ee8e7300040263a30ddea37ea0eb066::mini_game {
    struct GameCoinPool<phantom T0> has key {
        id: 0x2::object::UID,
        owner: address,
        coins: 0x2::balance::Balance<T0>,
        amount: u64,
    }

    struct GamingResultEvent has copy, drop {
        welcome: 0x1::string::String,
        is_win: bool,
        your_points: u8,
        computer_points: u8,
        result: 0x1::string::String,
        reward: u8,
    }

    public entry fun create(arg0: 0x2::coin::Coin<0x520cfde819014eaaf85e702c906565e368d9e9a32785c76ae7ac589e1395753a::ridesun_FAUCET_coin::RIDESUN_FAUCET_COIN>, arg1: &mut 0x2::tx_context::TxContext) {
        let v0 = GameCoinPool<0x520cfde819014eaaf85e702c906565e368d9e9a32785c76ae7ac589e1395753a::ridesun_FAUCET_coin::RIDESUN_FAUCET_COIN>{
            id     : 0x2::object::new(arg1),
            owner  : 0x2::tx_context::sender(arg1),
            coins  : 0x2::coin::into_balance<0x520cfde819014eaaf85e702c906565e368d9e9a32785c76ae7ac589e1395753a::ridesun_FAUCET_coin::RIDESUN_FAUCET_COIN>(arg0),
            amount : 0x2::coin::value<0x520cfde819014eaaf85e702c906565e368d9e9a32785c76ae7ac589e1395753a::ridesun_FAUCET_coin::RIDESUN_FAUCET_COIN>(&arg0),
        };
        0x2::transfer::share_object<GameCoinPool<0x520cfde819014eaaf85e702c906565e368d9e9a32785c76ae7ac589e1395753a::ridesun_FAUCET_coin::RIDESUN_FAUCET_COIN>>(v0);
    }

    fun get_random_points(arg0: &0x2::clock::Clock) : u8 {
        ((0x2::clock::timestamp_ms(arg0) % 10) as u8)
    }

    public entry fun play(arg0: &mut GameCoinPool<0x520cfde819014eaaf85e702c906565e368d9e9a32785c76ae7ac589e1395753a::ridesun_FAUCET_coin::RIDESUN_FAUCET_COIN>, arg1: 0x2::coin::Coin<0x520cfde819014eaaf85e702c906565e368d9e9a32785c76ae7ac589e1395753a::ridesun_FAUCET_coin::RIDESUN_FAUCET_COIN>, arg2: u8, arg3: &0x2::clock::Clock, arg4: &mut 0x2::tx_context::TxContext) {
        assert!(0x2::coin::value<0x520cfde819014eaaf85e702c906565e368d9e9a32785c76ae7ac589e1395753a::ridesun_FAUCET_coin::RIDESUN_FAUCET_COIN>(&arg1) > 0, 2);
        assert!(arg2 < 10, 1);
        let v0 = get_random_points(arg3);
        0x2::balance::join<0x520cfde819014eaaf85e702c906565e368d9e9a32785c76ae7ac589e1395753a::ridesun_FAUCET_coin::RIDESUN_FAUCET_COIN>(&mut arg0.coins, 0x2::coin::into_balance<0x520cfde819014eaaf85e702c906565e368d9e9a32785c76ae7ac589e1395753a::ridesun_FAUCET_coin::RIDESUN_FAUCET_COIN>(arg1));
        arg0.amount = arg0.amount + 1;
        let (v1, v2) = if (arg2 + v0 == 14) {
            if (arg0.amount > 0) {
                0x2::transfer::public_transfer<0x2::coin::Coin<0x520cfde819014eaaf85e702c906565e368d9e9a32785c76ae7ac589e1395753a::ridesun_FAUCET_coin::RIDESUN_FAUCET_COIN>>(0x2::coin::take<0x520cfde819014eaaf85e702c906565e368d9e9a32785c76ae7ac589e1395753a::ridesun_FAUCET_coin::RIDESUN_FAUCET_COIN>(&mut arg0.coins, 1, arg4), 0x2::tx_context::sender(arg4));
            };
            (0x1::string::utf8(b"Win"), true)
        } else {
            (0x1::string::utf8(b"Lose"), false)
        };
        let v3 = GamingResultEvent{
            welcome         : 0x1::string::utf8(b"Welcome to ridesun's 14 points game!"),
            is_win          : v2,
            your_points     : arg2,
            computer_points : v0,
            result          : v1,
            reward          : 1,
        };
        0x2::event::emit<GamingResultEvent>(v3);
    }

    public entry fun withdraw(arg0: &mut GameCoinPool<0x520cfde819014eaaf85e702c906565e368d9e9a32785c76ae7ac589e1395753a::ridesun_FAUCET_coin::RIDESUN_FAUCET_COIN>, arg1: &mut 0x2::tx_context::TxContext) {
        0x2::transfer::public_transfer<0x2::coin::Coin<0x520cfde819014eaaf85e702c906565e368d9e9a32785c76ae7ac589e1395753a::ridesun_FAUCET_coin::RIDESUN_FAUCET_COIN>>(0x2::coin::take<0x520cfde819014eaaf85e702c906565e368d9e9a32785c76ae7ac589e1395753a::ridesun_FAUCET_coin::RIDESUN_FAUCET_COIN>(&mut arg0.coins, 0x2::balance::value<0x520cfde819014eaaf85e702c906565e368d9e9a32785c76ae7ac589e1395753a::ridesun_FAUCET_coin::RIDESUN_FAUCET_COIN>(&arg0.coins), arg1), arg0.owner);
    }

    // decompiled from Move bytecode v6
}

