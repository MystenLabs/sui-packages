module 0x51be591bbdcfae8675a38b2c6ac775e87017b09e757817ee2f1024a75ebf4c61::meme_vault {
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
    }

    struct VaultManagerData has store {
        revoked_caps: 0x2::table::Table<0x2::object::ID, bool>,
        meme_balances: 0x2::bag::Bag,
    }

    struct VaultManager has key {
        id: 0x2::object::UID,
        data: VaultManagerData,
        paused: bool,
    }

    struct VaultKey<phantom T0> has copy, drop, store {
        dummy_field: bool,
    }

    struct Paused has copy, drop {
        vault_id: 0x2::object::ID,
        timestamp: u64,
    }

    struct Unpaused has copy, drop {
        vault_id: 0x2::object::ID,
        timestamp: u64,
    }

    struct MemeDeposited has copy, drop {
        vault_manager_id: 0x2::object::ID,
        amount: u64,
        depositor: address,
        timestamp: u64,
    }

    struct MemeWithdrawn has copy, drop {
        vault_manager_id: 0x2::object::ID,
        amount: u64,
        withdrawer: address,
        timestamp: u64,
    }

    struct AdminCapCreated has copy, drop {
        admin_cap_id: 0x2::object::ID,
        vault_manager_id: 0x2::object::ID,
        timestamp: u64,
    }

    struct AdminCapRevoked has copy, drop {
        admin_cap_id: 0x2::object::ID,
        vault_manager_id: 0x2::object::ID,
        timestamp: u64,
    }

    public fun create_admin_cap(arg0: &VaultManager, arg1: &SuperAdminCap, arg2: &mut 0x2::tx_context::TxContext) : AdminCap {
        verify_super_admin_cap(arg0, arg1);
        let v0 = AdminCap{
            id               : 0x2::object::new(arg2),
            vault_manager_id : 0x2::object::id<VaultManager>(arg0),
        };
        let v1 = AdminCapCreated{
            admin_cap_id     : 0x2::object::id<AdminCap>(&v0),
            vault_manager_id : 0x2::object::id<VaultManager>(arg0),
            timestamp        : 0x2::tx_context::epoch_timestamp_ms(arg2),
        };
        0x2::event::emit<AdminCapCreated>(v1);
        v0
    }

    public entry fun create_admin_cap_to(arg0: &VaultManager, arg1: &SuperAdminCap, arg2: address, arg3: &mut 0x2::tx_context::TxContext) {
        0x2::transfer::transfer<AdminCap>(create_admin_cap(arg0, arg1, arg3), arg2);
    }

    fun create_unique_vault_manager(arg0: MEME_VAULT, arg1: &mut 0x2::tx_context::TxContext) : VaultManager {
        let v0 = VaultManagerData{
            revoked_caps  : 0x2::table::new<0x2::object::ID, bool>(arg1),
            meme_balances : 0x2::bag::new(arg1),
        };
        VaultManager{
            id     : 0x2::object::new(arg1),
            data   : v0,
            paused : false,
        }
    }

    fun deposit<T0>(arg0: &mut VaultManager, arg1: 0x2::coin::Coin<T0>, arg2: &0x2::tx_context::TxContext) {
        let v0 = 0x2::coin::value<T0>(&arg1);
        assert!(v0 > 0, 3);
        let v1 = VaultKey<T0>{dummy_field: false};
        if (vault_exists<T0>(arg0)) {
            0x2::balance::join<T0>(0x2::bag::borrow_mut<VaultKey<T0>, 0x2::balance::Balance<T0>>(&mut arg0.data.meme_balances, v1), 0x2::coin::into_balance<T0>(arg1));
        } else {
            0x2::bag::add<VaultKey<T0>, 0x2::balance::Balance<T0>>(&mut arg0.data.meme_balances, v1, 0x2::coin::into_balance<T0>(arg1));
        };
        let v2 = MemeDeposited{
            vault_manager_id : 0x2::object::id<VaultManager>(arg0),
            amount           : v0,
            depositor        : 0x2::tx_context::sender(arg2),
            timestamp        : 0x2::tx_context::epoch_timestamp_ms(arg2),
        };
        0x2::event::emit<MemeDeposited>(v2);
    }

    public fun deposit_with_admin<T0>(arg0: &mut VaultManager, arg1: &AdminCap, arg2: 0x2::coin::Coin<T0>, arg3: &mut 0x2::tx_context::TxContext) {
        verify_vault_state(arg0);
        assert!(arg1.vault_manager_id == 0x2::object::id<VaultManager>(arg0), 1);
        assert!(!is_admin_cap_revoked(arg0, 0x2::object::id<AdminCap>(arg1)), 4);
        deposit<T0>(arg0, arg2, arg3);
    }

    public entry fun deposit_with_super<T0>(arg0: &mut VaultManager, arg1: &SuperAdminCap, arg2: 0x2::coin::Coin<T0>, arg3: &mut 0x2::tx_context::TxContext) {
        verify_super_admin_cap(arg0, arg1);
        deposit<T0>(arg0, arg2, arg3);
    }

    public fun get_balance<T0>(arg0: &VaultManager) : u64 {
        if (!vault_exists<T0>(arg0)) {
            return 0
        };
        let v0 = VaultKey<T0>{dummy_field: false};
        0x2::balance::value<T0>(0x2::bag::borrow<VaultKey<T0>, 0x2::balance::Balance<T0>>(&arg0.data.meme_balances, v0))
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

    public entry fun pause(arg0: &mut VaultManager, arg1: &SuperAdminCap, arg2: &mut 0x2::tx_context::TxContext) {
        verify_super_admin_cap(arg0, arg1);
        arg0.paused = true;
        let v0 = Paused{
            vault_id  : 0x2::object::id<VaultManager>(arg0),
            timestamp : 0x2::tx_context::epoch_timestamp_ms(arg2),
        };
        0x2::event::emit<Paused>(v0);
    }

    public entry fun revoke_admin_permission(arg0: &mut VaultManager, arg1: &SuperAdminCap, arg2: 0x2::object::ID, arg3: &0x2::tx_context::TxContext) {
        verify_super_admin_cap(arg0, arg1);
        0x2::table::add<0x2::object::ID, bool>(&mut arg0.data.revoked_caps, arg2, true);
        let v0 = AdminCapRevoked{
            admin_cap_id     : arg2,
            vault_manager_id : 0x2::object::id<VaultManager>(arg0),
            timestamp        : 0x2::tx_context::epoch_timestamp_ms(arg3),
        };
        0x2::event::emit<AdminCapRevoked>(v0);
    }

    public entry fun unpause(arg0: &mut VaultManager, arg1: &SuperAdminCap, arg2: &mut 0x2::tx_context::TxContext) {
        verify_super_admin_cap(arg0, arg1);
        arg0.paused = false;
        let v0 = Unpaused{
            vault_id  : 0x2::object::id<VaultManager>(arg0),
            timestamp : 0x2::tx_context::epoch_timestamp_ms(arg2),
        };
        0x2::event::emit<Unpaused>(v0);
    }

    public fun vault_exists<T0>(arg0: &VaultManager) : bool {
        let v0 = VaultKey<T0>{dummy_field: false};
        0x2::bag::contains<VaultKey<T0>>(&arg0.data.meme_balances, v0)
    }

    fun verify_super_admin_cap(arg0: &VaultManager, arg1: &SuperAdminCap) {
        assert!(arg1.vault_manager_id == 0x2::object::id<VaultManager>(arg0), 5);
    }

    fun verify_vault_state(arg0: &VaultManager) {
        assert!(!arg0.paused, 6);
    }

    fun withdraw<T0>(arg0: &mut VaultManager, arg1: u64, arg2: &mut 0x2::tx_context::TxContext) : 0x2::coin::Coin<T0> {
        assert!(arg1 > 0, 3);
        assert!(vault_exists<T0>(arg0), 2);
        let v0 = VaultKey<T0>{dummy_field: false};
        let v1 = 0x2::bag::borrow_mut<VaultKey<T0>, 0x2::balance::Balance<T0>>(&mut arg0.data.meme_balances, v0);
        assert!(0x2::balance::value<T0>(v1) >= arg1, 2);
        let v2 = 0x2::coin::from_balance<T0>(0x2::balance::split<T0>(v1, arg1), arg2);
        let v3 = MemeWithdrawn{
            vault_manager_id : 0x2::object::id<VaultManager>(arg0),
            amount           : arg1,
            withdrawer       : 0x2::tx_context::sender(arg2),
            timestamp        : 0x2::tx_context::epoch_timestamp_ms(arg2),
        };
        0x2::event::emit<MemeWithdrawn>(v3);
        v2
    }

    public fun withdraw_with_admin<T0>(arg0: &mut VaultManager, arg1: &AdminCap, arg2: u64, arg3: &mut 0x2::tx_context::TxContext) : 0x2::coin::Coin<T0> {
        verify_vault_state(arg0);
        assert!(arg1.vault_manager_id == 0x2::object::id<VaultManager>(arg0), 1);
        assert!(!is_admin_cap_revoked(arg0, 0x2::object::id<AdminCap>(arg1)), 4);
        withdraw<T0>(arg0, arg2, arg3)
    }

    public entry fun withdraw_with_super<T0>(arg0: &mut VaultManager, arg1: &SuperAdminCap, arg2: u64, arg3: address, arg4: &mut 0x2::tx_context::TxContext) {
        verify_super_admin_cap(arg0, arg1);
        0x2::transfer::public_transfer<0x2::coin::Coin<T0>>(withdraw<T0>(arg0, arg2, arg4), arg3);
    }

    // decompiled from Move bytecode v6
}

