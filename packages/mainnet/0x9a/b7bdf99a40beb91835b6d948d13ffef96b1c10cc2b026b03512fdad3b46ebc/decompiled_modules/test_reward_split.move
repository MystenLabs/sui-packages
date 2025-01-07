module 0x9ab7bdf99a40beb91835b6d948d13ffef96b1c10cc2b026b03512fdad3b46ebc::test_reward_split {
    struct Owner has store, key {
        id: 0x2::object::UID,
        owner_address: address,
    }

    struct UpgradeVersion has key {
        id: 0x2::object::UID,
        version: u64,
    }

    struct DistributorVault has store, key {
        id: 0x2::object::UID,
        category_locker: 0x2::vec_map::VecMap<0x1::string::String, u64>,
        address_locker: 0x2::vec_map::VecMap<0x1::string::String, address>,
        is_object_ids_exist: bool,
        is_category_names_exist: bool,
    }

    struct DistributorVaultBalance<phantom T0> has copy, drop, store {
        dummy_field: bool,
    }

    struct TEST_REWARD_SPLIT has drop {
        dummy_field: bool,
    }

    fun calculate_reward_amount(arg0: vector<u64>, arg1: u64) : vector<u64> {
        let v0 = 0x1::vector::empty<u64>();
        let v1 = 0;
        while (v1 < 0x1::vector::length<u64>(&arg0)) {
            0x1::vector::insert<u64>(&mut v0, (((arg1 as u256) * (*0x1::vector::borrow<u64>(&arg0, v1) as u256) / 10000) as u64), v1);
            v1 = v1 + 1;
        };
        v0
    }

    entry fun change_owner(arg0: Owner, arg1: address, arg2: &UpgradeVersion, arg3: 0x2::package::UpgradeCap, arg4: &0x2::tx_context::TxContext) {
        let v0 = arg0.owner_address;
        assert!(arg2.version == 0, 2);
        assert!(@0x0 != arg1, 3);
        assert!(0x2::tx_context::sender(arg4) == v0, 1);
        assert!(arg1 != v0, 4);
        arg0.owner_address = arg1;
        0x2::transfer::public_transfer<Owner>(arg0, arg1);
        0x2::transfer::public_transfer<0x2::package::UpgradeCap>(arg3, arg1);
        0x9ab7bdf99a40beb91835b6d948d13ffef96b1c10cc2b026b03512fdad3b46ebc::reward_events::changed_owner_event(v0, arg1);
    }

    fun collect_rewards<T0>(arg0: 0x2::transfer::Receiving<0x2::coin::Coin<T0>>, arg1: &mut DistributorVault) {
        let v0 = 0x2::transfer::public_receive<0x2::coin::Coin<T0>>(&mut arg1.id, arg0);
        let v1 = DistributorVaultBalance<T0>{dummy_field: false};
        let v2 = &mut arg1.id;
        if (0x2::dynamic_field::exists_<DistributorVaultBalance<T0>>(v2, v1)) {
            0x9ab7bdf99a40beb91835b6d948d13ffef96b1c10cc2b026b03512fdad3b46ebc::reward_events::received_token_event(0x2::coin::value<T0>(&v0));
            0x2::coin::join<T0>(0x2::dynamic_field::borrow_mut<DistributorVaultBalance<T0>, 0x2::coin::Coin<T0>>(v2, v1), v0);
        } else {
            0x9ab7bdf99a40beb91835b6d948d13ffef96b1c10cc2b026b03512fdad3b46ebc::reward_events::received_token_event(0x2::coin::value<T0>(&v0));
            0x2::dynamic_field::add<DistributorVaultBalance<T0>, 0x2::coin::Coin<T0>>(v2, v1, v0);
        };
    }

    entry fun distribute_rewards<T0>(arg0: 0x2::transfer::Receiving<0x2::coin::Coin<T0>>, arg1: &mut DistributorVault, arg2: &UpgradeVersion, arg3: &mut 0x2::tx_context::TxContext) {
        assert!(arg2.version == 0, 2);
        collect_rewards<T0>(arg0, arg1);
        let v0 = &mut arg1.id;
        let v1 = DistributorVaultBalance<T0>{dummy_field: false};
        assert!(0x2::dynamic_field::exists_<DistributorVaultBalance<T0>>(v0, v1), 9);
        let v2 = 0x2::dynamic_field::borrow_mut<DistributorVaultBalance<T0>, 0x2::coin::Coin<T0>>(v0, v1);
        let v3 = 0x2::balance::value<T0>(0x2::coin::balance<T0>(v2));
        assert!(v3 != 0, 9);
        assert!(arg1.is_object_ids_exist == true, 10);
        let (v4, v5) = 0x2::vec_map::into_keys_values<0x1::string::String, address>(arg1.address_locker);
        let (_, v7) = 0x2::vec_map::into_keys_values<0x1::string::String, u64>(arg1.category_locker);
        let v8 = calculate_reward_amount(v7, v3);
        send_rewards<T0>(v5, v2, v8, arg3);
        0x9ab7bdf99a40beb91835b6d948d13ffef96b1c10cc2b026b03512fdad3b46ebc::reward_events::distribute_rewards_event(v4, v8);
    }

    public fun distributor_vault_init(arg0: &mut 0x2::tx_context::TxContext) : DistributorVault {
        let v0 = DistributorVault{
            id                      : 0x2::object::new(arg0),
            category_locker         : 0x2::vec_map::empty<0x1::string::String, u64>(),
            address_locker          : 0x2::vec_map::empty<0x1::string::String, address>(),
            is_object_ids_exist     : false,
            is_category_names_exist : false,
        };
        0x2::vec_map::insert<0x1::string::String, u64>(&mut v0.category_locker, 0x1::string::utf8(b"Test_Public_Staking"), 375);
        0x2::vec_map::insert<0x1::string::String, u64>(&mut v0.category_locker, 0x1::string::utf8(b"GTH_Staked_Holding_Migration"), 725);
        0x2::vec_map::insert<0x1::string::String, u64>(&mut v0.category_locker, 0x1::string::utf8(b"POT_Base_Rewards"), 1750);
        0x2::vec_map::insert<0x1::string::String, u64>(&mut v0.category_locker, 0x1::string::utf8(b"POT_Plus_Boost"), 1050);
        0x2::vec_map::insert<0x1::string::String, u64>(&mut v0.category_locker, 0x1::string::utf8(b"POT_Plus"), 1750);
        0x2::vec_map::insert<0x1::string::String, u64>(&mut v0.category_locker, 0x1::string::utf8(b"Master_Node"), 2000);
        0x2::vec_map::insert<0x1::string::String, u64>(&mut v0.category_locker, 0x1::string::utf8(b"Loyalty_Pool"), 250);
        0x2::vec_map::insert<0x1::string::String, u64>(&mut v0.category_locker, 0x1::string::utf8(b"Test"), 2100);
        v0
    }

    public fun distributor_vault_init_for_test(arg0: &mut 0x2::tx_context::TxContext) : DistributorVault {
        let v0 = DistributorVault{
            id                      : 0x2::object::new(arg0),
            category_locker         : 0x2::vec_map::empty<0x1::string::String, u64>(),
            address_locker          : 0x2::vec_map::empty<0x1::string::String, address>(),
            is_object_ids_exist     : false,
            is_category_names_exist : false,
        };
        0x2::vec_map::insert<0x1::string::String, u64>(&mut v0.category_locker, 0x1::string::utf8(b"POT"), 1750);
        0x2::vec_map::insert<0x1::string::String, u64>(&mut v0.category_locker, 0x1::string::utf8(b"PUBLISHERNODE"), 1050);
        0x2::vec_map::insert<0x1::string::String, u64>(&mut v0.category_locker, 0x1::string::utf8(b"CLASSICSTAKING"), 2100);
        0x2::vec_map::insert<0x1::string::String, u64>(&mut v0.category_locker, 0x1::string::utf8(b"MASTERNODE"), 750);
        0x2::vec_map::insert<0x1::string::String, u64>(&mut v0.category_locker, 0x1::string::utf8(b"OWNERSOFPUBLISHERNODE"), 2000);
        0x2::vec_map::insert<0x1::string::String, u64>(&mut v0.category_locker, 0x1::string::utf8(b"LOYALTYPOOL"), 250);
        0x2::vec_map::insert<0x1::string::String, u64>(&mut v0.category_locker, 0x1::string::utf8(b"TEST"), 2100);
        v0
    }

    public fun get_category_percentage(arg0: &DistributorVault, arg1: &0x1::string::String) : u64 {
        let v0 = 0x2::vec_map::get<0x1::string::String, u64>(&arg0.category_locker, arg1);
        0x9ab7bdf99a40beb91835b6d948d13ffef96b1c10cc2b026b03512fdad3b46ebc::reward_events::get_category_name_and_percentage_event(*arg1, *v0);
        *v0
    }

    fun init(arg0: TEST_REWARD_SPLIT, arg1: &mut 0x2::tx_context::TxContext) {
        let v0 = 0x2::tx_context::sender(arg1);
        let v1 = distributor_vault_init(arg1);
        0x2::transfer::share_object<DistributorVault>(v1);
        let v2 = Owner{
            id            : 0x2::object::new(arg1),
            owner_address : v0,
        };
        0x2::transfer::public_transfer<Owner>(v2, v0);
        let v3 = UpgradeVersion{
            id      : 0x2::object::new(arg1),
            version : 0,
        };
        0x2::transfer::share_object<UpgradeVersion>(v3);
    }

    entry fun receiver_contract_ids(arg0: &Owner, arg1: &UpgradeVersion, arg2: &mut DistributorVault, arg3: vector<0x1::string::String>, arg4: vector<address>, arg5: &0x2::tx_context::TxContext) {
        let v0 = @0x0;
        assert!(!0x1::vector::contains<address>(&arg4, &v0), 3);
        if (!arg2.is_object_ids_exist) {
            arg2.is_object_ids_exist = true;
        };
        assert!(0x2::tx_context::sender(arg5) == arg0.owner_address, 1);
        assert!(arg1.version == 0, 2);
        let v1 = 0x2::vec_map::size<0x1::string::String, u64>(&arg2.category_locker);
        let v2 = 0x1::vector::length<0x1::string::String>(&arg3);
        assert!(&v1 == &v2, 5);
        let v3 = 0;
        while (v3 < 0x1::vector::length<0x1::string::String>(&arg3)) {
            assert!(0x2::vec_map::contains<0x1::string::String, u64>(&arg2.category_locker, 0x1::vector::borrow<0x1::string::String>(&arg3, v3)), 11);
            v3 = v3 + 1;
        };
        update_receiver_contract_ids(arg2, arg3, arg4);
        0x9ab7bdf99a40beb91835b6d948d13ffef96b1c10cc2b026b03512fdad3b46ebc::reward_events::receiver_contract_ids_event(arg3, arg4);
    }

    fun send_rewards<T0>(arg0: vector<address>, arg1: &mut 0x2::coin::Coin<T0>, arg2: vector<u64>, arg3: &mut 0x2::tx_context::TxContext) {
        let v0 = 0;
        while (v0 < 0x1::vector::length<address>(&arg0)) {
            let v1 = *0x1::vector::borrow<u64>(&arg2, v0);
            if (v1 != 0) {
                0x2::transfer::public_transfer<0x2::coin::Coin<T0>>(0x2::coin::split<T0>(arg1, v1, arg3), *0x1::vector::borrow<address>(&arg0, v0));
            };
            v0 = v0 + 1;
        };
    }

    fun update_category(arg0: &Owner, arg1: &mut DistributorVault, arg2: vector<0x1::string::String>, arg3: vector<u64>, arg4: &0x2::tx_context::TxContext) {
        assert!(0x2::tx_context::sender(arg4) == arg0.owner_address, 1);
        let v0 = 0x1::vector::length<0x1::string::String>(&arg2);
        let v1 = 0x1::vector::length<u64>(&arg3);
        let v2 = 0x1::vector::empty<0x1::string::String>();
        assert!(&v0 == &v1, 5);
        let v3 = 0;
        while (v3 < v0) {
            let v4 = *0x1::vector::borrow<0x1::string::String>(&arg2, v3);
            assert!(!0x1::vector::contains<0x1::string::String>(&v2, &v4), 7);
            0x1::vector::push_back<0x1::string::String>(&mut v2, *0x1::vector::borrow<0x1::string::String>(&arg2, v3));
            if (0x2::vec_map::contains<0x1::string::String, u64>(&arg1.category_locker, &v4)) {
                let (_, _) = 0x2::vec_map::remove<0x1::string::String, u64>(&mut arg1.category_locker, &v4);
                0x2::vec_map::insert<0x1::string::String, u64>(&mut arg1.category_locker, v4, *0x1::vector::borrow<u64>(&arg3, v3));
            } else {
                0x2::vec_map::insert<0x1::string::String, u64>(&mut arg1.category_locker, v4, *0x1::vector::borrow<u64>(&arg3, v3));
            };
            v3 = v3 + 1;
        };
    }

    entry fun update_category_and_percentages(arg0: &Owner, arg1: &UpgradeVersion, arg2: &mut DistributorVault, arg3: vector<0x1::string::String>, arg4: vector<u64>, arg5: vector<address>, arg6: &0x2::tx_context::TxContext) {
        assert!(arg1.version == 0, 2);
        arg2.category_locker = 0x2::vec_map::empty<0x1::string::String, u64>();
        update_category(arg0, arg2, arg3, arg4, arg6);
        if (!arg2.is_object_ids_exist) {
            arg2.is_object_ids_exist = true;
        };
        let (_, v1) = 0x2::vec_map::into_keys_values<0x1::string::String, u64>(arg2.category_locker);
        let v2 = v1;
        let v3 = 0;
        let v4 = 0;
        while (v3 < 0x1::vector::length<u64>(&v2)) {
            v4 = v4 + *0x1::vector::borrow<u64>(&v2, v3);
            v3 = v3 + 1;
        };
        assert!(v4 == 10000, 6);
        0x9ab7bdf99a40beb91835b6d948d13ffef96b1c10cc2b026b03512fdad3b46ebc::reward_events::category_names_and_percentage_event(arg3, arg4, arg5);
        arg2.address_locker = 0x2::vec_map::empty<0x1::string::String, address>();
        update_receiver_contract_ids(arg2, arg3, arg5);
    }

    fun update_receiver_contract_ids(arg0: &mut DistributorVault, arg1: vector<0x1::string::String>, arg2: vector<address>) {
        let v0 = 0x1::vector::length<0x1::string::String>(&arg1);
        let v1 = 0x1::vector::length<address>(&arg2);
        let v2 = 0x1::vector::empty<0x1::string::String>();
        let v3 = 0x1::vector::empty<address>();
        assert!(&v0 == &v1, 5);
        let v4 = 0;
        while (v4 < v0) {
            let v5 = *0x1::vector::borrow<0x1::string::String>(&arg1, v4);
            let v6 = *0x1::vector::borrow<address>(&arg2, v4);
            assert!(!0x1::vector::contains<0x1::string::String>(&v2, &v5), 7);
            0x1::vector::push_back<0x1::string::String>(&mut v2, *0x1::vector::borrow<0x1::string::String>(&arg1, v4));
            assert!(!0x1::vector::contains<address>(&v3, &v6), 8);
            0x1::vector::push_back<address>(&mut v3, *0x1::vector::borrow<address>(&arg2, v4));
            if (0x2::vec_map::contains<0x1::string::String, address>(&arg0.address_locker, &v5)) {
                let (_, _) = 0x2::vec_map::remove<0x1::string::String, address>(&mut arg0.address_locker, &v5);
                0x2::vec_map::insert<0x1::string::String, address>(&mut arg0.address_locker, v5, v6);
            } else {
                0x2::vec_map::insert<0x1::string::String, address>(&mut arg0.address_locker, v5, v6);
            };
            v4 = v4 + 1;
        };
    }

    entry fun upgrade_contract_version(arg0: &Owner, arg1: &mut UpgradeVersion, arg2: &0x2::tx_context::TxContext) {
        assert!(0x2::tx_context::sender(arg2) == arg0.owner_address, 1);
        assert!(arg1.version < 0, 2);
        arg1.version = 0;
    }

    // decompiled from Move bytecode v6
}

