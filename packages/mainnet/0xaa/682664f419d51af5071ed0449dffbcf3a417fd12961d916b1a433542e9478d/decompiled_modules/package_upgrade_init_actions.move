module 0xaa682664f419d51af5071ed0449dffbcf3a417fd12961d916b1a433542e9478d::package_upgrade_init_actions {
    struct UpgradeAction has copy, drop, store {
        name: 0x1::string::String,
        digest: vector<u8>,
        expected_cap_id: 0x2::object::ID,
    }

    struct CommitAction has copy, drop, store {
        name: 0x1::string::String,
        expected_cap_id: 0x2::object::ID,
    }

    struct RestrictAction has copy, drop, store {
        name: 0x1::string::String,
        policy: u8,
        expected_cap_id: 0x2::object::ID,
    }

    struct LockUpgradeCapAction has copy, drop, store {
        name: 0x1::string::String,
        delay_ms: u64,
        resource_name: 0x1::string::String,
        expected_cap_id: 0x2::object::ID,
    }

    struct UnlockUpgradeCapAction has copy, drop, store {
        name: 0x1::string::String,
        resource_name: 0x1::string::String,
        expected_cap_id: 0x2::object::ID,
    }

    public fun add_commit_spec(arg0: &mut 0xaa682664f419d51af5071ed0449dffbcf3a417fd12961d916b1a433542e9478d::action_spec_builder::Builder, arg1: 0x1::string::String, arg2: 0x2::object::ID) {
        assert_valid_package_name(&arg1);
        let v0 = CommitAction{
            name            : arg1,
            expected_cap_id : arg2,
        };
        0xaa682664f419d51af5071ed0449dffbcf3a417fd12961d916b1a433542e9478d::action_spec_builder::add(arg0, 0xf6ef484a0867ccffe219fa1f4648e58f8c3fd04a4ddcfb318a27f9cc6d2f3d9::intents::new_action_spec<0xaa682664f419d51af5071ed0449dffbcf3a417fd12961d916b1a433542e9478d::package_upgrade::PackageCommit>(0xaa682664f419d51af5071ed0449dffbcf3a417fd12961d916b1a433542e9478d::package_upgrade::package_commit_marker(), 0x2::bcs::to_bytes<CommitAction>(&v0), 1));
    }

    public fun add_lock_upgrade_cap_spec(arg0: &mut 0xaa682664f419d51af5071ed0449dffbcf3a417fd12961d916b1a433542e9478d::action_spec_builder::Builder, arg1: 0x1::string::String, arg2: u64, arg3: 0x1::string::String, arg4: 0x2::object::ID) {
        assert_valid_package_name(&arg1);
        assert_valid_resource_name(&arg3);
        let v0 = LockUpgradeCapAction{
            name            : arg1,
            delay_ms        : arg2,
            resource_name   : arg3,
            expected_cap_id : arg4,
        };
        0xaa682664f419d51af5071ed0449dffbcf3a417fd12961d916b1a433542e9478d::action_spec_builder::add(arg0, 0xf6ef484a0867ccffe219fa1f4648e58f8c3fd04a4ddcfb318a27f9cc6d2f3d9::intents::new_action_spec<0xaa682664f419d51af5071ed0449dffbcf3a417fd12961d916b1a433542e9478d::package_upgrade::LockUpgradeCap>(0xaa682664f419d51af5071ed0449dffbcf3a417fd12961d916b1a433542e9478d::package_upgrade::lock_upgrade_cap_marker(), 0x2::bcs::to_bytes<LockUpgradeCapAction>(&v0), 1));
    }

    public fun add_restrict_spec(arg0: &mut 0xaa682664f419d51af5071ed0449dffbcf3a417fd12961d916b1a433542e9478d::action_spec_builder::Builder, arg1: 0x1::string::String, arg2: u8, arg3: 0x2::object::ID) {
        assert_valid_package_name(&arg1);
        assert_valid_policy(arg2);
        let v0 = RestrictAction{
            name            : arg1,
            policy          : arg2,
            expected_cap_id : arg3,
        };
        0xaa682664f419d51af5071ed0449dffbcf3a417fd12961d916b1a433542e9478d::action_spec_builder::add(arg0, 0xf6ef484a0867ccffe219fa1f4648e58f8c3fd04a4ddcfb318a27f9cc6d2f3d9::intents::new_action_spec<0xaa682664f419d51af5071ed0449dffbcf3a417fd12961d916b1a433542e9478d::package_upgrade::PackageRestrict>(0xaa682664f419d51af5071ed0449dffbcf3a417fd12961d916b1a433542e9478d::package_upgrade::package_restrict_marker(), 0x2::bcs::to_bytes<RestrictAction>(&v0), 1));
    }

    public fun add_unlock_upgrade_cap_spec(arg0: &mut 0xaa682664f419d51af5071ed0449dffbcf3a417fd12961d916b1a433542e9478d::action_spec_builder::Builder, arg1: 0x1::string::String, arg2: 0x1::string::String, arg3: 0x2::object::ID) {
        assert_valid_package_name(&arg1);
        assert_valid_resource_name(&arg2);
        let v0 = UnlockUpgradeCapAction{
            name            : arg1,
            resource_name   : arg2,
            expected_cap_id : arg3,
        };
        0xaa682664f419d51af5071ed0449dffbcf3a417fd12961d916b1a433542e9478d::action_spec_builder::add(arg0, 0xf6ef484a0867ccffe219fa1f4648e58f8c3fd04a4ddcfb318a27f9cc6d2f3d9::intents::new_action_spec<0xaa682664f419d51af5071ed0449dffbcf3a417fd12961d916b1a433542e9478d::package_upgrade::UnlockUpgradeCap>(0xaa682664f419d51af5071ed0449dffbcf3a417fd12961d916b1a433542e9478d::package_upgrade::unlock_upgrade_cap_marker(), 0x2::bcs::to_bytes<UnlockUpgradeCapAction>(&v0), 1));
    }

    public fun add_upgrade_and_commit_specs(arg0: &mut 0xaa682664f419d51af5071ed0449dffbcf3a417fd12961d916b1a433542e9478d::action_spec_builder::Builder, arg1: 0x1::string::String, arg2: vector<u8>, arg3: 0x2::object::ID) {
        add_upgrade_spec(arg0, arg1, arg2, arg3);
        add_commit_spec(arg0, arg1, arg3);
    }

    public fun add_upgrade_spec(arg0: &mut 0xaa682664f419d51af5071ed0449dffbcf3a417fd12961d916b1a433542e9478d::action_spec_builder::Builder, arg1: 0x1::string::String, arg2: vector<u8>, arg3: 0x2::object::ID) {
        assert_valid_package_name(&arg1);
        let v0 = UpgradeAction{
            name            : arg1,
            digest          : arg2,
            expected_cap_id : arg3,
        };
        0xaa682664f419d51af5071ed0449dffbcf3a417fd12961d916b1a433542e9478d::action_spec_builder::add(arg0, 0xf6ef484a0867ccffe219fa1f4648e58f8c3fd04a4ddcfb318a27f9cc6d2f3d9::intents::new_action_spec<0xaa682664f419d51af5071ed0449dffbcf3a417fd12961d916b1a433542e9478d::package_upgrade::PackageUpgrade>(0xaa682664f419d51af5071ed0449dffbcf3a417fd12961d916b1a433542e9478d::package_upgrade::package_upgrade_marker(), 0x2::bcs::to_bytes<UpgradeAction>(&v0), 1));
    }

    fun assert_valid_package_name(arg0: &0x1::string::String) {
        assert!(0x1::string::length(arg0) > 0, 0);
    }

    fun assert_valid_policy(arg0: u8) {
        assert!(0xaa682664f419d51af5071ed0449dffbcf3a417fd12961d916b1a433542e9478d::package_upgrade::is_valid_restrict_policy(arg0), 1);
    }

    fun assert_valid_resource_name(arg0: &0x1::string::String) {
        assert!(0x1::string::length(arg0) > 0, 2);
    }

    // decompiled from Move bytecode v6
}

