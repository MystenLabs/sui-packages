module 0x1a75d4df4c66ba0a4629b949dbc94b12c300b72bced2694e28e9eb73684e4461::lock_lp {
    struct LPData has store, key {
        id: 0x2::object::UID,
        admin: address,
        lp_to_pid: 0x2::table::Table<0x1::string::String, u64>,
        lps: vector<0x1::string::String>,
        pool_info: vector<PoolInfo>,
        current_locked_id: u64,
    }

    struct PoolUsers has store, key {
        id: 0x2::object::UID,
        total_users: u64,
    }

    struct PoolUserInfo has store, key {
        id: 0x2::object::UID,
        pids: vector<u64>,
    }

    struct UserInfo has store, key {
        id: 0x2::object::UID,
        total_amount: u128,
        items: 0x2::vec_map::VecMap<u64, LockedLpItem>,
    }

    struct LockedLpItem has drop, store {
        pool_id: u64,
        locked_amout: u64,
        duration: u64,
        locked_until: u64,
        start_time: u64,
    }

    struct PoolInfo has store {
        total_pool_amount: u128,
        total_number_loked: u64,
        last_time_locked: u64,
        lp_type: 0x1::string::String,
        average_locked_time: u64,
        total_locked_duration: u64,
    }

    struct LPLocked has store, key {
        id: 0x2::object::UID,
    }

    struct LPLockedItem<phantom T0> has store, key {
        id: 0x2::object::UID,
        coin_lp: 0x2::balance::Balance<T0>,
    }

    struct DepositEvent has copy, drop, store {
        user: address,
        pid: u64,
        locked_id: u64,
        amount: u64,
    }

    struct WithdrawEvent has copy, drop, store {
        user: address,
        pid: u64,
        locked_lp_id: u64,
        amount: u64,
        withdraw_time: u64,
    }

    struct AddPoolEvent has copy, drop, store {
        pid: u64,
        lp: 0x1::string::String,
    }

    public entry fun add_pool<T0>(arg0: &mut LPData, arg1: &mut LPLocked, arg2: &mut 0x2::tx_context::TxContext) {
        let v0 = 0x1a75d4df4c66ba0a4629b949dbc94b12c300b72bced2694e28e9eb73684e4461::utils::get_token_name<T0>();
        assert!(0x2::tx_context::sender(arg2) == arg0.admin, 0);
        assert!(!0x2::table::contains<0x1::string::String, u64>(&arg0.lp_to_pid, v0), 3);
        let v1 = 0x2::table::length<0x1::string::String, u64>(&arg0.lp_to_pid);
        0x2::table::add<0x1::string::String, u64>(&mut arg0.lp_to_pid, v0, v1);
        0x1::vector::push_back<0x1::string::String>(&mut arg0.lps, v0);
        let v2 = PoolInfo{
            total_pool_amount     : 0,
            total_number_loked    : 0,
            last_time_locked      : 0,
            lp_type               : v0,
            average_locked_time   : 0,
            total_locked_duration : 0,
        };
        0x1::vector::push_back<PoolInfo>(&mut arg0.pool_info, v2);
        let v3 = LPLockedItem<T0>{
            id      : 0x2::object::new(arg2),
            coin_lp : 0x2::balance::zero<T0>(),
        };
        0x2::dynamic_object_field::add<0x1::string::String, LPLockedItem<T0>>(&mut arg1.id, v0, v3);
        let v4 = AddPoolEvent{
            pid : v1,
            lp  : v0,
        };
        0x2::event::emit<AddPoolEvent>(v4);
    }

    public entry fun deposit<T0, T1, T2>(arg0: &mut LPData, arg1: &mut PoolUsers, arg2: &mut LPLocked, arg3: u64, arg4: 0x2::coin::Coin<T0>, arg5: u64, arg6: &0x2::clock::Clock, arg7: &mut 0x2::tx_context::TxContext) {
        let v0 = 0x2::tx_context::sender(arg7);
        let v1 = 0x1a75d4df4c66ba0a4629b949dbc94b12c300b72bced2694e28e9eb73684e4461::utils::get_token_name<T0>();
        let v2 = 0x2::clock::timestamp_ms(arg6);
        let v3 = arg0.current_locked_id + 1;
        assert!(arg3 == 0x2::coin::value<T0>(&arg4) && 0x2::coin::value<T0>(&arg4) > 0, 13);
        assert!(0x2::table::contains<0x1::string::String, u64>(&arg0.lp_to_pid, v1), 2);
        let v4 = *0x2::table::borrow<0x1::string::String, u64>(&arg0.lp_to_pid, v1);
        if (!0x2::dynamic_object_field::exists_with_type<address, PoolUserInfo>(&mut arg1.id, v0)) {
            let v5 = PoolUserInfo{
                id   : 0x2::object::new(arg7),
                pids : 0x1::vector::empty<u64>(),
            };
            0x2::dynamic_object_field::add<address, PoolUserInfo>(&mut arg1.id, v0, v5);
            arg1.total_users = arg1.total_users + 1;
        };
        let v6 = 0x2::dynamic_object_field::borrow_mut<address, PoolUserInfo>(&mut arg1.id, v0);
        if (!0x2::dynamic_object_field::exists_with_type<u64, UserInfo>(&v6.id, v4)) {
            let v7 = UserInfo{
                id           : 0x2::object::new(arg7),
                total_amount : 0,
                items        : 0x2::vec_map::empty<u64, LockedLpItem>(),
            };
            0x2::dynamic_object_field::add<u64, UserInfo>(&mut v6.id, v4, v7);
            0x1::vector::push_back<u64>(&mut v6.pids, v4);
        };
        let v8 = 0x2::dynamic_object_field::borrow_mut<u64, UserInfo>(&mut v6.id, v4);
        let v9 = 0x1::vector::borrow_mut<PoolInfo>(&mut arg0.pool_info, v4);
        0x2::balance::join<T0>(&mut 0x2::dynamic_object_field::borrow_mut<0x1::string::String, LPLockedItem<T0>>(&mut arg2.id, v1).coin_lp, 0x2::coin::into_balance<T0>(arg4));
        v8.total_amount = v8.total_amount + (arg3 as u128);
        let v10 = LockedLpItem{
            pool_id      : v4,
            locked_amout : arg3,
            duration     : arg5,
            locked_until : v2 + arg5,
            start_time   : v2,
        };
        0x2::vec_map::insert<u64, LockedLpItem>(&mut v8.items, v3, v10);
        v9.total_pool_amount = v9.total_pool_amount + (arg3 as u128);
        v9.total_number_loked = v9.total_number_loked + 1;
        v9.last_time_locked = v2;
        v9.total_locked_duration = v9.total_locked_duration + arg5;
        v9.average_locked_time = v9.total_locked_duration / v9.total_number_loked;
        arg0.current_locked_id = v3;
        let v11 = DepositEvent{
            user      : v0,
            pid       : v4,
            locked_id : v3,
            amount    : arg3,
        };
        0x2::event::emit<DepositEvent>(v11);
    }

    fun init(arg0: &mut 0x2::tx_context::TxContext) {
        let v0 = LPData{
            id                : 0x2::object::new(arg0),
            admin             : @0x49cc391ab4d3503e03dbb24c4f9e28f3cdd2ddf8a459e0d43012c3868ffefa1,
            lp_to_pid         : 0x2::table::new<0x1::string::String, u64>(arg0),
            lps               : 0x1::vector::empty<0x1::string::String>(),
            pool_info         : 0x1::vector::empty<PoolInfo>(),
            current_locked_id : 0,
        };
        0x2::transfer::public_share_object<LPData>(v0);
        let v1 = PoolUsers{
            id          : 0x2::object::new(arg0),
            total_users : 0,
        };
        0x2::transfer::public_share_object<PoolUsers>(v1);
        let v2 = LPLocked{id: 0x2::object::new(arg0)};
        0x2::transfer::public_share_object<LPLocked>(v2);
    }

    public fun pool_length(arg0: &mut LPData) : u64 {
        0x2::table::length<0x1::string::String, u64>(&arg0.lp_to_pid)
    }

    public entry fun set_admin(arg0: &mut LPData, arg1: address, arg2: &mut 0x2::tx_context::TxContext) {
        assert!(arg1 != @0x0, 11);
        assert!(0x2::tx_context::sender(arg2) == arg0.admin, 0);
        arg0.admin = arg1;
    }

    public entry fun withdraw<T0, T1, T2>(arg0: &mut LPData, arg1: &mut PoolUsers, arg2: &mut LPLocked, arg3: u64, arg4: &0x2::clock::Clock, arg5: &mut 0x2::tx_context::TxContext) {
        let v0 = 0x1a75d4df4c66ba0a4629b949dbc94b12c300b72bced2694e28e9eb73684e4461::utils::get_token_name<T0>();
        let v1 = 0x2::clock::timestamp_ms(arg4);
        assert!(0x2::table::contains<0x1::string::String, u64>(&arg0.lp_to_pid, v0), 2);
        let v2 = 0x2::tx_context::sender(arg5);
        let v3 = *0x2::table::borrow<0x1::string::String, u64>(&arg0.lp_to_pid, v0);
        let v4 = 0x2::dynamic_object_field::borrow_mut<u64, UserInfo>(&mut 0x2::dynamic_object_field::borrow_mut<address, PoolUserInfo>(&mut arg1.id, v2).id, v3);
        let (_, v6) = 0x2::vec_map::remove<u64, LockedLpItem>(&mut v4.items, &arg3);
        let v7 = v6;
        assert!(v4.total_amount >= (v7.locked_amout as u128), 4);
        assert!(v1 > v7.locked_until, 14);
        let v8 = 0x1::vector::borrow_mut<PoolInfo>(&mut arg0.pool_info, v3);
        v4.total_amount = v4.total_amount - (v7.locked_amout as u128);
        0x2::transfer::public_transfer<0x2::coin::Coin<T0>>(0x2::coin::from_balance<T0>(0x2::balance::split<T0>(&mut 0x2::dynamic_object_field::borrow_mut<0x1::string::String, LPLockedItem<T0>>(&mut arg2.id, v0).coin_lp, v7.locked_amout), arg5), v2);
        v8.total_pool_amount = v8.total_pool_amount - (v7.locked_amout as u128);
        v8.total_number_loked = v8.total_number_loked - 1;
        v8.total_locked_duration = v8.total_locked_duration - v7.duration;
        v8.average_locked_time = v8.total_locked_duration / v8.total_number_loked;
        let v9 = WithdrawEvent{
            user          : v2,
            pid           : v3,
            locked_lp_id  : arg3,
            amount        : v7.locked_amout,
            withdraw_time : v1,
        };
        0x2::event::emit<WithdrawEvent>(v9);
    }

    // decompiled from Move bytecode v6
}

