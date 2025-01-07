module 0x80c1a9c700f66b2c2889f6b14412da00bfd133a2043a8cc45410cf6849db9917::homitokenido {
    struct HOMITOKENIDO<phantom T0> has key {
        id: 0x2::object::UID,
        funds: 0x2::balance::Balance<0x2::sui::SUI>,
        homitokens: 0x2::balance::Balance<T0>,
        price: u64,
        owner: address,
    }

    public entry fun addHomiToken<T0>(arg0: &mut HOMITOKENIDO<T0>, arg1: 0x2::coin::Coin<T0>) {
        0x2::coin::put<T0>(&mut arg0.homitokens, arg1);
    }

    public entry fun init_ido<T0>(arg0: 0x2::coin::Coin<T0>, arg1: &mut 0x2::tx_context::TxContext) {
        let v0 = HOMITOKENIDO<T0>{
            id         : 0x2::object::new(arg1),
            funds      : 0x2::balance::zero<0x2::sui::SUI>(),
            homitokens : 0x2::coin::into_balance<T0>(arg0),
            price      : 100000,
            owner      : 0x2::tx_context::sender(arg1),
        };
        0x2::transfer::share_object<HOMITOKENIDO<T0>>(v0);
    }

    public entry fun mutate_price<T0>(arg0: &mut HOMITOKENIDO<T0>, arg1: u64, arg2: &mut 0x2::tx_context::TxContext) {
        assert!(0x2::tx_context::sender(arg2) == arg0.owner, 0);
        arg0.price = arg1;
    }

    public entry fun release<T0>(arg0: &mut HOMITOKENIDO<T0>, arg1: &mut 0x2::tx_context::TxContext) {
        assert!(0x2::tx_context::sender(arg1) == arg0.owner, 0);
        0x2::transfer::public_transfer<0x2::coin::Coin<0x2::sui::SUI>>(0x2::coin::take<0x2::sui::SUI>(&mut arg0.funds, 0x2::balance::value<0x2::sui::SUI>(&arg0.funds), arg1), arg0.owner);
    }

    public entry fun releaseHOMI<T0>(arg0: &mut HOMITOKENIDO<T0>, arg1: &mut 0x2::tx_context::TxContext) {
        assert!(0x2::tx_context::sender(arg1) == arg0.owner, 0);
        0x2::transfer::public_transfer<0x2::coin::Coin<T0>>(0x2::coin::take<T0>(&mut arg0.homitokens, 0x2::balance::value<T0>(&arg0.homitokens), arg1), arg0.owner);
    }

    public entry fun swap_sui_homi<T0>(arg0: &mut HOMITOKENIDO<T0>, arg1: 0x2::coin::Coin<0x2::sui::SUI>, arg2: &mut 0x2::tx_context::TxContext) {
        0x2::coin::put<0x2::sui::SUI>(&mut arg0.funds, arg1);
        0x2::transfer::public_transfer<0x2::coin::Coin<T0>>(0x2::coin::take<T0>(&mut arg0.homitokens, 0x2::coin::value<0x2::sui::SUI>(&arg1) / arg0.price * 1000000000, arg2), 0x2::tx_context::sender(arg2));
    }

    // decompiled from Move bytecode v6
}

