module 0x8d4442173a2d14b2d06e7a2488733d9a982a31c70169fe92f98830a854f577d0::catfish_game {
    struct CatFishGameOwnerCap has key {
        id: 0x2::object::UID,
    }

    struct CatFishGameWallet has store, key {
        id: 0x2::object::UID,
        balance: 0x2::balance::Balance<0x2::sui::SUI>,
    }

    public fun deposit(arg0: &mut CatFishGameWallet, arg1: &mut 0x2::coin::Coin<0x2::sui::SUI>, arg2: &mut 0x2::tx_context::TxContext) {
        assert!(0x2::coin::value<0x2::sui::SUI>(arg1) > 0, 2);
        0x2::balance::join<0x2::sui::SUI>(&mut arg0.balance, 0x2::balance::split<0x2::sui::SUI>(0x2::coin::balance_mut<0x2::sui::SUI>(arg1), 0x2::coin::value<0x2::sui::SUI>(arg1)));
    }

    public fun distribute(arg0: &mut CatFishGameWallet, arg1: &CatFishGameOwnerCap, arg2: address, arg3: address, arg4: address, arg5: address, arg6: address, arg7: &mut 0x2::tx_context::TxContext) {
        let v0 = 0x2::balance::value<0x2::sui::SUI>(&arg0.balance);
        0x2::transfer::public_transfer<0x2::coin::Coin<0x2::sui::SUI>>(0x2::coin::from_balance<0x2::sui::SUI>(0x2::balance::split<0x2::sui::SUI>(&mut arg0.balance, v0 * 40 / 100), arg7), arg2);
        0x2::transfer::public_transfer<0x2::coin::Coin<0x2::sui::SUI>>(0x2::coin::from_balance<0x2::sui::SUI>(0x2::balance::split<0x2::sui::SUI>(&mut arg0.balance, v0 * 25 / 100), arg7), arg5);
        0x2::transfer::public_transfer<0x2::coin::Coin<0x2::sui::SUI>>(0x2::coin::from_balance<0x2::sui::SUI>(0x2::balance::split<0x2::sui::SUI>(&mut arg0.balance, v0 * 20 / 100), arg7), arg3);
        0x2::transfer::public_transfer<0x2::coin::Coin<0x2::sui::SUI>>(0x2::coin::from_balance<0x2::sui::SUI>(0x2::balance::split<0x2::sui::SUI>(&mut arg0.balance, v0 * 10 / 100), arg7), arg4);
        0x2::transfer::public_transfer<0x2::coin::Coin<0x2::sui::SUI>>(0x2::coin::from_balance<0x2::sui::SUI>(0x2::balance::split<0x2::sui::SUI>(&mut arg0.balance, v0 * 5 / 100), arg7), arg6);
    }

    fun init(arg0: &mut 0x2::tx_context::TxContext) {
        let v0 = CatFishGameOwnerCap{id: 0x2::object::new(arg0)};
        0x2::transfer::transfer<CatFishGameOwnerCap>(v0, 0x2::tx_context::sender(arg0));
        let v1 = CatFishGameWallet{
            id      : 0x2::object::new(arg0),
            balance : 0x2::balance::zero<0x2::sui::SUI>(),
        };
        0x2::transfer::share_object<CatFishGameWallet>(v1);
    }

    // decompiled from Move bytecode v6
}

