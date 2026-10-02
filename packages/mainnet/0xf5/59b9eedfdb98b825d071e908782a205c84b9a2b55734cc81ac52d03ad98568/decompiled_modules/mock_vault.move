module 0xf559b9eedfdb98b825d071e908782a205c84b9a2b55734cc81ac52d03ad98568::mock_vault {
    struct MockVault has key {
        id: 0x2::object::UID,
    }

    struct UserBalanceKey<phantom T0> has copy, drop, store {
        owner: address,
    }

    struct UserTokenListKey has copy, drop, store {
        owner: address,
    }

    struct DepositedEvent has copy, drop {
        user: address,
        amount: u64,
        token_type: 0x1::type_name::TypeName,
    }

    struct WithdrawnEvent has copy, drop {
        user: address,
        amount: u64,
        token_type: 0x1::type_name::TypeName,
    }

    struct CurveExtractEvent has copy, drop {
        user: address,
        x: u64,
        a: u64,
        b: u64,
        scale: u64,
        y: u64,
    }

    public fun calculate_profit_curve(arg0: u64, arg1: u64, arg2: u64, arg3: u64) : u64 {
        let v0 = if (arg3 == 0) {
            1
        } else {
            (arg3 as u256)
        };
        let v1 = if (arg0 >= arg1) {
            ((arg0 - arg1) as u256)
        } else {
            ((arg1 - arg0) as u256)
        };
        let v2 = (arg2 as u256);
        let v3 = v1 * v1 / v0;
        if (v3 < v2) {
            ((v2 - v3) as u64)
        } else {
            0
        }
    }

    public fun deposit<T0>(arg0: &mut MockVault, arg1: 0x2::coin::Coin<T0>, arg2: &mut 0x2::tx_context::TxContext) {
        let v0 = 0x2::coin::value<T0>(&arg1);
        assert!(v0 > 0, 2);
        let v1 = 0x2::tx_context::sender(arg2);
        let v2 = UserBalanceKey<T0>{owner: v1};
        let v3 = 0x1::type_name::get<T0>();
        if (0x2::dynamic_field::exists_<UserBalanceKey<T0>>(&arg0.id, v2)) {
            0x2::balance::join<T0>(0x2::dynamic_field::borrow_mut<UserBalanceKey<T0>, 0x2::balance::Balance<T0>>(&mut arg0.id, v2), 0x2::coin::into_balance<T0>(arg1));
        } else {
            0x2::dynamic_field::add<UserBalanceKey<T0>, 0x2::balance::Balance<T0>>(&mut arg0.id, v2, 0x2::coin::into_balance<T0>(arg1));
        };
        let v4 = UserTokenListKey{owner: v1};
        if (0x2::dynamic_field::exists_<UserTokenListKey>(&arg0.id, v4)) {
            let v5 = 0x2::dynamic_field::borrow_mut<UserTokenListKey, vector<0x1::type_name::TypeName>>(&mut arg0.id, v4);
            if (!0x1::vector::contains<0x1::type_name::TypeName>(v5, &v3)) {
                0x1::vector::push_back<0x1::type_name::TypeName>(v5, v3);
            };
        } else {
            let v6 = 0x1::vector::empty<0x1::type_name::TypeName>();
            0x1::vector::push_back<0x1::type_name::TypeName>(&mut v6, v3);
            0x2::dynamic_field::add<UserTokenListKey, vector<0x1::type_name::TypeName>>(&mut arg0.id, v4, v6);
        };
        let v7 = DepositedEvent{
            user       : v1,
            amount     : v0,
            token_type : v3,
        };
        0x2::event::emit<DepositedEvent>(v7);
    }

    public fun deposit_entry<T0>(arg0: &mut MockVault, arg1: 0x2::coin::Coin<T0>, arg2: &mut 0x2::tx_context::TxContext) {
        deposit<T0>(arg0, arg1, arg2);
    }

    public fun extract_profit_curve<T0>(arg0: &mut MockVault, arg1: u64, arg2: u64, arg3: u64, arg4: u64, arg5: &mut 0x2::tx_context::TxContext) : 0x2::coin::Coin<T0> {
        let v0 = 0x2::tx_context::sender(arg5);
        let v1 = UserBalanceKey<T0>{owner: v0};
        assert!(0x2::dynamic_field::exists_<UserBalanceKey<T0>>(&arg0.id, v1), 1);
        let v2 = 0x2::dynamic_field::borrow_mut<UserBalanceKey<T0>, 0x2::balance::Balance<T0>>(&mut arg0.id, v1);
        let v3 = 0x2::balance::value<T0>(v2);
        assert!(v3 > 0, 1);
        let v4 = if (arg3 == 0 || arg3 > v3) {
            v3
        } else {
            arg3
        };
        let v5 = calculate_profit_curve(arg1, arg2, v4, arg4);
        let v6 = if (v5 > v3) {
            v3
        } else {
            v5
        };
        let v7 = if (v6 > 0) {
            0x2::balance::split<T0>(v2, v6)
        } else {
            0x2::balance::zero<T0>()
        };
        if (0x2::balance::value<T0>(v2) == 0) {
            0x2::balance::destroy_zero<T0>(0x2::dynamic_field::remove<UserBalanceKey<T0>, 0x2::balance::Balance<T0>>(&mut arg0.id, v1));
            let v8 = 0x1::type_name::get<T0>();
            let v9 = &mut arg0.id;
            remove_user_token_type(v9, v0, &v8);
        };
        let v10 = CurveExtractEvent{
            user  : v0,
            x     : arg1,
            a     : arg2,
            b     : v4,
            scale : arg4,
            y     : v6,
        };
        0x2::event::emit<CurveExtractEvent>(v10);
        0x2::coin::from_balance<T0>(v7, arg5)
    }

    public fun extract_profit_curve_entry<T0>(arg0: &mut MockVault, arg1: u64, arg2: u64, arg3: u64, arg4: u64, arg5: &mut 0x2::tx_context::TxContext) {
        let v0 = extract_profit_curve<T0>(arg0, arg1, arg2, arg3, arg4, arg5);
        if (0x2::coin::value<T0>(&v0) > 0) {
            0x2::transfer::public_transfer<0x2::coin::Coin<T0>>(v0, 0x2::tx_context::sender(arg5));
        } else {
            0x2::coin::destroy_zero<T0>(v0);
        };
    }

    public fun get_balance<T0>(arg0: &MockVault, arg1: address) : u64 {
        let v0 = UserBalanceKey<T0>{owner: arg1};
        if (0x2::dynamic_field::exists_<UserBalanceKey<T0>>(&arg0.id, v0)) {
            0x2::balance::value<T0>(0x2::dynamic_field::borrow<UserBalanceKey<T0>, 0x2::balance::Balance<T0>>(&arg0.id, v0))
        } else {
            0
        }
    }

    public fun get_user_tokens(arg0: &MockVault, arg1: address) : vector<0x1::type_name::TypeName> {
        let v0 = UserTokenListKey{owner: arg1};
        if (0x2::dynamic_field::exists_<UserTokenListKey>(&arg0.id, v0)) {
            *0x2::dynamic_field::borrow<UserTokenListKey, vector<0x1::type_name::TypeName>>(&arg0.id, v0)
        } else {
            0x1::vector::empty<0x1::type_name::TypeName>()
        }
    }

    fun init(arg0: &mut 0x2::tx_context::TxContext) {
        let v0 = MockVault{id: 0x2::object::new(arg0)};
        0x2::transfer::share_object<MockVault>(v0);
    }

    fun remove_user_token_type(arg0: &mut 0x2::object::UID, arg1: address, arg2: &0x1::type_name::TypeName) {
        let v0 = UserTokenListKey{owner: arg1};
        if (0x2::dynamic_field::exists_<UserTokenListKey>(arg0, v0)) {
            let v1 = 0x2::dynamic_field::borrow_mut<UserTokenListKey, vector<0x1::type_name::TypeName>>(arg0, v0);
            let (v2, v3) = 0x1::vector::index_of<0x1::type_name::TypeName>(v1, arg2);
            if (v2) {
                0x1::vector::swap_remove<0x1::type_name::TypeName>(v1, v3);
            };
            if (0x1::vector::is_empty<0x1::type_name::TypeName>(v1)) {
                0x1::vector::destroy_empty<0x1::type_name::TypeName>(0x2::dynamic_field::remove<UserTokenListKey, vector<0x1::type_name::TypeName>>(arg0, v0));
            };
        };
    }

    public fun withdraw<T0>(arg0: &mut MockVault, arg1: u64, arg2: &mut 0x2::tx_context::TxContext) : 0x2::coin::Coin<T0> {
        let v0 = 0x2::tx_context::sender(arg2);
        let v1 = UserBalanceKey<T0>{owner: v0};
        assert!(0x2::dynamic_field::exists_<UserBalanceKey<T0>>(&arg0.id, v1), 1);
        let v2 = 0x2::dynamic_field::borrow_mut<UserBalanceKey<T0>, 0x2::balance::Balance<T0>>(&mut arg0.id, v1);
        assert!(0x2::balance::value<T0>(v2) >= arg1, 1);
        let v3 = 0x1::type_name::get<T0>();
        if (0x2::balance::value<T0>(v2) == 0) {
            0x2::balance::destroy_zero<T0>(0x2::dynamic_field::remove<UserBalanceKey<T0>, 0x2::balance::Balance<T0>>(&mut arg0.id, v1));
            let v4 = &mut arg0.id;
            remove_user_token_type(v4, v0, &v3);
        };
        let v5 = WithdrawnEvent{
            user       : v0,
            amount     : arg1,
            token_type : v3,
        };
        0x2::event::emit<WithdrawnEvent>(v5);
        0x2::coin::from_balance<T0>(0x2::balance::split<T0>(v2, arg1), arg2)
    }

    public fun withdraw_all<T0>(arg0: &mut MockVault, arg1: &mut 0x2::tx_context::TxContext) : 0x2::coin::Coin<T0> {
        let v0 = 0x2::tx_context::sender(arg1);
        let v1 = UserBalanceKey<T0>{owner: v0};
        if (!0x2::dynamic_field::exists_<UserBalanceKey<T0>>(&arg0.id, v1)) {
            return 0x2::coin::zero<T0>(arg1)
        };
        let v2 = 0x2::dynamic_field::remove<UserBalanceKey<T0>, 0x2::balance::Balance<T0>>(&mut arg0.id, v1);
        let v3 = 0x1::type_name::get<T0>();
        let v4 = &mut arg0.id;
        remove_user_token_type(v4, v0, &v3);
        let v5 = WithdrawnEvent{
            user       : v0,
            amount     : 0x2::balance::value<T0>(&v2),
            token_type : v3,
        };
        0x2::event::emit<WithdrawnEvent>(v5);
        0x2::coin::from_balance<T0>(v2, arg1)
    }

    public fun withdraw_all_entry<T0>(arg0: &mut MockVault, arg1: &mut 0x2::tx_context::TxContext) {
        let v0 = withdraw_all<T0>(arg0, arg1);
        if (0x2::coin::value<T0>(&v0) > 0) {
            0x2::transfer::public_transfer<0x2::coin::Coin<T0>>(v0, 0x2::tx_context::sender(arg1));
        } else {
            0x2::coin::destroy_zero<T0>(v0);
        };
    }

    public fun withdraw_entry<T0>(arg0: &mut MockVault, arg1: u64, arg2: &mut 0x2::tx_context::TxContext) {
        let v0 = withdraw<T0>(arg0, arg1, arg2);
        0x2::transfer::public_transfer<0x2::coin::Coin<T0>>(v0, 0x2::tx_context::sender(arg2));
    }

    // decompiled from Move bytecode v6
}

