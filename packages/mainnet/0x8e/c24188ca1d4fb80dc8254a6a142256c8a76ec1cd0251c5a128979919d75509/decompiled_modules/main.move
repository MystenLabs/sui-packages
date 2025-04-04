module 0x8ec24188ca1d4fb80dc8254a6a142256c8a76ec1cd0251c5a128979919d75509::main {
    struct Leaderboard<phantom T0> has store, key {
        id: 0x2::object::UID,
        creator: address,
        reward: 0x2::balance::Balance<T0>,
        claimed_reward_amount: u64,
        max_leaderboard_size: u64,
        top_projects: vector<0x2::object::ID>,
        top_balances: vector<u64>,
        end_timestamp_ms: u64,
    }

    struct ProjectManager has store, key {
        id: 0x2::object::UID,
        projects: 0x2::bag::Bag,
    }

    struct Project<phantom T0> has store, key {
        id: 0x2::object::UID,
        leaderboard_id: 0x2::object::ID,
        balance: 0x2::balance::Balance<T0>,
    }

    struct ProjectOwnerCap<phantom T0> has store, key {
        id: 0x2::object::UID,
        project_id: 0x2::object::ID,
    }

    public fun check_out_project<T0>(arg0: &mut ProjectManager, arg1: &Leaderboard<T0>, arg2: 0x2::object::ID, arg3: &mut 0x2::tx_context::TxContext) {
        let v0 = 0x2::bag::borrow_mut<0x2::object::ID, Project<T0>>(&mut arg0.projects, arg2);
        0x2::transfer::public_transfer<0x2::coin::Coin<T0>>(0x2::coin::from_balance<T0>(0x2::balance::split<T0>(&mut v0.balance, 0x2::balance::value<T0>(&v0.balance)), arg3), arg1.creator);
    }

    public fun create_leaderboard<T0>(arg0: u64, arg1: 0x2::coin::Coin<T0>, arg2: &mut 0x2::tx_context::TxContext) {
        let v0 = Leaderboard<T0>{
            id                    : 0x2::object::new(arg2),
            creator               : 0x2::tx_context::sender(arg2),
            reward                : 0x2::coin::into_balance<T0>(arg1),
            claimed_reward_amount : 0,
            max_leaderboard_size  : 30,
            top_projects          : 0x1::vector::empty<0x2::object::ID>(),
            top_balances          : 0x1::vector::empty<u64>(),
            end_timestamp_ms      : arg0,
        };
        0x2::transfer::share_object<Leaderboard<T0>>(v0);
    }

    public fun create_project<T0>(arg0: &mut ProjectManager, arg1: &mut Leaderboard<T0>, arg2: 0x2::coin::Coin<T0>, arg3: &mut 0x2::tx_context::TxContext) : ProjectOwnerCap<T0> {
        let v0 = Project<T0>{
            id             : 0x2::object::new(arg3),
            leaderboard_id : 0x2::object::id<Leaderboard<T0>>(arg1),
            balance        : 0x2::coin::into_balance<T0>(arg2),
        };
        let v1 = 0x2::object::id<Project<T0>>(&v0);
        update_leaderboard<T0>(arg1, v1, 0x2::balance::value<T0>(&v0.balance));
        0x2::bag::add<0x2::object::ID, Project<T0>>(&mut arg0.projects, v1, v0);
        ProjectOwnerCap<T0>{
            id         : 0x2::object::new(arg3),
            project_id : v1,
        }
    }

    public fun deposit_reward<T0>(arg0: &mut Leaderboard<T0>, arg1: 0x2::coin::Coin<T0>, arg2: &0x2::clock::Clock, arg3: &mut 0x2::tx_context::TxContext) {
        assert!(0x2::tx_context::sender(arg3) == arg0.creator, 1);
        0x2::balance::join<T0>(&mut arg0.reward, 0x2::coin::into_balance<T0>(arg1));
        update_end_timestamp<T0>(arg0, 0x2::clock::timestamp_ms(arg2) + 259200000);
    }

    fun init(arg0: &mut 0x2::tx_context::TxContext) {
        let v0 = ProjectManager{
            id       : 0x2::object::new(arg0),
            projects : 0x2::bag::new(arg0),
        };
        0x2::transfer::share_object<ProjectManager>(v0);
    }

    public fun update_end_timestamp<T0>(arg0: &mut Leaderboard<T0>, arg1: u64) {
        assert!(arg1 > arg0.end_timestamp_ms, 1);
        arg0.end_timestamp_ms = arg1;
    }

    fun update_leaderboard<T0>(arg0: &mut Leaderboard<T0>, arg1: 0x2::object::ID, arg2: u64) {
        let (v0, v1) = 0x1::vector::index_of<0x2::object::ID>(&arg0.top_projects, &arg1);
        if (v0) {
            0x1::vector::remove<0x2::object::ID>(&mut arg0.top_projects, v1);
            0x1::vector::remove<u64>(&mut arg0.top_balances, v1);
        };
        let v2 = 0x1::vector::length<u64>(&arg0.top_balances) - 1;
        let v3 = v2;
        if (arg2 < *0x1::vector::borrow<u64>(&arg0.top_balances, v2) && 0x1::vector::length<u64>(&arg0.top_balances) < arg0.max_leaderboard_size) {
            0x1::vector::push_back<0x2::object::ID>(&mut arg0.top_projects, arg1);
            0x1::vector::push_back<u64>(&mut arg0.top_balances, arg2);
        } else if (arg2 > *0x1::vector::borrow<u64>(&arg0.top_balances, v2)) {
            loop {
                if (arg2 > *0x1::vector::borrow<u64>(&arg0.top_balances, v3)) {
                    break
                };
                let v4 = v3 - 1;
                v3 = v4;
                if (v4 == 0) {
                    break
                };
            };
            0x1::vector::insert<0x2::object::ID>(&mut arg0.top_projects, arg1, v3);
            0x1::vector::insert<u64>(&mut arg0.top_balances, arg2, v3);
            if (0x1::vector::length<u64>(&arg0.top_balances) >= arg0.max_leaderboard_size) {
                0x1::vector::pop_back<0x2::object::ID>(&mut arg0.top_projects);
                0x1::vector::pop_back<u64>(&mut arg0.top_balances);
            };
        };
    }

    public fun vote<T0>(arg0: &mut ProjectManager, arg1: &mut Leaderboard<T0>, arg2: 0x2::object::ID, arg3: 0x2::coin::Coin<T0>, arg4: &0x2::clock::Clock) {
        let v0 = 0x2::bag::borrow_mut<0x2::object::ID, Project<T0>>(&mut arg0.projects, arg2);
        assert!(0x2::clock::timestamp_ms(arg4) < arg1.end_timestamp_ms, 1);
        0x2::balance::join<T0>(&mut v0.balance, 0x2::coin::into_balance<T0>(arg3));
        update_leaderboard<T0>(arg1, 0x2::object::id<Project<T0>>(v0), 0x2::balance::value<T0>(&v0.balance));
    }

    public fun withdraw<T0>(arg0: &mut ProjectManager, arg1: ProjectOwnerCap<T0>, arg2: &mut Leaderboard<T0>, arg3: 0x2::object::ID, arg4: &0x2::clock::Clock, arg5: &mut 0x2::tx_context::TxContext) : 0x2::coin::Coin<T0> {
        let v0 = 0x2::bag::remove<0x2::object::ID, Project<T0>>(&mut arg0.projects, arg3);
        assert!(0x2::clock::timestamp_ms(arg4) > arg2.end_timestamp_ms && 0x2::object::id<Leaderboard<T0>>(arg2) == v0.leaderboard_id, 1);
        let Project {
            id             : v1,
            leaderboard_id : _,
            balance        : v3,
        } = v0;
        let v4 = v3;
        0x2::object::delete(v1);
        let ProjectOwnerCap {
            id         : v5,
            project_id : v6,
        } = arg1;
        let v7 = v6;
        0x2::object::delete(v5);
        let (v8, v9) = 0x1::vector::index_of<0x2::object::ID>(&arg2.top_projects, &v7);
        if (v8) {
            0x1::vector::remove<0x2::object::ID>(&mut arg2.top_projects, v9);
            0x1::vector::remove<u64>(&mut arg2.top_balances, v9);
            arg2.claimed_reward_amount = arg2.claimed_reward_amount + 1;
            0x2::balance::join<T0>(&mut v4, 0x2::balance::split<T0>(&mut arg2.reward, 0x2::balance::value<T0>(&arg2.reward) / (30 - arg2.claimed_reward_amount)));
        };
        0x2::coin::from_balance<T0>(v4, arg5)
    }

    public fun withdraw_reward<T0>(arg0: &mut Leaderboard<T0>, arg1: u64, arg2: &mut 0x2::tx_context::TxContext) : 0x2::coin::Coin<T0> {
        assert!(0x2::tx_context::sender(arg2) == arg0.creator, 1);
        0x2::coin::from_balance<T0>(0x2::balance::split<T0>(&mut arg0.reward, arg1), arg2)
    }

    // decompiled from Move bytecode v6
}

