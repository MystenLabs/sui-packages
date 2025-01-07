module 0xde56fb47cbbfa4dbe2dcd014c7d81c1b510c442b10f573b4f79e028129e33733::task5 {
    struct Pool has key {
        id: 0x2::object::UID,
        coin_balance: 0x2::balance::Balance<0x9dba80f1aa2bb039b7da5aecdde81e4569757470c7080f0c04e32ef2a1023b56::suiceber_coin::SUICEBER_COIN>,
        faucet_balance: 0x2::balance::Balance<0x9dff1c645fdafdd15d37ba988544aa08955e28fad6783c21d2b539bc216efd4e::suiceber_faucet_coin::SUICEBER_FAUCET_COIN>,
    }

    public entry fun Deposit(arg0: &mut Pool, arg1: &mut 0x2::coin::Coin<0x9dba80f1aa2bb039b7da5aecdde81e4569757470c7080f0c04e32ef2a1023b56::suiceber_coin::SUICEBER_COIN>, arg2: &mut 0x2::coin::Coin<0x9dff1c645fdafdd15d37ba988544aa08955e28fad6783c21d2b539bc216efd4e::suiceber_faucet_coin::SUICEBER_FAUCET_COIN>, arg3: u64, arg4: u64) {
        0x2::balance::join<0x9dba80f1aa2bb039b7da5aecdde81e4569757470c7080f0c04e32ef2a1023b56::suiceber_coin::SUICEBER_COIN>(&mut arg0.coin_balance, 0x2::balance::split<0x9dba80f1aa2bb039b7da5aecdde81e4569757470c7080f0c04e32ef2a1023b56::suiceber_coin::SUICEBER_COIN>(0x2::coin::balance_mut<0x9dba80f1aa2bb039b7da5aecdde81e4569757470c7080f0c04e32ef2a1023b56::suiceber_coin::SUICEBER_COIN>(arg1), arg3));
        0x2::balance::join<0x9dff1c645fdafdd15d37ba988544aa08955e28fad6783c21d2b539bc216efd4e::suiceber_faucet_coin::SUICEBER_FAUCET_COIN>(&mut arg0.faucet_balance, 0x2::balance::split<0x9dff1c645fdafdd15d37ba988544aa08955e28fad6783c21d2b539bc216efd4e::suiceber_faucet_coin::SUICEBER_FAUCET_COIN>(0x2::coin::balance_mut<0x9dff1c645fdafdd15d37ba988544aa08955e28fad6783c21d2b539bc216efd4e::suiceber_faucet_coin::SUICEBER_FAUCET_COIN>(arg2), arg4));
    }

    fun init(arg0: &mut 0x2::tx_context::TxContext) {
        let v0 = Pool{
            id             : 0x2::object::new(arg0),
            coin_balance   : 0x2::balance::zero<0x9dba80f1aa2bb039b7da5aecdde81e4569757470c7080f0c04e32ef2a1023b56::suiceber_coin::SUICEBER_COIN>(),
            faucet_balance : 0x2::balance::zero<0x9dff1c645fdafdd15d37ba988544aa08955e28fad6783c21d2b539bc216efd4e::suiceber_faucet_coin::SUICEBER_FAUCET_COIN>(),
        };
        0x2::transfer::share_object<Pool>(v0);
    }

    public entry fun swap_coin_to_faucet(arg0: &mut Pool, arg1: &mut 0x2::coin::Coin<0x9dba80f1aa2bb039b7da5aecdde81e4569757470c7080f0c04e32ef2a1023b56::suiceber_coin::SUICEBER_COIN>, arg2: u64, arg3: &mut 0x2::tx_context::TxContext) {
        assert!(0x2::balance::value<0x9dff1c645fdafdd15d37ba988544aa08955e28fad6783c21d2b539bc216efd4e::suiceber_faucet_coin::SUICEBER_FAUCET_COIN>(&arg0.faucet_balance) >= arg2, 1000);
        0x2::balance::join<0x9dba80f1aa2bb039b7da5aecdde81e4569757470c7080f0c04e32ef2a1023b56::suiceber_coin::SUICEBER_COIN>(&mut arg0.coin_balance, 0x2::balance::split<0x9dba80f1aa2bb039b7da5aecdde81e4569757470c7080f0c04e32ef2a1023b56::suiceber_coin::SUICEBER_COIN>(0x2::coin::balance_mut<0x9dba80f1aa2bb039b7da5aecdde81e4569757470c7080f0c04e32ef2a1023b56::suiceber_coin::SUICEBER_COIN>(arg1), arg2));
        0x2::transfer::public_transfer<0x2::coin::Coin<0x9dff1c645fdafdd15d37ba988544aa08955e28fad6783c21d2b539bc216efd4e::suiceber_faucet_coin::SUICEBER_FAUCET_COIN>>(0x2::coin::take<0x9dff1c645fdafdd15d37ba988544aa08955e28fad6783c21d2b539bc216efd4e::suiceber_faucet_coin::SUICEBER_FAUCET_COIN>(&mut arg0.faucet_balance, arg2, arg3), 0x2::tx_context::sender(arg3));
    }

    public entry fun swap_faucet_to_coin(arg0: &mut Pool, arg1: &mut 0x2::coin::Coin<0x9dff1c645fdafdd15d37ba988544aa08955e28fad6783c21d2b539bc216efd4e::suiceber_faucet_coin::SUICEBER_FAUCET_COIN>, arg2: u64, arg3: &mut 0x2::tx_context::TxContext) {
        assert!(0x2::balance::value<0x9dba80f1aa2bb039b7da5aecdde81e4569757470c7080f0c04e32ef2a1023b56::suiceber_coin::SUICEBER_COIN>(&arg0.coin_balance) >= arg2, 1000);
        0x2::balance::join<0x9dff1c645fdafdd15d37ba988544aa08955e28fad6783c21d2b539bc216efd4e::suiceber_faucet_coin::SUICEBER_FAUCET_COIN>(&mut arg0.faucet_balance, 0x2::balance::split<0x9dff1c645fdafdd15d37ba988544aa08955e28fad6783c21d2b539bc216efd4e::suiceber_faucet_coin::SUICEBER_FAUCET_COIN>(0x2::coin::balance_mut<0x9dff1c645fdafdd15d37ba988544aa08955e28fad6783c21d2b539bc216efd4e::suiceber_faucet_coin::SUICEBER_FAUCET_COIN>(arg1), arg2));
        0x2::transfer::public_transfer<0x2::coin::Coin<0x9dba80f1aa2bb039b7da5aecdde81e4569757470c7080f0c04e32ef2a1023b56::suiceber_coin::SUICEBER_COIN>>(0x2::coin::take<0x9dba80f1aa2bb039b7da5aecdde81e4569757470c7080f0c04e32ef2a1023b56::suiceber_coin::SUICEBER_COIN>(&mut arg0.coin_balance, arg2, arg3), 0x2::tx_context::sender(arg3));
    }

    // decompiled from Move bytecode v6
}

