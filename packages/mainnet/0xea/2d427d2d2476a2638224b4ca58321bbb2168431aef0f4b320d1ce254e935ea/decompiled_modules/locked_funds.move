module 0xf6b468748dced8435f4407d0ecb0457b921a2e89266a60862e36dbf243c71841::locked_funds {
    struct LockedFundsManagement has key {
        id: 0x2::object::UID,
        user_collateral_coin_types: 0x2::table::Table<address, 0x2::vec_set::VecSet<0x1::type_name::TypeName>>,
    }

    struct BalanceStore<phantom T0> has store {
        balance: 0x2::balance::Balance<T0>,
    }

    struct Deposit has copy, drop, store {
        owner: address,
        amount: u64,
        coin_type: 0x1::type_name::TypeName,
    }

    struct Withdraw has copy, drop, store {
        owner: address,
        amount: u64,
        coin_type: 0x1::type_name::TypeName,
    }

    public fun deposit<T0>(arg0: &mut LockedFundsManagement, arg1: &0xf6b468748dced8435f4407d0ecb0457b921a2e89266a60862e36dbf243c71841::config::GlobalConfig, arg2: 0x2::coin::Coin<T0>, arg3: &mut 0x2::tx_context::TxContext) {
        0xf6b468748dced8435f4407d0ecb0457b921a2e89266a60862e36dbf243c71841::config::check_package_version(arg1);
        let v0 = 0x2::coin::value<T0>(&arg2);
        assert!(v0 > 0, 1);
        let v1 = 0x2::tx_context::sender(arg3);
        let v2 = get_or_create_balance_store_mut<T0>(arg0, v1);
        0x2::balance::join<T0>(&mut v2.balance, 0x2::coin::into_balance<T0>(arg2));
        update_user_collateral_coin_types<T0>(arg0, v1, 0x2::balance::value<T0>(&v2.balance));
        let v3 = Deposit{
            owner     : v1,
            amount    : v0,
            coin_type : 0x1::type_name::get<T0>(),
        };
        0x2::event::emit<Deposit>(v3);
    }

    fun get_balance_store_key<T0>(arg0: address) : vector<u8> {
        let v0 = 0x1::type_name::into_string(0x1::type_name::get<T0>());
        let v1 = 0x2::bcs::to_bytes<0x1::ascii::String>(&v0);
        0x1::vector::append<u8>(&mut v1, 0x2::bcs::to_bytes<address>(&arg0));
        v1
    }

    fun get_or_create_balance_store_mut<T0>(arg0: &mut LockedFundsManagement, arg1: address) : &mut BalanceStore<T0> {
        let v0 = get_balance_store_key<T0>(arg1);
        if (!0x2::dynamic_field::exists_<vector<u8>>(&arg0.id, v0)) {
            let v1 = BalanceStore<T0>{balance: 0x2::balance::zero<T0>()};
            0x2::dynamic_field::add<vector<u8>, BalanceStore<T0>>(&mut arg0.id, v0, v1);
        };
        0x2::dynamic_field::borrow_mut<vector<u8>, BalanceStore<T0>>(&mut arg0.id, v0)
    }

    public fun get_user_collateral_amount<T0>(arg0: &LockedFundsManagement, arg1: address) : u64 {
        let v0 = get_balance_store_key<T0>(arg1);
        if (!0x2::dynamic_field::exists_<vector<u8>>(&arg0.id, v0)) {
            return 0
        };
        0x2::balance::value<T0>(&0x2::dynamic_field::borrow<vector<u8>, BalanceStore<T0>>(&arg0.id, v0).balance)
    }

    public fun get_user_collateral_coin_types(arg0: &LockedFundsManagement, arg1: address) : vector<0x1::type_name::TypeName> {
        if (!0x2::table::contains<address, 0x2::vec_set::VecSet<0x1::type_name::TypeName>>(&arg0.user_collateral_coin_types, arg1)) {
            return 0x1::vector::empty<0x1::type_name::TypeName>()
        };
        let v0 = 0x2::vec_set::keys<0x1::type_name::TypeName>(0x2::table::borrow<address, 0x2::vec_set::VecSet<0x1::type_name::TypeName>>(&arg0.user_collateral_coin_types, arg1));
        let v1 = 0x1::vector::empty<0x1::type_name::TypeName>();
        let v2 = 0;
        while (v2 < 0x1::vector::length<0x1::type_name::TypeName>(v0)) {
            0x1::vector::push_back<0x1::type_name::TypeName>(&mut v1, *0x1::vector::borrow<0x1::type_name::TypeName>(v0, v2));
            v2 = v2 + 1;
        };
        v1
    }

    fun init(arg0: &mut 0x2::tx_context::TxContext) {
        let v0 = LockedFundsManagement{
            id                         : 0x2::object::new(arg0),
            user_collateral_coin_types : 0x2::table::new<address, 0x2::vec_set::VecSet<0x1::type_name::TypeName>>(arg0),
        };
        0x2::transfer::share_object<LockedFundsManagement>(v0);
    }

    fun update_user_collateral_coin_types<T0>(arg0: &mut LockedFundsManagement, arg1: address, arg2: u64) {
        let v0 = 0x1::type_name::get<T0>();
        if (arg2 != 0) {
            if (!0x2::table::contains<address, 0x2::vec_set::VecSet<0x1::type_name::TypeName>>(&arg0.user_collateral_coin_types, arg1)) {
                0x2::table::add<address, 0x2::vec_set::VecSet<0x1::type_name::TypeName>>(&mut arg0.user_collateral_coin_types, arg1, 0x2::vec_set::empty<0x1::type_name::TypeName>());
            };
            let v1 = 0x2::table::borrow_mut<address, 0x2::vec_set::VecSet<0x1::type_name::TypeName>>(&mut arg0.user_collateral_coin_types, arg1);
            if (!0x2::vec_set::contains<0x1::type_name::TypeName>(v1, &v0)) {
                0x2::vec_set::insert<0x1::type_name::TypeName>(v1, v0);
            };
        } else {
            if (0x2::table::contains<address, 0x2::vec_set::VecSet<0x1::type_name::TypeName>>(&arg0.user_collateral_coin_types, arg1)) {
                let v2 = 0x2::table::borrow_mut<address, 0x2::vec_set::VecSet<0x1::type_name::TypeName>>(&mut arg0.user_collateral_coin_types, arg1);
                if (0x2::vec_set::contains<0x1::type_name::TypeName>(v2, &v0)) {
                    0x2::vec_set::remove<0x1::type_name::TypeName>(v2, &v0);
                };
            };
            let v3 = get_balance_store_key<T0>(arg1);
            if (0x2::dynamic_field::exists_<vector<u8>>(&arg0.id, v3)) {
                let BalanceStore { balance: v4 } = 0x2::dynamic_field::remove<vector<u8>, BalanceStore<T0>>(&mut arg0.id, v3);
                0x2::balance::destroy_zero<T0>(v4);
            };
        };
    }

    public fun withdraw<T0>(arg0: &mut LockedFundsManagement, arg1: &0xf6b468748dced8435f4407d0ecb0457b921a2e89266a60862e36dbf243c71841::config::GlobalConfig, arg2: u64, arg3: &mut 0x2::tx_context::TxContext) {
        0xf6b468748dced8435f4407d0ecb0457b921a2e89266a60862e36dbf243c71841::config::check_package_version(arg1);
        assert!(arg2 > 0, 1);
        let v0 = 0x2::tx_context::sender(arg3);
        let v1 = get_or_create_balance_store_mut<T0>(arg0, v0);
        assert!(0x2::balance::value<T0>(&v1.balance) >= arg2, 2);
        0x2::transfer::public_transfer<0x2::coin::Coin<T0>>(0x2::coin::from_balance<T0>(0x2::balance::split<T0>(&mut v1.balance, arg2), arg3), v0);
        update_user_collateral_coin_types<T0>(arg0, v0, 0x2::balance::value<T0>(&v1.balance));
        let v2 = Withdraw{
            owner     : v0,
            amount    : arg2,
            coin_type : 0x1::type_name::get<T0>(),
        };
        0x2::event::emit<Withdraw>(v2);
    }

    public(friend) fun withdraw_internal<T0>(arg0: &mut LockedFundsManagement, arg1: address, arg2: u64, arg3: &mut 0x2::tx_context::TxContext) : 0x2::coin::Coin<T0> {
        assert!(arg2 > 0, 1);
        let v0 = get_balance_store_key<T0>(arg1);
        assert!(0x2::dynamic_field::exists_<vector<u8>>(&arg0.id, v0), 2);
        let v1 = 0x2::dynamic_field::borrow_mut<vector<u8>, BalanceStore<T0>>(&mut arg0.id, v0);
        assert!(0x2::balance::value<T0>(&v1.balance) >= arg2, 2);
        update_user_collateral_coin_types<T0>(arg0, arg1, 0x2::balance::value<T0>(&v1.balance));
        0x2::coin::from_balance<T0>(0x2::balance::split<T0>(&mut v1.balance, arg2), arg3)
    }

    // decompiled from Move bytecode v6
}

