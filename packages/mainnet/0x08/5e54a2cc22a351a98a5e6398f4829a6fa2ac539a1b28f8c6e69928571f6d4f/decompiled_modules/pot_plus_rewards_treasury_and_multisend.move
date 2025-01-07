module 0x85e54a2cc22a351a98a5e6398f4829a6fa2ac539a1b28f8c6e69928571f6d4f::pot_plus_rewards_treasury_and_multisend {
    struct Owner has store, key {
        id: 0x2::object::UID,
        owner_address: address,
    }

    struct UpgradeVersion has key {
        id: 0x2::object::UID,
        version: u64,
    }

    struct PotVault has store, key {
        id: 0x2::object::UID,
        has_distributor_role: 0x2::vec_set::VecSet<address>,
    }

    struct PotVaultBalance<phantom T0> has copy, drop, store {
        dummy_field: bool,
    }

    struct ChangedOwner has copy, drop {
        current_owner: address,
        new_owner: address,
    }

    struct RewardCollected has copy, drop {
        reward_amount: u64,
    }

    struct RewardSent has copy, drop {
        addresses: vector<address>,
        reward_amounts: vector<u64>,
    }

    struct GrantedDistributorRole has copy, drop {
        recipient: address,
    }

    struct RevokedDistributorRole has copy, drop {
        revoked_address: address,
    }

    struct POT_PLUS_REWARDS_TREASURY_AND_MULTISEND has drop {
        dummy_field: bool,
    }

    public entry fun change_owner(arg0: &mut PotVault, arg1: Owner, arg2: address, arg3: &UpgradeVersion, arg4: 0x2::package::UpgradeCap, arg5: &0x2::tx_context::TxContext) {
        let v0 = arg1.owner_address;
        assert!(arg3.version == 0, 2);
        assert!(@0x0 != arg2, 3);
        assert!(0x2::tx_context::sender(arg5) == v0, 1);
        assert!(arg2 != v0, 5);
        0x2::vec_set::remove<address>(&mut arg0.has_distributor_role, &v0);
        0x2::vec_set::insert<address>(&mut arg0.has_distributor_role, arg2);
        arg1.owner_address = arg2;
        0x2::transfer::public_transfer<Owner>(arg1, arg2);
        0x2::transfer::public_transfer<0x2::package::UpgradeCap>(arg4, arg2);
        let v1 = ChangedOwner{
            current_owner : v0,
            new_owner     : arg2,
        };
        0x2::event::emit<ChangedOwner>(v1);
    }

    entry fun collect_reward<T0>(arg0: 0x2::transfer::Receiving<0x2::coin::Coin<T0>>, arg1: &mut PotVault, arg2: &UpgradeVersion, arg3: &0x2::tx_context::TxContext) {
        let v0 = 0x2::tx_context::sender(arg3);
        assert!(arg2.version == 0, 2);
        assert!(0x2::vec_set::contains<address>(&arg1.has_distributor_role, &v0), 9);
        let v1 = 0x2::transfer::public_receive<0x2::coin::Coin<T0>>(&mut arg1.id, arg0);
        let v2 = PotVaultBalance<T0>{dummy_field: false};
        let v3 = &mut arg1.id;
        if (0x2::dynamic_field::exists_<PotVaultBalance<T0>>(v3, v2)) {
            0x2::coin::join<T0>(0x2::dynamic_field::borrow_mut<PotVaultBalance<T0>, 0x2::coin::Coin<T0>>(v3, v2), v1);
        } else {
            0x2::dynamic_field::add<PotVaultBalance<T0>, 0x2::coin::Coin<T0>>(v3, v2, v1);
        };
        let v4 = RewardCollected{reward_amount: 0x2::coin::value<T0>(&v1)};
        0x2::event::emit<RewardCollected>(v4);
    }

    public entry fun grant_distributor_role(arg0: &Owner, arg1: &mut PotVault, arg2: &UpgradeVersion, arg3: address, arg4: &mut 0x2::tx_context::TxContext) {
        assert!(arg2.version == 0, 2);
        assert!(0x2::tx_context::sender(arg4) == arg0.owner_address, 1);
        assert!(@0x0 != arg3, 3);
        assert!(!0x2::vec_set::contains<address>(&arg1.has_distributor_role, &arg3), 8);
        0x2::vec_set::insert<address>(&mut arg1.has_distributor_role, arg3);
        let v0 = GrantedDistributorRole{recipient: arg3};
        0x2::event::emit<GrantedDistributorRole>(v0);
    }

    fun init(arg0: POT_PLUS_REWARDS_TREASURY_AND_MULTISEND, arg1: &mut 0x2::tx_context::TxContext) {
        let v0 = 0x2::tx_context::sender(arg1);
        let v1 = PotVault{
            id                   : 0x2::object::new(arg1),
            has_distributor_role : 0x2::vec_set::empty<address>(),
        };
        0x2::vec_set::insert<address>(&mut v1.has_distributor_role, v0);
        0x2::transfer::share_object<PotVault>(v1);
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

    entry fun migrate(arg0: &Owner, arg1: &mut UpgradeVersion, arg2: &0x2::tx_context::TxContext) {
        assert!(0x2::tx_context::sender(arg2) == arg0.owner_address, 1);
        assert!(arg1.version < 0, 2);
        arg1.version = 0;
    }

    public entry fun revoke_distributor_role(arg0: &Owner, arg1: &mut PotVault, arg2: address, arg3: &UpgradeVersion, arg4: &mut 0x2::tx_context::TxContext) {
        assert!(arg3.version == 0, 2);
        let v0 = arg0.owner_address;
        assert!(0x2::tx_context::sender(arg4) == v0, 1);
        assert!(0x2::vec_set::contains<address>(&arg1.has_distributor_role, &arg2), 9);
        assert!(arg2 != v0, 10);
        0x2::vec_set::remove<address>(&mut arg1.has_distributor_role, &arg2);
        let v1 = RevokedDistributorRole{revoked_address: arg2};
        0x2::event::emit<RevokedDistributorRole>(v1);
    }

    public entry fun send_reward<T0>(arg0: vector<address>, arg1: vector<u64>, arg2: &mut PotVault, arg3: &UpgradeVersion, arg4: &mut 0x2::tx_context::TxContext) {
        let v0 = @0x0;
        let v1 = 0x2::tx_context::sender(arg4);
        assert!(arg3.version == 0, 2);
        assert!(0x1::vector::length<address>(&arg0) == 0x1::vector::length<u64>(&arg1), 4);
        assert!(!0x1::vector::contains<address>(&arg0, &v0), 3);
        let v2 = 0;
        assert!(!0x1::vector::contains<u64>(&arg1, &v2), 6);
        assert!(0x2::vec_set::contains<address>(&arg2.has_distributor_role, &v1), 9);
        let v3 = PotVaultBalance<T0>{dummy_field: false};
        let v4 = &mut arg2.id;
        assert!(0x2::dynamic_field::exists_<PotVaultBalance<T0>>(v4, v3), 7);
        let v5 = 0x2::dynamic_field::borrow_mut<PotVaultBalance<T0>, 0x2::coin::Coin<T0>>(v4, v3);
        split_and_transfer<T0>(arg0, arg1, v5, arg4);
        let v6 = RewardSent{
            addresses      : arg0,
            reward_amounts : arg1,
        };
        0x2::event::emit<RewardSent>(v6);
    }

    fun split_and_transfer<T0>(arg0: vector<address>, arg1: vector<u64>, arg2: &mut 0x2::coin::Coin<T0>, arg3: &mut 0x2::tx_context::TxContext) {
        let v0 = 0;
        let v1 = 0;
        while (v0 < 0x1::vector::length<address>(&arg0)) {
            let v2 = v1 + *0x1::vector::borrow<u64>(&arg1, v0);
            v1 = v2;
            assert!(v2 <= 0x2::balance::value<T0>(0x2::coin::balance<T0>(arg2)), 7);
            0x2::transfer::public_transfer<0x2::coin::Coin<T0>>(0x2::coin::split<T0>(arg2, *0x1::vector::borrow<u64>(&arg1, v0), arg3), *0x1::vector::borrow<address>(&arg0, v0));
            v0 = v0 + 1;
        };
    }

    // decompiled from Move bytecode v6
}

