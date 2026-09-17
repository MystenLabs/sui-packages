module 0x130bbd92b2d054c0969347f45292e9559051ec60dcf157bcc0c1aaefee27a35b::global {
    struct SuperAdminCap has key {
        id: 0x2::object::UID,
    }

    struct VaultRegistry has store, key {
        id: 0x2::object::UID,
        created: 0x2::table::Table<0x1::type_name::TypeName, 0x2::table::Table<0x1::type_name::TypeName, 0x2::object::ID>>,
        fee_earned: 0x2::bag::Bag,
    }

    public(friend) fun earn_fee<T0>(arg0: &mut VaultRegistry, arg1: 0x2::object::ID, arg2: 0x2::balance::Balance<T0>) {
        let v0 = 0x2::balance::value<T0>(&arg2);
        if (v0 == 0) {
            0x2::balance::destroy_zero<T0>(arg2);
            return
        };
        let v1 = 0x1::type_name::with_defining_ids<T0>();
        if (!0x2::bag::contains<0x1::type_name::TypeName>(&arg0.fee_earned, v1)) {
            0x2::bag::add<0x1::type_name::TypeName, 0x2::balance::Balance<T0>>(&mut arg0.fee_earned, v1, 0x2::balance::zero<T0>());
        };
        0x130bbd92b2d054c0969347f45292e9559051ec60dcf157bcc0c1aaefee27a35b::event::emit_fee_earned(arg1, v1, v0, 0x2::balance::join<T0>(0x2::bag::borrow_mut<0x1::type_name::TypeName, 0x2::balance::Balance<T0>>(&mut arg0.fee_earned, v1), arg2));
    }

    public fun get_vault_id<T0, T1>(arg0: &VaultRegistry) : 0x2::object::ID {
        let v0 = 0x1::type_name::with_defining_ids<T0>();
        assert!(0x2::table::contains<0x1::type_name::TypeName, 0x2::table::Table<0x1::type_name::TypeName, 0x2::object::ID>>(&arg0.created, v0), 0x130bbd92b2d054c0969347f45292e9559051ec60dcf157bcc0c1aaefee27a35b::error::wrong_vault());
        let v1 = 0x2::table::borrow<0x1::type_name::TypeName, 0x2::table::Table<0x1::type_name::TypeName, 0x2::object::ID>>(&arg0.created, v0);
        let v2 = 0x1::type_name::with_defining_ids<T1>();
        assert!(0x2::table::contains<0x1::type_name::TypeName, 0x2::object::ID>(v1, v2), 0x130bbd92b2d054c0969347f45292e9559051ec60dcf157bcc0c1aaefee27a35b::error::not_coin_type());
        *0x2::table::borrow<0x1::type_name::TypeName, 0x2::object::ID>(v1, v2)
    }

    fun init(arg0: &mut 0x2::tx_context::TxContext) {
        let v0 = VaultRegistry{
            id         : 0x2::object::new(arg0),
            created    : 0x2::table::new<0x1::type_name::TypeName, 0x2::table::Table<0x1::type_name::TypeName, 0x2::object::ID>>(arg0),
            fee_earned : 0x2::bag::new(arg0),
        };
        0x2::transfer::share_object<VaultRegistry>(v0);
        let v1 = SuperAdminCap{id: 0x2::object::new(arg0)};
        0x2::transfer::transfer<SuperAdminCap>(v1, 0x2::tx_context::sender(arg0));
    }

    public fun is_registered<T0, T1>(arg0: &VaultRegistry) : bool {
        let v0 = 0x1::type_name::with_defining_ids<T0>();
        if (!0x2::table::contains<0x1::type_name::TypeName, 0x2::table::Table<0x1::type_name::TypeName, 0x2::object::ID>>(&arg0.created, v0)) {
            return false
        };
        0x2::table::contains<0x1::type_name::TypeName, 0x2::object::ID>(0x2::table::borrow<0x1::type_name::TypeName, 0x2::table::Table<0x1::type_name::TypeName, 0x2::object::ID>>(&arg0.created, v0), 0x1::type_name::with_defining_ids<T1>())
    }

    public(friend) fun register<T0, T1>(arg0: &mut VaultRegistry, arg1: 0x2::object::ID, arg2: &mut 0x2::tx_context::TxContext) {
        let v0 = 0x1::type_name::with_defining_ids<T0>();
        let v1 = 0x1::type_name::with_defining_ids<T1>();
        if (!0x2::table::contains<0x1::type_name::TypeName, 0x2::table::Table<0x1::type_name::TypeName, 0x2::object::ID>>(&arg0.created, v0)) {
            0x2::table::add<0x1::type_name::TypeName, 0x2::table::Table<0x1::type_name::TypeName, 0x2::object::ID>>(&mut arg0.created, v0, 0x2::table::new<0x1::type_name::TypeName, 0x2::object::ID>(arg2));
        };
        let v2 = 0x2::table::borrow_mut<0x1::type_name::TypeName, 0x2::table::Table<0x1::type_name::TypeName, 0x2::object::ID>>(&mut arg0.created, v0);
        assert!(!0x2::table::contains<0x1::type_name::TypeName, 0x2::object::ID>(v2, v1), 0x130bbd92b2d054c0969347f45292e9559051ec60dcf157bcc0c1aaefee27a35b::error::vault_already_exists());
        0x2::table::add<0x1::type_name::TypeName, 0x2::object::ID>(v2, v1, arg1);
    }

    // decompiled from Move bytecode v7
}

