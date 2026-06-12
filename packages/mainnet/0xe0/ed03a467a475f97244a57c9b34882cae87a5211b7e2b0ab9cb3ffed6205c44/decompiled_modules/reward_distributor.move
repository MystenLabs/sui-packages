module 0xe0ed03a467a475f97244a57c9b34882cae87a5211b7e2b0ab9cb3ffed6205c44::reward_distributor {
    struct RewardPool has key {
        id: 0x2::object::UID,
        balance: 0x2::balance::Balance<0x2::sui::SUI>,
        admin: address,
        finalized: bool,
        payouts: 0x2::table::Table<0x2::object::ID, u64>,
        claimed: 0x2::table::Table<0x2::object::ID, bool>,
    }

    struct PoolDeposited has copy, drop {
        amount: u64,
        new_total: u64,
    }

    struct PoolFinalized has copy, drop {
        total: u64,
    }

    struct RewardClaimed has copy, drop {
        card_id: 0x2::object::ID,
        recipient: address,
        amount: u64,
    }

    public fun claim(arg0: &mut RewardPool, arg1: &0xe0ed03a467a475f97244a57c9b34882cae87a5211b7e2b0ab9cb3ffed6205c44::player_card::PlayerCard, arg2: address, arg3: &mut 0x2::tx_context::TxContext) {
        assert!(arg0.finalized, 2);
        assert!(!0xe0ed03a467a475f97244a57c9b34882cae87a5211b7e2b0ab9cb3ffed6205c44::player_card::is_alive(arg1), 4);
        let v0 = 0x2::object::id<0xe0ed03a467a475f97244a57c9b34882cae87a5211b7e2b0ab9cb3ffed6205c44::player_card::PlayerCard>(arg1);
        assert!(!0x2::table::contains<0x2::object::ID, bool>(&arg0.claimed, v0), 1);
        assert!(0x2::table::contains<0x2::object::ID, u64>(&arg0.payouts, v0), 3);
        let v1 = *0x2::table::borrow<0x2::object::ID, u64>(&arg0.payouts, v0);
        assert!(v1 > 0, 3);
        0x2::table::add<0x2::object::ID, bool>(&mut arg0.claimed, v0, true);
        0x2::transfer::public_transfer<0x2::coin::Coin<0x2::sui::SUI>>(0x2::coin::from_balance<0x2::sui::SUI>(0x2::balance::split<0x2::sui::SUI>(&mut arg0.balance, v1), arg3), arg2);
        let v2 = RewardClaimed{
            card_id   : v0,
            recipient : arg2,
            amount    : v1,
        };
        0x2::event::emit<RewardClaimed>(v2);
    }

    public(friend) fun deposit(arg0: &mut RewardPool, arg1: 0x2::coin::Coin<0x2::sui::SUI>) {
        0x2::balance::join<0x2::sui::SUI>(&mut arg0.balance, 0x2::coin::into_balance<0x2::sui::SUI>(arg1));
        let v0 = PoolDeposited{
            amount    : 0x2::coin::value<0x2::sui::SUI>(&arg1),
            new_total : 0x2::balance::value<0x2::sui::SUI>(&arg0.balance),
        };
        0x2::event::emit<PoolDeposited>(v0);
    }

    public fun deposit_direct(arg0: &mut RewardPool, arg1: 0x2::coin::Coin<0x2::sui::SUI>) {
        0x2::balance::join<0x2::sui::SUI>(&mut arg0.balance, 0x2::coin::into_balance<0x2::sui::SUI>(arg1));
        let v0 = PoolDeposited{
            amount    : 0x2::coin::value<0x2::sui::SUI>(&arg1),
            new_total : 0x2::balance::value<0x2::sui::SUI>(&arg0.balance),
        };
        0x2::event::emit<PoolDeposited>(v0);
    }

    public fun distribute(arg0: &mut RewardPool, arg1: vector<0x2::object::ID>, arg2: vector<address>, arg3: &mut 0x2::tx_context::TxContext) {
        assert!(0x2::tx_context::sender(arg3) == arg0.admin, 0);
        assert!(arg0.finalized, 2);
        let v0 = 0x1::vector::length<0x2::object::ID>(&arg1);
        assert!(0x1::vector::length<address>(&arg2) == v0, 5);
        let v1 = 0;
        while (v1 < v0) {
            let v2 = *0x1::vector::borrow<0x2::object::ID>(&arg1, v1);
            let v3 = *0x1::vector::borrow<address>(&arg2, v1);
            if (!0x2::table::contains<0x2::object::ID, bool>(&arg0.claimed, v2) && 0x2::table::contains<0x2::object::ID, u64>(&arg0.payouts, v2)) {
                let v4 = *0x2::table::borrow<0x2::object::ID, u64>(&arg0.payouts, v2);
                if (v4 > 0) {
                    0x2::table::add<0x2::object::ID, bool>(&mut arg0.claimed, v2, true);
                    0x2::transfer::public_transfer<0x2::coin::Coin<0x2::sui::SUI>>(0x2::coin::from_balance<0x2::sui::SUI>(0x2::balance::split<0x2::sui::SUI>(&mut arg0.balance, v4), arg3), v3);
                    let v5 = RewardClaimed{
                        card_id   : v2,
                        recipient : v3,
                        amount    : v4,
                    };
                    0x2::event::emit<RewardClaimed>(v5);
                };
            };
            v1 = v1 + 1;
        };
    }

    public fun finalize(arg0: &mut RewardPool, arg1: vector<0x2::object::ID>, arg2: vector<u8>, arg3: u64, arg4: &mut 0x2::tx_context::TxContext) {
        assert!(0x2::tx_context::sender(arg4) == arg0.admin, 0);
        assert!(!arg0.finalized, 2);
        let v0 = 0x2::balance::value<0x2::sui::SUI>(&arg0.balance);
        let v1 = 0x1::vector::length<0x2::object::ID>(&arg1);
        assert!(0x1::vector::length<u8>(&arg2) == v1, 5);
        let v2 = v0;
        let v3 = 0;
        while (v3 < v1) {
            let v4 = *0x1::vector::borrow<u8>(&arg2, v3);
            let v5 = if (v4 == 5) {
                v0 * 3000 / 10000
            } else if (v4 == 4) {
                v0 * 1500 / 10000
            } else if (v4 == 3) {
                v0 * 800 / 10000
            } else if (v4 == 2) {
                v0 * 400 / 10000
            } else if (v4 == 1) {
                v0 * 200 / 10000
            } else {
                0
            };
            if (v4 != 0) {
                let v6 = if (v2 > v5) {
                    v2 - v5
                } else {
                    0
                };
                v2 = v6;
                0x2::table::add<0x2::object::ID, u64>(&mut arg0.payouts, *0x1::vector::borrow<0x2::object::ID>(&arg1, v3), v5);
            };
            v3 = v3 + 1;
        };
        let v7 = if (arg3 > 0) {
            v2 / arg3
        } else {
            0
        };
        let v8 = 0;
        while (v8 < v1) {
            if (*0x1::vector::borrow<u8>(&arg2, v8) == 0) {
                0x2::table::add<0x2::object::ID, u64>(&mut arg0.payouts, *0x1::vector::borrow<0x2::object::ID>(&arg1, v8), v7);
            };
            v8 = v8 + 1;
        };
        arg0.finalized = true;
        let v9 = PoolFinalized{total: v0};
        0x2::event::emit<PoolFinalized>(v9);
    }

    fun init(arg0: &mut 0x2::tx_context::TxContext) {
        let v0 = RewardPool{
            id        : 0x2::object::new(arg0),
            balance   : 0x2::balance::zero<0x2::sui::SUI>(),
            admin     : 0x2::tx_context::sender(arg0),
            finalized : false,
            payouts   : 0x2::table::new<0x2::object::ID, u64>(arg0),
            claimed   : 0x2::table::new<0x2::object::ID, bool>(arg0),
        };
        0x2::transfer::share_object<RewardPool>(v0);
    }

    public fun is_claimed(arg0: &RewardPool, arg1: 0x2::object::ID) : bool {
        0x2::table::contains<0x2::object::ID, bool>(&arg0.claimed, arg1)
    }

    public fun is_finalized(arg0: &RewardPool) : bool {
        arg0.finalized
    }

    public fun payout_for(arg0: &RewardPool, arg1: 0x2::object::ID) : u64 {
        if (0x2::table::contains<0x2::object::ID, u64>(&arg0.payouts, arg1)) {
            *0x2::table::borrow<0x2::object::ID, u64>(&arg0.payouts, arg1)
        } else {
            0
        }
    }

    public fun pool_balance(arg0: &RewardPool) : u64 {
        0x2::balance::value<0x2::sui::SUI>(&arg0.balance)
    }

    // decompiled from Move bytecode v7
}

