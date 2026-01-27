module 0x71d2f18028e597337c8b4dd0e4c199c3d92761beda37a77694517f0f68ae2ab9::casino {
    struct Casino<phantom T0> has store, key {
        id: 0x2::object::UID,
        balance: 0x2::balance::Balance<T0>,
        record: vector<0x2::vec_map::VecMap<0x2::object::ID, u8>>,
    }

    public(friend) fun new_casino<T0>(arg0: 0x2::balance::Balance<T0>, arg1: &mut 0x2::tx_context::TxContext) : Casino<T0> {
        Casino<T0>{
            id      : 0x2::object::new(arg1),
            balance : arg0,
            record  : 0x1::vector::empty<0x2::vec_map::VecMap<0x2::object::ID, u8>>(),
        }
    }

    public fun play<T0>(arg0: &mut Casino<T0>, arg1: &0x2::random::Random, arg2: 0x2::coin::Coin<T0>, arg3: &mut 0x2::tx_context::TxContext) : 0x2::coin::Coin<T0> {
        let v0 = 0x2::coin::zero<T0>(arg3);
        let v1 = 0x2::random::new_generator(arg1, arg3);
        if (0x2::random::generate_u64_in_range(&mut v1, 1, 100) > 0x2::random::generate_u64_in_range(&mut v1, 1, 120)) {
            0x2::coin::join<T0>(&mut v0, arg2);
            0x2::coin::join<T0>(&mut v0, 0x2::coin::from_balance<T0>(0x2::balance::split<T0>(&mut arg0.balance, 0x2::coin::value<T0>(&arg2) * 2000 / 10000), arg3));
        } else {
            0x2::balance::join<T0>(&mut arg0.balance, 0x2::coin::into_balance<T0>(arg2));
        };
        v0
    }

    // decompiled from Move bytecode v6
}

