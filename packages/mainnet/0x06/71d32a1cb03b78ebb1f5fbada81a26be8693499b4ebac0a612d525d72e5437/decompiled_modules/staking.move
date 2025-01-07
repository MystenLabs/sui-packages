module 0xecf4b7276f06eb8818003db110c99726af321d9b1782d4cf25d71023bdfb3edf::staking {
    struct CreateStakePoolEvent has copy, drop {
        staking_pool_id: 0x2::object::ID,
    }

    struct CreateStakeLockEvent has copy, drop {
        staking_lock_id: 0x2::object::ID,
        amount: u64,
        lock_time: u64,
        staking_start_timestamp: u64,
    }

    struct ExtendStakeLockEvent has copy, drop {
        staking_lock_id: 0x2::object::ID,
        amount: u64,
        lock_time: u64,
        staking_start_timestamp: u64,
    }

    struct WithdrawStakeEvent has copy, drop {
        staking_lock_id: 0x2::object::ID,
        amount: u64,
    }

    struct StakingPool<phantom T0> has store, key {
        id: 0x2::object::UID,
        stake_balance: 0x2::balance::Balance<T0>,
        stakers: 0x2::bag::Bag,
        total_vesomis: u64,
        total_reward: u64,
        unstake_times_for_fluxtime: u64,
    }

    struct StakingLock has store, key {
        id: 0x2::object::UID,
        amount: u64,
        weeks: u64,
        staking_start_timestamp: u64,
        lock_time: u64,
        multiplier: u64,
        vesomis: u64,
        last_distribution_timestamp: u64,
    }

    struct AdminCap has key {
        id: 0x2::object::UID,
    }

    public entry fun change_plan<T0>(arg0: &mut StakingPool<T0>, arg1: &mut 0xecf4b7276f06eb8818003db110c99726af321d9b1782d4cf25d71023bdfb3edf::vesomis::Supply, arg2: 0xecf4b7276f06eb8818003db110c99726af321d9b1782d4cf25d71023bdfb3edf::vesomis::VeSomis, arg3: u64, arg4: 0x2::coin::Coin<T0>, arg5: &0x2::clock::Clock, arg6: &mut 0x2::tx_context::TxContext) {
        assert!(arg3 <= 104, 1001);
        assert!(0x2::bag::contains<address>(&arg0.stakers, 0x2::tx_context::sender(arg6)), 1004);
        let v0 = 0x2::bag::remove<address, StakingLock>(&mut arg0.stakers, 0x2::tx_context::sender(arg6));
        assert!(v0.weeks <= arg3, 1001);
        0x2::transfer::public_transfer<0x2::coin::Coin<T0>>(0x2::coin::take<T0>(&mut arg0.stake_balance, ((((v0.amount * v0.multiplier / 10000) as u256) * ((0x2::clock::timestamp_ms(arg5) - v0.last_distribution_timestamp) as u256) / (31536000000 as u256)) as u64), arg6), 0x2::tx_context::sender(arg6));
        let v1 = 0x2::coin::into_balance<T0>(arg4);
        0x2::balance::join<T0>(&mut arg0.stake_balance, v1);
        v0.amount = v0.amount + 0x2::balance::value<T0>(&v1);
        let (v2, v3) = weeks((v0.amount as u256), arg3);
        0xecf4b7276f06eb8818003db110c99726af321d9b1782d4cf25d71023bdfb3edf::vesomis::join(&mut arg2, 0xecf4b7276f06eb8818003db110c99726af321d9b1782d4cf25d71023bdfb3edf::vesomis::mint(arg1, v3 - v0.vesomis, arg6));
        0xecf4b7276f06eb8818003db110c99726af321d9b1782d4cf25d71023bdfb3edf::vesomis::transfer(arg2, arg6);
        v0.multiplier = v2;
        v0.vesomis = v3;
        v0.weeks = arg3;
        v0.last_distribution_timestamp = 0x2::clock::timestamp_ms(arg5);
        v0.lock_time = arg3 * 604800000;
        0x2::bag::add<address, StakingLock>(&mut arg0.stakers, 0x2::tx_context::sender(arg6), v0);
    }

    public entry fun change_stake<T0>(arg0: &AdminCap, arg1: &mut StakingPool<T0>, arg2: u64, arg3: &mut 0x2::tx_context::TxContext) {
        arg1.unstake_times_for_fluxtime = arg2;
    }

    public entry fun create_stake<T0>(arg0: &AdminCap, arg1: 0x2::coin::Coin<T0>, arg2: u64, arg3: &mut 0x2::tx_context::TxContext) {
        let v0 = StakingPool<T0>{
            id                         : 0x2::object::new(arg3),
            stake_balance              : 0x2::coin::into_balance<T0>(arg1),
            stakers                    : 0x2::bag::new(arg3),
            total_vesomis              : 0,
            total_reward               : 0,
            unstake_times_for_fluxtime : arg2,
        };
        let v1 = CreateStakePoolEvent{staking_pool_id: 0x2::object::uid_to_inner(&v0.id)};
        0x2::event::emit<CreateStakePoolEvent>(v1);
        0x2::transfer::public_share_object<StakingPool<T0>>(v0);
    }

    public entry fun deposit_stake<T0>(arg0: &AdminCap, arg1: &mut StakingPool<T0>, arg2: 0x2::coin::Coin<T0>, arg3: &mut 0x2::tx_context::TxContext) {
        0x2::balance::join<T0>(&mut arg1.stake_balance, 0x2::coin::into_balance<T0>(arg2));
    }

    public fun get_stake_lock<T0>(arg0: &StakingPool<T0>, arg1: address) : &StakingLock {
        assert!(0x2::bag::contains<address>(&arg0.stakers, arg1), 1004);
        0x2::bag::borrow<address, StakingLock>(&arg0.stakers, arg1)
    }

    public fun get_staking_projected_balance<T0>(arg0: &StakingPool<T0>, arg1: address, arg2: &0x2::clock::Clock) : u64 {
        assert!(0x2::bag::contains<address>(&arg0.stakers, arg1), 1004);
        let v0 = 0x2::bag::borrow<address, StakingLock>(&arg0.stakers, arg1);
        let v1 = 0x2::clock::timestamp_ms(arg2);
        if (v0.lock_time == 0) {
            0
        } else {
            let v3 = if (v0.staking_start_timestamp + v0.lock_time > v1) {
                v1 - v0.staking_start_timestamp
            } else {
                v0.lock_time
            };
            v0.vesomis * (v0.lock_time - v3) / v0.lock_time
        }
    }

    fun init(arg0: &mut 0x2::tx_context::TxContext) {
        let v0 = AdminCap{id: 0x2::object::new(arg0)};
        0x2::transfer::transfer<AdminCap>(v0, 0x2::tx_context::sender(arg0));
    }

    public entry fun stake<T0>(arg0: &mut StakingPool<T0>, arg1: &mut 0xecf4b7276f06eb8818003db110c99726af321d9b1782d4cf25d71023bdfb3edf::vesomis::Supply, arg2: u64, arg3: 0x2::coin::Coin<T0>, arg4: &0x2::clock::Clock, arg5: &mut 0x2::tx_context::TxContext) {
        assert!(arg2 <= 104, 1001);
        let v0 = 0x2::coin::into_balance<T0>(arg3);
        let v1 = 0x2::balance::value<T0>(&v0);
        let (v2, v3) = weeks((v1 as u256), arg2);
        let v4 = StakingLock{
            id                          : 0x2::object::new(arg5),
            amount                      : v1,
            weeks                       : arg2,
            staking_start_timestamp     : 0x2::clock::timestamp_ms(arg4),
            lock_time                   : arg2 * 604800000,
            multiplier                  : v2,
            vesomis                     : v3,
            last_distribution_timestamp : 0x2::clock::timestamp_ms(arg4),
        };
        0x2::balance::join<T0>(&mut arg0.stake_balance, v0);
        let v5 = CreateStakeLockEvent{
            staking_lock_id         : 0x2::object::uid_to_inner(&v4.id),
            amount                  : v4.amount,
            lock_time               : v4.lock_time,
            staking_start_timestamp : v4.staking_start_timestamp,
        };
        0x2::event::emit<CreateStakeLockEvent>(v5);
        0xecf4b7276f06eb8818003db110c99726af321d9b1782d4cf25d71023bdfb3edf::vesomis::transfer(0xecf4b7276f06eb8818003db110c99726af321d9b1782d4cf25d71023bdfb3edf::vesomis::mint(arg1, v3, arg5), arg5);
        0x2::bag::add<address, StakingLock>(&mut arg0.stakers, 0x2::tx_context::sender(arg5), v4);
    }

    public entry fun unstake<T0>(arg0: &mut StakingPool<T0>, arg1: &mut 0xecf4b7276f06eb8818003db110c99726af321d9b1782d4cf25d71023bdfb3edf::vesomis::Supply, arg2: 0xecf4b7276f06eb8818003db110c99726af321d9b1782d4cf25d71023bdfb3edf::vesomis::VeSomis, arg3: &0x2::clock::Clock, arg4: &mut 0x2::tx_context::TxContext) {
        let v0 = 0x2::bag::remove<address, StakingLock>(&mut arg0.stakers, 0x2::tx_context::sender(arg4));
        let v1 = if (v0.weeks == 0) {
            assert!(v0.staking_start_timestamp + v0.lock_time <= 0x2::clock::timestamp_ms(arg3), 1002);
            0x2::clock::timestamp_ms(arg3)
        } else {
            let v2 = v0.staking_start_timestamp + v0.lock_time;
            assert!(v2 <= 0x2::clock::timestamp_ms(arg3), 1002);
            v2
        };
        let v3 = v0.amount;
        let v4 = 0x2::coin::take<T0>(&mut arg0.stake_balance, v0.amount, arg4);
        0x2::coin::join<T0>(&mut v4, 0x2::coin::take<T0>(&mut arg0.stake_balance, ((((v3 * v0.multiplier / 10000) as u256) * ((v1 - v0.last_distribution_timestamp) as u256) / (31536000000 as u256)) as u64), arg4));
        0x2::transfer::public_transfer<0x2::coin::Coin<T0>>(v4, 0x2::tx_context::sender(arg4));
        assert!(0xecf4b7276f06eb8818003db110c99726af321d9b1782d4cf25d71023bdfb3edf::vesomis::amount(&arg2) >= v0.vesomis, 1003);
        0xecf4b7276f06eb8818003db110c99726af321d9b1782d4cf25d71023bdfb3edf::vesomis::burn(arg1, arg2, arg4);
        let v5 = WithdrawStakeEvent{
            staking_lock_id : 0x2::object::uid_to_inner(&v0.id),
            amount          : v3,
        };
        0x2::event::emit<WithdrawStakeEvent>(v5);
        let StakingLock {
            id                          : v6,
            amount                      : _,
            weeks                       : _,
            staking_start_timestamp     : _,
            lock_time                   : _,
            multiplier                  : _,
            vesomis                     : _,
            last_distribution_timestamp : _,
        } = v0;
        0x2::object::delete(v6);
    }

    public fun weeks(arg0: u256, arg1: u64) : (u64, u64) {
        let (v0, v1) = if (arg1 == 0) {
            (100 * 1, arg0 * 40 * 10000)
        } else if (arg1 == 1) {
            (143 * 1, arg0 * 70 * 10000)
        } else if (arg1 == 2) {
            (182 * 1, arg0 * 80 * 10000)
        } else if (arg1 == 3) {
            (222 * 1, arg0 * 100 * 10000)
        } else if (arg1 == 4) {
            (261 * 1, arg0 * 120 * 10000)
        } else if (arg1 == 5) {
            (301 * 1, arg0 * 140 * 10000)
        } else if (arg1 == 6) {
            (340 * 1, arg0 * 160 * 10000)
        } else if (arg1 == 7) {
            (380 * 1, arg0 * 180 * 10000)
        } else if (arg1 == 8) {
            (419 * 1, arg0 * 190 * 10000)
        } else if (arg1 == 9) {
            (459 * 1, arg0 * 210 * 10000)
        } else if (arg1 == 10) {
            (499 * 1, arg0 * 230 * 10000)
        } else if (arg1 == 11) {
            (538 * 1, arg0 * 250 * 10000)
        } else if (arg1 == 12) {
            (578 * 1, arg0 * 270 * 10000)
        } else if (arg1 == 13) {
            (617 * 1, arg0 * 290 * 10000)
        } else if (arg1 == 14) {
            (657 * 1, arg0 * 300 * 10000)
        } else if (arg1 == 15) {
            (696 * 1, arg0 * 320 * 10000)
        } else if (arg1 == 16) {
            (736 * 1, arg0 * 340 * 10000)
        } else if (arg1 == 17) {
            (775 * 1, arg0 * 360 * 10000)
        } else if (arg1 == 18) {
            (815 * 1, arg0 * 380 * 10000)
        } else if (arg1 == 19) {
            (854 * 1, arg0 * 400 * 10000)
        } else if (arg1 == 20) {
            (894 * 1, arg0 * 410 * 10000)
        } else if (arg1 == 21) {
            (933 * 1, arg0 * 430 * 10000)
        } else if (arg1 == 22) {
            (973 * 1, arg0 * 450 * 10000)
        } else if (arg1 == 23) {
            (1013 * 1, arg0 * 470 * 10000)
        } else if (arg1 == 24) {
            (1052 * 1, arg0 * 490 * 10000)
        } else if (arg1 == 25) {
            (1092 * 1, arg0 * 510 * 10000)
        } else if (arg1 == 26) {
            (1131 * 1, arg0 * 520 * 10000)
        } else if (arg1 == 27) {
            (1171 * 1, arg0 * 540 * 10000)
        } else if (arg1 == 28) {
            (1201 * 1, arg0 * 560 * 10000)
        } else if (arg1 == 29) {
            (1250 * 1, arg0 * 580 * 10000)
        } else if (arg1 == 30) {
            (1289 * 1, arg0 * 600 * 10000)
        } else if (arg1 == 31) {
            (1329 * 1, arg0 * 610 * 10000)
        } else if (arg1 == 32) {
            (1368 * 1, arg0 * 630 * 10000)
        } else if (arg1 == 33) {
            (1408 * 1, arg0 * 650 * 10000)
        } else if (arg1 == 34) {
            (1448 * 1, arg0 * 670 * 10000)
        } else if (arg1 == 35) {
            (1487 * 1, arg0 * 690 * 10000)
        } else if (arg1 == 36) {
            (1527 * 1, arg0 * 710 * 10000)
        } else if (arg1 == 37) {
            (1566 * 1, arg0 * 730 * 10000)
        } else if (arg1 == 38) {
            (1606 * 1, arg0 * 740 * 10000)
        } else if (arg1 == 39) {
            (1645 * 1, arg0 * 760 * 10000)
        } else if (arg1 == 40) {
            (1685 * 1, arg0 * 780 * 10000)
        } else if (arg1 == 41) {
            (1724 * 1, arg0 * 800 * 10000)
        } else if (arg1 == 42) {
            (1764 * 1, arg0 * 820 * 10000)
        } else if (arg1 == 43) {
            (1803 * 1, arg0 * 840 * 10000)
        } else if (arg1 == 44) {
            (1843 * 1, arg0 * 850 * 10000)
        } else if (arg1 == 45) {
            (1883 * 1, arg0 * 870 * 10000)
        } else if (arg1 == 46) {
            (1922 * 1, arg0 * 890 * 10000)
        } else if (arg1 == 47) {
            (1962 * 1, arg0 * 910 * 10000)
        } else if (arg1 == 48) {
            (2001 * 1, arg0 * 930 * 10000)
        } else if (arg1 == 49) {
            (2041 * 1, arg0 * 950 * 10000)
        } else if (arg1 == 50) {
            (2080 * 1, arg0 * 960 * 10000)
        } else if (arg1 == 51) {
            (2102 * 1, arg0 * 980 * 10000)
        } else if (arg1 == 52) {
            (2159 * 1, arg0 * 1000 * 10000)
        } else if (arg1 == 53) {
            (2173 * 1, arg0 * 1000 * 10000)
        } else {
            let (v2, v3) = if (arg1 == 54) {
                (arg0 * 1000 * 10000, 2187 * 1)
            } else {
                let (v4, v5) = if (arg1 == 55) {
                    (2201 * 1, arg0 * 1000 * 10000)
                } else if (arg1 == 56) {
                    (2215 * 1, arg0 * 1000 * 10000)
                } else if (arg1 == 57) {
                    (2229 * 1, arg0 * 1000 * 10000)
                } else if (arg1 == 58) {
                    (2243 * 1, arg0 * 1000 * 10000)
                } else if (arg1 == 59) {
                    (2257 * 1, arg0 * 1000 * 10000)
                } else if (arg1 == 60) {
                    (2271 * 1, arg0 * 1000 * 10000)
                } else if (arg1 == 61) {
                    (2285 * 1, arg0 * 1000 * 10000)
                } else if (arg1 == 62) {
                    (2299 * 1, arg0 * 1000 * 10000)
                } else if (arg1 == 63) {
                    (2313 * 1, arg0 * 1000 * 10000)
                } else if (arg1 == 64) {
                    (2327 * 1, arg0 * 1000 * 10000)
                } else if (arg1 == 65) {
                    (2340 * 1, arg0 * 1000 * 10000)
                } else if (arg1 == 66) {
                    (2354 * 1, arg0 * 1000 * 10000)
                } else if (arg1 == 67) {
                    (2368 * 1, arg0 * 1000 * 10000)
                } else if (arg1 == 68) {
                    (2382 * 1, arg0 * 1000 * 10000)
                } else if (arg1 == 69) {
                    (2396 * 1, arg0 * 1000 * 10000)
                } else if (arg1 == 70) {
                    (2410 * 1, arg0 * 1000 * 10000)
                } else if (arg1 == 71) {
                    (2424 * 1, arg0 * 1000 * 10000)
                } else if (arg1 == 72) {
                    (2438 * 1, arg0 * 1000 * 10000)
                } else if (arg1 == 73) {
                    (2452 * 1, arg0 * 1000 * 10000)
                } else if (arg1 == 74) {
                    (2466 * 1, arg0 * 1000 * 10000)
                } else if (arg1 == 75) {
                    (2480 * 1, arg0 * 1000 * 10000)
                } else if (arg1 == 76) {
                    (2494 * 1, arg0 * 1000 * 10000)
                } else if (arg1 == 77) {
                    (2508 * 1, arg0 * 1000 * 10000)
                } else if (arg1 == 78) {
                    (2522 * 1, arg0 * 1000 * 10000)
                } else if (arg1 == 79) {
                    (2536 * 1, arg0 * 1000 * 10000)
                } else if (arg1 == 80) {
                    (2550 * 1, arg0 * 1000 * 10000)
                } else if (arg1 == 81) {
                    (2564 * 1, arg0 * 1000 * 10000)
                } else if (arg1 == 82) {
                    (2578 * 1, arg0 * 1000 * 10000)
                } else if (arg1 == 83) {
                    (2592 * 1, arg0 * 1000 * 10000)
                } else if (arg1 == 84) {
                    (2606 * 1, arg0 * 1000 * 10000)
                } else if (arg1 == 85) {
                    (2620 * 1, arg0 * 1000 * 10000)
                } else if (arg1 == 86) {
                    (2634 * 1, arg0 * 1000 * 10000)
                } else if (arg1 == 87) {
                    (2648 * 1, arg0 * 1000 * 10000)
                } else if (arg1 == 88) {
                    (2662 * 1, arg0 * 1000 * 10000)
                } else if (arg1 == 89) {
                    (2676 * 1, arg0 * 1000 * 10000)
                } else if (arg1 == 90) {
                    (2690 * 1, arg0 * 1000 * 10000)
                } else if (arg1 == 91) {
                    (2703 * 1, arg0 * 1000 * 10000)
                } else if (arg1 == 92) {
                    (2717 * 1, arg0 * 1000 * 10000)
                } else if (arg1 == 93) {
                    (2731 * 1, arg0 * 1000 * 10000)
                } else if (arg1 == 94) {
                    (2745 * 1, arg0 * 1000 * 10000)
                } else if (arg1 == 95) {
                    (2759 * 1, arg0 * 1000 * 10000)
                } else if (arg1 == 96) {
                    (2773 * 1, arg0 * 1000 * 10000)
                } else if (arg1 == 97) {
                    (2787 * 1, arg0 * 1000 * 10000)
                } else if (arg1 == 98) {
                    (2801 * 1, arg0 * 1000 * 10000)
                } else {
                    let (v6, v7) = if (arg1 == 99) {
                        (arg0 * 1000 * 10000, 2815 * 1)
                    } else {
                        let (v8, v9) = if (arg1 == 100) {
                            (2829 * 1, arg0 * 1000 * 10000)
                        } else if (arg1 == 101) {
                            (2843 * 1, arg0 * 1000 * 10000)
                        } else if (arg1 == 102) {
                            (2857 * 1, arg0 * 1000 * 10000)
                        } else if (arg1 == 103) {
                            (2871 * 1, arg0 * 1000 * 10000)
                        } else {
                            (2885 * 1, arg0 * 1000 * 10000)
                        };
                        (v9, v8)
                    };
                    (v7, v6)
                };
                (v5, v4)
            };
            (v3, v2)
        };
        (v0, ((v1 / 1000 / 10000) as u64))
    }

    public entry fun withdraw_stake<T0>(arg0: &AdminCap, arg1: &mut StakingPool<T0>, arg2: &mut 0x2::tx_context::TxContext) {
        0x2::transfer::public_transfer<0x2::coin::Coin<T0>>(0x2::coin::from_balance<T0>(0x2::balance::withdraw_all<T0>(&mut arg1.stake_balance), arg2), 0x2::tx_context::sender(arg2));
    }

    // decompiled from Move bytecode v6
}

