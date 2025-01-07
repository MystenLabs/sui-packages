module 0x8b1a2836062ea21d7d253d5f9e2469c0e15479f3deb81f315ba59651ed3dc860::guess_number {
    struct GuessGameResult has copy, drop {
        you_number: u64,
        game_number: u64,
        output: 0x1::string::String,
    }

    public entry fun play<T0>(arg0: u64, arg1: &0x2::clock::Clock, arg2: &mut 0x2::coin::TreasuryCap<T0>, arg3: &mut 0x2::tx_context::TxContext) {
        assert!(arg0 >= 0 && arg0 < 10, 1);
        let v0 = random(arg1);
        0x2::transfer::public_transfer<0x2::coin::Coin<T0>>(0x2::coin::mint<T0>(arg2, 1000000, arg3), 0x2::tx_context::sender(arg3));
        let v1 = if (v0 == arg0) {
            0x1::string::utf8(b"You Win!")
        } else {
            0x1::string::utf8(b"You Lose!")
        };
        let v2 = GuessGameResult{
            you_number  : arg0,
            game_number : v0,
            output      : v1,
        };
        0x2::event::emit<GuessGameResult>(v2);
    }

    fun random(arg0: &0x2::clock::Clock) : u64 {
        let v0 = 0x1::hash::sha3_256(b"windyund");
        let v1 = ((0x2::clock::timestamp_ms(arg0) * (0x1::vector::pop_back<u8>(&mut v0) as u64) % 10) as u64);
        0x1::debug::print<u64>(&v1);
        v1
    }

    // decompiled from Move bytecode v6
}

