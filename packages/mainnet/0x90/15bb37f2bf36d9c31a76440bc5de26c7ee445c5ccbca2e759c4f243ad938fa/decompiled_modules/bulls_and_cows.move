module 0x9015bb37f2bf36d9c31a76440bc5de26c7ee445c5ccbca2e759c4f243ad938fa::bulls_and_cows {
    struct GamingResultEvent has copy, drop {
        is_win: bool,
        your_number: u32,
        computer_number: u32,
        result: 0x1::string::String,
    }

    struct Bank has key {
        id: 0x2::object::UID,
        xu8117faucetcoin: 0x2::balance::Balance<0xca9c7bb11711716be7c7fd5ab6bfc1f07da94f5585a636b07c018cace18ec56f::xu8117faucetcoin::XU8117FAUCETCOIN>,
    }

    public entry fun deposit(arg0: &mut Bank, arg1: 0x2::coin::Coin<0xca9c7bb11711716be7c7fd5ab6bfc1f07da94f5585a636b07c018cace18ec56f::xu8117faucetcoin::XU8117FAUCETCOIN>, arg2: &mut 0x2::tx_context::TxContext) {
        0x2::balance::join<0xca9c7bb11711716be7c7fd5ab6bfc1f07da94f5585a636b07c018cace18ec56f::xu8117faucetcoin::XU8117FAUCETCOIN>(&mut arg0.xu8117faucetcoin, 0x2::coin::into_balance<0xca9c7bb11711716be7c7fd5ab6bfc1f07da94f5585a636b07c018cace18ec56f::xu8117faucetcoin::XU8117FAUCETCOIN>(arg1));
    }

    fun get_random_number(arg0: &0x2::clock::Clock) : u32 {
        ((0x2::clock::timestamp_ms(arg0) % 2) as u32)
    }

    fun init(arg0: &mut 0x2::tx_context::TxContext) {
        let v0 = Bank{
            id               : 0x2::object::new(arg0),
            xu8117faucetcoin : 0x2::balance::zero<0xca9c7bb11711716be7c7fd5ab6bfc1f07da94f5585a636b07c018cace18ec56f::xu8117faucetcoin::XU8117FAUCETCOIN>(),
        };
        0x2::transfer::share_object<Bank>(v0);
    }

    public fun play(arg0: &mut Bank, arg1: u32, arg2: &0x2::clock::Clock, arg3: &mut 0x2::tx_context::TxContext) {
        assert!(arg1 >= 0 && arg1 <= 1, 1);
        let v0 = get_random_number(arg2);
        let (v1, v2) = if (arg1 == v0) {
            (0x1::string::utf8(b"congratulation, you are win."), true)
        } else {
            (0x1::string::utf8(b"Unfortunately, your guess was not correct."), false)
        };
        if (v2) {
            withdraw(arg0, 1000000, arg3);
        };
        let v3 = GamingResultEvent{
            is_win          : v2,
            your_number     : arg1,
            computer_number : v0,
            result          : v1,
        };
        0x2::event::emit<GamingResultEvent>(v3);
    }

    public entry fun withdraw(arg0: &mut Bank, arg1: u64, arg2: &mut 0x2::tx_context::TxContext) {
        0x2::transfer::public_transfer<0x2::coin::Coin<0xca9c7bb11711716be7c7fd5ab6bfc1f07da94f5585a636b07c018cace18ec56f::xu8117faucetcoin::XU8117FAUCETCOIN>>(0x2::coin::from_balance<0xca9c7bb11711716be7c7fd5ab6bfc1f07da94f5585a636b07c018cace18ec56f::xu8117faucetcoin::XU8117FAUCETCOIN>(0x2::balance::split<0xca9c7bb11711716be7c7fd5ab6bfc1f07da94f5585a636b07c018cace18ec56f::xu8117faucetcoin::XU8117FAUCETCOIN>(&mut arg0.xu8117faucetcoin, arg1), arg2), 0x2::tx_context::sender(arg2));
    }

    // decompiled from Move bytecode v6
}

