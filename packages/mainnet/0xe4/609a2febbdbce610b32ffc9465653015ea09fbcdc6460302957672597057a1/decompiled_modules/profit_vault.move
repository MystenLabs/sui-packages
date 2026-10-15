module 0xe4609a2febbdbce610b32ffc9465653015ea09fbcdc6460302957672597057a1::profit_vault {
    struct ProfitVault has key {
        id: 0x2::object::UID,
        whitelist: 0x2::vec_set::VecSet<address>,
        user_profits: 0x2::table::Table<address, vector<UserProfit>>,
        unlock_countdown_ts_ms: u64,
    }

    struct LockVault has key {
        id: 0x2::object::UID,
        user_profits: 0x2::table::Table<address, vector<LockedUserProfit>>,
    }

    struct UserProfit has copy, drop, store {
        collateral_token: 0x1::type_name::TypeName,
        base_token: 0x1::type_name::TypeName,
        position_id: u64,
        symbol_market_id: 0x2::object::ID,
        order_id: u64,
        amount: u64,
        create_ts_ms: u64,
    }

    struct LockedUserProfit has copy, drop, store {
        user_profit: UserProfit,
        create_ts_ms: u64,
    }

    struct AddWhitelistEvent has copy, drop {
        new_whitelist_address: address,
    }

    struct RemoveWhitelistEvent has copy, drop {
        removed_whitelist_address: address,
    }

    struct LockUserProfitEvent has copy, drop {
        user: address,
        user_profit: UserProfit,
    }

    struct UnlockUserProfitEvent has copy, drop {
        user: address,
        user_profit: UserProfit,
    }

    struct PutUserProfitEvent has copy, drop {
        user: address,
        user_profit: UserProfit,
    }

    struct WithdrawProfitEvent has copy, drop {
        token_type: 0x1::type_name::TypeName,
        withdraw_amount: u64,
    }

    entry fun add_whitelist(arg0: &0xd29b520a538a13a7b4b75ea5ce27ef26defaf25f084a7c00f6adf9865cc851c8::admin::Version, arg1: &mut ProfitVault, arg2: address, arg3: &0x2::tx_context::TxContext) {
        0xe4609a2febbdbce610b32ffc9465653015ea09fbcdc6460302957672597057a1::core_admin::verify(arg0, arg3);
        assert!(!0x2::vec_set::contains<address>(&arg1.whitelist, &arg2), 1);
        0x2::vec_set::insert<address>(&mut arg1.whitelist, arg2);
        let v0 = AddWhitelistEvent{new_whitelist_address: arg2};
        0x2::event::emit<AddWhitelistEvent>(v0);
    }

    entry fun create_lock_vault(arg0: &0xd29b520a538a13a7b4b75ea5ce27ef26defaf25f084a7c00f6adf9865cc851c8::admin::Version, arg1: &mut 0x2::tx_context::TxContext) {
        0xe4609a2febbdbce610b32ffc9465653015ea09fbcdc6460302957672597057a1::core_admin::verify(arg0, arg1);
        let v0 = LockVault{
            id           : 0x2::object::new(arg1),
            user_profits : 0x2::table::new<address, vector<LockedUserProfit>>(arg1),
        };
        0x2::transfer::share_object<LockVault>(v0);
    }

    entry fun create_profit_vault(arg0: &0xd29b520a538a13a7b4b75ea5ce27ef26defaf25f084a7c00f6adf9865cc851c8::admin::Version, arg1: u64, arg2: &mut 0x2::tx_context::TxContext) {
        0xe4609a2febbdbce610b32ffc9465653015ea09fbcdc6460302957672597057a1::core_admin::verify(arg0, arg2);
        let v0 = ProfitVault{
            id                     : 0x2::object::new(arg2),
            whitelist              : 0x2::vec_set::empty<address>(),
            user_profits           : 0x2::table::new<address, vector<UserProfit>>(arg2),
            unlock_countdown_ts_ms : arg1,
        };
        let v1 = 0x1::vector::empty<0x2::object::ID>();
        0x1::vector::push_back<0x2::object::ID>(&mut v1, 0x2::object::id<ProfitVault>(&v0));
        let v2 = 0x1::vector::empty<u64>();
        0x1::vector::push_back<u64>(&mut v2, arg1);
        0xe4609a2febbdbce610b32ffc9465653015ea09fbcdc6460302957672597057a1::core_admin::emit_admin_event(3, 0, 0, 0x1::vector::empty<0x1::type_name::TypeName>(), v1, v2, arg2);
        0x2::transfer::share_object<ProfitVault>(v0);
    }

    fun find_locked_profit_(arg0: &vector<LockedUserProfit>, arg1: 0x1::type_name::TypeName, arg2: 0x2::object::ID, arg3: u64) : u64 {
        let v0 = 0;
        while (v0 < 0x1::vector::length<LockedUserProfit>(arg0)) {
            let v1 = &0x1::vector::borrow<LockedUserProfit>(arg0, v0).user_profit;
            let v2 = if (v1.symbol_market_id == arg2) {
                if (v1.order_id == arg3) {
                    v1.collateral_token == arg1
                } else {
                    false
                }
            } else {
                false
            };
            if (v2) {
                return v0
            };
            v0 = v0 + 1;
        };
        v0
    }

    fun find_profit_(arg0: &vector<UserProfit>, arg1: 0x1::type_name::TypeName, arg2: 0x2::object::ID, arg3: u64) : u64 {
        let v0 = 0;
        while (v0 < 0x1::vector::length<UserProfit>(arg0)) {
            let v1 = 0x1::vector::borrow<UserProfit>(arg0, v0);
            let v2 = if (v1.symbol_market_id == arg2) {
                if (v1.order_id == arg3) {
                    v1.collateral_token == arg1
                } else {
                    false
                }
            } else {
                false
            };
            if (v2) {
                return v0
            };
            v0 = v0 + 1;
        };
        v0
    }

    public(friend) fun get_locked_user_profits(arg0: &0xd29b520a538a13a7b4b75ea5ce27ef26defaf25f084a7c00f6adf9865cc851c8::admin::Version, arg1: &LockVault, arg2: address) : vector<vector<u8>> {
        0xe4609a2febbdbce610b32ffc9465653015ea09fbcdc6460302957672597057a1::core_admin::version_check(arg0);
        let v0 = 0x1::vector::empty<vector<u8>>();
        if (0x2::table::contains<address, vector<LockedUserProfit>>(&arg1.user_profits, arg2)) {
            let v1 = 0x2::table::borrow<address, vector<LockedUserProfit>>(&arg1.user_profits, arg2);
            let v2 = 0;
            while (v2 < 0x1::vector::length<LockedUserProfit>(v1)) {
                0x1::vector::push_back<vector<u8>>(&mut v0, 0x2::bcs::to_bytes<LockedUserProfit>(0x1::vector::borrow<LockedUserProfit>(v1, v2)));
                v2 = v2 + 1;
            };
        };
        v0
    }

    public(friend) fun get_user_profits(arg0: &0xd29b520a538a13a7b4b75ea5ce27ef26defaf25f084a7c00f6adf9865cc851c8::admin::Version, arg1: &ProfitVault, arg2: address) : vector<vector<u8>> {
        0xe4609a2febbdbce610b32ffc9465653015ea09fbcdc6460302957672597057a1::core_admin::version_check(arg0);
        let v0 = 0x1::vector::empty<vector<u8>>();
        if (0x2::table::contains<address, vector<UserProfit>>(&arg1.user_profits, arg2)) {
            let v1 = 0x2::table::borrow<address, vector<UserProfit>>(&arg1.user_profits, arg2);
            let v2 = 0;
            while (v2 < 0x1::vector::length<UserProfit>(v1)) {
                0x1::vector::push_back<vector<u8>>(&mut v0, 0x2::bcs::to_bytes<UserProfit>(0x1::vector::borrow<UserProfit>(v1, v2)));
                v2 = v2 + 1;
            };
        };
        v0
    }

    public(friend) fun is_whitelist(arg0: &ProfitVault, arg1: address) : bool {
        0x2::vec_set::contains<address>(&arg0.whitelist, &arg1)
    }

    entry fun lock_user_profit<T0>(arg0: &0xd29b520a538a13a7b4b75ea5ce27ef26defaf25f084a7c00f6adf9865cc851c8::admin::Version, arg1: &mut ProfitVault, arg2: &mut LockVault, arg3: address, arg4: 0x2::object::ID, arg5: u64, arg6: &0x2::clock::Clock, arg7: &0x2::tx_context::TxContext) {
        0xe4609a2febbdbce610b32ffc9465653015ea09fbcdc6460302957672597057a1::core_admin::verify(arg0, arg7);
        let v0 = 0x1::type_name::with_defining_ids<T0>();
        if (0x2::table::contains<address, vector<UserProfit>>(&arg1.user_profits, arg3)) {
            let v1 = 0x2::table::borrow_mut<address, vector<UserProfit>>(&mut arg1.user_profits, arg3);
            let v2 = find_profit_(v1, v0, arg4, arg5);
            assert!(v2 < 0x1::vector::length<UserProfit>(v1), 0);
            let v3 = LockedUserProfit{
                user_profit  : 0x1::vector::remove<UserProfit>(v1, v2),
                create_ts_ms : 0x2::clock::timestamp_ms(arg6),
            };
            assert!(v0 == v3.user_profit.collateral_token, 8);
            if (0x2::table::contains<address, vector<LockedUserProfit>>(&arg2.user_profits, arg3)) {
                0x1::vector::push_back<LockedUserProfit>(0x2::table::borrow_mut<address, vector<LockedUserProfit>>(&mut arg2.user_profits, arg3), v3);
            } else {
                let v4 = 0x1::vector::empty<LockedUserProfit>();
                0x1::vector::push_back<LockedUserProfit>(&mut v4, v3);
                0x2::table::add<address, vector<LockedUserProfit>>(&mut arg2.user_profits, arg3, v4);
            };
            if (0x2::dynamic_field::exists_<0x1::type_name::TypeName>(&arg2.id, v0)) {
                0x2::balance::join<T0>(0x2::dynamic_field::borrow_mut<0x1::type_name::TypeName, 0x2::balance::Balance<T0>>(&mut arg2.id, v0), 0x2::balance::split<T0>(0x2::dynamic_field::borrow_mut<0x1::type_name::TypeName, 0x2::balance::Balance<T0>>(&mut arg1.id, v0), v3.user_profit.amount));
            } else {
                0x2::dynamic_field::add<0x1::type_name::TypeName, 0x2::balance::Balance<T0>>(&mut arg2.id, v0, 0x2::balance::split<T0>(0x2::dynamic_field::borrow_mut<0x1::type_name::TypeName, 0x2::balance::Balance<T0>>(&mut arg1.id, v0), v3.user_profit.amount));
            };
            if (0x1::vector::length<UserProfit>(v1) == 0) {
                0x2::table::remove<address, vector<UserProfit>>(&mut arg1.user_profits, arg3);
            };
            let v5 = LockUserProfitEvent{
                user        : arg3,
                user_profit : v3.user_profit,
            };
            0x2::event::emit<LockUserProfitEvent>(v5);
        };
    }

    public(friend) fun put_user_profit<T0>(arg0: &mut ProfitVault, arg1: address, arg2: 0x2::balance::Balance<T0>, arg3: 0x1::type_name::TypeName, arg4: u64, arg5: 0x2::object::ID, arg6: u64, arg7: &0x2::clock::Clock) {
        let v0 = 0x1::type_name::with_defining_ids<T0>();
        let v1 = UserProfit{
            collateral_token : v0,
            base_token       : arg3,
            position_id      : arg4,
            symbol_market_id : arg5,
            order_id         : arg6,
            amount           : 0x2::balance::value<T0>(&arg2),
            create_ts_ms     : 0x2::clock::timestamp_ms(arg7),
        };
        if (0x2::table::contains<address, vector<UserProfit>>(&arg0.user_profits, arg1)) {
            0x1::vector::push_back<UserProfit>(0x2::table::borrow_mut<address, vector<UserProfit>>(&mut arg0.user_profits, arg1), v1);
        } else {
            let v2 = 0x1::vector::empty<UserProfit>();
            0x1::vector::push_back<UserProfit>(&mut v2, v1);
            0x2::table::add<address, vector<UserProfit>>(&mut arg0.user_profits, arg1, v2);
        };
        if (0x2::dynamic_field::exists_<0x1::type_name::TypeName>(&arg0.id, v0)) {
            0x2::balance::join<T0>(0x2::dynamic_field::borrow_mut<0x1::type_name::TypeName, 0x2::balance::Balance<T0>>(&mut arg0.id, v0), arg2);
        } else {
            0x2::dynamic_field::add<0x1::type_name::TypeName, 0x2::balance::Balance<T0>>(&mut arg0.id, v0, arg2);
        };
        let v3 = PutUserProfitEvent{
            user        : arg1,
            user_profit : v1,
        };
        0x2::event::emit<PutUserProfitEvent>(v3);
    }

    entry fun remove_whitelist(arg0: &0xd29b520a538a13a7b4b75ea5ce27ef26defaf25f084a7c00f6adf9865cc851c8::admin::Version, arg1: &mut ProfitVault, arg2: address, arg3: &0x2::tx_context::TxContext) {
        0xe4609a2febbdbce610b32ffc9465653015ea09fbcdc6460302957672597057a1::core_admin::verify(arg0, arg3);
        assert!(0x2::vec_set::contains<address>(&arg1.whitelist, &arg2), 2);
        0x2::vec_set::remove<address>(&mut arg1.whitelist, &arg2);
        let v0 = RemoveWhitelistEvent{removed_whitelist_address: arg2};
        0x2::event::emit<RemoveWhitelistEvent>(v0);
    }

    entry fun unlock_user_profit<T0>(arg0: &0xd29b520a538a13a7b4b75ea5ce27ef26defaf25f084a7c00f6adf9865cc851c8::admin::Version, arg1: &mut ProfitVault, arg2: &mut LockVault, arg3: address, arg4: 0x2::object::ID, arg5: u64, arg6: &0x2::tx_context::TxContext) {
        0xe4609a2febbdbce610b32ffc9465653015ea09fbcdc6460302957672597057a1::core_admin::verify(arg0, arg6);
        let v0 = 0x1::type_name::with_defining_ids<T0>();
        if (0x2::table::contains<address, vector<LockedUserProfit>>(&arg2.user_profits, arg3)) {
            let v1 = 0x2::table::borrow_mut<address, vector<LockedUserProfit>>(&mut arg2.user_profits, arg3);
            let v2 = find_locked_profit_(v1, v0, arg4, arg5);
            assert!(v2 < 0x1::vector::length<LockedUserProfit>(v1), 0);
            let v3 = 0x1::vector::remove<LockedUserProfit>(v1, v2);
            assert!(v0 == v3.user_profit.collateral_token, 8);
            if (0x2::table::contains<address, vector<UserProfit>>(&arg1.user_profits, arg3)) {
                0x1::vector::push_back<UserProfit>(0x2::table::borrow_mut<address, vector<UserProfit>>(&mut arg1.user_profits, arg3), v3.user_profit);
            } else {
                let v4 = 0x1::vector::empty<UserProfit>();
                0x1::vector::push_back<UserProfit>(&mut v4, v3.user_profit);
                0x2::table::add<address, vector<UserProfit>>(&mut arg1.user_profits, arg3, v4);
            };
            if (0x2::dynamic_field::exists_<0x1::type_name::TypeName>(&arg1.id, v0)) {
                0x2::balance::join<T0>(0x2::dynamic_field::borrow_mut<0x1::type_name::TypeName, 0x2::balance::Balance<T0>>(&mut arg1.id, v0), 0x2::balance::split<T0>(0x2::dynamic_field::borrow_mut<0x1::type_name::TypeName, 0x2::balance::Balance<T0>>(&mut arg2.id, v0), v3.user_profit.amount));
            } else {
                0x2::dynamic_field::add<0x1::type_name::TypeName, 0x2::balance::Balance<T0>>(&mut arg1.id, v0, 0x2::balance::split<T0>(0x2::dynamic_field::borrow_mut<0x1::type_name::TypeName, 0x2::balance::Balance<T0>>(&mut arg2.id, v0), v3.user_profit.amount));
            };
            if (0x1::vector::length<LockedUserProfit>(v1) == 0) {
                0x2::table::remove<address, vector<LockedUserProfit>>(&mut arg2.user_profits, arg3);
            };
            let v5 = UnlockUserProfitEvent{
                user        : arg3,
                user_profit : v3.user_profit,
            };
            0x2::event::emit<UnlockUserProfitEvent>(v5);
        };
    }

    entry fun update_unlock_countdown_ts_ms(arg0: &0xd29b520a538a13a7b4b75ea5ce27ef26defaf25f084a7c00f6adf9865cc851c8::admin::Version, arg1: &mut ProfitVault, arg2: u64, arg3: &0x2::tx_context::TxContext) {
        0xe4609a2febbdbce610b32ffc9465653015ea09fbcdc6460302957672597057a1::core_admin::verify(arg0, arg3);
        let v0 = 0x1::vector::empty<0x2::object::ID>();
        0x1::vector::push_back<0x2::object::ID>(&mut v0, 0x2::object::id<ProfitVault>(arg1));
        let v1 = 0x1::vector::empty<u64>();
        let v2 = &mut v1;
        0x1::vector::push_back<u64>(v2, arg1.unlock_countdown_ts_ms);
        0x1::vector::push_back<u64>(v2, arg2);
        0xe4609a2febbdbce610b32ffc9465653015ea09fbcdc6460302957672597057a1::core_admin::emit_admin_event(3, 1, 0, 0x1::vector::empty<0x1::type_name::TypeName>(), v0, v1, arg3);
        arg1.unlock_countdown_ts_ms = arg2;
    }

    public fun withdraw_profit<T0>(arg0: &0xd29b520a538a13a7b4b75ea5ce27ef26defaf25f084a7c00f6adf9865cc851c8::admin::Version, arg1: &mut ProfitVault, arg2: &0x2::clock::Clock, arg3: &mut 0x2::tx_context::TxContext) : 0x2::balance::Balance<T0> {
        0xe4609a2febbdbce610b32ffc9465653015ea09fbcdc6460302957672597057a1::core_admin::version_check(arg0);
        let v0 = 0x1::type_name::with_defining_ids<T0>();
        let v1 = 0x2::tx_context::sender(arg3);
        let v2 = 0;
        let v3 = 0x1::vector::empty<UserProfit>();
        let v4 = if (0x2::table::contains<address, vector<UserProfit>>(&arg1.user_profits, v1)) {
            let v5 = 0x2::table::remove<address, vector<UserProfit>>(&mut arg1.user_profits, v1);
            0x1::vector::reverse<UserProfit>(&mut v5);
            while (0x1::vector::length<UserProfit>(&v5) > 0) {
                let v6 = 0x1::vector::pop_back<UserProfit>(&mut v5);
                if (v6.collateral_token == v0 && 0x2::clock::timestamp_ms(arg2) >= v6.create_ts_ms + arg1.unlock_countdown_ts_ms) {
                    v2 = v2 + v6.amount;
                    continue
                };
                0x1::vector::push_back<UserProfit>(&mut v3, v6);
            };
            if (0x1::vector::length<UserProfit>(&v3) > 0) {
                0x2::table::add<address, vector<UserProfit>>(&mut arg1.user_profits, v1, v3);
            };
            if (v2 > 0) {
                0x2::balance::split<T0>(0x2::dynamic_field::borrow_mut<0x1::type_name::TypeName, 0x2::balance::Balance<T0>>(&mut arg1.id, v0), v2)
            } else {
                0x2::balance::zero<T0>()
            }
        } else {
            0x2::balance::zero<T0>()
        };
        let v7 = v4;
        let v8 = WithdrawProfitEvent{
            token_type      : v0,
            withdraw_amount : 0x2::balance::value<T0>(&v7),
        };
        0x2::event::emit<WithdrawProfitEvent>(v8);
        v7
    }

    // decompiled from Move bytecode v7
}

