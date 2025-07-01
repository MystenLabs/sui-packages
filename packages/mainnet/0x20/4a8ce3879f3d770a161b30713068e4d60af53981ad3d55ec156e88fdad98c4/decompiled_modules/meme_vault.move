module 0x204a8ce3879f3d770a161b30713068e4d60af53981ad3d55ec156e88fdad98c4::meme_vault {
    struct MEME_VAULT has drop {
        dummy_field: bool,
    }

    struct SuperAdminCap has store, key {
        id: 0x2::object::UID,
        vault_manager_id: 0x2::object::ID,
    }

    struct AdminCap has store, key {
        id: 0x2::object::UID,
        vault_manager_id: 0x2::object::ID,
        admin_address: address,
    }

    struct VaultManagerData has store {
        super_admin: address,
        revoked_caps: 0x2::table::Table<0x2::object::ID, bool>,
        meme_balances: 0x2::bag::Bag,
    }

    struct VaultManager has key {
        id: 0x2::object::UID,
        data: VaultManagerData,
    }

    struct VaultKey<phantom T0> has copy, drop, store {
        dummy_field: bool,
    }

    struct MemeDepositEvent has copy, drop {
        vault_manager_id: 0x2::object::ID,
        amount: u64,
        depositor: address,
        timestamp: u64,
    }

    struct MemeWithdrawEvent has copy, drop {
        vault_manager_id: 0x2::object::ID,
        amount: u64,
        withdrawer: address,
        timestamp: u64,
    }

    struct AdminCapCreated has copy, drop {
        admin_cap_id: 0x2::object::ID,
        admin: address,
        vault_manager_id: 0x2::object::ID,
        timestamp: u64,
    }

    struct AdminCapRevoked has copy, drop {
        admin_cap_id: 0x2::object::ID,
        admin: address,
        vault_manager_id: 0x2::object::ID,
        timestamp: u64,
    }

    public entry fun create_admin_cap(arg0: &VaultManager, arg1: &SuperAdminCap, arg2: address, arg3: &mut 0x2::tx_context::TxContext) {
        verify_super_admin_cap(arg0, arg1);
        let v0 = AdminCap{
            id               : 0x2::object::new(arg3),
            vault_manager_id : 0x2::object::id<VaultManager>(arg0),
            admin_address    : arg2,
        };
        let v1 = AdminCapCreated{
            admin_cap_id     : 0x2::object::id<AdminCap>(&v0),
            admin            : arg2,
            vault_manager_id : 0x2::object::id<VaultManager>(arg0),
            timestamp        : 0x2::tx_context::epoch_timestamp_ms(arg3),
        };
        0x2::event::emit<AdminCapCreated>(v1);
        0x2::transfer::transfer<AdminCap>(v0, arg2);
    }

    fun create_unique_vault_manager(arg0: MEME_VAULT, arg1: &mut 0x2::tx_context::TxContext) : VaultManager {
        let v0 = VaultManagerData{
            super_admin   : 0x2::tx_context::sender(arg1),
            revoked_caps  : 0x2::table::new<0x2::object::ID, bool>(arg1),
            meme_balances : 0x2::bag::new(arg1),
        };
        VaultManager{
            id   : 0x2::object::new(arg1),
            data : v0,
        }
    }

    public entry fun deposit<T0>(arg0: &mut VaultManager, arg1: &AdminCap, arg2: 0x2::coin::Coin<T0>, arg3: &mut 0x2::tx_context::TxContext) {
        let v0 = 0x2::object::id<VaultManager>(arg0);
        assert!(arg1.vault_manager_id == v0, 1);
        let v1 = 0x2::tx_context::sender(arg3);
        assert!(arg1.admin_address == v1, 1);
        assert!(!is_admin_cap_revoked(arg0, 0x2::object::id<AdminCap>(arg1)), 4);
        let v2 = 0x2::coin::value<T0>(&arg2);
        assert!(v2 > 0, 3);
        let v3 = VaultKey<T0>{dummy_field: false};
        if (vault_exists<T0>(arg0)) {
            0x2::balance::join<T0>(0x2::bag::borrow_mut<VaultKey<T0>, 0x2::balance::Balance<T0>>(&mut arg0.data.meme_balances, v3), 0x2::coin::into_balance<T0>(arg2));
        } else {
            0x2::bag::add<VaultKey<T0>, 0x2::balance::Balance<T0>>(&mut arg0.data.meme_balances, v3, 0x2::coin::into_balance<T0>(arg2));
        };
        let v4 = MemeDepositEvent{
            vault_manager_id : v0,
            amount           : v2,
            depositor        : v1,
            timestamp        : 0x2::tx_context::epoch_timestamp_ms(arg3),
        };
        0x2::event::emit<MemeDepositEvent>(v4);
    }

    public fun get_balance<T0>(arg0: &VaultManager) : u64 {
        if (!vault_exists<T0>(arg0)) {
            return 0
        };
        let v0 = VaultKey<T0>{dummy_field: false};
        0x2::balance::value<T0>(0x2::bag::borrow<VaultKey<T0>, 0x2::balance::Balance<T0>>(&arg0.data.meme_balances, v0))
    }

    public fun get_super_admin(arg0: &VaultManager) : address {
        arg0.data.super_admin
    }

    public fun get_vault_info<T0>(arg0: &VaultManager) : u64 {
        get_balance<T0>(arg0)
    }

    public fun has_sufficient_balance<T0>(arg0: &VaultManager, arg1: u64) : bool {
        get_balance<T0>(arg0) >= arg1
    }

    fun init(arg0: MEME_VAULT, arg1: &mut 0x2::tx_context::TxContext) {
        let v0 = create_unique_vault_manager(arg0, arg1);
        let v1 = SuperAdminCap{
            id               : 0x2::object::new(arg1),
            vault_manager_id : 0x2::object::id<VaultManager>(&v0),
        };
        0x2::transfer::transfer<SuperAdminCap>(v1, 0x2::tx_context::sender(arg1));
        0x2::transfer::share_object<VaultManager>(v0);
    }

    public fun is_admin_cap_id_revoked(arg0: &VaultManager, arg1: 0x2::object::ID) : bool {
        is_admin_cap_revoked(arg0, arg1)
    }

    fun is_admin_cap_revoked(arg0: &VaultManager, arg1: 0x2::object::ID) : bool {
        0x2::table::contains<0x2::object::ID, bool>(&arg0.data.revoked_caps, arg1)
    }

    public fun is_valid_admin_cap(arg0: &VaultManager, arg1: &AdminCap) : bool {
        arg1.vault_manager_id == 0x2::object::id<VaultManager>(arg0) && !is_admin_cap_revoked(arg0, 0x2::object::id<AdminCap>(arg1))
    }

    public entry fun revoke_admin_permission(arg0: &mut VaultManager, arg1: &SuperAdminCap, arg2: 0x2::object::ID, arg3: &0x2::tx_context::TxContext) {
        verify_super_admin_cap(arg0, arg1);
        0x2::table::add<0x2::object::ID, bool>(&mut arg0.data.revoked_caps, arg2, true);
        let v0 = AdminCapRevoked{
            admin_cap_id     : arg2,
            admin            : @0x0,
            vault_manager_id : 0x2::object::id<VaultManager>(arg0),
            timestamp        : 0x2::tx_context::epoch_timestamp_ms(arg3),
        };
        0x2::event::emit<AdminCapRevoked>(v0);
    }

    public fun vault_exists<T0>(arg0: &VaultManager) : bool {
        let v0 = VaultKey<T0>{dummy_field: false};
        0x2::bag::contains<VaultKey<T0>>(&arg0.data.meme_balances, v0)
    }

    fun verify_super_admin_cap(arg0: &VaultManager, arg1: &SuperAdminCap) {
        assert!(arg1.vault_manager_id == 0x2::object::id<VaultManager>(arg0), 5);
    }

    public fun withdraw<T0>(arg0: &mut VaultManager, arg1: &AdminCap, arg2: u64, arg3: &mut 0x2::tx_context::TxContext) : 0x2::coin::Coin<T0> {
        let v0 = 0x2::object::id<VaultManager>(arg0);
        assert!(arg1.vault_manager_id == v0, 1);
        let v1 = 0x2::tx_context::sender(arg3);
        assert!(arg1.admin_address == v1, 1);
        assert!(!is_admin_cap_revoked(arg0, 0x2::object::id<AdminCap>(arg1)), 4);
        assert!(arg2 > 0, 3);
        assert!(vault_exists<T0>(arg0), 2);
        let v2 = VaultKey<T0>{dummy_field: false};
        let v3 = 0x2::bag::borrow_mut<VaultKey<T0>, 0x2::balance::Balance<T0>>(&mut arg0.data.meme_balances, v2);
        assert!(0x2::balance::value<T0>(v3) >= arg2, 2);
        let v4 = MemeWithdrawEvent{
            vault_manager_id : v0,
            amount           : arg2,
            withdrawer       : v1,
            timestamp        : 0x2::tx_context::epoch_timestamp_ms(arg3),
        };
        0x2::event::emit<MemeWithdrawEvent>(v4);
        0x2::coin::from_balance<T0>(0x2::balance::split<T0>(v3, arg2), arg3)
    }

    // decompiled from Move bytecode v6
}

