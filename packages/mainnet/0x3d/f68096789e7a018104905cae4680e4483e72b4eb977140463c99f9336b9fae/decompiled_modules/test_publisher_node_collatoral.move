module 0x3df68096789e7a018104905cae4680e4483e72b4eb977140463c99f9336b9fae::test_publisher_node_collatoral {
    struct PublisherNodeVault has store, key {
        id: 0x2::object::UID,
        total_staked: 0x2::coin::Coin<0x4bb07b086c13bda7af26b9872fa8c4b460a9c0479cde6a63de4b9d29ea0ec99a::test_token::TEST_TOKEN>,
        user_details: 0x2::vec_map::VecMap<address, 0x2::vec_map::VecMap<0x1::string::String, 0x2::vec_map::VecMap<u64, PublisherNode>>>,
        user_stake_info: 0x2::vec_map::VecMap<address, u64>,
        locking_period: u64,
        node_counter: u64,
    }

    struct PublisherNode has copy, drop, store {
        id: u64,
        price: u64,
        locking_period: u64,
        owner_address: address,
        timestamp: u64,
    }

    struct Owner has store, key {
        id: 0x2::object::UID,
        owner_address: address,
    }

    struct UpgradeVersion has key {
        id: 0x2::object::UID,
        version: u64,
    }

    struct MaintainerRole has store, key {
        id: 0x2::object::UID,
        has_maintainer_access: 0x2::vec_set::VecSet<address>,
    }

    struct UserDetails has copy, drop {
        staker: address,
        staker_details: 0x2::vec_map::VecMap<0x1::string::String, 0x2::vec_map::VecMap<u64, PublisherNode>>,
    }

    struct ConfiguredLockPeriod has copy, drop {
        new_locking_period: u64,
    }

    struct MaintainerRoleRevoked has copy, drop {
        revoke_address: address,
    }

    struct MaintainerRoleGranted has copy, drop {
        recipient: address,
    }

    struct ChangedOwner has copy, drop {
        current_owner: address,
        new_owner: address,
    }

    struct TEST_PUBLISHER_NODE_COLLATORAL has drop {
        dummy_field: bool,
    }

    public entry fun add_collatoral(arg0: &MaintainerRole, arg1: address, arg2: 0x2::coin::Coin<0x4bb07b086c13bda7af26b9872fa8c4b460a9c0479cde6a63de4b9d29ea0ec99a::test_token::TEST_TOKEN>, arg3: u64, arg4: 0x1::string::String, arg5: vector<u64>, arg6: &mut PublisherNodeVault, arg7: &0x2::clock::Clock, arg8: &UpgradeVersion, arg9: &mut 0x2::tx_context::TxContext) {
        let v0 = 0x2::coin::value<0x4bb07b086c13bda7af26b9872fa8c4b460a9c0479cde6a63de4b9d29ea0ec99a::test_token::TEST_TOKEN>(&arg2);
        let v1 = 0x2::tx_context::sender(arg9);
        assert!(0x2::vec_set::contains<address>(&arg0.has_maintainer_access, &v1), 12);
        assert!(arg8.version == 0, 2);
        assert!(0x1::vector::length<u64>(&arg5) == arg3, 10);
        assert!(v0 != 0, 1);
        0x2::coin::join<0x4bb07b086c13bda7af26b9872fa8c4b460a9c0479cde6a63de4b9d29ea0ec99a::test_token::TEST_TOKEN>(&mut arg6.total_staked, arg2);
        register_publisher_node(arg4, arg5, v0 / arg3, arg3, arg1, arg6, arg7, arg8);
    }

    public entry fun change_owner(arg0: 0x2::package::UpgradeCap, arg1: &mut MaintainerRole, arg2: Owner, arg3: address, arg4: &UpgradeVersion, arg5: &0x2::tx_context::TxContext) {
        let v0 = arg2.owner_address;
        assert!(0x2::tx_context::sender(arg5) == v0, 3);
        assert!(arg4.version == 0, 2);
        assert!(@0x0 != arg3, 4);
        assert!(arg3 != v0, 8);
        0x2::vec_set::remove<address>(&mut arg1.has_maintainer_access, &v0);
        0x2::vec_set::insert<address>(&mut arg1.has_maintainer_access, arg3);
        arg2.owner_address = arg3;
        0x2::transfer::public_transfer<Owner>(arg2, arg3);
        0x2::transfer::public_transfer<0x2::package::UpgradeCap>(arg0, arg3);
        let v1 = ChangedOwner{
            current_owner : v0,
            new_owner     : arg3,
        };
        0x2::event::emit<ChangedOwner>(v1);
    }

    public entry fun configure_lock_period(arg0: &MaintainerRole, arg1: &mut PublisherNodeVault, arg2: u64, arg3: &UpgradeVersion, arg4: &mut 0x2::tx_context::TxContext) {
        let v0 = 0x2::tx_context::sender(arg4);
        assert!(0x2::vec_set::contains<address>(&arg0.has_maintainer_access, &v0), 12);
        assert!(arg3.version == 0, 2);
        arg1.locking_period = arg2;
        let v1 = ConfiguredLockPeriod{new_locking_period: arg2};
        0x2::event::emit<ConfiguredLockPeriod>(v1);
    }

    public entry fun grant_maintainer_role(arg0: &Owner, arg1: &mut MaintainerRole, arg2: &UpgradeVersion, arg3: address, arg4: &0x2::tx_context::TxContext) {
        assert!(arg2.version == 0, 2);
        assert!(0x2::tx_context::sender(arg4) == arg0.owner_address, 3);
        assert!(@0x0 != arg3, 4);
        assert!(!0x2::vec_set::contains<address>(&arg1.has_maintainer_access, &arg3), 14);
        0x2::vec_set::insert<address>(&mut arg1.has_maintainer_access, arg3);
        let v0 = MaintainerRoleGranted{recipient: arg3};
        0x2::event::emit<MaintainerRoleGranted>(v0);
    }

    fun init(arg0: TEST_PUBLISHER_NODE_COLLATORAL, arg1: &mut 0x2::tx_context::TxContext) {
        let v0 = 0x2::tx_context::sender(arg1);
        let v1 = Owner{
            id            : 0x2::object::new(arg1),
            owner_address : v0,
        };
        let v2 = UpgradeVersion{
            id      : 0x2::object::new(arg1),
            version : 0,
        };
        let v3 = PublisherNodeVault{
            id              : 0x2::object::new(arg1),
            total_staked    : 0x2::coin::zero<0x4bb07b086c13bda7af26b9872fa8c4b460a9c0479cde6a63de4b9d29ea0ec99a::test_token::TEST_TOKEN>(arg1),
            user_details    : 0x2::vec_map::empty<address, 0x2::vec_map::VecMap<0x1::string::String, 0x2::vec_map::VecMap<u64, PublisherNode>>>(),
            user_stake_info : 0x2::vec_map::empty<address, u64>(),
            locking_period  : 31536000000,
            node_counter    : 0,
        };
        let v4 = MaintainerRole{
            id                    : 0x2::object::new(arg1),
            has_maintainer_access : 0x2::vec_set::empty<address>(),
        };
        0x2::vec_set::insert<address>(&mut v4.has_maintainer_access, v0);
        0x2::transfer::share_object<MaintainerRole>(v4);
        0x2::transfer::share_object<PublisherNodeVault>(v3);
        0x2::transfer::public_transfer<Owner>(v1, v0);
        0x2::transfer::share_object<UpgradeVersion>(v2);
    }

    public fun map_publisher_node(arg0: address, arg1: u64, arg2: u64, arg3: 0x1::string::String, arg4: &mut PublisherNodeVault, arg5: vector<PublisherNode>) {
        let v0 = 0;
        while (v0 < arg2) {
            let v1 = 0x1::vector::pop_back<PublisherNode>(&mut arg5);
            if (0x2::vec_map::contains<address, 0x2::vec_map::VecMap<0x1::string::String, 0x2::vec_map::VecMap<u64, PublisherNode>>>(&arg4.user_details, &arg0)) {
                let v2 = 0x2::vec_map::get_mut<address, 0x2::vec_map::VecMap<0x1::string::String, 0x2::vec_map::VecMap<u64, PublisherNode>>>(&mut arg4.user_details, &arg0);
                if (0x2::vec_map::contains<0x1::string::String, 0x2::vec_map::VecMap<u64, PublisherNode>>(v2, &arg3)) {
                    0x2::vec_map::insert<u64, PublisherNode>(0x2::vec_map::get_mut<0x1::string::String, 0x2::vec_map::VecMap<u64, PublisherNode>>(v2, &arg3), v1.id, v1);
                } else {
                    let v3 = 0x2::vec_map::empty<u64, PublisherNode>();
                    0x2::vec_map::insert<u64, PublisherNode>(&mut v3, v1.id, v1);
                    0x2::vec_map::insert<0x1::string::String, 0x2::vec_map::VecMap<u64, PublisherNode>>(v2, arg3, v3);
                };
                let (_, _) = 0x2::vec_map::remove<address, u64>(&mut arg4.user_stake_info, &arg0);
                0x2::vec_map::insert<address, u64>(&mut arg4.user_stake_info, arg0, *0x2::vec_map::get_mut<address, u64>(&mut arg4.user_stake_info, &arg0) + arg1);
            } else {
                let v6 = 0x2::vec_map::empty<0x1::string::String, 0x2::vec_map::VecMap<u64, PublisherNode>>();
                let v7 = 0x2::vec_map::empty<u64, PublisherNode>();
                0x2::vec_map::insert<u64, PublisherNode>(&mut v7, v1.id, v1);
                0x2::vec_map::insert<0x1::string::String, 0x2::vec_map::VecMap<u64, PublisherNode>>(&mut v6, arg3, v7);
                0x2::vec_map::insert<address, 0x2::vec_map::VecMap<0x1::string::String, 0x2::vec_map::VecMap<u64, PublisherNode>>>(&mut arg4.user_details, arg0, v6);
                0x2::vec_map::insert<address, u64>(&mut arg4.user_stake_info, arg0, arg1);
            };
            v0 = v0 + 1;
        };
        let v8 = UserDetails{
            staker         : arg0,
            staker_details : *0x2::vec_map::get_mut<address, 0x2::vec_map::VecMap<0x1::string::String, 0x2::vec_map::VecMap<u64, PublisherNode>>>(&mut arg4.user_details, &arg0),
        };
        0x2::event::emit<UserDetails>(v8);
    }

    public fun register_publisher_node(arg0: 0x1::string::String, arg1: vector<u64>, arg2: u64, arg3: u64, arg4: address, arg5: &mut PublisherNodeVault, arg6: &0x2::clock::Clock, arg7: &UpgradeVersion) {
        assert!(arg7.version == 0, 2);
        assert!(arg4 != @0x0, 4);
        assert!(arg3 != 0, 5);
        let v0 = 0x1::vector::empty<PublisherNode>();
        let v1 = 0;
        while (v1 < arg3) {
            let v2 = *0x1::vector::borrow<u64>(&arg1, v1);
            assert!(v2 > arg5.node_counter, 11);
            let v3 = PublisherNode{
                id             : v2,
                price          : arg2,
                locking_period : arg5.locking_period,
                owner_address  : arg4,
                timestamp      : 0x2::clock::timestamp_ms(arg6),
            };
            0x1::vector::push_back<PublisherNode>(&mut v0, v3);
            v1 = v1 + 1;
            arg5.node_counter = arg5.node_counter + 1;
        };
        map_publisher_node(arg4, arg2, arg3, arg0, arg5, v0);
    }

    public entry fun reinvest(arg0: &MaintainerRole, arg1: address, arg2: 0x1::string::String, arg3: vector<u64>, arg4: &mut PublisherNodeVault, arg5: &0x2::clock::Clock, arg6: &UpgradeVersion, arg7: &mut 0x2::tx_context::TxContext) {
        let v0 = 0x2::tx_context::sender(arg7);
        assert!(arg6.version == 0, 2);
        assert!(0x2::vec_map::contains<address, 0x2::vec_map::VecMap<0x1::string::String, 0x2::vec_map::VecMap<u64, PublisherNode>>>(&arg4.user_details, &arg1), 6);
        assert!(0x2::vec_set::contains<address>(&arg0.has_maintainer_access, &v0), 12);
        let v1 = 0x2::vec_map::get_mut<0x1::string::String, 0x2::vec_map::VecMap<u64, PublisherNode>>(0x2::vec_map::get_mut<address, 0x2::vec_map::VecMap<0x1::string::String, 0x2::vec_map::VecMap<u64, PublisherNode>>>(&mut arg4.user_details, &arg1), &arg2);
        let v2 = 0;
        let v3 = 0x2::clock::timestamp_ms(arg5);
        while (v2 < 0x1::vector::length<u64>(&arg3)) {
            let v4 = 0x1::vector::borrow<u64>(&arg3, v2);
            assert!(0x2::vec_map::contains<u64, PublisherNode>(v1, v4), 9);
            let v5 = 0x2::vec_map::get<u64, PublisherNode>(v1, v4);
            assert!(v5.locking_period <= v3 - v5.timestamp, 7);
            let v6 = 0x2::vec_map::get_mut<u64, PublisherNode>(v1, v4);
            v6.timestamp = v3;
            v6.locking_period = arg4.locking_period;
            v2 = v2 + 1;
        };
        let v7 = UserDetails{
            staker         : arg1,
            staker_details : *0x2::vec_map::get_mut<address, 0x2::vec_map::VecMap<0x1::string::String, 0x2::vec_map::VecMap<u64, PublisherNode>>>(&mut arg4.user_details, &arg1),
        };
        0x2::event::emit<UserDetails>(v7);
    }

    public entry fun remove_collatoral(arg0: &MaintainerRole, arg1: address, arg2: &mut PublisherNodeVault, arg3: 0x1::string::String, arg4: u64, arg5: &0x2::clock::Clock, arg6: &UpgradeVersion, arg7: &mut 0x2::tx_context::TxContext) {
        let v0 = 0x2::tx_context::sender(arg7);
        assert!(0x2::vec_set::contains<address>(&arg0.has_maintainer_access, &v0), 12);
        assert!(arg6.version == 0, 2);
        assert!(0x2::vec_map::contains<address, 0x2::vec_map::VecMap<0x1::string::String, 0x2::vec_map::VecMap<u64, PublisherNode>>>(&arg2.user_details, &arg1), 6);
        let v1 = 0x2::vec_map::get_mut<0x1::string::String, 0x2::vec_map::VecMap<u64, PublisherNode>>(0x2::vec_map::get_mut<address, 0x2::vec_map::VecMap<0x1::string::String, 0x2::vec_map::VecMap<u64, PublisherNode>>>(&mut arg2.user_details, &arg1), &arg3);
        assert!(0x2::vec_map::contains<u64, PublisherNode>(v1, &arg4), 9);
        let v2 = 0x2::vec_map::get<u64, PublisherNode>(v1, &arg4);
        assert!(v2.locking_period <= 0x2::clock::timestamp_ms(arg5) - v2.timestamp, 7);
        let (_, _) = 0x2::vec_map::remove<address, u64>(&mut arg2.user_stake_info, &arg1);
        0x2::transfer::public_transfer<0x2::coin::Coin<0x4bb07b086c13bda7af26b9872fa8c4b460a9c0479cde6a63de4b9d29ea0ec99a::test_token::TEST_TOKEN>>(0x2::coin::split<0x4bb07b086c13bda7af26b9872fa8c4b460a9c0479cde6a63de4b9d29ea0ec99a::test_token::TEST_TOKEN>(&mut arg2.total_staked, v2.price, arg7), arg1);
        0x2::vec_map::insert<address, u64>(&mut arg2.user_stake_info, arg1, *0x2::vec_map::get<address, u64>(&arg2.user_stake_info, &arg1) - v2.price);
        let (_, _) = 0x2::vec_map::remove<u64, PublisherNode>(v1, &arg4);
        let v7 = UserDetails{
            staker         : arg1,
            staker_details : *0x2::vec_map::get_mut<address, 0x2::vec_map::VecMap<0x1::string::String, 0x2::vec_map::VecMap<u64, PublisherNode>>>(&mut arg2.user_details, &arg1),
        };
        0x2::event::emit<UserDetails>(v7);
    }

    public entry fun revoke_maintainer_role(arg0: &Owner, arg1: &mut MaintainerRole, arg2: &UpgradeVersion, arg3: address, arg4: &0x2::tx_context::TxContext) {
        assert!(arg2.version == 0, 2);
        assert!(0x2::tx_context::sender(arg4) == arg0.owner_address, 3);
        assert!(@0x0 != arg3, 4);
        assert!(0x2::vec_set::contains<address>(&arg1.has_maintainer_access, &arg3), 12);
        assert!(arg3 != arg0.owner_address, 13);
        0x2::vec_set::remove<address>(&mut arg1.has_maintainer_access, &arg3);
        let v0 = MaintainerRoleRevoked{revoke_address: arg3};
        0x2::event::emit<MaintainerRoleRevoked>(v0);
    }

    entry fun upgrade_contract_version(arg0: &Owner, arg1: &mut UpgradeVersion, arg2: &0x2::tx_context::TxContext) {
        assert!(0x2::tx_context::sender(arg2) == arg0.owner_address, 3);
        assert!(arg1.version < 0, 2);
        arg1.version = 0;
    }

    // decompiled from Move bytecode v6
}

