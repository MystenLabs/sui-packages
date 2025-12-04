module 0x41efa3f778f47ad4938643e7f45a8cb0d78d4338ecd2c872e054d98b9a87af67::voter {
    struct VOTER has drop {
        dummy_field: bool,
    }

    struct Voted has copy, drop {
        lock_id: 0x2::object::ID,
        weight: u64,
    }

    struct Abstained has copy, drop {
        lock_id: 0x2::object::ID,
        weight: u64,
    }

    struct AdminCap has key {
        id: 0x2::object::UID,
    }

    struct Voter has key {
        id: 0x2::object::UID,
        version: u8,
        index: u64,
        vote_delay: u64,
        distribution_window_duration: u64,
        pools: 0x2::table_vec::TableVec<0x2::object::ID>,
        supply_index: 0x2::table::Table<0x2::object::ID, u64>,
        claimable: 0x2::table::Table<0x2::object::ID, u64>,
        gauges: 0x2::linked_table::LinkedTable<0x2::object::ID, 0x2::object::ID>,
        is_alive: 0x2::table::Table<0x2::object::ID, bool>,
        gauge_distribution_timestamp: 0x2::table::Table<0x2::object::ID, u64>,
        pool_for_gauge: 0x2::table::Table<0x2::object::ID, 0x2::object::ID>,
        votes: 0x2::table::Table<0x2::object::ID, 0x2::table::Table<0x2::object::ID, u64>>,
        pool_vote: 0x2::table::Table<0x2::object::ID, 0x2::table_vec::TableVec<0x2::object::ID>>,
        weights_per_epoch: 0x2::table::Table<u64, 0x2::table::Table<0x2::object::ID, u64>>,
        total_weights_per_epoch: 0x2::table::Table<u64, u64>,
        last_voted: 0x2::table::Table<0x2::object::ID, u64>,
        rewards: 0x2::balance::Balance<0x41efa3f778f47ad4938643e7f45a8cb0d78d4338ecd2c872e054d98b9a87af67::tyde_shift::TYDE_SHIFT>,
    }

    struct UserVote has copy, drop, store {
        pool_id: 0x2::object::ID,
        weight: u64,
    }

    public fun notify_reward_amount(arg0: &mut Voter, arg1: 0x2::coin::Coin<0x41efa3f778f47ad4938643e7f45a8cb0d78d4338ecd2c872e054d98b9a87af67::tyde_shift::TYDE_SHIFT>, arg2: &0x41efa3f778f47ad4938643e7f45a8cb0d78d4338ecd2c872e054d98b9a87af67::minter::Minter) {
        notify_reward_amount_(arg0, arg1, arg2);
    }

    public fun create_gauge<T0, T1, T2>(arg0: &mut Voter, arg1: &mut 0x41efa3f778f47ad4938643e7f45a8cb0d78d4338ecd2c872e054d98b9a87af67::pool::Pool<T0, T1, T2>, arg2: &mut 0x41efa3f778f47ad4938643e7f45a8cb0d78d4338ecd2c872e054d98b9a87af67::gauge_factory::GaugeFactory, arg3: &mut 0x41efa3f778f47ad4938643e7f45a8cb0d78d4338ecd2c872e054d98b9a87af67::bribe_factory::BribeFactory, arg4: &AdminCap, arg5: &mut 0x2::tx_context::TxContext) {
        create_gauge_<T0, T1, T2>(arg0, arg1, arg2, arg3, arg5);
    }

    fun check_end_vote_window(arg0: &Voter, arg1: &0x2::clock::Clock) {
        let v0 = 0x2::clock::timestamp_ms(arg1);
        assert!(v0 < v0 - v0 % 0x41efa3f778f47ad4938643e7f45a8cb0d78d4338ecd2c872e054d98b9a87af67::consts::WEEK() + 0x41efa3f778f47ad4938643e7f45a8cb0d78d4338ecd2c872e054d98b9a87af67::consts::WEEK() - arg0.distribution_window_duration, 1);
    }

    fun check_start_vote_window(arg0: &Voter, arg1: &0x2::clock::Clock) {
        let v0 = 0x2::clock::timestamp_ms(arg1);
        assert!(v0 > v0 - v0 % 0x41efa3f778f47ad4938643e7f45a8cb0d78d4338ecd2c872e054d98b9a87af67::consts::WEEK() + arg0.distribution_window_duration, 1);
    }

    fun create_gauge_<T0, T1, T2>(arg0: &mut Voter, arg1: &mut 0x41efa3f778f47ad4938643e7f45a8cb0d78d4338ecd2c872e054d98b9a87af67::pool::Pool<T0, T1, T2>, arg2: &mut 0x41efa3f778f47ad4938643e7f45a8cb0d78d4338ecd2c872e054d98b9a87af67::gauge_factory::GaugeFactory, arg3: &mut 0x41efa3f778f47ad4938643e7f45a8cb0d78d4338ecd2c872e054d98b9a87af67::bribe_factory::BribeFactory, arg4: &mut 0x2::tx_context::TxContext) {
        assert!(arg0.version == 1, 0);
        assert!(!0x2::linked_table::contains<0x2::object::ID, 0x2::object::ID>(&arg0.gauges, 0x41efa3f778f47ad4938643e7f45a8cb0d78d4338ecd2c872e054d98b9a87af67::pool::id<T0, T1, T2>(arg1)), 1);
        let v0 = 0x41efa3f778f47ad4938643e7f45a8cb0d78d4338ecd2c872e054d98b9a87af67::gauge_factory::create_gauge<T0, T1, T2>(arg2, arg1, arg4);
        0x41efa3f778f47ad4938643e7f45a8cb0d78d4338ecd2c872e054d98b9a87af67::bribe_factory::create_bribe_pair<T0, T1>(arg3, v0, arg4);
        0x2::linked_table::push_back<0x2::object::ID, 0x2::object::ID>(&mut arg0.gauges, 0x41efa3f778f47ad4938643e7f45a8cb0d78d4338ecd2c872e054d98b9a87af67::pool::id<T0, T1, T2>(arg1), v0);
        0x2::table::add<0x2::object::ID, 0x2::object::ID>(&mut arg0.pool_for_gauge, v0, 0x41efa3f778f47ad4938643e7f45a8cb0d78d4338ecd2c872e054d98b9a87af67::pool::id<T0, T1, T2>(arg1));
        0x2::table::add<0x2::object::ID, u64>(&mut arg0.supply_index, v0, arg0.index);
        0x2::table::add<0x2::object::ID, bool>(&mut arg0.is_alive, v0, true);
    }

    public fun distribute<T0, T1, T2>(arg0: &mut Voter, arg1: &mut 0x41efa3f778f47ad4938643e7f45a8cb0d78d4338ecd2c872e054d98b9a87af67::gauge::Gauge<T0, T1, T2>, arg2: &0x41efa3f778f47ad4938643e7f45a8cb0d78d4338ecd2c872e054d98b9a87af67::minter::Minter, arg3: &0x2::clock::Clock, arg4: &mut 0x2::tx_context::TxContext) {
        distribute_<T0, T1, T2>(arg0, arg1, arg2, arg3, arg4);
    }

    fun distribute_<T0, T1, T2>(arg0: &mut Voter, arg1: &mut 0x41efa3f778f47ad4938643e7f45a8cb0d78d4338ecd2c872e054d98b9a87af67::gauge::Gauge<T0, T1, T2>, arg2: &0x41efa3f778f47ad4938643e7f45a8cb0d78d4338ecd2c872e054d98b9a87af67::minter::Minter, arg3: &0x2::clock::Clock, arg4: &mut 0x2::tx_context::TxContext) {
        assert!(arg0.version == 1, 0);
        if (!0x2::table::contains<0x2::object::ID, u64>(&arg0.gauge_distribution_timestamp, 0x41efa3f778f47ad4938643e7f45a8cb0d78d4338ecd2c872e054d98b9a87af67::gauge::id<T0, T1, T2>(arg1))) {
            0x2::table::add<0x2::object::ID, u64>(&mut arg0.gauge_distribution_timestamp, 0x41efa3f778f47ad4938643e7f45a8cb0d78d4338ecd2c872e054d98b9a87af67::gauge::id<T0, T1, T2>(arg1), 0);
        };
        let v0 = 0x41efa3f778f47ad4938643e7f45a8cb0d78d4338ecd2c872e054d98b9a87af67::minter::active_period(arg2);
        if (*0x2::table::borrow<0x2::object::ID, u64>(&arg0.gauge_distribution_timestamp, 0x41efa3f778f47ad4938643e7f45a8cb0d78d4338ecd2c872e054d98b9a87af67::gauge::id<T0, T1, T2>(arg1)) < v0) {
            update_for_after_distribution(arg0, 0x41efa3f778f47ad4938643e7f45a8cb0d78d4338ecd2c872e054d98b9a87af67::gauge::id<T0, T1, T2>(arg1), arg2);
            let v1 = *0x2::table::borrow<0x2::object::ID, u64>(&arg0.claimable, 0x41efa3f778f47ad4938643e7f45a8cb0d78d4338ecd2c872e054d98b9a87af67::gauge::id<T0, T1, T2>(arg1));
            if (v1 > 0 && is_alive(arg0, *0x2::table::borrow<0x2::object::ID, 0x2::object::ID>(&arg0.pool_for_gauge, 0x41efa3f778f47ad4938643e7f45a8cb0d78d4338ecd2c872e054d98b9a87af67::gauge::id<T0, T1, T2>(arg1)))) {
                *0x2::table::borrow_mut<0x2::object::ID, u64>(&mut arg0.claimable, 0x41efa3f778f47ad4938643e7f45a8cb0d78d4338ecd2c872e054d98b9a87af67::gauge::id<T0, T1, T2>(arg1)) = 0;
                *0x2::table::borrow_mut<0x2::object::ID, u64>(&mut arg0.gauge_distribution_timestamp, 0x41efa3f778f47ad4938643e7f45a8cb0d78d4338ecd2c872e054d98b9a87af67::gauge::id<T0, T1, T2>(arg1)) = v0;
                0x41efa3f778f47ad4938643e7f45a8cb0d78d4338ecd2c872e054d98b9a87af67::gauge::notify_reward_amount<T0, T1, T2>(arg1, 0x2::coin::from_balance<0x41efa3f778f47ad4938643e7f45a8cb0d78d4338ecd2c872e054d98b9a87af67::tyde_shift::TYDE_SHIFT>(0x2::balance::split<0x41efa3f778f47ad4938643e7f45a8cb0d78d4338ecd2c872e054d98b9a87af67::tyde_shift::TYDE_SHIFT>(&mut arg0.rewards, v1), arg4), arg3);
            };
        };
    }

    public fun gauge_for_pool(arg0: &Voter, arg1: 0x2::object::ID) : 0x2::object::ID {
        *0x2::linked_table::borrow<0x2::object::ID, 0x2::object::ID>(&arg0.gauges, arg1)
    }

    fun init(arg0: VOTER, arg1: &mut 0x2::tx_context::TxContext) {
        let v0 = Voter{
            id                           : 0x2::object::new(arg1),
            version                      : 1,
            index                        : 0,
            vote_delay                   : 1000,
            distribution_window_duration : 0,
            pools                        : 0x2::table_vec::empty<0x2::object::ID>(arg1),
            supply_index                 : 0x2::table::new<0x2::object::ID, u64>(arg1),
            claimable                    : 0x2::table::new<0x2::object::ID, u64>(arg1),
            gauges                       : 0x2::linked_table::new<0x2::object::ID, 0x2::object::ID>(arg1),
            is_alive                     : 0x2::table::new<0x2::object::ID, bool>(arg1),
            gauge_distribution_timestamp : 0x2::table::new<0x2::object::ID, u64>(arg1),
            pool_for_gauge               : 0x2::table::new<0x2::object::ID, 0x2::object::ID>(arg1),
            votes                        : 0x2::table::new<0x2::object::ID, 0x2::table::Table<0x2::object::ID, u64>>(arg1),
            pool_vote                    : 0x2::table::new<0x2::object::ID, 0x2::table_vec::TableVec<0x2::object::ID>>(arg1),
            weights_per_epoch            : 0x2::table::new<u64, 0x2::table::Table<0x2::object::ID, u64>>(arg1),
            total_weights_per_epoch      : 0x2::table::new<u64, u64>(arg1),
            last_voted                   : 0x2::table::new<0x2::object::ID, u64>(arg1),
            rewards                      : 0x2::balance::zero<0x41efa3f778f47ad4938643e7f45a8cb0d78d4338ecd2c872e054d98b9a87af67::tyde_shift::TYDE_SHIFT>(),
        };
        let v1 = AdminCap{id: 0x2::object::new(arg1)};
        0x2::transfer::transfer<AdminCap>(v1, 0x2::tx_context::sender(arg1));
        0x2::transfer::share_object<Voter>(v0);
    }

    public fun is_alive(arg0: &Voter, arg1: 0x2::object::ID) : bool {
        if (!0x2::linked_table::contains<0x2::object::ID, 0x2::object::ID>(&arg0.gauges, arg1)) {
            return false
        };
        let v0 = *0x2::linked_table::borrow<0x2::object::ID, 0x2::object::ID>(&arg0.gauges, arg1);
        !0x2::table::contains<0x2::object::ID, bool>(&arg0.is_alive, v0) && false || *0x2::table::borrow<0x2::object::ID, bool>(&arg0.is_alive, v0)
    }

    public fun kill_gauge<T0, T1, T2>(arg0: &mut Voter, arg1: &mut 0x41efa3f778f47ad4938643e7f45a8cb0d78d4338ecd2c872e054d98b9a87af67::pool::Pool<T0, T1, T2>, arg2: &AdminCap) {
        kill_gauge_<T0, T1, T2>(arg0, arg1, arg2);
    }

    fun kill_gauge_<T0, T1, T2>(arg0: &mut Voter, arg1: &mut 0x41efa3f778f47ad4938643e7f45a8cb0d78d4338ecd2c872e054d98b9a87af67::pool::Pool<T0, T1, T2>, arg2: &AdminCap) {
        assert!(arg0.version == 1, 0);
        *0x2::table::borrow_mut<0x2::object::ID, bool>(&mut arg0.is_alive, *0x2::linked_table::borrow<0x2::object::ID, 0x2::object::ID>(&arg0.gauges, 0x41efa3f778f47ad4938643e7f45a8cb0d78d4338ecd2c872e054d98b9a87af67::pool::id<T0, T1, T2>(arg1))) = false;
        0x41efa3f778f47ad4938643e7f45a8cb0d78d4338ecd2c872e054d98b9a87af67::pool::set_gauge_active<T0, T1, T2>(arg1, false);
    }

    entry fun migrate(arg0: &mut Voter, arg1: &AdminCap) {
        assert!(arg0.version < 1, 13906836721258987519);
        arg0.version = 1;
    }

    fun notify_reward_amount_(arg0: &mut Voter, arg1: 0x2::coin::Coin<0x41efa3f778f47ad4938643e7f45a8cb0d78d4338ecd2c872e054d98b9a87af67::tyde_shift::TYDE_SHIFT>, arg2: &0x41efa3f778f47ad4938643e7f45a8cb0d78d4338ecd2c872e054d98b9a87af67::minter::Minter) {
        assert!(arg0.version == 1, 0);
        let v0 = 0x2::linked_table::front<0x2::object::ID, 0x2::object::ID>(&arg0.gauges);
        while (0x1::option::is_some<0x2::object::ID>(v0)) {
            if (0x1::option::is_some<0x2::object::ID>(v0)) {
                let v1 = 0x1::option::borrow<0x2::object::ID>(v0);
                assert!(*0x2::table::borrow<0x2::object::ID, u64>(&arg0.supply_index, *0x2::linked_table::borrow<0x2::object::ID, 0x2::object::ID>(&arg0.gauges, *v1)) == arg0.index, 13906835789251084287);
                v0 = 0x2::linked_table::next<0x2::object::ID, 0x2::object::ID>(&arg0.gauges, *v1);
            };
        };
        let v2 = total_weight_at(arg0, 0x41efa3f778f47ad4938643e7f45a8cb0d78d4338ecd2c872e054d98b9a87af67::minter::active_period(arg2) - 0x41efa3f778f47ad4938643e7f45a8cb0d78d4338ecd2c872e054d98b9a87af67::consts::WEEK());
        let v3 = 0;
        if (v2 > 0) {
            v3 = 0x41efa3f778f47ad4938643e7f45a8cb0d78d4338ecd2c872e054d98b9a87af67::amm_math::safe_mul_div_u64(0x2::coin::value<0x41efa3f778f47ad4938643e7f45a8cb0d78d4338ecd2c872e054d98b9a87af67::tyde_shift::TYDE_SHIFT>(&arg1), 0x1::u64::pow(10, 9), v2);
        };
        if (v3 > 0) {
            arg0.index = arg0.index + (v3 as u64);
        };
        0x2::balance::join<0x41efa3f778f47ad4938643e7f45a8cb0d78d4338ecd2c872e054d98b9a87af67::tyde_shift::TYDE_SHIFT>(&mut arg0.rewards, 0x2::coin::into_balance<0x41efa3f778f47ad4938643e7f45a8cb0d78d4338ecd2c872e054d98b9a87af67::tyde_shift::TYDE_SHIFT>(arg1));
    }

    public fun poke(arg0: &mut Voter, arg1: &mut 0x41efa3f778f47ad4938643e7f45a8cb0d78d4338ecd2c872e054d98b9a87af67::voting_escrow::VotingEscrow, arg2: &mut 0x41efa3f778f47ad4938643e7f45a8cb0d78d4338ecd2c872e054d98b9a87af67::bribe_factory::BribeFactory, arg3: &0x41efa3f778f47ad4938643e7f45a8cb0d78d4338ecd2c872e054d98b9a87af67::minter::Minter, arg4: &0x2::clock::Clock, arg5: &mut 0x2::tx_context::TxContext) {
        poke_internal(arg0, arg1, arg2, arg3, arg4, arg5);
    }

    fun poke_(arg0: &mut Voter, arg1: &mut 0x41efa3f778f47ad4938643e7f45a8cb0d78d4338ecd2c872e054d98b9a87af67::voting_escrow::VotingEscrow, arg2: &mut 0x41efa3f778f47ad4938643e7f45a8cb0d78d4338ecd2c872e054d98b9a87af67::bribe_factory::BribeFactory, arg3: &0x41efa3f778f47ad4938643e7f45a8cb0d78d4338ecd2c872e054d98b9a87af67::minter::Minter, arg4: &0x2::clock::Clock, arg5: &mut 0x2::tx_context::TxContext) {
        assert!(arg0.version == 1, 0);
        let v0 = 0x2::table::borrow<0x2::object::ID, 0x2::table_vec::TableVec<0x2::object::ID>>(&arg0.pool_vote, 0x41efa3f778f47ad4938643e7f45a8cb0d78d4338ecd2c872e054d98b9a87af67::voting_escrow::id(arg1));
        let v1 = 0x1::vector::empty<0x2::object::ID>();
        let v2 = 0x1::vector::empty<u64>();
        let v3 = 0;
        while (v3 < 0x2::table_vec::length<0x2::object::ID>(v0)) {
            let v4 = *0x2::table_vec::borrow<0x2::object::ID>(v0, v3);
            0x1::vector::insert<0x2::object::ID>(&mut v1, v4, v3);
            0x1::vector::insert<u64>(&mut v2, *0x2::table::borrow<0x2::object::ID, u64>(0x2::table::borrow<0x2::object::ID, 0x2::table::Table<0x2::object::ID, u64>>(&arg0.votes, 0x41efa3f778f47ad4938643e7f45a8cb0d78d4338ecd2c872e054d98b9a87af67::voting_escrow::id(arg1)), v4), v3);
            v3 = v3 + 1;
        };
        vote_(arg0, arg1, v1, v2, arg2, arg3, arg4, arg5);
        if (0x2::table::contains<0x2::object::ID, u64>(&arg0.last_voted, 0x41efa3f778f47ad4938643e7f45a8cb0d78d4338ecd2c872e054d98b9a87af67::voting_escrow::id(arg1))) {
            *0x2::table::borrow_mut<0x2::object::ID, u64>(&mut arg0.last_voted, 0x41efa3f778f47ad4938643e7f45a8cb0d78d4338ecd2c872e054d98b9a87af67::voting_escrow::id(arg1)) = 0x41efa3f778f47ad4938643e7f45a8cb0d78d4338ecd2c872e054d98b9a87af67::minter::active_period(arg3) + 1000;
        } else {
            0x2::table::add<0x2::object::ID, u64>(&mut arg0.last_voted, 0x41efa3f778f47ad4938643e7f45a8cb0d78d4338ecd2c872e054d98b9a87af67::voting_escrow::id(arg1), 0x41efa3f778f47ad4938643e7f45a8cb0d78d4338ecd2c872e054d98b9a87af67::minter::active_period(arg3) + 1000);
        };
    }

    fun poke_internal(arg0: &mut Voter, arg1: &mut 0x41efa3f778f47ad4938643e7f45a8cb0d78d4338ecd2c872e054d98b9a87af67::voting_escrow::VotingEscrow, arg2: &mut 0x41efa3f778f47ad4938643e7f45a8cb0d78d4338ecd2c872e054d98b9a87af67::bribe_factory::BribeFactory, arg3: &0x41efa3f778f47ad4938643e7f45a8cb0d78d4338ecd2c872e054d98b9a87af67::minter::Minter, arg4: &0x2::clock::Clock, arg5: &mut 0x2::tx_context::TxContext) {
        assert!(arg0.version == 1, 0);
        check_end_vote_window(arg0, arg4);
        poke_(arg0, arg1, arg2, arg3, arg4, arg5);
    }

    public fun reset(arg0: &mut Voter, arg1: &mut 0x41efa3f778f47ad4938643e7f45a8cb0d78d4338ecd2c872e054d98b9a87af67::voting_escrow::VotingEscrow, arg2: &mut 0x41efa3f778f47ad4938643e7f45a8cb0d78d4338ecd2c872e054d98b9a87af67::bribe_factory::BribeFactory, arg3: &0x41efa3f778f47ad4938643e7f45a8cb0d78d4338ecd2c872e054d98b9a87af67::minter::Minter, arg4: &0x2::clock::Clock) {
        reset_internal(arg0, arg1, arg2, arg3, arg4);
    }

    fun reset_(arg0: &mut Voter, arg1: &0x41efa3f778f47ad4938643e7f45a8cb0d78d4338ecd2c872e054d98b9a87af67::voting_escrow::VotingEscrow, arg2: &mut 0x41efa3f778f47ad4938643e7f45a8cb0d78d4338ecd2c872e054d98b9a87af67::bribe_factory::BribeFactory, arg3: &0x41efa3f778f47ad4938643e7f45a8cb0d78d4338ecd2c872e054d98b9a87af67::minter::Minter) {
        assert!(arg0.version == 1, 0);
        if (0x2::table::contains<0x2::object::ID, 0x2::table_vec::TableVec<0x2::object::ID>>(&arg0.pool_vote, 0x41efa3f778f47ad4938643e7f45a8cb0d78d4338ecd2c872e054d98b9a87af67::voting_escrow::id(arg1))) {
            let v0 = 0x2::table::borrow_mut<0x2::object::ID, 0x2::table_vec::TableVec<0x2::object::ID>>(&mut arg0.pool_vote, 0x41efa3f778f47ad4938643e7f45a8cb0d78d4338ecd2c872e054d98b9a87af67::voting_escrow::id(arg1));
            let v1 = 0;
            let v2 = 0x41efa3f778f47ad4938643e7f45a8cb0d78d4338ecd2c872e054d98b9a87af67::minter::active_period(arg3);
            let v3 = 0;
            while (v3 < 0x2::table_vec::length<0x2::object::ID>(v0)) {
                let v4 = *0x2::table_vec::borrow<0x2::object::ID>(v0, v3);
                let v5 = *0x2::linked_table::borrow<0x2::object::ID, 0x2::object::ID>(&arg0.gauges, v4);
                let v6 = *0x2::table::borrow<0x2::object::ID, u64>(0x2::table::borrow<0x2::object::ID, 0x2::table::Table<0x2::object::ID, u64>>(&arg0.votes, 0x41efa3f778f47ad4938643e7f45a8cb0d78d4338ecd2c872e054d98b9a87af67::voting_escrow::id(arg1)), v4);
                if (v6 > 0) {
                    *0x2::table::borrow_mut<0x2::object::ID, u64>(0x2::table::borrow_mut<0x2::object::ID, 0x2::table::Table<0x2::object::ID, u64>>(&mut arg0.votes, 0x41efa3f778f47ad4938643e7f45a8cb0d78d4338ecd2c872e054d98b9a87af67::voting_escrow::id(arg1)), v4) = 0;
                    if (*0x2::table::borrow<0x2::object::ID, u64>(&arg0.last_voted, 0x41efa3f778f47ad4938643e7f45a8cb0d78d4338ecd2c872e054d98b9a87af67::voting_escrow::id(arg1)) > v2) {
                        *0x2::table::borrow_mut<0x2::object::ID, u64>(0x2::table::borrow_mut<u64, 0x2::table::Table<0x2::object::ID, u64>>(&mut arg0.weights_per_epoch, v2), v4) = *0x2::table::borrow<0x2::object::ID, u64>(0x2::table::borrow<u64, 0x2::table::Table<0x2::object::ID, u64>>(&arg0.weights_per_epoch, v2), v4) - v6;
                        let (v7, v8) = 0x41efa3f778f47ad4938643e7f45a8cb0d78d4338ecd2c872e054d98b9a87af67::bribe_factory::bribes_mut(arg2, v5);
                        0x41efa3f778f47ad4938643e7f45a8cb0d78d4338ecd2c872e054d98b9a87af67::bribe::withdraw(v7, v6, arg1, arg3);
                        0x41efa3f778f47ad4938643e7f45a8cb0d78d4338ecd2c872e054d98b9a87af67::bribe::withdraw(v8, v6, arg1, arg3);
                        if (0x2::table::contains<0x2::object::ID, bool>(&arg0.is_alive, v5)) {
                            if (*0x2::table::borrow<0x2::object::ID, bool>(&arg0.is_alive, v5)) {
                                v1 = v1 + v6;
                            };
                        };
                    };
                    let v9 = Abstained{
                        lock_id : 0x41efa3f778f47ad4938643e7f45a8cb0d78d4338ecd2c872e054d98b9a87af67::voting_escrow::id(arg1),
                        weight  : v6,
                    };
                    0x2::event::emit<Abstained>(v9);
                };
                v3 = v3 + 1;
            };
            if (*0x2::table::borrow<0x2::object::ID, u64>(&arg0.last_voted, 0x41efa3f778f47ad4938643e7f45a8cb0d78d4338ecd2c872e054d98b9a87af67::voting_escrow::id(arg1)) < v2) {
                v1 = 0;
            };
            if (!0x2::table::contains<u64, u64>(&arg0.total_weights_per_epoch, v2)) {
                0x2::table::add<u64, u64>(&mut arg0.total_weights_per_epoch, v2, 0);
            };
            *0x2::table::borrow_mut<u64, u64>(&mut arg0.total_weights_per_epoch, v2) = *0x2::table::borrow<u64, u64>(&arg0.total_weights_per_epoch, v2) - v1;
            0x2::table_vec::drop<0x2::object::ID>(0x2::table::remove<0x2::object::ID, 0x2::table_vec::TableVec<0x2::object::ID>>(&mut arg0.pool_vote, 0x41efa3f778f47ad4938643e7f45a8cb0d78d4338ecd2c872e054d98b9a87af67::voting_escrow::id(arg1)));
        };
    }

    fun reset_internal(arg0: &mut Voter, arg1: &mut 0x41efa3f778f47ad4938643e7f45a8cb0d78d4338ecd2c872e054d98b9a87af67::voting_escrow::VotingEscrow, arg2: &mut 0x41efa3f778f47ad4938643e7f45a8cb0d78d4338ecd2c872e054d98b9a87af67::bribe_factory::BribeFactory, arg3: &0x41efa3f778f47ad4938643e7f45a8cb0d78d4338ecd2c872e054d98b9a87af67::minter::Minter, arg4: &0x2::clock::Clock) {
        assert!(arg0.version == 1, 0);
        vote_delay_(arg0, arg1, arg4);
        reset_(arg0, arg1, arg2, arg3);
        0x41efa3f778f47ad4938643e7f45a8cb0d78d4338ecd2c872e054d98b9a87af67::voting_escrow::abstain(arg1);
        if (0x2::table::contains<0x2::object::ID, u64>(&arg0.last_voted, 0x41efa3f778f47ad4938643e7f45a8cb0d78d4338ecd2c872e054d98b9a87af67::voting_escrow::id(arg1))) {
            *0x2::table::borrow_mut<0x2::object::ID, u64>(&mut arg0.last_voted, 0x41efa3f778f47ad4938643e7f45a8cb0d78d4338ecd2c872e054d98b9a87af67::voting_escrow::id(arg1)) = 0x41efa3f778f47ad4938643e7f45a8cb0d78d4338ecd2c872e054d98b9a87af67::minter::active_period(arg3) + 1000;
        } else {
            0x2::table::add<0x2::object::ID, u64>(&mut arg0.last_voted, 0x41efa3f778f47ad4938643e7f45a8cb0d78d4338ecd2c872e054d98b9a87af67::voting_escrow::id(arg1), 0x41efa3f778f47ad4938643e7f45a8cb0d78d4338ecd2c872e054d98b9a87af67::minter::active_period(arg3) + 1000);
        };
    }

    public fun revive_gauge<T0, T1, T2>(arg0: &mut Voter, arg1: &mut 0x41efa3f778f47ad4938643e7f45a8cb0d78d4338ecd2c872e054d98b9a87af67::pool::Pool<T0, T1, T2>, arg2: &AdminCap) {
        revive_gauge_<T0, T1, T2>(arg0, arg1, arg2);
    }

    fun revive_gauge_<T0, T1, T2>(arg0: &mut Voter, arg1: &mut 0x41efa3f778f47ad4938643e7f45a8cb0d78d4338ecd2c872e054d98b9a87af67::pool::Pool<T0, T1, T2>, arg2: &AdminCap) {
        assert!(arg0.version == 1, 0);
        *0x2::table::borrow_mut<0x2::object::ID, bool>(&mut arg0.is_alive, *0x2::linked_table::borrow<0x2::object::ID, 0x2::object::ID>(&arg0.gauges, 0x41efa3f778f47ad4938643e7f45a8cb0d78d4338ecd2c872e054d98b9a87af67::pool::id<T0, T1, T2>(arg1))) = true;
        0x41efa3f778f47ad4938643e7f45a8cb0d78d4338ecd2c872e054d98b9a87af67::pool::set_gauge_active<T0, T1, T2>(arg1, true);
    }

    public fun total_weight(arg0: &Voter, arg1: &0x41efa3f778f47ad4938643e7f45a8cb0d78d4338ecd2c872e054d98b9a87af67::minter::Minter) : u64 {
        *0x2::table::borrow<u64, u64>(&arg0.total_weights_per_epoch, 0x41efa3f778f47ad4938643e7f45a8cb0d78d4338ecd2c872e054d98b9a87af67::minter::active_period(arg1))
    }

    public fun total_weight_at(arg0: &Voter, arg1: u64) : u64 {
        if (!0x2::table::contains<u64, u64>(&arg0.total_weights_per_epoch, arg1)) {
            return 0
        };
        *0x2::table::borrow<u64, u64>(&arg0.total_weights_per_epoch, arg1)
    }

    fun update_for_after_distribution(arg0: &mut Voter, arg1: 0x2::object::ID, arg2: &0x41efa3f778f47ad4938643e7f45a8cb0d78d4338ecd2c872e054d98b9a87af67::minter::Minter) {
        let v0 = *0x2::table::borrow<0x2::object::ID, 0x2::object::ID>(&arg0.pool_for_gauge, arg1);
        let v1 = 0x41efa3f778f47ad4938643e7f45a8cb0d78d4338ecd2c872e054d98b9a87af67::minter::active_period(arg2) - 0x41efa3f778f47ad4938643e7f45a8cb0d78d4338ecd2c872e054d98b9a87af67::consts::WEEK();
        let v2 = 0;
        if (0x2::table::contains<u64, 0x2::table::Table<0x2::object::ID, u64>>(&arg0.weights_per_epoch, v1)) {
            if (0x2::table::contains<0x2::object::ID, u64>(0x2::table::borrow<u64, 0x2::table::Table<0x2::object::ID, u64>>(&arg0.weights_per_epoch, v1), v0)) {
                v2 = *0x2::table::borrow<0x2::object::ID, u64>(0x2::table::borrow<u64, 0x2::table::Table<0x2::object::ID, u64>>(&arg0.weights_per_epoch, v1), v0);
            };
        };
        if (!0x2::table::contains<0x2::object::ID, u64>(&arg0.claimable, arg1)) {
            0x2::table::add<0x2::object::ID, u64>(&mut arg0.claimable, arg1, 0);
        };
        if (v2 > 0) {
            let v3 = arg0.index;
            *0x2::table::borrow_mut<0x2::object::ID, u64>(&mut arg0.supply_index, arg1) = v3;
            let v4 = v3 - *0x2::table::borrow<0x2::object::ID, u64>(&arg0.supply_index, arg1);
            if (v4 > 0) {
                if (is_alive(arg0, v0)) {
                    *0x2::table::borrow_mut<0x2::object::ID, u64>(&mut arg0.claimable, arg1) = *0x2::table::borrow<0x2::object::ID, u64>(&arg0.claimable, arg1) + 0x41efa3f778f47ad4938643e7f45a8cb0d78d4338ecd2c872e054d98b9a87af67::amm_math::safe_mul_div_u64(v2, v4, 0x1::u64::pow(10, 9));
                };
            };
        } else {
            *0x2::table::borrow_mut<0x2::object::ID, u64>(&mut arg0.supply_index, arg1) = arg0.index;
        };
    }

    public fun user_votes(arg0: &Voter, arg1: 0x2::object::ID, arg2: &0x41efa3f778f47ad4938643e7f45a8cb0d78d4338ecd2c872e054d98b9a87af67::minter::Minter) : vector<UserVote> {
        let v0 = 0x1::vector::empty<UserVote>();
        if (!0x2::table::contains<0x2::object::ID, u64>(&arg0.last_voted, arg1)) {
            return v0
        };
        if (*0x2::table::borrow<0x2::object::ID, u64>(&arg0.last_voted, arg1) < 0x41efa3f778f47ad4938643e7f45a8cb0d78d4338ecd2c872e054d98b9a87af67::minter::active_period(arg2)) {
            return v0
        };
        if (0x2::table::contains<0x2::object::ID, 0x2::table_vec::TableVec<0x2::object::ID>>(&arg0.pool_vote, arg1)) {
            let v1 = 0x2::table::borrow<0x2::object::ID, 0x2::table_vec::TableVec<0x2::object::ID>>(&arg0.pool_vote, arg1);
            let v2 = 0x2::table::borrow<0x2::object::ID, 0x2::table::Table<0x2::object::ID, u64>>(&arg0.votes, arg1);
            let v3 = 0;
            while (v3 < 0x2::table_vec::length<0x2::object::ID>(v1)) {
                let v4 = *0x2::table_vec::borrow<0x2::object::ID>(v1, v3);
                if (0x2::table::contains<0x2::object::ID, u64>(v2, v4)) {
                    let v5 = *0x2::table::borrow<0x2::object::ID, u64>(v2, v4);
                    if (v5 > 0) {
                        let v6 = UserVote{
                            pool_id : v4,
                            weight  : v5,
                        };
                        0x1::vector::push_back<UserVote>(&mut v0, v6);
                    };
                };
                v3 = v3 + 1;
            };
        };
        v0
    }

    public fun vote(arg0: &mut Voter, arg1: &mut 0x41efa3f778f47ad4938643e7f45a8cb0d78d4338ecd2c872e054d98b9a87af67::voting_escrow::VotingEscrow, arg2: vector<0x2::object::ID>, arg3: vector<u64>, arg4: &mut 0x41efa3f778f47ad4938643e7f45a8cb0d78d4338ecd2c872e054d98b9a87af67::bribe_factory::BribeFactory, arg5: &0x41efa3f778f47ad4938643e7f45a8cb0d78d4338ecd2c872e054d98b9a87af67::minter::Minter, arg6: &0x2::clock::Clock, arg7: &mut 0x2::tx_context::TxContext) {
        vote_internal(arg0, arg1, arg2, arg3, arg4, arg5, arg6, arg7);
    }

    fun vote_(arg0: &mut Voter, arg1: &mut 0x41efa3f778f47ad4938643e7f45a8cb0d78d4338ecd2c872e054d98b9a87af67::voting_escrow::VotingEscrow, arg2: vector<0x2::object::ID>, arg3: vector<u64>, arg4: &mut 0x41efa3f778f47ad4938643e7f45a8cb0d78d4338ecd2c872e054d98b9a87af67::bribe_factory::BribeFactory, arg5: &0x41efa3f778f47ad4938643e7f45a8cb0d78d4338ecd2c872e054d98b9a87af67::minter::Minter, arg6: &0x2::clock::Clock, arg7: &mut 0x2::tx_context::TxContext) {
        assert!(arg0.version == 1, 0);
        reset_(arg0, arg1, arg4, arg5);
        let v0 = 0x1::vector::length<0x2::object::ID>(&arg2);
        let v1 = 0;
        let v2 = 0;
        let v3 = 0;
        let v4 = 0x41efa3f778f47ad4938643e7f45a8cb0d78d4338ecd2c872e054d98b9a87af67::minter::active_period(arg5);
        let v5 = 0;
        while (v5 < v0) {
            if (is_alive(arg0, *0x1::vector::borrow<0x2::object::ID>(&arg2, v5))) {
                v1 = v1 + *0x1::vector::borrow<u64>(&arg3, v5);
            };
            v5 = v5 + 1;
        };
        let v6 = 0;
        if (!0x2::table::contains<0x2::object::ID, 0x2::table_vec::TableVec<0x2::object::ID>>(&arg0.pool_vote, 0x41efa3f778f47ad4938643e7f45a8cb0d78d4338ecd2c872e054d98b9a87af67::voting_escrow::id(arg1))) {
            0x2::table::add<0x2::object::ID, 0x2::table_vec::TableVec<0x2::object::ID>>(&mut arg0.pool_vote, 0x41efa3f778f47ad4938643e7f45a8cb0d78d4338ecd2c872e054d98b9a87af67::voting_escrow::id(arg1), 0x2::table_vec::empty<0x2::object::ID>(arg7));
        };
        if (!0x2::table::contains<u64, 0x2::table::Table<0x2::object::ID, u64>>(&arg0.weights_per_epoch, v4)) {
            0x2::table::add<u64, 0x2::table::Table<0x2::object::ID, u64>>(&mut arg0.weights_per_epoch, v4, 0x2::table::new<0x2::object::ID, u64>(arg7));
        };
        if (!0x2::table::contains<0x2::object::ID, 0x2::table::Table<0x2::object::ID, u64>>(&arg0.votes, 0x41efa3f778f47ad4938643e7f45a8cb0d78d4338ecd2c872e054d98b9a87af67::voting_escrow::id(arg1))) {
            0x2::table::add<0x2::object::ID, 0x2::table::Table<0x2::object::ID, u64>>(&mut arg0.votes, 0x41efa3f778f47ad4938643e7f45a8cb0d78d4338ecd2c872e054d98b9a87af67::voting_escrow::id(arg1), 0x2::table::new<0x2::object::ID, u64>(arg7));
        };
        while (v6 < v0) {
            let v7 = *0x1::vector::borrow<0x2::object::ID>(&arg2, v6);
            if (is_alive(arg0, v7)) {
                let (v8, v9) = 0x41efa3f778f47ad4938643e7f45a8cb0d78d4338ecd2c872e054d98b9a87af67::bribe_factory::bribes_mut(arg4, *0x2::linked_table::borrow<0x2::object::ID, 0x2::object::ID>(&arg0.gauges, v7));
                let v10 = 0x41efa3f778f47ad4938643e7f45a8cb0d78d4338ecd2c872e054d98b9a87af67::amm_math::safe_mul_div_u64(*0x1::vector::borrow<u64>(&arg3, v6), 0x41efa3f778f47ad4938643e7f45a8cb0d78d4338ecd2c872e054d98b9a87af67::voting_escrow::balance_of_nft(arg1, arg6), v1);
                if (0x2::table::contains<0x2::object::ID, 0x2::table::Table<0x2::object::ID, u64>>(&arg0.votes, 0x41efa3f778f47ad4938643e7f45a8cb0d78d4338ecd2c872e054d98b9a87af67::voting_escrow::id(arg1))) {
                    if (0x2::table::contains<0x2::object::ID, u64>(0x2::table::borrow<0x2::object::ID, 0x2::table::Table<0x2::object::ID, u64>>(&arg0.votes, 0x41efa3f778f47ad4938643e7f45a8cb0d78d4338ecd2c872e054d98b9a87af67::voting_escrow::id(arg1)), v7)) {
                        assert!(*0x2::table::borrow<0x2::object::ID, u64>(0x2::table::borrow<0x2::object::ID, 0x2::table::Table<0x2::object::ID, u64>>(&arg0.votes, 0x41efa3f778f47ad4938643e7f45a8cb0d78d4338ecd2c872e054d98b9a87af67::voting_escrow::id(arg1)), v7) == 0, 11);
                    };
                };
                assert!(v10 > 0, 11);
                0x2::table_vec::push_back<0x2::object::ID>(0x2::table::borrow_mut<0x2::object::ID, 0x2::table_vec::TableVec<0x2::object::ID>>(&mut arg0.pool_vote, 0x41efa3f778f47ad4938643e7f45a8cb0d78d4338ecd2c872e054d98b9a87af67::voting_escrow::id(arg1)), v7);
                if (!0x2::table::contains<0x2::object::ID, u64>(0x2::table::borrow<u64, 0x2::table::Table<0x2::object::ID, u64>>(&arg0.weights_per_epoch, v4), v7)) {
                    0x2::table::add<0x2::object::ID, u64>(0x2::table::borrow_mut<u64, 0x2::table::Table<0x2::object::ID, u64>>(&mut arg0.weights_per_epoch, v4), v7, 0);
                };
                *0x2::table::borrow_mut<0x2::object::ID, u64>(0x2::table::borrow_mut<u64, 0x2::table::Table<0x2::object::ID, u64>>(&mut arg0.weights_per_epoch, v4), v7) = *0x2::table::borrow<0x2::object::ID, u64>(0x2::table::borrow<u64, 0x2::table::Table<0x2::object::ID, u64>>(&arg0.weights_per_epoch, v4), v7) + v10;
                if (0x2::table::contains<0x2::object::ID, u64>(0x2::table::borrow<0x2::object::ID, 0x2::table::Table<0x2::object::ID, u64>>(&arg0.votes, 0x41efa3f778f47ad4938643e7f45a8cb0d78d4338ecd2c872e054d98b9a87af67::voting_escrow::id(arg1)), v7)) {
                    *0x2::table::borrow_mut<0x2::object::ID, u64>(0x2::table::borrow_mut<0x2::object::ID, 0x2::table::Table<0x2::object::ID, u64>>(&mut arg0.votes, 0x41efa3f778f47ad4938643e7f45a8cb0d78d4338ecd2c872e054d98b9a87af67::voting_escrow::id(arg1)), v7) = v10;
                } else {
                    0x2::table::add<0x2::object::ID, u64>(0x2::table::borrow_mut<0x2::object::ID, 0x2::table::Table<0x2::object::ID, u64>>(&mut arg0.votes, 0x41efa3f778f47ad4938643e7f45a8cb0d78d4338ecd2c872e054d98b9a87af67::voting_escrow::id(arg1)), v7, v10);
                };
                0x41efa3f778f47ad4938643e7f45a8cb0d78d4338ecd2c872e054d98b9a87af67::bribe::deposit(v8, v10, arg1, arg5, arg7);
                0x41efa3f778f47ad4938643e7f45a8cb0d78d4338ecd2c872e054d98b9a87af67::bribe::deposit(v9, v10, arg1, arg5, arg7);
                v3 = v3 + v10;
                v2 = v2 + v10;
                let v11 = Voted{
                    lock_id : 0x41efa3f778f47ad4938643e7f45a8cb0d78d4338ecd2c872e054d98b9a87af67::voting_escrow::id(arg1),
                    weight  : v10,
                };
                0x2::event::emit<Voted>(v11);
            };
            v6 = v6 + 1;
        };
        if (v3 > 0) {
            0x41efa3f778f47ad4938643e7f45a8cb0d78d4338ecd2c872e054d98b9a87af67::voting_escrow::voting(arg1);
        };
        if (0x2::table::contains<u64, u64>(&arg0.total_weights_per_epoch, v4)) {
            *0x2::table::borrow_mut<u64, u64>(&mut arg0.total_weights_per_epoch, v4) = *0x2::table::borrow<u64, u64>(&arg0.total_weights_per_epoch, v4) + v2;
        } else {
            0x2::table::add<u64, u64>(&mut arg0.total_weights_per_epoch, v4, v2);
        };
    }

    fun vote_delay_(arg0: &Voter, arg1: &0x41efa3f778f47ad4938643e7f45a8cb0d78d4338ecd2c872e054d98b9a87af67::voting_escrow::VotingEscrow, arg2: &0x2::clock::Clock) {
        assert!(arg0.version == 1, 0);
        if (0x2::table::contains<0x2::object::ID, u64>(&arg0.last_voted, 0x41efa3f778f47ad4938643e7f45a8cb0d78d4338ecd2c872e054d98b9a87af67::voting_escrow::id(arg1))) {
            assert!(0x2::clock::timestamp_ms(arg2) > *0x2::table::borrow<0x2::object::ID, u64>(&arg0.last_voted, 0x41efa3f778f47ad4938643e7f45a8cb0d78d4338ecd2c872e054d98b9a87af67::voting_escrow::id(arg1)) + arg0.vote_delay, 11);
        };
        check_start_vote_window(arg0, arg2);
    }

    fun vote_internal(arg0: &mut Voter, arg1: &mut 0x41efa3f778f47ad4938643e7f45a8cb0d78d4338ecd2c872e054d98b9a87af67::voting_escrow::VotingEscrow, arg2: vector<0x2::object::ID>, arg3: vector<u64>, arg4: &mut 0x41efa3f778f47ad4938643e7f45a8cb0d78d4338ecd2c872e054d98b9a87af67::bribe_factory::BribeFactory, arg5: &0x41efa3f778f47ad4938643e7f45a8cb0d78d4338ecd2c872e054d98b9a87af67::minter::Minter, arg6: &0x2::clock::Clock, arg7: &mut 0x2::tx_context::TxContext) {
        assert!(arg0.version == 1, 0);
        vote_delay_(arg0, arg1, arg6);
        assert!(0x1::vector::length<0x2::object::ID>(&arg2) == 0x1::vector::length<u64>(&arg3), 11);
        vote_(arg0, arg1, arg2, arg3, arg4, arg5, arg6, arg7);
        if (0x2::table::contains<0x2::object::ID, u64>(&arg0.last_voted, 0x41efa3f778f47ad4938643e7f45a8cb0d78d4338ecd2c872e054d98b9a87af67::voting_escrow::id(arg1))) {
            *0x2::table::borrow_mut<0x2::object::ID, u64>(&mut arg0.last_voted, 0x41efa3f778f47ad4938643e7f45a8cb0d78d4338ecd2c872e054d98b9a87af67::voting_escrow::id(arg1)) = 0x41efa3f778f47ad4938643e7f45a8cb0d78d4338ecd2c872e054d98b9a87af67::minter::active_period(arg5) + 1000;
        } else {
            0x2::table::add<0x2::object::ID, u64>(&mut arg0.last_voted, 0x41efa3f778f47ad4938643e7f45a8cb0d78d4338ecd2c872e054d98b9a87af67::voting_escrow::id(arg1), 0x41efa3f778f47ad4938643e7f45a8cb0d78d4338ecd2c872e054d98b9a87af67::minter::active_period(arg5) + 1000);
        };
    }

    public fun weights(arg0: &Voter, arg1: 0x2::object::ID, arg2: &0x41efa3f778f47ad4938643e7f45a8cb0d78d4338ecd2c872e054d98b9a87af67::minter::Minter) : u64 {
        weights_at(arg0, arg1, 0x41efa3f778f47ad4938643e7f45a8cb0d78d4338ecd2c872e054d98b9a87af67::minter::active_period(arg2))
    }

    public fun weights_at(arg0: &Voter, arg1: 0x2::object::ID, arg2: u64) : u64 {
        if (!0x2::table::contains<u64, 0x2::table::Table<0x2::object::ID, u64>>(&arg0.weights_per_epoch, arg2)) {
            return 0
        };
        if (!0x2::table::contains<0x2::object::ID, u64>(0x2::table::borrow<u64, 0x2::table::Table<0x2::object::ID, u64>>(&arg0.weights_per_epoch, arg2), arg1)) {
            return 0
        };
        *0x2::table::borrow<0x2::object::ID, u64>(0x2::table::borrow<u64, 0x2::table::Table<0x2::object::ID, u64>>(&arg0.weights_per_epoch, arg2), arg1)
    }

    // decompiled from Move bytecode v6
}

