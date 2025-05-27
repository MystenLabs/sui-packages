module 0x4eb9c090cd484778411c32894ec7b936793deaab69f114e9b47d07a58e8f5e5d::snapshot {
    struct ValidatorSnapshot has key {
        id: 0x2::object::UID,
        all_stake: 0x2::vec_map::VecMap<address, u64>,
        ignored_stake: 0x2::vec_map::VecMap<address, u64>,
        last_updated_epoch: u64,
    }

    struct ValidatorSnapshotCap has store, key {
        id: 0x2::object::UID,
    }

    public fun all_stake(arg0: &ValidatorSnapshot) : 0x2::vec_map::VecMap<address, u64> {
        arg0.all_stake
    }

    public fun finalized_stake(arg0: &ValidatorSnapshot) : 0x2::vec_map::VecMap<address, u64> {
        let (v0, v1) = 0x2::vec_map::into_keys_values<address, u64>(arg0.all_stake);
        let v2 = 0x2::vec_map::empty<address, u64>();
        let v3 = v0;
        let v4 = v1;
        0x1::vector::reverse<u64>(&mut v4);
        assert!(0x1::vector::length<address>(&v3) == 0x1::vector::length<u64>(&v4), 13906834449221287935);
        0x1::vector::reverse<address>(&mut v3);
        let v5 = 0;
        while (v5 < 0x1::vector::length<address>(&v3)) {
            let v6 = 0x1::vector::pop_back<address>(&mut v3);
            let v7 = 0x2::vec_map::get_idx_opt<address, u64>(&arg0.ignored_stake, &v6);
            let v8 = if (0x1::option::is_some<u64>(&v7)) {
                let (_, v10) = 0x2::vec_map::get_entry_by_idx<address, u64>(&arg0.ignored_stake, 0x1::option::extract<u64>(&mut v7));
                *v10
            } else {
                0
            };
            0x2::vec_map::insert<address, u64>(&mut v2, v6, 0x1::vector::pop_back<u64>(&mut v4) - v8);
            v5 = v5 + 1;
        };
        0x1::vector::destroy_empty<address>(v3);
        0x1::vector::destroy_empty<u64>(v4);
        v2
    }

    public fun ignored_stake(arg0: &ValidatorSnapshot) : 0x2::vec_map::VecMap<address, u64> {
        arg0.ignored_stake
    }

    fun init(arg0: &mut 0x2::tx_context::TxContext) {
        let v0 = ValidatorSnapshot{
            id                 : 0x2::object::new(arg0),
            all_stake          : 0x2::vec_map::empty<address, u64>(),
            ignored_stake      : 0x2::vec_map::empty<address, u64>(),
            last_updated_epoch : 0,
        };
        0x2::transfer::share_object<ValidatorSnapshot>(v0);
        let v1 = ValidatorSnapshotCap{id: 0x2::object::new(arg0)};
        0x2::transfer::transfer<ValidatorSnapshotCap>(v1, 0x2::tx_context::sender(arg0));
    }

    public fun is_up_to_date(arg0: &ValidatorSnapshot, arg1: &0x2::tx_context::TxContext) : bool {
        arg0.last_updated_epoch == 0x2::tx_context::epoch(arg1)
    }

    public fun update_all_stake(arg0: &mut ValidatorSnapshot, arg1: &ValidatorSnapshotCap, arg2: 0x2::vec_map::VecMap<address, u64>, arg3: &0x2::tx_context::TxContext) {
        arg0.all_stake = arg2;
        arg0.last_updated_epoch = 0x2::tx_context::epoch(arg3);
    }

    public fun update_ignored_stake(arg0: &mut ValidatorSnapshot, arg1: &ValidatorSnapshotCap, arg2: 0x2::vec_map::VecMap<address, u64>, arg3: &0x2::tx_context::TxContext) {
        arg0.ignored_stake = arg2;
        arg0.last_updated_epoch = 0x2::tx_context::epoch(arg3);
    }

    // decompiled from Move bytecode v6
}

