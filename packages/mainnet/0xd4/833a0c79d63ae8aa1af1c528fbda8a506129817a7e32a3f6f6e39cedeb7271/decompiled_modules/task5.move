module 0xd4833a0c79d63ae8aa1af1c528fbda8a506129817a7e32a3f6f6e39cedeb7271::task5 {
    struct Pool has key {
        id: 0x2::object::UID,
        coin_a: 0x2::balance::Balance<0xd6269eb6a263d4f85a5f638432f299089559520e20f848da783f1471374830a4::suiceber_coin::SUICEBER_COIN>,
        coin_b: 0x2::balance::Balance<0xeb62c1564cf71fb4cc390f3514a0f4ba057630cc4a1cc406b5ee7790372b6fe2::suiceber_faucet_coin::SUICEBER_FAUCET_COIN>,
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

    public entry fun add_liquidity(arg0: &mut Pool, arg1: 0x2::coin::Coin<0xd6269eb6a263d4f85a5f638432f299089559520e20f848da783f1471374830a4::suiceber_coin::SUICEBER_COIN>, arg2: 0x2::coin::Coin<0xeb62c1564cf71fb4cc390f3514a0f4ba057630cc4a1cc406b5ee7790372b6fe2::suiceber_faucet_coin::SUICEBER_FAUCET_COIN>, arg3: &mut 0x2::tx_context::TxContext) {
        let v0 = 0x2::coin::value<0xd6269eb6a263d4f85a5f638432f299089559520e20f848da783f1471374830a4::suiceber_coin::SUICEBER_COIN>(&arg1);
        let v1 = 0x2::coin::value<0xeb62c1564cf71fb4cc390f3514a0f4ba057630cc4a1cc406b5ee7790372b6fe2::suiceber_faucet_coin::SUICEBER_FAUCET_COIN>(&arg2);
        assert!(v0 > 0 && v1 > 0, 1);
        0x2::balance::join<0xd6269eb6a263d4f85a5f638432f299089559520e20f848da783f1471374830a4::suiceber_coin::SUICEBER_COIN>(&mut arg0.coin_a, 0x2::coin::into_balance<0xd6269eb6a263d4f85a5f638432f299089559520e20f848da783f1471374830a4::suiceber_coin::SUICEBER_COIN>(arg1));
        0x2::balance::join<0xeb62c1564cf71fb4cc390f3514a0f4ba057630cc4a1cc406b5ee7790372b6fe2::suiceber_faucet_coin::SUICEBER_FAUCET_COIN>(&mut arg0.coin_b, 0x2::coin::into_balance<0xeb62c1564cf71fb4cc390f3514a0f4ba057630cc4a1cc406b5ee7790372b6fe2::suiceber_faucet_coin::SUICEBER_FAUCET_COIN>(arg2));
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
            coin_a : 0x2::balance::zero<0xd6269eb6a263d4f85a5f638432f299089559520e20f848da783f1471374830a4::suiceber_coin::SUICEBER_COIN>(),
            coin_b : 0x2::balance::zero<0xeb62c1564cf71fb4cc390f3514a0f4ba057630cc4a1cc406b5ee7790372b6fe2::suiceber_faucet_coin::SUICEBER_FAUCET_COIN>(),
        };
        0x2::transfer::share_object<Pool>(v0);
    }

    public entry fun swap_a_to_b(arg0: &mut Pool, arg1: 0x2::coin::Coin<0xd6269eb6a263d4f85a5f638432f299089559520e20f848da783f1471374830a4::suiceber_coin::SUICEBER_COIN>, arg2: &mut 0x2::tx_context::TxContext) {
        let v0 = 0x2::coin::value<0xd6269eb6a263d4f85a5f638432f299089559520e20f848da783f1471374830a4::suiceber_coin::SUICEBER_COIN>(&arg1);
        assert!(v0 > 0, 1);
        let v1 = 0x2::balance::value<0xeb62c1564cf71fb4cc390f3514a0f4ba057630cc4a1cc406b5ee7790372b6fe2::suiceber_faucet_coin::SUICEBER_FAUCET_COIN>(&arg0.coin_b);
        assert!(v1 > 0, 0);
        let v2 = v0 * v1 / (0x2::balance::value<0xd6269eb6a263d4f85a5f638432f299089559520e20f848da783f1471374830a4::suiceber_coin::SUICEBER_COIN>(&arg0.coin_a) + v0);
        assert!(v2 > 0 && v2 <= v1, 0);
        0x2::balance::join<0xd6269eb6a263d4f85a5f638432f299089559520e20f848da783f1471374830a4::suiceber_coin::SUICEBER_COIN>(&mut arg0.coin_a, 0x2::coin::into_balance<0xd6269eb6a263d4f85a5f638432f299089559520e20f848da783f1471374830a4::suiceber_coin::SUICEBER_COIN>(arg1));
        0x2::transfer::public_transfer<0x2::coin::Coin<0xeb62c1564cf71fb4cc390f3514a0f4ba057630cc4a1cc406b5ee7790372b6fe2::suiceber_faucet_coin::SUICEBER_FAUCET_COIN>>(0x2::coin::take<0xeb62c1564cf71fb4cc390f3514a0f4ba057630cc4a1cc406b5ee7790372b6fe2::suiceber_faucet_coin::SUICEBER_FAUCET_COIN>(&mut arg0.coin_b, v2, arg2), 0x2::tx_context::sender(arg2));
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

    public entry fun swap_b_to_a(arg0: &mut Pool, arg1: 0x2::coin::Coin<0xeb62c1564cf71fb4cc390f3514a0f4ba057630cc4a1cc406b5ee7790372b6fe2::suiceber_faucet_coin::SUICEBER_FAUCET_COIN>, arg2: &mut 0x2::tx_context::TxContext) {
        let v0 = 0x2::coin::value<0xeb62c1564cf71fb4cc390f3514a0f4ba057630cc4a1cc406b5ee7790372b6fe2::suiceber_faucet_coin::SUICEBER_FAUCET_COIN>(&arg1);
        assert!(v0 > 0, 1);
        let v1 = 0x2::balance::value<0xd6269eb6a263d4f85a5f638432f299089559520e20f848da783f1471374830a4::suiceber_coin::SUICEBER_COIN>(&arg0.coin_a);
        assert!(v1 > 0, 0);
        let v2 = v0 * v1 / (0x2::balance::value<0xeb62c1564cf71fb4cc390f3514a0f4ba057630cc4a1cc406b5ee7790372b6fe2::suiceber_faucet_coin::SUICEBER_FAUCET_COIN>(&arg0.coin_b) + v0);
        assert!(v2 > 0 && v2 <= v1, 0);
        0x2::balance::join<0xeb62c1564cf71fb4cc390f3514a0f4ba057630cc4a1cc406b5ee7790372b6fe2::suiceber_faucet_coin::SUICEBER_FAUCET_COIN>(&mut arg0.coin_b, 0x2::coin::into_balance<0xeb62c1564cf71fb4cc390f3514a0f4ba057630cc4a1cc406b5ee7790372b6fe2::suiceber_faucet_coin::SUICEBER_FAUCET_COIN>(arg1));
        0x2::transfer::public_transfer<0x2::coin::Coin<0xd6269eb6a263d4f85a5f638432f299089559520e20f848da783f1471374830a4::suiceber_coin::SUICEBER_COIN>>(0x2::coin::take<0xd6269eb6a263d4f85a5f638432f299089559520e20f848da783f1471374830a4::suiceber_coin::SUICEBER_COIN>(&mut arg0.coin_a, v2, arg2), 0x2::tx_context::sender(arg2));
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

