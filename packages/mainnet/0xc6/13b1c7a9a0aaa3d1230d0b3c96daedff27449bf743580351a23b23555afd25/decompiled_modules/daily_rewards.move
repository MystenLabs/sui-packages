module 0xc613b1c7a9a0aaa3d1230d0b3c96daedff27449bf743580351a23b23555afd25::daily_rewards {
    struct RewardsPool has key {
        id: 0x2::object::UID,
        pool: 0x2::balance::Balance<0x2::sui::SUI>,
        uses: u8,
        last_use_timestamp_ms: u64,
    }

    struct DepositCap has store, key {
        id: 0x2::object::UID,
    }

    struct EmergencyCap has store, key {
        id: 0x2::object::UID,
    }

    struct DistributionCap has store, key {
        id: 0x2::object::UID,
    }

    public fun deposit(arg0: DepositCap, arg1: &mut RewardsPool, arg2: 0x2::coin::Coin<0x2::sui::SUI>) {
        let DepositCap { id: v0 } = arg0;
        0x2::coin::put<0x2::sui::SUI>(&mut arg1.pool, arg2);
        0x2::object::delete(v0);
    }

    public fun distribute(arg0: &DistributionCap, arg1: &mut RewardsPool, arg2: vector<address>, arg3: &0x2::clock::Clock, arg4: &mut 0x2::tx_context::TxContext) {
        assert!(0x2::balance::value<0x2::sui::SUI>(&arg1.pool) >= 165000000000, 3);
        let v0 = vector[60000000000, 30000000000, 15000000000, 15000000000, 10000000000, 10000000000, 10000000000, 5000000000, 5000000000, 5000000000];
        assert!(0x1::vector::length<address>(&arg2) == 0x1::vector::length<u64>(&v0), 1);
        assert!(arg1.last_use_timestamp_ms + 72000000 <= 0x2::clock::timestamp_ms(arg3), 4);
        assert!(arg1.uses > 0, 5);
        let v1 = 0x2::vec_set::empty<address>();
        while (0x1::vector::length<address>(&arg2) > 0) {
            let v2 = 0x1::vector::pop_back<address>(&mut arg2);
            assert!(!0x2::vec_set::contains<address>(&v1, &v2), 2);
            let v3 = vector[60000000000, 30000000000, 15000000000, 15000000000, 10000000000, 10000000000, 10000000000, 5000000000, 5000000000, 5000000000];
            0x2::transfer::public_transfer<0x2::coin::Coin<0x2::sui::SUI>>(0x2::coin::take<0x2::sui::SUI>(&mut arg1.pool, *0x1::vector::borrow<u64>(&v3, 0x1::vector::length<address>(&arg2)), arg4), v2);
            0x2::vec_set::insert<address>(&mut v1, v2);
        };
        arg1.uses = arg1.uses - 1;
        arg1.last_use_timestamp_ms = 0x2::clock::timestamp_ms(arg3);
    }

    entry fun emergency_withdraw(arg0: EmergencyCap, arg1: &mut RewardsPool, arg2: &mut 0x2::tx_context::TxContext) {
        let EmergencyCap { id: v0 } = arg0;
        0x2::transfer::public_transfer<0x2::coin::Coin<0x2::sui::SUI>>(0x2::coin::take<0x2::sui::SUI>(&mut arg1.pool, 0x2::balance::value<0x2::sui::SUI>(&arg1.pool), arg2), 0x2::tx_context::sender(arg2));
        0x2::object::delete(v0);
    }

    fun init(arg0: &mut 0x2::tx_context::TxContext) {
        let v0 = vector[60000000000, 30000000000, 15000000000, 15000000000, 10000000000, 10000000000, 10000000000, 5000000000, 5000000000, 5000000000];
        assert!(0x1::vector::length<u64>(&v0) == 10, 0);
        let v1 = RewardsPool{
            id                    : 0x2::object::new(arg0),
            pool                  : 0x2::balance::zero<0x2::sui::SUI>(),
            uses                  : 30,
            last_use_timestamp_ms : 0,
        };
        0x2::transfer::share_object<RewardsPool>(v1);
        let v2 = DepositCap{id: 0x2::object::new(arg0)};
        0x2::transfer::transfer<DepositCap>(v2, 0x2::tx_context::sender(arg0));
        let v3 = EmergencyCap{id: 0x2::object::new(arg0)};
        0x2::transfer::transfer<EmergencyCap>(v3, 0x2::tx_context::sender(arg0));
        let v4 = DistributionCap{id: 0x2::object::new(arg0)};
        0x2::transfer::transfer<DistributionCap>(v4, 0x2::tx_context::sender(arg0));
    }

    // decompiled from Move bytecode v6
}

