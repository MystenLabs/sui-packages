module 0x914c6d3e9e8d19fc2f39874c469afad353ae1090a8231fe0ecb0a125d9d3551b::validator_set {
    struct ValidatorsSorted has copy, drop {
        validators: vector<address>,
    }

    struct ValidatorPriorUpdated has copy, drop {
        validator: address,
        priority: u64,
    }

    struct Vault has store {
        stakes: 0x2::object_table::ObjectTable<u64, 0x3::staking_pool::StakedSui>,
        gap: u64,
        length: u64,
        total_staked: u64,
    }

    struct ValidatorSet has store, key {
        id: 0x2::object::UID,
        vaults: 0x2::table::Table<address, Vault>,
        validators: 0x2::vec_map::VecMap<address, u64>,
        sorted_validators: vector<address>,
    }

    public(friend) fun add_stake(arg0: &mut ValidatorSet, arg1: address, arg2: 0x3::staking_pool::StakedSui, arg3: &mut 0x2::tx_context::TxContext) {
        if (0x2::table::contains<address, Vault>(&mut arg0.vaults, arg1)) {
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

    public(friend) fun create(arg0: &mut 0x2::tx_context::TxContext) : ValidatorSet {
        ValidatorSet{
            id                : 0x2::object::new(arg0),
            vaults            : 0x2::table::new<address, Vault>(arg0),
            validators        : 0x2::vec_map::empty<address, u64>(),
            sorted_validators : 0x1::vector::empty<address>(),
        }
    }

    fun destroy_vault(arg0: Vault) {
        let Vault {
            stakes       : v0,
            gap          : _,
            length       : _,
            total_staked : _,
        } = arg0;
        0x2::object_table::destroy_empty<u64, 0x3::staking_pool::StakedSui>(v0);
    }

    public fun get_bad_validators(arg0: &ValidatorSet) : vector<address> {
        assert!(0x1::vector::length<address>(&arg0.sorted_validators) != 0, 300);
        let v0 = 0x1::vector::empty<address>();
        let v1 = 0;
        while (v1 < 0x1::vector::length<address>(&arg0.sorted_validators)) {
            let v2 = 0x1::vector::borrow<address>(&arg0.sorted_validators, v1);
            if (*0x2::vec_map::get<address, u64>(&arg0.validators, v2) == 0) {
                0x1::vector::push_back<address>(&mut v0, *v2);
            };
            v1 = v1 + 1;
        };
        v0
    }

    public fun get_top_validator(arg0: &ValidatorSet) : address {
        assert!(0x1::vector::length<address>(&arg0.sorted_validators) != 0, 300);
        *0x1::vector::borrow<address>(&arg0.sorted_validators, 0)
    }

    public fun get_total_stake(arg0: &ValidatorSet, arg1: address) : u64 {
        if (!0x2::table::contains<address, Vault>(&arg0.vaults, arg1)) {
            return 0
        };
        0x2::table::borrow<address, Vault>(&arg0.vaults, arg1).total_staked
    }

    public fun get_validators(arg0: &ValidatorSet) : vector<address> {
        arg0.sorted_validators
    }

    public(friend) fun remove_stakes(arg0: &mut ValidatorSet, arg1: &mut 0x3::sui_system::SuiSystemState, arg2: address, arg3: u64, arg4: &mut 0x2::tx_context::TxContext) : (0x2::balance::Balance<0x2::sui::SUI>, u64, u64) {
        let v0 = 0x2::balance::zero<0x2::sui::SUI>();
        let v1 = 0;
        if (!0x2::table::contains<address, Vault>(&mut arg0.vaults, arg2)) {
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
            let v7 = if (v6 >= 1000000000 && v4 > v6 && v4 - v6 >= 1000000000) {
                v5 = v6;
                0x3::staking_pool::split(v3, v6, arg4)
            } else {
                v2.gap = v2.gap + 1;
                0x2::object_table::remove<u64, 0x3::staking_pool::StakedSui>(&mut v2.stakes, v2.gap)
            };
            v1 = v1 + v5;
            0x2::balance::join<0x2::sui::SUI>(&mut v0, 0x3::sui_system::request_withdraw_stake_non_entry(arg1, v7, arg4));
        };
        v2.total_staked = v2.total_staked - v1;
        if (v2.gap == v2.length) {
            assert!(v2.total_staked == 0, 302);
            if (*0x2::vec_map::get<address, u64>(&arg0.validators, &arg2) == 0) {
                destroy_vault(0x2::table::remove<address, Vault>(&mut arg0.vaults, arg2));
                let (_, _) = 0x2::vec_map::remove<address, u64>(&mut arg0.validators, &arg2);
                let (v10, v11) = 0x1::vector::index_of<address>(&arg0.sorted_validators, &arg2);
                assert!(v10, 303);
                0x1::vector::swap_remove<address>(&mut arg0.sorted_validators, v11);
            } else {
                v2.gap = 0;
                v2.length = 0;
            };
        };
        (v0, v1, 0x2::balance::value<0x2::sui::SUI>(&v0) - v1)
    }

    public(friend) fun sort_validators(arg0: &mut ValidatorSet) {
        let v0 = 0;
        let v1 = 0x1::vector::empty<address>();
        while (v0 < 0x2::vec_map::size<address, u64>(&arg0.validators)) {
            let (v2, v3) = 0x2::vec_map::get_entry_by_idx<address, u64>(&arg0.validators, v0);
            let v4 = *v3;
            let v5 = 0x1::vector::length<address>(&v1);
            if (v4 == 0 || v5 == 0) {
                0x1::vector::push_back<address>(&mut v1, *v2);
            } else {
                let v6 = 0;
                while (v6 < v5) {
                    if (*0x2::vec_map::get<address, u64>(&arg0.validators, 0x1::vector::borrow<address>(&v1, v6)) < v4) {
                        break
                    };
                    v6 = v6 + 1;
                };
                0x1::vector::insert<address>(&mut v1, *v2, v6);
            };
            v0 = v0 + 1;
        };
        let v7 = ValidatorsSorted{validators: v1};
        0x2::event::emit<ValidatorsSorted>(v7);
        arg0.sorted_validators = v1;
    }

    fun update_validator(arg0: &mut ValidatorSet, arg1: address, arg2: u64) {
        if (0x2::vec_map::contains<address, u64>(&arg0.validators, &arg1)) {
            *0x2::vec_map::get_mut<address, u64>(&mut arg0.validators, &arg1) = arg2;
        } else {
            0x2::vec_map::insert<address, u64>(&mut arg0.validators, arg1, arg2);
        };
        let v0 = ValidatorPriorUpdated{
            validator : arg1,
            priority  : arg2,
        };
        0x2::event::emit<ValidatorPriorUpdated>(v0);
    }

    public(friend) fun update_validators(arg0: &mut ValidatorSet, arg1: vector<address>, arg2: vector<u64>) {
        let v0 = 0x1::vector::length<address>(&arg1);
        assert!(v0 < 16, 304);
        assert!(v0 == 0x1::vector::length<u64>(&arg2), 301);
        let v1 = 0;
        while (v1 < v0) {
            update_validator(arg0, *0x1::vector::borrow<address>(&arg1, v1), *0x1::vector::borrow<u64>(&arg2, v1));
            v1 = v1 + 1;
        };
    }

    // decompiled from Move bytecode v6
}

