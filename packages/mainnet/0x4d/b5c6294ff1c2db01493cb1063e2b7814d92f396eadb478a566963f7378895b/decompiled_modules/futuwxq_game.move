module 0x4db5c6294ff1c2db01493cb1063e2b7814d92f396eadb478a566963f7378895b::futuwxq_game {
    struct ResultEvent has copy, drop {
        yourChoice: u8,
        randomChoice: u8,
        result: 0x1::string::String,
    }

    public fun generate_random(arg0: &0x2::clock::Clock) : u8 {
        ((0x2::clock::timestamp_ms(arg0) % 3) as u8)
    }

    public entry fun play(arg0: &mut 0x2::coin::TreasuryCap<0xf78f5a19f1bfceae1d850002c3676ca470af13858c4afed6e49419d1472ee7a0::futuwxq_faucet_coin::FUTUWXQ_FAUCET_COIN>, arg1: u8, arg2: &0x2::clock::Clock, arg3: &mut 0x2::tx_context::TxContext) {
        assert!(arg1 < 3, 0);
        let v0 = generate_random(arg2);
        let v1 = if (arg1 == v0) {
            0x1::string::utf8(b"Draw")
        } else if (arg1 == 0 && v0 == 1 || arg1 == 1 && v0 == 2 || arg1 == 2 && v0 == 1) {
            0x1::string::utf8(b"Fail")
        } else {
            0xf78f5a19f1bfceae1d850002c3676ca470af13858c4afed6e49419d1472ee7a0::futuwxq_faucet_coin::mint(arg0, 1, 0x2::tx_context::sender(arg3), arg3);
            0x1::string::utf8(b"Success")
        };
        let v2 = ResultEvent{
            yourChoice   : arg1,
            randomChoice : v0,
            result       : v1,
        };
        0x2::event::emit<ResultEvent>(v2);
    }

    // decompiled from Move bytecode v6
}

