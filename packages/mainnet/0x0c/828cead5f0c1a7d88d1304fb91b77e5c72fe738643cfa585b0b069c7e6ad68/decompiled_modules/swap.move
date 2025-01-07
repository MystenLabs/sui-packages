module 0xc828cead5f0c1a7d88d1304fb91b77e5c72fe738643cfa585b0b069c7e6ad68::swap {
    struct LSP<phantom T0, phantom T1> has drop {
        dummy_field: bool,
    }

    struct Pool<phantom T0, phantom T1> has key {
        id: 0x2::object::UID,
        coin_x: 0x2::balance::Balance<T0>,
        coin_y: 0x2::balance::Balance<T1>,
        lsp_supply: 0x2::balance::Supply<LSP<T0, T1>>,
        fee_percent: u64,
    }

    public entry fun add_liquidity<T0, T1>(arg0: &mut Pool<T0, T1>, arg1: 0x2::coin::Coin<T0>, arg2: 0x2::coin::Coin<T1>, arg3: &mut 0x2::tx_context::TxContext) {
        let v0 = 0x2::coin::value<T0>(&arg1);
        let v1 = 0x2::coin::value<T1>(&arg2);
        assert!(v0 >= 0 && v1 >= 0, 1001);
        0x2::balance::join<T1>(&mut arg0.coin_y, 0x2::coin::into_balance<T1>(arg2));
        let v2 = 0x1::ascii::string(b"coinB");
        0x1::debug::print<0x1::ascii::String>(&v2);
        let v3 = 0x2::balance::value<T1>(&arg0.coin_y);
        0x1::debug::print<u64>(&v3);
        0x2::coin::put<T0>(&mut arg0.coin_x, arg1);
        let v4 = 0x1::ascii::string(b"coinA");
        0x1::debug::print<0x1::ascii::String>(&v4);
        let v5 = 0x2::balance::value<T0>(&arg0.coin_x);
        0x1::debug::print<u64>(&v5);
        0x2::transfer::public_transfer<0x2::coin::Coin<LSP<T0, T1>>>(0x2::coin::from_balance<LSP<T0, T1>>(0x2::balance::increase_supply<LSP<T0, T1>>(&mut arg0.lsp_supply, v0 * 2 + v1), arg3), 0x2::tx_context::sender(arg3));
    }

    public fun calc_output_amount(arg0: u64, arg1: u64, arg2: u64) : u64 {
        let v0 = (arg0 as u128);
        let v1 = (arg1 as u128);
        ((v0 * v1 / (v0 - (arg2 as u128)) - v1) as u64)
    }

    public fun new_pool<T0, T1>(arg0: &mut 0x2::tx_context::TxContext) {
        let v0 = 0x1::ascii::string(b"init pool");
        0x1::debug::print<0x1::ascii::String>(&v0);
        let v1 = LSP<T0, T1>{dummy_field: false};
        let v2 = Pool<T0, T1>{
            id          : 0x2::object::new(arg0),
            coin_x      : 0x2::balance::zero<T0>(),
            coin_y      : 0x2::balance::zero<T1>(),
            lsp_supply  : 0x2::balance::create_supply<LSP<T0, T1>>(v1),
            fee_percent : (30 as u64),
        };
        0x2::transfer::share_object<Pool<T0, T1>>(v2);
    }

    public entry fun sellA<T0, T1>(arg0: &mut Pool<T0, T1>, arg1: 0x2::coin::Coin<T0>, arg2: &mut 0x2::tx_context::TxContext) {
        let v0 = 0x2::coin::value<T0>(&arg1);
        assert!(v0 > 0, 1001);
        let v1 = v0 / 2;
        let v2 = 0x2::balance::value<T1>(&arg0.coin_y);
        let v3 = 0x1::ascii::string(b"coinB supuly");
        0x1::debug::print<0x1::ascii::String>(&v3);
        0x1::debug::print<u64>(&v1);
        0x1::debug::print<u64>(&v2);
        assert!(v2 > v1, 1003);
        0x2::balance::join<T0>(&mut arg0.coin_x, 0x2::coin::into_balance<T0>(arg1));
        0x2::transfer::public_transfer<0x2::coin::Coin<T1>>(0x2::coin::take<T1>(&mut arg0.coin_y, v1, arg2), 0x2::tx_context::sender(arg2));
    }

    public entry fun sellB<T0, T1>(arg0: &mut Pool<T0, T1>, arg1: 0x2::coin::Coin<T1>, arg2: &mut 0x2::tx_context::TxContext) {
        let v0 = 0x2::coin::value<T1>(&arg1);
        assert!(v0 > 0, 1001);
        let v1 = v0 * 2;
        let v2 = 0x2::balance::value<T0>(&arg0.coin_x);
        let v3 = 0x1::ascii::string(b"coinA supuly");
        0x1::debug::print<0x1::ascii::String>(&v3);
        0x1::debug::print<u64>(&v1);
        0x1::debug::print<u64>(&v2);
        assert!(v2 > v1, 1003);
        0x2::balance::join<T1>(&mut arg0.coin_y, 0x2::coin::into_balance<T1>(arg1));
        0x2::transfer::public_transfer<0x2::coin::Coin<T0>>(0x2::coin::take<T0>(&mut arg0.coin_x, v1, arg2), 0x2::tx_context::sender(arg2));
    }

    // decompiled from Move bytecode v6
}

