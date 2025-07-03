module 0x42cf58fd8eb079de620f1b5161deaaa923ffbb8e4da0c2f3bdcf71fc4591dc69::user_staking_info {
    struct UserStakingInfo<phantom T0> has store {
        total_locked: u64,
        token_ids: vector<0x2::object::ID>,
        pending_rewards: u64,
    }

    public(friend) fun destroy_empty<T0>(arg0: UserStakingInfo<T0>) {
        assert!(0x1::vector::is_empty<0x2::object::ID>(&arg0.token_ids), 0);
        let UserStakingInfo {
            total_locked    : _,
            token_ids       : v1,
            pending_rewards : _,
        } = arg0;
        0x1::vector::destroy_empty<0x2::object::ID>(v1);
    }

    public fun add_stake<T0>(arg0: &mut UserStakingInfo<T0>, arg1: u64, arg2: 0x2::object::ID) {
        arg0.total_locked = arg0.total_locked + arg1;
        0x1::vector::push_back<0x2::object::ID>(&mut arg0.token_ids, arg2);
    }

    public fun create<T0>() : UserStakingInfo<T0> {
        UserStakingInfo<T0>{
            total_locked    : 0,
            token_ids       : 0x1::vector::empty<0x2::object::ID>(),
            pending_rewards : 0,
        }
    }

    fun find_token_index<T0>(arg0: &UserStakingInfo<T0>, arg1: 0x2::object::ID) : (bool, u64) {
        let v0 = 0;
        while (v0 < 0x1::vector::length<0x2::object::ID>(&arg0.token_ids)) {
            if (*0x1::vector::borrow<0x2::object::ID>(&arg0.token_ids, v0) == arg1) {
                return (true, v0)
            };
            v0 = v0 + 1;
        };
        (false, 0)
    }

    public fun has_active_stakes<T0>(arg0: &UserStakingInfo<T0>) : bool {
        !0x1::vector::is_empty<0x2::object::ID>(&arg0.token_ids)
    }

    public fun remove_stake<T0>(arg0: &mut UserStakingInfo<T0>, arg1: 0x2::object::ID) : bool {
        let (v0, v1) = find_token_index<T0>(arg0, arg1);
        if (v0) {
            0x1::vector::remove<0x2::object::ID>(&mut arg0.token_ids, v1);
            return true
        };
        false
    }

    public(friend) fun update_stake_amount<T0>(arg0: &mut UserStakingInfo<T0>, arg1: 0x2::object::ID, arg2: u64) {
        let (v0, _) = find_token_index<T0>(arg0, arg1);
        assert!(v0, 0);
        arg0.total_locked = arg0.total_locked + arg2;
    }

    // decompiled from Move bytecode v6
}

