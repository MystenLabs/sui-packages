module 0x9590f1822885a67e5adca95658532b545f10fc8781800bd5eb7274167761856d::guess_number {
    struct GuessGameResult has copy, drop {
        you_number: u64,
        game_number: u64,
        output: 0x1::string::String,
    }

    public entry fun play<T0>(arg0: &mut 0x2::coin::TreasuryCap<T0>, arg1: u64, arg2: &0x2::clock::Clock, arg3: &mut 0x2::tx_context::TxContext) {
        assert!(arg1 >= 0 && arg1 < 10, 1);
        let v0 = random(arg2);
        0x2::transfer::public_transfer<0x2::coin::Coin<T0>>(0x2::coin::mint<T0>(arg0, 1000000, arg3), 0x2::tx_context::sender(arg3));
        let v1 = if (v0 == arg1) {
            0x1::string::utf8(b"You Win!")
        } else {
            0x1::string::utf8(b"You Lose!")
        };
        let v2 = GuessGameResult{
            you_number  : arg1,
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

