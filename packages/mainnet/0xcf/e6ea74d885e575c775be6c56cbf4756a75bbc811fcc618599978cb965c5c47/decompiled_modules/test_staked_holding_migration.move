module 0x836a25005d9b68feaca30f7f3aa6fc7d0e3732d9741d65c2077720ce16b9b3d1::test_staked_holding_migration {
    struct TEST_STAKED_HOLDING_MIGRATION has drop {
        dummy_field: bool,
    }

    struct Owner has store, key {
        id: 0x2::object::UID,
        owner_address: address,
        already_vested: bool,
    }

    struct VestedTokens has store, key {
        id: 0x2::object::UID,
        coin: 0x2::coin::Coin<0xf29428618abe285833214f7041e60462465b323b9ef7e4793cf25fdc3aeda674::test_token::TEST_TOKEN>,
    }

    struct Locker has store {
        total_limit: u64,
        earned_reward: u64,
        total_unstake_balance: u64,
        remaining_balance: u64,
        user_reward_per_token: u64,
        contract_reward_per_token: u64,
    }

    struct TestLocker has store, key {
        id: 0x2::object::UID,
        lockers: 0x2::vec_map::VecMap<0x1::string::String, Locker>,
        address_locker: 0x2::vec_map::VecMap<0x1::string::String, address>,
        total_vested_amount: u64,
        total_claims_amount: u64,
        scheme: vector<u64>,
        is_total_supply_set: bool,
    }

    struct MaintainerRole has store, key {
        id: 0x2::object::UID,
        has_maintainer_access: 0x2::vec_set::VecSet<address>,
    }

    struct PauseUnpauseContract has store, key {
        id: 0x2::object::UID,
        is_paused: bool,
    }

    struct StartVesting has store, key {
        id: 0x2::object::UID,
        start_date: u64,
        tge_timestamp: u64,
        vesting_started: bool,
    }

    struct RewardKitty has store, key {
        id: 0x2::object::UID,
        total_kitty: 0x2::coin::Coin<0xf29428618abe285833214f7041e60462465b323b9ef7e4793cf25fdc3aeda674::test_token::TEST_TOKEN>,
        reward_per_token: u64,
    }

    struct TreasuryVault has store, key {
        id: 0x2::object::UID,
        treasury: 0x2::coin::Coin<0xf29428618abe285833214f7041e60462465b323b9ef7e4793cf25fdc3aeda674::test_token::TEST_TOKEN>,
        timestamp: u64,
        last_staked_at: u64,
    }

    struct TreasuryVaultBalance<phantom T0> has copy, drop, store {
        dummy_field: bool,
    }

    struct UpgradeVersion has key {
        id: 0x2::object::UID,
        version: u64,
    }

    struct VestedAmount has copy, drop {
        amount: u64,
    }

    struct EarnedRewards has copy, drop {
        user: address,
        evm_address: 0x1::string::String,
        earned_rewards: u64,
    }

    struct UpdateRewardEvent has copy, drop {
        staked_at: u64,
        last_contract_reward_per_token: u64,
        updated_contract_reward_per_token: u64,
    }

    struct AvailableAmount has copy, drop {
        available_amount: u64,
        released_amount: u64,
        current_month: u64,
    }

    struct VestingStart has copy, drop {
        start_time_in_sec: u64,
        tge_timestamp_in_sec: u64,
        total_supply_amount: u64,
    }

    struct RewardDetails has store, key {
        id: 0x2::object::UID,
        reward_percentage: u64,
        reward_per_sec: u64,
    }

    struct ChangedOwner has copy, drop {
        current_owner: address,
        new_owner: address,
    }

    struct MigratedData has copy, drop {
        evm_accounts: vector<0x1::string::String>,
        amounts: vector<u64>,
    }

    struct UpdateMigratedData has copy, drop {
        evm_addresses: vector<0x1::string::String>,
        sui_accounts: vector<address>,
        amounts: vector<u64>,
    }

    struct AddedSuiAccounts has copy, drop {
        evm_accounts: vector<0x1::string::String>,
        sui_accounts: vector<address>,
    }

    struct WithdrawDetails has copy, drop {
        recipient: address,
        amount: u64,
        evm_address: 0x1::string::String,
        current_month: u64,
    }

    struct EmergencyWithdrawDetails has copy, drop {
        recipient: address,
        amount: u64,
    }

    struct RewardCollected has copy, drop {
        reward_collected: u64,
    }

    struct TreasuryVaultFunded has copy, drop {
        total_funds: u64,
        funds_added: u64,
    }

    struct MaintainerRoleGranted has copy, drop {
        recipient: address,
    }

    struct MaintainerRoleRevoked has copy, drop {
        revoke_address: address,
    }

    public entry fun add_funds_to_treasury_vault(arg0: &Owner, arg1: 0x2::coin::Coin<0xf29428618abe285833214f7041e60462465b323b9ef7e4793cf25fdc3aeda674::test_token::TEST_TOKEN>, arg2: &mut TreasuryVault, arg3: &0x2::clock::Clock, arg4: &UpgradeVersion, arg5: &PauseUnpauseContract, arg6: &mut 0x2::tx_context::TxContext) {
        let v0 = 0x2::coin::value<0xf29428618abe285833214f7041e60462465b323b9ef7e4793cf25fdc3aeda674::test_token::TEST_TOKEN>(&arg1);
        assert!(0 != v0, 12);
        assert!(v0 >= 1000000000, 13);
        assert!(!arg5.is_paused, 26);
        assert!(0x2::tx_context::sender(arg6) == arg0.owner_address, 1);
        assert!(arg4.version == 1, 2);
        if (arg2.timestamp == 0) {
            arg2.timestamp = time_in_secs(arg3);
            arg2.last_staked_at = time_in_secs(arg3);
        };
        0x2::coin::join<0xf29428618abe285833214f7041e60462465b323b9ef7e4793cf25fdc3aeda674::test_token::TEST_TOKEN>(&mut arg2.treasury, arg1);
        let v1 = TreasuryVaultFunded{
            total_funds : 0x2::coin::value<0xf29428618abe285833214f7041e60462465b323b9ef7e4793cf25fdc3aeda674::test_token::TEST_TOKEN>(&arg2.treasury),
            funds_added : 0x2::coin::value<0xf29428618abe285833214f7041e60462465b323b9ef7e4793cf25fdc3aeda674::test_token::TEST_TOKEN>(&arg1),
        };
        0x2::event::emit<TreasuryVaultFunded>(v1);
    }

    public entry fun add_users_sui_accounts(arg0: &MaintainerRole, arg1: &mut TestLocker, arg2: vector<0x1::string::String>, arg3: vector<address>, arg4: &UpgradeVersion, arg5: &PauseUnpauseContract, arg6: &mut 0x2::tx_context::TxContext) {
        let v0 = 0x2::tx_context::sender(arg6);
        assert!(arg4.version == 1, 2);
        assert!(0x2::vec_set::contains<address>(&arg0.has_maintainer_access, &v0), 17);
        assert!(!arg5.is_paused, 26);
        let v1 = 0x1::vector::length<0x1::string::String>(&arg2);
        assert!(v1 != 0, 19);
        let v2 = 0x1::vector::length<address>(&arg3);
        assert!(v2 != 0, 19);
        assert!(v1 == v2, 21);
        let v3 = 0;
        while (v3 < v1) {
            assert!(42 == 0x1::string::length(0x1::vector::borrow<0x1::string::String>(&arg2, v3)), 20);
            assert!(@0x0 != *0x1::vector::borrow<address>(&arg3, v3), 8);
            assert!(0x2::vec_map::contains<0x1::string::String, Locker>(&arg1.lockers, 0x1::vector::borrow<0x1::string::String>(&arg2, v3)), 5);
            0x2::vec_map::insert<0x1::string::String, address>(&mut arg1.address_locker, *0x1::vector::borrow<0x1::string::String>(&arg2, v3), *0x1::vector::borrow<address>(&arg3, v3));
            v3 = v3 + 1;
        };
        let v4 = AddedSuiAccounts{
            evm_accounts : arg2,
            sui_accounts : arg3,
        };
        0x2::event::emit<AddedSuiAccounts>(v4);
    }

    public entry fun available_amount(arg0: &TestLocker, arg1: &StartVesting, arg2: 0x1::string::String, arg3: &0x2::clock::Clock, arg4: &UpgradeVersion, arg5: &PauseUnpauseContract, arg6: &mut 0x2::tx_context::TxContext) {
        assert!(arg4.version == 1, 2);
        assert!(!arg5.is_paused, 26);
        let (v0, v1, v2) = get_available_amount(arg0, arg2, arg1, arg3);
        let v3 = AvailableAmount{
            available_amount : v0,
            released_amount  : v1,
            current_month    : v2,
        };
        0x2::event::emit<AvailableAmount>(v3);
    }

    public entry fun change_owner(arg0: Owner, arg1: &mut MaintainerRole, arg2: 0x2::package::UpgradeCap, arg3: address, arg4: &UpgradeVersion, arg5: &0x2::tx_context::TxContext) {
        let v0 = arg0.owner_address;
        assert!(arg4.version == 1, 2);
        assert!(@0x0 != arg3, 8);
        assert!(0x2::tx_context::sender(arg5) == v0, 1);
        assert!(arg3 != v0, 9);
        arg0.owner_address = arg3;
        0x2::vec_set::remove<address>(&mut arg1.has_maintainer_access, &v0);
        0x2::vec_set::insert<address>(&mut arg1.has_maintainer_access, arg3);
        0x2::transfer::public_transfer<Owner>(arg0, arg3);
        0x2::transfer::public_transfer<0x2::package::UpgradeCap>(arg2, arg3);
        let v1 = ChangedOwner{
            current_owner : v0,
            new_owner     : arg3,
        };
        0x2::event::emit<ChangedOwner>(v1);
    }

    public entry fun claim_rewards(arg0: &mut TestLocker, arg1: &mut StartVesting, arg2: &mut TreasuryVault, arg3: &mut RewardKitty, arg4: 0x1::string::String, arg5: &0x2::clock::Clock, arg6: &RewardDetails, arg7: &UpgradeVersion, arg8: &PauseUnpauseContract, arg9: &mut 0x2::tx_context::TxContext) {
        let v0 = 0x2::tx_context::sender(arg9);
        assert!(arg7.version == 1, 2);
        assert!(!arg8.is_paused, 26);
        assert!(42 == 0x1::string::length(&arg4), 20);
        assert!(0x2::vec_map::contains<0x1::string::String, Locker>(&arg0.lockers, &arg4), 11);
        assert!(v0 == *0x2::vec_map::get<0x1::string::String, address>(&arg0.address_locker, &arg4), 5);
        assert!(arg1.vesting_started == true, 7);
        update_reward(0x1::option::none<u64>(), arg4, arg0, arg2, arg3, arg5, arg6, arg9);
        let v1 = 0x2::vec_map::get_mut<0x1::string::String, Locker>(&mut arg0.lockers, &arg4);
        assert!(v1.earned_reward != 0, 14);
        assert!(v1.earned_reward <= 0x2::coin::value<0xf29428618abe285833214f7041e60462465b323b9ef7e4793cf25fdc3aeda674::test_token::TEST_TOKEN>(&arg3.total_kitty), 10);
        let v2 = 0x2::coin::split<0xf29428618abe285833214f7041e60462465b323b9ef7e4793cf25fdc3aeda674::test_token::TEST_TOKEN>(&mut arg3.total_kitty, v1.earned_reward, arg9);
        0x2::transfer::public_transfer<0x2::coin::Coin<0xf29428618abe285833214f7041e60462465b323b9ef7e4793cf25fdc3aeda674::test_token::TEST_TOKEN>>(v2, v0);
        v1.earned_reward = 0;
        let v3 = EarnedRewards{
            user           : v0,
            evm_address    : arg4,
            earned_rewards : 0x2::coin::value<0xf29428618abe285833214f7041e60462465b323b9ef7e4793cf25fdc3aeda674::test_token::TEST_TOKEN>(&v2),
        };
        0x2::event::emit<EarnedRewards>(v3);
    }

    entry fun collect_reward(arg0: 0x2::transfer::Receiving<0x2::coin::Coin<0xf29428618abe285833214f7041e60462465b323b9ef7e4793cf25fdc3aeda674::test_token::TEST_TOKEN>>, arg1: &mut TreasuryVault, arg2: &MaintainerRole, arg3: &UpgradeVersion, arg4: &PauseUnpauseContract, arg5: &mut 0x2::tx_context::TxContext) {
        let v0 = 0x2::tx_context::sender(arg5);
        assert!(arg3.version == 1, 2);
        assert!(!arg4.is_paused, 26);
        assert!(0x2::vec_set::contains<address>(&arg2.has_maintainer_access, &v0), 17);
        let v1 = 0x2::transfer::public_receive<0x2::coin::Coin<0xf29428618abe285833214f7041e60462465b323b9ef7e4793cf25fdc3aeda674::test_token::TEST_TOKEN>>(&mut arg1.id, arg0);
        let v2 = TreasuryVaultBalance<0xf29428618abe285833214f7041e60462465b323b9ef7e4793cf25fdc3aeda674::test_token::TEST_TOKEN>{dummy_field: false};
        let v3 = &mut arg1.id;
        if (0x2::dynamic_field::exists_<TreasuryVaultBalance<0xf29428618abe285833214f7041e60462465b323b9ef7e4793cf25fdc3aeda674::test_token::TEST_TOKEN>>(v3, v2)) {
            0x2::coin::join<0xf29428618abe285833214f7041e60462465b323b9ef7e4793cf25fdc3aeda674::test_token::TEST_TOKEN>(0x2::dynamic_field::borrow_mut<TreasuryVaultBalance<0xf29428618abe285833214f7041e60462465b323b9ef7e4793cf25fdc3aeda674::test_token::TEST_TOKEN>, 0x2::coin::Coin<0xf29428618abe285833214f7041e60462465b323b9ef7e4793cf25fdc3aeda674::test_token::TEST_TOKEN>>(v3, v2), v1);
        } else {
            0x2::dynamic_field::add<TreasuryVaultBalance<0xf29428618abe285833214f7041e60462465b323b9ef7e4793cf25fdc3aeda674::test_token::TEST_TOKEN>, 0x2::coin::Coin<0xf29428618abe285833214f7041e60462465b323b9ef7e4793cf25fdc3aeda674::test_token::TEST_TOKEN>>(v3, v2, v1);
        };
        let v4 = 0x2::dynamic_field::borrow_mut<TreasuryVaultBalance<0xf29428618abe285833214f7041e60462465b323b9ef7e4793cf25fdc3aeda674::test_token::TEST_TOKEN>, 0x2::coin::Coin<0xf29428618abe285833214f7041e60462465b323b9ef7e4793cf25fdc3aeda674::test_token::TEST_TOKEN>>(v3, v2);
        0x2::coin::join<0xf29428618abe285833214f7041e60462465b323b9ef7e4793cf25fdc3aeda674::test_token::TEST_TOKEN>(&mut arg1.treasury, 0x2::coin::split<0xf29428618abe285833214f7041e60462465b323b9ef7e4793cf25fdc3aeda674::test_token::TEST_TOKEN>(v4, 0x2::coin::value<0xf29428618abe285833214f7041e60462465b323b9ef7e4793cf25fdc3aeda674::test_token::TEST_TOKEN>(v4), arg5));
        let v5 = RewardCollected{reward_collected: 0x2::coin::value<0xf29428618abe285833214f7041e60462465b323b9ef7e4793cf25fdc3aeda674::test_token::TEST_TOKEN>(&v1)};
        0x2::event::emit<RewardCollected>(v5);
    }

    public entry fun emergency_withdrawal_from_reward_kitty(arg0: &Owner, arg1: address, arg2: &mut RewardKitty, arg3: &UpgradeVersion, arg4: &mut 0x2::tx_context::TxContext) {
        assert!(0x2::tx_context::sender(arg4) == arg0.owner_address, 1);
        assert!(arg3.version == 1, 2);
        assert!(@0x0 != arg1, 8);
        let v0 = 0x2::coin::value<0xf29428618abe285833214f7041e60462465b323b9ef7e4793cf25fdc3aeda674::test_token::TEST_TOKEN>(&arg2.total_kitty);
        assert!(0x2::coin::value<0xf29428618abe285833214f7041e60462465b323b9ef7e4793cf25fdc3aeda674::test_token::TEST_TOKEN>(&arg2.total_kitty) != 0, 12);
        0x2::transfer::public_transfer<0x2::coin::Coin<0xf29428618abe285833214f7041e60462465b323b9ef7e4793cf25fdc3aeda674::test_token::TEST_TOKEN>>(0x2::coin::split<0xf29428618abe285833214f7041e60462465b323b9ef7e4793cf25fdc3aeda674::test_token::TEST_TOKEN>(&mut arg2.total_kitty, v0, arg4), arg1);
        let v1 = EmergencyWithdrawDetails{
            recipient : arg1,
            amount    : v0,
        };
        0x2::event::emit<EmergencyWithdrawDetails>(v1);
    }

    public entry fun emergency_withdrawal_from_treasury_vault(arg0: &Owner, arg1: address, arg2: &mut TreasuryVault, arg3: &UpgradeVersion, arg4: &mut 0x2::tx_context::TxContext) {
        assert!(0x2::tx_context::sender(arg4) == arg0.owner_address, 1);
        assert!(arg3.version == 1, 2);
        assert!(@0x0 != arg1, 8);
        let v0 = 0x2::coin::value<0xf29428618abe285833214f7041e60462465b323b9ef7e4793cf25fdc3aeda674::test_token::TEST_TOKEN>(&arg2.treasury);
        assert!(0x2::coin::value<0xf29428618abe285833214f7041e60462465b323b9ef7e4793cf25fdc3aeda674::test_token::TEST_TOKEN>(&arg2.treasury) != 0, 12);
        0x2::transfer::public_transfer<0x2::coin::Coin<0xf29428618abe285833214f7041e60462465b323b9ef7e4793cf25fdc3aeda674::test_token::TEST_TOKEN>>(0x2::coin::split<0xf29428618abe285833214f7041e60462465b323b9ef7e4793cf25fdc3aeda674::test_token::TEST_TOKEN>(&mut arg2.treasury, v0, arg4), arg1);
        let v1 = EmergencyWithdrawDetails{
            recipient : arg1,
            amount    : v0,
        };
        0x2::event::emit<EmergencyWithdrawDetails>(v1);
    }

    fun get_available_amount(arg0: &TestLocker, arg1: 0x1::string::String, arg2: &StartVesting, arg3: &0x2::clock::Clock) : (u64, u64, u64) {
        assert!(arg2.vesting_started == true, 7);
        assert!(0x2::vec_map::contains<0x1::string::String, Locker>(&arg0.lockers, &arg1), 5);
        let v0 = time_in_secs(arg3);
        assert!(v0 >= arg2.tge_timestamp, 24);
        let v1 = time_in_months(v0 - arg2.tge_timestamp);
        let v2 = 0x2::vec_map::get<0x1::string::String, Locker>(&arg0.lockers, &arg1);
        let v3 = arg0.scheme;
        let v4 = 0;
        let v5 = 0;
        if (v1 < 0x1::vector::length<u64>(&v3)) {
            while (v4 <= v1) {
                v5 = v5 + v2.total_limit * *0x1::vector::borrow<u64>(&v3, v4) / 100;
                v4 = v4 + 1;
            };
        } else {
            v5 = v2.total_limit;
        };
        (v5 - v2.total_unstake_balance, v5, v1)
    }

    entry fun grant_maintainer_role(arg0: &Owner, arg1: &mut MaintainerRole, arg2: &UpgradeVersion, arg3: address, arg4: &PauseUnpauseContract, arg5: &0x2::tx_context::TxContext) {
        assert!(arg2.version == 1, 2);
        assert!(!arg4.is_paused, 26);
        assert!(0x2::tx_context::sender(arg5) == arg0.owner_address, 1);
        assert!(@0x0 != arg3, 8);
        assert!(!0x2::vec_set::contains<address>(&arg1.has_maintainer_access, &arg3), 16);
        0x2::vec_set::insert<address>(&mut arg1.has_maintainer_access, arg3);
        let v0 = MaintainerRoleGranted{recipient: arg3};
        0x2::event::emit<MaintainerRoleGranted>(v0);
    }

    fun init(arg0: TEST_STAKED_HOLDING_MIGRATION, arg1: &mut 0x2::tx_context::TxContext) {
        let v0 = 0x2::tx_context::sender(arg1);
        let v1 = Owner{
            id             : 0x2::object::new(arg1),
            owner_address  : v0,
            already_vested : false,
        };
        0x2::transfer::public_transfer<Owner>(v1, 0x2::tx_context::sender(arg1));
        let v2 = StartVesting{
            id              : 0x2::object::new(arg1),
            start_date      : 0,
            tge_timestamp   : 0,
            vesting_started : false,
        };
        0x2::transfer::share_object<StartVesting>(v2);
        let v3 = TestLocker{
            id                  : 0x2::object::new(arg1),
            lockers             : 0x2::vec_map::empty<0x1::string::String, Locker>(),
            address_locker      : 0x2::vec_map::empty<0x1::string::String, address>(),
            total_vested_amount : 0,
            total_claims_amount : 0,
            scheme              : vector[0, 0, 0, 20, 20, 20, 20, 20],
            is_total_supply_set : false,
        };
        0x2::transfer::share_object<TestLocker>(v3);
        let v4 = UpgradeVersion{
            id      : 0x2::object::new(arg1),
            version : 1,
        };
        0x2::transfer::share_object<UpgradeVersion>(v4);
        let v5 = PauseUnpauseContract{
            id        : 0x2::object::new(arg1),
            is_paused : false,
        };
        0x2::transfer::share_object<PauseUnpauseContract>(v5);
        let v6 = VestedTokens{
            id   : 0x2::object::new(arg1),
            coin : 0x2::coin::zero<0xf29428618abe285833214f7041e60462465b323b9ef7e4793cf25fdc3aeda674::test_token::TEST_TOKEN>(arg1),
        };
        0x2::transfer::share_object<VestedTokens>(v6);
        let v7 = TreasuryVault{
            id             : 0x2::object::new(arg1),
            treasury       : 0x2::coin::zero<0xf29428618abe285833214f7041e60462465b323b9ef7e4793cf25fdc3aeda674::test_token::TEST_TOKEN>(arg1),
            timestamp      : 0,
            last_staked_at : 0,
        };
        0x2::transfer::share_object<TreasuryVault>(v7);
        let v8 = RewardKitty{
            id               : 0x2::object::new(arg1),
            total_kitty      : 0x2::coin::zero<0xf29428618abe285833214f7041e60462465b323b9ef7e4793cf25fdc3aeda674::test_token::TEST_TOKEN>(arg1),
            reward_per_token : 0,
        };
        0x2::transfer::share_object<RewardKitty>(v8);
        let v9 = RewardDetails{
            id                : 0x2::object::new(arg1),
            reward_percentage : 2100,
            reward_per_sec    : 1000000000,
        };
        0x2::transfer::share_object<RewardDetails>(v9);
        let v10 = MaintainerRole{
            id                    : 0x2::object::new(arg1),
            has_maintainer_access : 0x2::vec_set::empty<address>(),
        };
        0x2::vec_set::insert<address>(&mut v10.has_maintainer_access, v0);
        0x2::transfer::share_object<MaintainerRole>(v10);
    }

    public entry fun migrate_users_data(arg0: &MaintainerRole, arg1: &mut TestLocker, arg2: vector<0x1::string::String>, arg3: vector<u64>, arg4: vector<0x1::string::String>, arg5: vector<address>, arg6: &UpgradeVersion, arg7: 0x1::option::Option<u64>, arg8: &PauseUnpauseContract, arg9: &mut 0x2::tx_context::TxContext) {
        let v0 = 0x2::tx_context::sender(arg9);
        assert!(arg6.version == 1, 2);
        assert!(!arg8.is_paused, 26);
        assert!(0x2::vec_set::contains<address>(&arg0.has_maintainer_access, &v0), 17);
        let v1 = set_total_supply_amount(arg1, arg7);
        let v2 = process_accounts_and_amounts(arg1, arg2, arg3, v1);
        arg1.total_claims_amount = v2;
        add_users_sui_accounts(arg0, arg1, arg4, arg5, arg6, arg8, arg9);
        let v3 = MigratedData{
            evm_accounts : arg2,
            amounts      : arg3,
        };
        0x2::event::emit<MigratedData>(v3);
    }

    public entry fun pause_unpause_contract(arg0: &mut Owner, arg1: &mut PauseUnpauseContract, arg2: &UpgradeVersion, arg3: bool, arg4: &mut 0x2::tx_context::TxContext) {
        assert!(0x2::tx_context::sender(arg4) == arg0.owner_address, 1);
        assert!(arg2.version == 1, 2);
        if (arg3) {
            assert!(!arg1.is_paused, 26);
            arg1.is_paused = true;
        } else {
            assert!(arg1.is_paused, 27);
            arg1.is_paused = false;
        };
    }

    fun process_accounts_and_amounts(arg0: &mut TestLocker, arg1: vector<0x1::string::String>, arg2: vector<u64>, arg3: u64) : u64 {
        let v0 = 0x1::vector::length<0x1::string::String>(&arg1);
        let v1 = arg0.total_claims_amount;
        assert!(v0 == 0x1::vector::length<u64>(&arg2), 3);
        let v2 = 0;
        while (v2 < v0) {
            assert!(42 == 0x1::string::length(0x1::vector::borrow<0x1::string::String>(&arg1, v2)), 20);
            assert!(0 != *0x1::vector::borrow<u64>(&arg2, v2), 12);
            let v3 = v1 + *0x1::vector::borrow<u64>(&arg2, v2);
            v1 = v3;
            assert!(arg3 >= v3, 15);
            arg0.total_claims_amount = v3;
            let v4 = Locker{
                total_limit               : *0x1::vector::borrow<u64>(&arg2, v2),
                earned_reward             : 0,
                total_unstake_balance     : 0,
                remaining_balance         : *0x1::vector::borrow<u64>(&arg2, v2),
                user_reward_per_token     : 0,
                contract_reward_per_token : 0,
            };
            0x2::vec_map::insert<0x1::string::String, Locker>(&mut arg0.lockers, *0x1::vector::borrow<0x1::string::String>(&arg1, v2), v4);
            v2 = v2 + 1;
        };
        v1
    }

    entry fun revoke_maintainer_role(arg0: &Owner, arg1: &mut MaintainerRole, arg2: &UpgradeVersion, arg3: address, arg4: &PauseUnpauseContract, arg5: &0x2::tx_context::TxContext) {
        assert!(arg2.version == 1, 2);
        assert!(!arg4.is_paused, 26);
        assert!(0x2::tx_context::sender(arg5) == arg0.owner_address, 1);
        assert!(@0x0 != arg3, 8);
        assert!(0x2::vec_set::contains<address>(&arg1.has_maintainer_access, &arg3), 17);
        assert!(arg3 != arg0.owner_address, 18);
        0x2::vec_set::remove<address>(&mut arg1.has_maintainer_access, &arg3);
        let v0 = MaintainerRoleRevoked{revoke_address: arg3};
        0x2::event::emit<MaintainerRoleRevoked>(v0);
    }

    public entry fun set_reward_details(arg0: &mut MaintainerRole, arg1: &mut RewardDetails, arg2: 0x1::option::Option<u64>, arg3: 0x1::option::Option<u64>, arg4: &mut TestLocker, arg5: &mut TreasuryVault, arg6: &mut RewardKitty, arg7: &0x2::clock::Clock, arg8: &UpgradeVersion, arg9: &PauseUnpauseContract, arg10: &mut 0x2::tx_context::TxContext) {
        let v0 = 0x2::tx_context::sender(arg10);
        assert!(arg8.version == 1, 2);
        assert!(0x2::vec_set::contains<address>(&arg0.has_maintainer_access, &v0), 17);
        assert!(!arg9.is_paused, 26);
        update_reward_contract(arg4, arg5, arg6, arg7, arg1, arg8, arg10);
        if (!0x1::option::is_none<u64>(&arg2)) {
            arg1.reward_percentage = 0x1::option::extract<u64>(&mut arg2);
        };
        if (!0x1::option::is_none<u64>(&arg3)) {
            arg1.reward_per_sec = 0x1::option::extract<u64>(&mut arg3);
        };
    }

    fun set_total_supply_amount(arg0: &mut TestLocker, arg1: 0x1::option::Option<u64>) : u64 {
        if (!arg0.is_total_supply_set) {
            assert!(!0x1::option::is_none<u64>(&arg1), 23);
            let v0 = 0x1::option::extract<u64>(&mut arg1);
            assert!(v0 > 0, 12);
            arg0.total_vested_amount = v0;
            arg0.is_total_supply_set = true;
            return v0
        };
        assert!(0x1::option::is_none<u64>(&arg1), 22);
        arg0.total_vested_amount
    }

    public entry fun start_vesting(arg0: &mut Owner, arg1: &mut TestLocker, arg2: &mut VestedTokens, arg3: &mut 0x2::coin::Coin<0xf29428618abe285833214f7041e60462465b323b9ef7e4793cf25fdc3aeda674::test_token::TEST_TOKEN>, arg4: &mut StartVesting, arg5: &0x2::clock::Clock, arg6: u64, arg7: &UpgradeVersion, arg8: &PauseUnpauseContract, arg9: &mut 0x2::tx_context::TxContext) {
        assert!(arg7.version == 1, 2);
        assert!(!arg8.is_paused, 26);
        assert!(0x2::tx_context::sender(arg9) == arg0.owner_address, 1);
        assert!(arg4.vesting_started == false, 4);
        assert!(arg6 != 0, 25);
        let v0 = arg1.total_vested_amount;
        assert!(v0 == 0x2::balance::value<0xf29428618abe285833214f7041e60462465b323b9ef7e4793cf25fdc3aeda674::test_token::TEST_TOKEN>(0x2::coin::balance<0xf29428618abe285833214f7041e60462465b323b9ef7e4793cf25fdc3aeda674::test_token::TEST_TOKEN>(arg3)), 6);
        vest_token(arg0, arg3, arg2, v0, arg9);
        arg4.start_date = time_in_secs(arg5);
        arg4.tge_timestamp = arg6;
        arg4.vesting_started = true;
        let v1 = VestingStart{
            start_time_in_sec    : arg4.start_date,
            tge_timestamp_in_sec : arg4.tge_timestamp,
            total_supply_amount  : v0,
        };
        0x2::event::emit<VestingStart>(v1);
    }

    public fun time_in_months(arg0: u64) : u64 {
        arg0 / 60 / 60 / 24 / 3
    }

    public fun time_in_secs(arg0: &0x2::clock::Clock) : u64 {
        0x2::clock::timestamp_ms(arg0) / 1000
    }

    public entry fun unstake(arg0: &mut TestLocker, arg1: &mut StartVesting, arg2: 0x1::string::String, arg3: &0x2::clock::Clock, arg4: &mut VestedTokens, arg5: &mut TreasuryVault, arg6: &mut RewardKitty, arg7: &RewardDetails, arg8: &UpgradeVersion, arg9: &PauseUnpauseContract, arg10: &mut 0x2::tx_context::TxContext) {
        let v0 = 0x2::tx_context::sender(arg10);
        assert!(arg8.version == 1, 2);
        assert!(!arg9.is_paused, 26);
        assert!(42 == 0x1::string::length(&arg2), 20);
        assert!(arg1.vesting_started == true, 7);
        assert!(0x2::vec_map::contains<0x1::string::String, Locker>(&arg0.lockers, &arg2), 11);
        assert!(v0 == *0x2::vec_map::get<0x1::string::String, address>(&arg0.address_locker, &arg2), 5);
        let (v1, _, v3) = get_available_amount(arg0, arg2, arg1, arg3);
        assert!(v1 > 0, 10);
        update_reward(0x1::option::none<u64>(), arg2, arg0, arg5, arg6, arg3, arg7, arg10);
        0x2::transfer::public_transfer<0x2::coin::Coin<0xf29428618abe285833214f7041e60462465b323b9ef7e4793cf25fdc3aeda674::test_token::TEST_TOKEN>>(0x2::coin::split<0xf29428618abe285833214f7041e60462465b323b9ef7e4793cf25fdc3aeda674::test_token::TEST_TOKEN>(&mut arg4.coin, v1, arg10), v0);
        let v4 = 0x2::vec_map::get_mut<0x1::string::String, Locker>(&mut arg0.lockers, &arg2);
        v4.remaining_balance = v4.remaining_balance - v1;
        v4.total_unstake_balance = v4.total_unstake_balance + v1;
        let v5 = WithdrawDetails{
            recipient     : v0,
            amount        : v1,
            evm_address   : arg2,
            current_month : v3,
        };
        0x2::event::emit<WithdrawDetails>(v5);
    }

    public entry fun update_hydro_locker_with_new_gth_holders_accounts(arg0: &MaintainerRole, arg1: &mut TestLocker, arg2: vector<0x1::string::String>, arg3: vector<u64>, arg4: vector<address>, arg5: &UpgradeVersion, arg6: &PauseUnpauseContract, arg7: &mut 0x2::tx_context::TxContext) {
        let v0 = 0x2::tx_context::sender(arg7);
        assert!(arg5.version == 1, 2);
        assert!(!arg6.is_paused, 26);
        assert!(0x2::vec_set::contains<address>(&arg0.has_maintainer_access, &v0), 17);
        assert!(arg1.is_total_supply_set, 23);
        let v1 = arg1.total_vested_amount;
        let v2 = process_accounts_and_amounts(arg1, arg2, arg3, v1);
        arg1.total_claims_amount = v2;
        add_users_sui_accounts(arg0, arg1, arg2, arg4, arg5, arg6, arg7);
        let v3 = UpdateMigratedData{
            evm_addresses : arg2,
            sui_accounts  : arg4,
            amounts       : arg3,
        };
        0x2::event::emit<UpdateMigratedData>(v3);
    }

    fun update_reward(arg0: 0x1::option::Option<u64>, arg1: 0x1::string::String, arg2: &mut TestLocker, arg3: &mut TreasuryVault, arg4: &mut RewardKitty, arg5: &0x2::clock::Clock, arg6: &RewardDetails, arg7: &mut 0x2::tx_context::TxContext) {
        let v0 = 0x2::vec_map::get_mut<0x1::string::String, Locker>(&mut arg2.lockers, &arg1);
        0x2::coin::value<0xf29428618abe285833214f7041e60462465b323b9ef7e4793cf25fdc3aeda674::test_token::TEST_TOKEN>(&arg4.total_kitty);
        let v1 = updated_reward_kitty(arg3, arg4, arg5, arg6, arg7);
        let v2 = arg2.total_vested_amount;
        let v3 = if (v2 == 0) {
            0
        } else {
            (((v1 as u256) * (1000000000 as u256) / (v2 as u256)) as u64)
        };
        arg4.reward_per_token = arg4.reward_per_token + v3;
        let v4 = if (0x1::option::is_none<u64>(&arg0)) {
            ((((arg4.reward_per_token - v0.contract_reward_per_token) as u256) * (v0.remaining_balance as u256) / (1000000000 as u256)) as u64)
        } else {
            ((((arg4.reward_per_token - v0.contract_reward_per_token) as u256) * (0x1::option::extract<u64>(&mut arg0) as u256) / (1000000000 as u256)) as u64)
        };
        v0.user_reward_per_token = v3;
        v0.earned_reward = v0.earned_reward + v4;
        v0.contract_reward_per_token = arg4.reward_per_token;
        let v5 = UpdateRewardEvent{
            staked_at                         : time_in_secs(arg5),
            last_contract_reward_per_token    : v0.contract_reward_per_token,
            updated_contract_reward_per_token : arg4.reward_per_token,
        };
        0x2::event::emit<UpdateRewardEvent>(v5);
    }

    public fun update_reward_contract(arg0: &mut TestLocker, arg1: &mut TreasuryVault, arg2: &mut RewardKitty, arg3: &0x2::clock::Clock, arg4: &RewardDetails, arg5: &UpgradeVersion, arg6: &mut 0x2::tx_context::TxContext) {
        assert!(arg5.version == 1, 2);
        let v0 = updated_reward_kitty(arg1, arg2, arg3, arg4, arg6);
        let v1 = arg0.total_vested_amount;
        let v2 = if (v1 == 0) {
            0
        } else {
            (((v0 as u256) * (1000000000 as u256) / (v1 as u256)) as u64)
        };
        arg2.reward_per_token = arg2.reward_per_token + v2;
    }

    fun updated_reward_kitty(arg0: &mut TreasuryVault, arg1: &mut RewardKitty, arg2: &0x2::clock::Clock, arg3: &RewardDetails, arg4: &mut 0x2::tx_context::TxContext) : u64 {
        let v0 = time_in_secs(arg2);
        let v1 = (((((arg3.reward_percentage as u256) * ((arg3.reward_per_sec * (v0 - arg0.last_staked_at)) as u256)) as u256) / 10000) as u64);
        assert!(0x2::coin::value<0xf29428618abe285833214f7041e60462465b323b9ef7e4793cf25fdc3aeda674::test_token::TEST_TOKEN>(&arg0.treasury) >= v1, 10);
        0x2::coin::join<0xf29428618abe285833214f7041e60462465b323b9ef7e4793cf25fdc3aeda674::test_token::TEST_TOKEN>(&mut arg1.total_kitty, 0x2::coin::split<0xf29428618abe285833214f7041e60462465b323b9ef7e4793cf25fdc3aeda674::test_token::TEST_TOKEN>(&mut arg0.treasury, v1, arg4));
        arg0.last_staked_at = v0;
        v1
    }

    entry fun upgrade_contract_version(arg0: &Owner, arg1: &mut UpgradeVersion, arg2: &0x2::tx_context::TxContext) {
        assert!(0x2::tx_context::sender(arg2) == arg0.owner_address, 1);
        assert!(arg1.version < 1, 2);
        arg1.version = 1;
    }

    fun vest_token(arg0: &mut Owner, arg1: &mut 0x2::coin::Coin<0xf29428618abe285833214f7041e60462465b323b9ef7e4793cf25fdc3aeda674::test_token::TEST_TOKEN>, arg2: &mut VestedTokens, arg3: u64, arg4: &mut 0x2::tx_context::TxContext) {
        0x2::coin::join<0xf29428618abe285833214f7041e60462465b323b9ef7e4793cf25fdc3aeda674::test_token::TEST_TOKEN>(&mut arg2.coin, 0x2::coin::split<0xf29428618abe285833214f7041e60462465b323b9ef7e4793cf25fdc3aeda674::test_token::TEST_TOKEN>(arg1, arg3, arg4));
        arg0.already_vested = true;
        let v0 = VestedAmount{amount: arg3};
        0x2::event::emit<VestedAmount>(v0);
    }

    // decompiled from Move bytecode v6
}

