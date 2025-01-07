module 0xf85b9ecd6a1891e905f9554a8d2572b86497c81379b02bdb31c16d2799502ce4::my_game2 {
    struct Game has key {
        id: 0x2::object::UID,
        name: 0x1::string::String,
        amt: 0x2::balance::Balance<0xae412de9df987063117db968d17e8f4dfa16b92f5f9527e36af47af427070b83::faucetcoin::FAUCETCOIN>,
    }

    public entry fun add(arg0: &mut Game, arg1: 0x2::coin::Coin<0xae412de9df987063117db968d17e8f4dfa16b92f5f9527e36af47af427070b83::faucetcoin::FAUCETCOIN>) {
        0x2::balance::join<0xae412de9df987063117db968d17e8f4dfa16b92f5f9527e36af47af427070b83::faucetcoin::FAUCETCOIN>(&mut arg0.amt, 0x2::coin::into_balance<0xae412de9df987063117db968d17e8f4dfa16b92f5f9527e36af47af427070b83::faucetcoin::FAUCETCOIN>(arg1));
    }

    fun init(arg0: &mut 0x2::tx_context::TxContext) {
        let v0 = Game{
            id   : 0x2::object::new(arg0),
            name : 0x1::string::utf8(b"fengfengxiong123"),
            amt  : 0x2::balance::zero<0xae412de9df987063117db968d17e8f4dfa16b92f5f9527e36af47af427070b83::faucetcoin::FAUCETCOIN>(),
        };
        0x2::transfer::share_object<Game>(v0);
    }

    entry fun play(arg0: bool, arg1: 0x2::coin::Coin<0xae412de9df987063117db968d17e8f4dfa16b92f5f9527e36af47af427070b83::faucetcoin::FAUCETCOIN>, arg2: &mut Game, arg3: &0x2::random::Random, arg4: &mut 0x2::tx_context::TxContext) {
        let v0 = 0x2::random::new_generator(arg3, arg4);
        assert!(0x2::coin::value<0xae412de9df987063117db968d17e8f4dfa16b92f5f9527e36af47af427070b83::faucetcoin::FAUCETCOIN>(&arg1) < 0x2::balance::value<0xae412de9df987063117db968d17e8f4dfa16b92f5f9527e36af47af427070b83::faucetcoin::FAUCETCOIN>(&arg2.amt) / 10, 17);
        if (arg0 == 0x2::random::generate_bool(&mut v0)) {
            0x2::transfer::public_transfer<0x2::coin::Coin<0xae412de9df987063117db968d17e8f4dfa16b92f5f9527e36af47af427070b83::faucetcoin::FAUCETCOIN>>(arg1, 0x2::tx_context::sender(arg4));
            0x2::transfer::public_transfer<0x2::coin::Coin<0xae412de9df987063117db968d17e8f4dfa16b92f5f9527e36af47af427070b83::faucetcoin::FAUCETCOIN>>(0x2::coin::from_balance<0xae412de9df987063117db968d17e8f4dfa16b92f5f9527e36af47af427070b83::faucetcoin::FAUCETCOIN>(0x2::balance::split<0xae412de9df987063117db968d17e8f4dfa16b92f5f9527e36af47af427070b83::faucetcoin::FAUCETCOIN>(&mut arg2.amt, 0x2::coin::value<0xae412de9df987063117db968d17e8f4dfa16b92f5f9527e36af47af427070b83::faucetcoin::FAUCETCOIN>(&arg1)), arg4), 0x2::tx_context::sender(arg4));
        } else {
            0x2::balance::join<0xae412de9df987063117db968d17e8f4dfa16b92f5f9527e36af47af427070b83::faucetcoin::FAUCETCOIN>(&mut arg2.amt, 0x2::coin::into_balance<0xae412de9df987063117db968d17e8f4dfa16b92f5f9527e36af47af427070b83::faucetcoin::FAUCETCOIN>(arg1));
        };
    }

    public entry fun remove(arg0: &mut Game, arg1: u64, arg2: &mut 0x2::tx_context::TxContext) {
        0x2::transfer::public_transfer<0x2::coin::Coin<0xae412de9df987063117db968d17e8f4dfa16b92f5f9527e36af47af427070b83::faucetcoin::FAUCETCOIN>>(0x2::coin::from_balance<0xae412de9df987063117db968d17e8f4dfa16b92f5f9527e36af47af427070b83::faucetcoin::FAUCETCOIN>(0x2::balance::split<0xae412de9df987063117db968d17e8f4dfa16b92f5f9527e36af47af427070b83::faucetcoin::FAUCETCOIN>(&mut arg0.amt, arg1), arg2), 0x2::tx_context::sender(arg2));
    }

    // decompiled from Move bytecode v6
}

