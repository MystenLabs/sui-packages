module 0x21fe7f81e7e4b9d9cbd32cd94dca7a68d04b8d3371c3923241635a8b3de2e61a::vault {
    struct Vault has key {
        id: 0x2::object::UID,
        cap: 0x1::option::Option<0x2::package::UpgradeCap>,
        depositor: address,
        bound_by: 0x1::option::Option<0x1::type_name::TypeName>,
    }

    public fun deposit(arg0: 0x2::package::UpgradeCap, arg1: &mut 0x2::tx_context::TxContext) {
        let v0 = Vault{
            id        : 0x2::object::new(arg1),
            cap       : 0x1::option::some<0x2::package::UpgradeCap>(arg0),
            depositor : 0x2::tx_context::sender(arg1),
            bound_by  : 0x1::option::none<0x1::type_name::TypeName>(),
        };
        0x2::transfer::share_object<Vault>(v0);
    }

    public fun depositor(arg0: &Vault) : address {
        arg0.depositor
    }

    public fun is_claimed(arg0: &Vault) : bool {
        0x1::option::is_none<0x2::package::UpgradeCap>(&arg0.cap)
    }

    public fun release<T0: drop>(arg0: &mut Vault, arg1: T0, arg2: 0x2::object::ID, arg3: &0x2::tx_context::TxContext) : 0x2::package::UpgradeCap {
        assert!(0x2::tx_context::sender(arg3) == arg0.depositor, 1900);
        assert!(0x1::option::is_some<0x2::package::UpgradeCap>(&arg0.cap), 1901);
        let v0 = 0x1::option::extract<0x2::package::UpgradeCap>(&mut arg0.cap);
        assert!(0x2::package::upgrade_package(&v0) == arg2, 1902);
        0x1::option::fill<0x1::type_name::TypeName>(&mut arg0.bound_by, 0x1::type_name::with_defining_ids<T0>());
        v0
    }

    // decompiled from Move bytecode v7
}

