module 0xe506fec551083f07b74512f8c71df25909803401130a82561c6477bb9b158672::task5 {
    struct Bank has key {
        id: 0x2::object::UID,
        coin: 0x2::balance::Balance<0x63926a3402c6085c1cea8af0e6ff15f67ae04e4e2d3d54b0c700dfa2d55ab43c::laolong1994_coin::LAOLONG1994_COIN>,
        faucet_coin: 0x2::balance::Balance<0x63926a3402c6085c1cea8af0e6ff15f67ae04e4e2d3d54b0c700dfa2d55ab43c::laolong1994_faucet_coin::LAOLONG1994_FAUCET_COIN>,
    }

    struct AdminCap has key {
        id: 0x2::object::UID,
    }

    public fun add_coin(arg0: &mut Bank, arg1: 0x2::coin::Coin<0x63926a3402c6085c1cea8af0e6ff15f67ae04e4e2d3d54b0c700dfa2d55ab43c::laolong1994_coin::LAOLONG1994_COIN>, arg2: &mut 0x2::tx_context::TxContext) {
        0x2::balance::join<0x63926a3402c6085c1cea8af0e6ff15f67ae04e4e2d3d54b0c700dfa2d55ab43c::laolong1994_coin::LAOLONG1994_COIN>(&mut arg0.coin, 0x2::coin::into_balance<0x63926a3402c6085c1cea8af0e6ff15f67ae04e4e2d3d54b0c700dfa2d55ab43c::laolong1994_coin::LAOLONG1994_COIN>(arg1));
    }

    public fun add_faucet_coin(arg0: &mut Bank, arg1: 0x2::coin::Coin<0x63926a3402c6085c1cea8af0e6ff15f67ae04e4e2d3d54b0c700dfa2d55ab43c::laolong1994_faucet_coin::LAOLONG1994_FAUCET_COIN>, arg2: &mut 0x2::tx_context::TxContext) {
        0x2::balance::join<0x63926a3402c6085c1cea8af0e6ff15f67ae04e4e2d3d54b0c700dfa2d55ab43c::laolong1994_faucet_coin::LAOLONG1994_FAUCET_COIN>(&mut arg0.faucet_coin, 0x2::coin::into_balance<0x63926a3402c6085c1cea8af0e6ff15f67ae04e4e2d3d54b0c700dfa2d55ab43c::laolong1994_faucet_coin::LAOLONG1994_FAUCET_COIN>(arg1));
    }

    public fun coin_to_faucet_coin(arg0: &mut Bank, arg1: 0x2::coin::Coin<0x63926a3402c6085c1cea8af0e6ff15f67ae04e4e2d3d54b0c700dfa2d55ab43c::laolong1994_coin::LAOLONG1994_COIN>, arg2: &mut 0x2::tx_context::TxContext) {
        0x2::balance::join<0x63926a3402c6085c1cea8af0e6ff15f67ae04e4e2d3d54b0c700dfa2d55ab43c::laolong1994_coin::LAOLONG1994_COIN>(&mut arg0.coin, 0x2::coin::into_balance<0x63926a3402c6085c1cea8af0e6ff15f67ae04e4e2d3d54b0c700dfa2d55ab43c::laolong1994_coin::LAOLONG1994_COIN>(arg1));
        0x2::transfer::public_transfer<0x2::coin::Coin<0x63926a3402c6085c1cea8af0e6ff15f67ae04e4e2d3d54b0c700dfa2d55ab43c::laolong1994_faucet_coin::LAOLONG1994_FAUCET_COIN>>(0x2::coin::from_balance<0x63926a3402c6085c1cea8af0e6ff15f67ae04e4e2d3d54b0c700dfa2d55ab43c::laolong1994_faucet_coin::LAOLONG1994_FAUCET_COIN>(0x2::balance::split<0x63926a3402c6085c1cea8af0e6ff15f67ae04e4e2d3d54b0c700dfa2d55ab43c::laolong1994_faucet_coin::LAOLONG1994_FAUCET_COIN>(&mut arg0.faucet_coin, 0x2::coin::value<0x63926a3402c6085c1cea8af0e6ff15f67ae04e4e2d3d54b0c700dfa2d55ab43c::laolong1994_coin::LAOLONG1994_COIN>(&arg1) * 72 / 10), arg2), 0x2::tx_context::sender(arg2));
    }

    public fun faucet_coin_to_coin(arg0: &mut Bank, arg1: 0x2::coin::Coin<0x63926a3402c6085c1cea8af0e6ff15f67ae04e4e2d3d54b0c700dfa2d55ab43c::laolong1994_faucet_coin::LAOLONG1994_FAUCET_COIN>, arg2: &mut 0x2::tx_context::TxContext) {
        0x2::balance::join<0x63926a3402c6085c1cea8af0e6ff15f67ae04e4e2d3d54b0c700dfa2d55ab43c::laolong1994_faucet_coin::LAOLONG1994_FAUCET_COIN>(&mut arg0.faucet_coin, 0x2::coin::into_balance<0x63926a3402c6085c1cea8af0e6ff15f67ae04e4e2d3d54b0c700dfa2d55ab43c::laolong1994_faucet_coin::LAOLONG1994_FAUCET_COIN>(arg1));
        0x2::transfer::public_transfer<0x2::coin::Coin<0x63926a3402c6085c1cea8af0e6ff15f67ae04e4e2d3d54b0c700dfa2d55ab43c::laolong1994_coin::LAOLONG1994_COIN>>(0x2::coin::from_balance<0x63926a3402c6085c1cea8af0e6ff15f67ae04e4e2d3d54b0c700dfa2d55ab43c::laolong1994_coin::LAOLONG1994_COIN>(0x2::balance::split<0x63926a3402c6085c1cea8af0e6ff15f67ae04e4e2d3d54b0c700dfa2d55ab43c::laolong1994_coin::LAOLONG1994_COIN>(&mut arg0.coin, 0x2::coin::value<0x63926a3402c6085c1cea8af0e6ff15f67ae04e4e2d3d54b0c700dfa2d55ab43c::laolong1994_faucet_coin::LAOLONG1994_FAUCET_COIN>(&arg1) * 10 / 72), arg2), 0x2::tx_context::sender(arg2));
    }

    fun init(arg0: &mut 0x2::tx_context::TxContext) {
        let v0 = Bank{
            id          : 0x2::object::new(arg0),
            coin        : 0x2::balance::zero<0x63926a3402c6085c1cea8af0e6ff15f67ae04e4e2d3d54b0c700dfa2d55ab43c::laolong1994_coin::LAOLONG1994_COIN>(),
            faucet_coin : 0x2::balance::zero<0x63926a3402c6085c1cea8af0e6ff15f67ae04e4e2d3d54b0c700dfa2d55ab43c::laolong1994_faucet_coin::LAOLONG1994_FAUCET_COIN>(),
        };
        0x2::transfer::share_object<Bank>(v0);
        let v1 = AdminCap{id: 0x2::object::new(arg0)};
        0x2::transfer::transfer<AdminCap>(v1, 0x2::tx_context::sender(arg0));
    }

    public fun without_coin(arg0: &AdminCap, arg1: &mut Bank, arg2: u64, arg3: &mut 0x2::tx_context::TxContext) {
        0x2::transfer::public_transfer<0x2::coin::Coin<0x63926a3402c6085c1cea8af0e6ff15f67ae04e4e2d3d54b0c700dfa2d55ab43c::laolong1994_faucet_coin::LAOLONG1994_FAUCET_COIN>>(0x2::coin::from_balance<0x63926a3402c6085c1cea8af0e6ff15f67ae04e4e2d3d54b0c700dfa2d55ab43c::laolong1994_faucet_coin::LAOLONG1994_FAUCET_COIN>(0x2::balance::split<0x63926a3402c6085c1cea8af0e6ff15f67ae04e4e2d3d54b0c700dfa2d55ab43c::laolong1994_faucet_coin::LAOLONG1994_FAUCET_COIN>(&mut arg1.faucet_coin, arg2), arg3), 0x2::tx_context::sender(arg3));
    }

    // decompiled from Move bytecode v6
}

