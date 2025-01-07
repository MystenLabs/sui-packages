module 0x4cda79120c613274c294850ad0148b06142c288a0ec66998eea3e05fd838215f::test_wallet_holding_migration {
    struct TEST_WALLET_HOLDING_MIGRATION has drop {
        dummy_field: bool,
    }

    struct Owner has store, key {
        id: 0x2::object::UID,
        owner: address,
        already_vested: bool,
    }

    struct UpgradeVersion has key {
        id: 0x2::object::UID,
        version: u64,
    }

    struct VestedTokens has store, key {
        id: 0x2::object::UID,
        coin: 0x2::coin::Coin<0xf29428618abe285833214f7041e60462465b323b9ef7e4793cf25fdc3aeda674::test_token::TEST_TOKEN>,
    }

    struct VestedAmount has copy, drop {
        amount: u64,
    }

    struct Locker has store {
        total_limit: u64,
        total_withdraw_balance: u64,
        remaining_balance: u64,
    }

    struct HydroLocker has store, key {
        id: 0x2::object::UID,
        lockers: 0x2::vec_map::VecMap<0x1::string::String, Locker>,
        address_locker: 0x2::vec_map::VecMap<0x1::string::String, address>,
        total_vested_amount: u64,
        total_claims_amount: u64,
        scheme: vector<u64>,
        is_migrated: bool,
    }

    struct StartVesting has store, key {
        id: 0x2::object::UID,
        start_date: u64,
        tge_timestamp_date: u64,
        vesting_started: bool,
    }

    struct PauseUnpauseContract has store, key {
        id: 0x2::object::UID,
        is_paused: bool,
    }

    struct VestingStart has copy, drop {
        start_date_in_sec: u64,
        tge_timestamp_date_in_sec: u64,
    }

    struct WithdrawDetails has copy, drop {
        recipient: address,
        withdrawal_amount: u64,
        evm_address: 0x1::string::String,
        current_month: u64,
    }

    struct MaintainerRole has store, key {
        id: 0x2::object::UID,
        has_maintainer_access: 0x2::vec_set::VecSet<address>,
    }

    struct MigratedData has copy, drop {
        evm_addresses: vector<0x1::string::String>,
        amounts: vector<u64>,
    }

    struct AddedSuiAccounts has copy, drop {
        evm_addresses: vector<0x1::string::String>,
        mapped_sui_accounts: vector<address>,
    }

    struct UpdateMigratedData has copy, drop {
        evm_addresses: vector<0x1::string::String>,
        mapped_sui_accounts: vector<address>,
        amounts: vector<u64>,
    }

    struct MaintainerRoleGranted has copy, drop {
        recipient: address,
    }

    struct MaintainerRoleRevoked has copy, drop {
        revoke_address: address,
    }

    public entry fun add_users_sui_accounts(arg0: &MaintainerRole, arg1: &mut HydroLocker, arg2: vector<0x1::string::String>, arg3: vector<address>, arg4: &UpgradeVersion, arg5: &PauseUnpauseContract, arg6: &mut 0x2::tx_context::TxContext) {
        let v0 = 0x2::tx_context::sender(arg6);
        assert!(arg4.version == 0, 2);
        assert!(!arg5.is_paused, 24);
        assert!(0x2::vec_set::contains<address>(&arg0.has_maintainer_access, &v0), 18);
        let v1 = 0x1::vector::length<0x1::string::String>(&arg2);
        assert!(v1 != 0, 11);
        let v2 = 0x1::vector::length<address>(&arg3);
        assert!(v2 != 0, 11);
        assert!(v1 == v2, 15);
        let v3 = 0;
        while (v3 < v1) {
            assert!(42 == 0x1::string::length(0x1::vector::borrow<0x1::string::String>(&arg2, v3)), 16);
            assert!(@0x0 != *0x1::vector::borrow<address>(&arg3, v3), 8);
            assert!(0x2::vec_map::contains<0x1::string::String, Locker>(&arg1.lockers, 0x1::vector::borrow<0x1::string::String>(&arg2, v3)), 5);
            0x2::vec_map::insert<0x1::string::String, address>(&mut arg1.address_locker, *0x1::vector::borrow<0x1::string::String>(&arg2, v3), *0x1::vector::borrow<address>(&arg3, v3));
            v3 = v3 + 1;
        };
        let v4 = AddedSuiAccounts{
            evm_addresses       : arg2,
            mapped_sui_accounts : arg3,
        };
        0x2::event::emit<AddedSuiAccounts>(v4);
    }

    public entry fun change_owner(arg0: Owner, arg1: &mut MaintainerRole, arg2: 0x2::package::UpgradeCap, arg3: address, arg4: &UpgradeVersion, arg5: &0x2::tx_context::TxContext) {
        let v0 = arg0.owner;
        assert!(arg4.version == 0, 2);
        assert!(@0x0 != arg3, 8);
        assert!(0x2::tx_context::sender(arg5) == v0, 1);
        assert!(arg3 != v0, 9);
        arg0.owner = arg3;
        0x2::vec_set::remove<address>(&mut arg1.has_maintainer_access, &v0);
        0x2::vec_set::insert<address>(&mut arg1.has_maintainer_access, arg3);
        0x2::transfer::public_transfer<Owner>(arg0, arg3);
        0x2::transfer::public_transfer<0x2::package::UpgradeCap>(arg2, arg3);
    }

    fun get_available_amount(arg0: &HydroLocker, arg1: 0x1::string::String, arg2: &StartVesting, arg3: &0x2::clock::Clock) : (u64, u64, u64) {
        assert!(arg2.vesting_started == true, 7);
        assert!(0x2::vec_map::contains<0x1::string::String, Locker>(&arg0.lockers, &arg1), 5);
        let v0 = time_in_secs(arg3);
        assert!(v0 >= arg2.tge_timestamp_date, 22);
        let v1 = time_in_months(v0 - arg2.tge_timestamp_date);
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
        (v5 - v2.total_withdraw_balance, v5, v1)
    }

    public entry fun grant_maintainer_role(arg0: &Owner, arg1: &mut MaintainerRole, arg2: &UpgradeVersion, arg3: address, arg4: &PauseUnpauseContract, arg5: &0x2::tx_context::TxContext) {
        assert!(arg2.version == 0, 2);
        assert!(0x2::tx_context::sender(arg5) == arg0.owner, 1);
        assert!(@0x0 != arg3, 8);
        assert!(!arg4.is_paused, 24);
        assert!(!0x2::vec_set::contains<address>(&arg1.has_maintainer_access, &arg3), 17);
        0x2::vec_set::insert<address>(&mut arg1.has_maintainer_access, arg3);
        let v0 = MaintainerRoleGranted{recipient: arg3};
        0x2::event::emit<MaintainerRoleGranted>(v0);
    }

    fun init(arg0: TEST_WALLET_HOLDING_MIGRATION, arg1: &mut 0x2::tx_context::TxContext) {
        let v0 = Owner{
            id             : 0x2::object::new(arg1),
            owner          : 0x2::tx_context::sender(arg1),
            already_vested : false,
        };
        0x2::transfer::public_transfer<Owner>(v0, 0x2::tx_context::sender(arg1));
        let v1 = UpgradeVersion{
            id      : 0x2::object::new(arg1),
            version : 0,
        };
        0x2::transfer::share_object<UpgradeVersion>(v1);
        let v2 = VestedTokens{
            id   : 0x2::object::new(arg1),
            coin : 0x2::coin::zero<0xf29428618abe285833214f7041e60462465b323b9ef7e4793cf25fdc3aeda674::test_token::TEST_TOKEN>(arg1),
        };
        0x2::transfer::share_object<VestedTokens>(v2);
        let v3 = PauseUnpauseContract{
            id        : 0x2::object::new(arg1),
            is_paused : false,
        };
        0x2::transfer::share_object<PauseUnpauseContract>(v3);
        let v4 = StartVesting{
            id                 : 0x2::object::new(arg1),
            start_date         : 0,
            tge_timestamp_date : 0,
            vesting_started    : false,
        };
        0x2::transfer::share_object<StartVesting>(v4);
        let v5 = HydroLocker{
            id                  : 0x2::object::new(arg1),
            lockers             : 0x2::vec_map::empty<0x1::string::String, Locker>(),
            address_locker      : 0x2::vec_map::empty<0x1::string::String, address>(),
            total_vested_amount : 0,
            total_claims_amount : 0,
            scheme              : vector[5, 35, 30, 20, 10],
            is_migrated         : false,
        };
        0x2::transfer::share_object<HydroLocker>(v5);
        let v6 = MaintainerRole{
            id                    : 0x2::object::new(arg1),
            has_maintainer_access : 0x2::vec_set::empty<address>(),
        };
        0x2::vec_set::insert<address>(&mut v6.has_maintainer_access, 0x2::tx_context::sender(arg1));
        0x2::transfer::share_object<MaintainerRole>(v6);
    }

    public entry fun migrate_users_data(arg0: &MaintainerRole, arg1: &mut HydroLocker, arg2: vector<0x1::string::String>, arg3: vector<u64>, arg4: vector<0x1::string::String>, arg5: vector<address>, arg6: &UpgradeVersion, arg7: u64, arg8: &PauseUnpauseContract, arg9: &mut 0x2::tx_context::TxContext) {
        let v0 = 0x2::tx_context::sender(arg9);
        assert!(arg6.version == 0, 2);
        assert!(!arg1.is_migrated, 20);
        assert!(!arg8.is_paused, 24);
        assert!(0x2::vec_set::contains<address>(&arg0.has_maintainer_access, &v0), 18);
        let v1 = 0x1::vector::length<0x1::string::String>(&arg2);
        assert!(v1 != 0, 11);
        let v2 = 0x1::vector::length<u64>(&arg3);
        assert!(v2 != 0, 11);
        assert!(v1 == v2, 3);
        arg1.total_vested_amount = arg7;
        let v3 = process_accounts_and_amounts(arg2, arg3, arg1, arg7);
        arg1.total_claims_amount = v3;
        add_users_sui_accounts(arg0, arg1, arg4, arg5, arg6, arg8, arg9);
        arg1.is_migrated = true;
        let v4 = MigratedData{
            evm_addresses : arg2,
            amounts       : arg3,
        };
        0x2::event::emit<MigratedData>(v4);
    }

    public entry fun pause_unpause_contract(arg0: &mut Owner, arg1: &mut PauseUnpauseContract, arg2: &UpgradeVersion, arg3: bool, arg4: &mut 0x2::tx_context::TxContext) {
        assert!(0x2::tx_context::sender(arg4) == arg0.owner, 1);
        assert!(arg2.version == 0, 2);
        if (arg3) {
            assert!(!arg1.is_paused, 24);
            arg1.is_paused = true;
        } else {
            assert!(arg1.is_paused, 25);
            arg1.is_paused = false;
        };
    }

    fun process_accounts_and_amounts(arg0: vector<0x1::string::String>, arg1: vector<u64>, arg2: &mut HydroLocker, arg3: u64) : u64 {
        let v0 = arg2.total_claims_amount;
        let v1 = 0;
        while (v1 < 0x1::vector::length<0x1::string::String>(&arg0)) {
            assert!(42 == 0x1::string::length(0x1::vector::borrow<0x1::string::String>(&arg0, v1)), 16);
            assert!(0 != *0x1::vector::borrow<u64>(&arg1, v1), 12);
            let v2 = v0 + *0x1::vector::borrow<u64>(&arg1, v1);
            v0 = v2;
            assert!(arg3 >= v2, 14);
            arg2.total_claims_amount = v2;
            let v3 = Locker{
                total_limit            : *0x1::vector::borrow<u64>(&arg1, v1),
                total_withdraw_balance : 0,
                remaining_balance      : *0x1::vector::borrow<u64>(&arg1, v1),
            };
            0x2::vec_map::insert<0x1::string::String, Locker>(&mut arg2.lockers, *0x1::vector::borrow<0x1::string::String>(&arg0, v1), v3);
            v1 = v1 + 1;
        };
        v0
    }

    public entry fun rescue_with_accounts(arg0: &Owner, arg1: &mut HydroLocker, arg2: &mut StartVesting, arg3: &0x2::clock::Clock, arg4: &mut VestedTokens, arg5: vector<0x1::string::String>, arg6: &UpgradeVersion, arg7: &mut 0x2::tx_context::TxContext) {
        let v0 = 0x2::tx_context::sender(arg7);
        assert!(arg6.version == 0, 2);
        assert!(v0 == arg0.owner, 1);
        assert!(arg2.vesting_started == true, 7);
        let v1 = 0x1::vector::length<0x1::string::String>(&arg5);
        assert!(v1 != 0, 11);
        let v2 = 0;
        while (v2 < v1) {
            assert!(0x2::vec_map::contains<0x1::string::String, Locker>(&arg1.lockers, 0x1::vector::borrow<0x1::string::String>(&arg5, v2)), 5);
            v2 = v2 + 1;
        };
        let v3 = 0;
        while (v3 < v1) {
            let v4 = *0x1::vector::borrow<0x1::string::String>(&arg5, v3);
            let (v5, _, _) = get_available_amount(arg1, v4, arg2, arg3);
            assert!(0 != v5, 12);
            0x2::transfer::public_transfer<0x2::coin::Coin<0xf29428618abe285833214f7041e60462465b323b9ef7e4793cf25fdc3aeda674::test_token::TEST_TOKEN>>(0x2::coin::split<0xf29428618abe285833214f7041e60462465b323b9ef7e4793cf25fdc3aeda674::test_token::TEST_TOKEN>(&mut arg4.coin, v5, arg7), v0);
            let v8 = 0x2::vec_map::get_mut<0x1::string::String, Locker>(&mut arg1.lockers, &v4);
            v8.total_withdraw_balance = v8.total_withdraw_balance + v5;
            v8.remaining_balance = v8.total_limit - v8.total_withdraw_balance;
            v3 = v3 + 1;
        };
    }

    public entry fun revoke_maintainer_role(arg0: &Owner, arg1: &mut MaintainerRole, arg2: &UpgradeVersion, arg3: address, arg4: &PauseUnpauseContract, arg5: &0x2::tx_context::TxContext) {
        assert!(arg2.version == 0, 2);
        assert!(0x2::tx_context::sender(arg5) == arg0.owner, 1);
        assert!(@0x0 != arg3, 8);
        assert!(!arg4.is_paused, 24);
        assert!(0x2::vec_set::contains<address>(&arg1.has_maintainer_access, &arg3), 18);
        assert!(arg3 != arg0.owner, 19);
        0x2::vec_set::remove<address>(&mut arg1.has_maintainer_access, &arg3);
        let v0 = MaintainerRoleRevoked{revoke_address: arg3};
        0x2::event::emit<MaintainerRoleRevoked>(v0);
    }

    public entry fun start_vesting(arg0: &mut Owner, arg1: &mut HydroLocker, arg2: &mut 0x2::coin::Coin<0xf29428618abe285833214f7041e60462465b323b9ef7e4793cf25fdc3aeda674::test_token::TEST_TOKEN>, arg3: &mut StartVesting, arg4: &mut VestedTokens, arg5: &0x2::clock::Clock, arg6: u64, arg7: &PauseUnpauseContract, arg8: &UpgradeVersion, arg9: &mut 0x2::tx_context::TxContext) {
        assert!(arg8.version == 0, 2);
        assert!(0x2::tx_context::sender(arg9) == arg0.owner, 1);
        assert!(!arg7.is_paused, 24);
        assert!(arg3.vesting_started == false, 4);
        assert!(arg6 != 0, 23);
        let v0 = arg1.total_vested_amount;
        assert!(v0 == 0x2::balance::value<0xf29428618abe285833214f7041e60462465b323b9ef7e4793cf25fdc3aeda674::test_token::TEST_TOKEN>(0x2::coin::balance<0xf29428618abe285833214f7041e60462465b323b9ef7e4793cf25fdc3aeda674::test_token::TEST_TOKEN>(arg2)), 13);
        vest_token(arg0, arg2, arg4, v0, arg9);
        arg3.start_date = time_in_secs(arg5);
        arg3.tge_timestamp_date = arg6;
        arg3.vesting_started = true;
        let v1 = VestingStart{
            start_date_in_sec         : arg3.start_date,
            tge_timestamp_date_in_sec : arg3.tge_timestamp_date,
        };
        0x2::event::emit<VestingStart>(v1);
    }

    public fun time_in_months(arg0: u64) : u64 {
        arg0 / 60 / 60 / 24 / 3
    }

    public fun time_in_secs(arg0: &0x2::clock::Clock) : u64 {
        0x2::clock::timestamp_ms(arg0) / 1000
    }

    public entry fun update_hydro_locker_with_new_gth_holders_accounts(arg0: &MaintainerRole, arg1: &mut HydroLocker, arg2: vector<0x1::string::String>, arg3: vector<u64>, arg4: vector<address>, arg5: &PauseUnpauseContract, arg6: &UpgradeVersion, arg7: &mut 0x2::tx_context::TxContext) {
        let v0 = 0x2::tx_context::sender(arg7);
        assert!(arg6.version == 0, 2);
        assert!(arg1.is_migrated, 21);
        assert!(!arg5.is_paused, 24);
        assert!(0x2::vec_set::contains<address>(&arg0.has_maintainer_access, &v0), 18);
        assert!(0x1::vector::length<0x1::string::String>(&arg2) == 0x1::vector::length<u64>(&arg3), 3);
        assert!(0x1::vector::length<0x1::string::String>(&arg2) != 0, 11);
        assert!(0x1::vector::length<address>(&arg4) != 0, 11);
        let v1 = arg1.total_vested_amount;
        let v2 = process_accounts_and_amounts(arg2, arg3, arg1, v1);
        arg1.total_claims_amount = v2;
        add_users_sui_accounts(arg0, arg1, arg2, arg4, arg6, arg5, arg7);
        let v3 = UpdateMigratedData{
            evm_addresses       : arg2,
            mapped_sui_accounts : arg4,
            amounts             : arg3,
        };
        0x2::event::emit<UpdateMigratedData>(v3);
    }

    public entry fun upgrade_contract_version(arg0: &mut Owner, arg1: &mut UpgradeVersion, arg2: &mut 0x2::tx_context::TxContext) {
        assert!(0x2::tx_context::sender(arg2) == arg0.owner, 1);
        assert!(arg1.version < 0, 2);
        arg1.version = 0;
    }

    fun vest_token(arg0: &mut Owner, arg1: &mut 0x2::coin::Coin<0xf29428618abe285833214f7041e60462465b323b9ef7e4793cf25fdc3aeda674::test_token::TEST_TOKEN>, arg2: &mut VestedTokens, arg3: u64, arg4: &mut 0x2::tx_context::TxContext) {
        0x2::coin::join<0xf29428618abe285833214f7041e60462465b323b9ef7e4793cf25fdc3aeda674::test_token::TEST_TOKEN>(&mut arg2.coin, 0x2::coin::split<0xf29428618abe285833214f7041e60462465b323b9ef7e4793cf25fdc3aeda674::test_token::TEST_TOKEN>(arg1, arg3, arg4));
        arg0.already_vested = true;
        let v0 = VestedAmount{amount: arg3};
        0x2::event::emit<VestedAmount>(v0);
    }

    public entry fun withdraw(arg0: &mut HydroLocker, arg1: &mut StartVesting, arg2: &0x2::clock::Clock, arg3: 0x1::string::String, arg4: &mut VestedTokens, arg5: &PauseUnpauseContract, arg6: &UpgradeVersion, arg7: &mut 0x2::tx_context::TxContext) {
        let v0 = 0x2::tx_context::sender(arg7);
        assert!(arg6.version == 0, 2);
        assert!(!arg5.is_paused, 24);
        assert!(arg1.vesting_started == true, 7);
        assert!(42 == 0x1::string::length(&arg3), 16);
        assert!(0x2::vec_map::contains<0x1::string::String, Locker>(&arg0.lockers, &arg3), 5);
        let (v1, _, v3) = get_available_amount(arg0, arg3, arg1, arg2);
        assert!(v1 > 0, 10);
        assert!(v0 == *0x2::vec_map::get<0x1::string::String, address>(&arg0.address_locker, &arg3), 5);
        0x2::transfer::public_transfer<0x2::coin::Coin<0xf29428618abe285833214f7041e60462465b323b9ef7e4793cf25fdc3aeda674::test_token::TEST_TOKEN>>(0x2::coin::split<0xf29428618abe285833214f7041e60462465b323b9ef7e4793cf25fdc3aeda674::test_token::TEST_TOKEN>(&mut arg4.coin, v1, arg7), v0);
        let v4 = 0x2::vec_map::get_mut<0x1::string::String, Locker>(&mut arg0.lockers, &arg3);
        v4.remaining_balance = v4.remaining_balance - v1;
        v4.total_withdraw_balance = v4.total_withdraw_balance + v1;
        let v5 = WithdrawDetails{
            recipient         : v0,
            withdrawal_amount : v1,
            evm_address       : arg3,
            current_month     : v3,
        };
        0x2::event::emit<WithdrawDetails>(v5);
    }

    // decompiled from Move bytecode v6
}

