module 0x8f3783f65d58c5ec323fe71f7d43b481cf88b981e30adaedcffe8b39cd5adc7f::airdrop {
    struct AirdropPool<phantom T0> has key {
        id: 0x2::object::UID,
        admin: address,
        pool: 0x2::balance::Balance<T0>,
    }

    entry fun create_pool<T0>(arg0: &mut 0x2::tx_context::TxContext) {
        let v0 = AirdropPool<T0>{
            id    : 0x2::object::new(arg0),
            admin : 0x2::tx_context::sender(arg0),
            pool  : 0x2::balance::zero<T0>(),
        };
        0x2::transfer::share_object<AirdropPool<T0>>(v0);
    }

    entry fun deposit<T0>(arg0: &mut AirdropPool<T0>, arg1: 0x2::coin::Coin<T0>) {
        0x2::balance::join<T0>(&mut arg0.pool, 0x2::coin::into_balance<T0>(arg1));
    }

    entry fun distribute<T0>(arg0: &mut AirdropPool<T0>, arg1: vector<address>, arg2: vector<u64>, arg3: &mut 0x2::tx_context::TxContext) {
        assert!(0x2::tx_context::sender(arg3) == arg0.admin, 0);
        assert!(0x1::vector::length<address>(&arg1) == 0x1::vector::length<u64>(&arg2), 1);
        let v0 = 0;
        while (v0 < 0x1::vector::length<address>(&arg1)) {
            let v1 = *0x1::vector::borrow<u64>(&arg2, v0);
            if (v1 > 0 && 0x2::balance::value<T0>(&arg0.pool) >= v1) {
                0x2::transfer::public_transfer<0x2::coin::Coin<T0>>(0x2::coin::from_balance<T0>(0x2::balance::split<T0>(&mut arg0.pool, v1), arg3), *0x1::vector::borrow<address>(&arg1, v0));
            };
            v0 = v0 + 1;
        };
    }

    entry fun withdraw<T0>(arg0: &mut AirdropPool<T0>, arg1: &mut 0x2::tx_context::TxContext) {
        assert!(0x2::tx_context::sender(arg1) == arg0.admin, 0);
        let v0 = 0x2::balance::value<T0>(&arg0.pool);
        if (v0 > 0) {
            0x2::transfer::public_transfer<0x2::coin::Coin<T0>>(0x2::coin::from_balance<T0>(0x2::balance::split<T0>(&mut arg0.pool, v0), arg1), arg0.admin);
        };
    }

    // decompiled from Move bytecode v6
}

