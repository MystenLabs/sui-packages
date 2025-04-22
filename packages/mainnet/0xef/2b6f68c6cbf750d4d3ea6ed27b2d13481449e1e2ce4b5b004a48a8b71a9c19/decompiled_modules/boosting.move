module 0xef2b6f68c6cbf750d4d3ea6ed27b2d13481449e1e2ce4b5b004a48a8b71a9c19::boosting {
    struct Treasury has key {
        id: 0x2::object::UID,
        suiCoinsTreasury: 0x2::balance::Balance<0x2::sui::SUI>,
        boostOf: 0x2::vec_map::VecMap<address, u64>,
        historyBoostOf: 0x2::vec_map::VecMap<address, u64>,
        status: bool,
        boostTime1: u64,
        boostTime2: u64,
        boostTime3: u64,
    }

    struct AdminCap has key {
        id: 0x2::object::UID,
    }

    struct DepositBoost has copy, drop {
        user: address,
        amount: u64,
    }

    struct AdminDeposit has copy, drop {
        user: address,
        amount: u64,
    }

    struct AdminSuiWithdrawn has copy, drop {
        user: address,
        amount: u64,
    }

    struct AdminUpdateBoosting has copy, drop {
        user: address,
        status: bool,
    }

    struct AdminUpdateBoostTime has copy, drop {
        user: address,
        boostTime: u64,
    }

    struct AdminUpdateClaimStatusBoosting has copy, drop {
        user: address,
        claimStatus: bool,
    }

    public entry fun admin_deposit(arg0: 0x2::coin::Coin<0x2::sui::SUI>, arg1: &mut Treasury, arg2: address, arg3: u64, arg4: &0x2::clock::Clock, arg5: &mut 0x2::tx_context::TxContext) {
        assert!(arg1.status == true, 13);
        let v0 = 0x2::coin::value<0x2::sui::SUI>(&arg0);
        let v1 = 0x2::clock::timestamp_ms(arg4);
        0x2::balance::join<0x2::sui::SUI>(&mut arg1.suiCoinsTreasury, 0x2::coin::into_balance<0x2::sui::SUI>(arg0));
        let v2 = if (arg3 == 1) {
            arg1.boostTime1
        } else if (arg3 == 2) {
            arg1.boostTime2
        } else {
            assert!(arg3 == 3, 14);
            arg1.boostTime3
        };
        if (!0x2::vec_map::contains<address, u64>(&arg1.boostOf, &arg2)) {
            0x2::vec_map::insert<address, u64>(&mut arg1.boostOf, arg2, v1 + v2);
            0x2::vec_map::insert<address, u64>(&mut arg1.historyBoostOf, arg2, v0);
        } else {
            let v3 = 0x2::vec_map::get_mut<address, u64>(&mut arg1.boostOf, &arg2);
            if (*v3 >= v1) {
                *v3 = *v3 + v2;
            } else {
                *v3 = v1 + v2;
            };
            let v4 = 0x2::vec_map::get_mut<address, u64>(&mut arg1.historyBoostOf, &arg2);
            *v4 = *v4 + v0;
        };
        let v5 = DepositBoost{
            user   : 0x2::tx_context::sender(arg5),
            amount : v0,
        };
        0x2::event::emit<DepositBoost>(v5);
    }

    public entry fun admin_withdraw(arg0: &mut Treasury, arg1: &mut 0x2::tx_context::TxContext) {
        let v0 = 0x2::balance::value<0x2::sui::SUI>(&arg0.suiCoinsTreasury);
        assert!(@0xa8125cc1a3c3d425a317d405b4089402cf0a9e20fb8a484a0f98973baec09c0b == 0x2::tx_context::sender(arg1), 11);
        0x2::transfer::public_transfer<0x2::coin::Coin<0x2::sui::SUI>>(0x2::coin::take<0x2::sui::SUI>(&mut arg0.suiCoinsTreasury, v0, arg1), 0x2::tx_context::sender(arg1));
        let v1 = AdminSuiWithdrawn{
            user   : 0x2::tx_context::sender(arg1),
            amount : v0,
        };
        0x2::event::emit<AdminSuiWithdrawn>(v1);
    }

    public entry fun deposit(arg0: 0x2::coin::Coin<0x2::sui::SUI>, arg1: &mut Treasury, arg2: address, arg3: u64, arg4: &0x2::clock::Clock, arg5: &mut 0x2::tx_context::TxContext) {
        assert!(arg1.status == true, 13);
        let v0 = 0x2::coin::value<0x2::sui::SUI>(&arg0);
        let v1 = 0x2::clock::timestamp_ms(arg4);
        if (arg3 == 1) {
            assert!(v0 == 100000000, 14);
        } else if (arg3 == 2) {
            assert!(v0 == 1000000000, 14);
        } else {
            assert!(arg3 == 3, 14);
            assert!(v0 == 1000000000, 14);
        };
        0x2::balance::join<0x2::sui::SUI>(&mut arg1.suiCoinsTreasury, 0x2::coin::into_balance<0x2::sui::SUI>(arg0));
        let v2 = if (arg3 == 1) {
            arg1.boostTime1
        } else if (arg3 == 2) {
            arg1.boostTime2
        } else {
            assert!(arg3 == 3, 14);
            arg1.boostTime3
        };
        if (!0x2::vec_map::contains<address, u64>(&arg1.boostOf, &arg2)) {
            0x2::vec_map::insert<address, u64>(&mut arg1.boostOf, arg2, v1 + v2);
            0x2::vec_map::insert<address, u64>(&mut arg1.historyBoostOf, arg2, v0);
        } else {
            let v3 = 0x2::vec_map::get_mut<address, u64>(&mut arg1.boostOf, &arg2);
            if (*v3 >= v1) {
                *v3 = *v3 + v2;
            } else {
                *v3 = v1 + v2;
            };
            let v4 = 0x2::vec_map::get_mut<address, u64>(&mut arg1.historyBoostOf, &arg2);
            *v4 = *v4 + v0;
        };
        let v5 = DepositBoost{
            user   : 0x2::tx_context::sender(arg5),
            amount : v0,
        };
        0x2::event::emit<DepositBoost>(v5);
    }

    fun init(arg0: &mut 0x2::tx_context::TxContext) {
        let v0 = AdminCap{id: 0x2::object::new(arg0)};
        0x2::transfer::transfer<AdminCap>(v0, 0x2::tx_context::sender(arg0));
    }

    public entry fun new_boosting(arg0: &mut 0x2::tx_context::TxContext) {
        let v0 = Treasury{
            id               : 0x2::object::new(arg0),
            suiCoinsTreasury : 0x2::balance::zero<0x2::sui::SUI>(),
            boostOf          : 0x2::vec_map::empty<address, u64>(),
            historyBoostOf   : 0x2::vec_map::empty<address, u64>(),
            status           : true,
            boostTime1       : 600000,
            boostTime2       : 3600000,
            boostTime3       : 86400000,
        };
        0x2::transfer::share_object<Treasury>(v0);
    }

    public entry fun update_active_boosting(arg0: &mut Treasury, arg1: bool, arg2: &mut 0x2::tx_context::TxContext) {
        assert!(@0xa8125cc1a3c3d425a317d405b4089402cf0a9e20fb8a484a0f98973baec09c0b == 0x2::tx_context::sender(arg2), 11);
        arg0.status = arg1;
        let v0 = AdminUpdateBoosting{
            user   : 0x2::tx_context::sender(arg2),
            status : arg1,
        };
        0x2::event::emit<AdminUpdateBoosting>(v0);
    }

    public entry fun update_boostTime(arg0: &mut Treasury, arg1: u64, arg2: u64, arg3: &mut 0x2::tx_context::TxContext) {
        assert!(0x2::tx_context::sender(arg3) == @0xa8125cc1a3c3d425a317d405b4089402cf0a9e20fb8a484a0f98973baec09c0b, 11);
        if (arg2 == 1) {
            arg0.boostTime1 = arg1;
        } else if (arg2 == 2) {
            arg0.boostTime2 = arg1;
        } else {
            assert!(arg2 == 3, 14);
            arg0.boostTime3 = arg1;
        };
        let v0 = AdminUpdateBoostTime{
            user      : 0x2::tx_context::sender(arg3),
            boostTime : arg1,
        };
        0x2::event::emit<AdminUpdateBoostTime>(v0);
    }

    // decompiled from Move bytecode v6
}

