module 0x876bde98af774c6e5df5a0e0f484b8a2c9e3abadf596581ebce0fc62eeda2e85::my_swap {
    struct Pool has store, key {
        id: 0x2::object::UID,
        coinA: 0x2::balance::Balance<0x5e4d65fdd9f8db59ebcff3b99769896e9ac3f76c247370ed8897bcdfa7e20609::my_coin::MY_COIN>,
        coinB: 0x2::balance::Balance<0x5711dc07a73d745ab646c4c2b2961bb5342454d49681a30a7092ed66f065f081::mycoin::MYCOIN>,
    }

    public entry fun DepositA(arg0: &mut Pool, arg1: &mut 0x2::coin::Coin<0x5e4d65fdd9f8db59ebcff3b99769896e9ac3f76c247370ed8897bcdfa7e20609::my_coin::MY_COIN>, arg2: u64) {
        assert!(0x2::coin::value<0x5e4d65fdd9f8db59ebcff3b99769896e9ac3f76c247370ed8897bcdfa7e20609::my_coin::MY_COIN>(arg1) >= arg2, 100);
        0x2::balance::join<0x5e4d65fdd9f8db59ebcff3b99769896e9ac3f76c247370ed8897bcdfa7e20609::my_coin::MY_COIN>(&mut arg0.coinA, 0x2::balance::split<0x5e4d65fdd9f8db59ebcff3b99769896e9ac3f76c247370ed8897bcdfa7e20609::my_coin::MY_COIN>(0x2::coin::balance_mut<0x5e4d65fdd9f8db59ebcff3b99769896e9ac3f76c247370ed8897bcdfa7e20609::my_coin::MY_COIN>(arg1), arg2));
    }

    public entry fun DepositB(arg0: &mut Pool, arg1: &mut 0x2::coin::Coin<0x5711dc07a73d745ab646c4c2b2961bb5342454d49681a30a7092ed66f065f081::mycoin::MYCOIN>, arg2: u64) {
        assert!(0x2::coin::value<0x5711dc07a73d745ab646c4c2b2961bb5342454d49681a30a7092ed66f065f081::mycoin::MYCOIN>(arg1) >= arg2, 100);
        0x2::balance::join<0x5711dc07a73d745ab646c4c2b2961bb5342454d49681a30a7092ed66f065f081::mycoin::MYCOIN>(&mut arg0.coinB, 0x2::balance::split<0x5711dc07a73d745ab646c4c2b2961bb5342454d49681a30a7092ed66f065f081::mycoin::MYCOIN>(0x2::coin::balance_mut<0x5711dc07a73d745ab646c4c2b2961bb5342454d49681a30a7092ed66f065f081::mycoin::MYCOIN>(arg1), arg2));
    }

    fun init(arg0: &mut 0x2::tx_context::TxContext) {
        let v0 = Pool{
            id    : 0x2::object::new(arg0),
            coinA : 0x2::balance::zero<0x5e4d65fdd9f8db59ebcff3b99769896e9ac3f76c247370ed8897bcdfa7e20609::my_coin::MY_COIN>(),
            coinB : 0x2::balance::zero<0x5711dc07a73d745ab646c4c2b2961bb5342454d49681a30a7092ed66f065f081::mycoin::MYCOIN>(),
        };
        0x2::transfer::share_object<Pool>(v0);
    }

    public entry fun swap_A_to_B(arg0: &mut Pool, arg1: &mut 0x2::coin::Coin<0x5e4d65fdd9f8db59ebcff3b99769896e9ac3f76c247370ed8897bcdfa7e20609::my_coin::MY_COIN>, arg2: u64, arg3: &mut 0x2::tx_context::TxContext) {
        let v0 = 0x2::balance::value<0x5711dc07a73d745ab646c4c2b2961bb5342454d49681a30a7092ed66f065f081::mycoin::MYCOIN>(&arg0.coinB);
        let v1 = 0x2::balance::value<0x5e4d65fdd9f8db59ebcff3b99769896e9ac3f76c247370ed8897bcdfa7e20609::my_coin::MY_COIN>(&arg0.coinA);
        let v2 = if (arg2 > 0) {
            if (v0 > 0) {
                v1 > 0
            } else {
                false
            }
        } else {
            false
        };
        assert!(v2, 100);
        let v3 = arg2 * v0 / (v1 + arg2);
        assert!(v3 > 0 && v3 < v0, 100);
        0x2::balance::join<0x5e4d65fdd9f8db59ebcff3b99769896e9ac3f76c247370ed8897bcdfa7e20609::my_coin::MY_COIN>(&mut arg0.coinA, 0x2::balance::split<0x5e4d65fdd9f8db59ebcff3b99769896e9ac3f76c247370ed8897bcdfa7e20609::my_coin::MY_COIN>(0x2::coin::balance_mut<0x5e4d65fdd9f8db59ebcff3b99769896e9ac3f76c247370ed8897bcdfa7e20609::my_coin::MY_COIN>(arg1), arg2));
        0x2::transfer::public_transfer<0x2::coin::Coin<0x5711dc07a73d745ab646c4c2b2961bb5342454d49681a30a7092ed66f065f081::mycoin::MYCOIN>>(0x2::coin::take<0x5711dc07a73d745ab646c4c2b2961bb5342454d49681a30a7092ed66f065f081::mycoin::MYCOIN>(&mut arg0.coinB, v3, arg3), 0x2::tx_context::sender(arg3));
    }

    public entry fun swap_B_to_A(arg0: &mut Pool, arg1: &mut 0x2::coin::Coin<0x5711dc07a73d745ab646c4c2b2961bb5342454d49681a30a7092ed66f065f081::mycoin::MYCOIN>, arg2: u64, arg3: &mut 0x2::tx_context::TxContext) {
        let v0 = 0x2::balance::value<0x5711dc07a73d745ab646c4c2b2961bb5342454d49681a30a7092ed66f065f081::mycoin::MYCOIN>(&arg0.coinB);
        let v1 = 0x2::balance::value<0x5e4d65fdd9f8db59ebcff3b99769896e9ac3f76c247370ed8897bcdfa7e20609::my_coin::MY_COIN>(&arg0.coinA);
        let v2 = if (arg2 > 0) {
            if (v0 > 0) {
                v1 > 0
            } else {
                false
            }
        } else {
            false
        };
        assert!(v2, 100);
        let v3 = arg2 * v1 / (v0 + arg2);
        assert!(v3 > 0 && v3 < v1, 100);
        0x2::balance::join<0x5711dc07a73d745ab646c4c2b2961bb5342454d49681a30a7092ed66f065f081::mycoin::MYCOIN>(&mut arg0.coinB, 0x2::balance::split<0x5711dc07a73d745ab646c4c2b2961bb5342454d49681a30a7092ed66f065f081::mycoin::MYCOIN>(0x2::coin::balance_mut<0x5711dc07a73d745ab646c4c2b2961bb5342454d49681a30a7092ed66f065f081::mycoin::MYCOIN>(arg1), arg2));
        0x2::transfer::public_transfer<0x2::coin::Coin<0x5e4d65fdd9f8db59ebcff3b99769896e9ac3f76c247370ed8897bcdfa7e20609::my_coin::MY_COIN>>(0x2::coin::take<0x5e4d65fdd9f8db59ebcff3b99769896e9ac3f76c247370ed8897bcdfa7e20609::my_coin::MY_COIN>(&mut arg0.coinA, v3, arg3), 0x2::tx_context::sender(arg3));
    }

    // decompiled from Move bytecode v6
}

