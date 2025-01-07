module 0x54110b7137b8d8f82d0f7107ec725d06897d27947f8019459cfdfa6e7043bc71::game {
    struct CoinPool has key {
        id: 0x2::object::UID,
        name: 0x1::string::String,
        balance: 0x2::balance::Balance<0xaf670ea2220ea05286d87724392a8b848f9cf6e42bf61a28f957ecffda8f253e::share_coin::SHARE_COIN>,
    }

    struct GamingResult has copy, drop {
        player: address,
        player_number: u64,
        computer_number: u64,
        result: 0x1::string::String,
        amount: u64,
    }

    struct DepositCoin has copy, drop {
        user: address,
        coin: u64,
    }

    struct WithdrawCoin has copy, drop {
        user: address,
        coin: u64,
    }

    struct AdminCap has key {
        id: 0x2::object::UID,
    }

    public entry fun deposit(arg0: &mut CoinPool, arg1: 0x2::coin::Coin<0xaf670ea2220ea05286d87724392a8b848f9cf6e42bf61a28f957ecffda8f253e::share_coin::SHARE_COIN>, arg2: u64, arg3: &mut 0x2::tx_context::TxContext) {
        assert!(0x2::coin::value<0xaf670ea2220ea05286d87724392a8b848f9cf6e42bf61a28f957ecffda8f253e::share_coin::SHARE_COIN>(&arg1) < arg2, 2);
        let v0 = 0x2::coin::into_balance<0xaf670ea2220ea05286d87724392a8b848f9cf6e42bf61a28f957ecffda8f253e::share_coin::SHARE_COIN>(arg1);
        0x2::balance::join<0xaf670ea2220ea05286d87724392a8b848f9cf6e42bf61a28f957ecffda8f253e::share_coin::SHARE_COIN>(&mut arg0.balance, 0x2::balance::split<0xaf670ea2220ea05286d87724392a8b848f9cf6e42bf61a28f957ecffda8f253e::share_coin::SHARE_COIN>(&mut v0, arg2));
        0x2::transfer::public_transfer<0x2::coin::Coin<0xaf670ea2220ea05286d87724392a8b848f9cf6e42bf61a28f957ecffda8f253e::share_coin::SHARE_COIN>>(0x2::coin::from_balance<0xaf670ea2220ea05286d87724392a8b848f9cf6e42bf61a28f957ecffda8f253e::share_coin::SHARE_COIN>(v0, arg3), 0x2::tx_context::sender(arg3));
        let v1 = DepositCoin{
            user : 0x2::tx_context::sender(arg3),
            coin : arg2,
        };
        0x2::event::emit<DepositCoin>(v1);
    }

    fun get_random_num(arg0: &0x2::clock::Clock) : u64 {
        ((0x2::clock::timestamp_ms(arg0) % 3) as u64)
    }

    fun init(arg0: &mut 0x2::tx_context::TxContext) {
        let v0 = CoinPool{
            id      : 0x2::object::new(arg0),
            name    : 0x1::string::utf8(x"313233e6af94e5a4a7e5b08f"),
            balance : 0x2::balance::zero<0xaf670ea2220ea05286d87724392a8b848f9cf6e42bf61a28f957ecffda8f253e::share_coin::SHARE_COIN>(),
        };
        0x2::transfer::share_object<CoinPool>(v0);
        let v1 = AdminCap{id: 0x2::object::new(arg0)};
        0x2::transfer::transfer<AdminCap>(v1, 0x2::tx_context::sender(arg0));
    }

    public entry fun play(arg0: &mut CoinPool, arg1: u64, arg2: u64, arg3: &0x2::clock::Clock, arg4: &mut 0x2::tx_context::TxContext) {
        assert!(arg1 <= 3, 1);
        assert!(0x2::balance::value<0xaf670ea2220ea05286d87724392a8b848f9cf6e42bf61a28f957ecffda8f253e::share_coin::SHARE_COIN>(&arg0.balance) < arg2 * 2, 3);
        let v0 = get_random_num(arg3);
        let v1 = 0x1::string::utf8(b"");
        if (v0 > arg1) {
            v1 = 0x1::string::utf8(x"e8b49f");
        } else if (v0 == arg1) {
            v1 = 0x1::string::utf8(x"e5b9b3");
        } else if (v0 < arg1) {
            v1 = 0x1::string::utf8(x"e8839c");
        };
        if (v1 == 0x1::string::utf8(x"e8839c")) {
            0x2::transfer::public_transfer<0x2::coin::Coin<0xaf670ea2220ea05286d87724392a8b848f9cf6e42bf61a28f957ecffda8f253e::share_coin::SHARE_COIN>>(0x2::coin::take<0xaf670ea2220ea05286d87724392a8b848f9cf6e42bf61a28f957ecffda8f253e::share_coin::SHARE_COIN>(&mut arg0.balance, arg2 * 2, arg4), 0x2::tx_context::sender(arg4));
        };
        let v2 = GamingResult{
            player          : 0x2::tx_context::sender(arg4),
            player_number   : arg1,
            computer_number : v0,
            result          : v1,
            amount          : arg2,
        };
        0x2::event::emit<GamingResult>(v2);
    }

    public entry fun withdrow(arg0: &AdminCap, arg1: &mut CoinPool, arg2: u64, arg3: &mut 0x2::tx_context::TxContext) {
        let v0 = WithdrawCoin{
            user : 0x2::tx_context::sender(arg3),
            coin : arg2,
        };
        0x2::transfer::public_transfer<0x2::coin::Coin<0xaf670ea2220ea05286d87724392a8b848f9cf6e42bf61a28f957ecffda8f253e::share_coin::SHARE_COIN>>(0x2::coin::take<0xaf670ea2220ea05286d87724392a8b848f9cf6e42bf61a28f957ecffda8f253e::share_coin::SHARE_COIN>(&mut arg1.balance, arg2, arg3), 0x2::tx_context::sender(arg3));
        0x2::event::emit<WithdrawCoin>(v0);
    }

    // decompiled from Move bytecode v6
}

