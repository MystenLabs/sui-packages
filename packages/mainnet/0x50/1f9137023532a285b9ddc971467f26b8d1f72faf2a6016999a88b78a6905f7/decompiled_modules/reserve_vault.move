module 0x501f9137023532a285b9ddc971467f26b8d1f72faf2a6016999a88b78a6905f7::reserve_vault {
    struct ReserveVault<phantom T0> has key {
        id: 0x2::object::UID,
        version: u64,
        owner: address,
        operator: address,
        collateral_vault: 0x2::balance::Balance<T0>,
        yoso_treasury: 0x2::coin::TreasuryCap<0x501f9137023532a285b9ddc971467f26b8d1f72faf2a6016999a88b78a6905f7::yosousd::YOSOUSD>,
        total_deposited: u64,
        total_withdrawn: u64,
        total_admin_minted: u64,
        total_reserve_removed: u64,
        total_admin_burned: u64,
        deposits_paused: bool,
        withdrawals_paused: bool,
        approved_contracts: 0x2::table::Table<address, bool>,
    }

    struct MigrationMintState<phantom T0> has key {
        id: 0x2::object::UID,
        version: u64,
        reserve_vault_id: 0x2::object::ID,
        migration_minter: address,
        migration_mint_per_tx_cap: u64,
        migration_mint_daily_cap: u64,
        migration_mint_day: u64,
        migration_minted_today: u64,
        migration_mint_hashes: 0x2::table::Table<vector<u8>, bool>,
    }

    struct ReserveVaultCreated has copy, drop {
        vault_id: 0x2::object::ID,
        owner: address,
    }

    struct MigrationMintStateCreated has copy, drop {
        state_id: 0x2::object::ID,
        reserve_vault_id: 0x2::object::ID,
    }

    struct Deposited has copy, drop {
        user: address,
        collateral_amount: u64,
        yoso_minted: u64,
    }

    struct Withdrawn has copy, drop {
        user: address,
        yoso_burned: u64,
        collateral_returned: u64,
    }

    struct AdminMinted has copy, drop {
        recipient: address,
        amount: u64,
    }

    struct MigrationMinted has copy, drop {
        recipient: address,
        amount: u64,
        evm_burn_tx_hash: vector<u8>,
    }

    struct AdminBurned has copy, drop {
        amount: u64,
    }

    struct ReserveRemoved has copy, drop {
        amount: u64,
        remaining_reserve: u64,
    }

    struct EmergencyWithdraw has copy, drop {
        token_kind: u8,
        amount: u64,
    }

    struct DepositsPausedUpdated has copy, drop {
        paused: bool,
    }

    struct WithdrawalsPausedUpdated has copy, drop {
        paused: bool,
    }

    struct ApprovedContractUpdated has copy, drop {
        contract_addr: address,
        approved: bool,
    }

    struct OperatorUpdated has copy, drop {
        old_operator: address,
        new_operator: address,
    }

    struct MigrationMinterUpdated has copy, drop {
        old_minter: address,
        new_minter: address,
    }

    struct MigrationMintCapsUpdated has copy, drop {
        per_tx_cap: u64,
        daily_cap: u64,
    }

    struct OwnershipTransferred has copy, drop {
        old_owner: address,
        new_owner: address,
    }

    public fun admin_burn<T0>(arg0: &mut ReserveVault<T0>, arg1: 0x2::coin::Coin<0x501f9137023532a285b9ddc971467f26b8d1f72faf2a6016999a88b78a6905f7::yosousd::YOSOUSD>, arg2: &mut 0x2::tx_context::TxContext) {
        assert_owner<T0>(arg0, arg2);
        let v0 = 0x2::coin::value<0x501f9137023532a285b9ddc971467f26b8d1f72faf2a6016999a88b78a6905f7::yosousd::YOSOUSD>(&arg1);
        assert!(v0 > 0, 3);
        arg0.total_admin_burned = arg0.total_admin_burned + v0;
        0x2::coin::burn<0x501f9137023532a285b9ddc971467f26b8d1f72faf2a6016999a88b78a6905f7::yosousd::YOSOUSD>(&mut arg0.yoso_treasury, arg1);
        let v1 = AdminBurned{amount: v0};
        0x2::event::emit<AdminBurned>(v1);
    }

    public fun admin_mint<T0>(arg0: &mut ReserveVault<T0>, arg1: address, arg2: u64, arg3: &mut 0x2::tx_context::TxContext) {
        assert_owner<T0>(arg0, arg3);
        assert!(arg2 > 0, 3);
        arg0.total_admin_minted = arg0.total_admin_minted + arg2;
        0x2::transfer::public_transfer<0x2::coin::Coin<0x501f9137023532a285b9ddc971467f26b8d1f72faf2a6016999a88b78a6905f7::yosousd::YOSOUSD>>(0x2::coin::mint<0x501f9137023532a285b9ddc971467f26b8d1f72faf2a6016999a88b78a6905f7::yosousd::YOSOUSD>(&mut arg0.yoso_treasury, arg2, arg3), arg1);
        let v0 = AdminMinted{
            recipient : arg1,
            amount    : arg2,
        };
        0x2::event::emit<AdminMinted>(v0);
    }

    public fun approved_contract<T0>(arg0: &ReserveVault<T0>, arg1: address) : bool {
        is_approved_contract<T0>(arg0, arg1)
    }

    fun assert_operator<T0>(arg0: &ReserveVault<T0>, arg1: &0x2::tx_context::TxContext) {
        assert_version<T0>(arg0);
        let v0 = 0x2::tx_context::sender(arg1);
        assert!(v0 == arg0.owner || v0 == arg0.operator, 1);
    }

    fun assert_owner<T0>(arg0: &ReserveVault<T0>, arg1: &0x2::tx_context::TxContext) {
        assert_version<T0>(arg0);
        assert!(0x2::tx_context::sender(arg1) == arg0.owner, 1);
    }

    fun assert_state_for_vault<T0>(arg0: &ReserveVault<T0>, arg1: &MigrationMintState<T0>) {
        assert_version<T0>(arg0);
        assert_state_version<T0>(arg1);
        assert!(arg1.reserve_vault_id == 0x2::object::id<ReserveVault<T0>>(arg0), 2);
    }

    fun assert_state_version<T0>(arg0: &MigrationMintState<T0>) {
        assert!(arg0.version == 1, 7);
    }

    fun assert_version<T0>(arg0: &ReserveVault<T0>) {
        assert!(arg0.version == 1, 7);
    }

    public fun deposit<T0>(arg0: &mut ReserveVault<T0>, arg1: 0x2::coin::Coin<T0>, arg2: &mut 0x2::tx_context::TxContext) {
        assert_version<T0>(arg0);
        assert!(!arg0.deposits_paused, 2);
        let v0 = 0x2::tx_context::sender(arg2);
        deposit_internal<T0>(arg0, arg1, v0, false, arg2);
    }

    public fun deposit_from_caller<T0>(arg0: &mut ReserveVault<T0>, arg1: 0x2::coin::Coin<T0>, arg2: &mut 0x2::tx_context::TxContext) {
        assert_version<T0>(arg0);
        let v0 = 0x2::tx_context::sender(arg2);
        assert!(is_approved_contract<T0>(arg0, v0), 1);
        deposit_internal<T0>(arg0, arg1, v0, true, arg2);
    }

    fun deposit_internal<T0>(arg0: &mut ReserveVault<T0>, arg1: 0x2::coin::Coin<T0>, arg2: address, arg3: bool, arg4: &mut 0x2::tx_context::TxContext) {
        let v0 = 0x2::coin::value<T0>(&arg1);
        assert!(v0 > 0, 3);
        0x2::balance::join<T0>(&mut arg0.collateral_vault, 0x2::coin::into_balance<T0>(arg1));
        if (!arg3) {
            arg0.total_deposited = arg0.total_deposited + v0;
            let v1 = Deposited{
                user              : arg2,
                collateral_amount : v0,
                yoso_minted       : v0,
            };
            0x2::event::emit<Deposited>(v1);
        };
        0x2::transfer::public_transfer<0x2::coin::Coin<0x501f9137023532a285b9ddc971467f26b8d1f72faf2a6016999a88b78a6905f7::yosousd::YOSOUSD>>(0x2::coin::mint<0x501f9137023532a285b9ddc971467f26b8d1f72faf2a6016999a88b78a6905f7::yosousd::YOSOUSD>(&mut arg0.yoso_treasury, v0, arg4), arg2);
    }

    public fun deposits_paused<T0>(arg0: &ReserveVault<T0>) : bool {
        assert_version<T0>(arg0);
        arg0.deposits_paused
    }

    public fun emergency_withdraw_collateral<T0>(arg0: &mut ReserveVault<T0>, arg1: u64, arg2: address, arg3: &mut 0x2::tx_context::TxContext) {
        assert_owner<T0>(arg0, arg3);
        assert!(arg1 > 0, 3);
        assert!(0x2::balance::value<T0>(&arg0.collateral_vault) >= arg1, 4);
        arg0.total_reserve_removed = arg0.total_reserve_removed + arg1;
        0x2::transfer::public_transfer<0x2::coin::Coin<T0>>(0x2::coin::from_balance<T0>(0x2::balance::split<T0>(&mut arg0.collateral_vault, arg1), arg3), arg2);
        let v0 = ReserveRemoved{
            amount            : arg1,
            remaining_reserve : 0x2::balance::value<T0>(&arg0.collateral_vault),
        };
        0x2::event::emit<ReserveRemoved>(v0);
        let v1 = EmergencyWithdraw{
            token_kind : 1,
            amount     : arg1,
        };
        0x2::event::emit<EmergencyWithdraw>(v1);
    }

    public fun init_migration_mint_state<T0>(arg0: &ReserveVault<T0>, arg1: &mut 0x2::tx_context::TxContext) {
        assert_owner<T0>(arg0, arg1);
        let v0 = new_migration_state<T0>(arg0, arg1);
        let v1 = MigrationMintStateCreated{
            state_id         : 0x2::object::id<MigrationMintState<T0>>(&v0),
            reserve_vault_id : v0.reserve_vault_id,
        };
        0x2::event::emit<MigrationMintStateCreated>(v1);
        0x2::transfer::share_object<MigrationMintState<T0>>(v0);
    }

    public fun init_vault<T0>(arg0: address, arg1: 0x2::coin::TreasuryCap<0x501f9137023532a285b9ddc971467f26b8d1f72faf2a6016999a88b78a6905f7::yosousd::YOSOUSD>, arg2: &mut 0x2::tx_context::TxContext) {
        let v0 = new_vault<T0>(arg0, arg1, arg2);
        let v1 = ReserveVaultCreated{
            vault_id : 0x2::object::id<ReserveVault<T0>>(&v0),
            owner    : arg0,
        };
        0x2::event::emit<ReserveVaultCreated>(v1);
        0x2::transfer::share_object<ReserveVault<T0>>(v0);
    }

    fun is_approved_contract<T0>(arg0: &ReserveVault<T0>, arg1: address) : bool {
        assert_version<T0>(arg0);
        0x2::table::contains<address, bool>(&arg0.approved_contracts, arg1) && *0x2::table::borrow<address, bool>(&arg0.approved_contracts, arg1)
    }

    public fun migration_hash_used<T0>(arg0: &MigrationMintState<T0>, arg1: vector<u8>) : bool {
        assert_state_version<T0>(arg0);
        0x2::table::contains<vector<u8>, bool>(&arg0.migration_mint_hashes, arg1)
    }

    public fun migration_mint<T0>(arg0: &mut ReserveVault<T0>, arg1: &mut MigrationMintState<T0>, arg2: address, arg3: u64, arg4: vector<u8>, arg5: &0x2::clock::Clock, arg6: &mut 0x2::tx_context::TxContext) {
        assert_state_for_vault<T0>(arg0, arg1);
        assert!(0x2::tx_context::sender(arg6) == arg1.migration_minter, 1);
        assert!(arg3 > 0, 3);
        assert!(arg1.migration_mint_per_tx_cap > 0, 2);
        assert!(arg1.migration_mint_daily_cap > 0, 2);
        assert!(arg3 <= arg1.migration_mint_per_tx_cap, 5);
        assert!(!0x2::table::contains<vector<u8>, bool>(&arg1.migration_mint_hashes, arg4), 6);
        let v0 = 0x2::clock::timestamp_ms(arg5) / 86400000;
        if (arg1.migration_mint_day != v0) {
            arg1.migration_mint_day = v0;
            arg1.migration_minted_today = 0;
        };
        assert!(arg3 <= arg1.migration_mint_daily_cap - arg1.migration_minted_today, 5);
        arg1.migration_minted_today = arg1.migration_minted_today + arg3;
        arg0.total_admin_minted = arg0.total_admin_minted + arg3;
        0x2::table::add<vector<u8>, bool>(&mut arg1.migration_mint_hashes, arg4, true);
        0x2::transfer::public_transfer<0x2::coin::Coin<0x501f9137023532a285b9ddc971467f26b8d1f72faf2a6016999a88b78a6905f7::yosousd::YOSOUSD>>(0x2::coin::mint<0x501f9137023532a285b9ddc971467f26b8d1f72faf2a6016999a88b78a6905f7::yosousd::YOSOUSD>(&mut arg0.yoso_treasury, arg3, arg6), arg2);
        let v1 = MigrationMinted{
            recipient        : arg2,
            amount           : arg3,
            evm_burn_tx_hash : arg4,
        };
        0x2::event::emit<MigrationMinted>(v1);
    }

    public fun migration_mint_daily_cap<T0>(arg0: &MigrationMintState<T0>) : u64 {
        assert_state_version<T0>(arg0);
        arg0.migration_mint_daily_cap
    }

    public fun migration_mint_per_tx_cap<T0>(arg0: &MigrationMintState<T0>) : u64 {
        assert_state_version<T0>(arg0);
        arg0.migration_mint_per_tx_cap
    }

    public fun migration_minted_today<T0>(arg0: &MigrationMintState<T0>) : u64 {
        assert_state_version<T0>(arg0);
        arg0.migration_minted_today
    }

    public fun migration_minter<T0>(arg0: &MigrationMintState<T0>) : address {
        assert_state_version<T0>(arg0);
        arg0.migration_minter
    }

    public fun migration_state_vault_id<T0>(arg0: &MigrationMintState<T0>) : 0x2::object::ID {
        assert_state_version<T0>(arg0);
        arg0.reserve_vault_id
    }

    public fun migration_state_version<T0>(arg0: &MigrationMintState<T0>) : u64 {
        assert_state_version<T0>(arg0);
        arg0.version
    }

    fun new_migration_state<T0>(arg0: &ReserveVault<T0>, arg1: &mut 0x2::tx_context::TxContext) : MigrationMintState<T0> {
        assert_version<T0>(arg0);
        MigrationMintState<T0>{
            id                        : 0x2::object::new(arg1),
            version                   : 1,
            reserve_vault_id          : 0x2::object::id<ReserveVault<T0>>(arg0),
            migration_minter          : @0x0,
            migration_mint_per_tx_cap : 0,
            migration_mint_daily_cap  : 0,
            migration_mint_day        : 0,
            migration_minted_today    : 0,
            migration_mint_hashes     : 0x2::table::new<vector<u8>, bool>(arg1),
        }
    }

    fun new_vault<T0>(arg0: address, arg1: 0x2::coin::TreasuryCap<0x501f9137023532a285b9ddc971467f26b8d1f72faf2a6016999a88b78a6905f7::yosousd::YOSOUSD>, arg2: &mut 0x2::tx_context::TxContext) : ReserveVault<T0> {
        ReserveVault<T0>{
            id                    : 0x2::object::new(arg2),
            version               : 1,
            owner                 : arg0,
            operator              : @0x0,
            collateral_vault      : 0x2::balance::zero<T0>(),
            yoso_treasury         : arg1,
            total_deposited       : 0,
            total_withdrawn       : 0,
            total_admin_minted    : 0,
            total_reserve_removed : 0,
            total_admin_burned    : 0,
            deposits_paused       : false,
            withdrawals_paused    : false,
            approved_contracts    : 0x2::table::new<address, bool>(arg2),
        }
    }

    public fun operator<T0>(arg0: &ReserveVault<T0>) : address {
        assert_version<T0>(arg0);
        arg0.operator
    }

    public fun owner<T0>(arg0: &ReserveVault<T0>) : address {
        assert_version<T0>(arg0);
        arg0.owner
    }

    public fun pause_deposits<T0>(arg0: &mut ReserveVault<T0>, arg1: &mut 0x2::tx_context::TxContext) {
        assert_operator<T0>(arg0, arg1);
        assert!(!arg0.deposits_paused, 2);
        arg0.deposits_paused = true;
        let v0 = DepositsPausedUpdated{paused: true};
        0x2::event::emit<DepositsPausedUpdated>(v0);
    }

    public fun pause_withdrawals<T0>(arg0: &mut ReserveVault<T0>, arg1: &mut 0x2::tx_context::TxContext) {
        assert_owner<T0>(arg0, arg1);
        assert!(!arg0.withdrawals_paused, 2);
        arg0.withdrawals_paused = true;
        let v0 = WithdrawalsPausedUpdated{paused: true};
        0x2::event::emit<WithdrawalsPausedUpdated>(v0);
    }

    public fun reserve_balance<T0>(arg0: &ReserveVault<T0>) : u64 {
        assert_version<T0>(arg0);
        0x2::balance::value<T0>(&arg0.collateral_vault)
    }

    public fun reserve_ratio_bps<T0>(arg0: &ReserveVault<T0>) : u64 {
        assert_version<T0>(arg0);
        let v0 = 0x2::coin::total_supply<0x501f9137023532a285b9ddc971467f26b8d1f72faf2a6016999a88b78a6905f7::yosousd::YOSOUSD>(&arg0.yoso_treasury);
        if (v0 == 0) {
            18446744073709551615
        } else {
            let v2 = (0x2::balance::value<T0>(&arg0.collateral_vault) as u128) * (10000 as u128) / (v0 as u128);
            assert!(v2 <= (18446744073709551615 as u128), 5);
            (v2 as u64)
        }
    }

    public fun set_approved_contract<T0>(arg0: &mut ReserveVault<T0>, arg1: address, arg2: bool, arg3: &mut 0x2::tx_context::TxContext) {
        assert_owner<T0>(arg0, arg3);
        if (0x2::table::contains<address, bool>(&arg0.approved_contracts, arg1)) {
            *0x2::table::borrow_mut<address, bool>(&mut arg0.approved_contracts, arg1) = arg2;
        } else {
            0x2::table::add<address, bool>(&mut arg0.approved_contracts, arg1, arg2);
        };
        let v0 = ApprovedContractUpdated{
            contract_addr : arg1,
            approved      : arg2,
        };
        0x2::event::emit<ApprovedContractUpdated>(v0);
    }

    public fun set_migration_mint_caps<T0>(arg0: &ReserveVault<T0>, arg1: &mut MigrationMintState<T0>, arg2: u64, arg3: u64, arg4: &mut 0x2::tx_context::TxContext) {
        assert_owner<T0>(arg0, arg4);
        assert_state_for_vault<T0>(arg0, arg1);
        arg1.migration_mint_per_tx_cap = arg2;
        arg1.migration_mint_daily_cap = arg3;
        let v0 = MigrationMintCapsUpdated{
            per_tx_cap : arg2,
            daily_cap  : arg3,
        };
        0x2::event::emit<MigrationMintCapsUpdated>(v0);
    }

    public fun set_migration_minter<T0>(arg0: &ReserveVault<T0>, arg1: &mut MigrationMintState<T0>, arg2: address, arg3: &mut 0x2::tx_context::TxContext) {
        assert_owner<T0>(arg0, arg3);
        assert_state_for_vault<T0>(arg0, arg1);
        arg1.migration_minter = arg2;
        let v0 = MigrationMinterUpdated{
            old_minter : arg1.migration_minter,
            new_minter : arg2,
        };
        0x2::event::emit<MigrationMinterUpdated>(v0);
    }

    public fun set_operator<T0>(arg0: &mut ReserveVault<T0>, arg1: address, arg2: &mut 0x2::tx_context::TxContext) {
        assert_owner<T0>(arg0, arg2);
        arg0.operator = arg1;
        let v0 = OperatorUpdated{
            old_operator : arg0.operator,
            new_operator : arg1,
        };
        0x2::event::emit<OperatorUpdated>(v0);
    }

    public fun total_admin_burned<T0>(arg0: &ReserveVault<T0>) : u64 {
        assert_version<T0>(arg0);
        arg0.total_admin_burned
    }

    public fun total_admin_minted<T0>(arg0: &ReserveVault<T0>) : u64 {
        assert_version<T0>(arg0);
        arg0.total_admin_minted
    }

    public fun total_deposited<T0>(arg0: &ReserveVault<T0>) : u64 {
        assert_version<T0>(arg0);
        arg0.total_deposited
    }

    public fun total_reserve_removed<T0>(arg0: &ReserveVault<T0>) : u64 {
        assert_version<T0>(arg0);
        arg0.total_reserve_removed
    }

    public fun total_withdrawn<T0>(arg0: &ReserveVault<T0>) : u64 {
        assert_version<T0>(arg0);
        arg0.total_withdrawn
    }

    public fun transfer_ownership<T0>(arg0: &mut ReserveVault<T0>, arg1: address, arg2: &mut 0x2::tx_context::TxContext) {
        assert_owner<T0>(arg0, arg2);
        arg0.owner = arg1;
        let v0 = OwnershipTransferred{
            old_owner : arg0.owner,
            new_owner : arg1,
        };
        0x2::event::emit<OwnershipTransferred>(v0);
    }

    public fun unpause_deposits<T0>(arg0: &mut ReserveVault<T0>, arg1: &mut 0x2::tx_context::TxContext) {
        assert_owner<T0>(arg0, arg1);
        assert!(arg0.deposits_paused, 2);
        arg0.deposits_paused = false;
        let v0 = DepositsPausedUpdated{paused: false};
        0x2::event::emit<DepositsPausedUpdated>(v0);
    }

    public fun unpause_withdrawals<T0>(arg0: &mut ReserveVault<T0>, arg1: &mut 0x2::tx_context::TxContext) {
        assert_owner<T0>(arg0, arg1);
        assert!(arg0.withdrawals_paused, 2);
        arg0.withdrawals_paused = false;
        let v0 = WithdrawalsPausedUpdated{paused: false};
        0x2::event::emit<WithdrawalsPausedUpdated>(v0);
    }

    public fun version<T0>(arg0: &ReserveVault<T0>) : u64 {
        assert_version<T0>(arg0);
        arg0.version
    }

    public fun withdraw<T0>(arg0: &mut ReserveVault<T0>, arg1: 0x2::coin::Coin<0x501f9137023532a285b9ddc971467f26b8d1f72faf2a6016999a88b78a6905f7::yosousd::YOSOUSD>, arg2: &mut 0x2::tx_context::TxContext) {
        assert_version<T0>(arg0);
        assert!(!arg0.withdrawals_paused, 2);
        let v0 = 0x2::tx_context::sender(arg2);
        withdraw_internal<T0>(arg0, arg1, v0, false, arg2);
    }

    public fun withdraw_from_caller<T0>(arg0: &mut ReserveVault<T0>, arg1: 0x2::coin::Coin<0x501f9137023532a285b9ddc971467f26b8d1f72faf2a6016999a88b78a6905f7::yosousd::YOSOUSD>, arg2: &mut 0x2::tx_context::TxContext) {
        assert_version<T0>(arg0);
        let v0 = 0x2::tx_context::sender(arg2);
        assert!(is_approved_contract<T0>(arg0, v0), 1);
        withdraw_internal<T0>(arg0, arg1, v0, true, arg2);
    }

    fun withdraw_internal<T0>(arg0: &mut ReserveVault<T0>, arg1: 0x2::coin::Coin<0x501f9137023532a285b9ddc971467f26b8d1f72faf2a6016999a88b78a6905f7::yosousd::YOSOUSD>, arg2: address, arg3: bool, arg4: &mut 0x2::tx_context::TxContext) {
        let v0 = 0x2::coin::value<0x501f9137023532a285b9ddc971467f26b8d1f72faf2a6016999a88b78a6905f7::yosousd::YOSOUSD>(&arg1);
        assert!(v0 > 0, 3);
        assert!(0x2::balance::value<T0>(&arg0.collateral_vault) >= v0, 4);
        0x2::coin::burn<0x501f9137023532a285b9ddc971467f26b8d1f72faf2a6016999a88b78a6905f7::yosousd::YOSOUSD>(&mut arg0.yoso_treasury, arg1);
        if (!arg3) {
            arg0.total_withdrawn = arg0.total_withdrawn + v0;
            let v1 = Withdrawn{
                user                : arg2,
                yoso_burned         : v0,
                collateral_returned : v0,
            };
            0x2::event::emit<Withdrawn>(v1);
        };
        0x2::transfer::public_transfer<0x2::coin::Coin<T0>>(0x2::coin::from_balance<T0>(0x2::balance::split<T0>(&mut arg0.collateral_vault, v0), arg4), arg2);
    }

    public fun withdrawals_paused<T0>(arg0: &ReserveVault<T0>) : bool {
        assert_version<T0>(arg0);
        arg0.withdrawals_paused
    }

    // decompiled from Move bytecode v7
}

