module 0x4e4c16d833abe593b81ebffb232e0798876b848fb2b55afef787c94db122edd4::enjoyoors_vault {
    struct ENJOYOORS_VAULT has drop {
        dummy_field: bool,
    }

    struct VaultConfig has store, key {
        id: 0x2::object::UID,
        roles: 0x2::vec_map::VecMap<u8, address>,
        pending_admin: 0x1::option::Option<address>,
        coins: 0x2::table::Table<0x2::object::ID, CoinConfig>,
    }

    struct CoinConfig has store {
        are_deposits_paused: bool,
        are_withdrawals_paused: bool,
        are_claims_paused: bool,
        min_deposit: u64,
        supply_till_limit: u64,
    }

    struct CoinDepositsStorage<phantom T0> has store, key {
        id: 0x2::object::UID,
        balance: 0x2::balance::Balance<T0>,
        total_supply: u64,
        user_deposits: 0x2::table::Table<address, u64>,
    }

    struct CoinDepositsStorageRegistry has store, key {
        id: 0x2::object::UID,
        coin_deposits: 0x2::table::Table<0x2::object::ID, 0x2::object::ID>,
    }

    struct WithdrawalStats has store, key {
        id: 0x2::object::UID,
        approval_table_id: 0x1::option::Option<0x2::object::ID>,
        last_request_id: u64,
        withdrawal_requests: 0x2::vec_map::VecMap<u64, WithdrawalRequest>,
    }

    struct WithdrawalRequest has drop, store {
        amount: u64,
        user: address,
        coin_metadata_id: 0x2::object::ID,
        timestamp: u64,
    }

    struct Initialized has copy, drop {
        vault_config_id: 0x2::object::ID,
        coin_deposits_storage_registry_id: 0x2::object::ID,
        withdrawal_stats_id: 0x2::object::ID,
    }

    struct Deposit has copy, drop {
        coin_metadata_id: 0x2::object::ID,
        user: address,
        amount: u64,
    }

    struct WithdrawalRequested has copy, drop {
        coin_metadata_id: 0x2::object::ID,
        user: address,
        request_id: u64,
        amount: u64,
    }

    struct WithdrawalClaimed has copy, drop {
        request_id: u64,
        amount: u64,
    }

    struct RoleGranted has copy, drop {
        role: u8,
        account: address,
        sender: address,
    }

    struct RoleRevoked has copy, drop {
        role: u8,
        from: address,
        sender: address,
    }

    struct AdminRightsAccepted has copy, drop {
        by: address,
    }

    struct AdminRightsTransfer has copy, drop {
        from: address,
        to: address,
    }

    struct AdminRightsTransferCanceled has copy, drop {
        dummy_field: bool,
    }

    struct NewCoinListed has copy, drop {
        coin_metadata_id: 0x2::object::ID,
        coin_deposits_storage_id: 0x2::object::ID,
    }

    struct ApprovalTableIdChanged has copy, drop {
        old: 0x1::option::Option<0x2::object::ID>,
        new: 0x2::object::ID,
    }

    struct MinDepositChanged has copy, drop {
        coin_metadata_id: 0x2::object::ID,
        old: u64,
        new: u64,
    }

    struct SupplyLimitIncreased has copy, drop {
        coin_metadata_id: 0x2::object::ID,
        delta: u64,
    }

    struct SupplyLimitDecreased has copy, drop {
        coin_metadata_id: 0x2::object::ID,
        delta: u64,
    }

    struct PauseClaims has copy, drop {
        coin_metadata_id: 0x2::object::ID,
    }

    struct PauseDeposits has copy, drop {
        coin_metadata_id: 0x2::object::ID,
    }

    struct PauseWithdrawals has copy, drop {
        coin_metadata_id: 0x2::object::ID,
    }

    struct ResumeClaims has copy, drop {
        coin_metadata_id: 0x2::object::ID,
    }

    struct ResumeDeposits has copy, drop {
        coin_metadata_id: 0x2::object::ID,
    }

    struct ResumeWithdrawals has copy, drop {
        coin_metadata_id: 0x2::object::ID,
    }

    public fun accept_admin(arg0: &mut VaultConfig, arg1: &mut 0x2::tx_context::TxContext) {
        assert!(0x1::option::is_some<address>(&arg0.pending_admin), 77700);
        assert!(*0x1::option::borrow<address>(&arg0.pending_admin) == 0x2::tx_context::sender(arg1), 77700);
        grant_role_inner(arg0, 0, 0x2::tx_context::sender(arg1), 0x2::tx_context::sender(arg1));
        arg0.pending_admin = 0x1::option::none<address>();
        let v0 = AdminRightsAccepted{by: 0x2::tx_context::sender(arg1)};
        0x2::event::emit<AdminRightsAccepted>(v0);
    }

    public fun add_coin<T0>(arg0: &mut VaultConfig, arg1: &mut CoinDepositsStorageRegistry, arg2: &0x2::coin::CoinMetadata<T0>, arg3: &mut 0x2::tx_context::TxContext) {
        only_role(arg0, 8, 0x2::tx_context::sender(arg3));
        let v0 = 0x2::object::id<0x2::coin::CoinMetadata<T0>>(arg2);
        assert!(!0x2::table::contains<0x2::object::ID, CoinConfig>(&arg0.coins, v0), 77702);
        let v1 = CoinConfig{
            are_deposits_paused    : false,
            are_withdrawals_paused : false,
            are_claims_paused      : false,
            min_deposit            : 0,
            supply_till_limit      : 0,
        };
        0x2::table::add<0x2::object::ID, CoinConfig>(&mut arg0.coins, v0, v1);
        let v2 = CoinDepositsStorage<T0>{
            id            : 0x2::object::new(arg3),
            balance       : 0x2::balance::zero<T0>(),
            total_supply  : 0,
            user_deposits : 0x2::table::new<address, u64>(arg3),
        };
        let v3 = 0x2::object::id<CoinDepositsStorage<T0>>(&v2);
        0x2::table::add<0x2::object::ID, 0x2::object::ID>(&mut arg1.coin_deposits, v0, v3);
        let v4 = NewCoinListed{
            coin_metadata_id         : v0,
            coin_deposits_storage_id : v3,
        };
        0x2::event::emit<NewCoinListed>(v4);
        0x2::transfer::share_object<CoinDepositsStorage<T0>>(v2);
    }

    public fun cancel_admin_transfer(arg0: &mut VaultConfig, arg1: &mut 0x2::tx_context::TxContext) {
        only_role(arg0, 0, 0x2::tx_context::sender(arg1));
        assert!(0x1::option::is_some<address>(&arg0.pending_admin), 77720);
        arg0.pending_admin = 0x1::option::none<address>();
        let v0 = AdminRightsTransferCanceled{dummy_field: false};
        0x2::event::emit<AdminRightsTransferCanceled>(v0);
    }

    public fun change_approval_table_id(arg0: &VaultConfig, arg1: &mut WithdrawalStats, arg2: 0x2::object::ID, arg3: &mut 0x2::tx_context::TxContext) {
        only_role(arg0, 1, 0x2::tx_context::sender(arg3));
        arg1.approval_table_id = 0x1::option::some<0x2::object::ID>(arg2);
        let v0 = ApprovalTableIdChanged{
            old : arg1.approval_table_id,
            new : arg2,
        };
        0x2::event::emit<ApprovalTableIdChanged>(v0);
    }

    public fun change_min_deposit(arg0: &mut VaultConfig, arg1: 0x2::object::ID, arg2: u64, arg3: &mut 0x2::tx_context::TxContext) {
        only_role(arg0, 1, 0x2::tx_context::sender(arg3));
        let v0 = 0x2::table::borrow_mut<0x2::object::ID, CoinConfig>(&mut arg0.coins, arg1);
        v0.min_deposit = arg2;
        let v1 = MinDepositChanged{
            coin_metadata_id : arg1,
            old              : v0.min_deposit,
            new              : arg2,
        };
        0x2::event::emit<MinDepositChanged>(v1);
    }

    public fun decrease_supply_limit(arg0: &mut VaultConfig, arg1: 0x2::object::ID, arg2: u64, arg3: &mut 0x2::tx_context::TxContext) {
        only_role(arg0, 1, 0x2::tx_context::sender(arg3));
        assert!(arg2 > 0, 77714);
        let v0 = 0x2::table::borrow_mut<0x2::object::ID, CoinConfig>(&mut arg0.coins, arg1);
        assert!(v0.supply_till_limit >= arg2, 77707);
        v0.supply_till_limit = v0.supply_till_limit - arg2;
        let v1 = SupplyLimitDecreased{
            coin_metadata_id : arg1,
            delta            : arg2,
        };
        0x2::event::emit<SupplyLimitDecreased>(v1);
    }

    public fun deposit<T0>(arg0: &mut VaultConfig, arg1: &mut CoinDepositsStorage<T0>, arg2: 0x2::coin::Coin<T0>, arg3: 0x2::object::ID, arg4: &0x2::tx_context::TxContext) {
        assert!(0x2::table::contains<0x2::object::ID, CoinConfig>(&arg0.coins, arg3), 77703);
        let v0 = 0x2::table::borrow_mut<0x2::object::ID, CoinConfig>(&mut arg0.coins, arg3);
        assert!(!v0.are_deposits_paused, 77704);
        let v1 = 0x2::coin::value<T0>(&arg2);
        assert!(v1 >= v0.min_deposit && v1 > 0, 77711);
        assert!(v1 <= v0.supply_till_limit, 77701);
        arg1.total_supply = arg1.total_supply + v1;
        let v2 = &mut arg1.user_deposits;
        let v3 = 0x2::tx_context::sender(arg4);
        if (0x2::table::contains<address, u64>(v2, v3)) {
            let v4 = 0x2::table::borrow_mut<address, u64>(v2, v3);
            *v4 = *v4 + v1;
        } else {
            0x2::table::add<address, u64>(v2, v3, v1);
        };
        v0.supply_till_limit = v0.supply_till_limit - v1;
        0x2::coin::put<T0>(&mut arg1.balance, arg2);
        let v5 = Deposit{
            coin_metadata_id : arg3,
            user             : v3,
            amount           : v1,
        };
        0x2::event::emit<Deposit>(v5);
    }

    public fun finalize_withdrawal<T0>(arg0: &mut VaultConfig, arg1: &mut WithdrawalStats, arg2: &mut CoinDepositsStorage<T0>, arg3: u64, arg4: 0x2::object::ID, arg5: &0x2::table::Table<u64, bool>, arg6: &mut 0x2::tx_context::TxContext) {
        assert!(0x2::table::contains<0x2::object::ID, CoinConfig>(&arg0.coins, arg4), 77703);
        let v0 = 0x2::table::borrow_mut<0x2::object::ID, CoinConfig>(&mut arg0.coins, arg4);
        assert!(!v0.are_claims_paused, 77706);
        assert!(0x2::vec_map::contains<u64, WithdrawalRequest>(&arg1.withdrawal_requests, &arg3), 77717);
        assert!(0x1::option::is_some<0x2::object::ID>(&arg1.approval_table_id), 77716);
        let v1 = 0x2::object::id<0x2::table::Table<u64, bool>>(arg5);
        assert!(&v1 == 0x1::option::borrow<0x2::object::ID>(&arg1.approval_table_id), 77715);
        assert!(0x2::table::contains<u64, bool>(arg5, arg3), 77718);
        let v2 = 0x2::vec_map::get<u64, WithdrawalRequest>(&arg1.withdrawal_requests, &arg3);
        let v3 = v2.amount;
        v0.supply_till_limit = v0.supply_till_limit + v3;
        0x2::transfer::public_transfer<0x2::coin::Coin<T0>>(0x2::coin::take<T0>(&mut arg2.balance, v3, arg6), v2.user);
        let (_, _) = 0x2::vec_map::remove<u64, WithdrawalRequest>(&mut arg1.withdrawal_requests, &arg3);
        let v6 = WithdrawalClaimed{
            request_id : arg3,
            amount     : v3,
        };
        0x2::event::emit<WithdrawalClaimed>(v6);
    }

    public fun get_coin_config(arg0: &VaultConfig, arg1: 0x2::object::ID) : &CoinConfig {
        assert!(0x2::table::contains<0x2::object::ID, CoinConfig>(&arg0.coins, arg1), 77703);
        0x2::table::borrow<0x2::object::ID, CoinConfig>(&arg0.coins, arg1)
    }

    public fun get_last_withdrawal_request_id(arg0: &WithdrawalStats) : u64 {
        arg0.last_request_id
    }

    public fun get_min_deposit(arg0: &CoinConfig) : u64 {
        arg0.min_deposit
    }

    public fun get_supply_till_limit(arg0: &CoinConfig) : u64 {
        arg0.supply_till_limit
    }

    public fun get_total_supply<T0>(arg0: &CoinDepositsStorage<T0>) : u64 {
        arg0.total_supply
    }

    public fun get_user_deposit<T0>(arg0: &CoinDepositsStorage<T0>, arg1: address) : u64 {
        if (0x2::table::contains<address, u64>(&arg0.user_deposits, arg1)) {
            return *0x2::table::borrow<address, u64>(&arg0.user_deposits, arg1)
        };
        0
    }

    public fun get_withdrawal_request_amount(arg0: &WithdrawalRequest) : u64 {
        arg0.amount
    }

    public fun get_withdrawal_request_by_id(arg0: &WithdrawalStats, arg1: &u64) : &WithdrawalRequest {
        assert!(0x2::vec_map::contains<u64, WithdrawalRequest>(&arg0.withdrawal_requests, arg1), 77717);
        0x2::vec_map::get<u64, WithdrawalRequest>(&arg0.withdrawal_requests, arg1)
    }

    public fun get_withdrawal_request_timestamp(arg0: &WithdrawalRequest) : u64 {
        arg0.timestamp
    }

    public fun get_withdrawal_request_user(arg0: &WithdrawalRequest) : address {
        arg0.user
    }

    public fun grant_role(arg0: &mut VaultConfig, arg1: u8, arg2: address, arg3: &mut 0x2::tx_context::TxContext) {
        only_role(arg0, 0, 0x2::tx_context::sender(arg3));
        assert!(arg1 < 9, 77712);
        assert!(arg1 != 0, 77712);
        grant_role_inner(arg0, arg1, arg2, 0x2::tx_context::sender(arg3));
    }

    fun grant_role_inner(arg0: &mut VaultConfig, arg1: u8, arg2: address, arg3: address) {
        let v0 = 0x2::vec_map::try_get<u8, address>(&arg0.roles, &arg1);
        if (0x1::option::is_some<address>(&v0)) {
            let v1 = *0x1::option::borrow<address>(&v0);
            assert!(v1 != arg2, 77719);
            let (_, _) = 0x2::vec_map::remove<u8, address>(&mut arg0.roles, &arg1);
            let v4 = RoleRevoked{
                role   : arg1,
                from   : v1,
                sender : arg3,
            };
            0x2::event::emit<RoleRevoked>(v4);
        };
        0x2::vec_map::insert<u8, address>(&mut arg0.roles, arg1, arg2);
        let v5 = RoleGranted{
            role    : arg1,
            account : arg2,
            sender  : arg3,
        };
        0x2::event::emit<RoleGranted>(v5);
    }

    public fun increase_supply_limit(arg0: &mut VaultConfig, arg1: 0x2::object::ID, arg2: u64, arg3: &mut 0x2::tx_context::TxContext) {
        only_role(arg0, 1, 0x2::tx_context::sender(arg3));
        assert!(arg2 > 0, 77714);
        let v0 = 0x2::table::borrow_mut<0x2::object::ID, CoinConfig>(&mut arg0.coins, arg1);
        v0.supply_till_limit = v0.supply_till_limit + arg2;
        let v1 = SupplyLimitIncreased{
            coin_metadata_id : arg1,
            delta            : arg2,
        };
        0x2::event::emit<SupplyLimitIncreased>(v1);
    }

    fun init(arg0: ENJOYOORS_VAULT, arg1: &mut 0x2::tx_context::TxContext) {
        0x2::package::claim_and_keep<ENJOYOORS_VAULT>(arg0, arg1);
        let v0 = 0x2::vec_map::empty<u8, address>();
        0x2::vec_map::insert<u8, address>(&mut v0, 0, 0x2::tx_context::sender(arg1));
        let v1 = VaultConfig{
            id            : 0x2::object::new(arg1),
            roles         : v0,
            pending_admin : 0x1::option::none<address>(),
            coins         : 0x2::table::new<0x2::object::ID, CoinConfig>(arg1),
        };
        let v2 = CoinDepositsStorageRegistry{
            id            : 0x2::object::new(arg1),
            coin_deposits : 0x2::table::new<0x2::object::ID, 0x2::object::ID>(arg1),
        };
        let v3 = WithdrawalStats{
            id                  : 0x2::object::new(arg1),
            approval_table_id   : 0x1::option::none<0x2::object::ID>(),
            last_request_id     : 0,
            withdrawal_requests : 0x2::vec_map::empty<u64, WithdrawalRequest>(),
        };
        let v4 = Initialized{
            vault_config_id                   : 0x2::object::id<VaultConfig>(&v1),
            coin_deposits_storage_registry_id : 0x2::object::id<CoinDepositsStorageRegistry>(&v2),
            withdrawal_stats_id               : 0x2::object::id<WithdrawalStats>(&v3),
        };
        0x2::event::emit<Initialized>(v4);
        0x2::transfer::share_object<VaultConfig>(v1);
        0x2::transfer::share_object<CoinDepositsStorageRegistry>(v2);
        0x2::transfer::share_object<WithdrawalStats>(v3);
    }

    fun only_role(arg0: &VaultConfig, arg1: u8, arg2: address) {
        assert!(arg1 < 9, 77712);
        assert!(0x2::vec_map::try_get<u8, address>(&arg0.roles, &arg1) == 0x1::option::some<address>(arg2), 77700);
    }

    public fun pause_claim(arg0: &mut VaultConfig, arg1: 0x2::object::ID, arg2: &mut 0x2::tx_context::TxContext) {
        only_role(arg0, 2, 0x2::tx_context::sender(arg2));
        let v0 = 0x2::table::borrow_mut<0x2::object::ID, CoinConfig>(&mut arg0.coins, arg1);
        assert!(!v0.are_claims_paused, 77706);
        v0.are_claims_paused = true;
        let v1 = PauseClaims{coin_metadata_id: arg1};
        0x2::event::emit<PauseClaims>(v1);
    }

    public fun pause_deposit(arg0: &mut VaultConfig, arg1: 0x2::object::ID, arg2: &mut 0x2::tx_context::TxContext) {
        only_role(arg0, 3, 0x2::tx_context::sender(arg2));
        let v0 = 0x2::table::borrow_mut<0x2::object::ID, CoinConfig>(&mut arg0.coins, arg1);
        assert!(!v0.are_deposits_paused, 77704);
        v0.are_deposits_paused = true;
        let v1 = PauseDeposits{coin_metadata_id: arg1};
        0x2::event::emit<PauseDeposits>(v1);
    }

    public fun pause_withdrawal(arg0: &mut VaultConfig, arg1: 0x2::object::ID, arg2: &mut 0x2::tx_context::TxContext) {
        only_role(arg0, 4, 0x2::tx_context::sender(arg2));
        let v0 = 0x2::table::borrow_mut<0x2::object::ID, CoinConfig>(&mut arg0.coins, arg1);
        assert!(!v0.are_withdrawals_paused, 77705);
        v0.are_withdrawals_paused = true;
        let v1 = PauseWithdrawals{coin_metadata_id: arg1};
        0x2::event::emit<PauseWithdrawals>(v1);
    }

    public fun request_withdrawal<T0>(arg0: &mut VaultConfig, arg1: &mut WithdrawalStats, arg2: &mut CoinDepositsStorage<T0>, arg3: u64, arg4: 0x2::object::ID, arg5: &0x2::clock::Clock, arg6: &0x2::tx_context::TxContext) {
        assert!(arg3 > 0, 77714);
        assert!(0x2::table::contains<0x2::object::ID, CoinConfig>(&arg0.coins, arg4), 77703);
        assert!(!0x2::table::borrow_mut<0x2::object::ID, CoinConfig>(&mut arg0.coins, arg4).are_withdrawals_paused, 77705);
        let v0 = &mut arg2.user_deposits;
        let v1 = 0x2::tx_context::sender(arg6);
        assert!(0x2::table::contains<address, u64>(v0, v1), 77713);
        let v2 = 0x2::table::borrow_mut<address, u64>(v0, v1);
        assert!(*v2 >= arg3, 77713);
        if (arg3 == *v2) {
            0x2::table::remove<address, u64>(v0, v1);
        } else {
            *v2 = *v2 - arg3;
        };
        arg2.total_supply = arg2.total_supply - arg3;
        let v3 = arg1.last_request_id + 1;
        arg1.last_request_id = v3;
        let v4 = WithdrawalRequest{
            amount           : arg3,
            user             : v1,
            coin_metadata_id : arg4,
            timestamp        : 0x2::clock::timestamp_ms(arg5),
        };
        0x2::vec_map::insert<u64, WithdrawalRequest>(&mut arg1.withdrawal_requests, v3, v4);
        let v5 = WithdrawalRequested{
            coin_metadata_id : arg4,
            user             : v1,
            request_id       : v3,
            amount           : arg3,
        };
        0x2::event::emit<WithdrawalRequested>(v5);
    }

    public fun resume_claim(arg0: &mut VaultConfig, arg1: 0x2::object::ID, arg2: &mut 0x2::tx_context::TxContext) {
        only_role(arg0, 5, 0x2::tx_context::sender(arg2));
        let v0 = 0x2::table::borrow_mut<0x2::object::ID, CoinConfig>(&mut arg0.coins, arg1);
        assert!(v0.are_claims_paused, 77710);
        v0.are_claims_paused = false;
        let v1 = ResumeClaims{coin_metadata_id: arg1};
        0x2::event::emit<ResumeClaims>(v1);
    }

    public fun resume_deposit(arg0: &mut VaultConfig, arg1: 0x2::object::ID, arg2: &mut 0x2::tx_context::TxContext) {
        only_role(arg0, 6, 0x2::tx_context::sender(arg2));
        let v0 = 0x2::table::borrow_mut<0x2::object::ID, CoinConfig>(&mut arg0.coins, arg1);
        assert!(v0.are_deposits_paused, 77708);
        v0.are_deposits_paused = false;
        let v1 = ResumeDeposits{coin_metadata_id: arg1};
        0x2::event::emit<ResumeDeposits>(v1);
    }

    public fun resume_withdrawal(arg0: &mut VaultConfig, arg1: 0x2::object::ID, arg2: &mut 0x2::tx_context::TxContext) {
        only_role(arg0, 7, 0x2::tx_context::sender(arg2));
        let v0 = 0x2::table::borrow_mut<0x2::object::ID, CoinConfig>(&mut arg0.coins, arg1);
        assert!(v0.are_withdrawals_paused, 77709);
        v0.are_withdrawals_paused = false;
        let v1 = ResumeWithdrawals{coin_metadata_id: arg1};
        0x2::event::emit<ResumeWithdrawals>(v1);
    }

    public fun transfer_admin(arg0: &mut VaultConfig, arg1: address, arg2: &mut 0x2::tx_context::TxContext) {
        only_role(arg0, 0, 0x2::tx_context::sender(arg2));
        assert!(0x2::tx_context::sender(arg2) != arg1, 77719);
        assert!(0x1::option::is_none<address>(&arg0.pending_admin), 77721);
        arg0.pending_admin = 0x1::option::some<address>(arg1);
        let v0 = AdminRightsTransfer{
            from : 0x2::tx_context::sender(arg2),
            to   : arg1,
        };
        0x2::event::emit<AdminRightsTransfer>(v0);
    }

    // decompiled from Move bytecode v6
}

