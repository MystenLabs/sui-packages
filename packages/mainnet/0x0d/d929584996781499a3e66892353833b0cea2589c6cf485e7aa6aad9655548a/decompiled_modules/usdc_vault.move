module 0xdd929584996781499a3e66892353833b0cea2589c6cf485e7aa6aad9655548a::usdc_vault {
    struct USDC_VAULT has drop {
        dummy_field: bool,
    }

    struct SuperAdminCap has store, key {
        id: 0x2::object::UID,
        vault_id: 0x2::object::ID,
    }

    struct AdminCap has store, key {
        id: 0x2::object::UID,
        vault_id: 0x2::object::ID,
    }

    struct USDCVault has key {
        id: 0x2::object::UID,
        balance: 0x2::balance::Balance<0xdba34672e30cb065b1f93e3ab55318768fd6fef66c15942c9f7cb846e2f900e7::usdc::USDC>,
        revoked_caps: 0x2::table::Table<0x2::object::ID, bool>,
        created_at: u64,
        paused: bool,
    }

    struct Paused has copy, drop {
        vault_id: 0x2::object::ID,
        timestamp: u64,
    }

    struct Unpaused has copy, drop {
        vault_id: 0x2::object::ID,
        timestamp: u64,
    }

    struct USDCDeposited has copy, drop {
        vault_id: 0x2::object::ID,
        amount: u64,
        depositor: address,
        timestamp: u64,
    }

    struct USDCWithdrawn has copy, drop {
        vault_id: 0x2::object::ID,
        amount: u64,
        withdrawer: address,
        timestamp: u64,
    }

    struct AdminCapCreated has copy, drop {
        admin_cap_id: 0x2::object::ID,
        vault_id: 0x2::object::ID,
        timestamp: u64,
    }

    struct AdminCapRevoked has copy, drop {
        admin_cap_id: 0x2::object::ID,
        vault_id: 0x2::object::ID,
        timestamp: u64,
    }

    struct USDCVaultCreated has copy, drop {
        vault_id: 0x2::object::ID,
        timestamp: u64,
    }

    public fun create_admin_cap(arg0: &USDCVault, arg1: &SuperAdminCap, arg2: &mut 0x2::tx_context::TxContext) : AdminCap {
        verify_super_admin_cap(arg0, arg1);
        let v0 = AdminCap{
            id       : 0x2::object::new(arg2),
            vault_id : 0x2::object::id<USDCVault>(arg0),
        };
        let v1 = AdminCapCreated{
            admin_cap_id : 0x2::object::id<AdminCap>(&v0),
            vault_id     : 0x2::object::id<USDCVault>(arg0),
            timestamp    : 0x2::tx_context::epoch_timestamp_ms(arg2),
        };
        0x2::event::emit<AdminCapCreated>(v1);
        v0
    }

    public entry fun create_admin_cap_to(arg0: &USDCVault, arg1: &SuperAdminCap, arg2: address, arg3: &mut 0x2::tx_context::TxContext) {
        0x2::transfer::transfer<AdminCap>(create_admin_cap(arg0, arg1, arg3), arg2);
    }

    fun create_vault(arg0: &mut 0x2::tx_context::TxContext) : (USDCVault, SuperAdminCap) {
        let v0 = USDCVault{
            id           : 0x2::object::new(arg0),
            balance      : 0x2::balance::zero<0xdba34672e30cb065b1f93e3ab55318768fd6fef66c15942c9f7cb846e2f900e7::usdc::USDC>(),
            revoked_caps : 0x2::table::new<0x2::object::ID, bool>(arg0),
            created_at   : 0x2::tx_context::epoch_timestamp_ms(arg0),
            paused       : false,
        };
        let v1 = SuperAdminCap{
            id       : 0x2::object::new(arg0),
            vault_id : 0x2::object::id<USDCVault>(&v0),
        };
        let v2 = USDCVaultCreated{
            vault_id  : 0x2::object::id<USDCVault>(&v0),
            timestamp : 0x2::tx_context::epoch_timestamp_ms(arg0),
        };
        0x2::event::emit<USDCVaultCreated>(v2);
        (v0, v1)
    }

    fun deposit(arg0: &mut USDCVault, arg1: 0x2::coin::Coin<0xdba34672e30cb065b1f93e3ab55318768fd6fef66c15942c9f7cb846e2f900e7::usdc::USDC>, arg2: &0x2::tx_context::TxContext) {
        let v0 = 0x2::coin::value<0xdba34672e30cb065b1f93e3ab55318768fd6fef66c15942c9f7cb846e2f900e7::usdc::USDC>(&arg1);
        assert!(v0 > 0, 3);
        0x2::balance::join<0xdba34672e30cb065b1f93e3ab55318768fd6fef66c15942c9f7cb846e2f900e7::usdc::USDC>(&mut arg0.balance, 0x2::coin::into_balance<0xdba34672e30cb065b1f93e3ab55318768fd6fef66c15942c9f7cb846e2f900e7::usdc::USDC>(arg1));
        let v1 = USDCDeposited{
            vault_id  : 0x2::object::id<USDCVault>(arg0),
            amount    : v0,
            depositor : 0x2::tx_context::sender(arg2),
            timestamp : 0x2::tx_context::epoch_timestamp_ms(arg2),
        };
        0x2::event::emit<USDCDeposited>(v1);
    }

    public fun deposit_with_admin(arg0: &mut USDCVault, arg1: &AdminCap, arg2: 0x2::coin::Coin<0xdba34672e30cb065b1f93e3ab55318768fd6fef66c15942c9f7cb846e2f900e7::usdc::USDC>, arg3: &mut 0x2::tx_context::TxContext) {
        verify_vault_state(arg0);
        assert!(arg1.vault_id == 0x2::object::id<USDCVault>(arg0), 1);
        assert!(!is_admin_cap_revoked(arg0, 0x2::object::id<AdminCap>(arg1)), 4);
        deposit(arg0, arg2, arg3);
    }

    public entry fun deposit_with_super(arg0: &mut USDCVault, arg1: &SuperAdminCap, arg2: 0x2::coin::Coin<0xdba34672e30cb065b1f93e3ab55318768fd6fef66c15942c9f7cb846e2f900e7::usdc::USDC>, arg3: &mut 0x2::tx_context::TxContext) {
        verify_super_admin_cap(arg0, arg1);
        deposit(arg0, arg2, arg3);
    }

    public fun get_balance(arg0: &USDCVault) : u64 {
        0x2::balance::value<0xdba34672e30cb065b1f93e3ab55318768fd6fef66c15942c9f7cb846e2f900e7::usdc::USDC>(&arg0.balance)
    }

    public fun get_vault_info(arg0: &USDCVault) : (u64, 0x2::object::ID) {
        (0x2::balance::value<0xdba34672e30cb065b1f93e3ab55318768fd6fef66c15942c9f7cb846e2f900e7::usdc::USDC>(&arg0.balance), 0x2::object::id<USDCVault>(arg0))
    }

    public fun has_sufficient_balance(arg0: &USDCVault, arg1: u64) : bool {
        0x2::balance::value<0xdba34672e30cb065b1f93e3ab55318768fd6fef66c15942c9f7cb846e2f900e7::usdc::USDC>(&arg0.balance) >= arg1
    }

    fun init(arg0: USDC_VAULT, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = create_vault(arg1);
        0x2::transfer::share_object<USDCVault>(v0);
        0x2::transfer::transfer<SuperAdminCap>(v1, 0x2::tx_context::sender(arg1));
    }

    public fun is_admin_cap_id_revoked(arg0: &USDCVault, arg1: 0x2::object::ID) : bool {
        is_admin_cap_revoked(arg0, arg1)
    }

    fun is_admin_cap_revoked(arg0: &USDCVault, arg1: 0x2::object::ID) : bool {
        0x2::table::contains<0x2::object::ID, bool>(&arg0.revoked_caps, arg1)
    }

    public fun is_valid_admin_cap(arg0: &USDCVault, arg1: &AdminCap) : bool {
        arg1.vault_id == 0x2::object::id<USDCVault>(arg0) && !is_admin_cap_revoked(arg0, 0x2::object::id<AdminCap>(arg1))
    }

    public fun is_vault_admin(arg0: &USDCVault, arg1: &AdminCap) : bool {
        is_valid_admin_cap(arg0, arg1)
    }

    public entry fun pause(arg0: &mut USDCVault, arg1: &SuperAdminCap, arg2: &mut 0x2::tx_context::TxContext) {
        verify_super_admin_cap(arg0, arg1);
        arg0.paused = true;
        let v0 = Paused{
            vault_id  : 0x2::object::id<USDCVault>(arg0),
            timestamp : 0x2::tx_context::epoch_timestamp_ms(arg2),
        };
        0x2::event::emit<Paused>(v0);
    }

    public entry fun revoke_admin_permission(arg0: &mut USDCVault, arg1: &SuperAdminCap, arg2: 0x2::object::ID, arg3: &0x2::tx_context::TxContext) {
        verify_super_admin_cap(arg0, arg1);
        0x2::table::add<0x2::object::ID, bool>(&mut arg0.revoked_caps, arg2, true);
        let v0 = AdminCapRevoked{
            admin_cap_id : arg2,
            vault_id     : 0x2::object::id<USDCVault>(arg0),
            timestamp    : 0x2::tx_context::epoch_timestamp_ms(arg3),
        };
        0x2::event::emit<AdminCapRevoked>(v0);
    }

    public entry fun unpause(arg0: &mut USDCVault, arg1: &SuperAdminCap, arg2: &mut 0x2::tx_context::TxContext) {
        verify_super_admin_cap(arg0, arg1);
        arg0.paused = false;
        let v0 = Unpaused{
            vault_id  : 0x2::object::id<USDCVault>(arg0),
            timestamp : 0x2::tx_context::epoch_timestamp_ms(arg2),
        };
        0x2::event::emit<Unpaused>(v0);
    }

    fun verify_super_admin_cap(arg0: &USDCVault, arg1: &SuperAdminCap) {
        assert!(arg1.vault_id == 0x2::object::id<USDCVault>(arg0), 5);
    }

    fun verify_vault_state(arg0: &USDCVault) {
        assert!(!arg0.paused, 6);
    }

    fun withdraw(arg0: &mut USDCVault, arg1: u64, arg2: &mut 0x2::tx_context::TxContext) : 0x2::coin::Coin<0xdba34672e30cb065b1f93e3ab55318768fd6fef66c15942c9f7cb846e2f900e7::usdc::USDC> {
        assert!(arg1 > 0, 3);
        assert!(0x2::balance::value<0xdba34672e30cb065b1f93e3ab55318768fd6fef66c15942c9f7cb846e2f900e7::usdc::USDC>(&arg0.balance) >= arg1, 2);
        let v0 = USDCWithdrawn{
            vault_id   : 0x2::object::id<USDCVault>(arg0),
            amount     : arg1,
            withdrawer : 0x2::tx_context::sender(arg2),
            timestamp  : 0x2::tx_context::epoch_timestamp_ms(arg2),
        };
        0x2::event::emit<USDCWithdrawn>(v0);
        0x2::coin::from_balance<0xdba34672e30cb065b1f93e3ab55318768fd6fef66c15942c9f7cb846e2f900e7::usdc::USDC>(0x2::balance::split<0xdba34672e30cb065b1f93e3ab55318768fd6fef66c15942c9f7cb846e2f900e7::usdc::USDC>(&mut arg0.balance, arg1), arg2)
    }

    public fun withdraw_with_admin(arg0: &mut USDCVault, arg1: &AdminCap, arg2: u64, arg3: &mut 0x2::tx_context::TxContext) : 0x2::coin::Coin<0xdba34672e30cb065b1f93e3ab55318768fd6fef66c15942c9f7cb846e2f900e7::usdc::USDC> {
        verify_vault_state(arg0);
        assert!(arg1.vault_id == 0x2::object::id<USDCVault>(arg0), 1);
        assert!(!is_admin_cap_revoked(arg0, 0x2::object::id<AdminCap>(arg1)), 4);
        withdraw(arg0, arg2, arg3)
    }

    public entry fun withdraw_with_super(arg0: &mut USDCVault, arg1: &SuperAdminCap, arg2: u64, arg3: address, arg4: &mut 0x2::tx_context::TxContext) {
        verify_super_admin_cap(arg0, arg1);
        0x2::transfer::public_transfer<0x2::coin::Coin<0xdba34672e30cb065b1f93e3ab55318768fd6fef66c15942c9f7cb846e2f900e7::usdc::USDC>>(withdraw(arg0, arg2, arg4), arg3);
    }

    // decompiled from Move bytecode v6
}

