module 0x2c19e1d24675ef3662101ec4091fb2a85038f956edb540227372b62c6ba9e0a9::task5 {
    struct Pool has key {
        id: 0x2::object::UID,
        coin_a: 0x2::balance::Balance<0x1f18bc4e7264786ea21d37d02534dd7c01d2b8a4a235752289dce32966c7c6ff::suiceber_coin::SUICEBER_COIN>,
        coin_b: 0x2::balance::Balance<0x36511f0b40af9836476af0edcbf58d922b9857cadde62f62e84a053942f816b4::suiceber_faucet_coin::SUICEBER_FAUCET_COIN>,
    }

    struct LiquidityEvent has copy, drop {
        provider: address,
        coin_a_amount: u64,
        coin_b_amount: u64,
        coin_a_type: 0x1::string::String,
        coin_b_type: 0x1::string::String,
        timestamp: u64,
    }

    struct SwapEvent has copy, drop {
        sender: address,
        coin_in_amount: u64,
        coin_out_amount: u64,
        coin_in_type: 0x1::string::String,
        coin_out_type: 0x1::string::String,
        timestamp: u64,
    }

    public entry fun add_liquidity(arg0: &mut Pool, arg1: 0x2::coin::Coin<0x1f18bc4e7264786ea21d37d02534dd7c01d2b8a4a235752289dce32966c7c6ff::suiceber_coin::SUICEBER_COIN>, arg2: 0x2::coin::Coin<0x36511f0b40af9836476af0edcbf58d922b9857cadde62f62e84a053942f816b4::suiceber_faucet_coin::SUICEBER_FAUCET_COIN>, arg3: &mut 0x2::tx_context::TxContext) {
        let v0 = 0x2::coin::value<0x1f18bc4e7264786ea21d37d02534dd7c01d2b8a4a235752289dce32966c7c6ff::suiceber_coin::SUICEBER_COIN>(&arg1);
        let v1 = 0x2::coin::value<0x36511f0b40af9836476af0edcbf58d922b9857cadde62f62e84a053942f816b4::suiceber_faucet_coin::SUICEBER_FAUCET_COIN>(&arg2);
        assert!(v0 > 0 && v1 > 0, 1);
        0x2::balance::join<0x1f18bc4e7264786ea21d37d02534dd7c01d2b8a4a235752289dce32966c7c6ff::suiceber_coin::SUICEBER_COIN>(&mut arg0.coin_a, 0x2::coin::into_balance<0x1f18bc4e7264786ea21d37d02534dd7c01d2b8a4a235752289dce32966c7c6ff::suiceber_coin::SUICEBER_COIN>(arg1));
        0x2::balance::join<0x36511f0b40af9836476af0edcbf58d922b9857cadde62f62e84a053942f816b4::suiceber_faucet_coin::SUICEBER_FAUCET_COIN>(&mut arg0.coin_b, 0x2::coin::into_balance<0x36511f0b40af9836476af0edcbf58d922b9857cadde62f62e84a053942f816b4::suiceber_faucet_coin::SUICEBER_FAUCET_COIN>(arg2));
        let v2 = LiquidityEvent{
            provider      : 0x2::tx_context::sender(arg3),
            coin_a_amount : v0,
            coin_b_amount : v1,
            coin_a_type   : 0x1::string::utf8(b"SUICEBER_COIN"),
            coin_b_type   : 0x1::string::utf8(b"SUICEBER_FAUCET_COIN"),
            timestamp     : 0x2::tx_context::epoch(arg3),
        };
        0x2::event::emit<LiquidityEvent>(v2);
    }

    fun init(arg0: &mut 0x2::tx_context::TxContext) {
        let v0 = Pool{
            id     : 0x2::object::new(arg0),
            coin_a : 0x2::balance::zero<0x1f18bc4e7264786ea21d37d02534dd7c01d2b8a4a235752289dce32966c7c6ff::suiceber_coin::SUICEBER_COIN>(),
            coin_b : 0x2::balance::zero<0x36511f0b40af9836476af0edcbf58d922b9857cadde62f62e84a053942f816b4::suiceber_faucet_coin::SUICEBER_FAUCET_COIN>(),
        };
        0x2::transfer::share_object<Pool>(v0);
    }

    public entry fun swap_a_to_b(arg0: &mut Pool, arg1: 0x2::coin::Coin<0x1f18bc4e7264786ea21d37d02534dd7c01d2b8a4a235752289dce32966c7c6ff::suiceber_coin::SUICEBER_COIN>, arg2: &mut 0x2::tx_context::TxContext) {
        let v0 = 0x2::coin::value<0x1f18bc4e7264786ea21d37d02534dd7c01d2b8a4a235752289dce32966c7c6ff::suiceber_coin::SUICEBER_COIN>(&arg1);
        assert!(v0 > 0, 1);
        let v1 = 0x2::balance::value<0x36511f0b40af9836476af0edcbf58d922b9857cadde62f62e84a053942f816b4::suiceber_faucet_coin::SUICEBER_FAUCET_COIN>(&arg0.coin_b);
        assert!(v1 > 0, 0);
        let v2 = v0 * v1 / (0x2::balance::value<0x1f18bc4e7264786ea21d37d02534dd7c01d2b8a4a235752289dce32966c7c6ff::suiceber_coin::SUICEBER_COIN>(&arg0.coin_a) + v0);
        assert!(v2 > 0 && v2 <= v1, 0);
        0x2::balance::join<0x1f18bc4e7264786ea21d37d02534dd7c01d2b8a4a235752289dce32966c7c6ff::suiceber_coin::SUICEBER_COIN>(&mut arg0.coin_a, 0x2::coin::into_balance<0x1f18bc4e7264786ea21d37d02534dd7c01d2b8a4a235752289dce32966c7c6ff::suiceber_coin::SUICEBER_COIN>(arg1));
        0x2::transfer::public_transfer<0x2::coin::Coin<0x36511f0b40af9836476af0edcbf58d922b9857cadde62f62e84a053942f816b4::suiceber_faucet_coin::SUICEBER_FAUCET_COIN>>(0x2::coin::take<0x36511f0b40af9836476af0edcbf58d922b9857cadde62f62e84a053942f816b4::suiceber_faucet_coin::SUICEBER_FAUCET_COIN>(&mut arg0.coin_b, v2, arg2), 0x2::tx_context::sender(arg2));
        let v3 = SwapEvent{
            sender          : 0x2::tx_context::sender(arg2),
            coin_in_amount  : v0,
            coin_out_amount : v2,
            coin_in_type    : 0x1::string::utf8(b"SUICEBER_COIN"),
            coin_out_type   : 0x1::string::utf8(b"SUICEBER_FAUCET_COIN"),
            timestamp       : 0x2::tx_context::epoch(arg2),
        };
        0x2::event::emit<SwapEvent>(v3);
    }

    public entry fun swap_b_to_a(arg0: &mut Pool, arg1: 0x2::coin::Coin<0x36511f0b40af9836476af0edcbf58d922b9857cadde62f62e84a053942f816b4::suiceber_faucet_coin::SUICEBER_FAUCET_COIN>, arg2: &mut 0x2::tx_context::TxContext) {
        let v0 = 0x2::coin::value<0x36511f0b40af9836476af0edcbf58d922b9857cadde62f62e84a053942f816b4::suiceber_faucet_coin::SUICEBER_FAUCET_COIN>(&arg1);
        assert!(v0 > 0, 1);
        let v1 = 0x2::balance::value<0x1f18bc4e7264786ea21d37d02534dd7c01d2b8a4a235752289dce32966c7c6ff::suiceber_coin::SUICEBER_COIN>(&arg0.coin_a);
        assert!(v1 > 0, 0);
        let v2 = v0 * v1 / (0x2::balance::value<0x36511f0b40af9836476af0edcbf58d922b9857cadde62f62e84a053942f816b4::suiceber_faucet_coin::SUICEBER_FAUCET_COIN>(&arg0.coin_b) + v0);
        assert!(v2 > 0 && v2 <= v1, 0);
        0x2::balance::join<0x36511f0b40af9836476af0edcbf58d922b9857cadde62f62e84a053942f816b4::suiceber_faucet_coin::SUICEBER_FAUCET_COIN>(&mut arg0.coin_b, 0x2::coin::into_balance<0x36511f0b40af9836476af0edcbf58d922b9857cadde62f62e84a053942f816b4::suiceber_faucet_coin::SUICEBER_FAUCET_COIN>(arg1));
        0x2::transfer::public_transfer<0x2::coin::Coin<0x1f18bc4e7264786ea21d37d02534dd7c01d2b8a4a235752289dce32966c7c6ff::suiceber_coin::SUICEBER_COIN>>(0x2::coin::take<0x1f18bc4e7264786ea21d37d02534dd7c01d2b8a4a235752289dce32966c7c6ff::suiceber_coin::SUICEBER_COIN>(&mut arg0.coin_a, v2, arg2), 0x2::tx_context::sender(arg2));
        let v3 = SwapEvent{
            sender          : 0x2::tx_context::sender(arg2),
            coin_in_amount  : v0,
            coin_out_amount : v2,
            coin_in_type    : 0x1::string::utf8(b"SUICEBER_FAUCET_COIN"),
            coin_out_type   : 0x1::string::utf8(b"SUICEBER_COIN"),
            timestamp       : 0x2::tx_context::epoch(arg2),
        };
        0x2::event::emit<SwapEvent>(v3);
    }

    // decompiled from Move bytecode v6
}

