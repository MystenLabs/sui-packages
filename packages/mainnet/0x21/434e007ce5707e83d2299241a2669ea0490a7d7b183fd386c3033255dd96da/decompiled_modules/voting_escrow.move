module 0x21434e007ce5707e83d2299241a2669ea0490a7d7b183fd386c3033255dd96da::voting_escrow {
    struct VotingEscrow has store, key {
        id: 0x2::object::UID,
        balance: 0x2::balance::Balance<0x21434e007ce5707e83d2299241a2669ea0490a7d7b183fd386c3033255dd96da::mmt::MMT>,
        bond_mode: u8,
        unlock_at: u64,
        votes: 0x2::vec_map::VecMap<address, Vote>,
    }

    struct Vote has drop, store {
        weight: u64,
        last_claimed: LastClaimed,
    }

    struct LastClaimed has copy, drop, store {
        fee_epoch: u64,
        incentive_epoch: 0x2::vec_map::VecMap<0x1::type_name::TypeName, u64>,
    }

    struct UserVote has copy, drop, store {
        gauge_id: address,
        weight: u64,
    }

    public fun gauge_id(arg0: &UserVote) : address {
        arg0.gauge_id
    }

    public(friend) fun vote_power(arg0: &VotingEscrow, arg1: &0x21434e007ce5707e83d2299241a2669ea0490a7d7b183fd386c3033255dd96da::vote_power::VotePowerConfig, arg2: &0x21434e007ce5707e83d2299241a2669ea0490a7d7b183fd386c3033255dd96da::epoch::EpochConfig, arg3: u64) : u64 {
        if (arg0.bond_mode == 2) {
            0x21434e007ce5707e83d2299241a2669ea0490a7d7b183fd386c3033255dd96da::vote_power::vote_power_for_max_bond(arg1, 0x2::balance::value<0x21434e007ce5707e83d2299241a2669ea0490a7d7b183fd386c3033255dd96da::mmt::MMT>(&arg0.balance))
        } else {
            assert!(arg0.bond_mode == 1, 11);
            0x21434e007ce5707e83d2299241a2669ea0490a7d7b183fd386c3033255dd96da::vote_power::vote_power_for_range(arg1, arg2, 0x2::balance::value<0x21434e007ce5707e83d2299241a2669ea0490a7d7b183fd386c3033255dd96da::mmt::MMT>(&arg0.balance), arg3, arg0.unlock_at)
        }
    }

    public(friend) fun add_vote(arg0: &mut VotingEscrow, arg1: &mut 0x21434e007ce5707e83d2299241a2669ea0490a7d7b183fd386c3033255dd96da::gauge::Gauge, arg2: &0x21434e007ce5707e83d2299241a2669ea0490a7d7b183fd386c3033255dd96da::vote_power::VotePowerConfig, arg3: &0x21434e007ce5707e83d2299241a2669ea0490a7d7b183fd386c3033255dd96da::epoch::EpochConfig, arg4: u64, arg5: u64) {
        check_vote_new_weight(arg0, arg5);
        check_vote_claimed(arg0, arg1, arg4 - 1);
        let v0 = 0x21434e007ce5707e83d2299241a2669ea0490a7d7b183fd386c3033255dd96da::gauge::gauge_id(arg1);
        assert!(!0x2::vec_map::contains<address, Vote>(&arg0.votes, &v0), 7);
        assert!(0x2::vec_map::size<address, Vote>(&arg0.votes) + 1 <= 20, 15);
        0x2::vec_map::insert<address, Vote>(&mut arg0.votes, 0x21434e007ce5707e83d2299241a2669ea0490a7d7b183fd386c3033255dd96da::gauge::gauge_id(arg1), create_new_empty_vote(arg1, arg4));
        let v1 = 0x21434e007ce5707e83d2299241a2669ea0490a7d7b183fd386c3033255dd96da::gauge::gauge_id(arg1);
        let v2 = 0x2::vec_map::get_mut<address, Vote>(&mut arg0.votes, &v1);
        v2.weight = v2.weight + arg5;
        add_vote_to_gauge(arg0, arg1, arg2, arg3, arg5);
    }

    fun add_vote_to_gauge(arg0: &VotingEscrow, arg1: &mut 0x21434e007ce5707e83d2299241a2669ea0490a7d7b183fd386c3033255dd96da::gauge::Gauge, arg2: &0x21434e007ce5707e83d2299241a2669ea0490a7d7b183fd386c3033255dd96da::vote_power::VotePowerConfig, arg3: &0x21434e007ce5707e83d2299241a2669ea0490a7d7b183fd386c3033255dd96da::epoch::EpochConfig, arg4: u64) {
        if (arg0.bond_mode == 1) {
            0x21434e007ce5707e83d2299241a2669ea0490a7d7b183fd386c3033255dd96da::gauge::add_vote_unlock_at(arg1, arg2, arg3, 0x21434e007ce5707e83d2299241a2669ea0490a7d7b183fd386c3033255dd96da::vote_power::effective_amount(0x2::balance::value<0x21434e007ce5707e83d2299241a2669ea0490a7d7b183fd386c3033255dd96da::mmt::MMT>(&arg0.balance), arg4), arg0.unlock_at);
        } else {
            assert!(arg0.bond_mode == 2, 11);
            0x21434e007ce5707e83d2299241a2669ea0490a7d7b183fd386c3033255dd96da::gauge::add_vote_max_bond(arg1, arg2, arg3, 0x21434e007ce5707e83d2299241a2669ea0490a7d7b183fd386c3033255dd96da::vote_power::effective_amount(0x2::balance::value<0x21434e007ce5707e83d2299241a2669ea0490a7d7b183fd386c3033255dd96da::mmt::MMT>(&arg0.balance), arg4));
        };
    }

    public fun bond_info(arg0: &VotingEscrow) : (u64, u8, u64) {
        (0x2::balance::value<0x21434e007ce5707e83d2299241a2669ea0490a7d7b183fd386c3033255dd96da::mmt::MMT>(&arg0.balance), arg0.bond_mode, arg0.unlock_at)
    }

    public fun bond_mode_max_bond() : u8 {
        2
    }

    public fun bond_mode_normal() : u8 {
        1
    }

    public(friend) fun change_vote(arg0: &mut VotingEscrow, arg1: &mut 0x21434e007ce5707e83d2299241a2669ea0490a7d7b183fd386c3033255dd96da::gauge::Gauge, arg2: &0x21434e007ce5707e83d2299241a2669ea0490a7d7b183fd386c3033255dd96da::vote_power::VotePowerConfig, arg3: &0x21434e007ce5707e83d2299241a2669ea0490a7d7b183fd386c3033255dd96da::epoch::EpochConfig, arg4: u64, arg5: u64) {
        check_vote_claimed(arg0, arg1, arg4 - 1);
        let v0 = 0x21434e007ce5707e83d2299241a2669ea0490a7d7b183fd386c3033255dd96da::gauge::gauge_id(arg1);
        let v1 = 0x2::vec_map::get<address, Vote>(&arg0.votes, &v0);
        if (arg5 > v1.weight) {
            check_vote_new_weight(arg0, arg5 - v1.weight);
        };
        if (arg5 > v1.weight) {
            add_vote_to_gauge(arg0, arg1, arg2, arg3, arg5 - v1.weight);
        } else if (arg5 < v1.weight) {
            remove_vote_from_gauge(arg0, arg1, arg2, arg3, v1.weight - arg5);
        };
        let v2 = 0x21434e007ce5707e83d2299241a2669ea0490a7d7b183fd386c3033255dd96da::gauge::gauge_id(arg1);
        0x2::vec_map::get_mut<address, Vote>(&mut arg0.votes, &v2).weight = arg5;
    }

    fun check_incentive_claimed(arg0: &LastClaimed, arg1: 0x1::type_name::TypeName, arg2: u64) : bool {
        0x2::vec_map::contains<0x1::type_name::TypeName, u64>(&arg0.incentive_epoch, &arg1) && *0x2::vec_map::get<0x1::type_name::TypeName, u64>(&arg0.incentive_epoch, &arg1) == arg2
    }

    fun check_merge_allowed_for_bond(arg0: &VotingEscrow, arg1: &VotingEscrow) : bool {
        arg0.bond_mode == 2 || arg1.bond_mode == 2 && false || arg0.unlock_at > arg1.unlock_at
    }

    public fun check_vote_claimed(arg0: &VotingEscrow, arg1: &0x21434e007ce5707e83d2299241a2669ea0490a7d7b183fd386c3033255dd96da::gauge::Gauge, arg2: u64) {
        let v0 = 0x21434e007ce5707e83d2299241a2669ea0490a7d7b183fd386c3033255dd96da::gauge::gauge_id(arg1);
        let v1 = get_gauge_vote(arg0, &v0);
        assert!(v1.last_claimed.fee_epoch == arg2, 12);
        let v2 = 0x21434e007ce5707e83d2299241a2669ea0490a7d7b183fd386c3033255dd96da::gauge::incentive_types(arg1);
        let v3 = 0;
        while (v3 < 0x1::vector::length<0x1::type_name::TypeName>(&v2)) {
            check_incentive_claimed(&v1.last_claimed, *0x1::vector::borrow<0x1::type_name::TypeName>(&v2, v3), arg2);
            v3 = v3 + 1;
        };
    }

    fun check_vote_new_weight(arg0: &VotingEscrow, arg1: u64) {
        let v0 = 0;
        let v1 = 0;
        let v2 = 0x2::vec_map::keys<address, Vote>(&arg0.votes);
        while (v1 < 0x1::vector::length<address>(&v2)) {
            v0 = v0 + 0x2::vec_map::get<address, Vote>(&arg0.votes, 0x1::vector::borrow<address>(&v2, v1)).weight;
            v1 = v1 + 1;
        };
        assert!(v0 + arg1 <= 0x21434e007ce5707e83d2299241a2669ea0490a7d7b183fd386c3033255dd96da::vote_power::vote_weight_denom(), 14);
    }

    public(friend) fun claim_fees_for_gauge_max_bond<T0, T1>(arg0: &mut VotingEscrow, arg1: &mut 0x21434e007ce5707e83d2299241a2669ea0490a7d7b183fd386c3033255dd96da::gauge::Gauge, arg2: &0x21434e007ce5707e83d2299241a2669ea0490a7d7b183fd386c3033255dd96da::vote_power::VotePowerConfig, arg3: u64) : (0x2::balance::Balance<T0>, 0x2::balance::Balance<T1>) {
        assert!(arg0.bond_mode == 2, 4);
        let v0 = 0x21434e007ce5707e83d2299241a2669ea0490a7d7b183fd386c3033255dd96da::gauge::gauge_id(arg1);
        let v1 = get_gauge_vote(arg0, &v0);
        let (v2, v3) = 0x21434e007ce5707e83d2299241a2669ea0490a7d7b183fd386c3033255dd96da::gauge::pending_fees_max_bond(arg1, arg2, 0x21434e007ce5707e83d2299241a2669ea0490a7d7b183fd386c3033255dd96da::vote_power::effective_amount(0x2::balance::value<0x21434e007ce5707e83d2299241a2669ea0490a7d7b183fd386c3033255dd96da::mmt::MMT>(&arg0.balance), v1.weight), v1.last_claimed.fee_epoch + 1, arg3);
        let v4 = 0x21434e007ce5707e83d2299241a2669ea0490a7d7b183fd386c3033255dd96da::gauge::gauge_id(arg1);
        get_gauge_vote_mut(arg0, &v4).last_claimed.fee_epoch = arg3;
        (0x21434e007ce5707e83d2299241a2669ea0490a7d7b183fd386c3033255dd96da::gauge::take_balance<T0>(arg1, v2), 0x21434e007ce5707e83d2299241a2669ea0490a7d7b183fd386c3033255dd96da::gauge::take_balance<T1>(arg1, v3))
    }

    public(friend) fun claim_fees_for_gauge_normal<T0, T1>(arg0: &mut VotingEscrow, arg1: &mut 0x21434e007ce5707e83d2299241a2669ea0490a7d7b183fd386c3033255dd96da::gauge::Gauge, arg2: &0x21434e007ce5707e83d2299241a2669ea0490a7d7b183fd386c3033255dd96da::vote_power::VotePowerConfig, arg3: &0x21434e007ce5707e83d2299241a2669ea0490a7d7b183fd386c3033255dd96da::epoch::EpochConfig, arg4: u64) : (0x2::balance::Balance<T0>, 0x2::balance::Balance<T1>) {
        assert!(arg0.bond_mode == 1, 3);
        let v0 = 0x21434e007ce5707e83d2299241a2669ea0490a7d7b183fd386c3033255dd96da::gauge::gauge_id(arg1);
        let v1 = get_gauge_vote(arg0, &v0);
        let (v2, v3) = 0x21434e007ce5707e83d2299241a2669ea0490a7d7b183fd386c3033255dd96da::gauge::pending_fees_normal(arg1, arg2, arg3, 0x21434e007ce5707e83d2299241a2669ea0490a7d7b183fd386c3033255dd96da::vote_power::effective_amount(0x2::balance::value<0x21434e007ce5707e83d2299241a2669ea0490a7d7b183fd386c3033255dd96da::mmt::MMT>(&arg0.balance), v1.weight), arg0.unlock_at, v1.last_claimed.fee_epoch + 1, arg4);
        let v4 = 0x21434e007ce5707e83d2299241a2669ea0490a7d7b183fd386c3033255dd96da::gauge::gauge_id(arg1);
        get_gauge_vote_mut(arg0, &v4).last_claimed.fee_epoch = arg4;
        (0x21434e007ce5707e83d2299241a2669ea0490a7d7b183fd386c3033255dd96da::gauge::take_balance<T0>(arg1, v2), 0x21434e007ce5707e83d2299241a2669ea0490a7d7b183fd386c3033255dd96da::gauge::take_balance<T1>(arg1, v3))
    }

    public(friend) fun claim_incentive_for_gauge_max_bond<T0>(arg0: &mut VotingEscrow, arg1: &mut 0x21434e007ce5707e83d2299241a2669ea0490a7d7b183fd386c3033255dd96da::gauge::Gauge, arg2: &0x21434e007ce5707e83d2299241a2669ea0490a7d7b183fd386c3033255dd96da::vote_power::VotePowerConfig, arg3: u64) : 0x2::balance::Balance<T0> {
        assert!(arg0.bond_mode == 2, 4);
        let v0 = 0x21434e007ce5707e83d2299241a2669ea0490a7d7b183fd386c3033255dd96da::gauge::gauge_id(arg1);
        let v1 = 0x21434e007ce5707e83d2299241a2669ea0490a7d7b183fd386c3033255dd96da::gauge::pending_incentive_max_bond<T0>(arg1, arg2, 0x21434e007ce5707e83d2299241a2669ea0490a7d7b183fd386c3033255dd96da::vote_power::effective_amount(0x2::balance::value<0x21434e007ce5707e83d2299241a2669ea0490a7d7b183fd386c3033255dd96da::mmt::MMT>(&arg0.balance), get_gauge_vote(arg0, &v0).weight), get_incentive_last_claimed<T0>(arg0, arg1) + 1, arg3);
        let v2 = 0x21434e007ce5707e83d2299241a2669ea0490a7d7b183fd386c3033255dd96da::gauge::gauge_id(arg1);
        let v3 = &mut get_gauge_vote_mut(arg0, &v2).last_claimed;
        set_incentive_last_claimed(v3, 0x1::type_name::get<T0>(), arg3);
        0x21434e007ce5707e83d2299241a2669ea0490a7d7b183fd386c3033255dd96da::gauge::take_balance<T0>(arg1, v1)
    }

    public(friend) fun claim_incentive_for_gauge_normal<T0>(arg0: &mut VotingEscrow, arg1: &mut 0x21434e007ce5707e83d2299241a2669ea0490a7d7b183fd386c3033255dd96da::gauge::Gauge, arg2: &0x21434e007ce5707e83d2299241a2669ea0490a7d7b183fd386c3033255dd96da::vote_power::VotePowerConfig, arg3: &0x21434e007ce5707e83d2299241a2669ea0490a7d7b183fd386c3033255dd96da::epoch::EpochConfig, arg4: u64) : 0x2::balance::Balance<T0> {
        assert!(arg0.bond_mode == 1, 3);
        let v0 = 0x21434e007ce5707e83d2299241a2669ea0490a7d7b183fd386c3033255dd96da::gauge::gauge_id(arg1);
        let v1 = 0x21434e007ce5707e83d2299241a2669ea0490a7d7b183fd386c3033255dd96da::gauge::pending_incentive_unlock_at<T0>(arg1, arg2, arg3, 0x21434e007ce5707e83d2299241a2669ea0490a7d7b183fd386c3033255dd96da::vote_power::effective_amount(0x2::balance::value<0x21434e007ce5707e83d2299241a2669ea0490a7d7b183fd386c3033255dd96da::mmt::MMT>(&arg0.balance), get_gauge_vote(arg0, &v0).weight), arg0.unlock_at, get_incentive_last_claimed<T0>(arg0, arg1) + 1, arg4);
        let v2 = 0x21434e007ce5707e83d2299241a2669ea0490a7d7b183fd386c3033255dd96da::gauge::gauge_id(arg1);
        let v3 = &mut get_gauge_vote_mut(arg0, &v2).last_claimed;
        set_incentive_last_claimed(v3, 0x1::type_name::get<T0>(), arg4);
        0x21434e007ce5707e83d2299241a2669ea0490a7d7b183fd386c3033255dd96da::gauge::take_balance<T0>(arg1, v1)
    }

    public(friend) fun create_max_bond(arg0: 0x2::balance::Balance<0x21434e007ce5707e83d2299241a2669ea0490a7d7b183fd386c3033255dd96da::mmt::MMT>, arg1: &mut 0x2::tx_context::TxContext) : VotingEscrow {
        VotingEscrow{
            id        : 0x2::object::new(arg1),
            balance   : arg0,
            bond_mode : 2,
            unlock_at : 18446744073709551615,
            votes     : 0x2::vec_map::empty<address, Vote>(),
        }
    }

    fun create_new_empty_vote(arg0: &0x21434e007ce5707e83d2299241a2669ea0490a7d7b183fd386c3033255dd96da::gauge::Gauge, arg1: u64) : Vote {
        let v0 = 0x21434e007ce5707e83d2299241a2669ea0490a7d7b183fd386c3033255dd96da::gauge::incentive_types(arg0);
        let v1 = 0x2::vec_map::empty<0x1::type_name::TypeName, u64>();
        let v2 = 0;
        while (v2 < 0x1::vector::length<0x1::type_name::TypeName>(&v0)) {
            0x2::vec_map::insert<0x1::type_name::TypeName, u64>(&mut v1, *0x1::vector::borrow<0x1::type_name::TypeName>(&v0, v2), arg1 - 1);
            v2 = v2 + 1;
        };
        let v3 = LastClaimed{
            fee_epoch       : arg1 - 1,
            incentive_epoch : v1,
        };
        Vote{
            weight       : 0,
            last_claimed : v3,
        }
    }

    public(friend) fun create_normal(arg0: 0x2::balance::Balance<0x21434e007ce5707e83d2299241a2669ea0490a7d7b183fd386c3033255dd96da::mmt::MMT>, arg1: u64, arg2: &0x2::clock::Clock, arg3: &mut 0x2::tx_context::TxContext) : VotingEscrow {
        assert!(0x2::clock::timestamp_ms(arg2) >= arg1, 0);
        VotingEscrow{
            id        : 0x2::object::new(arg3),
            balance   : arg0,
            bond_mode : 1,
            unlock_at : arg1,
            votes     : 0x2::vec_map::empty<address, Vote>(),
        }
    }

    public(friend) fun deposit(arg0: &mut VotingEscrow, arg1: 0x2::balance::Balance<0x21434e007ce5707e83d2299241a2669ea0490a7d7b183fd386c3033255dd96da::mmt::MMT>) {
        0x2::balance::join<0x21434e007ce5707e83d2299241a2669ea0490a7d7b183fd386c3033255dd96da::mmt::MMT>(&mut arg0.balance, arg1);
    }

    public(friend) fun effective_vote_power_for_gauge(arg0: &VotingEscrow, arg1: &0x21434e007ce5707e83d2299241a2669ea0490a7d7b183fd386c3033255dd96da::vote_power::VotePowerConfig, arg2: &0x21434e007ce5707e83d2299241a2669ea0490a7d7b183fd386c3033255dd96da::epoch::EpochConfig, arg3: u64, arg4: &address) : u64 {
        0x21434e007ce5707e83d2299241a2669ea0490a7d7b183fd386c3033255dd96da::vote_power::effective_vote_power(vote_power(arg0, arg1, arg2, arg3), get_gauge_vote(arg0, arg4).weight)
    }

    public(friend) fun extend(arg0: &mut VotingEscrow, arg1: u64) {
        assert!(arg0.bond_mode == 1, 3);
        assert!(arg0.unlock_at < arg1, 2);
        arg0.unlock_at = arg1;
    }

    fun get_gauge_vote(arg0: &VotingEscrow, arg1: &address) : &Vote {
        assert!(0x2::vec_map::contains<address, Vote>(&arg0.votes, arg1), 10);
        0x2::vec_map::get<address, Vote>(&arg0.votes, arg1)
    }

    fun get_gauge_vote_mut(arg0: &mut VotingEscrow, arg1: &address) : &mut Vote {
        assert!(0x2::vec_map::contains<address, Vote>(&arg0.votes, arg1), 10);
        0x2::vec_map::get_mut<address, Vote>(&mut arg0.votes, arg1)
    }

    fun get_incentive_last_claimed<T0>(arg0: &VotingEscrow, arg1: &0x21434e007ce5707e83d2299241a2669ea0490a7d7b183fd386c3033255dd96da::gauge::Gauge) : u64 {
        let v0 = 0x21434e007ce5707e83d2299241a2669ea0490a7d7b183fd386c3033255dd96da::gauge::gauge_id(arg1);
        let v1 = get_gauge_vote(arg0, &v0);
        let v2 = 0x1::type_name::get<T0>();
        if (0x2::vec_map::contains<0x1::type_name::TypeName, u64>(&v1.last_claimed.incentive_epoch, &v2)) {
            return *0x2::vec_map::get<0x1::type_name::TypeName, u64>(&v1.last_claimed.incentive_epoch, &v2)
        };
        let v3 = 0x21434e007ce5707e83d2299241a2669ea0490a7d7b183fd386c3033255dd96da::gauge::get_incentive_epoch_start<T0>(arg1);
        assert!(v3 > 0, 13);
        v3 - 1
    }

    public(friend) fun get_vote_data(arg0: &VotingEscrow, arg1: &address) : &Vote {
        0x2::vec_map::get<address, Vote>(&arg0.votes, arg1)
    }

    public(friend) fun merge(arg0: &mut VotingEscrow, arg1: VotingEscrow) {
        assert!(check_merge_allowed_for_bond(arg0, &arg1), 6);
        let VotingEscrow {
            id        : v0,
            balance   : v1,
            bond_mode : _,
            unlock_at : _,
            votes     : _,
        } = arg1;
        0x2::object::delete(v0);
        0x2::balance::join<0x21434e007ce5707e83d2299241a2669ea0490a7d7b183fd386c3033255dd96da::mmt::MMT>(&mut arg0.balance, v1);
    }

    public(friend) fun remove_vote(arg0: &mut VotingEscrow, arg1: &mut 0x21434e007ce5707e83d2299241a2669ea0490a7d7b183fd386c3033255dd96da::gauge::Gauge, arg2: &0x21434e007ce5707e83d2299241a2669ea0490a7d7b183fd386c3033255dd96da::vote_power::VotePowerConfig, arg3: &0x21434e007ce5707e83d2299241a2669ea0490a7d7b183fd386c3033255dd96da::epoch::EpochConfig, arg4: u64) {
        check_vote_claimed(arg0, arg1, arg4 - 1);
        let v0 = 0x21434e007ce5707e83d2299241a2669ea0490a7d7b183fd386c3033255dd96da::gauge::gauge_id(arg1);
        assert!(0x2::vec_map::contains<address, Vote>(&arg0.votes, &v0), 10);
        let v1 = 0x21434e007ce5707e83d2299241a2669ea0490a7d7b183fd386c3033255dd96da::gauge::gauge_id(arg1);
        let (_, v3) = 0x2::vec_map::remove<address, Vote>(&mut arg0.votes, &v1);
        let v4 = v3;
        remove_vote_from_gauge(arg0, arg1, arg2, arg3, v4.weight);
    }

    fun remove_vote_from_gauge(arg0: &VotingEscrow, arg1: &mut 0x21434e007ce5707e83d2299241a2669ea0490a7d7b183fd386c3033255dd96da::gauge::Gauge, arg2: &0x21434e007ce5707e83d2299241a2669ea0490a7d7b183fd386c3033255dd96da::vote_power::VotePowerConfig, arg3: &0x21434e007ce5707e83d2299241a2669ea0490a7d7b183fd386c3033255dd96da::epoch::EpochConfig, arg4: u64) {
        if (arg0.bond_mode == 1) {
            0x21434e007ce5707e83d2299241a2669ea0490a7d7b183fd386c3033255dd96da::gauge::remove_vote_unlock_at(arg1, arg2, arg3, 0x21434e007ce5707e83d2299241a2669ea0490a7d7b183fd386c3033255dd96da::vote_power::effective_amount(0x2::balance::value<0x21434e007ce5707e83d2299241a2669ea0490a7d7b183fd386c3033255dd96da::mmt::MMT>(&arg0.balance), arg4), arg0.unlock_at);
        } else {
            assert!(arg0.bond_mode == 2, 11);
            0x21434e007ce5707e83d2299241a2669ea0490a7d7b183fd386c3033255dd96da::gauge::remove_vote_max_bound(arg1, arg2, arg3, 0x21434e007ce5707e83d2299241a2669ea0490a7d7b183fd386c3033255dd96da::vote_power::effective_amount(0x2::balance::value<0x21434e007ce5707e83d2299241a2669ea0490a7d7b183fd386c3033255dd96da::mmt::MMT>(&arg0.balance), arg4));
        };
    }

    fun set_incentive_last_claimed(arg0: &mut LastClaimed, arg1: 0x1::type_name::TypeName, arg2: u64) {
        if (0x2::vec_map::contains<0x1::type_name::TypeName, u64>(&arg0.incentive_epoch, &arg1)) {
            *0x2::vec_map::get_mut<0x1::type_name::TypeName, u64>(&mut arg0.incentive_epoch, &arg1) = arg2;
        } else {
            0x2::vec_map::insert<0x1::type_name::TypeName, u64>(&mut arg0.incentive_epoch, arg1, arg2);
        };
    }

    public(friend) fun set_max_bond(arg0: &mut VotingEscrow) {
        assert!(arg0.bond_mode == 1, 1);
        arg0.bond_mode = 2;
        arg0.unlock_at = 0;
    }

    public(friend) fun set_normal(arg0: &mut VotingEscrow, arg1: u64) {
        assert!(arg0.bond_mode == 2, 5);
        arg0.bond_mode = 1;
        arg0.unlock_at = arg1;
    }

    public(friend) fun unbond(arg0: VotingEscrow, arg1: &0x2::clock::Clock) : 0x2::balance::Balance<0x21434e007ce5707e83d2299241a2669ea0490a7d7b183fd386c3033255dd96da::mmt::MMT> {
        assert!(arg0.bond_mode == 1, 8);
        assert!(arg0.unlock_at <= 0x2::clock::timestamp_ms(arg1), 9);
        let VotingEscrow {
            id        : v0,
            balance   : v1,
            bond_mode : _,
            unlock_at : _,
            votes     : _,
        } = arg0;
        0x2::object::delete(v0);
        v1
    }

    public(friend) fun unlock_epoch(arg0: &VotingEscrow, arg1: &0x21434e007ce5707e83d2299241a2669ea0490a7d7b183fd386c3033255dd96da::epoch::EpochConfig) : u64 {
        if (arg0.bond_mode == 2) {
            18446744073709551615
        } else {
            0x21434e007ce5707e83d2299241a2669ea0490a7d7b183fd386c3033255dd96da::epoch::epoch_id(arg1, arg0.unlock_at)
        }
    }

    public fun user_votes(arg0: &VotingEscrow) : vector<UserVote> {
        let v0 = 0x2::vec_map::keys<address, Vote>(&arg0.votes);
        let v1 = 0x1::vector::empty<UserVote>();
        let v2 = 0;
        while (v2 < 0x1::vector::length<address>(&v0)) {
            let v3 = *0x1::vector::borrow<address>(&v0, v2);
            let v4 = UserVote{
                gauge_id : v3,
                weight   : 0x2::vec_map::get<address, Vote>(&arg0.votes, &v3).weight,
            };
            0x1::vector::push_back<UserVote>(&mut v1, v4);
            v2 = v2 + 1;
        };
        let v5 = 0;
        while (v5 < 0x1::vector::length<address>(&v0)) {
            0x1::vector::pop_back<address>(&mut v0);
            v5 = v5 + 1;
        };
        0x1::vector::destroy_empty<address>(v0);
        v1
    }

    public fun user_votes_from_vectors(arg0: vector<address>, arg1: vector<u64>) : vector<UserVote> {
        assert!(0x1::vector::length<address>(&arg0) == 0x1::vector::length<u64>(&arg1), 16);
        let v0 = 0x1::vector::empty<UserVote>();
        let v1 = 0;
        while (v1 < 0x1::vector::length<address>(&arg0)) {
            let v2 = UserVote{
                gauge_id : *0x1::vector::borrow<address>(&arg0, v1),
                weight   : *0x1::vector::borrow<u64>(&arg1, v1),
            };
            0x1::vector::push_back<UserVote>(&mut v0, v2);
            v1 = v1 + 1;
        };
        v0
    }

    public fun weight(arg0: &UserVote) : u64 {
        arg0.weight
    }

    // decompiled from Move bytecode v6
}

