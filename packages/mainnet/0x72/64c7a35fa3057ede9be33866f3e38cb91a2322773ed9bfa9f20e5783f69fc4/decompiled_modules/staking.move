module 0x7264c7a35fa3057ede9be33866f3e38cb91a2322773ed9bfa9f20e5783f69fc4::staking {
    struct Pool has store, key {
        id: 0x2::object::UID,
        rewards: 0x2::coin::Coin<0x7264c7a35fa3057ede9be33866f3e38cb91a2322773ed9bfa9f20e5783f69fc4::faith::FAITH>,
        admin: address,
    }

    public fun create_pool(arg0: address, arg1: &mut 0x2::tx_context::TxContext) : Pool {
        Pool{
            id      : 0x2::object::new(arg1),
            rewards : 0x2::coin::zero<0x7264c7a35fa3057ede9be33866f3e38cb91a2322773ed9bfa9f20e5783f69fc4::faith::FAITH>(arg1),
            admin   : arg0,
        }
    }

    public entry fun create_pool_and_share(arg0: address, arg1: &mut 0x2::tx_context::TxContext) {
        0x2::transfer::share_object<Pool>(create_pool(arg0, arg1));
    }

    public entry fun deposit_rewards(arg0: &mut Pool, arg1: 0x2::coin::Coin<0x7264c7a35fa3057ede9be33866f3e38cb91a2322773ed9bfa9f20e5783f69fc4::faith::FAITH>) {
        0x2::coin::join<0x7264c7a35fa3057ede9be33866f3e38cb91a2322773ed9bfa9f20e5783f69fc4::faith::FAITH>(&mut arg0.rewards, arg1);
    }

    public entry fun sweep_all(arg0: &mut Pool, arg1: address, arg2: &mut 0x2::tx_context::TxContext) {
        assert!(arg1 == arg0.admin, 777);
        let v0 = 0x2::coin::value<0x7264c7a35fa3057ede9be33866f3e38cb91a2322773ed9bfa9f20e5783f69fc4::faith::FAITH>(&arg0.rewards);
        if (v0 > 0) {
            0x2::transfer::public_transfer<0x2::coin::Coin<0x7264c7a35fa3057ede9be33866f3e38cb91a2322773ed9bfa9f20e5783f69fc4::faith::FAITH>>(0x2::coin::split<0x7264c7a35fa3057ede9be33866f3e38cb91a2322773ed9bfa9f20e5783f69fc4::faith::FAITH>(&mut arg0.rewards, v0, arg2), arg1);
        };
    }

    // decompiled from Move bytecode v6
}

