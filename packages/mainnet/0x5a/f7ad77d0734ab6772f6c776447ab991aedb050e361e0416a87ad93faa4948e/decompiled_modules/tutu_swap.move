module 0x5af7ad77d0734ab6772f6c776447ab991aedb050e361e0416a87ad93faa4948e::tutu_swap {
    struct Bank has key {
        id: 0x2::object::UID,
        mycoin: 0x2::balance::Balance<0xd0e013e834f9b832da96936e4306019ca50de6a4601cfc6fa2995f05ba990462::tutustack_coin::TUTUSTACK_COIN>,
        myfaucetcoin: 0x2::balance::Balance<0xd0e013e834f9b832da96936e4306019ca50de6a4601cfc6fa2995f05ba990462::tutustack_faucet_coin::TUTUSTACK_FAUCET_COIN>,
    }

    struct AdminCap has key {
        id: 0x2::object::UID,
    }

    public entry fun deposit_mycoin(arg0: &mut Bank, arg1: 0x2::coin::Coin<0xd0e013e834f9b832da96936e4306019ca50de6a4601cfc6fa2995f05ba990462::tutustack_coin::TUTUSTACK_COIN>, arg2: &mut 0x2::tx_context::TxContext) {
        0x2::balance::join<0xd0e013e834f9b832da96936e4306019ca50de6a4601cfc6fa2995f05ba990462::tutustack_coin::TUTUSTACK_COIN>(&mut arg0.mycoin, 0x2::coin::into_balance<0xd0e013e834f9b832da96936e4306019ca50de6a4601cfc6fa2995f05ba990462::tutustack_coin::TUTUSTACK_COIN>(arg1));
    }

    public entry fun deposit_myfaucetcoin(arg0: &mut Bank, arg1: 0x2::coin::Coin<0xd0e013e834f9b832da96936e4306019ca50de6a4601cfc6fa2995f05ba990462::tutustack_faucet_coin::TUTUSTACK_FAUCET_COIN>, arg2: &mut 0x2::tx_context::TxContext) {
        0x2::balance::join<0xd0e013e834f9b832da96936e4306019ca50de6a4601cfc6fa2995f05ba990462::tutustack_faucet_coin::TUTUSTACK_FAUCET_COIN>(&mut arg0.myfaucetcoin, 0x2::coin::into_balance<0xd0e013e834f9b832da96936e4306019ca50de6a4601cfc6fa2995f05ba990462::tutustack_faucet_coin::TUTUSTACK_FAUCET_COIN>(arg1));
    }

    fun init(arg0: &mut 0x2::tx_context::TxContext) {
        let v0 = Bank{
            id           : 0x2::object::new(arg0),
            mycoin       : 0x2::balance::zero<0xd0e013e834f9b832da96936e4306019ca50de6a4601cfc6fa2995f05ba990462::tutustack_coin::TUTUSTACK_COIN>(),
            myfaucetcoin : 0x2::balance::zero<0xd0e013e834f9b832da96936e4306019ca50de6a4601cfc6fa2995f05ba990462::tutustack_faucet_coin::TUTUSTACK_FAUCET_COIN>(),
        };
        0x2::transfer::share_object<Bank>(v0);
        let v1 = AdminCap{id: 0x2::object::new(arg0)};
        0x2::transfer::transfer<AdminCap>(v1, 0x2::tx_context::sender(arg0));
    }

    public entry fun swap_mycoin_to_myfaucetcoin(arg0: &mut Bank, arg1: u64, arg2: 0x2::coin::Coin<0xd0e013e834f9b832da96936e4306019ca50de6a4601cfc6fa2995f05ba990462::tutustack_coin::TUTUSTACK_COIN>, arg3: &mut 0x2::tx_context::TxContext) {
        0x2::balance::join<0xd0e013e834f9b832da96936e4306019ca50de6a4601cfc6fa2995f05ba990462::tutustack_coin::TUTUSTACK_COIN>(&mut arg0.mycoin, 0x2::coin::into_balance<0xd0e013e834f9b832da96936e4306019ca50de6a4601cfc6fa2995f05ba990462::tutustack_coin::TUTUSTACK_COIN>(arg2));
        0x2::transfer::public_transfer<0x2::coin::Coin<0xd0e013e834f9b832da96936e4306019ca50de6a4601cfc6fa2995f05ba990462::tutustack_faucet_coin::TUTUSTACK_FAUCET_COIN>>(0x2::coin::from_balance<0xd0e013e834f9b832da96936e4306019ca50de6a4601cfc6fa2995f05ba990462::tutustack_faucet_coin::TUTUSTACK_FAUCET_COIN>(0x2::balance::split<0xd0e013e834f9b832da96936e4306019ca50de6a4601cfc6fa2995f05ba990462::tutustack_faucet_coin::TUTUSTACK_FAUCET_COIN>(&mut arg0.myfaucetcoin, 0x2::coin::value<0xd0e013e834f9b832da96936e4306019ca50de6a4601cfc6fa2995f05ba990462::tutustack_coin::TUTUSTACK_COIN>(&arg2) * 73 / 10), arg3), 0x2::tx_context::sender(arg3));
    }

    public entry fun swap_myfaucetcoin_to_mycoin(arg0: &mut Bank, arg1: u64, arg2: 0x2::coin::Coin<0xd0e013e834f9b832da96936e4306019ca50de6a4601cfc6fa2995f05ba990462::tutustack_faucet_coin::TUTUSTACK_FAUCET_COIN>, arg3: &mut 0x2::tx_context::TxContext) {
        0x2::balance::join<0xd0e013e834f9b832da96936e4306019ca50de6a4601cfc6fa2995f05ba990462::tutustack_faucet_coin::TUTUSTACK_FAUCET_COIN>(&mut arg0.myfaucetcoin, 0x2::coin::into_balance<0xd0e013e834f9b832da96936e4306019ca50de6a4601cfc6fa2995f05ba990462::tutustack_faucet_coin::TUTUSTACK_FAUCET_COIN>(arg2));
        0x2::transfer::public_transfer<0x2::coin::Coin<0xd0e013e834f9b832da96936e4306019ca50de6a4601cfc6fa2995f05ba990462::tutustack_coin::TUTUSTACK_COIN>>(0x2::coin::from_balance<0xd0e013e834f9b832da96936e4306019ca50de6a4601cfc6fa2995f05ba990462::tutustack_coin::TUTUSTACK_COIN>(0x2::balance::split<0xd0e013e834f9b832da96936e4306019ca50de6a4601cfc6fa2995f05ba990462::tutustack_coin::TUTUSTACK_COIN>(&mut arg0.mycoin, 0x2::coin::value<0xd0e013e834f9b832da96936e4306019ca50de6a4601cfc6fa2995f05ba990462::tutustack_faucet_coin::TUTUSTACK_FAUCET_COIN>(&arg2) * 10 / 73), arg3), 0x2::tx_context::sender(arg3));
    }

    public entry fun withdraw_mycoin(arg0: &AdminCap, arg1: &mut Bank, arg2: u64, arg3: &mut 0x2::coin::Coin<0xd0e013e834f9b832da96936e4306019ca50de6a4601cfc6fa2995f05ba990462::tutustack_coin::TUTUSTACK_COIN>, arg4: &mut 0x2::tx_context::TxContext) {
        0x2::transfer::public_transfer<0x2::coin::Coin<0xd0e013e834f9b832da96936e4306019ca50de6a4601cfc6fa2995f05ba990462::tutustack_coin::TUTUSTACK_COIN>>(0x2::coin::from_balance<0xd0e013e834f9b832da96936e4306019ca50de6a4601cfc6fa2995f05ba990462::tutustack_coin::TUTUSTACK_COIN>(0x2::balance::split<0xd0e013e834f9b832da96936e4306019ca50de6a4601cfc6fa2995f05ba990462::tutustack_coin::TUTUSTACK_COIN>(&mut arg1.mycoin, arg2), arg4), 0x2::tx_context::sender(arg4));
    }

    public entry fun withdraw_myfaucetcoin(arg0: &AdminCap, arg1: &mut Bank, arg2: u64, arg3: &mut 0x2::coin::Coin<0xd0e013e834f9b832da96936e4306019ca50de6a4601cfc6fa2995f05ba990462::tutustack_faucet_coin::TUTUSTACK_FAUCET_COIN>, arg4: &mut 0x2::tx_context::TxContext) {
        0x2::transfer::public_transfer<0x2::coin::Coin<0xd0e013e834f9b832da96936e4306019ca50de6a4601cfc6fa2995f05ba990462::tutustack_faucet_coin::TUTUSTACK_FAUCET_COIN>>(0x2::coin::from_balance<0xd0e013e834f9b832da96936e4306019ca50de6a4601cfc6fa2995f05ba990462::tutustack_faucet_coin::TUTUSTACK_FAUCET_COIN>(0x2::balance::split<0xd0e013e834f9b832da96936e4306019ca50de6a4601cfc6fa2995f05ba990462::tutustack_faucet_coin::TUTUSTACK_FAUCET_COIN>(&mut arg1.myfaucetcoin, arg2), arg4), 0x2::tx_context::sender(arg4));
    }

    // decompiled from Move bytecode v6
}

