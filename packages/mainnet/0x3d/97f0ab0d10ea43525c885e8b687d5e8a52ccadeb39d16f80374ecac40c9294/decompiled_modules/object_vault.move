module 0x3d97f0ab0d10ea43525c885e8b687d5e8a52ccadeb39d16f80374ecac40c9294::object_vault {
    struct ObjectVault has key {
        id: 0x2::object::UID,
        vault: 0x2::object_bag::ObjectBag,
    }

    struct ObjectVaultCap has store, key {
        id: 0x2::object::UID,
    }

    public fun add_whitelist_address(arg0: &mut ObjectVault, arg1: &ObjectVaultCap, arg2: address) {
        0x3d97f0ab0d10ea43525c885e8b687d5e8a52ccadeb39d16f80374ecac40c9294::whitelist::add_whitelist_address(&mut arg0.id, arg2);
    }

    public fun allow_all(arg0: &mut ObjectVault, arg1: &ObjectVaultCap) {
        0x3d97f0ab0d10ea43525c885e8b687d5e8a52ccadeb39d16f80374ecac40c9294::whitelist::allow_all(&mut arg0.id);
    }

    fun init(arg0: &mut 0x2::tx_context::TxContext) {
        let v0 = ObjectVault{
            id    : 0x2::object::new(arg0),
            vault : 0x2::object_bag::new(arg0),
        };
        let v1 = ObjectVaultCap{id: 0x2::object::new(arg0)};
        0x2::transfer::share_object<ObjectVault>(v0);
        0x2::transfer::transfer<ObjectVaultCap>(v1, 0x2::tx_context::sender(arg0));
    }

    public fun put<T0: store + key>(arg0: &mut ObjectVault, arg1: T0) {
        0x2::object_bag::add<0x1::type_name::TypeName, T0>(&mut arg0.vault, 0x1::type_name::get<T0>(), arg1);
    }

    public fun reject_all(arg0: &mut ObjectVault, arg1: &ObjectVaultCap) {
        0x3d97f0ab0d10ea43525c885e8b687d5e8a52ccadeb39d16f80374ecac40c9294::whitelist::reject_all(&mut arg0.id);
    }

    public fun remove_whitelist_address(arg0: &mut ObjectVault, arg1: &ObjectVaultCap, arg2: address) {
        0x3d97f0ab0d10ea43525c885e8b687d5e8a52ccadeb39d16f80374ecac40c9294::whitelist::remove_whitelist_address(&mut arg0.id, arg2);
    }

    public fun switch_to_whitelist_mode(arg0: &mut ObjectVault, arg1: &ObjectVaultCap) {
        0x3d97f0ab0d10ea43525c885e8b687d5e8a52ccadeb39d16f80374ecac40c9294::whitelist::switch_to_whitelist_mode(&mut arg0.id);
    }

    public fun take<T0: store + key>(arg0: &mut ObjectVault, arg1: &mut 0x2::tx_context::TxContext) : T0 {
        assert!(0x3d97f0ab0d10ea43525c885e8b687d5e8a52ccadeb39d16f80374ecac40c9294::whitelist::is_address_allowed(&arg0.id, 0x2::tx_context::sender(arg1)), 272);
        0x2::object_bag::remove<0x1::type_name::TypeName, T0>(&mut arg0.vault, 0x1::type_name::get<T0>())
    }

    // decompiled from Move bytecode v6
}

