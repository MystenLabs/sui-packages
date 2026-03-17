module 0x9de5bfb1384ab65dec70bab89f47c4aeb16beec99b38b561a2cc5f27fc014f8f::treasury {
    struct Treasury has key {
        id: 0x2::object::UID,
        dao_id: 0x2::object::ID,
        sui_balance: 0x2::balance::Balance<0x2::sui::SUI>,
    }

    public entry fun create_treasury(arg0: &0x9de5bfb1384ab65dec70bab89f47c4aeb16beec99b38b561a2cc5f27fc014f8f::dao::AdminCap, arg1: &0x9de5bfb1384ab65dec70bab89f47c4aeb16beec99b38b561a2cc5f27fc014f8f::dao::DaoConfig, arg2: &mut 0x2::tx_context::TxContext) {
        let v0 = Treasury{
            id          : 0x2::object::new(arg2),
            dao_id      : 0x2::object::id<0x9de5bfb1384ab65dec70bab89f47c4aeb16beec99b38b561a2cc5f27fc014f8f::dao::DaoConfig>(arg1),
            sui_balance : 0x2::balance::zero<0x2::sui::SUI>(),
        };
        0x2::transfer::share_object<Treasury>(v0);
    }

    public entry fun deposit_sui(arg0: &mut Treasury, arg1: 0x2::coin::Coin<0x2::sui::SUI>) {
        0x2::balance::join<0x2::sui::SUI>(&mut arg0.sui_balance, 0x2::coin::into_balance<0x2::sui::SUI>(arg1));
    }

    public entry fun execute_sui_transfer(arg0: &mut 0x9de5bfb1384ab65dec70bab89f47c4aeb16beec99b38b561a2cc5f27fc014f8f::dao::Proposal, arg1: &mut Treasury, arg2: &0x9de5bfb1384ab65dec70bab89f47c4aeb16beec99b38b561a2cc5f27fc014f8f::dao::DaoConfig, arg3: u64, arg4: address, arg5: &0x2::clock::Clock, arg6: &mut 0x2::tx_context::TxContext) {
        assert!(!0x9de5bfb1384ab65dec70bab89f47c4aeb16beec99b38b561a2cc5f27fc014f8f::dao::cancelled(arg0), 202);
        assert!(!0x9de5bfb1384ab65dec70bab89f47c4aeb16beec99b38b561a2cc5f27fc014f8f::dao::executed(arg0), 201);
        let (v0, _) = 0x9de5bfb1384ab65dec70bab89f47c4aeb16beec99b38b561a2cc5f27fc014f8f::vote::result(arg0, arg2, arg5);
        assert!(v0, 200);
        0x9de5bfb1384ab65dec70bab89f47c4aeb16beec99b38b561a2cc5f27fc014f8f::dao::mark_executed(arg0);
        0x2::transfer::public_transfer<0x2::coin::Coin<0x2::sui::SUI>>(0x2::coin::take<0x2::sui::SUI>(&mut arg1.sui_balance, arg3, arg6), arg4);
    }

    public fun sui_balance(arg0: &Treasury) : u64 {
        0x2::balance::value<0x2::sui::SUI>(&arg0.sui_balance)
    }

    // decompiled from Move bytecode v6
}

