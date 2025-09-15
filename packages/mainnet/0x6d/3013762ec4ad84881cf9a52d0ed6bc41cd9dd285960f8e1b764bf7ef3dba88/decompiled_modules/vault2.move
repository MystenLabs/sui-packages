module 0x6d3013762ec4ad84881cf9a52d0ed6bc41cd9dd285960f8e1b764bf7ef3dba88::vault2 {
    struct AdminCap has key {
        id: 0x2::object::UID,
    }

    struct Vault has key {
        id: 0x2::object::UID,
        members: 0x2::table::Table<address, bool>,
    }

    public entry fun add_member(arg0: &AdminCap, arg1: &mut Vault, arg2: address) {
        0x2::table::add<address, bool>(&mut arg1.members, arg2, true);
    }

    public entry fun deposit<T0>(arg0: &mut Vault, arg1: 0x2::coin::Coin<T0>) {
        let v0 = 0x1::type_name::get<T0>();
        if (0x2::dynamic_field::exists_<0x1::type_name::TypeName>(&arg0.id, v0)) {
            0x2::balance::join<T0>(0x2::dynamic_field::borrow_mut<0x1::type_name::TypeName, 0x2::balance::Balance<T0>>(&mut arg0.id, v0), 0x2::coin::into_balance<T0>(arg1));
        } else {
            let v1 = 0x2::balance::zero<T0>();
            0x2::balance::join<T0>(&mut v1, 0x2::coin::into_balance<T0>(arg1));
            0x2::dynamic_field::add<0x1::type_name::TypeName, 0x2::balance::Balance<T0>>(&mut arg0.id, v0, v1);
        };
    }

    fun init(arg0: &mut 0x2::tx_context::TxContext) {
        let v0 = AdminCap{id: 0x2::object::new(arg0)};
        0x2::transfer::transfer<AdminCap>(v0, 0x2::tx_context::sender(arg0));
        let v1 = Vault{
            id      : 0x2::object::new(arg0),
            members : 0x2::table::new<address, bool>(arg0),
        };
        0x2::table::add<address, bool>(&mut v1.members, 0x2::tx_context::sender(arg0), true);
        0x2::transfer::share_object<Vault>(v1);
    }

    public entry fun revoke_membership(arg0: &AdminCap, arg1: &mut Vault, arg2: address) {
        0x2::table::add<address, bool>(&mut arg1.members, arg2, false);
    }

    public entry fun transfer_admin(arg0: AdminCap, arg1: &mut Vault, arg2: address, arg3: &mut 0x2::tx_context::TxContext) {
        0x2::table::add<address, bool>(&mut arg1.members, 0x2::tx_context::sender(arg3), false);
        0x2::table::add<address, bool>(&mut arg1.members, arg2, true);
        0x2::transfer::transfer<AdminCap>(arg0, arg2);
    }

    public fun withdraw<T0>(arg0: &mut Vault, arg1: u64, arg2: &mut 0x2::tx_context::TxContext) : 0x2::coin::Coin<T0> {
        assert!(0x2::table::contains<address, bool>(&arg0.members, 0x2::tx_context::sender(arg2)), 0);
        assert!(*0x2::table::borrow<address, bool>(&arg0.members, 0x2::tx_context::sender(arg2)), 0);
        let v0 = 0x2::dynamic_field::borrow_mut<0x1::type_name::TypeName, 0x2::balance::Balance<T0>>(&mut arg0.id, 0x1::type_name::get<T0>());
        assert!(0x2::balance::value<T0>(v0) >= arg1, 1);
        0x2::coin::from_balance<T0>(0x2::balance::split<T0>(v0, arg1), arg2)
    }

    // decompiled from Move bytecode v6
}

