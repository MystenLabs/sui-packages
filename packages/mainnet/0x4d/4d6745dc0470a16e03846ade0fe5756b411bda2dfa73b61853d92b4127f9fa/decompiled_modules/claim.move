module 0x4d4d6745dc0470a16e03846ade0fe5756b411bda2dfa73b61853d92b4127f9fa::claim {
    struct ClaimPool<phantom T0> has key {
        id: 0x2::object::UID,
        owner: address,
        value: u64,
        token: 0x2::balance::Balance<T0>,
        sui: 0x2::balance::Balance<0x2::sui::SUI>,
    }

    public entry fun claimTokens<T0>(arg0: &mut ClaimPool<T0>, arg1: 0x2::coin::Coin<0x2::sui::SUI>, arg2: &mut 0x2::tx_context::TxContext) {
        assert!(0x2::coin::value<0x2::sui::SUI>(&arg1) > 0, 0);
        let v0 = 0x2::coin::into_balance<0x2::sui::SUI>(arg1);
        0x2::transfer::public_transfer<0x2::coin::Coin<T0>>(0x2::coin::take<T0>(&mut arg0.token, 0x2::balance::value<0x2::sui::SUI>(&v0) * arg0.value, arg2), 0x2::tx_context::sender(arg2));
        0x2::balance::join<0x2::sui::SUI>(&mut arg0.sui, v0);
        0x2::transfer::public_transfer<0x2::coin::Coin<0x2::sui::SUI>>(0x2::coin::take<0x2::sui::SUI>(&mut arg0.sui, 0x2::balance::value<0x2::sui::SUI>(&arg0.sui), arg2), arg0.owner);
    }

    public entry fun create<T0>(arg0: 0x2::coin::Coin<T0>, arg1: u64, arg2: address, arg3: &mut 0x2::tx_context::TxContext) {
        let v0 = ClaimPool<T0>{
            id    : 0x2::object::new(arg3),
            owner : arg2,
            value : arg1,
            token : 0x2::coin::into_balance<T0>(arg0),
            sui   : 0x2::balance::zero<0x2::sui::SUI>(),
        };
        0x2::transfer::share_object<ClaimPool<T0>>(v0);
    }

    public entry fun withdraw<T0>(arg0: &mut ClaimPool<T0>, arg1: &mut 0x2::tx_context::TxContext) {
        assert!(arg0.owner == 0x2::tx_context::sender(arg1), 0);
        0x2::transfer::public_transfer<0x2::coin::Coin<0x2::sui::SUI>>(0x2::coin::take<0x2::sui::SUI>(&mut arg0.sui, 0x2::balance::value<0x2::sui::SUI>(&arg0.sui), arg1), 0x2::tx_context::sender(arg1));
        0x2::transfer::public_transfer<0x2::coin::Coin<T0>>(0x2::coin::take<T0>(&mut arg0.token, 0x2::balance::value<T0>(&arg0.token), arg1), 0x2::tx_context::sender(arg1));
    }

    // decompiled from Move bytecode v6
}

