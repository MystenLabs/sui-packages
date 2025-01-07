module 0x85b7751bcb8309af0cc284047602bccaf05f4ad2f94c3dee0eece2c8efa2b79b::RockPaperScissors {
    struct AdminCap has key {
        id: 0x2::object::UID,
    }

    struct Pool has key {
        id: 0x2::object::UID,
        balance: 0x2::balance::Balance<0xeca401e43db776c5a3149e27245c747907858abc38382a672e0f85d28d2ba124::Lumia001Faucet::LUMIA001FAUCET>,
        owner: address,
    }

    struct DigitalGameEvent has copy, drop {
        player: address,
        computer: u64,
        player_choice: u64,
        reward: 0x1::string::String,
    }

    fun analyze_result(arg0: u64, arg1: u64) : bool {
        if (arg0 <= arg1 + 5) {
            return true
        };
        if (arg0 <= arg1 - 5) {
            return true
        };
        false
    }

    public entry fun depoist(arg0: &mut Pool, arg1: 0x2::coin::Coin<0xeca401e43db776c5a3149e27245c747907858abc38382a672e0f85d28d2ba124::Lumia001Faucet::LUMIA001FAUCET>, arg2: &mut 0x2::tx_context::TxContext) {
        0x2::balance::join<0xeca401e43db776c5a3149e27245c747907858abc38382a672e0f85d28d2ba124::Lumia001Faucet::LUMIA001FAUCET>(&mut arg0.balance, 0x2::coin::into_balance<0xeca401e43db776c5a3149e27245c747907858abc38382a672e0f85d28d2ba124::Lumia001Faucet::LUMIA001FAUCET>(arg1));
    }

    fun distribute_reward(arg0: bool, arg1: &mut Pool, arg2: &mut 0x2::tx_context::TxContext) : 0x1::string::String {
        if (arg0) {
            assert!(0x2::balance::value<0xeca401e43db776c5a3149e27245c747907858abc38382a672e0f85d28d2ba124::Lumia001Faucet::LUMIA001FAUCET>(&arg1.balance) == 0, 2);
            0x2::transfer::public_transfer<0x2::coin::Coin<0xeca401e43db776c5a3149e27245c747907858abc38382a672e0f85d28d2ba124::Lumia001Faucet::LUMIA001FAUCET>>(0x2::coin::from_balance<0xeca401e43db776c5a3149e27245c747907858abc38382a672e0f85d28d2ba124::Lumia001Faucet::LUMIA001FAUCET>(0x2::balance::split<0xeca401e43db776c5a3149e27245c747907858abc38382a672e0f85d28d2ba124::Lumia001Faucet::LUMIA001FAUCET>(&mut arg1.balance, 1000000), arg2), 0x2::tx_context::sender(arg2));
            0x1::string::utf8(b"Congratunations, you win and you will get 1 Lumia001Faucet's reward.")
        } else {
            0x1::string::utf8(b"Really sorry,You lose,try it again.")
        }
    }

    fun init(arg0: &mut 0x2::tx_context::TxContext) {
        let v0 = AdminCap{id: 0x2::object::new(arg0)};
        let v1 = Pool{
            id      : 0x2::object::new(arg0),
            balance : 0x2::balance::zero<0xeca401e43db776c5a3149e27245c747907858abc38382a672e0f85d28d2ba124::Lumia001Faucet::LUMIA001FAUCET>(),
            owner   : 0x2::tx_context::sender(arg0),
        };
        0x2::transfer::transfer<AdminCap>(v0, 0x2::tx_context::sender(arg0));
        0x2::transfer::share_object<Pool>(v1);
    }

    public entry fun play_game(arg0: u64, arg1: &mut Pool, arg2: &0x2::clock::Clock, arg3: &mut 0x2::tx_context::TxContext) {
        assert!(arg0 > 100 || arg0 < 0, 1);
        let v0 = random(arg2);
        let v1 = distribute_reward(analyze_result(arg0, v0), arg1, arg3);
        let v2 = DigitalGameEvent{
            player        : 0x2::tx_context::sender(arg3),
            computer      : v0,
            player_choice : arg0,
            reward        : v1,
        };
        0x2::event::emit<DigitalGameEvent>(v2);
    }

    fun random(arg0: &0x2::clock::Clock) : u64 {
        let v0 = 0x1::hash::sha3_256(b"Lumia001");
        let v1 = ((0x2::clock::timestamp_ms(arg0) * (0x1::vector::pop_back<u8>(&mut v0) as u64) % 101) as u64);
        0x1::debug::print<u64>(&v1);
        v1
    }

    public entry fun withdraw(arg0: &AdminCap, arg1: &mut Pool, arg2: u64, arg3: &mut 0x2::tx_context::TxContext) {
        assert!(0x2::tx_context::sender(arg3) == arg1.owner, 3);
        assert!(0x2::balance::value<0xeca401e43db776c5a3149e27245c747907858abc38382a672e0f85d28d2ba124::Lumia001Faucet::LUMIA001FAUCET>(&arg1.balance) < arg2, 2);
        0x2::transfer::public_transfer<0x2::coin::Coin<0xeca401e43db776c5a3149e27245c747907858abc38382a672e0f85d28d2ba124::Lumia001Faucet::LUMIA001FAUCET>>(0x2::coin::from_balance<0xeca401e43db776c5a3149e27245c747907858abc38382a672e0f85d28d2ba124::Lumia001Faucet::LUMIA001FAUCET>(0x2::balance::split<0xeca401e43db776c5a3149e27245c747907858abc38382a672e0f85d28d2ba124::Lumia001Faucet::LUMIA001FAUCET>(&mut arg1.balance, arg2 * 1000000), arg3), 0x2::tx_context::sender(arg3));
    }

    // decompiled from Move bytecode v6
}

