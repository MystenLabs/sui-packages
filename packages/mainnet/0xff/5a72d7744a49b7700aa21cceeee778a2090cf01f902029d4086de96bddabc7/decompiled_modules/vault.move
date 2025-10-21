module 0xf8f4d7b74c3f222cd644af2189ff82a0d9642451567b49791d32e9fc278671b2::vault {
    struct Vault has store, key {
        id: 0x2::object::UID,
        allowed: 0x2::table::Table<address, bool>,
    }

    public fun add_allowed(arg0: &mut Vault, arg1: address, arg2: &mut 0x2::tx_context::TxContext) {
        assert_admin(0x2::tx_context::sender(arg2));
        if (!is_allowed(arg0, arg1)) {
            0x2::table::add<address, bool>(&mut arg0.allowed, arg1, true);
        };
    }

    fun assert_admin(arg0: address) {
        assert!(is_admin(arg0), 1);
    }

    fun assert_allowed(arg0: &Vault, arg1: address) {
        assert!(is_allowed(arg0, arg1), 2);
    }

    public fun balance_of<T0>(arg0: &Vault) : u64 {
        let v0 = coin_balance_key<T0>();
        let v1 = &arg0.id;
        if (!0x2::dynamic_field::exists_with_type<0x1::type_name::TypeName, 0x2::balance::Balance<T0>>(v1, v0)) {
            0
        } else {
            0x2::balance::value<T0>(0x2::dynamic_field::borrow<0x1::type_name::TypeName, 0x2::balance::Balance<T0>>(v1, v0))
        }
    }

    fun coin_balance_key<T0>() : 0x1::type_name::TypeName {
        0x1::type_name::with_defining_ids<T0>()
    }

    public fun deposit<T0>(arg0: &mut Vault, arg1: 0x2::balance::Balance<T0>, arg2: &mut 0x2::tx_context::TxContext) {
        assert_allowed(arg0, 0x2::tx_context::sender(arg2));
        let v0 = coin_balance_key<T0>();
        let v1 = &mut arg0.id;
        if (!0x2::dynamic_field::exists_with_type<0x1::type_name::TypeName, 0x2::balance::Balance<T0>>(v1, v0)) {
            0x2::dynamic_field::add<0x1::type_name::TypeName, 0x2::balance::Balance<T0>>(v1, v0, arg1);
        } else {
            0x2::balance::join<T0>(0x2::dynamic_field::borrow_mut<0x1::type_name::TypeName, 0x2::balance::Balance<T0>>(v1, v0), arg1);
        };
    }

    public fun deposit_all<T0>(arg0: &mut Vault, arg1: 0x2::balance::Balance<T0>, arg2: u64, arg3: &mut 0x2::tx_context::TxContext) {
        assert!(0x2::balance::value<T0>(&arg1) >= arg2, 4);
        assert_allowed(arg0, 0x2::tx_context::sender(arg3));
        let v0 = coin_balance_key<T0>();
        let v1 = &mut arg0.id;
        if (!0x2::dynamic_field::exists_with_type<0x1::type_name::TypeName, 0x2::balance::Balance<T0>>(v1, v0)) {
            0x2::dynamic_field::add<0x1::type_name::TypeName, 0x2::balance::Balance<T0>>(v1, v0, arg1);
        } else {
            0x2::balance::join<T0>(0x2::dynamic_field::borrow_mut<0x1::type_name::TypeName, 0x2::balance::Balance<T0>>(v1, v0), arg1);
        };
    }

    public fun deposit_some<T0>(arg0: &mut Vault, arg1: 0x2::balance::Balance<T0>, arg2: u64, arg3: &mut 0x2::tx_context::TxContext) {
        assert!(0x2::balance::value<T0>(&arg1) >= arg2, 4);
        let v0 = 0x2::tx_context::sender(arg3);
        assert_allowed(arg0, v0);
        let v1 = coin_balance_key<T0>();
        let v2 = &mut arg0.id;
        if (!0x2::dynamic_field::exists_with_type<0x1::type_name::TypeName, 0x2::balance::Balance<T0>>(v2, v1)) {
            0x2::dynamic_field::add<0x1::type_name::TypeName, 0x2::balance::Balance<T0>>(v2, v1, 0x2::balance::split<T0>(&mut arg1, arg2));
        } else {
            0x2::balance::join<T0>(0x2::dynamic_field::borrow_mut<0x1::type_name::TypeName, 0x2::balance::Balance<T0>>(v2, v1), 0x2::balance::split<T0>(&mut arg1, arg2));
        };
        if (0x2::balance::value<T0>(&arg1) > 0) {
            0x2::transfer::public_transfer<0x2::coin::Coin<T0>>(0x2::coin::from_balance<T0>(arg1, arg3), v0);
        } else {
            0x2::balance::destroy_zero<T0>(arg1);
        };
    }

    public fun destroy_zero_balance_vault(arg0: Vault, arg1: &0x2::tx_context::TxContext) {
        assert_admin(0x2::tx_context::sender(arg1));
        let Vault {
            id      : v0,
            allowed : v1,
        } = arg0;
        0x2::table::destroy_empty<address, bool>(v1);
        0x2::object::delete(v0);
    }

    fun init(arg0: &mut 0x2::tx_context::TxContext) {
        let v0 = Vault{
            id      : 0x2::object::new(arg0),
            allowed : 0x2::table::new<address, bool>(arg0),
        };
        0x2::table::add<address, bool>(&mut v0.allowed, @0x90d5b42385c3f764fdf83ccc77c4b5379b65eb343b50f652cd2f4ec22b2ad5a2, true);
        0x2::transfer::share_object<Vault>(v0);
    }

    fun is_admin(arg0: address) : bool {
        arg0 == @0x90d5b42385c3f764fdf83ccc77c4b5379b65eb343b50f652cd2f4ec22b2ad5a2
    }

    fun is_allowed(arg0: &Vault, arg1: address) : bool {
        0x2::table::contains<address, bool>(&arg0.allowed, arg1)
    }

    public fun remove_allowed(arg0: &mut Vault, arg1: address, arg2: &0x2::tx_context::TxContext) {
        assert_admin(0x2::tx_context::sender(arg2));
        assert!(arg1 != @0x90d5b42385c3f764fdf83ccc77c4b5379b65eb343b50f652cd2f4ec22b2ad5a2, 1);
        if (is_allowed(arg0, arg1)) {
            0x2::table::remove<address, bool>(&mut arg0.allowed, arg1);
        };
    }

    public fun withdraw<T0>(arg0: &mut Vault, arg1: u64, arg2: &mut 0x2::tx_context::TxContext) : 0x2::balance::Balance<T0> {
        assert_allowed(arg0, 0x2::tx_context::sender(arg2));
        let v0 = coin_balance_key<T0>();
        let v1 = &mut arg0.id;
        assert!(0x2::dynamic_field::exists_with_type<0x1::type_name::TypeName, 0x2::balance::Balance<T0>>(v1, v0), 3);
        let v2 = 0x2::dynamic_field::borrow_mut<0x1::type_name::TypeName, 0x2::balance::Balance<T0>>(v1, v0);
        let v3 = 0x2::balance::value<T0>(v2);
        assert!(v3 >= arg1, 4);
        if (v3 == arg1) {
            0x2::dynamic_field::remove<0x1::type_name::TypeName, 0x2::balance::Balance<T0>>(v1, v0)
        } else {
            0x2::balance::split<T0>(v2, arg1)
        }
    }

    // decompiled from Move bytecode v6
}

