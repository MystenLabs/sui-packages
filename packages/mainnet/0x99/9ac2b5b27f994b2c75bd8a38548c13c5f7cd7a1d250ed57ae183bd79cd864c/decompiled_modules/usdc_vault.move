module 0x999ac2b5b27f994b2c75bd8a38548c13c5f7cd7a1d250ed57ae183bd79cd864c::usdc_vault {
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
        admin_address: address,
    }

    struct USDCVault has key {
        id: 0x2::object::UID,
        balance: 0x2::balance::Balance<0xdba34672e30cb065b1f93e3ab55318768fd6fef66c15942c9f7cb846e2f900e7::usdc::USDC>,
        super_admin: address,
        revoked_caps: 0x2::table::Table<0x2::object::ID, bool>,
        created_at: u64,
    }

    struct USDCDepositEvent has copy, drop {
        vault_id: 0x2::object::ID,
        amount: u64,
        depositor: address,
        timestamp: u64,
    }

    struct USDCWithdrawEvent has copy, drop {
        vault_id: 0x2::object::ID,
        amount: u64,
        withdrawer: address,
        timestamp: u64,
    }

    struct AdminCapCreated has copy, drop {
        admin_cap_id: 0x2::object::ID,
        admin: address,
        vault_id: 0x2::object::ID,
        timestamp: u64,
    }

    struct AdminCapRevoked has copy, drop {
        admin_cap_id: 0x2::object::ID,
        admin: address,
        vault_id: 0x2::object::ID,
        timestamp: u64,
    }

    struct USDCVaultCreated has copy, drop {
        vault_id: 0x2::object::ID,
        timestamp: u64,
    }

    public entry fun create_admin_cap(arg0: &USDCVault, arg1: &SuperAdminCap, arg2: address, arg3: &mut 0x2::tx_context::TxContext) {
        verify_super_admin_cap(arg0, arg1);
        let v0 = AdminCap{
            id            : 0x2::object::new(arg3),
            vault_id      : 0x2::object::id<USDCVault>(arg0),
            admin_address : arg2,
        };
        let v1 = AdminCapCreated{
            admin_cap_id : 0x2::object::id<AdminCap>(&v0),
            admin        : arg2,
            vault_id     : 0x2::object::id<USDCVault>(arg0),
            timestamp    : 0x2::tx_context::epoch_timestamp_ms(arg3),
        };
        0x2::event::emit<AdminCapCreated>(v1);
        0x2::transfer::transfer<AdminCap>(v0, arg2);
    }

    fun create_vault(arg0: &mut 0x2::tx_context::TxContext) : (USDCVault, SuperAdminCap) {
        let v0 = USDCVault{
            id           : 0x2::object::new(arg0),
            balance      : 0x2::balance::zero<0xdba34672e30cb065b1f93e3ab55318768fd6fef66c15942c9f7cb846e2f900e7::usdc::USDC>(),
            super_admin  : 0x2::tx_context::sender(arg0),
            revoked_caps : 0x2::table::new<0x2::object::ID, bool>(arg0),
            created_at   : 0x2::tx_context::epoch_timestamp_ms(arg0),
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

    public entry fun deposit(arg0: &mut USDCVault, arg1: &AdminCap, arg2: 0x2::coin::Coin<0xdba34672e30cb065b1f93e3ab55318768fd6fef66c15942c9f7cb846e2f900e7::usdc::USDC>, arg3: &mut 0x2::tx_context::TxContext) {
        assert!(arg1.vault_id == 0x2::object::id<USDCVault>(arg0), 1);
        let v0 = 0x2::tx_context::sender(arg3);
        assert!(arg1.admin_address == v0, 1);
        assert!(!is_admin_cap_revoked(arg0, 0x2::object::id<AdminCap>(arg1)), 4);
        let v1 = 0x2::coin::value<0xdba34672e30cb065b1f93e3ab55318768fd6fef66c15942c9f7cb846e2f900e7::usdc::USDC>(&arg2);
        assert!(v1 > 0, 3);
        0x2::balance::join<0xdba34672e30cb065b1f93e3ab55318768fd6fef66c15942c9f7cb846e2f900e7::usdc::USDC>(&mut arg0.balance, 0x2::coin::into_balance<0xdba34672e30cb065b1f93e3ab55318768fd6fef66c15942c9f7cb846e2f900e7::usdc::USDC>(arg2));
        let v2 = USDCDepositEvent{
            vault_id  : 0x2::object::id<USDCVault>(arg0),
            amount    : v1,
            depositor : v0,
            timestamp : 0x2::tx_context::epoch_timestamp_ms(arg3),
        };
        0x2::event::emit<USDCDepositEvent>(v2);
    }

    public fun get_balance(arg0: &USDCVault) : u64 {
        0x2::balance::value<0xdba34672e30cb065b1f93e3ab55318768fd6fef66c15942c9f7cb846e2f900e7::usdc::USDC>(&arg0.balance)
    }

    public fun get_super_admin(arg0: &USDCVault) : address {
        arg0.super_admin
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

    public entry fun revoke_admin_permission(arg0: &mut USDCVault, arg1: &SuperAdminCap, arg2: 0x2::object::ID, arg3: &0x2::tx_context::TxContext) {
        verify_super_admin_cap(arg0, arg1);
        0x2::table::add<0x2::object::ID, bool>(&mut arg0.revoked_caps, arg2, true);
        let v0 = AdminCapRevoked{
            admin_cap_id : arg2,
            admin        : @0x0,
            vault_id     : 0x2::object::id<USDCVault>(arg0),
            timestamp    : 0x2::tx_context::epoch_timestamp_ms(arg3),
        };
        0x2::event::emit<AdminCapRevoked>(v0);
    }

    fun verify_super_admin_cap(arg0: &USDCVault, arg1: &SuperAdminCap) {
        assert!(arg1.vault_id == 0x2::object::id<USDCVault>(arg0), 5);
    }

    public fun withdraw(arg0: &mut USDCVault, arg1: &AdminCap, arg2: u64, arg3: &mut 0x2::tx_context::TxContext) : 0x2::coin::Coin<0xdba34672e30cb065b1f93e3ab55318768fd6fef66c15942c9f7cb846e2f900e7::usdc::USDC> {
        assert!(arg1.vault_id == 0x2::object::id<USDCVault>(arg0), 1);
        let v0 = 0x2::tx_context::sender(arg3);
        assert!(arg1.admin_address == v0, 1);
        assert!(!is_admin_cap_revoked(arg0, 0x2::object::id<AdminCap>(arg1)), 4);
        assert!(arg2 > 0, 3);
        assert!(0x2::balance::value<0xdba34672e30cb065b1f93e3ab55318768fd6fef66c15942c9f7cb846e2f900e7::usdc::USDC>(&arg0.balance) >= arg2, 2);
        let v1 = USDCWithdrawEvent{
            vault_id   : 0x2::object::id<USDCVault>(arg0),
            amount     : arg2,
            withdrawer : v0,
            timestamp  : 0x2::tx_context::epoch_timestamp_ms(arg3),
        };
        0x2::event::emit<USDCWithdrawEvent>(v1);
        0x2::coin::from_balance<0xdba34672e30cb065b1f93e3ab55318768fd6fef66c15942c9f7cb846e2f900e7::usdc::USDC>(0x2::balance::split<0xdba34672e30cb065b1f93e3ab55318768fd6fef66c15942c9f7cb846e2f900e7::usdc::USDC>(&mut arg0.balance, arg2), arg3)
    }

    // decompiled from Move bytecode v6
}

