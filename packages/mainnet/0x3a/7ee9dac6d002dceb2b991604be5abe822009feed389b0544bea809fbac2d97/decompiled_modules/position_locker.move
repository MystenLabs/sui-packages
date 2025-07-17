module 0x3a7ee9dac6d002dceb2b991604be5abe822009feed389b0544bea809fbac2d97::position_locker {
    struct PositionLocker has key {
        id: 0x2::object::UID,
        next_lock_id: u64,
        admin: address,
        pending_admin: 0x1::option::Option<address>,
        fee_receiver: address,
        vaults: 0x2::table::Table<u64, 0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::position::Position>,
        locks: 0x2::table::Table<u64, LockInfo>,
        user_locks: 0x2::table::Table<address, 0x2::vec_set::VecSet<u64>>,
        fees: 0x2::vec_map::VecMap<vector<u8>, FeeStruct>,
        custom_user_fees: 0x2::table::Table<address, FeeStruct>,
    }

    struct LockInfo has drop, store {
        lock_id: u64,
        position_id: 0x2::object::ID,
        owner: address,
        pending_owner: 0x1::option::Option<address>,
        collector: address,
        collect_fee: u64,
        lp_fee: u64,
        liquidity: u128,
        start_time: u64,
        unlock_time: u64,
    }

    struct FeeStruct has drop, store {
        name: 0x1::ascii::String,
        lp_fee: u64,
        collect_fee: u64,
        lock_fee: u64,
        lock_fee_coin_type: 0x1::ascii::String,
    }

    struct OnLockEvent has copy, drop {
        lock_id: u64,
        owner: address,
        position_id: 0x2::object::ID,
        liquidity: u128,
        start_time: u64,
        unlock_time: u64,
    }

    struct OnUnlockEvent has copy, drop {
        lock_id: u64,
        owner: address,
        position_id: 0x2::object::ID,
        liquidity: u128,
        unlocked_time: u64,
    }

    struct OnTransferLockEvent has copy, drop {
        lock_id: u64,
        current_owner: address,
        pending_owner: address,
    }

    struct OnAcceptLockEvent has copy, drop {
        lock_id: u64,
        original_owner: address,
        new_owner: address,
    }

    struct OnIncreaseLiquidityEvent has copy, drop {
        lock_id: u64,
        position_id: 0x2::object::ID,
        previous_liquidity: u128,
        new_liquidity: u128,
        amount_a: u64,
        amount_b: u64,
    }

    struct OnDecreaseLiquidityEvent has copy, drop {
        lock_id: u64,
        position_id: 0x2::object::ID,
        previous_liquidity: u128,
        new_liquidity: u128,
        amount_a: u64,
        amount_b: u64,
    }

    struct OnRelockEvent has copy, drop {
        lock_id: u64,
        original_unlock_time: u64,
        new_unlock_time: u64,
    }

    struct OnSetCollectorEvent has copy, drop {
        lock_id: u64,
        original_collector: address,
        new_collector: address,
    }

    struct OnCollectFeeEvent has copy, drop {
        lock_id: u64,
        collector: address,
        recipient: address,
        amount_a: u64,
        amount_b: u64,
        collect_fee_a: u64,
        collect_fee_b: u64,
    }

    struct OnAddFeeEvent has copy, drop {
        name: 0x1::ascii::String,
        lp_fee: u64,
        collect_fee: u64,
        lock_fee: u64,
        lock_fee_coin_type: 0x1::ascii::String,
    }

    struct OnUpdateFeeEvent has copy, drop {
        name: 0x1::ascii::String,
        lp_fee: u64,
        collect_fee: u64,
        lock_fee: u64,
        lock_fee_coin_type: 0x1::ascii::String,
    }

    struct OnRemoveFeeEvent has copy, drop {
        name: 0x1::ascii::String,
        lp_fee: u64,
        collect_fee: u64,
        lock_fee: u64,
        lock_fee_coin_type: 0x1::ascii::String,
    }

    struct OnSetCustomFeeEvent has copy, drop {
        user: address,
        name: 0x1::ascii::String,
        lp_fee: u64,
        collect_fee: u64,
        lock_fee: u64,
        lock_fee_coin_type: 0x1::ascii::String,
    }

    struct OnUpdateCustomFeeEvent has copy, drop {
        user: address,
        name: 0x1::ascii::String,
        lp_fee: u64,
        collect_fee: u64,
        lock_fee: u64,
        lock_fee_coin_type: 0x1::ascii::String,
    }

    struct OnRemoveCustomFeeEvent has copy, drop {
        user: address,
        name: 0x1::ascii::String,
        lp_fee: u64,
        collect_fee: u64,
        lock_fee: u64,
        lock_fee_coin_type: 0x1::ascii::String,
    }

    struct OnUpdateFeeReceiverEvent has copy, drop {
        original_receiver: address,
        new_receiver: address,
    }

    struct OnTransferAdminEvent has copy, drop {
        current_admin: address,
        pending_admin: address,
    }

    struct OnAcceptAdminEvent has copy, drop {
        original_admin: address,
        new_admin: address,
    }

    public entry fun accept_admin(arg0: &mut PositionLocker, arg1: &0x2::tx_context::TxContext) {
        let v0 = 0x2::tx_context::sender(arg1);
        assert!(0x1::option::contains<address>(&arg0.pending_admin, &v0), 3);
        let v1 = OnAcceptAdminEvent{
            original_admin : arg0.admin,
            new_admin      : v0,
        };
        0x2::event::emit<OnAcceptAdminEvent>(v1);
        arg0.admin = v0;
        arg0.pending_admin = 0x1::option::none<address>();
    }

    public entry fun accept_lock(arg0: &mut PositionLocker, arg1: u64, arg2: &0x2::tx_context::TxContext) {
        assert!(0x2::table::contains<u64, LockInfo>(&arg0.locks, arg1) && 0x2::table::contains<u64, 0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::position::Position>(&arg0.vaults, arg1), 1);
        let v0 = 0x2::tx_context::sender(arg2);
        let v1 = 0x2::table::borrow_mut<u64, LockInfo>(&mut arg0.locks, arg1);
        assert!(0x1::option::contains<address>(&v1.pending_owner, &v0), 5);
        let v2 = OnAcceptLockEvent{
            lock_id        : arg1,
            original_owner : v1.owner,
            new_owner      : v0,
        };
        0x2::event::emit<OnAcceptLockEvent>(v2);
        let v3 = &mut arg0.user_locks;
        remove_user_lock(v3, v1.owner, arg1);
        let v4 = &mut arg0.user_locks;
        add_user_lock(v4, v0, arg1);
        v1.owner = v0;
        v1.pending_owner = 0x1::option::none<address>();
    }

    public entry fun add_or_update_fee<T0>(arg0: &mut PositionLocker, arg1: 0x1::ascii::String, arg2: u64, arg3: u64, arg4: u64, arg5: &0x2::tx_context::TxContext) {
        assert!(0x2::tx_context::sender(arg5) == arg0.admin, 2);
        let v0 = &mut arg0.fees;
        add_or_update_fee_internal(v0, arg1, arg2, arg3, arg4, 0x1::type_name::into_string(0x1::type_name::get<T0>()));
    }

    fun add_or_update_fee_internal(arg0: &mut 0x2::vec_map::VecMap<vector<u8>, FeeStruct>, arg1: 0x1::ascii::String, arg2: u64, arg3: u64, arg4: u64, arg5: 0x1::ascii::String) {
        let v0 = 0x2::hash::keccak256(0x1::ascii::as_bytes(&arg1));
        if (0x2::vec_map::contains<vector<u8>, FeeStruct>(arg0, &v0)) {
            let v1 = 0x2::vec_map::get_mut<vector<u8>, FeeStruct>(arg0, &v0);
            v1.lp_fee = arg2;
            v1.collect_fee = arg3;
            v1.lock_fee = arg4;
            v1.lock_fee_coin_type = arg5;
            let v2 = OnUpdateFeeEvent{
                name               : arg1,
                lp_fee             : arg2,
                collect_fee        : arg3,
                lock_fee           : arg4,
                lock_fee_coin_type : arg5,
            };
            0x2::event::emit<OnUpdateFeeEvent>(v2);
        } else {
            let v3 = FeeStruct{
                name               : arg1,
                lp_fee             : arg2,
                collect_fee        : arg3,
                lock_fee           : arg4,
                lock_fee_coin_type : arg5,
            };
            0x2::vec_map::insert<vector<u8>, FeeStruct>(arg0, v0, v3);
            let v4 = OnAddFeeEvent{
                name               : arg1,
                lp_fee             : arg2,
                collect_fee        : arg3,
                lock_fee           : arg4,
                lock_fee_coin_type : arg5,
            };
            0x2::event::emit<OnAddFeeEvent>(v4);
        };
    }

    fun add_user_lock(arg0: &mut 0x2::table::Table<address, 0x2::vec_set::VecSet<u64>>, arg1: address, arg2: u64) {
        if (!0x2::table::contains<address, 0x2::vec_set::VecSet<u64>>(arg0, arg1)) {
            0x2::table::add<address, 0x2::vec_set::VecSet<u64>>(arg0, arg1, 0x2::vec_set::empty<u64>());
        };
        let v0 = 0x2::table::borrow_mut<address, 0x2::vec_set::VecSet<u64>>(arg0, arg1);
        if (!0x2::vec_set::contains<u64>(v0, &arg2)) {
            0x2::vec_set::insert<u64>(v0, arg2);
        };
    }

    public entry fun collect_fees<T0, T1>(arg0: &mut PositionLocker, arg1: &0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::config::GlobalConfig, arg2: &mut 0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool::Pool<T0, T1>, arg3: u64, arg4: address, arg5: &mut 0x2::tx_context::TxContext) {
        assert!(0x2::table::contains<u64, LockInfo>(&arg0.locks, arg3) && 0x2::table::contains<u64, 0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::position::Position>(&arg0.vaults, arg3), 1);
        let v0 = 0x2::tx_context::sender(arg5);
        let v1 = 0x2::table::borrow<u64, LockInfo>(&arg0.locks, arg3);
        assert!(v1.owner == v0 || v1.collector == v0, 7);
        let v2 = 0x2::table::borrow<u64, 0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::position::Position>(&arg0.vaults, arg3);
        assert!(0x2::object::id<0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool::Pool<T0, T1>>(arg2) == 0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::position::pool_id(v2), 15);
        let (v3, v4) = 0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool::collect_fee<T0, T1>(arg1, arg2, v2, true);
        let v5 = v4;
        let v6 = v3;
        assert!(0x2::balance::value<T0>(&v6) > 0 || 0x2::balance::value<T1>(&v5) > 0, 17);
        let v7 = 0x2::balance::value<T0>(&v6);
        let v8 = 0x2::balance::value<T1>(&v5);
        let v9 = v7 * v1.collect_fee / 10000;
        let v10 = v8 * v1.collect_fee / 10000;
        let v11 = 0x2::coin::from_balance<T0>(v6, arg5);
        let v12 = 0x2::coin::from_balance<T1>(v5, arg5);
        0x2::transfer::public_transfer<0x2::coin::Coin<T0>>(v11, arg4);
        0x2::transfer::public_transfer<0x2::coin::Coin<T1>>(v12, arg4);
        0x2::transfer::public_transfer<0x2::coin::Coin<T0>>(0x2::coin::split<T0>(&mut v11, v9, arg5), arg0.fee_receiver);
        0x2::transfer::public_transfer<0x2::coin::Coin<T1>>(0x2::coin::split<T1>(&mut v12, v10, arg5), arg0.fee_receiver);
        let v13 = OnCollectFeeEvent{
            lock_id       : arg3,
            collector     : v0,
            recipient     : arg4,
            amount_a      : v7 - v9,
            amount_b      : v8 - v10,
            collect_fee_a : v9,
            collect_fee_b : v10,
        };
        0x2::event::emit<OnCollectFeeEvent>(v13);
    }

    public entry fun decrease_liquidity<T0, T1>(arg0: &mut PositionLocker, arg1: &0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::config::GlobalConfig, arg2: &mut 0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool::Pool<T0, T1>, arg3: u64, arg4: u128, arg5: &0x2::clock::Clock, arg6: &mut 0x2::tx_context::TxContext) : (u64, u64) {
        assert!(0x2::table::contains<u64, LockInfo>(&arg0.locks, arg3) && 0x2::table::contains<u64, 0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::position::Position>(&arg0.vaults, arg3), 1);
        let v0 = 0x2::table::borrow_mut<u64, 0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::position::Position>(&mut arg0.vaults, arg3);
        let v1 = 0x2::table::borrow_mut<u64, LockInfo>(&mut arg0.locks, arg3);
        assert!(v1.owner == 0x2::tx_context::sender(arg6), 4);
        let v2 = v1.liquidity;
        assert!(arg4 > 0 && arg4 <= v2, 19);
        assert!(v1.unlock_time < 0x2::clock::timestamp_ms(arg5), 9);
        assert!(0x2::object::id<0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool::Pool<T0, T1>>(arg2) == 0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::position::pool_id(v0), 15);
        let (v3, v4) = 0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool::remove_liquidity<T0, T1>(arg1, arg2, v0, arg4, arg5);
        let v5 = v4;
        let v6 = v3;
        let v7 = 0x2::balance::value<T0>(&v6);
        let v8 = 0x2::balance::value<T1>(&v5);
        0x2::transfer::public_transfer<0x2::coin::Coin<T0>>(0x2::coin::from_balance<T0>(v6, arg6), v1.owner);
        0x2::transfer::public_transfer<0x2::coin::Coin<T1>>(0x2::coin::from_balance<T1>(v5, arg6), v1.owner);
        let v9 = 0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::position::liquidity(v0);
        assert!(v9 + arg4 == v2, 19);
        v1.liquidity = v9;
        let v10 = OnDecreaseLiquidityEvent{
            lock_id            : arg3,
            position_id        : v1.position_id,
            previous_liquidity : v2,
            new_liquidity      : v9,
            amount_a           : v7,
            amount_b           : v8,
        };
        0x2::event::emit<OnDecreaseLiquidityEvent>(v10);
        (v7, v8)
    }

    public entry fun get_fee(arg0: &PositionLocker, arg1: address, arg2: 0x1::ascii::String) : (u64, u64, u64, 0x1::ascii::String) {
        if (arg1 != @0x0 && 0x2::table::contains<address, FeeStruct>(&arg0.custom_user_fees, arg1)) {
            let v4 = 0x2::table::borrow<address, FeeStruct>(&arg0.custom_user_fees, arg1);
            (v4.lp_fee, v4.collect_fee, v4.lock_fee, v4.lock_fee_coin_type)
        } else {
            let v5 = 0x2::hash::keccak256(0x1::ascii::as_bytes(&arg2));
            if (!0x2::vec_map::contains<vector<u8>, FeeStruct>(&arg0.fees, &v5)) {
                let v6 = 0x1::ascii::string(b"DEFAULT");
                v5 = 0x2::hash::keccak256(0x1::ascii::as_bytes(&v6));
            };
            let v7 = 0x2::vec_map::get<vector<u8>, FeeStruct>(&arg0.fees, &v5);
            (v7.lp_fee, v7.collect_fee, v7.lock_fee, v7.lock_fee_coin_type)
        }
    }

    public entry fun get_lock_info(arg0: &PositionLocker, arg1: u64) : (address, address, address, u128, u64, u64, u64, u64) {
        assert!(0x2::table::contains<u64, LockInfo>(&arg0.locks, arg1), 1);
        let v0 = 0x2::table::borrow<u64, LockInfo>(&arg0.locks, arg1);
        (v0.owner, 0x1::option::get_with_default<address>(&v0.pending_owner, @0x0), v0.collector, v0.liquidity, v0.collect_fee, v0.lp_fee, v0.start_time, v0.unlock_time)
    }

    public entry fun get_user_locks(arg0: &PositionLocker, arg1: address) : (vector<u64>, u64) {
        if (0x2::table::contains<address, 0x2::vec_set::VecSet<u64>>(&arg0.user_locks, arg1)) {
            let v2 = 0x2::table::borrow<address, 0x2::vec_set::VecSet<u64>>(&arg0.user_locks, arg1);
            (0x2::vec_set::into_keys<u64>(*v2), 0x2::vec_set::size<u64>(v2))
        } else {
            (0x1::vector::empty<u64>(), 0)
        }
    }

    public entry fun increase_liquidity<T0, T1>(arg0: &mut PositionLocker, arg1: &0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::config::GlobalConfig, arg2: &mut 0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool::Pool<T0, T1>, arg3: u64, arg4: 0x2::coin::Coin<T0>, arg5: 0x2::coin::Coin<T1>, arg6: u128, arg7: &0x2::clock::Clock, arg8: &mut 0x2::tx_context::TxContext) : (u64, u64) {
        assert!(0x2::table::contains<u64, LockInfo>(&arg0.locks, arg3) && 0x2::table::contains<u64, 0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::position::Position>(&arg0.vaults, arg3), 1);
        let v0 = 0x2::tx_context::sender(arg8);
        let v1 = 0x2::table::borrow_mut<u64, LockInfo>(&mut arg0.locks, arg3);
        assert!(v1.owner == v0, 4);
        let v2 = 0x2::table::borrow_mut<u64, 0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::position::Position>(&mut arg0.vaults, arg3);
        assert!(0x2::object::id<0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool::Pool<T0, T1>>(arg2) == 0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::position::pool_id(v2), 15);
        let v3 = arg6 * ((10000 - v1.lp_fee) as u128) / (10000 as u128);
        let v4 = v1.liquidity;
        let v5 = 0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool::add_liquidity<T0, T1>(arg1, arg2, v2, v3, arg7);
        let v6 = 0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::position::liquidity(v2);
        assert!(v4 + v3 == v6, 19);
        v1.liquidity = v6;
        let (v7, v8) = 0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool::add_liquidity_pay_amount<T0, T1>(&v5);
        let v9 = v7 * v1.lp_fee / 10000;
        let v10 = v8 * v1.lp_fee / 10000;
        assert!(0x2::coin::value<T0>(&arg4) >= v7 + v9 && 0x2::coin::value<T1>(&arg5) >= v8 + v10, 18);
        0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool::repay_add_liquidity<T0, T1>(arg1, arg2, 0x2::coin::into_balance<T0>(0x2::coin::split<T0>(&mut arg4, v7, arg8)), 0x2::coin::into_balance<T1>(0x2::coin::split<T1>(&mut arg5, v8, arg8)), v5);
        if (v9 > 0) {
            if (0x2::coin::value<T0>(&arg4) == v9) {
                0x2::transfer::public_transfer<0x2::coin::Coin<T0>>(arg4, arg0.fee_receiver);
            } else {
                0x2::transfer::public_transfer<0x2::coin::Coin<T0>>(0x2::coin::split<T0>(&mut arg4, v9, arg8), arg0.fee_receiver);
                0x2::transfer::public_transfer<0x2::coin::Coin<T0>>(arg4, v0);
            };
        } else {
            0x2::transfer::public_transfer<0x2::coin::Coin<T0>>(arg4, v0);
        };
        if (v10 > 0) {
            if (0x2::coin::value<T1>(&arg5) == v10) {
                0x2::transfer::public_transfer<0x2::coin::Coin<T1>>(arg5, arg0.fee_receiver);
            } else {
                0x2::transfer::public_transfer<0x2::coin::Coin<T1>>(0x2::coin::split<T1>(&mut arg5, v10, arg8), arg0.fee_receiver);
                0x2::transfer::public_transfer<0x2::coin::Coin<T1>>(arg5, v0);
            };
        } else {
            0x2::transfer::public_transfer<0x2::coin::Coin<T1>>(arg5, v0);
        };
        let v11 = OnIncreaseLiquidityEvent{
            lock_id            : arg3,
            position_id        : v1.position_id,
            previous_liquidity : v4,
            new_liquidity      : v6,
            amount_a           : v7,
            amount_b           : v8,
        };
        0x2::event::emit<OnIncreaseLiquidityEvent>(v11);
        (v7, v8)
    }

    fun init(arg0: &mut 0x2::tx_context::TxContext) {
        let v0 = PositionLocker{
            id               : 0x2::object::new(arg0),
            next_lock_id     : 1,
            admin            : @0x665e4337f39aad6de7252b16442088cbb5d1b4152fd2820a14d6aa1dfc46abde,
            pending_admin    : 0x1::option::none<address>(),
            fee_receiver     : @0x665e4337f39aad6de7252b16442088cbb5d1b4152fd2820a14d6aa1dfc46abde,
            vaults           : 0x2::table::new<u64, 0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::position::Position>(arg0),
            locks            : 0x2::table::new<u64, LockInfo>(arg0),
            user_locks       : 0x2::table::new<address, 0x2::vec_set::VecSet<u64>>(arg0),
            fees             : 0x2::vec_map::empty<vector<u8>, FeeStruct>(),
            custom_user_fees : 0x2::table::new<address, FeeStruct>(arg0),
        };
        let v1 = &mut v0.fees;
        add_or_update_fee_internal(v1, 0x1::ascii::string(b"DEFAULT"), 50, 200, 0, 0x1::type_name::into_string(0x1::type_name::get<0x2::sui::SUI>()));
        0x2::transfer::share_object<PositionLocker>(v0);
    }

    public entry fun is_locked(arg0: &PositionLocker, arg1: u64, arg2: &0x2::clock::Clock) : bool {
        if (!0x2::table::contains<u64, LockInfo>(&arg0.locks, arg1)) {
            false
        } else {
            let v1 = 0x2::table::borrow<u64, 0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::position::Position>(&arg0.vaults, arg1);
            0x2::table::borrow<u64, LockInfo>(&arg0.locks, arg1).unlock_time > 0x2::clock::timestamp_ms(arg2) && 0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::position::liquidity(v1) > 0
        }
    }

    public entry fun is_supported_fee_name(arg0: &PositionLocker, arg1: 0x1::ascii::String) : bool {
        let v0 = 0x2::hash::keccak256(0x1::ascii::as_bytes(&arg1));
        0x2::vec_map::contains<vector<u8>, FeeStruct>(&arg0.fees, &v0)
    }

    public entry fun lock_position<T0, T1, T2>(arg0: &mut PositionLocker, arg1: &0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::config::GlobalConfig, arg2: &mut 0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool::Pool<T0, T1>, arg3: 0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::position::Position, arg4: address, arg5: u64, arg6: 0x1::ascii::String, arg7: 0x2::coin::Coin<T2>, arg8: &0x2::clock::Clock, arg9: &mut 0x2::tx_context::TxContext) : u64 {
        let v0 = 0x2::tx_context::sender(arg9);
        assert!(0x2::object::id<0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool::Pool<T0, T1>>(arg2) == 0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::position::pool_id(&arg3), 15);
        assert!(arg4 != @0x0, 6);
        let v1 = 0x2::clock::timestamp_ms(arg8);
        assert!(arg5 > v1, 10);
        let v2 = 0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::position::liquidity(&arg3);
        assert!(v2 > 0, 20);
        let (v3, v4, v5, v6) = get_fee(arg0, v0, arg6);
        if (v5 > 0) {
            assert!(v6 == 0x1::type_name::into_string(0x1::type_name::get<T2>()), 16);
            assert!(0x2::coin::value<T2>(&arg7) >= v5, 13);
            if (0x2::coin::value<T2>(&arg7) == v5) {
                0x2::transfer::public_transfer<0x2::coin::Coin<T2>>(arg7, arg0.fee_receiver);
            } else {
                0x2::transfer::public_transfer<0x2::coin::Coin<T2>>(0x2::coin::split<T2>(&mut arg7, v5, arg9), arg0.fee_receiver);
                0x2::transfer::public_transfer<0x2::coin::Coin<T2>>(arg7, v0);
            };
        } else {
            0x2::transfer::public_transfer<0x2::coin::Coin<T2>>(arg7, v0);
        };
        let v7 = v2 * (v3 as u128) / (10000 as u128);
        if (v3 > 0) {
            let (v8, v9) = 0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool::remove_liquidity<T0, T1>(arg1, arg2, &mut arg3, v7, arg8);
            0x2::transfer::public_transfer<0x2::coin::Coin<T0>>(0x2::coin::from_balance<T0>(v8, arg9), arg0.fee_receiver);
            0x2::transfer::public_transfer<0x2::coin::Coin<T1>>(0x2::coin::from_balance<T1>(v9, arg9), arg0.fee_receiver);
        };
        let v10 = v2 - v7;
        assert!(v10 == 0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::position::liquidity(&arg3), 19);
        let v11 = arg0.next_lock_id;
        arg0.next_lock_id = v11 + 1;
        let v12 = 0x2::object::id<0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::position::Position>(&arg3);
        0x2::table::add<u64, 0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::position::Position>(&mut arg0.vaults, v11, arg3);
        let v13 = &mut arg0.user_locks;
        add_user_lock(v13, v0, v11);
        let v14 = LockInfo{
            lock_id       : v11,
            position_id   : v12,
            owner         : v0,
            pending_owner : 0x1::option::none<address>(),
            collector     : arg4,
            collect_fee   : v4,
            lp_fee        : v3,
            liquidity     : v10,
            start_time    : v1,
            unlock_time   : arg5,
        };
        0x2::table::add<u64, LockInfo>(&mut arg0.locks, v11, v14);
        let v15 = OnLockEvent{
            lock_id     : v11,
            owner       : v0,
            position_id : v12,
            liquidity   : v2,
            start_time  : v1,
            unlock_time : arg5,
        };
        0x2::event::emit<OnLockEvent>(v15);
        v11
    }

    public entry fun relock(arg0: &mut PositionLocker, arg1: u64, arg2: u64, arg3: &0x2::clock::Clock, arg4: &0x2::tx_context::TxContext) {
        assert!(0x2::table::contains<u64, LockInfo>(&arg0.locks, arg1) && 0x2::table::contains<u64, 0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::position::Position>(&arg0.vaults, arg1), 1);
        let v0 = 0x2::table::borrow_mut<u64, LockInfo>(&mut arg0.locks, arg1);
        assert!(v0.owner == 0x2::tx_context::sender(arg4), 4);
        assert!(arg2 > v0.unlock_time, 10);
        assert!(arg2 > 0x2::clock::timestamp_ms(arg3), 10);
        let v1 = OnRelockEvent{
            lock_id              : arg1,
            original_unlock_time : v0.unlock_time,
            new_unlock_time      : arg2,
        };
        0x2::event::emit<OnRelockEvent>(v1);
        v0.unlock_time = arg2;
    }

    public entry fun remove_custom_fee(arg0: &mut PositionLocker, arg1: address, arg2: &0x2::tx_context::TxContext) {
        assert!(0x2::tx_context::sender(arg2) == arg0.admin, 2);
        assert!(arg1 != @0x0 && 0x2::table::contains<address, FeeStruct>(&arg0.custom_user_fees, arg1), 8);
        let v0 = 0x2::table::borrow<address, FeeStruct>(&arg0.custom_user_fees, arg1);
        let v1 = OnRemoveCustomFeeEvent{
            user               : arg1,
            name               : v0.name,
            lp_fee             : v0.lp_fee,
            collect_fee        : v0.collect_fee,
            lock_fee           : v0.lock_fee,
            lock_fee_coin_type : v0.lock_fee_coin_type,
        };
        0x2::event::emit<OnRemoveCustomFeeEvent>(v1);
        0x2::table::remove<address, FeeStruct>(&mut arg0.custom_user_fees, arg1);
    }

    public entry fun remove_fee(arg0: &mut PositionLocker, arg1: 0x1::ascii::String, arg2: &0x2::tx_context::TxContext) {
        assert!(0x2::tx_context::sender(arg2) == arg0.admin, 2);
        assert!(arg1 != 0x1::ascii::string(b"DEFAULT"), 11);
        let v0 = 0x2::hash::keccak256(0x1::ascii::as_bytes(&arg1));
        assert!(0x2::vec_map::contains<vector<u8>, FeeStruct>(&arg0.fees, &v0), 12);
        let (_, v2) = 0x2::vec_map::remove<vector<u8>, FeeStruct>(&mut arg0.fees, &v0);
        let v3 = v2;
        let v4 = OnRemoveFeeEvent{
            name               : arg1,
            lp_fee             : v3.lp_fee,
            collect_fee        : v3.collect_fee,
            lock_fee           : v3.lock_fee,
            lock_fee_coin_type : v3.lock_fee_coin_type,
        };
        0x2::event::emit<OnRemoveFeeEvent>(v4);
    }

    fun remove_user_lock(arg0: &mut 0x2::table::Table<address, 0x2::vec_set::VecSet<u64>>, arg1: address, arg2: u64) {
        if (!0x2::table::contains<address, 0x2::vec_set::VecSet<u64>>(arg0, arg1)) {
            return
        };
        let v0 = 0x2::table::borrow_mut<address, 0x2::vec_set::VecSet<u64>>(arg0, arg1);
        if (0x2::vec_set::contains<u64>(v0, &arg2)) {
            0x2::vec_set::remove<u64>(v0, &arg2);
        };
    }

    public entry fun set_collector(arg0: &mut PositionLocker, arg1: u64, arg2: address, arg3: &0x2::tx_context::TxContext) {
        assert!(0x2::table::contains<u64, LockInfo>(&arg0.locks, arg1) && 0x2::table::contains<u64, 0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::position::Position>(&arg0.vaults, arg1), 1);
        assert!(arg2 != @0x0, 6);
        let v0 = 0x2::table::borrow_mut<u64, LockInfo>(&mut arg0.locks, arg1);
        assert!(v0.owner == 0x2::tx_context::sender(arg3), 4);
        let v1 = OnSetCollectorEvent{
            lock_id            : arg1,
            original_collector : v0.collector,
            new_collector      : arg2,
        };
        0x2::event::emit<OnSetCollectorEvent>(v1);
        v0.collector = arg2;
    }

    public entry fun set_or_update_custom_fee<T0>(arg0: &mut PositionLocker, arg1: address, arg2: 0x1::ascii::String, arg3: u64, arg4: u64, arg5: u64, arg6: &0x2::tx_context::TxContext) {
        assert!(0x2::tx_context::sender(arg6) == arg0.admin, 2);
        assert!(arg3 <= 500 && arg4 <= 500, 14);
        assert!(arg1 != @0x0, 8);
        let v0 = &mut arg0.custom_user_fees;
        set_or_update_custom_fee_internal(v0, arg1, arg2, arg3, arg4, arg5, 0x1::type_name::into_string(0x1::type_name::get<T0>()));
    }

    fun set_or_update_custom_fee_internal(arg0: &mut 0x2::table::Table<address, FeeStruct>, arg1: address, arg2: 0x1::ascii::String, arg3: u64, arg4: u64, arg5: u64, arg6: 0x1::ascii::String) {
        if (0x2::table::contains<address, FeeStruct>(arg0, arg1)) {
            let v0 = 0x2::table::borrow_mut<address, FeeStruct>(arg0, arg1);
            v0.lp_fee = arg3;
            v0.collect_fee = arg4;
            v0.lock_fee = arg5;
            v0.lock_fee_coin_type = arg6;
            let v1 = OnUpdateCustomFeeEvent{
                user               : arg1,
                name               : arg2,
                lp_fee             : arg3,
                collect_fee        : arg4,
                lock_fee           : arg5,
                lock_fee_coin_type : arg6,
            };
            0x2::event::emit<OnUpdateCustomFeeEvent>(v1);
        } else {
            let v2 = FeeStruct{
                name               : arg2,
                lp_fee             : arg3,
                collect_fee        : arg4,
                lock_fee           : arg5,
                lock_fee_coin_type : arg6,
            };
            0x2::table::add<address, FeeStruct>(arg0, arg1, v2);
            let v3 = OnSetCustomFeeEvent{
                user               : arg1,
                name               : arg2,
                lp_fee             : arg3,
                collect_fee        : arg4,
                lock_fee           : arg5,
                lock_fee_coin_type : arg6,
            };
            0x2::event::emit<OnSetCustomFeeEvent>(v3);
        };
    }

    public entry fun transfer_admin(arg0: &mut PositionLocker, arg1: address, arg2: &0x2::tx_context::TxContext) {
        assert!(0x2::tx_context::sender(arg2) == arg0.admin, 2);
        arg0.pending_admin = 0x1::option::some<address>(arg1);
        let v0 = OnTransferAdminEvent{
            current_admin : arg0.admin,
            pending_admin : arg1,
        };
        0x2::event::emit<OnTransferAdminEvent>(v0);
    }

    public entry fun transfer_lock(arg0: &mut PositionLocker, arg1: u64, arg2: address, arg3: &0x2::tx_context::TxContext) {
        assert!(0x2::table::contains<u64, LockInfo>(&arg0.locks, arg1) && 0x2::table::contains<u64, 0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::position::Position>(&arg0.vaults, arg1), 1);
        let v0 = 0x2::table::borrow_mut<u64, LockInfo>(&mut arg0.locks, arg1);
        assert!(v0.owner == 0x2::tx_context::sender(arg3), 4);
        v0.pending_owner = 0x1::option::some<address>(arg2);
        let v1 = OnTransferLockEvent{
            lock_id       : arg1,
            current_owner : v0.owner,
            pending_owner : arg2,
        };
        0x2::event::emit<OnTransferLockEvent>(v1);
    }

    public entry fun unlock_position(arg0: &mut PositionLocker, arg1: u64, arg2: &0x2::clock::Clock, arg3: &0x2::tx_context::TxContext) {
        assert!(0x2::table::contains<u64, LockInfo>(&arg0.locks, arg1) && 0x2::table::contains<u64, 0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::position::Position>(&arg0.vaults, arg1), 1);
        let v0 = 0x2::clock::timestamp_ms(arg2);
        let v1 = 0x2::table::borrow<u64, LockInfo>(&arg0.locks, arg1);
        assert!(v1.owner == 0x2::tx_context::sender(arg3), 4);
        assert!(v1.unlock_time < v0, 9);
        let v2 = v1.owner;
        let v3 = v1.liquidity;
        0x2::transfer::public_transfer<0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::position::Position>(0x2::table::remove<u64, 0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::position::Position>(&mut arg0.vaults, arg1), v2);
        let v4 = &mut arg0.user_locks;
        remove_user_lock(v4, v2, arg1);
        0x2::table::remove<u64, LockInfo>(&mut arg0.locks, arg1);
        let v5 = OnUnlockEvent{
            lock_id       : arg1,
            owner         : v2,
            position_id   : v1.position_id,
            liquidity     : v3,
            unlocked_time : v0,
        };
        0x2::event::emit<OnUnlockEvent>(v5);
    }

    public entry fun update_fee_receiver(arg0: &mut PositionLocker, arg1: address, arg2: &0x2::tx_context::TxContext) {
        assert!(0x2::tx_context::sender(arg2) == arg0.admin, 2);
        let v0 = OnUpdateFeeReceiverEvent{
            original_receiver : arg0.fee_receiver,
            new_receiver      : arg1,
        };
        0x2::event::emit<OnUpdateFeeReceiverEvent>(v0);
        arg0.fee_receiver = arg1;
    }

    // decompiled from Move bytecode v6
}

