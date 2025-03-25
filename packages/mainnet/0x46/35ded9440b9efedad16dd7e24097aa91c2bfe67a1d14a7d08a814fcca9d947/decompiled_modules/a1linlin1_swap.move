module 0x4635ded9440b9efedad16dd7e24097aa91c2bfe67a1d14a7d08a814fcca9d947::a1linlin1_swap {
    struct Pool has key {
        id: 0x2::object::UID,
        balance_a: 0x2::balance::Balance<0xf03d70b8c37326289213f3b64f2ee82e6046dffca3ed26ed057c7ce8fd556565::A1LinLin1_coin::A1LINLIN1_COIN>,
        balance_b: 0x2::balance::Balance<0x9f4147dedf3fb03a3314db8262bdccf6be43794ab8f1496571b91bc42228ee1f::A1LinLin1_faucet_coin::A1LINLIN1_FAUCET_COIN>,
    }

    public fun addLiquidityAC(arg0: &mut Pool, arg1: 0x2::coin::Coin<0xf03d70b8c37326289213f3b64f2ee82e6046dffca3ed26ed057c7ce8fd556565::A1LinLin1_coin::A1LINLIN1_COIN>, arg2: &mut 0x2::tx_context::TxContext) {
        0x2::balance::join<0xf03d70b8c37326289213f3b64f2ee82e6046dffca3ed26ed057c7ce8fd556565::A1LinLin1_coin::A1LINLIN1_COIN>(&mut arg0.balance_a, 0x2::coin::into_balance<0xf03d70b8c37326289213f3b64f2ee82e6046dffca3ed26ed057c7ce8fd556565::A1LinLin1_coin::A1LINLIN1_COIN>(arg1));
    }

    public fun addLiquidityAFC(arg0: &mut Pool, arg1: 0x2::coin::Coin<0x9f4147dedf3fb03a3314db8262bdccf6be43794ab8f1496571b91bc42228ee1f::A1LinLin1_faucet_coin::A1LINLIN1_FAUCET_COIN>, arg2: &mut 0x2::tx_context::TxContext) {
        0x2::balance::join<0x9f4147dedf3fb03a3314db8262bdccf6be43794ab8f1496571b91bc42228ee1f::A1LinLin1_faucet_coin::A1LINLIN1_FAUCET_COIN>(&mut arg0.balance_b, 0x2::coin::into_balance<0x9f4147dedf3fb03a3314db8262bdccf6be43794ab8f1496571b91bc42228ee1f::A1LinLin1_faucet_coin::A1LINLIN1_FAUCET_COIN>(arg1));
    }

    fun init(arg0: &mut 0x2::tx_context::TxContext) {
        let v0 = Pool{
            id        : 0x2::object::new(arg0),
            balance_a : 0x2::balance::zero<0xf03d70b8c37326289213f3b64f2ee82e6046dffca3ed26ed057c7ce8fd556565::A1LinLin1_coin::A1LINLIN1_COIN>(),
            balance_b : 0x2::balance::zero<0x9f4147dedf3fb03a3314db8262bdccf6be43794ab8f1496571b91bc42228ee1f::A1LinLin1_faucet_coin::A1LINLIN1_FAUCET_COIN>(),
        };
        0x2::transfer::share_object<Pool>(v0);
    }

    public fun swap_a_for_b(arg0: &mut Pool, arg1: 0x2::coin::Coin<0xf03d70b8c37326289213f3b64f2ee82e6046dffca3ed26ed057c7ce8fd556565::A1LinLin1_coin::A1LINLIN1_COIN>, arg2: &mut 0x2::tx_context::TxContext) {
        0x2::balance::join<0xf03d70b8c37326289213f3b64f2ee82e6046dffca3ed26ed057c7ce8fd556565::A1LinLin1_coin::A1LINLIN1_COIN>(&mut arg0.balance_a, 0x2::coin::into_balance<0xf03d70b8c37326289213f3b64f2ee82e6046dffca3ed26ed057c7ce8fd556565::A1LinLin1_coin::A1LINLIN1_COIN>(arg1));
        0x2::transfer::public_transfer<0x2::coin::Coin<0x9f4147dedf3fb03a3314db8262bdccf6be43794ab8f1496571b91bc42228ee1f::A1LinLin1_faucet_coin::A1LINLIN1_FAUCET_COIN>>(0x2::coin::from_balance<0x9f4147dedf3fb03a3314db8262bdccf6be43794ab8f1496571b91bc42228ee1f::A1LinLin1_faucet_coin::A1LINLIN1_FAUCET_COIN>(0x2::balance::split<0x9f4147dedf3fb03a3314db8262bdccf6be43794ab8f1496571b91bc42228ee1f::A1LinLin1_faucet_coin::A1LINLIN1_FAUCET_COIN>(&mut arg0.balance_b, 0x2::coin::value<0xf03d70b8c37326289213f3b64f2ee82e6046dffca3ed26ed057c7ce8fd556565::A1LinLin1_coin::A1LINLIN1_COIN>(&arg1)), arg2), 0x2::tx_context::sender(arg2));
    }

    public fun swap_b_for_a(arg0: &mut Pool, arg1: 0x2::coin::Coin<0x9f4147dedf3fb03a3314db8262bdccf6be43794ab8f1496571b91bc42228ee1f::A1LinLin1_faucet_coin::A1LINLIN1_FAUCET_COIN>, arg2: &mut 0x2::tx_context::TxContext) {
        0x2::balance::join<0x9f4147dedf3fb03a3314db8262bdccf6be43794ab8f1496571b91bc42228ee1f::A1LinLin1_faucet_coin::A1LINLIN1_FAUCET_COIN>(&mut arg0.balance_b, 0x2::coin::into_balance<0x9f4147dedf3fb03a3314db8262bdccf6be43794ab8f1496571b91bc42228ee1f::A1LinLin1_faucet_coin::A1LINLIN1_FAUCET_COIN>(arg1));
        0x2::transfer::public_transfer<0x2::coin::Coin<0xf03d70b8c37326289213f3b64f2ee82e6046dffca3ed26ed057c7ce8fd556565::A1LinLin1_coin::A1LINLIN1_COIN>>(0x2::coin::from_balance<0xf03d70b8c37326289213f3b64f2ee82e6046dffca3ed26ed057c7ce8fd556565::A1LinLin1_coin::A1LINLIN1_COIN>(0x2::balance::split<0xf03d70b8c37326289213f3b64f2ee82e6046dffca3ed26ed057c7ce8fd556565::A1LinLin1_coin::A1LINLIN1_COIN>(&mut arg0.balance_a, 0x2::coin::value<0x9f4147dedf3fb03a3314db8262bdccf6be43794ab8f1496571b91bc42228ee1f::A1LinLin1_faucet_coin::A1LINLIN1_FAUCET_COIN>(&arg1)), arg2), 0x2::tx_context::sender(arg2));
    }

    // decompiled from Move bytecode v6
}

