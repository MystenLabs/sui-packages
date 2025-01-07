module 0xb73cdd947dcadbfbea8d199a5f5a5c30847acb04b4f3733f48761c5508dac2c9::move_swap {
    struct Pool has key {
        id: 0x2::object::UID,
        coin_a: 0x2::balance::Balance<0x5eba66432f3f60b472895c003872af367cc73f81c726207fae9585026da3858c::j_coin::J_COIN>,
        coin_b: 0x2::balance::Balance<0x5865895f21bad55e8c747d2b53a3787a123b55c2dd0ea070e0813873b1e2c347::faucet_j_coin::FAUCET_J_COIN>,
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

    public entry fun add_liquidity(arg0: &mut Pool, arg1: 0x2::coin::Coin<0x5eba66432f3f60b472895c003872af367cc73f81c726207fae9585026da3858c::j_coin::J_COIN>, arg2: 0x2::coin::Coin<0x5865895f21bad55e8c747d2b53a3787a123b55c2dd0ea070e0813873b1e2c347::faucet_j_coin::FAUCET_J_COIN>, arg3: &mut 0x2::tx_context::TxContext) {
        let v0 = 0x2::coin::value<0x5eba66432f3f60b472895c003872af367cc73f81c726207fae9585026da3858c::j_coin::J_COIN>(&arg1);
        let v1 = 0x2::coin::value<0x5865895f21bad55e8c747d2b53a3787a123b55c2dd0ea070e0813873b1e2c347::faucet_j_coin::FAUCET_J_COIN>(&arg2);
        assert!(v0 > 0 && v1 > 0, 1);
        0x2::balance::join<0x5eba66432f3f60b472895c003872af367cc73f81c726207fae9585026da3858c::j_coin::J_COIN>(&mut arg0.coin_a, 0x2::coin::into_balance<0x5eba66432f3f60b472895c003872af367cc73f81c726207fae9585026da3858c::j_coin::J_COIN>(arg1));
        0x2::balance::join<0x5865895f21bad55e8c747d2b53a3787a123b55c2dd0ea070e0813873b1e2c347::faucet_j_coin::FAUCET_J_COIN>(&mut arg0.coin_b, 0x2::coin::into_balance<0x5865895f21bad55e8c747d2b53a3787a123b55c2dd0ea070e0813873b1e2c347::faucet_j_coin::FAUCET_J_COIN>(arg2));
        let v2 = LiquidityEvent{
            provider      : 0x2::tx_context::sender(arg3),
            coin_a_amount : v0,
            coin_b_amount : v1,
            coin_a_type   : 0x1::string::utf8(b"J_COIN"),
            coin_b_type   : 0x1::string::utf8(b"FAUCET_J_COIN"),
            timestamp     : 0x2::tx_context::epoch(arg3),
        };
        0x2::event::emit<LiquidityEvent>(v2);
    }

    fun init(arg0: &mut 0x2::tx_context::TxContext) {
        let v0 = Pool{
            id     : 0x2::object::new(arg0),
            coin_a : 0x2::balance::zero<0x5eba66432f3f60b472895c003872af367cc73f81c726207fae9585026da3858c::j_coin::J_COIN>(),
            coin_b : 0x2::balance::zero<0x5865895f21bad55e8c747d2b53a3787a123b55c2dd0ea070e0813873b1e2c347::faucet_j_coin::FAUCET_J_COIN>(),
        };
        0x2::transfer::share_object<Pool>(v0);
    }

    public entry fun swap_a_to_b(arg0: &mut Pool, arg1: 0x2::coin::Coin<0x5eba66432f3f60b472895c003872af367cc73f81c726207fae9585026da3858c::j_coin::J_COIN>, arg2: &mut 0x2::tx_context::TxContext) {
        let v0 = 0x2::coin::value<0x5eba66432f3f60b472895c003872af367cc73f81c726207fae9585026da3858c::j_coin::J_COIN>(&arg1);
        assert!(v0 > 0, 1);
        let v1 = 0x2::balance::value<0x5865895f21bad55e8c747d2b53a3787a123b55c2dd0ea070e0813873b1e2c347::faucet_j_coin::FAUCET_J_COIN>(&arg0.coin_b);
        assert!(v1 > 0, 0);
        let v2 = v0 * v1 / (0x2::balance::value<0x5eba66432f3f60b472895c003872af367cc73f81c726207fae9585026da3858c::j_coin::J_COIN>(&arg0.coin_a) + v0);
        assert!(v2 > 0 && v2 <= v1, 0);
        0x2::balance::join<0x5eba66432f3f60b472895c003872af367cc73f81c726207fae9585026da3858c::j_coin::J_COIN>(&mut arg0.coin_a, 0x2::coin::into_balance<0x5eba66432f3f60b472895c003872af367cc73f81c726207fae9585026da3858c::j_coin::J_COIN>(arg1));
        0x2::transfer::public_transfer<0x2::coin::Coin<0x5865895f21bad55e8c747d2b53a3787a123b55c2dd0ea070e0813873b1e2c347::faucet_j_coin::FAUCET_J_COIN>>(0x2::coin::take<0x5865895f21bad55e8c747d2b53a3787a123b55c2dd0ea070e0813873b1e2c347::faucet_j_coin::FAUCET_J_COIN>(&mut arg0.coin_b, v2, arg2), 0x2::tx_context::sender(arg2));
        let v3 = SwapEvent{
            sender          : 0x2::tx_context::sender(arg2),
            coin_in_amount  : v0,
            coin_out_amount : v2,
            coin_in_type    : 0x1::string::utf8(b"J_COIN"),
            coin_out_type   : 0x1::string::utf8(b"FAUCET_J_COIN"),
            timestamp       : 0x2::tx_context::epoch(arg2),
        };
        0x2::event::emit<SwapEvent>(v3);
    }

    // decompiled from Move bytecode v6
}

