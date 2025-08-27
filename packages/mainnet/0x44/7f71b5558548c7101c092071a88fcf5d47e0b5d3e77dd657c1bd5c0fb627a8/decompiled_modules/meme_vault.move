module 0x447f71b5558548c7101c092071a88fcf5d47e0b5d3e77dd657c1bd5c0fb627a8::meme_vault {
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

    struct VaultManager has key {
        id: 0x2::object::UID,
        revoked_caps: 0x2::table::Table<0x2::object::ID, bool>,
        paused: bool,
        receiver: 0x1::option::Option<address>,
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

    struct ReceiverSet has copy, drop {
        vault_id: 0x2::object::ID,
        old_receiver: address,
        new_receiver: address,
        timestamp: u64,
    }

    struct MemeDeposited has copy, drop {
        vault_manager_id: 0x2::object::ID,
        amount: u64,
        depositor: address,
        timestamp: u64,
    }

    struct MemeDirectDeposited has copy, drop {
        id: 0x1::string::String,
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
        VaultManager{
            id           : 0x2::object::new(arg1),
            revoked_caps : 0x2::table::new<0x2::object::ID, bool>(arg1),
            paused       : false,
            receiver     : 0x1::option::none<address>(),
        }
    }

    fun deposit<T0>(arg0: &mut VaultManager, arg1: 0x2::coin::Coin<T0>, arg2: &0x2::tx_context::TxContext) {
        let v0 = 0x2::coin::value<T0>(&arg1);
        assert!(v0 > 0, 3);
        let v1 = VaultKey<T0>{dummy_field: false};
        if (vault_exists<T0>(arg0)) {
            0x2::balance::join<T0>(0x2::dynamic_field::borrow_mut<VaultKey<T0>, 0x2::balance::Balance<T0>>(&mut arg0.id, v1), 0x2::coin::into_balance<T0>(arg1));
        } else {
            0x2::dynamic_field::add<VaultKey<T0>, 0x2::balance::Balance<T0>>(&mut arg0.id, v1, 0x2::coin::into_balance<T0>(arg1));
        };
        let v2 = MemeDeposited{
            vault_manager_id : 0x2::object::id<VaultManager>(arg0),
            amount           : v0,
            depositor        : 0x2::tx_context::sender(arg2),
            timestamp        : 0x2::tx_context::epoch_timestamp_ms(arg2),
        };
        0x2::event::emit<MemeDeposited>(v2);
    }

    public entry fun deposit_direct<T0>(arg0: 0x1::string::String, arg1: &mut VaultManager, arg2: 0x2::coin::Coin<T0>, arg3: &mut 0x2::tx_context::TxContext) {
        deposit<T0>(arg1, arg2, arg3);
        let v0 = MemeDirectDeposited{
            id               : arg0,
            vault_manager_id : 0x2::object::id<VaultManager>(arg1),
            amount           : 0x2::coin::value<T0>(&arg2),
            depositor        : 0x2::tx_context::sender(arg3),
            timestamp        : 0x2::tx_context::epoch_timestamp_ms(arg3),
        };
        0x2::event::emit<MemeDirectDeposited>(v0);
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
        0x2::balance::value<T0>(0x2::dynamic_field::borrow<VaultKey<T0>, 0x2::balance::Balance<T0>>(&arg0.id, v0))
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
        0x2::table::contains<0x2::object::ID, bool>(&arg0.revoked_caps, arg1)
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
        0x2::table::add<0x2::object::ID, bool>(&mut arg0.revoked_caps, arg2, true);
        let v0 = AdminCapRevoked{
            admin_cap_id     : arg2,
            vault_manager_id : 0x2::object::id<VaultManager>(arg0),
            timestamp        : 0x2::tx_context::epoch_timestamp_ms(arg3),
        };
        0x2::event::emit<AdminCapRevoked>(v0);
    }

    public entry fun set_receiver(arg0: &mut VaultManager, arg1: &SuperAdminCap, arg2: address, arg3: &mut 0x2::tx_context::TxContext) {
        verify_super_admin_cap(arg0, arg1);
        arg0.receiver = 0x1::option::some<address>(arg2);
        let v0 = ReceiverSet{
            vault_id     : 0x2::object::id<VaultManager>(arg0),
            old_receiver : 0x1::option::get_with_default<address>(&arg0.receiver, 0x2::address::from_u256(0)),
            new_receiver : arg2,
            timestamp    : 0x2::tx_context::epoch_timestamp_ms(arg3),
        };
        0x2::event::emit<ReceiverSet>(v0);
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
        0x2::dynamic_field::exists_<VaultKey<T0>>(&arg0.id, v0)
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
        let v1 = 0x2::dynamic_field::borrow_mut<VaultKey<T0>, 0x2::balance::Balance<T0>>(&mut arg0.id, v0);
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

    public entry fun withdraw_with_super<T0>(arg0: &mut VaultManager, arg1: &SuperAdminCap, arg2: u64, arg3: &mut 0x2::tx_context::TxContext) {
        verify_super_admin_cap(arg0, arg1);
        let v0 = withdraw<T0>(arg0, arg2, arg3);
        assert!(0x1::option::is_some<address>(&arg0.receiver), 7);
        0x2::transfer::public_transfer<0x2::coin::Coin<T0>>(v0, *0x1::option::borrow<address>(&arg0.receiver));
    }

    // decompiled from Move bytecode v6
}

