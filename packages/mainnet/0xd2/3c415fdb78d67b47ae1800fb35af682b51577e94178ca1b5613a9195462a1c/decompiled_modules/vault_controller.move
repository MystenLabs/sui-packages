module 0xd23c415fdb78d67b47ae1800fb35af682b51577e94178ca1b5613a9195462a1c::vault_controller {
    struct VaultController has key {
        id: 0x2::object::UID,
    }

    struct CoinTypeWrapper<phantom T0> has copy, drop, store {
        dummy_field: bool,
    }

    public fun balance<T0>(arg0: &0xd23c415fdb78d67b47ae1800fb35af682b51577e94178ca1b5613a9195462a1c::vault_core::VaultRegistry, arg1: &0x2::tx_context::TxContext) : u64 {
        let v0 = 0xd23c415fdb78d67b47ae1800fb35af682b51577e94178ca1b5613a9195462a1c::vault_core::generate_resource_vault_id<T0>(0x2::tx_context::sender(arg1));
        assert!(0xd23c415fdb78d67b47ae1800fb35af682b51577e94178ca1b5613a9195462a1c::vault_core::resource_vault_exists(arg0, v0), 1);
        0xd23c415fdb78d67b47ae1800fb35af682b51577e94178ca1b5613a9195462a1c::vault_core::balance<T0>(arg0, v0)
    }

    public fun create_delegation<T0>(arg0: &mut 0xd23c415fdb78d67b47ae1800fb35af682b51577e94178ca1b5613a9195462a1c::vault_core::VaultRegistry, arg1: address, arg2: u64, arg3: u64, arg4: &0x2::clock::Clock, arg5: &mut 0x2::tx_context::TxContext) {
        let v0 = 0x2::tx_context::sender(arg5);
        assert!(0xd23c415fdb78d67b47ae1800fb35af682b51577e94178ca1b5613a9195462a1c::vault_core::resource_vault_exists(arg0, 0xd23c415fdb78d67b47ae1800fb35af682b51577e94178ca1b5613a9195462a1c::vault_core::generate_resource_vault_id<T0>(v0)), 1);
        0xd23c415fdb78d67b47ae1800fb35af682b51577e94178ca1b5613a9195462a1c::vault_core::create_delegation<T0>(0xd23c415fdb78d67b47ae1800fb35af682b51577e94178ca1b5613a9195462a1c::vault_core::borrow_mut_resource_vault<T0>(arg0, v0), arg1, arg2, arg3, arg4, arg5);
    }

    public fun delegated_amount<T0>(arg0: &0xd23c415fdb78d67b47ae1800fb35af682b51577e94178ca1b5613a9195462a1c::vault_core::VaultRegistry, arg1: address, arg2: &0x2::tx_context::TxContext) : u64 {
        let v0 = 0xd23c415fdb78d67b47ae1800fb35af682b51577e94178ca1b5613a9195462a1c::vault_core::generate_resource_vault_id<T0>(0x2::tx_context::sender(arg2));
        assert!(0xd23c415fdb78d67b47ae1800fb35af682b51577e94178ca1b5613a9195462a1c::vault_core::resource_vault_exists(arg0, v0), 1);
        0xd23c415fdb78d67b47ae1800fb35af682b51577e94178ca1b5613a9195462a1c::vault_core::delegated_amount<T0>(arg0, v0, arg1)
    }

    public fun deposit<T0>(arg0: &mut 0xd23c415fdb78d67b47ae1800fb35af682b51577e94178ca1b5613a9195462a1c::vault_core::VaultRegistry, arg1: 0x2::coin::Coin<T0>, arg2: &mut 0x2::tx_context::TxContext) {
        let v0 = 0x2::tx_context::sender(arg2);
        assert!(0xd23c415fdb78d67b47ae1800fb35af682b51577e94178ca1b5613a9195462a1c::vault_core::resource_vault_exists(arg0, 0xd23c415fdb78d67b47ae1800fb35af682b51577e94178ca1b5613a9195462a1c::vault_core::generate_resource_vault_id<T0>(v0)), 1);
        0xd23c415fdb78d67b47ae1800fb35af682b51577e94178ca1b5613a9195462a1c::vault_core::deposit<T0>(0xd23c415fdb78d67b47ae1800fb35af682b51577e94178ca1b5613a9195462a1c::vault_core::borrow_mut_resource_vault<T0>(arg0, v0), arg1, arg2);
    }

    fun init(arg0: &mut 0x2::tx_context::TxContext) {
        let v0 = VaultController{id: 0x2::object::new(arg0)};
        0x2::transfer::share_object<VaultController>(v0);
    }

    public fun is_frozen<T0>(arg0: &0xd23c415fdb78d67b47ae1800fb35af682b51577e94178ca1b5613a9195462a1c::vault_core::VaultRegistry, arg1: address, arg2: &0x2::tx_context::TxContext) : bool {
        let v0 = 0xd23c415fdb78d67b47ae1800fb35af682b51577e94178ca1b5613a9195462a1c::vault_core::generate_resource_vault_id<T0>(0x2::tx_context::sender(arg2));
        assert!(0xd23c415fdb78d67b47ae1800fb35af682b51577e94178ca1b5613a9195462a1c::vault_core::resource_vault_exists(arg0, v0), 1);
        0xd23c415fdb78d67b47ae1800fb35af682b51577e94178ca1b5613a9195462a1c::vault_core::is_frozen<T0>(arg0, v0, arg1)
    }

    public fun owner<T0>(arg0: &0xd23c415fdb78d67b47ae1800fb35af682b51577e94178ca1b5613a9195462a1c::vault_core::VaultRegistry, arg1: &0x2::tx_context::TxContext) : address {
        let v0 = 0xd23c415fdb78d67b47ae1800fb35af682b51577e94178ca1b5613a9195462a1c::vault_core::generate_resource_vault_id<T0>(0x2::tx_context::sender(arg1));
        assert!(0xd23c415fdb78d67b47ae1800fb35af682b51577e94178ca1b5613a9195462a1c::vault_core::resource_vault_exists(arg0, v0), 1);
        0xd23c415fdb78d67b47ae1800fb35af682b51577e94178ca1b5613a9195462a1c::vault_core::owner<T0>(arg0, v0)
    }

    public fun register_vault<T0>(arg0: &mut 0xd23c415fdb78d67b47ae1800fb35af682b51577e94178ca1b5613a9195462a1c::vault_core::VaultRegistry, arg1: &mut 0x2::tx_context::TxContext) {
        assert!(!0xd23c415fdb78d67b47ae1800fb35af682b51577e94178ca1b5613a9195462a1c::vault_core::resource_vault_exists(arg0, 0xd23c415fdb78d67b47ae1800fb35af682b51577e94178ca1b5613a9195462a1c::vault_core::generate_resource_vault_id<T0>(0x2::tx_context::sender(arg1))), 2);
        0xd23c415fdb78d67b47ae1800fb35af682b51577e94178ca1b5613a9195462a1c::vault_core::create_resource_vault<T0>(arg0, arg1);
    }

    public fun set_frozen<T0>(arg0: &mut 0xd23c415fdb78d67b47ae1800fb35af682b51577e94178ca1b5613a9195462a1c::vault_core::VaultRegistry, arg1: address, arg2: bool, arg3: &mut 0x2::tx_context::TxContext) {
        let v0 = 0xd23c415fdb78d67b47ae1800fb35af682b51577e94178ca1b5613a9195462a1c::vault_core::generate_resource_vault_id<T0>(0x2::tx_context::sender(arg3));
        assert!(0xd23c415fdb78d67b47ae1800fb35af682b51577e94178ca1b5613a9195462a1c::vault_core::resource_vault_exists(arg0, v0), 1);
        0xd23c415fdb78d67b47ae1800fb35af682b51577e94178ca1b5613a9195462a1c::vault_core::set_frozen<T0>(arg0, v0, arg1, arg2, arg3);
    }

    public fun withdraw_by_solver<T0>(arg0: &mut 0xd23c415fdb78d67b47ae1800fb35af682b51577e94178ca1b5613a9195462a1c::vault_core::VaultRegistry, arg1: address, arg2: u64, arg3: &0x2::clock::Clock, arg4: &mut 0x2::tx_context::TxContext) : 0x2::coin::Coin<T0> {
        assert!(0xd23c415fdb78d67b47ae1800fb35af682b51577e94178ca1b5613a9195462a1c::vault_core::resource_vault_exists(arg0, 0xd23c415fdb78d67b47ae1800fb35af682b51577e94178ca1b5613a9195462a1c::vault_core::generate_resource_vault_id<T0>(arg1)), 1);
        0xd23c415fdb78d67b47ae1800fb35af682b51577e94178ca1b5613a9195462a1c::vault_core::withdraw<T0>(0xd23c415fdb78d67b47ae1800fb35af682b51577e94178ca1b5613a9195462a1c::vault_core::borrow_mut_resource_vault<T0>(arg0, arg1), arg2, arg3, 0x2::tx_context::sender(arg4), arg4)
    }

    public fun withdraw_by_user<T0>(arg0: &mut 0xd23c415fdb78d67b47ae1800fb35af682b51577e94178ca1b5613a9195462a1c::vault_core::VaultRegistry, arg1: address, arg2: u64, arg3: &0x2::clock::Clock, arg4: &mut 0x2::tx_context::TxContext) : 0x2::coin::Coin<T0> {
        let v0 = 0x2::tx_context::sender(arg4);
        assert!(0xd23c415fdb78d67b47ae1800fb35af682b51577e94178ca1b5613a9195462a1c::vault_core::resource_vault_exists(arg0, 0xd23c415fdb78d67b47ae1800fb35af682b51577e94178ca1b5613a9195462a1c::vault_core::generate_resource_vault_id<T0>(v0)), 1);
        0xd23c415fdb78d67b47ae1800fb35af682b51577e94178ca1b5613a9195462a1c::vault_core::withdraw<T0>(0xd23c415fdb78d67b47ae1800fb35af682b51577e94178ca1b5613a9195462a1c::vault_core::borrow_mut_resource_vault<T0>(arg0, v0), arg2, arg3, arg1, arg4)
    }

    // decompiled from Move bytecode v6
}

