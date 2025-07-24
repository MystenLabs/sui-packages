module 0xb874c9b51b63e05425b74a22891c35b8da447900e577667b52e85a16d4d85486::pending_active_set {
    struct PendingActiveSetEntry has copy, drop, store {
        validator_id: 0x2::object::ID,
        staked_amount: u64,
    }

    struct PendingActiveSet has copy, drop, store {
        min_validator_count: u64,
        max_validator_count: u64,
        min_validator_joining_stake: u64,
        max_validator_change_count: u64,
        validators: vector<PendingActiveSetEntry>,
        total_stake: u64,
        validator_changes: 0x2::vec_set::VecSet<0x2::object::ID>,
    }

    public(friend) fun remove(arg0: &mut PendingActiveSet, arg1: 0x2::object::ID) : bool {
        let v0 = find_validator_index(arg0, arg1);
        let v1 = 0x1::option::is_some<u64>(&v0);
        if (0x1::option::is_some<u64>(&v0)) {
            let v2 = 0x1::vector::remove<PendingActiveSetEntry>(&mut arg0.validators, 0x1::option::destroy_some<u64>(v0));
            arg0.total_stake = arg0.total_stake - v2.staked_amount;
        } else {
            0x1::option::destroy_none<u64>(v0);
        };
        assert!(0x1::vector::length<PendingActiveSetEntry>(&arg0.validators) < arg0.min_validator_count || 0x1::vector::length<PendingActiveSetEntry>(&arg0.validators) >= arg0.min_validator_count, 3);
        if (v1) {
            if (!0x2::vec_set::contains<0x2::object::ID>(&arg0.validator_changes, &arg1)) {
                0x2::vec_set::insert<0x2::object::ID>(&mut arg0.validator_changes, arg1);
            };
            assert!(0x2::vec_set::size<0x2::object::ID>(&arg0.validator_changes) <= arg0.max_validator_change_count, 4);
        };
        v1
    }

    fun insert(arg0: &mut PendingActiveSet, arg1: 0x2::object::ID, arg2: u64) : (bool, 0x1::option::Option<0x2::object::ID>) {
        let v0 = find_validator_index(arg0, arg1);
        assert!(0x1::option::is_none<u64>(&v0), 1);
        if (0x1::vector::length<PendingActiveSetEntry>(&arg0.validators) < arg0.max_validator_count) {
            arg0.total_stake = arg0.total_stake + arg2;
            let v1 = PendingActiveSetEntry{
                validator_id  : arg1,
                staked_amount : arg2,
            };
            insert_sorted(arg0, v1);
            if (!0x2::vec_set::contains<0x2::object::ID>(&arg0.validator_changes, &arg1)) {
                0x2::vec_set::insert<0x2::object::ID>(&mut arg0.validator_changes, arg1);
            };
            assert!(0x2::vec_set::size<0x2::object::ID>(&arg0.validator_changes) <= arg0.max_validator_change_count, 4);
            return (true, 0x1::option::none<0x2::object::ID>())
        };
        if (arg2 <= 0x1::vector::borrow<PendingActiveSetEntry>(&arg0.validators, 0).staked_amount) {
            return (false, 0x1::option::none<0x2::object::ID>())
        };
        let v2 = 0x1::vector::borrow<PendingActiveSetEntry>(&arg0.validators, 0).validator_id;
        arg0.total_stake = arg0.total_stake - 0x1::vector::borrow<PendingActiveSetEntry>(&arg0.validators, 0).staked_amount + arg2;
        0x1::vector::remove<PendingActiveSetEntry>(&mut arg0.validators, 0);
        let v3 = PendingActiveSetEntry{
            validator_id  : arg1,
            staked_amount : arg2,
        };
        insert_sorted(arg0, v3);
        if (!0x2::vec_set::contains<0x2::object::ID>(&arg0.validator_changes, &arg1)) {
            0x2::vec_set::insert<0x2::object::ID>(&mut arg0.validator_changes, arg1);
        };
        assert!(0x2::vec_set::size<0x2::object::ID>(&arg0.validator_changes) <= arg0.max_validator_change_count, 4);
        (true, 0x1::option::some<0x2::object::ID>(v2))
    }

    public(friend) fun size(arg0: &PendingActiveSet) : u64 {
        0x1::vector::length<PendingActiveSetEntry>(&arg0.validators)
    }

    public(friend) fun active_ids(arg0: &PendingActiveSet) : vector<0x2::object::ID> {
        let v0 = &arg0.validators;
        let v1 = 0x1::vector::empty<0x2::object::ID>();
        let v2 = 0;
        while (v2 < 0x1::vector::length<PendingActiveSetEntry>(v0)) {
            0x1::vector::push_back<0x2::object::ID>(&mut v1, 0x1::vector::borrow<PendingActiveSetEntry>(v0, v2).validator_id);
            v2 = v2 + 1;
        };
        v1
    }

    public(friend) fun active_ids_and_stake(arg0: &PendingActiveSet) : (vector<0x2::object::ID>, vector<u64>) {
        let v0 = 0x1::vector::empty<0x2::object::ID>();
        let v1 = vector[];
        let v2 = &arg0.validators;
        let v3 = 0;
        while (v3 < 0x1::vector::length<PendingActiveSetEntry>(v2)) {
            let v4 = 0x1::vector::borrow<PendingActiveSetEntry>(v2, v3);
            0x1::vector::push_back<0x2::object::ID>(&mut v0, v4.validator_id);
            0x1::vector::push_back<u64>(&mut v1, v4.staked_amount);
            v3 = v3 + 1;
        };
        (v0, v1)
    }

    public(friend) fun find_validator_index(arg0: &PendingActiveSet, arg1: 0x2::object::ID) : 0x1::option::Option<u64> {
        let v0 = 0;
        while (v0 < 0x1::vector::length<PendingActiveSetEntry>(&arg0.validators)) {
            if (0x1::vector::borrow<PendingActiveSetEntry>(&arg0.validators, v0).validator_id == arg1) {
                return 0x1::option::some<u64>(v0)
            };
            v0 = v0 + 1;
        };
        0x1::option::none<u64>()
    }

    public(friend) fun insert_or_update_or_remove(arg0: &mut PendingActiveSet, arg1: 0x2::object::ID, arg2: u64) : (bool, 0x1::option::Option<0x2::object::ID>) {
        if (arg2 == 0 || arg2 < arg0.min_validator_joining_stake) {
            if (remove(arg0, arg1)) {
                (false, 0x1::option::some<0x2::object::ID>(arg1))
            } else {
                (false, 0x1::option::none<0x2::object::ID>())
            }
        } else if (update(arg0, arg1, arg2)) {
            (true, 0x1::option::none<0x2::object::ID>())
        } else {
            insert(arg0, arg1, arg2)
        }
    }

    fun insert_sorted(arg0: &mut PendingActiveSet, arg1: PendingActiveSetEntry) {
        let v0 = 0;
        let v1 = 0x1::vector::length<PendingActiveSetEntry>(&arg0.validators);
        while (v0 < v1) {
            v1 = (v0 + v1) / 2;
            if (0x1::vector::borrow<PendingActiveSetEntry>(&arg0.validators, v1).staked_amount < arg1.staked_amount) {
                v0 = v1 + 1;
                continue
            };
        };
        0x1::vector::push_back<PendingActiveSetEntry>(&mut arg0.validators, arg1);
        let v2 = 0x1::vector::length<PendingActiveSetEntry>(&arg0.validators);
        if (v2 > 1) {
            let v3 = v2 - 1;
            while (v3 > v0) {
                0x1::vector::swap<PendingActiveSetEntry>(&mut arg0.validators, v3, v3 - 1);
                v3 = v3 - 1;
            };
        };
    }

    public(friend) fun max_validator_change_count(arg0: &PendingActiveSet) : u64 {
        arg0.max_validator_change_count
    }

    public(friend) fun max_validator_count(arg0: &PendingActiveSet) : u64 {
        arg0.max_validator_count
    }

    public(friend) fun min_validator_count(arg0: &PendingActiveSet) : u64 {
        arg0.min_validator_count
    }

    public(friend) fun min_validator_joining_stake(arg0: &PendingActiveSet) : u64 {
        arg0.min_validator_joining_stake
    }

    public(friend) fun new(arg0: u64, arg1: u64, arg2: u64, arg3: u64) : PendingActiveSet {
        assert!(arg1 > 0, 0);
        assert!(arg0 <= arg1, 3);
        PendingActiveSet{
            min_validator_count         : arg0,
            max_validator_count         : arg1,
            min_validator_joining_stake : arg2,
            max_validator_change_count  : arg3,
            validators                  : 0x1::vector::empty<PendingActiveSetEntry>(),
            total_stake                 : 0,
            validator_changes           : 0x2::vec_set::empty<0x2::object::ID>(),
        }
    }

    fun reposition_validator(arg0: &mut PendingActiveSet, arg1: u64) {
        let v0 = 0x1::vector::remove<PendingActiveSetEntry>(&mut arg0.validators, arg1);
        insert_sorted(arg0, v0);
    }

    public(friend) fun reset_validator_changes(arg0: &mut PendingActiveSet) {
        arg0.validator_changes = 0x2::vec_set::empty<0x2::object::ID>();
    }

    public(friend) fun set_max_validator_change_count(arg0: &mut PendingActiveSet, arg1: u64) {
        arg0.max_validator_change_count = arg1;
    }

    public(friend) fun set_max_validator_count(arg0: &mut PendingActiveSet, arg1: u64) {
        arg0.max_validator_count = arg1;
    }

    public(friend) fun set_min_validator_count(arg0: &mut PendingActiveSet, arg1: u64) {
        arg0.min_validator_count = arg1;
    }

    public(friend) fun set_min_validator_joining_stake(arg0: &mut PendingActiveSet, arg1: u64) {
        arg0.min_validator_joining_stake = arg1;
    }

    public(friend) fun total_stake(arg0: &PendingActiveSet) : u64 {
        arg0.total_stake
    }

    public(friend) fun update(arg0: &mut PendingActiveSet, arg1: 0x2::object::ID, arg2: u64) : bool {
        let v0 = find_validator_index(arg0, arg1);
        if (0x1::option::is_none<u64>(&v0)) {
            return false
        };
        if (0x1::option::is_some<u64>(&v0)) {
            let v1 = 0x1::option::destroy_some<u64>(v0);
            arg0.total_stake = arg0.total_stake + arg2 - 0x1::vector::borrow<PendingActiveSetEntry>(&arg0.validators, v1).staked_amount;
            0x1::vector::borrow_mut<PendingActiveSetEntry>(&mut arg0.validators, v1).staked_amount = arg2;
            reposition_validator(arg0, v1);
        } else {
            0x1::option::destroy_none<u64>(v0);
        };
        true
    }

    public(friend) fun update_or_remove(arg0: &mut PendingActiveSet, arg1: 0x2::object::ID, arg2: u64) : (bool, 0x1::option::Option<0x2::object::ID>) {
        if (arg2 == 0 || arg2 < arg0.min_validator_joining_stake) {
            if (remove(arg0, arg1)) {
                (false, 0x1::option::some<0x2::object::ID>(arg1))
            } else {
                (false, 0x1::option::none<0x2::object::ID>())
            }
        } else {
            (update(arg0, arg1, arg2), 0x1::option::none<0x2::object::ID>())
        }
    }

    // decompiled from Move bytecode v6
}

