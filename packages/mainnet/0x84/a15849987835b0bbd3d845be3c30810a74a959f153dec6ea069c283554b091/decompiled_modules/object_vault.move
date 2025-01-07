module 0x84a15849987835b0bbd3d845be3c30810a74a959f153dec6ea069c283554b091::object_vault {
    struct ObjectVault has key {
        id: 0x2::object::UID,
        vault: 0x2::object_bag::ObjectBag,
    }

    struct ObjectVaultCap has store, key {
        id: 0x2::object::UID,
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

    public fun take<T0: store + key>(arg0: &mut ObjectVault, arg1: &ObjectVaultCap) : T0 {
        0x2::object_bag::remove<0x1::type_name::TypeName, T0>(&mut arg0.vault, 0x1::type_name::get<T0>())
    }

    // decompiled from Move bytecode v6
}

