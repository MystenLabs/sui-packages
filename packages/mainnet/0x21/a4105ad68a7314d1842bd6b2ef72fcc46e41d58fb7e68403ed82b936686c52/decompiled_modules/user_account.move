module 0x21a4105ad68a7314d1842bd6b2ef72fcc46e41d58fb7e68403ed82b936686c52::user_account {
    struct UserAccount has store, key {
        id: 0x2::object::UID,
        owner: address,
        delegate_user: vector<address>,
        symbols: vector<0x1::type_name::TypeName>,
        u64_padding: vector<u64>,
    }

    struct UserAccountCap has store, key {
        id: 0x2::object::UID,
        owner: address,
        user_account_id: 0x2::object::ID,
    }

    public(friend) fun add_delegate_user(arg0: &mut UserAccount, arg1: address) {
        if (!0x1::vector::contains<address>(&arg0.delegate_user, &arg1)) {
            0x1::vector::push_back<address>(&mut arg0.delegate_user, arg1);
        };
    }

    public(friend) fun check_owner(arg0: &UserAccount, arg1: &0x2::tx_context::TxContext) {
        assert!(arg0.owner == 0x2::tx_context::sender(arg1), 0x21a4105ad68a7314d1842bd6b2ef72fcc46e41d58fb7e68403ed82b936686c52::error::not_user_account_owner());
    }

    public(friend) fun deposit<T0>(arg0: &mut UserAccount, arg1: 0x2::balance::Balance<T0>) {
        let v0 = 0x1::type_name::get<T0>();
        if (0x1::vector::contains<0x1::type_name::TypeName>(&arg0.symbols, &v0)) {
            0x2::balance::join<T0>(0x2::dynamic_field::borrow_mut<0x1::type_name::TypeName, 0x2::balance::Balance<T0>>(&mut arg0.id, v0), arg1);
        } else {
            0x1::vector::push_back<0x1::type_name::TypeName>(&mut arg0.symbols, v0);
            0x2::dynamic_field::add<0x1::type_name::TypeName, 0x2::balance::Balance<T0>>(&mut arg0.id, v0, arg1);
        };
    }

    public(friend) fun get_mut_user_account(arg0: &mut 0x2::object::UID, arg1: address) : &mut UserAccount {
        0x2::object_table::borrow_mut<address, UserAccount>(0x2::dynamic_field::borrow_mut<0x1::string::String, 0x2::object_table::ObjectTable<address, UserAccount>>(arg0, 0x1::string::utf8(b"user_accounts")), arg1)
    }

    public(friend) fun get_user_account_owner(arg0: &UserAccountCap) : address {
        arg0.owner
    }

    public(friend) fun has_user_account(arg0: &0x2::object::UID, arg1: address) : bool {
        0x2::object_table::contains<address, UserAccount>(0x2::dynamic_field::borrow<0x1::string::String, 0x2::object_table::ObjectTable<address, UserAccount>>(arg0, 0x1::string::utf8(b"user_accounts")), arg1)
    }

    public(friend) fun new_user_account(arg0: &mut 0x2::tx_context::TxContext) : (UserAccount, UserAccountCap) {
        let v0 = 0x1::vector::empty<address>();
        0x1::vector::push_back<address>(&mut v0, 0x2::tx_context::sender(arg0));
        let v1 = UserAccount{
            id            : 0x2::object::new(arg0),
            owner         : 0x2::tx_context::sender(arg0),
            delegate_user : v0,
            symbols       : 0x1::vector::empty<0x1::type_name::TypeName>(),
            u64_padding   : 0x1::vector::empty<u64>(),
        };
        let v2 = UserAccountCap{
            id              : 0x2::object::new(arg0),
            owner           : 0x2::tx_context::sender(arg0),
            user_account_id : 0x2::object::id<UserAccount>(&v1),
        };
        (v1, v2)
    }

    public(friend) fun remove_user_account(arg0: &mut 0x2::object::UID, arg1: address, arg2: UserAccountCap) {
        let UserAccount {
            id            : v0,
            owner         : _,
            delegate_user : _,
            symbols       : v3,
            u64_padding   : _,
        } = 0x2::object_table::remove<address, UserAccount>(0x2::dynamic_field::borrow_mut<0x1::string::String, 0x2::object_table::ObjectTable<address, UserAccount>>(arg0, 0x1::string::utf8(b"user_accounts")), arg1);
        let v5 = v3;
        assert!(0x1::vector::is_empty<0x1::type_name::TypeName>(&v5), 0x21a4105ad68a7314d1842bd6b2ef72fcc46e41d58fb7e68403ed82b936686c52::error::not_empty_symbols());
        0x2::object::delete(v0);
        let UserAccountCap {
            id              : v6,
            owner           : _,
            user_account_id : _,
        } = arg2;
        0x2::object::delete(v6);
    }

    public(friend) fun withdraw<T0>(arg0: &mut UserAccount, arg1: 0x1::option::Option<u64>, arg2: &UserAccountCap) : 0x2::balance::Balance<T0> {
        let v0 = 0x1::type_name::get<T0>();
        assert!(0x1::vector::contains<0x1::type_name::TypeName>(&arg0.symbols, &v0), 0x21a4105ad68a7314d1842bd6b2ef72fcc46e41d58fb7e68403ed82b936686c52::error::no_balance());
        assert!(arg2.user_account_id == 0x2::object::id<UserAccount>(arg0), 0x21a4105ad68a7314d1842bd6b2ef72fcc46e41d58fb7e68403ed82b936686c52::error::not_user_account_cap());
        if (0x1::option::is_none<u64>(&arg1)) {
            let (v2, v3) = 0x1::vector::index_of<0x1::type_name::TypeName>(&arg0.symbols, &v0);
            assert!(v2, 0x21a4105ad68a7314d1842bd6b2ef72fcc46e41d58fb7e68403ed82b936686c52::error::no_balance());
            0x1::vector::remove<0x1::type_name::TypeName>(&mut arg0.symbols, v3);
            0x2::dynamic_field::remove<0x1::type_name::TypeName, 0x2::balance::Balance<T0>>(&mut arg0.id, v0)
        } else {
            0x2::balance::split<T0>(0x2::dynamic_field::borrow_mut<0x1::type_name::TypeName, 0x2::balance::Balance<T0>>(&mut arg0.id, v0), 0x1::option::extract<u64>(&mut arg1))
        }
    }

    // decompiled from Move bytecode v6
}

