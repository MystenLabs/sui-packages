module 0xe3f0614ae7b7feb77a142385cb71abb36d6e0e269c5f4fc5604b3b7e1b1d45dc::admin {
    struct AdminCap has store, key {
        id: 0x2::object::UID,
    }

    struct DelegateWitnessList has key {
        id: 0x2::object::UID,
        witnesses: 0x2::vec_set::VecSet<0x1::type_name::TypeName>,
    }

    struct GlobalConfig has key {
        id: 0x2::object::UID,
        enable_redeem: bool,
    }

    public fun add_delegate_witness<T0: drop>(arg0: &AdminCap, arg1: &mut DelegateWitnessList) {
        let v0 = 0x1::type_name::get<T0>();
        if (0x2::vec_set::contains<0x1::type_name::TypeName>(&arg1.witnesses, &v0)) {
            return
        };
        0x2::vec_set::insert<0x1::type_name::TypeName>(&mut arg1.witnesses, v0);
    }

    public fun assert_is_delegate_witness<T0: drop>(arg0: &DelegateWitnessList) {
        let v0 = 0x1::type_name::get<T0>();
        assert!(0x2::vec_set::contains<0x1::type_name::TypeName>(&arg0.witnesses, &v0), 403);
    }

    public fun assert_redeem_enabled(arg0: &GlobalConfig) : bool {
        assert!(arg0.enable_redeem, 503);
        arg0.enable_redeem
    }

    public fun decrease_score(arg0: &AdminCap, arg1: &mut 0xe3f0614ae7b7feb77a142385cb71abb36d6e0e269c5f4fc5604b3b7e1b1d45dc::scallop_score::ScallopScoreTable, arg2: address, arg3: u64) {
        0xe3f0614ae7b7feb77a142385cb71abb36d6e0e269c5f4fc5604b3b7e1b1d45dc::scallop_score::decrease_score(arg1, arg2, arg3);
    }

    public fun decrease_score_delegated<T0: drop>(arg0: T0, arg1: &DelegateWitnessList, arg2: &mut 0xe3f0614ae7b7feb77a142385cb71abb36d6e0e269c5f4fc5604b3b7e1b1d45dc::scallop_score::ScallopScoreTable, arg3: address, arg4: u64) {
        assert_is_delegate_witness<T0>(arg1);
        0xe3f0614ae7b7feb77a142385cb71abb36d6e0e269c5f4fc5604b3b7e1b1d45dc::scallop_score::decrease_score(arg2, arg3, arg4);
    }

    public fun disable_redeem(arg0: &AdminCap, arg1: &mut GlobalConfig) {
        arg1.enable_redeem = false;
    }

    public fun enable_redeem(arg0: &AdminCap, arg1: &mut GlobalConfig) {
        arg1.enable_redeem = true;
    }

    public fun increase_score(arg0: &AdminCap, arg1: &mut 0xe3f0614ae7b7feb77a142385cb71abb36d6e0e269c5f4fc5604b3b7e1b1d45dc::scallop_score::ScallopScoreTable, arg2: address, arg3: u64) {
        0xe3f0614ae7b7feb77a142385cb71abb36d6e0e269c5f4fc5604b3b7e1b1d45dc::scallop_score::increase_score(arg1, arg2, arg3);
    }

    public fun increase_score_delegated<T0: drop>(arg0: T0, arg1: &DelegateWitnessList, arg2: &mut 0xe3f0614ae7b7feb77a142385cb71abb36d6e0e269c5f4fc5604b3b7e1b1d45dc::scallop_score::ScallopScoreTable, arg3: address, arg4: u64) {
        assert_is_delegate_witness<T0>(arg1);
        0xe3f0614ae7b7feb77a142385cb71abb36d6e0e269c5f4fc5604b3b7e1b1d45dc::scallop_score::increase_score(arg2, arg3, arg4);
    }

    fun init(arg0: &mut 0x2::tx_context::TxContext) {
        let v0 = AdminCap{id: 0x2::object::new(arg0)};
        let v1 = DelegateWitnessList{
            id        : 0x2::object::new(arg0),
            witnesses : 0x2::vec_set::empty<0x1::type_name::TypeName>(),
        };
        let v2 = GlobalConfig{
            id            : 0x2::object::new(arg0),
            enable_redeem : true,
        };
        0x2::transfer::transfer<AdminCap>(v0, 0x2::tx_context::sender(arg0));
        0x2::transfer::share_object<DelegateWitnessList>(v1);
        0x2::transfer::share_object<GlobalConfig>(v2);
    }

    public fun remove_delegate_witness<T0: drop>(arg0: &AdminCap, arg1: &mut DelegateWitnessList) {
        let v0 = 0x1::type_name::get<T0>();
        if (!0x2::vec_set::contains<0x1::type_name::TypeName>(&arg1.witnesses, &v0)) {
            return
        };
        0x2::vec_set::remove<0x1::type_name::TypeName>(&mut arg1.witnesses, &v0);
    }

    public fun set_score(arg0: &AdminCap, arg1: &mut 0xe3f0614ae7b7feb77a142385cb71abb36d6e0e269c5f4fc5604b3b7e1b1d45dc::scallop_score::ScallopScoreTable, arg2: address, arg3: u64) {
        0xe3f0614ae7b7feb77a142385cb71abb36d6e0e269c5f4fc5604b3b7e1b1d45dc::scallop_score::set_score(arg1, arg2, arg3);
    }

    public fun upgrade_contract(arg0: &AdminCap, arg1: &mut 0xe3f0614ae7b7feb77a142385cb71abb36d6e0e269c5f4fc5604b3b7e1b1d45dc::version::Version) {
        0xe3f0614ae7b7feb77a142385cb71abb36d6e0e269c5f4fc5604b3b7e1b1d45dc::version::upgrade(arg1);
    }

    // decompiled from Move bytecode v6
}

