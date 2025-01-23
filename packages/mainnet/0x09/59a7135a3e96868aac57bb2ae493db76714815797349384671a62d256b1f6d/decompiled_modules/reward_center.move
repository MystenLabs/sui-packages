module 0x959a7135a3e96868aac57bb2ae493db76714815797349384671a62d256b1f6d::reward_center {
    struct RewardState<phantom T0> has store {
        total_weights: u64,
        reward: 0x2::balance::Balance<T0>,
        total_rewards: u64,
        votes: 0x2::table::Table<0x2::object::ID, u64>,
    }

    struct RewardCenter<phantom T0, phantom T1, phantom T2> has store, key {
        id: 0x2::object::UID,
        versions: 0x2::vec_set::VecSet<u64>,
        claimable: bool,
        voting_states: 0x2::table::Table<u64, RewardState<T2>>,
        last_claimed: 0x2::table::Table<0x2::object::ID, u64>,
        offset: u64,
        start_epoch: u64,
    }

    struct NewCenter<phantom T0> has copy, drop {
        center_id: 0x2::object::ID,
        token_type: 0x1::ascii::String,
        reward_type: 0x1::ascii::String,
        claimable: bool,
        offset: u64,
    }

    struct Supply<phantom T0> has copy, drop {
        center_id: 0x2::object::ID,
        token_type: 0x1::ascii::String,
        reward_type: 0x1::ascii::String,
        amount: u64,
    }

    struct CheckIn<phantom T0> has copy, drop {
        center_id: 0x2::object::ID,
        proof_id: 0x2::object::ID,
        token_type: 0x1::ascii::String,
        reward_type: 0x1::ascii::String,
        voting_weight: u64,
    }

    struct Claim<phantom T0> has copy, drop {
        center_id: 0x2::object::ID,
        proof_id: 0x2::object::ID,
        token_type: 0x1::ascii::String,
        reward_type: 0x1::ascii::String,
        amount: u64,
    }

    public fun new<T0, T1, T2>(arg0: &0x6104e610f707fe5f1b3f34aa274c113a6b0523e63d5fb2069710e1c2d1f1fd1c::de_center::AdminCap<T1>, arg1: u64, arg2: &0x2::clock::Clock, arg3: bool, arg4: &mut 0x2::tx_context::TxContext) : RewardCenter<T0, T1, T2> {
        let (v0, _) = get_weekly_epoch_time(0x2::clock::timestamp_ms(arg2), arg1);
        let v2 = RewardCenter<T0, T1, T2>{
            id            : 0x2::object::new(arg4),
            versions      : 0x2::vec_set::singleton<u64>(package_version()),
            claimable     : arg3,
            voting_states : 0x2::table::new<u64, RewardState<T2>>(arg4),
            last_claimed  : 0x2::table::new<0x2::object::ID, u64>(arg4),
            offset        : arg1,
            start_epoch   : v0,
        };
        let v3 = NewCenter<T1>{
            center_id   : 0x2::object::id<RewardCenter<T0, T1, T2>>(&v2),
            token_type  : 0x1::type_name::into_string(0x1::type_name::get<T0>()),
            reward_type : 0x1::type_name::into_string(0x1::type_name::get<T2>()),
            claimable   : arg3,
            offset      : arg1,
        };
        0x2::event::emit<NewCenter<T1>>(v3);
        v2
    }

    fun add_voting_state_if_not_exists<T0, T1, T2>(arg0: &mut RewardCenter<T0, T1, T2>, arg1: &0x2::clock::Clock, arg2: &mut 0x2::tx_context::TxContext) {
        let (v0, _) = get_weekly_epoch_time(0x2::clock::timestamp_ms(arg1), arg0.offset);
        if (!0x2::table::contains<u64, RewardState<T2>>(&arg0.voting_states, v0)) {
            0x2::table::add<u64, RewardState<T2>>(&mut arg0.voting_states, v0, default_voting_state<T2>(arg2));
        };
    }

    fun assert_fresh_vote<T0, T1, T2>(arg0: &RewardCenter<T0, T1, T2>, arg1: &0x959a7135a3e96868aac57bb2ae493db76714815797349384671a62d256b1f6d::de_wrapper::DeWrapper<T0, T1>, arg2: &0x2::clock::Clock) {
        if (0x2::table::contains<0x2::object::ID, u64>(&get_current_voting_state<T0, T1, T2>(arg0, arg2).votes, 0x2::object::id<0x959a7135a3e96868aac57bb2ae493db76714815797349384671a62d256b1f6d::de_wrapper::DeWrapper<T0, T1>>(arg1))) {
            err_already_checked_in();
        };
    }

    fun assert_version<T0, T1, T2>(arg0: &RewardCenter<T0, T1, T2>) {
        let v0 = package_version();
        if (!0x2::vec_set::contains<u64>(&arg0.versions, &v0)) {
            err_invalid_package_version();
        };
    }

    public fun check_in<T0, T1, T2>(arg0: &mut RewardCenter<T0, T1, T2>, arg1: &0x959a7135a3e96868aac57bb2ae493db76714815797349384671a62d256b1f6d::de_wrapper::DeWrapper<T0, T1>, arg2: &0x2::clock::Clock, arg3: &mut 0x2::tx_context::TxContext) {
        assert_version<T0, T1, T2>(arg0);
        add_voting_state_if_not_exists<T0, T1, T2>(arg0, arg2, arg3);
        assert_fresh_vote<T0, T1, T2>(arg0, arg1, arg2);
        let v0 = get_current_voting_state_mut<T0, T1, T2>(arg0, arg2);
        let v1 = 0x959a7135a3e96868aac57bb2ae493db76714815797349384671a62d256b1f6d::de_wrapper::total_voting_weight<T0, T1>(arg1, arg2);
        0x2::table::add<0x2::object::ID, u64>(&mut v0.votes, 0x2::object::id<0x959a7135a3e96868aac57bb2ae493db76714815797349384671a62d256b1f6d::de_wrapper::DeWrapper<T0, T1>>(arg1), v1);
        v0.total_weights = v0.total_weights + v1;
        let v2 = CheckIn<T1>{
            center_id     : 0x2::object::id<RewardCenter<T0, T1, T2>>(arg0),
            proof_id      : 0x2::object::id<0x959a7135a3e96868aac57bb2ae493db76714815797349384671a62d256b1f6d::de_wrapper::DeWrapper<T0, T1>>(arg1),
            token_type    : 0x1::type_name::into_string(0x1::type_name::get<T0>()),
            reward_type   : 0x1::type_name::into_string(0x1::type_name::get<T2>()),
            voting_weight : v1,
        };
        0x2::event::emit<CheckIn<T1>>(v2);
    }

    public fun claim<T0, T1, T2>(arg0: &mut RewardCenter<T0, T1, T2>, arg1: &0x959a7135a3e96868aac57bb2ae493db76714815797349384671a62d256b1f6d::de_wrapper::DeWrapper<T0, T1>, arg2: &0x2::clock::Clock) : 0x2::balance::Balance<T2> {
        assert_version<T0, T1, T2>(arg0);
        if (arg0.claimable) {
            let v1 = 0x2::object::id<0x959a7135a3e96868aac57bb2ae493db76714815797349384671a62d256b1f6d::de_wrapper::DeWrapper<T0, T1>>(arg1);
            let v2 = if (0x2::table::contains<0x2::object::ID, u64>(&arg0.last_claimed, v1)) {
                *0x2::table::borrow<0x2::object::ID, u64>(&arg0.last_claimed, v1) + 1
            } else {
                start_epoch<T0, T1, T2>(arg0)
            };
            let (v3, _) = get_current_epoch_time<T0, T1, T2>(arg0, arg2);
            let v5 = 0x2::balance::zero<T2>();
            let v6 = v2;
            while (v6 < v3) {
                if (0x2::table::contains<u64, RewardState<T2>>(&arg0.voting_states, v6)) {
                    let v7 = 0x2::table::borrow_mut<u64, RewardState<T2>>(&mut arg0.voting_states, v6);
                    0x2::balance::join<T2>(&mut v5, 0x2::balance::split<T2>(&mut v7.reward, get_rewards_by_epoch<T2>(v7, v1)));
                };
                v6 = v6 + 1;
            };
            if (0x2::table::contains<0x2::object::ID, u64>(&arg0.last_claimed, v1)) {
                *0x2::table::borrow_mut<0x2::object::ID, u64>(&mut arg0.last_claimed, v1) = v3 - 1;
            } else {
                0x2::table::add<0x2::object::ID, u64>(&mut arg0.last_claimed, v1, v3 - 1);
            };
            let v8 = Claim<T1>{
                center_id   : 0x2::object::id<RewardCenter<T0, T1, T2>>(arg0),
                proof_id    : 0x2::object::id<0x959a7135a3e96868aac57bb2ae493db76714815797349384671a62d256b1f6d::de_wrapper::DeWrapper<T0, T1>>(arg1),
                token_type  : 0x1::type_name::into_string(0x1::type_name::get<T0>()),
                reward_type : 0x1::type_name::into_string(0x1::type_name::get<T2>()),
                amount      : 0x2::balance::value<T2>(&v5),
            };
            0x2::event::emit<Claim<T1>>(v8);
            v5
        } else {
            0x2::balance::zero<T2>()
        }
    }

    public fun claimable<T0, T1, T2>(arg0: &RewardCenter<T0, T1, T2>) : bool {
        arg0.claimable
    }

    fun default_voting_state<T0>(arg0: &mut 0x2::tx_context::TxContext) : RewardState<T0> {
        RewardState<T0>{
            total_weights : 0,
            reward        : 0x2::balance::zero<T0>(),
            total_rewards : 0,
            votes         : 0x2::table::new<0x2::object::ID, u64>(arg0),
        }
    }

    fun err_already_checked_in() {
        abort 202
    }

    fun err_invalid_package_version() {
        abort 201
    }

    public fun get_casted_weight_by_epoch<T0, T1, T2>(arg0: &RewardCenter<T0, T1, T2>, arg1: 0x2::object::ID, arg2: u64) : u64 {
        if (!0x2::table::contains<u64, RewardState<T2>>(&arg0.voting_states, arg2)) {
            return 0
        };
        let v0 = get_voting_state_by_epoch<T0, T1, T2>(arg0, arg2);
        if (0x2::table::contains<0x2::object::ID, u64>(&v0.votes, arg1)) {
            *0x2::table::borrow<0x2::object::ID, u64>(&v0.votes, arg1)
        } else {
            0
        }
    }

    public fun get_current_epoch_time<T0, T1, T2>(arg0: &RewardCenter<T0, T1, T2>, arg1: &0x2::clock::Clock) : (u64, u64) {
        get_weekly_epoch_time(0x2::clock::timestamp_ms(arg1), arg0.offset)
    }

    public fun get_current_voting_state<T0, T1, T2>(arg0: &RewardCenter<T0, T1, T2>, arg1: &0x2::clock::Clock) : &RewardState<T2> {
        let (v0, _) = get_current_epoch_time<T0, T1, T2>(arg0, arg1);
        0x2::table::borrow<u64, RewardState<T2>>(&arg0.voting_states, v0)
    }

    fun get_current_voting_state_mut<T0, T1, T2>(arg0: &mut RewardCenter<T0, T1, T2>, arg1: &0x2::clock::Clock) : &mut RewardState<T2> {
        let (v0, _) = get_current_epoch_time<T0, T1, T2>(arg0, arg1);
        0x2::table::borrow_mut<u64, RewardState<T2>>(&mut arg0.voting_states, v0)
    }

    public fun get_current_voting_state_reward<T0, T1, T2>(arg0: &RewardCenter<T0, T1, T2>, arg1: &0x2::clock::Clock) : &0x2::balance::Balance<T2> {
        &get_current_voting_state<T0, T1, T2>(arg0, arg1).reward
    }

    public fun get_current_voting_state_total_rewards<T0, T1, T2>(arg0: &RewardCenter<T0, T1, T2>, arg1: &0x2::clock::Clock) : u64 {
        get_current_voting_state<T0, T1, T2>(arg0, arg1).total_rewards
    }

    public fun get_current_voting_state_total_weights<T0, T1, T2>(arg0: &RewardCenter<T0, T1, T2>, arg1: &0x2::clock::Clock) : u64 {
        get_current_voting_state<T0, T1, T2>(arg0, arg1).total_weights
    }

    public fun get_pending_rewards<T0, T1, T2>(arg0: &RewardCenter<T0, T1, T2>, arg1: 0x2::object::ID, arg2: &0x2::clock::Clock) : u64 {
        let v0 = if (0x2::table::contains<0x2::object::ID, u64>(&arg0.last_claimed, arg1)) {
            *0x2::table::borrow<0x2::object::ID, u64>(&arg0.last_claimed, arg1) + 1
        } else {
            start_epoch<T0, T1, T2>(arg0)
        };
        let (v1, _) = get_current_epoch_time<T0, T1, T2>(arg0, arg2);
        let v3 = 0;
        let v4 = v0;
        while (v4 < v1) {
            if (0x2::table::contains<u64, RewardState<T2>>(&arg0.voting_states, v4)) {
                v3 = v3 + get_rewards_by_epoch<T2>(0x2::table::borrow<u64, RewardState<T2>>(&arg0.voting_states, v4), arg1);
            };
            v4 = v4 + 1;
        };
        v3
    }

    public fun get_rewards_by_epoch<T0>(arg0: &RewardState<T0>, arg1: 0x2::object::ID) : u64 {
        let v0 = if (0x2::table::contains<0x2::object::ID, u64>(&arg0.votes, arg1)) {
            *0x2::table::borrow<0x2::object::ID, u64>(&arg0.votes, arg1)
        } else {
            0
        };
        (((v0 as u128) * (arg0.total_rewards as u128) / (arg0.total_weights as u128)) as u64)
    }

    public fun get_voting_state_by_epoch<T0, T1, T2>(arg0: &RewardCenter<T0, T1, T2>, arg1: u64) : &RewardState<T2> {
        0x2::table::borrow<u64, RewardState<T2>>(&arg0.voting_states, arg1)
    }

    public fun get_voting_state_reward_by_epoch<T0, T1, T2>(arg0: &RewardCenter<T0, T1, T2>, arg1: u64) : &0x2::balance::Balance<T2> {
        &get_voting_state_by_epoch<T0, T1, T2>(arg0, arg1).reward
    }

    public fun get_voting_state_total_rewards_by_epoch<T0, T1, T2>(arg0: &RewardCenter<T0, T1, T2>, arg1: u64) : u64 {
        get_voting_state_by_epoch<T0, T1, T2>(arg0, arg1).total_rewards
    }

    public fun get_voting_state_total_weights_by_epoch<T0, T1, T2>(arg0: &RewardCenter<T0, T1, T2>, arg1: u64) : u64 {
        get_voting_state_by_epoch<T0, T1, T2>(arg0, arg1).total_weights
    }

    public fun get_weekly_epoch_time(arg0: u64, arg1: u64) : (u64, u64) {
        let v0 = (arg0 - arg1) / 0x6104e610f707fe5f1b3f34aa274c113a6b0523e63d5fb2069710e1c2d1f1fd1c::de_center::week();
        (v0, v0 * 0x6104e610f707fe5f1b3f34aa274c113a6b0523e63d5fb2069710e1c2d1f1fd1c::de_center::week() + arg1)
    }

    public fun last_claimed<T0, T1, T2>(arg0: &RewardCenter<T0, T1, T2>, arg1: 0x2::object::ID) : u64 {
        *0x2::table::borrow<0x2::object::ID, u64>(&arg0.last_claimed, arg1)
    }

    public fun offset<T0, T1, T2>(arg0: &RewardCenter<T0, T1, T2>) : u64 {
        arg0.offset
    }

    public fun package_version() : u64 {
        1
    }

    public fun start_epoch<T0, T1, T2>(arg0: &RewardCenter<T0, T1, T2>) : u64 {
        arg0.start_epoch
    }

    public fun supply<T0, T1, T2>(arg0: &mut RewardCenter<T0, T1, T2>, arg1: 0x2::balance::Balance<T2>, arg2: &0x2::clock::Clock, arg3: &mut 0x2::tx_context::TxContext) {
        assert_version<T0, T1, T2>(arg0);
        let (v0, _) = get_weekly_epoch_time(0x2::clock::timestamp_ms(arg2), arg0.offset);
        add_voting_state_if_not_exists<T0, T1, T2>(arg0, arg2, arg3);
        let v2 = 0x2::table::borrow_mut<u64, RewardState<T2>>(&mut arg0.voting_states, v0);
        v2.total_rewards = v2.total_rewards + 0x2::balance::value<T2>(&arg1);
        0x2::balance::join<T2>(&mut v2.reward, arg1);
        let v3 = Supply<T1>{
            center_id   : 0x2::object::id<RewardCenter<T0, T1, T2>>(arg0),
            token_type  : 0x1::type_name::into_string(0x1::type_name::get<T0>()),
            reward_type : 0x1::type_name::into_string(0x1::type_name::get<T0>()),
            amount      : 0x2::balance::value<T2>(&arg1),
        };
        0x2::event::emit<Supply<T1>>(v3);
    }

    public fun toggle_claimable<T0, T1, T2>(arg0: &mut RewardCenter<T0, T1, T2>, arg1: &0x6104e610f707fe5f1b3f34aa274c113a6b0523e63d5fb2069710e1c2d1f1fd1c::de_center::AdminCap<T1>) {
        arg0.claimable = !claimable<T0, T1, T2>(arg0);
    }

    public fun voting_state_reward<T0>(arg0: &RewardState<T0>) : &0x2::balance::Balance<T0> {
        &arg0.reward
    }

    public fun voting_state_total_rewards<T0>(arg0: &RewardState<T0>) : u64 {
        arg0.total_rewards
    }

    public fun voting_state_votes<T0>(arg0: &RewardState<T0>) : &0x2::table::Table<0x2::object::ID, u64> {
        &arg0.votes
    }

    // decompiled from Move bytecode v6
}

