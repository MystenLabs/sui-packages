module 0x41efa3f778f47ad4938643e7f45a8cb0d78d4338ecd2c872e054d98b9a87af67::rewards_distributor {
    struct REWARDS_DISTRIBUTOR has drop {
        dummy_field: bool,
    }

    struct RewardsDistributor has key {
        id: 0x2::object::UID,
        version: u8,
        start_time: u64,
        last_token_time: u64,
        rewards: 0x2::balance::Balance<0x41efa3f778f47ad4938643e7f45a8cb0d78d4338ecd2c872e054d98b9a87af67::tyde_shift::TYDE_SHIFT>,
        time_cursor_of: 0x2::table::Table<0x2::object::ID, u64>,
        tokens_per_week: 0x2::table::Table<u64, u64>,
    }

    struct AdminCap has key {
        id: 0x2::object::UID,
    }

    public fun claim(arg0: &mut RewardsDistributor, arg1: &mut 0x41efa3f778f47ad4938643e7f45a8cb0d78d4338ecd2c872e054d98b9a87af67::voting_escrow::VotingEscrow, arg2: &mut 0x41efa3f778f47ad4938643e7f45a8cb0d78d4338ecd2c872e054d98b9a87af67::voting_escrow_manager::VotingEscrowManager, arg3: &0x41efa3f778f47ad4938643e7f45a8cb0d78d4338ecd2c872e054d98b9a87af67::minter::Minter, arg4: &0x2::clock::Clock, arg5: &mut 0x2::tx_context::TxContext) : 0x2::coin::Coin<0x41efa3f778f47ad4938643e7f45a8cb0d78d4338ecd2c872e054d98b9a87af67::tyde_shift::TYDE_SHIFT> {
        claim_internal(arg0, arg1, arg2, arg3, arg4, arg5)
    }

    fun claim_(arg0: &mut RewardsDistributor, arg1: &0x41efa3f778f47ad4938643e7f45a8cb0d78d4338ecd2c872e054d98b9a87af67::voting_escrow::VotingEscrow, arg2: &0x41efa3f778f47ad4938643e7f45a8cb0d78d4338ecd2c872e054d98b9a87af67::voting_escrow_manager::VotingEscrowManager, arg3: u64) : 0x2::balance::Balance<0x41efa3f778f47ad4938643e7f45a8cb0d78d4338ecd2c872e054d98b9a87af67::tyde_shift::TYDE_SHIFT> {
        assert!(arg0.version == 1, 0);
        if (!0x2::table::contains<0x2::object::ID, u64>(&arg0.time_cursor_of, 0x41efa3f778f47ad4938643e7f45a8cb0d78d4338ecd2c872e054d98b9a87af67::voting_escrow::id(arg1))) {
            0x2::table::add<0x2::object::ID, u64>(&mut arg0.time_cursor_of, 0x41efa3f778f47ad4938643e7f45a8cb0d78d4338ecd2c872e054d98b9a87af67::voting_escrow::id(arg1), 0);
        };
        let (v0, _, v2) = claimable_(arg0, arg1, arg2, arg3);
        *0x2::table::borrow_mut<0x2::object::ID, u64>(&mut arg0.time_cursor_of, 0x41efa3f778f47ad4938643e7f45a8cb0d78d4338ecd2c872e054d98b9a87af67::voting_escrow::id(arg1)) = v2;
        0x2::balance::split<0x41efa3f778f47ad4938643e7f45a8cb0d78d4338ecd2c872e054d98b9a87af67::tyde_shift::TYDE_SHIFT>(&mut arg0.rewards, v0)
    }

    fun claim_internal(arg0: &mut RewardsDistributor, arg1: &mut 0x41efa3f778f47ad4938643e7f45a8cb0d78d4338ecd2c872e054d98b9a87af67::voting_escrow::VotingEscrow, arg2: &mut 0x41efa3f778f47ad4938643e7f45a8cb0d78d4338ecd2c872e054d98b9a87af67::voting_escrow_manager::VotingEscrowManager, arg3: &0x41efa3f778f47ad4938643e7f45a8cb0d78d4338ecd2c872e054d98b9a87af67::minter::Minter, arg4: &0x2::clock::Clock, arg5: &mut 0x2::tx_context::TxContext) : 0x2::coin::Coin<0x41efa3f778f47ad4938643e7f45a8cb0d78d4338ecd2c872e054d98b9a87af67::tyde_shift::TYDE_SHIFT> {
        assert!(arg0.version == 1, 0);
        let v0 = 0x2::clock::timestamp_ms(arg4);
        if (0x41efa3f778f47ad4938643e7f45a8cb0d78d4338ecd2c872e054d98b9a87af67::minter::active_period(arg3) < v0 / 0x41efa3f778f47ad4938643e7f45a8cb0d78d4338ecd2c872e054d98b9a87af67::consts::WEEK() * 0x41efa3f778f47ad4938643e7f45a8cb0d78d4338ecd2c872e054d98b9a87af67::consts::WEEK()) {
            abort 11
        };
        let v1 = arg0.last_token_time / 0x41efa3f778f47ad4938643e7f45a8cb0d78d4338ecd2c872e054d98b9a87af67::consts::WEEK() * 0x41efa3f778f47ad4938643e7f45a8cb0d78d4338ecd2c872e054d98b9a87af67::consts::WEEK();
        let v2 = 0x2::coin::from_balance<0x41efa3f778f47ad4938643e7f45a8cb0d78d4338ecd2c872e054d98b9a87af67::tyde_shift::TYDE_SHIFT>(claim_(arg0, arg1, arg2, v1), arg5);
        if (0x2::coin::value<0x41efa3f778f47ad4938643e7f45a8cb0d78d4338ecd2c872e054d98b9a87af67::tyde_shift::TYDE_SHIFT>(&v2) == 0) {
            return v2
        };
        let (_, v4) = 0x41efa3f778f47ad4938643e7f45a8cb0d78d4338ecd2c872e054d98b9a87af67::voting_escrow::locked(arg1);
        if (v0 >= v4) {
            v2
        } else {
            0x41efa3f778f47ad4938643e7f45a8cb0d78d4338ecd2c872e054d98b9a87af67::voting_escrow_manager::increase_amount(arg2, arg1, v2, arg4, arg5);
            0x2::coin::zero<0x41efa3f778f47ad4938643e7f45a8cb0d78d4338ecd2c872e054d98b9a87af67::tyde_shift::TYDE_SHIFT>(arg5)
        }
    }

    public fun claimable(arg0: &RewardsDistributor, arg1: &0x41efa3f778f47ad4938643e7f45a8cb0d78d4338ecd2c872e054d98b9a87af67::voting_escrow::VotingEscrow, arg2: &0x41efa3f778f47ad4938643e7f45a8cb0d78d4338ecd2c872e054d98b9a87af67::voting_escrow_manager::VotingEscrowManager) : u64 {
        claimable_internal(arg0, arg1, arg2)
    }

    fun claimable_(arg0: &RewardsDistributor, arg1: &0x41efa3f778f47ad4938643e7f45a8cb0d78d4338ecd2c872e054d98b9a87af67::voting_escrow::VotingEscrow, arg2: &0x41efa3f778f47ad4938643e7f45a8cb0d78d4338ecd2c872e054d98b9a87af67::voting_escrow_manager::VotingEscrowManager, arg3: u64) : (u64, u64, u64) {
        let v0 = arg0.start_time;
        let v1 = 0;
        let v2 = 0;
        if (0x2::table::contains<0x2::object::ID, u64>(&arg0.time_cursor_of, 0x41efa3f778f47ad4938643e7f45a8cb0d78d4338ecd2c872e054d98b9a87af67::voting_escrow::id(arg1))) {
            v2 = *0x2::table::borrow<0x2::object::ID, u64>(&arg0.time_cursor_of, 0x41efa3f778f47ad4938643e7f45a8cb0d78d4338ecd2c872e054d98b9a87af67::voting_escrow::id(arg1));
        };
        let v3 = v2;
        if (0x41efa3f778f47ad4938643e7f45a8cb0d78d4338ecd2c872e054d98b9a87af67::voting_escrow::point_epoch(arg1) == 0) {
            return (0, v2, v2)
        };
        if (v2 == 0) {
            let v4 = 0x41efa3f778f47ad4938643e7f45a8cb0d78d4338ecd2c872e054d98b9a87af67::voting_escrow::point(arg1, 1);
            let v5 = 0x41efa3f778f47ad4938643e7f45a8cb0d78d4338ecd2c872e054d98b9a87af67::point::ts(&v4) / 0x41efa3f778f47ad4938643e7f45a8cb0d78d4338ecd2c872e054d98b9a87af67::consts::WEEK() * 0x41efa3f778f47ad4938643e7f45a8cb0d78d4338ecd2c872e054d98b9a87af67::consts::WEEK();
            v2 = v5;
            v3 = v5;
        };
        if (v2 >= arg3) {
            return (0, v3, v2)
        };
        if (v2 < v0) {
            v2 = v0;
        };
        let v6 = 0;
        while (v6 < 50) {
            if (v2 >= arg3) {
                break
            };
            let v7 = if (0x2::table::contains<u64, u64>(&arg0.tokens_per_week, v2)) {
                *0x2::table::borrow<u64, u64>(&arg0.tokens_per_week, v2)
            } else {
                0
            };
            let v8 = 0x41efa3f778f47ad4938643e7f45a8cb0d78d4338ecd2c872e054d98b9a87af67::voting_escrow_manager::total_supply_at_t(arg2, v2 + 0x41efa3f778f47ad4938643e7f45a8cb0d78d4338ecd2c872e054d98b9a87af67::consts::WEEK() - 1000);
            let v9 = v8;
            if (v8 == 0) {
                v9 = 1;
            };
            v1 = v1 + 0x41efa3f778f47ad4938643e7f45a8cb0d78d4338ecd2c872e054d98b9a87af67::amm_math::safe_mul_div_u64(0x41efa3f778f47ad4938643e7f45a8cb0d78d4338ecd2c872e054d98b9a87af67::voting_escrow::balance_of_nft_at(arg1, v2 + 0x41efa3f778f47ad4938643e7f45a8cb0d78d4338ecd2c872e054d98b9a87af67::consts::WEEK() - 1000), v7, v9);
            v2 = v2 + 0x41efa3f778f47ad4938643e7f45a8cb0d78d4338ecd2c872e054d98b9a87af67::consts::WEEK();
            v6 = v6 + 1;
        };
        (v1, v3, v2)
    }

    fun claimable_internal(arg0: &RewardsDistributor, arg1: &0x41efa3f778f47ad4938643e7f45a8cb0d78d4338ecd2c872e054d98b9a87af67::voting_escrow::VotingEscrow, arg2: &0x41efa3f778f47ad4938643e7f45a8cb0d78d4338ecd2c872e054d98b9a87af67::voting_escrow_manager::VotingEscrowManager) : u64 {
        let (v0, _, _) = claimable_(arg0, arg1, arg2, arg0.last_token_time / 0x41efa3f778f47ad4938643e7f45a8cb0d78d4338ecd2c872e054d98b9a87af67::consts::WEEK() * 0x41efa3f778f47ad4938643e7f45a8cb0d78d4338ecd2c872e054d98b9a87af67::consts::WEEK());
        v0
    }

    public fun deposit_rewards(arg0: &mut RewardsDistributor, arg1: 0x2::coin::Coin<0x41efa3f778f47ad4938643e7f45a8cb0d78d4338ecd2c872e054d98b9a87af67::tyde_shift::TYDE_SHIFT>, arg2: &0x2::clock::Clock) {
        deposit_rewards_(arg0, arg1, arg2);
    }

    fun deposit_rewards_(arg0: &mut RewardsDistributor, arg1: 0x2::coin::Coin<0x41efa3f778f47ad4938643e7f45a8cb0d78d4338ecd2c872e054d98b9a87af67::tyde_shift::TYDE_SHIFT>, arg2: &0x2::clock::Clock) {
        assert!(arg0.version == 1, 0);
        let v0 = 0x2::coin::value<0x41efa3f778f47ad4938643e7f45a8cb0d78d4338ecd2c872e054d98b9a87af67::tyde_shift::TYDE_SHIFT>(&arg1);
        0x2::balance::join<0x41efa3f778f47ad4938643e7f45a8cb0d78d4338ecd2c872e054d98b9a87af67::tyde_shift::TYDE_SHIFT>(&mut arg0.rewards, 0x2::coin::into_balance<0x41efa3f778f47ad4938643e7f45a8cb0d78d4338ecd2c872e054d98b9a87af67::tyde_shift::TYDE_SHIFT>(arg1));
        let v1 = 0x2::clock::timestamp_ms(arg2);
        let v2 = arg0.last_token_time;
        let v3 = v1 - v2;
        arg0.last_token_time = v1;
        let v4 = v2 / 0x41efa3f778f47ad4938643e7f45a8cb0d78d4338ecd2c872e054d98b9a87af67::consts::WEEK() * 0x41efa3f778f47ad4938643e7f45a8cb0d78d4338ecd2c872e054d98b9a87af67::consts::WEEK();
        let v5 = 0;
        while (v5 < 20) {
            if (!0x2::table::contains<u64, u64>(&arg0.tokens_per_week, v4)) {
                0x2::table::add<u64, u64>(&mut arg0.tokens_per_week, v4, 0);
            };
            let v6 = *0x2::table::borrow<u64, u64>(&arg0.tokens_per_week, v4);
            v4 = v4 + 0x41efa3f778f47ad4938643e7f45a8cb0d78d4338ecd2c872e054d98b9a87af67::consts::WEEK();
            if (v1 < v4) {
                if (v3 == 0 && v1 == v2) {
                    *0x2::table::borrow_mut<u64, u64>(&mut arg0.tokens_per_week, v4) = v6 + v0;
                    break
                } else {
                    *0x2::table::borrow_mut<u64, u64>(&mut arg0.tokens_per_week, v4) = v6 + 0x41efa3f778f47ad4938643e7f45a8cb0d78d4338ecd2c872e054d98b9a87af67::amm_math::safe_mul_div_u64(v0, v1 - v2, v3);
                    break
                };
            };
            if (v3 == 0 && v4 == v2) {
                *0x2::table::borrow_mut<u64, u64>(&mut arg0.tokens_per_week, v4) = v6 + v0;
            } else {
                *0x2::table::borrow_mut<u64, u64>(&mut arg0.tokens_per_week, v4) = v6 + 0x41efa3f778f47ad4938643e7f45a8cb0d78d4338ecd2c872e054d98b9a87af67::amm_math::safe_mul_div_u64(v0, v4 - v2, v3);
            };
            v5 = v5 + 1;
        };
    }

    fun init(arg0: REWARDS_DISTRIBUTOR, arg1: &mut 0x2::tx_context::TxContext) {
        let v0 = 0x2::tx_context::epoch_timestamp_ms(arg1) / 0x41efa3f778f47ad4938643e7f45a8cb0d78d4338ecd2c872e054d98b9a87af67::consts::WEEK() * 0x41efa3f778f47ad4938643e7f45a8cb0d78d4338ecd2c872e054d98b9a87af67::consts::WEEK();
        let v1 = RewardsDistributor{
            id              : 0x2::object::new(arg1),
            version         : 1,
            start_time      : v0,
            last_token_time : v0,
            rewards         : 0x2::balance::zero<0x41efa3f778f47ad4938643e7f45a8cb0d78d4338ecd2c872e054d98b9a87af67::tyde_shift::TYDE_SHIFT>(),
            time_cursor_of  : 0x2::table::new<0x2::object::ID, u64>(arg1),
            tokens_per_week : 0x2::table::new<u64, u64>(arg1),
        };
        let v2 = AdminCap{id: 0x2::object::new(arg1)};
        0x2::transfer::share_object<RewardsDistributor>(v1);
        0x2::transfer::transfer<AdminCap>(v2, 0x2::tx_context::sender(arg1));
    }

    entry fun migrate(arg0: &mut RewardsDistributor, arg1: &AdminCap) {
        assert!(arg0.version < 1, 13906835196545597439);
        arg0.version = 1;
    }

    // decompiled from Move bytecode v6
}

