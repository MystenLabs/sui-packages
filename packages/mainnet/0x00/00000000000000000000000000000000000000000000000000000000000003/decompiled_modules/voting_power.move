module 0x3::voting_power {
    struct VotingPowerInfo has drop {
        validator_index: u64,
        voting_power: u64,
    }

    struct VotingPowerInfoV2 has drop {
        validator_index: u64,
        voting_power: u64,
        stake: u64,
    }

    fun insert(arg0: &mut vector<VotingPowerInfoV2>, arg1: VotingPowerInfoV2) {
        let v0 = 0;
        let v1;
        while (v0 < 0x1::vector::length<VotingPowerInfoV2>(arg0)) {
            if (arg1.stake >= 0x1::vector::borrow<VotingPowerInfoV2>(arg0, v0).stake) {
                v1 = 0x1::option::some<u64>(v0);
                /* label 4 */
                let v2 = if (0x1::option::is_some<u64>(&v1)) {
                    0x1::option::destroy_some<u64>(v1)
                } else {
                    0x1::option::destroy_none<u64>(v1);
                    0x1::vector::length<VotingPowerInfoV2>(arg0)
                };
                0x1::vector::insert<VotingPowerInfoV2>(arg0, arg1, v2);
                return
            };
            v0 = v0 + 1;
        };
        v1 = 0x1::option::none<u64>();
        /* goto 4 */
    }

    public(friend) fun set_voting_power(arg0: &mut vector<0x3::validator::Validator>, arg1: u64) {
        let v0 = 10000;
        let v1 = 0x1::u64::min(v0, 0x1::u64::max(1000, 0x1::u64::divide_and_round_up(v0, 0x1::vector::length<0x3::validator::Validator>(arg0))));
        let (v2, v3) = init_voting_power_info(arg0, v1, arg1);
        let v4 = v2;
        let v5 = &mut v4;
        adjust_voting_power(v5, v1, v3);
        update_voting_power(arg0, v4);
        check_invariants(arg0);
    }

    fun adjust_voting_power(arg0: &mut vector<VotingPowerInfoV2>, arg1: u64, arg2: u64) {
        let v0 = 0;
        let v1 = 0x1::vector::length<VotingPowerInfoV2>(arg0);
        while (v0 < v1 && arg2 > 0) {
            let v2 = 0x1::vector::borrow_mut<VotingPowerInfoV2>(arg0, v0);
            let v3 = 0x1::u64::min(arg2, 0x1::u64::min(arg1, v2.voting_power + 0x1::u64::divide_and_round_up(arg2, v1 - v0)) - v2.voting_power);
            v2.voting_power = v2.voting_power + v3;
            assert!(v2.voting_power <= arg1, 3);
            arg2 = arg2 - v3;
            v0 = v0 + 1;
        };
        assert!(arg2 == 0, 1);
    }

    fun check_invariants(arg0: &vector<0x3::validator::Validator>) {
        let v0 = 0;
        let v1 = 0;
        while (v1 < 0x1::vector::length<0x3::validator::Validator>(arg0)) {
            let v2 = 0x3::validator::voting_power(0x1::vector::borrow<0x3::validator::Validator>(arg0, v1));
            assert!(v2 > 0, 4);
            v0 = v0 + v2;
            v1 = v1 + 1;
        };
        assert!(v0 == 10000, 1);
        let v3 = 0x1::vector::length<0x3::validator::Validator>(arg0);
        let v4 = 0;
        while (v4 < v3) {
            let v5 = v4 + 1;
            while (v5 < v3) {
                let v6 = 0x1::vector::borrow<0x3::validator::Validator>(arg0, v4);
                let v7 = 0x1::vector::borrow<0x3::validator::Validator>(arg0, v5);
                let v8 = 0x3::validator::total_stake(v6);
                let v9 = 0x3::validator::total_stake(v7);
                let v10 = 0x3::validator::voting_power(v6);
                let v11 = 0x3::validator::voting_power(v7);
                if (v8 > v9) {
                    assert!(v10 >= v11, 2);
                };
                if (v8 < v9) {
                    assert!(v10 <= v11, 2);
                };
                v5 = v5 + 1;
            };
            v4 = v4 + 1;
        };
    }

    public(friend) fun derive_raw_voting_power(arg0: u64, arg1: u64) : u64 {
        (((arg0 as u128) * (10000 as u128) / (arg1 as u128)) as u64)
    }

    fun init_voting_power_info(arg0: &vector<0x3::validator::Validator>, arg1: u64, arg2: u64) : (vector<VotingPowerInfoV2>, u64) {
        let v0 = 0;
        let v1 = 0x1::vector::empty<VotingPowerInfoV2>();
        let v2 = 0;
        while (v2 < 0x1::vector::length<0x3::validator::Validator>(arg0)) {
            let v3 = 0x3::validator::total_stake(0x1::vector::borrow<0x3::validator::Validator>(arg0, v2));
            let v4 = 0x1::u64::min(derive_raw_voting_power(v3, arg2), arg1);
            let v5 = &mut v1;
            let v6 = VotingPowerInfoV2{
                validator_index : v2,
                voting_power    : v4,
                stake           : v3,
            };
            insert(v5, v6);
            v0 = v0 + v4;
            v2 = v2 + 1;
        };
        (v1, 10000 - v0)
    }

    public fun quorum_threshold() : u64 {
        6667
    }

    public fun total_voting_power() : u64 {
        10000
    }

    fun update_voting_power(arg0: &mut vector<0x3::validator::Validator>, arg1: vector<VotingPowerInfoV2>) {
        let v0 = 0;
        while (v0 < 0x1::vector::length<VotingPowerInfoV2>(&arg1)) {
            let VotingPowerInfoV2 {
                validator_index : v1,
                voting_power    : v2,
                stake           : _,
            } = 0x1::vector::pop_back<VotingPowerInfoV2>(&mut arg1);
            0x3::validator::set_voting_power(0x1::vector::borrow_mut<0x3::validator::Validator>(arg0, v1), v2);
            v0 = v0 + 1;
        };
        0x1::vector::destroy_empty<VotingPowerInfoV2>(arg1);
    }

    // decompiled from Move bytecode v6
}

