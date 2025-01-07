module 0x4bb07b086c13bda7af26b9872fa8c4b460a9c0479cde6a63de4b9d29ea0ec99a::test_token {
    struct TEST_TOKEN has drop {
        dummy_field: bool,
    }

    struct Owner has store, key {
        id: 0x2::object::UID,
        owner: address,
    }

    struct TreasuryLock has key {
        id: 0x2::object::UID,
        treasury_cap: 0x2::coin::TreasuryCap<TEST_TOKEN>,
    }

    struct AllowanceDetails has copy, drop, store {
        total_allowance: u64,
        remaining_allowance: u64,
    }

    struct MinterRole has key {
        id: 0x2::object::UID,
        has_limited_mint_access: 0x2::vec_map::VecMap<address, AllowanceDetails>,
        has_unlimited_mint_access: 0x2::vec_set::VecSet<address>,
    }

    struct UpgradeVersion has key {
        id: 0x2::object::UID,
        version: u64,
    }

    struct MintedTokens has copy, drop {
        minted_amount: u64,
        recipient: address,
    }

    struct BurnedTokens has copy, drop {
        burned_amount: u64,
        recipient: address,
    }

    struct ChangedOwner has copy, drop {
        current_owner: address,
        new_owner: address,
    }

    struct AddedToBlackList has copy, drop {
        blacklisted_users: vector<address>,
        already_blacklisted_users: vector<address>,
    }

    struct RemovedFromBlackList has copy, drop {
        removed_from_blacklist: vector<address>,
    }

    struct TotalSupply has copy, drop {
        total_supply: u64,
    }

    struct OwnerAddress has copy, drop {
        owner_address: address,
    }

    struct GrantedMinterRole has copy, drop {
        recipient: address,
        granted_limited_allowance: 0x1::option::Option<AllowanceDetails>,
        granted_unlimited_allowance: 0x1::option::Option<0x1::string::String>,
    }

    struct RevokedMinterRole has copy, drop {
        revoked_address: address,
    }

    struct UpdatedMintAllowance has copy, drop {
        minter: address,
        updated_limited_allowance: 0x1::option::Option<AllowanceDetails>,
        updated_unlimited_allowance: 0x1::option::Option<0x1::string::String>,
    }

    public entry fun burn(arg0: &mut 0x2::deny_list::DenyList, arg1: &mut TreasuryLock, arg2: &mut 0x2::coin::Coin<TEST_TOKEN>, arg3: u64, arg4: &UpgradeVersion, arg5: &mut 0x2::tx_context::TxContext) {
        assert!(arg4.version == 0, 9);
        assert!(arg3 != 0, 3);
        let v0 = 0x2::tx_context::sender(arg5);
        assert!(!0x2::coin::deny_list_contains<TEST_TOKEN>(arg0, v0), 7);
        0x2::coin::burn<TEST_TOKEN>(&mut arg1.treasury_cap, 0x2::coin::take<TEST_TOKEN>(0x2::coin::balance_mut<TEST_TOKEN>(arg2), arg3, arg5));
        let v1 = BurnedTokens{
            burned_amount : arg3,
            recipient     : v0,
        };
        0x2::event::emit<BurnedTokens>(v1);
    }

    public entry fun total_supply(arg0: &TreasuryLock, arg1: &UpgradeVersion) : u64 {
        let v0 = 0x2::coin::total_supply<TEST_TOKEN>(&arg0.treasury_cap);
        assert!(arg1.version == 0, 9);
        let v1 = TotalSupply{total_supply: v0};
        0x2::event::emit<TotalSupply>(v1);
        v0
    }

    public entry fun add_addr_to_blacklist(arg0: &mut 0x2::deny_list::DenyList, arg1: &mut 0x2::coin::DenyCap<TEST_TOKEN>, arg2: &Owner, arg3: vector<address>, arg4: &UpgradeVersion, arg5: &mut 0x2::tx_context::TxContext) {
        assert!(arg4.version == 0, 9);
        let v0 = 0;
        let v1 = 0x1::vector::empty<address>();
        let v2 = 0x1::vector::empty<address>();
        while (v0 < 0x1::vector::length<address>(&arg3)) {
            let v3 = 0x1::vector::pop_back<address>(&mut arg3);
            if (0x2::coin::deny_list_contains<TEST_TOKEN>(arg0, v3)) {
                assert!(v3 != arg2.owner, 5);
                0x1::vector::push_back<address>(&mut v2, v3);
            } else {
                assert!(v3 != arg2.owner, 5);
                assert!(@0x0 != v3, 4);
                0x1::vector::push_back<address>(&mut v1, v3);
                0x2::coin::deny_list_add<TEST_TOKEN>(arg0, arg1, v3, arg5);
            };
            v0 = v0 + 1;
        };
        let v4 = AddedToBlackList{
            blacklisted_users         : v1,
            already_blacklisted_users : v2,
        };
        0x2::event::emit<AddedToBlackList>(v4);
    }

    public entry fun change_owner(arg0: 0x2::coin::DenyCap<TEST_TOKEN>, arg1: 0x2::package::UpgradeCap, arg2: &0x2::deny_list::DenyList, arg3: &mut MinterRole, arg4: Owner, arg5: address, arg6: &UpgradeVersion, arg7: &0x2::tx_context::TxContext) {
        let v0 = arg4.owner;
        assert!(arg6.version == 0, 9);
        assert!(@0x0 != arg5, 4);
        assert!(0x2::tx_context::sender(arg7) == v0, 1);
        assert!(arg5 != v0, 2);
        assert!(!0x2::coin::deny_list_contains<TEST_TOKEN>(arg2, arg5), 6);
        arg4.owner = arg5;
        0x2::vec_set::remove<address>(&mut arg3.has_unlimited_mint_access, &v0);
        0x2::vec_set::insert<address>(&mut arg3.has_unlimited_mint_access, arg5);
        0x2::transfer::public_transfer<Owner>(arg4, arg5);
        0x2::transfer::public_transfer<0x2::coin::DenyCap<TEST_TOKEN>>(arg0, arg5);
        0x2::transfer::public_transfer<0x2::package::UpgradeCap>(arg1, arg5);
        let v1 = ChangedOwner{
            current_owner : v0,
            new_owner     : arg5,
        };
        0x2::event::emit<ChangedOwner>(v1);
    }

    fun event_updated_mint_allowance(arg0: 0x1::option::Option<AllowanceDetails>, arg1: 0x1::option::Option<0x1::string::String>, arg2: address) {
        let v0 = UpdatedMintAllowance{
            minter                      : arg2,
            updated_limited_allowance   : arg0,
            updated_unlimited_allowance : arg1,
        };
        0x2::event::emit<UpdatedMintAllowance>(v0);
    }

    fun execute_minting_based_on_allowance(arg0: &mut MinterRole, arg1: address, arg2: &mut TreasuryLock, arg3: u64, arg4: address, arg5: &mut 0x2::tx_context::TxContext) {
        if (0x2::vec_set::contains<address>(&arg0.has_unlimited_mint_access, &arg1)) {
            0x2::coin::mint_and_transfer<TEST_TOKEN>(&mut arg2.treasury_cap, arg3, arg4, arg5);
            event_updated_mint_allowance(0x1::option::none<AllowanceDetails>(), 0x1::option::some<0x1::string::String>(0x1::string::utf8(b"unlimited mint allowance exist")), arg1);
        } else {
            let v0 = 0x2::vec_map::get_mut<address, AllowanceDetails>(&mut arg0.has_limited_mint_access, &arg1);
            let v1 = v0.remaining_allowance;
            let v2 = v0.total_allowance;
            assert!(arg3 <= v1, 11);
            0x2::coin::mint_and_transfer<TEST_TOKEN>(&mut arg2.treasury_cap, arg3, arg4, arg5);
            let (_, _) = 0x2::vec_map::remove<address, AllowanceDetails>(&mut arg0.has_limited_mint_access, &arg1);
            let v5 = AllowanceDetails{
                total_allowance     : v2,
                remaining_allowance : v1 - arg3,
            };
            0x2::vec_map::insert<address, AllowanceDetails>(&mut arg0.has_limited_mint_access, arg1, v5);
            event_updated_mint_allowance(0x1::option::some<AllowanceDetails>(v5), 0x1::option::none<0x1::string::String>(), arg1);
        };
    }

    public entry fun get_owner_address(arg0: &Owner, arg1: &UpgradeVersion) : address {
        let v0 = arg0.owner;
        assert!(arg1.version == 0, 9);
        let v1 = OwnerAddress{owner_address: v0};
        0x2::event::emit<OwnerAddress>(v1);
        v0
    }

    public entry fun grant_minter_role(arg0: &0x2::deny_list::DenyList, arg1: &Owner, arg2: &mut MinterRole, arg3: &UpgradeVersion, arg4: address, arg5: 0x1::option::Option<u64>, arg6: &mut 0x2::tx_context::TxContext) {
        assert!(arg3.version == 0, 9);
        assert!(0x2::tx_context::sender(arg6) == arg1.owner, 1);
        assert!(@0x0 != arg4, 4);
        assert!(!0x2::coin::deny_list_contains<TEST_TOKEN>(arg0, arg4), 7);
        assert!(!0x2::vec_set::contains<address>(&arg2.has_unlimited_mint_access, &arg4) && !0x2::vec_map::contains<address, AllowanceDetails>(&arg2.has_limited_mint_access, &arg4), 8);
        let v0 = GrantedMinterRole{
            recipient                   : arg4,
            granted_limited_allowance   : 0x1::option::none<AllowanceDetails>(),
            granted_unlimited_allowance : 0x1::option::none<0x1::string::String>(),
        };
        if (0x1::option::is_none<u64>(&arg5)) {
            v0.granted_unlimited_allowance = 0x1::option::some<0x1::string::String>(0x1::string::utf8(b"unlimited mint allowance allocated"));
            0x2::vec_set::insert<address>(&mut arg2.has_unlimited_mint_access, arg4);
        } else {
            let v1 = 0x1::option::extract<u64>(&mut arg5);
            let v2 = AllowanceDetails{
                total_allowance     : v1,
                remaining_allowance : v1,
            };
            v0.granted_limited_allowance = 0x1::option::some<AllowanceDetails>(v2);
            0x2::vec_map::insert<address, AllowanceDetails>(&mut arg2.has_limited_mint_access, arg4, v2);
        };
        0x2::event::emit<GrantedMinterRole>(v0);
    }

    fun init(arg0: TEST_TOKEN, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1, v2) = 0x2::coin::create_regulated_currency<TEST_TOKEN>(arg0, 9, b"TT", b"TestToken", b"Utility Coin for Test Token", 0x1::option::none<0x2::url::Url>(), arg1);
        let v3 = 0x2::tx_context::sender(arg1);
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<TEST_TOKEN>>(v2);
        0x2::transfer::public_transfer<0x2::coin::DenyCap<TEST_TOKEN>>(v1, v3);
        let v4 = TreasuryLock{
            id           : 0x2::object::new(arg1),
            treasury_cap : v0,
        };
        let v5 = MinterRole{
            id                        : 0x2::object::new(arg1),
            has_limited_mint_access   : 0x2::vec_map::empty<address, AllowanceDetails>(),
            has_unlimited_mint_access : 0x2::vec_set::empty<address>(),
        };
        0x2::vec_set::insert<address>(&mut v5.has_unlimited_mint_access, v3);
        0x2::transfer::share_object<MinterRole>(v5);
        let v6 = Owner{
            id    : 0x2::object::new(arg1),
            owner : v3,
        };
        0x2::transfer::public_transfer<Owner>(v6, v3);
        0x2::transfer::share_object<TreasuryLock>(v4);
        let v7 = UpgradeVersion{
            id      : 0x2::object::new(arg1),
            version : 0,
        };
        0x2::transfer::share_object<UpgradeVersion>(v7);
    }

    entry fun migrate(arg0: &Owner, arg1: &mut UpgradeVersion, arg2: &0x2::tx_context::TxContext) {
        assert!(0x2::tx_context::sender(arg2) == arg0.owner, 1);
        assert!(arg1.version < 0, 9);
        arg1.version = 0;
    }

    public entry fun mint(arg0: &mut 0x2::deny_list::DenyList, arg1: &mut TreasuryLock, arg2: &mut MinterRole, arg3: u64, arg4: address, arg5: &UpgradeVersion, arg6: &mut 0x2::tx_context::TxContext) {
        let v0 = 0x2::tx_context::sender(arg6);
        assert!(arg5.version == 0, 9);
        assert!(arg3 != 0, 3);
        assert!(0x2::vec_set::contains<address>(&arg2.has_unlimited_mint_access, &v0) || 0x2::vec_map::contains<address, AllowanceDetails>(&arg2.has_limited_mint_access, &v0), 10);
        assert!(@0x0 != arg4, 4);
        assert!(!0x2::coin::deny_list_contains<TEST_TOKEN>(arg0, arg4), 7);
        assert!(!0x2::coin::deny_list_contains<TEST_TOKEN>(arg0, v0), 7);
        execute_minting_based_on_allowance(arg2, v0, arg1, arg3, arg4, arg6);
        let v1 = MintedTokens{
            minted_amount : arg3,
            recipient     : arg4,
        };
        0x2::event::emit<MintedTokens>(v1);
    }

    public entry fun remove_addr_from_blacklist(arg0: &mut 0x2::deny_list::DenyList, arg1: &mut 0x2::coin::DenyCap<TEST_TOKEN>, arg2: vector<address>, arg3: &UpgradeVersion, arg4: &mut 0x2::tx_context::TxContext) {
        assert!(arg3.version == 0, 9);
        let v0 = 0;
        while (v0 < 0x1::vector::length<address>(&arg2)) {
            0x2::coin::deny_list_remove<TEST_TOKEN>(arg0, arg1, 0x1::vector::pop_back<address>(&mut arg2), arg4);
            v0 = v0 + 1;
        };
        let v1 = RemovedFromBlackList{removed_from_blacklist: arg2};
        0x2::event::emit<RemovedFromBlackList>(v1);
    }

    public entry fun revoke_minter_role(arg0: &Owner, arg1: &mut MinterRole, arg2: address, arg3: &UpgradeVersion, arg4: &mut 0x2::tx_context::TxContext) {
        assert!(arg3.version == 0, 9);
        let v0 = arg0.owner;
        assert!(0x2::tx_context::sender(arg4) == v0, 1);
        assert!(0x2::vec_map::contains<address, AllowanceDetails>(&arg1.has_limited_mint_access, &arg2) || 0x2::vec_set::contains<address>(&arg1.has_unlimited_mint_access, &arg2), 10);
        assert!(arg2 != v0, 5);
        if (0x2::vec_map::contains<address, AllowanceDetails>(&arg1.has_limited_mint_access, &arg2)) {
            let (_, _) = 0x2::vec_map::remove<address, AllowanceDetails>(&mut arg1.has_limited_mint_access, &arg2);
        } else {
            0x2::vec_set::remove<address>(&mut arg1.has_unlimited_mint_access, &arg2);
        };
        let v3 = RevokedMinterRole{revoked_address: arg2};
        0x2::event::emit<RevokedMinterRole>(v3);
    }

    public entry fun update_mint_allowance(arg0: &0x2::deny_list::DenyList, arg1: &Owner, arg2: &mut MinterRole, arg3: address, arg4: 0x1::option::Option<u64>, arg5: &UpgradeVersion, arg6: &0x2::tx_context::TxContext) {
        assert!(arg5.version == 0, 9);
        let v0 = arg1.owner;
        assert!(!0x2::coin::deny_list_contains<TEST_TOKEN>(arg0, arg3), 7);
        assert!(0x2::tx_context::sender(arg6) == v0, 1);
        assert!(0x2::vec_map::contains<address, AllowanceDetails>(&arg2.has_limited_mint_access, &arg3) || 0x2::vec_set::contains<address>(&arg2.has_unlimited_mint_access, &arg3), 10);
        assert!(arg3 != v0, 5);
        if (0x2::vec_map::contains<address, AllowanceDetails>(&arg2.has_limited_mint_access, &arg3)) {
            let (_, _) = 0x2::vec_map::remove<address, AllowanceDetails>(&mut arg2.has_limited_mint_access, &arg3);
        } else {
            0x2::vec_set::remove<address>(&mut arg2.has_unlimited_mint_access, &arg3);
        };
        if (0x1::option::is_none<u64>(&arg4)) {
            0x2::vec_set::insert<address>(&mut arg2.has_unlimited_mint_access, arg3);
            event_updated_mint_allowance(0x1::option::none<AllowanceDetails>(), 0x1::option::some<0x1::string::String>(0x1::string::utf8(b"unlimited mint allowance allocated")), arg3);
        } else {
            let v3 = 0x1::option::extract<u64>(&mut arg4);
            let v4 = AllowanceDetails{
                total_allowance     : v3,
                remaining_allowance : v3,
            };
            0x2::vec_map::insert<address, AllowanceDetails>(&mut arg2.has_limited_mint_access, arg3, v4);
            event_updated_mint_allowance(0x1::option::some<AllowanceDetails>(v4), 0x1::option::none<0x1::string::String>(), arg3);
        };
    }

    // decompiled from Move bytecode v6
}

