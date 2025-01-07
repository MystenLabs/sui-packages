module 0xea75b8e26aefbace54c8c434070c1c655c0341f5dbb1aed28b229761393bb958::leondev1024 {
    struct Pool has key {
        id: 0x2::object::UID,
        coin_a: 0x2::balance::Balance<0xe26e9e113df2c183e8d08ef5c9a0018acdb705155aa1d7c873a9646e7d3f6b84::leon_dev_1024_coin::LEON_DEV_1024_COIN>,
        coin_b: 0x2::balance::Balance<0xd3929e729b017a3c1ce40a4458cc00db8e71bb5882c99b1fe86bdc25899bb2ce::leon_dev_1024_faucet_coin::LEON_DEV_1024_FAUCET_COIN>,
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

    public entry fun add_liquidity(arg0: &mut Pool, arg1: 0x2::coin::Coin<0xe26e9e113df2c183e8d08ef5c9a0018acdb705155aa1d7c873a9646e7d3f6b84::leon_dev_1024_coin::LEON_DEV_1024_COIN>, arg2: 0x2::coin::Coin<0xd3929e729b017a3c1ce40a4458cc00db8e71bb5882c99b1fe86bdc25899bb2ce::leon_dev_1024_faucet_coin::LEON_DEV_1024_FAUCET_COIN>, arg3: &mut 0x2::tx_context::TxContext) {
        let v0 = 0x2::coin::value<0xe26e9e113df2c183e8d08ef5c9a0018acdb705155aa1d7c873a9646e7d3f6b84::leon_dev_1024_coin::LEON_DEV_1024_COIN>(&arg1);
        let v1 = 0x2::coin::value<0xd3929e729b017a3c1ce40a4458cc00db8e71bb5882c99b1fe86bdc25899bb2ce::leon_dev_1024_faucet_coin::LEON_DEV_1024_FAUCET_COIN>(&arg2);
        assert!(v0 > 0 && v1 > 0, 1);
        0x2::balance::join<0xe26e9e113df2c183e8d08ef5c9a0018acdb705155aa1d7c873a9646e7d3f6b84::leon_dev_1024_coin::LEON_DEV_1024_COIN>(&mut arg0.coin_a, 0x2::coin::into_balance<0xe26e9e113df2c183e8d08ef5c9a0018acdb705155aa1d7c873a9646e7d3f6b84::leon_dev_1024_coin::LEON_DEV_1024_COIN>(arg1));
        0x2::balance::join<0xd3929e729b017a3c1ce40a4458cc00db8e71bb5882c99b1fe86bdc25899bb2ce::leon_dev_1024_faucet_coin::LEON_DEV_1024_FAUCET_COIN>(&mut arg0.coin_b, 0x2::coin::into_balance<0xd3929e729b017a3c1ce40a4458cc00db8e71bb5882c99b1fe86bdc25899bb2ce::leon_dev_1024_faucet_coin::LEON_DEV_1024_FAUCET_COIN>(arg2));
        let v2 = LiquidityEvent{
            provider      : 0x2::tx_context::sender(arg3),
            coin_a_amount : v0,
            coin_b_amount : v1,
            coin_a_type   : 0x1::string::utf8(b"LEON_DEV_1024_COIN"),
            coin_b_type   : 0x1::string::utf8(b"LEON_DEV_1024_FAUCET_COIN"),
            timestamp     : 0x2::tx_context::epoch(arg3),
        };
        0x2::event::emit<LiquidityEvent>(v2);
    }

    fun init(arg0: &mut 0x2::tx_context::TxContext) {
        let v0 = Pool{
            id     : 0x2::object::new(arg0),
            coin_a : 0x2::balance::zero<0xe26e9e113df2c183e8d08ef5c9a0018acdb705155aa1d7c873a9646e7d3f6b84::leon_dev_1024_coin::LEON_DEV_1024_COIN>(),
            coin_b : 0x2::balance::zero<0xd3929e729b017a3c1ce40a4458cc00db8e71bb5882c99b1fe86bdc25899bb2ce::leon_dev_1024_faucet_coin::LEON_DEV_1024_FAUCET_COIN>(),
        };
        0x2::transfer::share_object<Pool>(v0);
    }

    public entry fun swap_a_to_b(arg0: &mut Pool, arg1: 0x2::coin::Coin<0xe26e9e113df2c183e8d08ef5c9a0018acdb705155aa1d7c873a9646e7d3f6b84::leon_dev_1024_coin::LEON_DEV_1024_COIN>, arg2: &mut 0x2::tx_context::TxContext) {
        let v0 = 0x2::coin::value<0xe26e9e113df2c183e8d08ef5c9a0018acdb705155aa1d7c873a9646e7d3f6b84::leon_dev_1024_coin::LEON_DEV_1024_COIN>(&arg1);
        assert!(v0 > 0, 1);
        let v1 = 0x2::balance::value<0xd3929e729b017a3c1ce40a4458cc00db8e71bb5882c99b1fe86bdc25899bb2ce::leon_dev_1024_faucet_coin::LEON_DEV_1024_FAUCET_COIN>(&arg0.coin_b);
        assert!(v1 > 0, 0);
        let v2 = v0 * v1 / (0x2::balance::value<0xe26e9e113df2c183e8d08ef5c9a0018acdb705155aa1d7c873a9646e7d3f6b84::leon_dev_1024_coin::LEON_DEV_1024_COIN>(&arg0.coin_a) + v0);
        assert!(v2 > 0 && v2 <= v1, 0);
        0x2::balance::join<0xe26e9e113df2c183e8d08ef5c9a0018acdb705155aa1d7c873a9646e7d3f6b84::leon_dev_1024_coin::LEON_DEV_1024_COIN>(&mut arg0.coin_a, 0x2::coin::into_balance<0xe26e9e113df2c183e8d08ef5c9a0018acdb705155aa1d7c873a9646e7d3f6b84::leon_dev_1024_coin::LEON_DEV_1024_COIN>(arg1));
        0x2::transfer::public_transfer<0x2::coin::Coin<0xd3929e729b017a3c1ce40a4458cc00db8e71bb5882c99b1fe86bdc25899bb2ce::leon_dev_1024_faucet_coin::LEON_DEV_1024_FAUCET_COIN>>(0x2::coin::take<0xd3929e729b017a3c1ce40a4458cc00db8e71bb5882c99b1fe86bdc25899bb2ce::leon_dev_1024_faucet_coin::LEON_DEV_1024_FAUCET_COIN>(&mut arg0.coin_b, v2, arg2), 0x2::tx_context::sender(arg2));
        let v3 = SwapEvent{
            sender          : 0x2::tx_context::sender(arg2),
            coin_in_amount  : v0,
            coin_out_amount : v2,
            coin_in_type    : 0x1::string::utf8(b"LEON_DEV_1024_COIN"),
            coin_out_type   : 0x1::string::utf8(b"LEON_DEV_1024_FAUCET_COIN"),
            timestamp       : 0x2::tx_context::epoch(arg2),
        };
        0x2::event::emit<SwapEvent>(v3);
    }

    public entry fun swap_b_to_a(arg0: &mut Pool, arg1: 0x2::coin::Coin<0xd3929e729b017a3c1ce40a4458cc00db8e71bb5882c99b1fe86bdc25899bb2ce::leon_dev_1024_faucet_coin::LEON_DEV_1024_FAUCET_COIN>, arg2: &mut 0x2::tx_context::TxContext) {
        let v0 = 0x2::coin::value<0xd3929e729b017a3c1ce40a4458cc00db8e71bb5882c99b1fe86bdc25899bb2ce::leon_dev_1024_faucet_coin::LEON_DEV_1024_FAUCET_COIN>(&arg1);
        assert!(v0 > 0, 1);
        let v1 = 0x2::balance::value<0xe26e9e113df2c183e8d08ef5c9a0018acdb705155aa1d7c873a9646e7d3f6b84::leon_dev_1024_coin::LEON_DEV_1024_COIN>(&arg0.coin_a);
        assert!(v1 > 0, 0);
        let v2 = v0 * v1 / (0x2::balance::value<0xd3929e729b017a3c1ce40a4458cc00db8e71bb5882c99b1fe86bdc25899bb2ce::leon_dev_1024_faucet_coin::LEON_DEV_1024_FAUCET_COIN>(&arg0.coin_b) + v0);
        assert!(v2 > 0 && v2 <= v1, 0);
        0x2::balance::join<0xd3929e729b017a3c1ce40a4458cc00db8e71bb5882c99b1fe86bdc25899bb2ce::leon_dev_1024_faucet_coin::LEON_DEV_1024_FAUCET_COIN>(&mut arg0.coin_b, 0x2::coin::into_balance<0xd3929e729b017a3c1ce40a4458cc00db8e71bb5882c99b1fe86bdc25899bb2ce::leon_dev_1024_faucet_coin::LEON_DEV_1024_FAUCET_COIN>(arg1));
        0x2::transfer::public_transfer<0x2::coin::Coin<0xe26e9e113df2c183e8d08ef5c9a0018acdb705155aa1d7c873a9646e7d3f6b84::leon_dev_1024_coin::LEON_DEV_1024_COIN>>(0x2::coin::take<0xe26e9e113df2c183e8d08ef5c9a0018acdb705155aa1d7c873a9646e7d3f6b84::leon_dev_1024_coin::LEON_DEV_1024_COIN>(&mut arg0.coin_a, v2, arg2), 0x2::tx_context::sender(arg2));
        let v3 = SwapEvent{
            sender          : 0x2::tx_context::sender(arg2),
            coin_in_amount  : v0,
            coin_out_amount : v2,
            coin_in_type    : 0x1::string::utf8(b"LEON_DEV_1024_FAUCET_COIN"),
            coin_out_type   : 0x1::string::utf8(b"LEON_DEV_1024_COIN"),
            timestamp       : 0x2::tx_context::epoch(arg2),
        };
        0x2::event::emit<SwapEvent>(v3);
    }

    // decompiled from Move bytecode v6
}

