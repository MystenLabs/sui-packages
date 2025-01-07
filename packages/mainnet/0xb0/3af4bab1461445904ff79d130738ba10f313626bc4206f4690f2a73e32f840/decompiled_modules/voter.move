module 0xb03af4bab1461445904ff79d130738ba10f313626bc4206f4690f2a73e32f840::voter {
    struct VoterCap has key {
        id: 0x2::object::UID,
    }

    struct Voter has store, key {
        id: 0x2::object::UID,
        version: u64,
        balance: 0x2::balance::Balance<0x788ceec9c41a9867307667269c80ba7bc67e8ee2d421b1bf1addada06812c78a::sdb::SDB>,
        total_weight: u64,
        pool_weights: 0x2::table::Table<0x2::object::ID, u64>,
        registry: 0x2::table::Table<0x2::object::ID, 0x2::object::ID>,
        index: u256,
    }

    struct VSDB has drop {
        dummy_field: bool,
    }

    struct VotingState has drop, store {
        pool_votes: 0x2::vec_map::VecMap<0x2::object::ID, u64>,
        voted: bool,
        used_weights: u64,
        last_voted: u64,
        unclaimed_rewards: 0x2::vec_map::VecMap<0x2::object::ID, 0x2::vec_set::VecSet<0x1::type_name::TypeName>>,
    }

    struct Potato {
        reset: bool,
        weights: 0x2::vec_map::VecMap<0x2::object::ID, u64>,
        used_weight: u64,
        total_weight: u64,
    }

    public fun voted(arg0: &0x788ceec9c41a9867307667269c80ba7bc67e8ee2d421b1bf1addada06812c78a::vsdb::Vsdb) : bool {
        voting_state_borrow(arg0).voted
    }

    fun assert_available_voting(arg0: u64) {
        assert!(arg0 >= vote_start(arg0) && arg0 <= vote_end(arg0), 104);
    }

    public entry fun claim_bribes<T0, T1, T2>(arg0: &mut 0xb03af4bab1461445904ff79d130738ba10f313626bc4206f4690f2a73e32f840::bribe::Bribe<T0, T1>, arg1: &mut 0xb03af4bab1461445904ff79d130738ba10f313626bc4206f4690f2a73e32f840::bribe::Rewards<T0, T1>, arg2: &mut 0x788ceec9c41a9867307667269c80ba7bc67e8ee2d421b1bf1addada06812c78a::vsdb::Vsdb, arg3: &0x2::clock::Clock, arg4: &mut 0x2::tx_context::TxContext) {
        0xb03af4bab1461445904ff79d130738ba10f313626bc4206f4690f2a73e32f840::bribe::get_reward<T0, T1, T2>(arg0, arg1, arg2, arg3, arg4);
        let v0 = voting_state_borrow_mut(arg2);
        let v1 = 0x2::object::id<0xb03af4bab1461445904ff79d130738ba10f313626bc4206f4690f2a73e32f840::bribe::Rewards<T0, T1>>(arg1);
        let v2 = 0x2::vec_map::get_mut<0x2::object::ID, 0x2::vec_set::VecSet<0x1::type_name::TypeName>>(&mut v0.unclaimed_rewards, &v1);
        let v3 = 0x1::type_name::get<T2>();
        0x2::vec_set::remove<0x1::type_name::TypeName>(v2, &v3);
        if (0x2::vec_set::is_empty<0x1::type_name::TypeName>(v2)) {
            let v4 = 0x2::object::id<0xb03af4bab1461445904ff79d130738ba10f313626bc4206f4690f2a73e32f840::bribe::Rewards<T0, T1>>(arg1);
            let (_, _) = 0x2::vec_map::remove<0x2::object::ID, 0x2::vec_set::VecSet<0x1::type_name::TypeName>>(&mut v0.unclaimed_rewards, &v4);
        };
    }

    public entry fun claim_rewards<T0, T1>(arg0: &mut Voter, arg1: &mut 0xb03af4bab1461445904ff79d130738ba10f313626bc4206f4690f2a73e32f840::gauge::Gauge<T0, T1>, arg2: &mut 0xb03af4bab1461445904ff79d130738ba10f313626bc4206f4690f2a73e32f840::gauge::Stake<T0, T1>, arg3: &0x2::clock::Clock, arg4: &mut 0x2::tx_context::TxContext) {
        assert!(arg0.version == 0xb03af4bab1461445904ff79d130738ba10f313626bc4206f4690f2a73e32f840::minter::package_version(), 1);
        0xb03af4bab1461445904ff79d130738ba10f313626bc4206f4690f2a73e32f840::gauge::get_reward<T0, T1>(arg1, arg2, arg3, arg4);
    }

    public fun clear(arg0: &mut 0x788ceec9c41a9867307667269c80ba7bc67e8ee2d421b1bf1addada06812c78a::vsdb::Vsdb) {
        let v0 = VSDB{dummy_field: false};
        let VotingState {
            pool_votes        : v1,
            voted             : v2,
            used_weights      : _,
            last_voted        : _,
            unclaimed_rewards : _,
        } = 0x788ceec9c41a9867307667269c80ba7bc67e8ee2d421b1bf1addada06812c78a::vsdb::df_remove<VSDB, VotingState>(v0, arg0);
        assert!(!v2, 102);
        0x2::vec_map::destroy_empty<0x2::object::ID, u64>(v1);
    }

    public entry fun create_gauge<T0, T1>(arg0: &mut Voter, arg1: &VoterCap, arg2: &0xdaf9d2d923b1c75f82870c17605163acd5f8aa172821f0356bf3fa4e5be7dad1::pool::Pool<T0, T1>, arg3: &mut 0x2::tx_context::TxContext) {
        assert!(arg0.version == 0xb03af4bab1461445904ff79d130738ba10f313626bc4206f4690f2a73e32f840::minter::package_version(), 1);
        let v0 = 0xb03af4bab1461445904ff79d130738ba10f313626bc4206f4690f2a73e32f840::gauge::new<T0, T1>(arg2, arg3);
        let v1 = 0x2::object::id<0xb03af4bab1461445904ff79d130738ba10f313626bc4206f4690f2a73e32f840::gauge::Gauge<T0, T1>>(&v0);
        0x2::table::add<0x2::object::ID, 0x2::object::ID>(&mut arg0.registry, 0x2::object::id<0xdaf9d2d923b1c75f82870c17605163acd5f8aa172821f0356bf3fa4e5be7dad1::pool::Pool<T0, T1>>(arg2), v1);
        0x2::table::add<0x2::object::ID, u64>(&mut arg0.pool_weights, 0x2::object::id<0xdaf9d2d923b1c75f82870c17605163acd5f8aa172821f0356bf3fa4e5be7dad1::pool::Pool<T0, T1>>(arg2), 0);
        0xb03af4bab1461445904ff79d130738ba10f313626bc4206f4690f2a73e32f840::gauge::update_voting_index<T0, T1>(&mut v0, arg0.index);
        0xb03af4bab1461445904ff79d130738ba10f313626bc4206f4690f2a73e32f840::event::gauge_created<T0, T1>(0x2::object::id<0xdaf9d2d923b1c75f82870c17605163acd5f8aa172821f0356bf3fa4e5be7dad1::pool::Pool<T0, T1>>(arg2), v1, 0xb03af4bab1461445904ff79d130738ba10f313626bc4206f4690f2a73e32f840::gauge::bribe_id<T0, T1>(&v0), 0xb03af4bab1461445904ff79d130738ba10f313626bc4206f4690f2a73e32f840::gauge::rewards_id<T0, T1>(&v0));
        0x2::transfer::public_share_object<0xb03af4bab1461445904ff79d130738ba10f313626bc4206f4690f2a73e32f840::gauge::Gauge<T0, T1>>(v0);
    }

    public entry fun deposit_sdb(arg0: &mut Voter, arg1: 0x2::coin::Coin<0x788ceec9c41a9867307667269c80ba7bc67e8ee2d421b1bf1addada06812c78a::sdb::SDB>) {
        assert!(arg0.version == 0xb03af4bab1461445904ff79d130738ba10f313626bc4206f4690f2a73e32f840::minter::package_version(), 1);
        let v0 = 0x2::coin::value<0x788ceec9c41a9867307667269c80ba7bc67e8ee2d421b1bf1addada06812c78a::sdb::SDB>(&arg1);
        let v1 = (v0 as u256) * 1000000000000000000 / (arg0.total_weight as u256);
        if (v1 > 0) {
            arg0.index = arg0.index + (v1 as u256);
        };
        0x2::coin::put<0x788ceec9c41a9867307667269c80ba7bc67e8ee2d421b1bf1addada06812c78a::sdb::SDB>(&mut arg0.balance, arg1);
        0xb03af4bab1461445904ff79d130738ba10f313626bc4206f4690f2a73e32f840::event::notify_reward<0x788ceec9c41a9867307667269c80ba7bc67e8ee2d421b1bf1addada06812c78a::sdb::SDB>(v0);
    }

    public entry fun distribute<T0, T1>(arg0: &mut Voter, arg1: &mut 0xb03af4bab1461445904ff79d130738ba10f313626bc4206f4690f2a73e32f840::minter::Minter, arg2: &mut 0xb03af4bab1461445904ff79d130738ba10f313626bc4206f4690f2a73e32f840::gauge::Gauge<T0, T1>, arg3: &mut 0xb03af4bab1461445904ff79d130738ba10f313626bc4206f4690f2a73e32f840::bribe::Rewards<T0, T1>, arg4: &mut 0xdaf9d2d923b1c75f82870c17605163acd5f8aa172821f0356bf3fa4e5be7dad1::pool::Pool<T0, T1>, arg5: &mut 0x788ceec9c41a9867307667269c80ba7bc67e8ee2d421b1bf1addada06812c78a::vsdb::VSDBRegistry, arg6: &0x2::clock::Clock, arg7: &mut 0x2::tx_context::TxContext) {
        assert!(arg0.version == 0xb03af4bab1461445904ff79d130738ba10f313626bc4206f4690f2a73e32f840::minter::package_version(), 1);
        let v0 = 0xb03af4bab1461445904ff79d130738ba10f313626bc4206f4690f2a73e32f840::minter::update_period(arg1, arg5, arg6, arg7);
        if (0x1::option::is_some<0x2::coin::Coin<0x788ceec9c41a9867307667269c80ba7bc67e8ee2d421b1bf1addada06812c78a::sdb::SDB>>(&v0)) {
            deposit_sdb(arg0, 0x1::option::extract<0x2::coin::Coin<0x788ceec9c41a9867307667269c80ba7bc67e8ee2d421b1bf1addada06812c78a::sdb::SDB>>(&mut v0));
        };
        0x1::option::destroy_none<0x2::coin::Coin<0x788ceec9c41a9867307667269c80ba7bc67e8ee2d421b1bf1addada06812c78a::sdb::SDB>>(v0);
        update_for<T0, T1>(arg0, arg2, arg1);
        let v1 = 0xb03af4bab1461445904ff79d130738ba10f313626bc4206f4690f2a73e32f840::gauge::claimable<T0, T1>(arg2);
        if (v1 > 0xb03af4bab1461445904ff79d130738ba10f313626bc4206f4690f2a73e32f840::gauge::left<T0, T1>(arg2, arg6) && v1 > 604800) {
            0xb03af4bab1461445904ff79d130738ba10f313626bc4206f4690f2a73e32f840::gauge::update_claimable<T0, T1>(arg2, 0);
            0xb03af4bab1461445904ff79d130738ba10f313626bc4206f4690f2a73e32f840::gauge::distribute_emissions<T0, T1>(arg2, arg3, arg4, 0x2::coin::take<0x788ceec9c41a9867307667269c80ba7bc67e8ee2d421b1bf1addada06812c78a::sdb::SDB>(&mut arg0.balance, v1, arg7), arg6, arg7);
        };
    }

    public fun index(arg0: &Voter) : u256 {
        arg0.index
    }

    fun init(arg0: &mut 0x2::tx_context::TxContext) {
        let v0 = Voter{
            id           : 0x2::object::new(arg0),
            version      : 0xb03af4bab1461445904ff79d130738ba10f313626bc4206f4690f2a73e32f840::minter::package_version(),
            balance      : 0x2::balance::zero<0x788ceec9c41a9867307667269c80ba7bc67e8ee2d421b1bf1addada06812c78a::sdb::SDB>(),
            total_weight : 0,
            pool_weights : 0x2::table::new<0x2::object::ID, u64>(arg0),
            registry     : 0x2::table::new<0x2::object::ID, 0x2::object::ID>(arg0),
            index        : 0,
        };
        0x2::transfer::share_object<Voter>(v0);
        let v1 = VoterCap{id: 0x2::object::new(arg0)};
        0x2::transfer::transfer<VoterCap>(v1, 0x2::tx_context::sender(arg0));
    }

    public entry fun initialize(arg0: &0x788ceec9c41a9867307667269c80ba7bc67e8ee2d421b1bf1addada06812c78a::vsdb::VSDBRegistry, arg1: &mut 0x788ceec9c41a9867307667269c80ba7bc67e8ee2d421b1bf1addada06812c78a::vsdb::Vsdb) {
        let v0 = VotingState{
            pool_votes        : 0x2::vec_map::empty<0x2::object::ID, u64>(),
            voted             : false,
            used_weights      : 0,
            last_voted        : 0,
            unclaimed_rewards : 0x2::vec_map::empty<0x2::object::ID, 0x2::vec_set::VecSet<0x1::type_name::TypeName>>(),
        };
        let v1 = VSDB{dummy_field: false};
        0x788ceec9c41a9867307667269c80ba7bc67e8ee2d421b1bf1addada06812c78a::vsdb::df_add<VSDB, VotingState>(v1, arg0, arg1, v0);
    }

    public fun is_initialized(arg0: &0x788ceec9c41a9867307667269c80ba7bc67e8ee2d421b1bf1addada06812c78a::vsdb::Vsdb) : bool {
        let v0 = VSDB{dummy_field: false};
        0x788ceec9c41a9867307667269c80ba7bc67e8ee2d421b1bf1addada06812c78a::vsdb::df_exists<VSDB>(arg0, v0)
    }

    public fun is_registry<T0, T1>(arg0: &Voter, arg1: &0xdaf9d2d923b1c75f82870c17605163acd5f8aa172821f0356bf3fa4e5be7dad1::pool::Pool<T0, T1>) : bool {
        0x2::table::contains<0x2::object::ID, 0x2::object::ID>(&arg0.registry, 0x2::object::id<0xdaf9d2d923b1c75f82870c17605163acd5f8aa172821f0356bf3fa4e5be7dad1::pool::Pool<T0, T1>>(arg1))
    }

    public entry fun kill_gauge<T0, T1>(arg0: &VoterCap, arg1: &mut Voter, arg2: &mut 0xb03af4bab1461445904ff79d130738ba10f313626bc4206f4690f2a73e32f840::gauge::Gauge<T0, T1>, arg3: &mut 0xb03af4bab1461445904ff79d130738ba10f313626bc4206f4690f2a73e32f840::minter::Minter) {
        assert!(0xb03af4bab1461445904ff79d130738ba10f313626bc4206f4690f2a73e32f840::gauge::is_alive<T0, T1>(arg2), 105);
        0xb03af4bab1461445904ff79d130738ba10f313626bc4206f4690f2a73e32f840::gauge::update_is_alive<T0, T1>(arg2, false);
        let v0 = 0xb03af4bab1461445904ff79d130738ba10f313626bc4206f4690f2a73e32f840::gauge::claimable<T0, T1>(arg2);
        if (v0 > 0) {
            0xb03af4bab1461445904ff79d130738ba10f313626bc4206f4690f2a73e32f840::gauge::update_claimable<T0, T1>(arg2, 0);
            0xb03af4bab1461445904ff79d130738ba10f313626bc4206f4690f2a73e32f840::minter::join(arg3, 0x2::balance::split<0x788ceec9c41a9867307667269c80ba7bc67e8ee2d421b1bf1addada06812c78a::sdb::SDB>(&mut arg1.balance, v0));
        };
        0xb03af4bab1461445904ff79d130738ba10f313626bc4206f4690f2a73e32f840::gauge::update_is_alive<T0, T1>(arg2, false);
    }

    public fun last_voted(arg0: &0x788ceec9c41a9867307667269c80ba7bc67e8ee2d421b1bf1addada06812c78a::vsdb::Vsdb) : u64 {
        voting_state_borrow(arg0).last_voted
    }

    public entry fun new_reward<T0, T1, T2>(arg0: &VoterCap, arg1: &mut 0xb03af4bab1461445904ff79d130738ba10f313626bc4206f4690f2a73e32f840::bribe::Rewards<T0, T1>, arg2: &mut 0x2::tx_context::TxContext) {
        0xb03af4bab1461445904ff79d130738ba10f313626bc4206f4690f2a73e32f840::bribe::new_reward_<T0, T1, T2>(arg1, arg2);
    }

    public fun pool_votes(arg0: &0x788ceec9c41a9867307667269c80ba7bc67e8ee2d421b1bf1addada06812c78a::vsdb::Vsdb, arg1: &0x2::object::ID) : u64 {
        let v0 = 0x2::vec_map::try_get<0x2::object::ID, u64>(&voting_state_borrow(arg0).pool_votes, arg1);
        if (0x1::option::is_some<u64>(&v0)) {
            0x1::option::destroy_some<u64>(v0)
        } else {
            0x1::option::destroy_none<u64>(v0);
            0
        }
    }

    public fun pool_weights<T0, T1>(arg0: &Voter, arg1: &0xdaf9d2d923b1c75f82870c17605163acd5f8aa172821f0356bf3fa4e5be7dad1::pool::Pool<T0, T1>) : u64 {
        *0x2::table::borrow<0x2::object::ID, u64>(&arg0.pool_weights, 0x2::object::id<0xdaf9d2d923b1c75f82870c17605163acd5f8aa172821f0356bf3fa4e5be7dad1::pool::Pool<T0, T1>>(arg1))
    }

    public fun reset_<T0, T1>(arg0: Potato, arg1: &mut Voter, arg2: &mut 0xb03af4bab1461445904ff79d130738ba10f313626bc4206f4690f2a73e32f840::minter::Minter, arg3: &mut 0x788ceec9c41a9867307667269c80ba7bc67e8ee2d421b1bf1addada06812c78a::vsdb::Vsdb, arg4: &mut 0xb03af4bab1461445904ff79d130738ba10f313626bc4206f4690f2a73e32f840::gauge::Gauge<T0, T1>, arg5: &mut 0xb03af4bab1461445904ff79d130738ba10f313626bc4206f4690f2a73e32f840::bribe::Bribe<T0, T1>, arg6: &0x2::clock::Clock) : Potato {
        assert!(arg1.version == 0xb03af4bab1461445904ff79d130738ba10f313626bc4206f4690f2a73e32f840::minter::package_version(), 1);
        assert!(!arg0.reset, 102);
        let v0 = 0xb03af4bab1461445904ff79d130738ba10f313626bc4206f4690f2a73e32f840::gauge::pool_id<T0, T1>(arg4);
        if (0x2::vec_map::contains<0x2::object::ID, u64>(&arg0.weights, &v0) && arg0.total_weight == 0) {
            let (v1, v2) = 0x2::vec_map::remove<0x2::object::ID, u64>(&mut arg0.weights, &v0);
            assert!(v2 > 0, 102);
            update_for<T0, T1>(arg1, arg4, arg2);
            *0x2::table::borrow_mut<0x2::object::ID, u64>(&mut arg1.pool_weights, v1) = *0x2::table::borrow<0x2::object::ID, u64>(&arg1.pool_weights, v1) - v2;
            0xb03af4bab1461445904ff79d130738ba10f313626bc4206f4690f2a73e32f840::bribe::revoke<T0, T1>(arg5, arg3, v2, arg6);
            0xb03af4bab1461445904ff79d130738ba10f313626bc4206f4690f2a73e32f840::event::abstain<T0, T1>(0x2::object::id<0x788ceec9c41a9867307667269c80ba7bc67e8ee2d421b1bf1addada06812c78a::vsdb::Vsdb>(arg3), v2);
            arg0.used_weight = arg0.used_weight + v2;
        };
        arg0
    }

    public fun reset_exit(arg0: Potato, arg1: &mut Voter, arg2: &mut 0x788ceec9c41a9867307667269c80ba7bc67e8ee2d421b1bf1addada06812c78a::vsdb::Vsdb) {
        let v0 = voting_state_borrow_mut(arg2);
        let Potato {
            reset        : v1,
            weights      : v2,
            used_weight  : v3,
            total_weight : v4,
        } = arg0;
        let v5 = v2;
        assert!(!v1 && v4 == 0 && 0x2::vec_map::size<0x2::object::ID, u64>(&v5) == 0, 102);
        v0.used_weights = 0;
        v0.voted = false;
        arg1.total_weight = arg1.total_weight - v3;
    }

    public entry fun revive_gauge<T0, T1>(arg0: &VoterCap, arg1: &mut 0xb03af4bab1461445904ff79d130738ba10f313626bc4206f4690f2a73e32f840::gauge::Gauge<T0, T1>) {
        assert!(0xb03af4bab1461445904ff79d130738ba10f313626bc4206f4690f2a73e32f840::gauge::is_alive<T0, T1>(arg1), 106);
        0xb03af4bab1461445904ff79d130738ba10f313626bc4206f4690f2a73e32f840::gauge::update_is_alive<T0, T1>(arg1, true);
    }

    public fun round_down_week(arg0: u64) : u64 {
        arg0 / 604800 * 604800
    }

    public fun sdb_balance(arg0: &Voter) : u64 {
        0x2::balance::value<0x788ceec9c41a9867307667269c80ba7bc67e8ee2d421b1bf1addada06812c78a::sdb::SDB>(&arg0.balance)
    }

    public fun total_weight(arg0: &Voter) : u64 {
        arg0.total_weight
    }

    public fun unix_timestamp(arg0: &0x2::clock::Clock) : u64 {
        0x2::clock::timestamp_ms(arg0) / 1000
    }

    public entry fun update_for<T0, T1>(arg0: &mut Voter, arg1: &mut 0xb03af4bab1461445904ff79d130738ba10f313626bc4206f4690f2a73e32f840::gauge::Gauge<T0, T1>, arg2: &mut 0xb03af4bab1461445904ff79d130738ba10f313626bc4206f4690f2a73e32f840::minter::Minter) {
        assert!(arg0.version == 0xb03af4bab1461445904ff79d130738ba10f313626bc4206f4690f2a73e32f840::minter::package_version(), 1);
        let v0 = *0x2::table::borrow<0x2::object::ID, u64>(&arg0.pool_weights, 0xb03af4bab1461445904ff79d130738ba10f313626bc4206f4690f2a73e32f840::gauge::pool_id<T0, T1>(arg1));
        if (v0 > 0) {
            let v1 = arg0.index - 0xb03af4bab1461445904ff79d130738ba10f313626bc4206f4690f2a73e32f840::gauge::voting_index<T0, T1>(arg1);
            if (v1 > 0) {
                if (0xb03af4bab1461445904ff79d130738ba10f313626bc4206f4690f2a73e32f840::gauge::is_alive<T0, T1>(arg1)) {
                    0xb03af4bab1461445904ff79d130738ba10f313626bc4206f4690f2a73e32f840::gauge::update_claimable<T0, T1>(arg1, (((v0 as u256) * (v1 as u256) / 1000000000000000000) as u64) + 0xb03af4bab1461445904ff79d130738ba10f313626bc4206f4690f2a73e32f840::gauge::claimable<T0, T1>(arg1));
                } else {
                    0xb03af4bab1461445904ff79d130738ba10f313626bc4206f4690f2a73e32f840::minter::join(arg2, 0x2::balance::split<0x788ceec9c41a9867307667269c80ba7bc67e8ee2d421b1bf1addada06812c78a::sdb::SDB>(&mut arg0.balance, (((v0 as u256) * (v1 as u256) / 1000000000000000000) as u64)));
                };
            };
        };
        0xb03af4bab1461445904ff79d130738ba10f313626bc4206f4690f2a73e32f840::gauge::update_voting_index<T0, T1>(arg1, arg0.index);
    }

    public fun used_weights(arg0: &0x788ceec9c41a9867307667269c80ba7bc67e8ee2d421b1bf1addada06812c78a::vsdb::Vsdb) : u64 {
        voting_state_borrow(arg0).used_weights
    }

    public fun vote_<T0, T1>(arg0: Potato, arg1: &mut Voter, arg2: &mut 0xb03af4bab1461445904ff79d130738ba10f313626bc4206f4690f2a73e32f840::minter::Minter, arg3: &mut 0x788ceec9c41a9867307667269c80ba7bc67e8ee2d421b1bf1addada06812c78a::vsdb::Vsdb, arg4: &mut 0xb03af4bab1461445904ff79d130738ba10f313626bc4206f4690f2a73e32f840::gauge::Gauge<T0, T1>, arg5: &mut 0xb03af4bab1461445904ff79d130738ba10f313626bc4206f4690f2a73e32f840::bribe::Bribe<T0, T1>, arg6: &0xb03af4bab1461445904ff79d130738ba10f313626bc4206f4690f2a73e32f840::bribe::Rewards<T0, T1>, arg7: &0x2::clock::Clock) : Potato {
        assert!(arg1.version == 0xb03af4bab1461445904ff79d130738ba10f313626bc4206f4690f2a73e32f840::minter::package_version(), 1);
        assert!(arg0.reset, 103);
        assert!(0xb03af4bab1461445904ff79d130738ba10f313626bc4206f4690f2a73e32f840::gauge::is_alive<T0, T1>(arg4), 105);
        let v0 = 0xb03af4bab1461445904ff79d130738ba10f313626bc4206f4690f2a73e32f840::gauge::pool_id<T0, T1>(arg4);
        if (0x2::vec_map::contains<0x2::object::ID, u64>(&arg0.weights, &v0)) {
            let (_, v2) = 0x2::vec_map::remove<0x2::object::ID, u64>(&mut arg0.weights, &v0);
            assert!(v2 > 0, 103);
            let v3 = (((v2 as u256) * (0x788ceec9c41a9867307667269c80ba7bc67e8ee2d421b1bf1addada06812c78a::vsdb::voting_weight(arg3, arg7) as u256) / (arg0.total_weight as u256)) as u64);
            assert!(v3 > 0, 100);
            update_for<T0, T1>(arg1, arg4, arg2);
            let v4 = voting_state_borrow_mut(arg3);
            0x2::vec_map::insert<0x2::object::ID, u64>(&mut v4.pool_votes, v0, v3);
            *0x2::table::borrow_mut<0x2::object::ID, u64>(&mut arg1.pool_weights, v0) = *0x2::table::borrow<0x2::object::ID, u64>(&arg1.pool_weights, v0) + v3;
            let v5 = 0xb03af4bab1461445904ff79d130738ba10f313626bc4206f4690f2a73e32f840::gauge::rewards_id<T0, T1>(arg4);
            if (0x2::vec_map::contains<0x2::object::ID, 0x2::vec_set::VecSet<0x1::type_name::TypeName>>(&v4.unclaimed_rewards, &v5)) {
                let (_, _) = 0x2::vec_map::remove<0x2::object::ID, 0x2::vec_set::VecSet<0x1::type_name::TypeName>>(&mut v4.unclaimed_rewards, &v5);
            };
            0x2::vec_map::insert<0x2::object::ID, 0x2::vec_set::VecSet<0x1::type_name::TypeName>>(&mut v4.unclaimed_rewards, v5, 0xb03af4bab1461445904ff79d130738ba10f313626bc4206f4690f2a73e32f840::bribe::rewards_type<T0, T1>(arg6));
            0xb03af4bab1461445904ff79d130738ba10f313626bc4206f4690f2a73e32f840::bribe::cast<T0, T1>(arg5, arg3, v3, arg7);
            arg0.used_weight = arg0.used_weight + v3;
            0xb03af4bab1461445904ff79d130738ba10f313626bc4206f4690f2a73e32f840::event::voted<T0, T1>(0x2::object::id<0x788ceec9c41a9867307667269c80ba7bc67e8ee2d421b1bf1addada06812c78a::vsdb::Vsdb>(arg3), v3);
        };
        arg0
    }

    public fun vote_end(arg0: u64) : u64 {
        round_down_week(arg0) + 604800 - 3600
    }

    public fun vote_entry(arg0: Potato, arg1: &mut Voter, arg2: &0x788ceec9c41a9867307667269c80ba7bc67e8ee2d421b1bf1addada06812c78a::vsdb::Vsdb, arg3: vector<address>, arg4: vector<u64>) : Potato {
        assert!(arg0.total_weight == 0 && 0x2::vec_map::size<0x2::object::ID, u64>(&arg0.weights) == 0, 102);
        assert!(0x1::vector::length<address>(&arg3) == 0x1::vector::length<u64>(&arg4), 103);
        arg1.total_weight = arg1.total_weight - arg0.used_weight;
        let v0 = 0;
        let v1 = 0;
        while (v1 < 0x1::vector::length<u64>(&arg4)) {
            let v2 = 0x1::vector::pop_back<u64>(&mut arg4);
            let v3 = v2 + v2 * ((0x788ceec9c41a9867307667269c80ba7bc67e8ee2d421b1bf1addada06812c78a::vsdb::level(arg2) % 2) as u64) / 10000;
            v0 = v0 + v3;
            0x2::vec_map::insert<0x2::object::ID, u64>(&mut arg0.weights, 0x2::object::id_from_address(0x1::vector::pop_back<address>(&mut arg3)), v3);
            v1 = v1 + 1;
        };
        arg0.used_weight = 0;
        arg0.total_weight = v0;
        arg0.reset = true;
        arg0
    }

    public fun vote_exit(arg0: Potato, arg1: &mut Voter, arg2: &mut 0x788ceec9c41a9867307667269c80ba7bc67e8ee2d421b1bf1addada06812c78a::vsdb::Vsdb) {
        let Potato {
            reset        : v0,
            weights      : v1,
            used_weight  : v2,
            total_weight : _,
        } = arg0;
        let v4 = v1;
        assert!(v0 && 0x2::vec_map::size<0x2::object::ID, u64>(&v4) == 0, 103);
        let v5 = VSDB{dummy_field: false};
        0x788ceec9c41a9867307667269c80ba7bc67e8ee2d421b1bf1addada06812c78a::vsdb::earn_xp<VSDB>(v5, arg2, 10);
        let v6 = voting_state_borrow_mut(arg2);
        v6.used_weights = v2;
        v6.voted = true;
        arg1.total_weight = arg1.total_weight + v2;
    }

    public fun vote_start(arg0: u64) : u64 {
        round_down_week(arg0) + 3600
    }

    public fun voting_entry(arg0: &mut 0x788ceec9c41a9867307667269c80ba7bc67e8ee2d421b1bf1addada06812c78a::vsdb::Vsdb, arg1: &0x2::clock::Clock) : Potato {
        let v0 = unix_timestamp(arg1);
        assert_available_voting(v0);
        let v1 = voting_state_borrow_mut(arg0);
        assert!(v0 / 604800 * 604800 > v1.last_voted, 101);
        v1.last_voted = v0;
        v1.pool_votes = 0x2::vec_map::empty<0x2::object::ID, u64>();
        Potato{
            reset        : false,
            weights      : v1.pool_votes,
            used_weight  : 0,
            total_weight : 0,
        }
    }

    public fun voting_state_borrow(arg0: &0x788ceec9c41a9867307667269c80ba7bc67e8ee2d421b1bf1addada06812c78a::vsdb::Vsdb) : &VotingState {
        let v0 = VSDB{dummy_field: false};
        0x788ceec9c41a9867307667269c80ba7bc67e8ee2d421b1bf1addada06812c78a::vsdb::df_borrow<VSDB, VotingState>(arg0, v0)
    }

    fun voting_state_borrow_mut(arg0: &mut 0x788ceec9c41a9867307667269c80ba7bc67e8ee2d421b1bf1addada06812c78a::vsdb::Vsdb) : &mut VotingState {
        let v0 = VSDB{dummy_field: false};
        0x788ceec9c41a9867307667269c80ba7bc67e8ee2d421b1bf1addada06812c78a::vsdb::df_borrow_mut<VSDB, VotingState>(arg0, v0)
    }

    // decompiled from Move bytecode v6
}

