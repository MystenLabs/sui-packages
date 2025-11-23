module 0x129a693d03ed0fd5d63bcf036fe2a34849813b86f7eb37d8a81032f9196e1e85::solver_registry {
    struct AdminCap has store, key {
        id: 0x2::object::UID,
    }

    struct SolverProfile has copy, drop, store {
        solver_address: address,
        stake_amount: u64,
        reputation_score: u64,
        total_batches_participated: u64,
        batches_won: u64,
        total_surplus_generated: u64,
        accuracy_score: u64,
        last_submission_epoch: u64,
        registration_timestamp: u64,
        status: u8,
        pending_withdrawal: 0x1::option::Option<u64>,
    }

    struct SolverRegistry has key {
        id: 0x2::object::UID,
        profiles: 0x2::table::Table<address, SolverProfile>,
        stakes: 0x2::table::Table<address, 0x2::balance::Balance<0x2::sui::SUI>>,
        min_stake: u64,
        slash_percentage: u8,
        withdrawal_cooldown: u64,
        reward_percentage: u8,
        total_solvers: u64,
        admin: address,
    }

    struct SolverRegistered has copy, drop {
        solver: address,
        stake: u64,
        timestamp: u64,
    }

    struct SolverSlashed has copy, drop {
        solver: address,
        slash_amount: u64,
        reason: vector<u8>,
        timestamp: u64,
    }

    struct WithdrawalInitiated has copy, drop {
        solver: address,
        amount: u64,
        available_at: u64,
    }

    struct WithdrawalCompleted has copy, drop {
        solver: address,
        amount: u64,
        timestamp: u64,
    }

    struct ReputationUpdated has copy, drop {
        solver: address,
        old_reputation: u64,
        new_reputation: u64,
        batch_id: vector<u8>,
    }

    struct BatchRewardDistributed has copy, drop {
        batch_id: vector<u8>,
        winner: address,
        surplus_amount: u64,
        reward_amount: u64,
    }

    fun calculate_reputation(arg0: &SolverProfile) : u64 {
        if (arg0.total_batches_participated == 0) {
            return 10000 / 2
        };
        let v0 = if (arg0.total_surplus_generated > 0) {
            log_approximation(arg0.total_surplus_generated) * 10000 * 30 / log_approximation(1000000000000) * 100
        } else {
            0
        };
        let v1 = arg0.batches_won * 100 / arg0.total_batches_participated * 10000 * 40 / 10000 + arg0.accuracy_score * 10000 * 30 / 10000 + v0;
        if (v1 > 10000) {
            10000
        } else {
            v1
        }
    }

    entry fun complete_withdrawal(arg0: &mut SolverRegistry, arg1: &0x129a693d03ed0fd5d63bcf036fe2a34849813b86f7eb37d8a81032f9196e1e85::slash_manager::SlashManager, arg2: u64, arg3: &0x2::clock::Clock, arg4: &mut 0x2::tx_context::TxContext) {
        let v0 = 0x2::tx_context::sender(arg4);
        let v1 = 0x2::clock::timestamp_ms(arg3);
        assert!(0x2::table::contains<address, SolverProfile>(&arg0.profiles, v0), 1002);
        let v2 = 0x2::table::borrow_mut<address, SolverProfile>(&mut arg0.profiles, v0);
        assert!(0x1::option::is_some<u64>(&v2.pending_withdrawal), 1012);
        assert!(v1 >= *0x1::option::borrow<u64>(&v2.pending_withdrawal), 1007);
        let v3 = 0x129a693d03ed0fd5d63bcf036fe2a34849813b86f7eb37d8a81032f9196e1e85::slash_manager::calculate_total_slash_percentage(arg1, v0);
        let v4 = if (v3 > 0) {
            arg2 - arg2 * v3 / 10000
        } else {
            arg2
        };
        v2.stake_amount = v2.stake_amount - arg2;
        v2.pending_withdrawal = 0x1::option::none<u64>();
        v2.status = 0;
        let v5 = 0x2::table::borrow_mut<address, 0x2::balance::Balance<0x2::sui::SUI>>(&mut arg0.stakes, v0);
        if (v3 > 0) {
            0x2::transfer::public_transfer<0x2::coin::Coin<0x2::sui::SUI>>(0x2::coin::from_balance<0x2::sui::SUI>(0x2::balance::split<0x2::sui::SUI>(v5, arg2 - v4), arg4), @0x0);
        };
        let v6 = WithdrawalCompleted{
            solver    : v0,
            amount    : v4,
            timestamp : v1,
        };
        0x2::event::emit<WithdrawalCompleted>(v6);
        0x2::transfer::public_transfer<0x2::coin::Coin<0x2::sui::SUI>>(0x2::coin::from_balance<0x2::sui::SUI>(0x2::balance::split<0x2::sui::SUI>(v5, v4), arg4), v0);
    }

    public(friend) fun distribute_batch_rewards(arg0: &SolverRegistry, arg1: vector<u8>, arg2: address, arg3: u64, arg4: 0x2::coin::Coin<0x2::sui::SUI>) {
        assert!(0x2::table::contains<address, SolverProfile>(&arg0.profiles, arg2), 1002);
        0x2::transfer::public_transfer<0x2::coin::Coin<0x2::sui::SUI>>(arg4, arg2);
        let v0 = BatchRewardDistributed{
            batch_id       : arg1,
            winner         : arg2,
            surplus_amount : arg3,
            reward_amount  : 0x2::coin::value<0x2::sui::SUI>(&arg4),
        };
        0x2::event::emit<BatchRewardDistributed>(v0);
    }

    public(friend) fun get_min_stake_amount() : u64 {
        1000000000
    }

    public fun get_registry_stats(arg0: &SolverRegistry) : (u64, u64, u64) {
        (arg0.total_solvers, arg0.min_stake, arg0.withdrawal_cooldown)
    }

    public(friend) fun get_slash_percentage() : u8 {
        20
    }

    public fun get_solver_profile(arg0: &SolverRegistry, arg1: address) : 0x1::option::Option<SolverProfile> {
        if (0x2::table::contains<address, SolverProfile>(&arg0.profiles, arg1)) {
            0x1::option::some<SolverProfile>(*0x2::table::borrow<address, SolverProfile>(&arg0.profiles, arg1))
        } else {
            0x1::option::none<SolverProfile>()
        }
    }

    public fun get_solver_reputation(arg0: &SolverRegistry, arg1: address) : u64 {
        if (0x2::table::contains<address, SolverProfile>(&arg0.profiles, arg1)) {
            0x2::table::borrow<address, SolverProfile>(&arg0.profiles, arg1).reputation_score
        } else {
            0
        }
    }

    public fun get_solver_stake(arg0: &SolverRegistry, arg1: address) : u64 {
        if (0x2::table::contains<address, SolverProfile>(&arg0.profiles, arg1)) {
            0x2::table::borrow<address, SolverProfile>(&arg0.profiles, arg1).stake_amount
        } else {
            0
        }
    }

    public(friend) fun get_withdrawal_cooldown_ms() : u64 {
        604800000
    }

    entry fun increase_stake(arg0: &mut SolverRegistry, arg1: 0x2::coin::Coin<0x2::sui::SUI>, arg2: &mut 0x2::tx_context::TxContext) {
        let v0 = 0x2::tx_context::sender(arg2);
        assert!(0x2::table::contains<address, SolverProfile>(&arg0.profiles, v0), 1002);
        let v1 = 0x2::table::borrow_mut<address, SolverProfile>(&mut arg0.profiles, v0);
        v1.stake_amount = v1.stake_amount + 0x2::coin::value<0x2::sui::SUI>(&arg1);
        0x2::balance::join<0x2::sui::SUI>(0x2::table::borrow_mut<address, 0x2::balance::Balance<0x2::sui::SUI>>(&mut arg0.stakes, v0), 0x2::coin::into_balance<0x2::sui::SUI>(arg1));
    }

    fun init(arg0: &mut 0x2::tx_context::TxContext) {
        let v0 = AdminCap{id: 0x2::object::new(arg0)};
        let v1 = SolverRegistry{
            id                  : 0x2::object::new(arg0),
            profiles            : 0x2::table::new<address, SolverProfile>(arg0),
            stakes              : 0x2::table::new<address, 0x2::balance::Balance<0x2::sui::SUI>>(arg0),
            min_stake           : 1000000000,
            slash_percentage    : 20,
            withdrawal_cooldown : 604800000,
            reward_percentage   : 10,
            total_solvers       : 0,
            admin               : 0x2::tx_context::sender(arg0),
        };
        0x2::transfer::transfer<AdminCap>(v0, 0x2::tx_context::sender(arg0));
        0x2::transfer::share_object<SolverRegistry>(v1);
    }

    entry fun initiate_withdrawal(arg0: &mut SolverRegistry, arg1: u64, arg2: &0x2::clock::Clock, arg3: &mut 0x2::tx_context::TxContext) {
        let v0 = 0x2::tx_context::sender(arg3);
        assert!(0x2::table::contains<address, SolverProfile>(&arg0.profiles, v0), 1002);
        let v1 = 0x2::table::borrow_mut<address, SolverProfile>(&mut arg0.profiles, v0);
        assert!(v1.stake_amount >= arg1, 1011);
        assert!(v1.stake_amount - arg1 >= arg0.min_stake, 1001);
        let v2 = 0x2::clock::timestamp_ms(arg2) + arg0.withdrawal_cooldown;
        v1.pending_withdrawal = 0x1::option::some<u64>(v2);
        v1.status = 3;
        let v3 = WithdrawalInitiated{
            solver       : v0,
            amount       : arg1,
            available_at : v2,
        };
        0x2::event::emit<WithdrawalInitiated>(v3);
    }

    public fun is_solver_active(arg0: &SolverRegistry, arg1: address) : bool {
        0x2::table::contains<address, SolverProfile>(&arg0.profiles, arg1) && 0x2::table::borrow<address, SolverProfile>(&arg0.profiles, arg1).status == 0
    }

    fun log_approximation(arg0: u64) : u64 {
        if (arg0 <= 1) {
            return 0
        };
        let v0 = 0;
        while (arg0 > 1) {
            arg0 = arg0 / 2;
            v0 = v0 + 1;
        };
        v0 * 100
    }

    public(friend) fun record_batch_participation(arg0: &mut SolverRegistry, arg1: address, arg2: vector<u8>, arg3: bool, arg4: u64, arg5: u64, arg6: u64, arg7: u64) {
        assert!(0x2::table::contains<address, SolverProfile>(&arg0.profiles, arg1), 1002);
        let v0 = 0x2::table::borrow_mut<address, SolverProfile>(&mut arg0.profiles, arg1);
        v0.total_batches_participated = v0.total_batches_participated + 1;
        v0.last_submission_epoch = arg7;
        if (arg3) {
            v0.batches_won = v0.batches_won + 1;
            v0.total_surplus_generated = v0.total_surplus_generated + arg4;
        };
        if (arg5 > 0) {
            let v1 = if (arg6 > arg5) {
                arg6 - arg5
            } else {
                arg5 - arg6
            };
            let v2 = if (v1 * 100 / arg5 > 100) {
                0
            } else {
                100 - v1 * 100 / arg5
            };
            v0.accuracy_score = (v0.accuracy_score * 9 + v2) / 10;
        };
        let v3 = calculate_reputation(v0);
        v0.reputation_score = v3;
        let v4 = ReputationUpdated{
            solver         : arg1,
            old_reputation : v0.reputation_score,
            new_reputation : v3,
            batch_id       : arg2,
        };
        0x2::event::emit<ReputationUpdated>(v4);
    }

    entry fun register_solver(arg0: &mut SolverRegistry, arg1: 0x2::coin::Coin<0x2::sui::SUI>, arg2: &0x2::clock::Clock, arg3: &mut 0x2::tx_context::TxContext) {
        let v0 = 0x2::tx_context::sender(arg3);
        let v1 = 0x2::coin::value<0x2::sui::SUI>(&arg1);
        let v2 = 0x2::clock::timestamp_ms(arg2);
        assert!(v1 >= arg0.min_stake, 1001);
        assert!(!0x2::table::contains<address, SolverProfile>(&arg0.profiles, v0), 1003);
        let v3 = SolverProfile{
            solver_address             : v0,
            stake_amount               : v1,
            reputation_score           : 10000 / 2,
            total_batches_participated : 0,
            batches_won                : 0,
            total_surplus_generated    : 0,
            accuracy_score             : 100,
            last_submission_epoch      : 0,
            registration_timestamp     : v2,
            status                     : 0,
            pending_withdrawal         : 0x1::option::none<u64>(),
        };
        0x2::table::add<address, SolverProfile>(&mut arg0.profiles, v0, v3);
        0x2::table::add<address, 0x2::balance::Balance<0x2::sui::SUI>>(&mut arg0.stakes, v0, 0x2::coin::into_balance<0x2::sui::SUI>(arg1));
        arg0.total_solvers = arg0.total_solvers + 1;
        let v4 = SolverRegistered{
            solver    : v0,
            stake     : v1,
            timestamp : v2,
        };
        0x2::event::emit<SolverRegistered>(v4);
    }

    public(friend) fun slash_solver(arg0: &AdminCap, arg1: &mut SolverRegistry, arg2: address, arg3: vector<u8>, arg4: &0x2::clock::Clock, arg5: &mut 0x2::tx_context::TxContext) {
        assert!(0x2::table::contains<address, SolverProfile>(&arg1.profiles, arg2), 1002);
        let v0 = 0x2::table::borrow_mut<address, SolverProfile>(&mut arg1.profiles, arg2);
        let v1 = v0.stake_amount * (arg1.slash_percentage as u64) / 100;
        v0.stake_amount = v0.stake_amount - v1;
        v0.status = 1;
        v0.reputation_score = v0.reputation_score / 2;
        0x2::transfer::public_transfer<0x2::coin::Coin<0x2::sui::SUI>>(0x2::coin::from_balance<0x2::sui::SUI>(0x2::balance::split<0x2::sui::SUI>(0x2::table::borrow_mut<address, 0x2::balance::Balance<0x2::sui::SUI>>(&mut arg1.stakes, arg2), v1), arg5), @0x0);
        let v2 = SolverSlashed{
            solver       : arg2,
            slash_amount : v1,
            reason       : arg3,
            timestamp    : 0x2::clock::timestamp_ms(arg4),
        };
        0x2::event::emit<SolverSlashed>(v2);
    }

    entry fun update_min_stake(arg0: &AdminCap, arg1: &mut SolverRegistry, arg2: u64) {
        arg1.min_stake = arg2;
    }

    entry fun update_slash_percentage(arg0: &AdminCap, arg1: &mut SolverRegistry, arg2: u8) {
        assert!(arg2 <= 50, 1009);
        arg1.slash_percentage = arg2;
    }

    // decompiled from Move bytecode v6
}

