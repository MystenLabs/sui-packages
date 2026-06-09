module 0xefe9f03841af163ecf3b9b5c30c3919da95e74d37db921e7a681fa44bfd7f116::demo {
    struct Vault<phantom T0> has store, key {
        id: 0x2::object::UID,
        balance: 0x2::balance::Balance<T0>,
        admin: address,
    }

    struct Admin has store, key {
        id: 0x2::object::UID,
        admin: address,
        vaults: 0x2::table::Table<0x1::type_name::TypeName, 0x2::object::ID>,
    }

    public entry fun create_vault<T0>(arg0: &mut Admin, arg1: &mut 0x2::tx_context::TxContext) {
        assert!(arg0.admin == 0x2::tx_context::sender(arg1), 0);
        assert!(!0x2::table::contains<0x1::type_name::TypeName, 0x2::object::ID>(&arg0.vaults, 0x1::type_name::with_defining_ids<T0>()), 101);
        let v0 = Vault<T0>{
            id      : 0x2::object::new(arg1),
            balance : 0x2::balance::zero<T0>(),
            admin   : 0x2::tx_context::sender(arg1),
        };
        0x2::table::add<0x1::type_name::TypeName, 0x2::object::ID>(&mut arg0.vaults, 0x1::type_name::with_defining_ids<T0>(), 0x2::object::id<Vault<T0>>(&v0));
        0x2::transfer::share_object<Vault<T0>>(v0);
    }

    public entry fun deposit<T0>(arg0: &Admin, arg1: &mut Vault<T0>, arg2: 0x2::coin::Coin<T0>, arg3: u64, arg4: &mut 0x2::tx_context::TxContext) {
        assert!(0x2::coin::value<T0>(&arg2) >= arg3, 100);
        let v0 = 0x2::object::id<Vault<T0>>(arg1);
        assert!(0x2::table::borrow<0x1::type_name::TypeName, 0x2::object::ID>(&arg0.vaults, 0x1::type_name::with_defining_ids<T0>()) == &v0, 102);
        if (0x2::coin::value<T0>(&arg2) > arg3) {
            0x2::balance::join<T0>(&mut arg1.balance, 0x2::coin::into_balance<T0>(0x2::coin::split<T0>(&mut arg2, arg3, arg4)));
            0x2::transfer::public_transfer<0x2::coin::Coin<T0>>(arg2, 0x2::tx_context::sender(arg4));
        } else {
            0x2::coin::put<T0>(&mut arg1.balance, arg2);
        };
    }

    fun init(arg0: &mut 0x2::tx_context::TxContext) {
        let v0 = Admin{
            id     : 0x2::object::new(arg0),
            admin  : 0x2::tx_context::sender(arg0),
            vaults : 0x2::table::new<0x1::type_name::TypeName, 0x2::object::ID>(arg0),
        };
        0x2::transfer::share_object<Admin>(v0);
    }

    public fun vault_balance<T0>(arg0: &Admin, arg1: &Vault<T0>) : u64 {
        let v0 = 0x2::object::id<Vault<T0>>(arg1);
        assert!(0x2::table::borrow<0x1::type_name::TypeName, 0x2::object::ID>(&arg0.vaults, 0x1::type_name::with_defining_ids<T0>()) == &v0, 13906835351164420095);
        0x2::balance::value<T0>(&arg1.balance)
    }

    public entry fun withdraw<T0>(arg0: &Admin, arg1: &mut Vault<T0>, arg2: u64, arg3: &mut 0x2::tx_context::TxContext) {
        assert!(arg0.admin == 0x2::tx_context::sender(arg3), 0);
        let v0 = 0x2::object::id<Vault<T0>>(arg1);
        assert!(0x2::table::borrow<0x1::type_name::TypeName, 0x2::object::ID>(&arg0.vaults, 0x1::type_name::with_defining_ids<T0>()) == &v0, 102);
        assert!(0x2::balance::value<T0>(&arg1.balance) >= arg2, 100);
        0x2::transfer::public_transfer<0x2::coin::Coin<T0>>(0x2::coin::take<T0>(&mut arg1.balance, arg2, arg3), 0x2::tx_context::sender(arg3));
    }

    // decompiled from Move bytecode v7
}

