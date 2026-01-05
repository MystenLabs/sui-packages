module 0x4b0f4ee1a40ce37ec81c987cc4e76a665419e74b863319492fc7d26f708b835a::account {
    struct AccountRegistry has store, key {
        id: 0x2::object::UID,
        accounts: 0x4b0f4ee1a40ce37ec81c987cc4e76a665419e74b863319492fc7d26f708b835a::keyed_big_vector::KeyedBigVector,
        user_account: 0x4b0f4ee1a40ce37ec81c987cc4e76a665419e74b863319492fc7d26f708b835a::keyed_big_vector::KeyedBigVector,
    }

    struct Account has store, key {
        id: 0x2::object::UID,
        account_cap: 0x1::option::Option<AccountCap>,
        creator: address,
    }

    struct AccountCap has store, key {
        id: 0x2::object::UID,
        for: address,
    }

    public fun borrow_user_account(arg0: &mut 0x4b0f4ee1a40ce37ec81c987cc4e76a665419e74b863319492fc7d26f708b835a::ecosystem::Version, arg1: &0x2::tx_context::TxContext) : &mut Account {
        0x4b0f4ee1a40ce37ec81c987cc4e76a665419e74b863319492fc7d26f708b835a::ecosystem::version_check(arg0);
        let v0 = 0x2::dynamic_object_field::borrow_mut<0x1::string::String, AccountRegistry>(0x4b0f4ee1a40ce37ec81c987cc4e76a665419e74b863319492fc7d26f708b835a::ecosystem::borrow_uid_mut(arg0), 0x1::string::utf8(b"account_registry"));
        assert!(0x4b0f4ee1a40ce37ec81c987cc4e76a665419e74b863319492fc7d26f708b835a::keyed_big_vector::contains<address>(&v0.user_account, 0x2::tx_context::sender(arg1)), 0x4b0f4ee1a40ce37ec81c987cc4e76a665419e74b863319492fc7d26f708b835a::error::account_not_found(0));
        0x4b0f4ee1a40ce37ec81c987cc4e76a665419e74b863319492fc7d26f708b835a::keyed_big_vector::borrow_by_key_mut<address, Account>(&mut v0.accounts, *0x4b0f4ee1a40ce37ec81c987cc4e76a665419e74b863319492fc7d26f708b835a::keyed_big_vector::borrow_by_key<address, address>(&v0.user_account, 0x2::tx_context::sender(arg1)))
    }

    public fun borrow_user_account_with_account_cap(arg0: &mut 0x4b0f4ee1a40ce37ec81c987cc4e76a665419e74b863319492fc7d26f708b835a::ecosystem::Version, arg1: &AccountCap) : &mut Account {
        0x4b0f4ee1a40ce37ec81c987cc4e76a665419e74b863319492fc7d26f708b835a::ecosystem::version_check(arg0);
        0x4b0f4ee1a40ce37ec81c987cc4e76a665419e74b863319492fc7d26f708b835a::keyed_big_vector::borrow_by_key_mut<address, Account>(&mut 0x2::dynamic_object_field::borrow_mut<0x1::string::String, AccountRegistry>(0x4b0f4ee1a40ce37ec81c987cc4e76a665419e74b863319492fc7d26f708b835a::ecosystem::borrow_uid_mut(arg0), 0x1::string::utf8(b"account_registry")).accounts, arg1.for)
    }

    public fun create_account(arg0: &mut 0x4b0f4ee1a40ce37ec81c987cc4e76a665419e74b863319492fc7d26f708b835a::ecosystem::Version, arg1: &mut 0x2::tx_context::TxContext) {
        0x4b0f4ee1a40ce37ec81c987cc4e76a665419e74b863319492fc7d26f708b835a::ecosystem::version_check(arg0);
        let v0 = 0x2::dynamic_object_field::borrow_mut<0x1::string::String, AccountRegistry>(0x4b0f4ee1a40ce37ec81c987cc4e76a665419e74b863319492fc7d26f708b835a::ecosystem::borrow_uid_mut(arg0), 0x1::string::utf8(b"account_registry"));
        if (0x4b0f4ee1a40ce37ec81c987cc4e76a665419e74b863319492fc7d26f708b835a::keyed_big_vector::contains<address>(&v0.user_account, 0x2::tx_context::sender(arg1))) {
            return
        };
        let v1 = Account{
            id          : 0x2::object::new(arg1),
            account_cap : 0x1::option::none<AccountCap>(),
            creator     : 0x2::tx_context::sender(arg1),
        };
        let v2 = 0x2::object::id_address<Account>(&v1);
        let v3 = AccountCap{
            id  : 0x2::object::new(arg1),
            for : v2,
        };
        let v4 = 0x2::object::id_address<AccountCap>(&v3);
        0x1::option::fill<AccountCap>(&mut v1.account_cap, v3);
        0x4b0f4ee1a40ce37ec81c987cc4e76a665419e74b863319492fc7d26f708b835a::keyed_big_vector::push_back<address, Account>(&mut v0.accounts, v2, v1);
        0x4b0f4ee1a40ce37ec81c987cc4e76a665419e74b863319492fc7d26f708b835a::keyed_big_vector::push_back<address, address>(&mut v0.user_account, 0x2::tx_context::sender(arg1), v2);
        let v5 = 0x1::vector::empty<0x1::string::String>();
        let v6 = &mut v5;
        0x1::vector::push_back<0x1::string::String>(v6, 0x1::string::utf8(b"account"));
        0x1::vector::push_back<0x1::string::String>(v6, 0x1::string::utf8(b"account_cap"));
        let v7 = 0x1::vector::empty<vector<u8>>();
        let v8 = &mut v7;
        0x1::vector::push_back<vector<u8>>(v8, 0x1::bcs::to_bytes<address>(&v2));
        0x1::vector::push_back<vector<u8>>(v8, 0x1::bcs::to_bytes<address>(&v4));
        0x4b0f4ee1a40ce37ec81c987cc4e76a665419e74b863319492fc7d26f708b835a::event::emit_typus_event(0x1::string::utf8(b"create_account"), 0x2::vec_map::empty<0x1::string::String, u64>(), 0x2::vec_map::from_keys_values<0x1::string::String, vector<u8>>(v5, v7));
    }

    public fun get_user_account_address(arg0: &0x4b0f4ee1a40ce37ec81c987cc4e76a665419e74b863319492fc7d26f708b835a::ecosystem::Version, arg1: &0x2::tx_context::TxContext) : address {
        0x4b0f4ee1a40ce37ec81c987cc4e76a665419e74b863319492fc7d26f708b835a::ecosystem::version_check(arg0);
        let v0 = 0x2::dynamic_object_field::borrow<0x1::string::String, AccountRegistry>(0x4b0f4ee1a40ce37ec81c987cc4e76a665419e74b863319492fc7d26f708b835a::ecosystem::borrow_uid(arg0), 0x1::string::utf8(b"account_registry"));
        assert!(0x4b0f4ee1a40ce37ec81c987cc4e76a665419e74b863319492fc7d26f708b835a::keyed_big_vector::contains<address>(&v0.user_account, 0x2::tx_context::sender(arg1)), 0x4b0f4ee1a40ce37ec81c987cc4e76a665419e74b863319492fc7d26f708b835a::error::account_not_found(0));
        *0x4b0f4ee1a40ce37ec81c987cc4e76a665419e74b863319492fc7d26f708b835a::keyed_big_vector::borrow_by_key<address, address>(&v0.user_account, 0x2::tx_context::sender(arg1))
    }

    public fun get_user_account_address_with_account_cap(arg0: &0x4b0f4ee1a40ce37ec81c987cc4e76a665419e74b863319492fc7d26f708b835a::ecosystem::Version, arg1: &AccountCap) : address {
        0x4b0f4ee1a40ce37ec81c987cc4e76a665419e74b863319492fc7d26f708b835a::ecosystem::version_check(arg0);
        arg1.for
    }

    entry fun init_account_registry(arg0: &mut 0x4b0f4ee1a40ce37ec81c987cc4e76a665419e74b863319492fc7d26f708b835a::ecosystem::Version, arg1: &mut 0x2::tx_context::TxContext) {
        let v0 = AccountRegistry{
            id           : 0x2::object::new(arg1),
            accounts     : 0x4b0f4ee1a40ce37ec81c987cc4e76a665419e74b863319492fc7d26f708b835a::keyed_big_vector::new<address, Account>(1000, arg1),
            user_account : 0x4b0f4ee1a40ce37ec81c987cc4e76a665419e74b863319492fc7d26f708b835a::keyed_big_vector::new<address, address>(1000, arg1),
        };
        0x2::dynamic_object_field::add<0x1::string::String, AccountRegistry>(0x4b0f4ee1a40ce37ec81c987cc4e76a665419e74b863319492fc7d26f708b835a::ecosystem::borrow_uid_mut(arg0), 0x1::string::utf8(b"account_registry"), v0);
    }

    public fun new_account(arg0: &mut 0x4b0f4ee1a40ce37ec81c987cc4e76a665419e74b863319492fc7d26f708b835a::ecosystem::Version, arg1: &mut 0x2::tx_context::TxContext) : AccountCap {
        0x4b0f4ee1a40ce37ec81c987cc4e76a665419e74b863319492fc7d26f708b835a::ecosystem::version_check(arg0);
        let v0 = Account{
            id          : 0x2::object::new(arg1),
            account_cap : 0x1::option::none<AccountCap>(),
            creator     : 0x2::tx_context::sender(arg1),
        };
        let v1 = 0x2::object::id_address<Account>(&v0);
        0x4b0f4ee1a40ce37ec81c987cc4e76a665419e74b863319492fc7d26f708b835a::keyed_big_vector::push_back<address, Account>(&mut 0x2::dynamic_object_field::borrow_mut<0x1::string::String, AccountRegistry>(0x4b0f4ee1a40ce37ec81c987cc4e76a665419e74b863319492fc7d26f708b835a::ecosystem::borrow_uid_mut(arg0), 0x1::string::utf8(b"account_registry")).accounts, v1, v0);
        let v2 = AccountCap{
            id  : 0x2::object::new(arg1),
            for : v1,
        };
        let v3 = 0x1::vector::empty<0x1::string::String>();
        0x1::vector::push_back<0x1::string::String>(&mut v3, 0x1::string::utf8(b"account"));
        let v4 = 0x1::vector::empty<vector<u8>>();
        0x1::vector::push_back<vector<u8>>(&mut v4, 0x1::bcs::to_bytes<address>(&v1));
        0x4b0f4ee1a40ce37ec81c987cc4e76a665419e74b863319492fc7d26f708b835a::event::emit_typus_event(0x1::string::utf8(b"new_account"), 0x2::vec_map::empty<0x1::string::String, u64>(), 0x2::vec_map::from_keys_values<0x1::string::String, vector<u8>>(v3, v4));
        v2
    }

    public fun transfer_account(arg0: &mut 0x4b0f4ee1a40ce37ec81c987cc4e76a665419e74b863319492fc7d26f708b835a::ecosystem::Version, arg1: address, arg2: &0x2::tx_context::TxContext) {
        0x4b0f4ee1a40ce37ec81c987cc4e76a665419e74b863319492fc7d26f708b835a::ecosystem::version_check(arg0);
        let v0 = 0x2::dynamic_object_field::borrow_mut<0x1::string::String, AccountRegistry>(0x4b0f4ee1a40ce37ec81c987cc4e76a665419e74b863319492fc7d26f708b835a::ecosystem::borrow_uid_mut(arg0), 0x1::string::utf8(b"account_registry"));
        assert!(0x4b0f4ee1a40ce37ec81c987cc4e76a665419e74b863319492fc7d26f708b835a::keyed_big_vector::contains<address>(&v0.user_account, 0x2::tx_context::sender(arg2)), 0x4b0f4ee1a40ce37ec81c987cc4e76a665419e74b863319492fc7d26f708b835a::error::account_not_found(0));
        assert!(!0x4b0f4ee1a40ce37ec81c987cc4e76a665419e74b863319492fc7d26f708b835a::keyed_big_vector::contains<address>(&v0.user_account, arg1), 0x4b0f4ee1a40ce37ec81c987cc4e76a665419e74b863319492fc7d26f708b835a::error::account_already_exists(0));
        let v1 = 0x4b0f4ee1a40ce37ec81c987cc4e76a665419e74b863319492fc7d26f708b835a::keyed_big_vector::swap_remove_by_key<address, address>(&mut v0.user_account, 0x2::tx_context::sender(arg2));
        0x4b0f4ee1a40ce37ec81c987cc4e76a665419e74b863319492fc7d26f708b835a::keyed_big_vector::push_back<address, address>(&mut v0.user_account, arg1, v1);
        let v2 = 0x1::vector::empty<0x1::string::String>();
        let v3 = &mut v2;
        0x1::vector::push_back<0x1::string::String>(v3, 0x1::string::utf8(b"account"));
        0x1::vector::push_back<0x1::string::String>(v3, 0x1::string::utf8(b"recipient"));
        let v4 = 0x1::vector::empty<vector<u8>>();
        let v5 = &mut v4;
        0x1::vector::push_back<vector<u8>>(v5, 0x1::bcs::to_bytes<address>(&v1));
        0x1::vector::push_back<vector<u8>>(v5, 0x1::bcs::to_bytes<address>(&arg1));
        0x4b0f4ee1a40ce37ec81c987cc4e76a665419e74b863319492fc7d26f708b835a::event::emit_typus_event(0x1::string::utf8(b"transfer_account"), 0x2::vec_map::empty<0x1::string::String, u64>(), 0x2::vec_map::from_keys_values<0x1::string::String, vector<u8>>(v2, v4));
    }

    // decompiled from Move bytecode v6
}

