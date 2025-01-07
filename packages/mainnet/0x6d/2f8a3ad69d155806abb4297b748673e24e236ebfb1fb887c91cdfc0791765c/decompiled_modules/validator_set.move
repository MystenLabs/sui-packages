module 0x6d2f8a3ad69d155806abb4297b748673e24e236ebfb1fb887c91cdfc0791765c::validator_set {
    struct ValidatorsSortedEvent has copy, drop {
        validators: vector<address>,
    }

    struct Vault has store {
        stakes: 0x2::object_table::ObjectTable<u64, 0x3::staking_pool::StakedSui>,
        gap: u64,
        length: u64,
        total_staked: u64,
    }

    struct Validator has copy, drop, store {
        voting_score: u64,
        current_score: u64,
    }

    struct ValidatorSet has store, key {
        id: 0x2::object::UID,
        vaults: 0x2::table::Table<address, Vault>,
        validators: 0x2::vec_map::VecMap<address, Validator>,
        sorted_validators: vector<address>,
        total_score: u64,
        is_sorted: bool,
        last_snapshot_update_ms: u64,
    }

    public(friend) fun new(arg0: &mut 0x2::tx_context::TxContext) : ValidatorSet {
        ValidatorSet{
            id                      : 0x2::object::new(arg0),
            vaults                  : 0x2::table::new<address, Vault>(arg0),
            validators              : 0x2::vec_map::empty<address, Validator>(),
            sorted_validators       : 0x1::vector::empty<address>(),
            total_score             : 0,
            is_sorted               : false,
            last_snapshot_update_ms : 0,
        }
    }

    public(friend) fun add_stake(arg0: &mut ValidatorSet, arg1: address, arg2: 0x3::staking_pool::StakedSui, arg3: &mut 0x2::tx_context::TxContext) {
        if (0x2::table::contains<address, Vault>(&arg0.vaults, arg1)) {
            let v0 = 0x2::table::borrow_mut<address, Vault>(&mut arg0.vaults, arg1);
            0x2::object_table::add<u64, 0x3::staking_pool::StakedSui>(&mut v0.stakes, v0.length, arg2);
            v0.total_staked = v0.total_staked + 0x3::staking_pool::staked_sui_amount(&arg2);
            v0.length = v0.length + 1;
        } else {
            let v1 = Vault{
                stakes       : 0x2::object_table::new<u64, 0x3::staking_pool::StakedSui>(arg3),
                gap          : 0,
                length       : 1,
                total_staked : 0x3::staking_pool::staked_sui_amount(&arg2),
            };
            0x2::object_table::add<u64, 0x3::staking_pool::StakedSui>(&mut v1.stakes, 0, arg2);
            0x2::table::add<address, Vault>(&mut arg0.vaults, arg1, v1);
        };
    }

    public(friend) fun add_validator(arg0: &mut ValidatorSet, arg1: address) {
        assert!(!0x2::vec_map::contains<address, Validator>(&arg0.validators, &arg1), 200);
        let v0 = Validator{
            voting_score  : 0,
            current_score : 0,
        };
        0x2::vec_map::insert<address, Validator>(&mut arg0.validators, arg1, v0);
        0x1::vector::push_back<address>(&mut arg0.sorted_validators, arg1);
        sort_validators(arg0);
    }

    public fun get_last_snapshot_update_ms(arg0: &ValidatorSet) : u64 {
        arg0.last_snapshot_update_ms
    }

    public fun get_total_score(arg0: &ValidatorSet) : u64 {
        arg0.total_score
    }

    public fun get_total_stake(arg0: &ValidatorSet, arg1: address) : u64 {
        if (!0x2::table::contains<address, Vault>(&arg0.vaults, arg1)) {
            return 0
        };
        0x2::table::borrow<address, Vault>(&arg0.vaults, arg1).total_staked
    }

    public fun get_validator_score(arg0: &ValidatorSet, arg1: address) : u64 {
        0x2::vec_map::get<address, Validator>(&arg0.validators, &arg1).current_score
    }

    public fun get_validators(arg0: &ValidatorSet) : vector<address> {
        arg0.sorted_validators
    }

    public(friend) fun remove_stakes(arg0: &mut ValidatorSet, arg1: &mut 0x3::sui_system::SuiSystemState, arg2: address, arg3: u64, arg4: &mut 0x2::tx_context::TxContext) : (0x2::balance::Balance<0x2::sui::SUI>, u64, u64) {
        let v0 = 0x2::balance::zero<0x2::sui::SUI>();
        let v1 = 0;
        if (!0x2::table::contains<address, Vault>(&arg0.vaults, arg2)) {
            return (v0, 0, 0)
        };
        let v2 = 0x2::table::borrow_mut<address, Vault>(&mut arg0.vaults, arg2);
        while (v2.gap < v2.length && 0x2::balance::value<0x2::sui::SUI>(&v0) < arg3) {
            let v3 = 0x2::object_table::borrow_mut<u64, 0x3::staking_pool::StakedSui>(&mut v2.stakes, v2.gap);
            if (0x3::staking_pool::stake_activation_epoch(v3) > 0x2::tx_context::epoch(arg4)) {
                break
            };
            let v4 = 0x3::staking_pool::staked_sui_amount(v3);
            let v5 = v4;
            let v6 = arg3 - 0x2::balance::value<0x2::sui::SUI>(&v0);
            let v7 = v6;
            if (v6 < 1000000000) {
                v7 = 1000000000;
            };
            let v8 = if (v4 > v7 && v4 - v7 >= 1000000000) {
                v5 = v7;
                0x3::staking_pool::split(v3, v7, arg4)
            } else {
                v2.gap = v2.gap + 1;
                0x2::object_table::remove<u64, 0x3::staking_pool::StakedSui>(&mut v2.stakes, v2.gap)
            };
            v1 = v1 + v5;
            0x2::balance::join<0x2::sui::SUI>(&mut v0, 0x3::sui_system::request_withdraw_stake_non_entry(arg1, v8, arg4));
        };
        v2.total_staked = v2.total_staked - v1;
        if (v2.gap == v2.length) {
            assert!(v2.total_staked == 0, 203);
            v2.gap = 0;
            v2.length = 0;
        };
        (v0, v1, 0x2::balance::value<0x2::sui::SUI>(&v0) - v1)
    }

    public(friend) fun snapshot(arg0: &mut ValidatorSet, arg1: u64) {
        let v0 = 0x1::vector::length<address>(&arg0.sorted_validators);
        assert!(v0 > 0, 202);
        let v1 = 0;
        while (v1 < v0) {
            let v2 = *0x1::vector::borrow<address>(&arg0.sorted_validators, v1);
            let v3 = 0x2::vec_map::get_mut<address, Validator>(&mut arg0.validators, &v2);
            arg0.total_score = arg0.total_score - v3.current_score + v3.voting_score;
            v3.current_score = v3.voting_score;
            v1 = v1 + 1;
        };
        arg0.last_snapshot_update_ms = arg1;
        sort_validators(arg0);
    }

    public(friend) fun sort_validators(arg0: &mut ValidatorSet) {
        let v0 = 0;
        let v1 = 0x1::vector::empty<address>();
        while (v0 < 0x2::vec_map::size<address, Validator>(&arg0.validators)) {
            let (v2, v3) = 0x2::vec_map::get_entry_by_idx<address, Validator>(&arg0.validators, v0);
            let v4 = v3.current_score;
            let v5 = 0x1::vector::length<address>(&v1);
            if (v4 == 0 || v5 == 0) {
                0x1::vector::push_back<address>(&mut v1, *v2);
            } else {
                let v6 = 0;
                while (v6 < v5) {
                    if (0x2::vec_map::get<address, Validator>(&arg0.validators, 0x1::vector::borrow<address>(&v1, v6)).current_score < v4) {
                        break
                    };
                    v6 = v6 + 1;
                };
                0x1::vector::insert<address>(&mut v1, *v2, v6);
            };
            v0 = v0 + 1;
        };
        arg0.is_sorted = true;
        arg0.sorted_validators = v1;
        let v7 = ValidatorsSortedEvent{validators: v1};
        0x2::event::emit<ValidatorsSortedEvent>(v7);
    }

    public(friend) fun vote_validator(arg0: &mut ValidatorSet, arg1: address, arg2: u64, arg3: u64) {
        assert!(0x2::vec_map::contains<address, Validator>(&arg0.validators, &arg1), 201);
        let v0 = 0x2::vec_map::get_mut<address, Validator>(&mut arg0.validators, &arg1);
        v0.voting_score = v0.voting_score - arg2 + arg3;
    }

    // decompiled from Move bytecode v6
}

