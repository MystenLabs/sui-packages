module 0xc0b2d3f71a30453e0606923a024acf9597909c8c5ec78ee84ee00d2d26f269d3::llv_user_entry {
    struct DepositReceipt<phantom T0> {
        pool_id: 0x2::object::ID,
        min_shares_out: u128,
        remaining: 0x2::balance::Balance<T0>,
        expected_allocation_plan: vector<0xc0b2d3f71a30453e0606923a024acf9597909c8c5ec78ee84ee00d2d26f269d3::llv_allocation_plan::ProtocolAmount>,
        actual_deposits: vector<0xc0b2d3f71a30453e0606923a024acf9597909c8c5ec78ee84ee00d2d26f269d3::llv_allocation_plan::ProtocolAmount>,
        total_deposited: u128,
        snapshot_total_assets: u128,
        snapshot_total_shares: u128,
    }

    struct DepositLegTicket<phantom T0> {
        protocol_id: u8,
        before_remaining: u64,
    }

    struct WithdrawLegTicket<phantom T0> {
        protocol_id: u8,
        amount_extracted: u64,
    }

    struct WithdrawReceipt<phantom T0, phantom T1> {
        pool_id: 0x2::object::ID,
        shares_to_withdraw: u128,
        share_coin: 0x2::coin::Coin<T1>,
        expected_recall_plan: vector<0xc0b2d3f71a30453e0606923a024acf9597909c8c5ec78ee84ee00d2d26f269d3::llv_allocation_plan::ProtocolAmount>,
        total_withdrawed: 0x2::balance::Balance<T0>,
        actual_withdraws: vector<0xc0b2d3f71a30453e0606923a024acf9597909c8c5ec78ee84ee00d2d26f269d3::llv_allocation_plan::ProtocolAmount>,
        snapshot_total_assets: u128,
        snapshot_total_shares: u128,
    }

    public fun get_min_deposit<T0, T1>(arg0: &0xc0b2d3f71a30453e0606923a024acf9597909c8c5ec78ee84ee00d2d26f269d3::llv_pool::LLVPool<T0, T1>) : u64 {
        0xc0b2d3f71a30453e0606923a024acf9597909c8c5ec78ee84ee00d2d26f269d3::llv_pool::get_min_deposit<T0, T1>(arg0)
    }

    public fun get_protocol_balance<T0, T1>(arg0: &0xc0b2d3f71a30453e0606923a024acf9597909c8c5ec78ee84ee00d2d26f269d3::llv_pool::LLVPool<T0, T1>, arg1: u8) : u128 {
        0xc0b2d3f71a30453e0606923a024acf9597909c8c5ec78ee84ee00d2d26f269d3::llv_pool::get_protocol_balance<T0, T1>(arg0, arg1)
    }

    public fun get_protocol_ratio<T0, T1>(arg0: &0xc0b2d3f71a30453e0606923a024acf9597909c8c5ec78ee84ee00d2d26f269d3::llv_pool::LLVPool<T0, T1>, arg1: u8) : u64 {
        0xc0b2d3f71a30453e0606923a024acf9597909c8c5ec78ee84ee00d2d26f269d3::llv_pool::get_protocol_ratio<T0, T1>(arg0, arg1)
    }

    public fun is_protocol_enabled<T0, T1>(arg0: &0xc0b2d3f71a30453e0606923a024acf9597909c8c5ec78ee84ee00d2d26f269d3::llv_pool::LLVPool<T0, T1>, arg1: u8) : bool {
        0xc0b2d3f71a30453e0606923a024acf9597909c8c5ec78ee84ee00d2d26f269d3::llv_pool::is_protocol_enabled<T0, T1>(arg0, arg1)
    }

    public fun add_withdraw_leg<T0, T1, T2>(arg0: &mut WithdrawReceipt<T0, T1>, arg1: &0xc0b2d3f71a30453e0606923a024acf9597909c8c5ec78ee84ee00d2d26f269d3::llv_pool::LLVPool<T0, T1>, arg2: u8, arg3: 0x2::balance::Balance<T0>, arg4: &T2) {
        assert!(arg0.pool_id == 0x2::object::id<0xc0b2d3f71a30453e0606923a024acf9597909c8c5ec78ee84ee00d2d26f269d3::llv_pool::LLVPool<T0, T1>>(arg1), 8);
        assert!(arg2 <= 5 || 0xc0b2d3f71a30453e0606923a024acf9597909c8c5ec78ee84ee00d2d26f269d3::llv_allocation_plan::is_idle_protocol(arg2), 15);
        0xc0b2d3f71a30453e0606923a024acf9597909c8c5ec78ee84ee00d2d26f269d3::llv_pool::assert_protocol_leg_auth<T0, T1, T2>(arg1, arg2);
        let v0 = (0x2::balance::value<T0>(&arg3) as u128);
        0x2::balance::join<T0>(&mut arg0.total_withdrawed, arg3);
        if (v0 > 0) {
            0xc0b2d3f71a30453e0606923a024acf9597909c8c5ec78ee84ee00d2d26f269d3::llv_allocation_plan::accumulate(&mut arg0.actual_withdraws, arg2, v0);
        };
    }

    fun assert_deposit_plan_bounds(arg0: &vector<0xc0b2d3f71a30453e0606923a024acf9597909c8c5ec78ee84ee00d2d26f269d3::llv_allocation_plan::ProtocolAmount>, arg1: &vector<0xc0b2d3f71a30453e0606923a024acf9597909c8c5ec78ee84ee00d2d26f269d3::llv_allocation_plan::ProtocolAmount>) {
        assert_plan_bounds(arg0, arg1, 0);
    }

    fun assert_plan_bounds(arg0: &vector<0xc0b2d3f71a30453e0606923a024acf9597909c8c5ec78ee84ee00d2d26f269d3::llv_allocation_plan::ProtocolAmount>, arg1: &vector<0xc0b2d3f71a30453e0606923a024acf9597909c8c5ec78ee84ee00d2d26f269d3::llv_allocation_plan::ProtocolAmount>, arg2: u128) {
        let v0 = 0;
        while (v0 < 0x1::vector::length<0xc0b2d3f71a30453e0606923a024acf9597909c8c5ec78ee84ee00d2d26f269d3::llv_allocation_plan::ProtocolAmount>(arg1)) {
            let v1 = 0x1::vector::borrow<0xc0b2d3f71a30453e0606923a024acf9597909c8c5ec78ee84ee00d2d26f269d3::llv_allocation_plan::ProtocolAmount>(arg1, v0);
            assert_protocol_within_plan(arg0, 0xc0b2d3f71a30453e0606923a024acf9597909c8c5ec78ee84ee00d2d26f269d3::llv_allocation_plan::protocol_id(v1), 0xc0b2d3f71a30453e0606923a024acf9597909c8c5ec78ee84ee00d2d26f269d3::llv_allocation_plan::amount(v1), arg2);
            v0 = v0 + 1;
        };
    }

    fun assert_protocol_within_plan(arg0: &vector<0xc0b2d3f71a30453e0606923a024acf9597909c8c5ec78ee84ee00d2d26f269d3::llv_allocation_plan::ProtocolAmount>, arg1: u8, arg2: u128, arg3: u128) {
        assert!(arg2 <= 0xc0b2d3f71a30453e0606923a024acf9597909c8c5ec78ee84ee00d2d26f269d3::llv_allocation_plan::get_amount(arg0, arg1) + arg3, 13);
    }

    fun assert_withdraw_plan_bounds(arg0: &vector<0xc0b2d3f71a30453e0606923a024acf9597909c8c5ec78ee84ee00d2d26f269d3::llv_allocation_plan::ProtocolAmount>, arg1: &vector<0xc0b2d3f71a30453e0606923a024acf9597909c8c5ec78ee84ee00d2d26f269d3::llv_allocation_plan::ProtocolAmount>) {
        assert_plan_bounds(arg0, arg1, 8);
    }

    public fun begin_deposit<T0, T1>(arg0: &0xc0b2d3f71a30453e0606923a024acf9597909c8c5ec78ee84ee00d2d26f269d3::llv_admin::LLVGlobal, arg1: &mut 0xc0b2d3f71a30453e0606923a024acf9597909c8c5ec78ee84ee00d2d26f269d3::llv_pool::LLVPool<T0, T1>, arg2: 0x2::coin::Coin<T0>, arg3: u128) : DepositReceipt<T0> {
        0xc0b2d3f71a30453e0606923a024acf9597909c8c5ec78ee84ee00d2d26f269d3::llv_admin::assert_version(arg0);
        assert!(!0xc0b2d3f71a30453e0606923a024acf9597909c8c5ec78ee84ee00d2d26f269d3::llv_admin::is_global_paused(arg0), 5);
        assert!(!0xc0b2d3f71a30453e0606923a024acf9597909c8c5ec78ee84ee00d2d26f269d3::llv_pool::is_paused<T0, T1>(arg1), 1);
        0xc0b2d3f71a30453e0606923a024acf9597909c8c5ec78ee84ee00d2d26f269d3::llv_pool::refresh_idle_balance<T0, T1>(arg1);
        let v0 = 0x2::coin::value<T0>(&arg2);
        assert!(v0 > 0, 2);
        let v1 = 0xc0b2d3f71a30453e0606923a024acf9597909c8c5ec78ee84ee00d2d26f269d3::llv_deposit::calculate_deposit<T0, T1>(arg1, v0);
        DepositReceipt<T0>{
            pool_id                  : 0x2::object::id<0xc0b2d3f71a30453e0606923a024acf9597909c8c5ec78ee84ee00d2d26f269d3::llv_pool::LLVPool<T0, T1>>(arg1),
            min_shares_out           : arg3,
            remaining                : 0x2::coin::into_balance<T0>(arg2),
            expected_allocation_plan : *0xc0b2d3f71a30453e0606923a024acf9597909c8c5ec78ee84ee00d2d26f269d3::llv_deposit::allocation(&v1),
            actual_deposits          : 0x1::vector::empty<0xc0b2d3f71a30453e0606923a024acf9597909c8c5ec78ee84ee00d2d26f269d3::llv_allocation_plan::ProtocolAmount>(),
            total_deposited          : 0,
            snapshot_total_assets    : 0xc0b2d3f71a30453e0606923a024acf9597909c8c5ec78ee84ee00d2d26f269d3::llv_pool::get_total_assets<T0, T1>(arg1),
            snapshot_total_shares    : 0xc0b2d3f71a30453e0606923a024acf9597909c8c5ec78ee84ee00d2d26f269d3::llv_pool::total_shares<T0, T1>(arg1),
        }
    }

    public fun begin_deposit_leg<T0, T1, T2>(arg0: &mut DepositReceipt<T0>, arg1: &0xc0b2d3f71a30453e0606923a024acf9597909c8c5ec78ee84ee00d2d26f269d3::llv_pool::LLVPool<T0, T1>, arg2: u8, arg3: u64, arg4: &T2) : (0x2::balance::Balance<T0>, DepositLegTicket<T0>) {
        assert!(arg0.pool_id == 0x2::object::id<0xc0b2d3f71a30453e0606923a024acf9597909c8c5ec78ee84ee00d2d26f269d3::llv_pool::LLVPool<T0, T1>>(arg1), 8);
        0xc0b2d3f71a30453e0606923a024acf9597909c8c5ec78ee84ee00d2d26f269d3::llv_pool::assert_protocol_leg_auth<T0, T1, T2>(arg1, arg2);
        let v0 = 0x2::balance::value<T0>(&arg0.remaining);
        let v1 = if (arg3 >= v0) {
            0x2::balance::withdraw_all<T0>(&mut arg0.remaining)
        } else {
            0x2::balance::split<T0>(&mut arg0.remaining, arg3)
        };
        let v2 = DepositLegTicket<T0>{
            protocol_id      : arg2,
            before_remaining : v0,
        };
        (v1, v2)
    }

    public fun begin_withdraw<T0, T1>(arg0: &0xc0b2d3f71a30453e0606923a024acf9597909c8c5ec78ee84ee00d2d26f269d3::llv_admin::LLVGlobal, arg1: &mut 0xc0b2d3f71a30453e0606923a024acf9597909c8c5ec78ee84ee00d2d26f269d3::llv_pool::LLVPool<T0, T1>, arg2: 0x2::coin::Coin<T1>) : WithdrawReceipt<T0, T1> {
        0xc0b2d3f71a30453e0606923a024acf9597909c8c5ec78ee84ee00d2d26f269d3::llv_admin::assert_version(arg0);
        assert!(!0xc0b2d3f71a30453e0606923a024acf9597909c8c5ec78ee84ee00d2d26f269d3::llv_admin::is_global_paused(arg0), 5);
        assert!(!0xc0b2d3f71a30453e0606923a024acf9597909c8c5ec78ee84ee00d2d26f269d3::llv_pool::is_paused<T0, T1>(arg1), 1);
        0xc0b2d3f71a30453e0606923a024acf9597909c8c5ec78ee84ee00d2d26f269d3::llv_pool::refresh_idle_balance<T0, T1>(arg1);
        let v0 = (0x2::coin::value<T1>(&arg2) as u128);
        assert!(v0 > 0, 2);
        let v1 = 0xc0b2d3f71a30453e0606923a024acf9597909c8c5ec78ee84ee00d2d26f269d3::llv_withdraw::calculate_withdraw_by_shares<T0, T1>(arg1, v0);
        WithdrawReceipt<T0, T1>{
            pool_id               : 0x2::object::id<0xc0b2d3f71a30453e0606923a024acf9597909c8c5ec78ee84ee00d2d26f269d3::llv_pool::LLVPool<T0, T1>>(arg1),
            shares_to_withdraw    : v0,
            share_coin            : arg2,
            expected_recall_plan  : *0xc0b2d3f71a30453e0606923a024acf9597909c8c5ec78ee84ee00d2d26f269d3::llv_withdraw::recall_plan(&v1),
            total_withdrawed      : 0x2::balance::zero<T0>(),
            actual_withdraws      : 0x1::vector::empty<0xc0b2d3f71a30453e0606923a024acf9597909c8c5ec78ee84ee00d2d26f269d3::llv_allocation_plan::ProtocolAmount>(),
            snapshot_total_assets : 0xc0b2d3f71a30453e0606923a024acf9597909c8c5ec78ee84ee00d2d26f269d3::llv_pool::get_total_assets<T0, T1>(arg1),
            snapshot_total_shares : 0xc0b2d3f71a30453e0606923a024acf9597909c8c5ec78ee84ee00d2d26f269d3::llv_pool::total_shares<T0, T1>(arg1),
        }
    }

    public fun begin_withdraw_leg<T0, T1, T2, T3>(arg0: &WithdrawReceipt<T0, T1>, arg1: &mut 0xc0b2d3f71a30453e0606923a024acf9597909c8c5ec78ee84ee00d2d26f269d3::llv_pool::LLVPool<T0, T1>, arg2: u8, arg3: u64, arg4: &T3) : (0x2::balance::Balance<T2>, WithdrawLegTicket<T0>) {
        assert!(arg0.pool_id == 0x2::object::id<0xc0b2d3f71a30453e0606923a024acf9597909c8c5ec78ee84ee00d2d26f269d3::llv_pool::LLVPool<T0, T1>>(arg1), 8);
        0xc0b2d3f71a30453e0606923a024acf9597909c8c5ec78ee84ee00d2d26f269d3::llv_pool::assert_protocol_leg_auth<T0, T1, T3>(arg1, arg2);
        let v0 = 0xc0b2d3f71a30453e0606923a024acf9597909c8c5ec78ee84ee00d2d26f269d3::llv_pool::extract_balance<T0, T1, T2>(arg1, arg2, arg3);
        let v1 = WithdrawLegTicket<T0>{
            protocol_id      : arg2,
            amount_extracted : 0x2::balance::value<T2>(&v0),
        };
        (v0, v1)
    }

    public fun borrow_cap_by_auth<T0, T1, T2: copy + drop + store, T3: store, T4>(arg0: &0xc0b2d3f71a30453e0606923a024acf9597909c8c5ec78ee84ee00d2d26f269d3::llv_pool::LLVPool<T0, T1>, arg1: u8, arg2: T2, arg3: &T4) : &T3 {
        0xc0b2d3f71a30453e0606923a024acf9597909c8c5ec78ee84ee00d2d26f269d3::llv_pool::assert_protocol_leg_auth<T0, T1, T4>(arg0, arg1);
        0x2::dynamic_field::borrow<T2, T3>(0xc0b2d3f71a30453e0606923a024acf9597909c8c5ec78ee84ee00d2d26f269d3::llv_pool::borrow_uid<T0, T1>(arg0), arg2)
    }

    public fun borrow_cap_for_deposit<T0, T1, T2: copy + drop + store, T3: store, T4>(arg0: &DepositReceipt<T0>, arg1: &0xc0b2d3f71a30453e0606923a024acf9597909c8c5ec78ee84ee00d2d26f269d3::llv_pool::LLVPool<T0, T1>, arg2: u8, arg3: T2, arg4: &T4) : &T3 {
        assert!(arg0.pool_id == 0x2::object::id<0xc0b2d3f71a30453e0606923a024acf9597909c8c5ec78ee84ee00d2d26f269d3::llv_pool::LLVPool<T0, T1>>(arg1), 8);
        0xc0b2d3f71a30453e0606923a024acf9597909c8c5ec78ee84ee00d2d26f269d3::llv_pool::assert_protocol_leg_auth<T0, T1, T4>(arg1, arg2);
        0x2::dynamic_field::borrow<T2, T3>(0xc0b2d3f71a30453e0606923a024acf9597909c8c5ec78ee84ee00d2d26f269d3::llv_pool::borrow_uid<T0, T1>(arg1), arg3)
    }

    public fun borrow_cap_for_keeper<T0, T1, T2: copy + drop + store, T3: store>(arg0: &0xc0b2d3f71a30453e0606923a024acf9597909c8c5ec78ee84ee00d2d26f269d3::llv_pool::LLVPool<T0, T1>, arg1: T2, arg2: &mut 0x2::tx_context::TxContext) : &T3 {
        0xc0b2d3f71a30453e0606923a024acf9597909c8c5ec78ee84ee00d2d26f269d3::llv_pool::assert_keeper<T0, T1>(arg0, 0x2::tx_context::sender(arg2));
        0x2::dynamic_field::borrow<T2, T3>(0xc0b2d3f71a30453e0606923a024acf9597909c8c5ec78ee84ee00d2d26f269d3::llv_pool::borrow_uid<T0, T1>(arg0), arg1)
    }

    public fun borrow_cap_for_withdraw<T0, T1, T2: copy + drop + store, T3: store, T4>(arg0: &WithdrawReceipt<T0, T1>, arg1: &0xc0b2d3f71a30453e0606923a024acf9597909c8c5ec78ee84ee00d2d26f269d3::llv_pool::LLVPool<T0, T1>, arg2: u8, arg3: T2, arg4: &T4) : &T3 {
        assert!(arg0.pool_id == 0x2::object::id<0xc0b2d3f71a30453e0606923a024acf9597909c8c5ec78ee84ee00d2d26f269d3::llv_pool::LLVPool<T0, T1>>(arg1), 8);
        0xc0b2d3f71a30453e0606923a024acf9597909c8c5ec78ee84ee00d2d26f269d3::llv_pool::assert_protocol_leg_auth<T0, T1, T4>(arg1, arg2);
        0x2::dynamic_field::borrow<T2, T3>(0xc0b2d3f71a30453e0606923a024acf9597909c8c5ec78ee84ee00d2d26f269d3::llv_pool::borrow_uid<T0, T1>(arg1), arg3)
    }

    public fun complete_deposit<T0, T1>(arg0: &mut 0xc0b2d3f71a30453e0606923a024acf9597909c8c5ec78ee84ee00d2d26f269d3::llv_pool::LLVPool<T0, T1>, arg1: DepositReceipt<T0>, arg2: &0x2::clock::Clock, arg3: &mut 0x2::tx_context::TxContext) {
        let v0 = complete_deposit_return<T0, T1>(arg0, arg1, arg2, arg3);
        0x2::transfer::public_transfer<0x2::coin::Coin<T1>>(v0, 0x2::tx_context::sender(arg3));
    }

    public fun complete_deposit_return<T0, T1>(arg0: &mut 0xc0b2d3f71a30453e0606923a024acf9597909c8c5ec78ee84ee00d2d26f269d3::llv_pool::LLVPool<T0, T1>, arg1: DepositReceipt<T0>, arg2: &0x2::clock::Clock, arg3: &mut 0x2::tx_context::TxContext) : 0x2::coin::Coin<T1> {
        let DepositReceipt {
            pool_id                  : v0,
            min_shares_out           : v1,
            remaining                : v2,
            expected_allocation_plan : v3,
            actual_deposits          : v4,
            total_deposited          : v5,
            snapshot_total_assets    : v6,
            snapshot_total_shares    : v7,
        } = arg1;
        let v8 = v5;
        let v9 = v4;
        let v10 = v3;
        let v11 = v2;
        assert!(v0 == 0x2::object::id<0xc0b2d3f71a30453e0606923a024acf9597909c8c5ec78ee84ee00d2d26f269d3::llv_pool::LLVPool<T0, T1>>(arg0), 8);
        let v12 = 0x2::balance::value<T0>(&v11);
        if (v12 > 0) {
            0xc0b2d3f71a30453e0606923a024acf9597909c8c5ec78ee84ee00d2d26f269d3::llv_pool::store_or_join_idle_balance<T0, T1>(arg0, 0x2::balance::withdraw_all<T0>(&mut v11));
            let v13 = (v12 as u128);
            0xc0b2d3f71a30453e0606923a024acf9597909c8c5ec78ee84ee00d2d26f269d3::llv_allocation_plan::accumulate(&mut v9, 0xc0b2d3f71a30453e0606923a024acf9597909c8c5ec78ee84ee00d2d26f269d3::llv_allocation_plan::PROTOCOL_IDLE(), v13);
            v8 = v5 + v13;
        };
        assert_deposit_plan_bounds(&v10, &v9);
        assert!((v8 as u64) >= 0xc0b2d3f71a30453e0606923a024acf9597909c8c5ec78ee84ee00d2d26f269d3::llv_pool::get_min_deposit<T0, T1>(arg0), 11);
        0xc0b2d3f71a30453e0606923a024acf9597909c8c5ec78ee84ee00d2d26f269d3::llv_pool::accrue_fees<T0, T1>(arg0, v6, 0x2::clock::timestamp_ms(arg2));
        let v14 = 0xc0b2d3f71a30453e0606923a024acf9597909c8c5ec78ee84ee00d2d26f269d3::llv_math::calculate_shares_with_min(v7, v6, (v8 as u64));
        0xc0b2d3f71a30453e0606923a024acf9597909c8c5ec78ee84ee00d2d26f269d3::llv_deposit::verify_min_shares(v14, v1);
        0xc0b2d3f71a30453e0606923a024acf9597909c8c5ec78ee84ee00d2d26f269d3::llv_pool::assert_deposit_cap<T0, T1>(arg0, v6, (v8 as u64));
        0xc0b2d3f71a30453e0606923a024acf9597909c8c5ec78ee84ee00d2d26f269d3::llv_deposit::record_deposit_state<T0, T1>(arg0, &v9);
        0xc0b2d3f71a30453e0606923a024acf9597909c8c5ec78ee84ee00d2d26f269d3::llv_pool::update_last_total_assets<T0, T1>(arg0);
        assert!(v14 <= 18446744073709551615, 10);
        0x2::balance::destroy_zero<T0>(v11);
        0xc0b2d3f71a30453e0606923a024acf9597909c8c5ec78ee84ee00d2d26f269d3::llv_events::emit_deposited(v0, 0x2::tx_context::sender(arg3), (v8 as u64), v14, v9, 0x2::clock::timestamp_ms(arg2));
        0x2::coin::mint<T1>(0xc0b2d3f71a30453e0606923a024acf9597909c8c5ec78ee84ee00d2d26f269d3::llv_pool::share_treasury_mut<T0, T1>(arg0), (v14 as u64), arg3)
    }

    public fun complete_withdraw<T0, T1>(arg0: &mut 0xc0b2d3f71a30453e0606923a024acf9597909c8c5ec78ee84ee00d2d26f269d3::llv_pool::LLVPool<T0, T1>, arg1: WithdrawReceipt<T0, T1>, arg2: u64, arg3: &0x2::clock::Clock, arg4: &mut 0x2::tx_context::TxContext) {
        let v0 = complete_withdraw_return<T0, T1>(arg0, arg1, arg2, arg3, arg4);
        0x2::transfer::public_transfer<0x2::coin::Coin<T0>>(v0, 0x2::tx_context::sender(arg4));
    }

    public fun complete_withdraw_return<T0, T1>(arg0: &mut 0xc0b2d3f71a30453e0606923a024acf9597909c8c5ec78ee84ee00d2d26f269d3::llv_pool::LLVPool<T0, T1>, arg1: WithdrawReceipt<T0, T1>, arg2: u64, arg3: &0x2::clock::Clock, arg4: &mut 0x2::tx_context::TxContext) : 0x2::coin::Coin<T0> {
        let WithdrawReceipt {
            pool_id               : v0,
            shares_to_withdraw    : v1,
            share_coin            : v2,
            expected_recall_plan  : v3,
            total_withdrawed      : v4,
            actual_withdraws      : v5,
            snapshot_total_assets : v6,
            snapshot_total_shares : v7,
        } = arg1;
        let v8 = v5;
        let v9 = v4;
        let v10 = v3;
        assert!(v0 == 0x2::object::id<0xc0b2d3f71a30453e0606923a024acf9597909c8c5ec78ee84ee00d2d26f269d3::llv_pool::LLVPool<T0, T1>>(arg0), 8);
        let v11 = 0xc0b2d3f71a30453e0606923a024acf9597909c8c5ec78ee84ee00d2d26f269d3::llv_allocation_plan::PROTOCOL_IDLE();
        let v12 = 0xc0b2d3f71a30453e0606923a024acf9597909c8c5ec78ee84ee00d2d26f269d3::llv_allocation_plan::get_amount(&v10, v11);
        if (v12 > 0) {
            let v13 = 0xc0b2d3f71a30453e0606923a024acf9597909c8c5ec78ee84ee00d2d26f269d3::llv_pool::extract_idle_balance<T0, T1>(arg0, (v12 as u64));
            let v14 = (0x2::balance::value<T0>(&v13) as u128);
            0x2::balance::join<T0>(&mut v9, v13);
            if (v14 > 0) {
                0xc0b2d3f71a30453e0606923a024acf9597909c8c5ec78ee84ee00d2d26f269d3::llv_allocation_plan::accumulate(&mut v8, v11, v14);
            };
        };
        let v15 = 0x2::balance::value<T0>(&v9);
        assert!((v15 as u128) >= (arg2 as u128), 4);
        assert_withdraw_plan_bounds(&v10, &v8);
        0xc0b2d3f71a30453e0606923a024acf9597909c8c5ec78ee84ee00d2d26f269d3::llv_pool::accrue_fees<T0, T1>(arg0, v6, 0x2::clock::timestamp_ms(arg3));
        let v16 = 0xc0b2d3f71a30453e0606923a024acf9597909c8c5ec78ee84ee00d2d26f269d3::llv_math::calculate_assets_for_shares(v7, v6, v1);
        if (v16 > 0) {
            assert!(v15 > 0, 4);
        };
        assert!((v15 as u128) <= v16 + 8, 4);
        let v17 = 0xc0b2d3f71a30453e0606923a024acf9597909c8c5ec78ee84ee00d2d26f269d3::llv_math::calculate_proportional_withdraw_burn(v1, v16, (v15 as u128));
        let v18 = if (v17 > v1) {
            v1
        } else {
            v17
        };
        assert!(v18 <= 18446744073709551615, 10);
        let v19 = v2;
        if (v18 < v1) {
            0x2::coin::burn<T1>(0xc0b2d3f71a30453e0606923a024acf9597909c8c5ec78ee84ee00d2d26f269d3::llv_pool::share_treasury_mut<T0, T1>(arg0), 0x2::coin::split<T1>(&mut v19, (v18 as u64), arg4));
            0x2::transfer::public_transfer<0x2::coin::Coin<T1>>(v19, 0x2::tx_context::sender(arg4));
        } else {
            0x2::coin::burn<T1>(0xc0b2d3f71a30453e0606923a024acf9597909c8c5ec78ee84ee00d2d26f269d3::llv_pool::share_treasury_mut<T0, T1>(arg0), v19);
        };
        0xc0b2d3f71a30453e0606923a024acf9597909c8c5ec78ee84ee00d2d26f269d3::llv_withdraw::record_withdraw_state<T0, T1>(arg0, &v8);
        0xc0b2d3f71a30453e0606923a024acf9597909c8c5ec78ee84ee00d2d26f269d3::llv_pool::update_last_total_assets<T0, T1>(arg0);
        0xc0b2d3f71a30453e0606923a024acf9597909c8c5ec78ee84ee00d2d26f269d3::llv_events::emit_withdrawn(v0, 0x2::tx_context::sender(arg4), v18, v15, v8, 0x2::clock::timestamp_ms(arg3));
        0x2::coin::from_balance<T0>(v9, arg4)
    }

    public fun deposit_receipt_pool_id<T0>(arg0: &DepositReceipt<T0>) : 0x2::object::ID {
        arg0.pool_id
    }

    public fun deposit_receipt_remaining<T0>(arg0: &DepositReceipt<T0>) : u64 {
        0x2::balance::value<T0>(&arg0.remaining)
    }

    public fun estimate_shares_value<T0, T1>(arg0: &0xc0b2d3f71a30453e0606923a024acf9597909c8c5ec78ee84ee00d2d26f269d3::llv_pool::LLVPool<T0, T1>, arg1: u64) : u128 {
        0xc0b2d3f71a30453e0606923a024acf9597909c8c5ec78ee84ee00d2d26f269d3::llv_math::calculate_assets_for_shares(0xc0b2d3f71a30453e0606923a024acf9597909c8c5ec78ee84ee00d2d26f269d3::llv_pool::total_shares<T0, T1>(arg0), 0xc0b2d3f71a30453e0606923a024acf9597909c8c5ec78ee84ee00d2d26f269d3::llv_pool::get_total_assets<T0, T1>(arg0), (arg1 as u128))
    }

    public fun finish_deposit_leg<T0, T1, T2>(arg0: &mut DepositReceipt<T0>, arg1: &0xc0b2d3f71a30453e0606923a024acf9597909c8c5ec78ee84ee00d2d26f269d3::llv_pool::LLVPool<T0, T1>, arg2: DepositLegTicket<T0>, arg3: 0x2::balance::Balance<T0>, arg4: &T2) {
        assert!(arg0.pool_id == 0x2::object::id<0xc0b2d3f71a30453e0606923a024acf9597909c8c5ec78ee84ee00d2d26f269d3::llv_pool::LLVPool<T0, T1>>(arg1), 8);
        let DepositLegTicket {
            protocol_id      : v0,
            before_remaining : v1,
        } = arg2;
        0xc0b2d3f71a30453e0606923a024acf9597909c8c5ec78ee84ee00d2d26f269d3::llv_pool::assert_protocol_leg_auth<T0, T1, T2>(arg1, v0);
        let v2 = 0x2::balance::value<T0>(&arg0.remaining) + 0x2::balance::value<T0>(&arg3);
        0x2::balance::join<T0>(&mut arg0.remaining, arg3);
        assert!(v1 >= v2, 4);
        let v3 = v1 - v2;
        if (v3 > 0) {
            let v4 = (v3 as u128);
            0xc0b2d3f71a30453e0606923a024acf9597909c8c5ec78ee84ee00d2d26f269d3::llv_allocation_plan::accumulate(&mut arg0.actual_deposits, v0, v4);
            arg0.total_deposited = arg0.total_deposited + v4;
        };
    }

    public fun finish_deposit_leg_accounted<T0, T1, T2>(arg0: &mut DepositReceipt<T0>, arg1: &0xc0b2d3f71a30453e0606923a024acf9597909c8c5ec78ee84ee00d2d26f269d3::llv_pool::LLVPool<T0, T1>, arg2: DepositLegTicket<T0>, arg3: u64, arg4: u64, arg5: u64, arg6: &T2) {
        assert!(arg0.pool_id == 0x2::object::id<0xc0b2d3f71a30453e0606923a024acf9597909c8c5ec78ee84ee00d2d26f269d3::llv_pool::LLVPool<T0, T1>>(arg1), 8);
        let DepositLegTicket {
            protocol_id      : v0,
            before_remaining : v1,
        } = arg2;
        0xc0b2d3f71a30453e0606923a024acf9597909c8c5ec78ee84ee00d2d26f269d3::llv_pool::assert_protocol_leg_auth<T0, T1, T2>(arg1, v0);
        let v2 = 0x2::balance::value<T0>(&arg0.remaining);
        assert!(v1 >= v2, 18);
        assert!(arg3 == v1 - v2, 18);
        assert!(arg4 <= arg3, 16);
        assert!(arg3 - arg4 <= arg5, 17);
        if (arg4 > 0) {
            let v3 = (arg4 as u128);
            0xc0b2d3f71a30453e0606923a024acf9597909c8c5ec78ee84ee00d2d26f269d3::llv_allocation_plan::accumulate(&mut arg0.actual_deposits, v0, v3);
            arg0.total_deposited = arg0.total_deposited + v3;
        };
    }

    public fun finish_withdraw_leg<T0, T1, T2>(arg0: &mut WithdrawReceipt<T0, T1>, arg1: &0xc0b2d3f71a30453e0606923a024acf9597909c8c5ec78ee84ee00d2d26f269d3::llv_pool::LLVPool<T0, T1>, arg2: WithdrawLegTicket<T0>, arg3: 0x2::balance::Balance<T0>, arg4: &T2) {
        assert!(arg0.pool_id == 0x2::object::id<0xc0b2d3f71a30453e0606923a024acf9597909c8c5ec78ee84ee00d2d26f269d3::llv_pool::LLVPool<T0, T1>>(arg1), 8);
        let WithdrawLegTicket {
            protocol_id      : v0,
            amount_extracted : v1,
        } = arg2;
        0xc0b2d3f71a30453e0606923a024acf9597909c8c5ec78ee84ee00d2d26f269d3::llv_pool::assert_protocol_leg_auth<T0, T1, T2>(arg1, v0);
        if (v1 > 0) {
            assert!(0x2::balance::value<T0>(&arg3) > 0, 14);
        };
        let v2 = (0x2::balance::value<T0>(&arg3) as u128);
        0x2::balance::join<T0>(&mut arg0.total_withdrawed, arg3);
        if (v2 > 0) {
            0xc0b2d3f71a30453e0606923a024acf9597909c8c5ec78ee84ee00d2d26f269d3::llv_allocation_plan::accumulate(&mut arg0.actual_withdraws, v0, v2);
        };
    }

    public fun get_exchange_rate<T0, T1>(arg0: &0xc0b2d3f71a30453e0606923a024acf9597909c8c5ec78ee84ee00d2d26f269d3::llv_pool::LLVPool<T0, T1>) : u128 {
        let v0 = 0xc0b2d3f71a30453e0606923a024acf9597909c8c5ec78ee84ee00d2d26f269d3::llv_pool::total_shares<T0, T1>(arg0);
        if (v0 == 0) {
            return 0xc0b2d3f71a30453e0606923a024acf9597909c8c5ec78ee84ee00d2d26f269d3::llv_math::scale()
        };
        0xc0b2d3f71a30453e0606923a024acf9597909c8c5ec78ee84ee00d2d26f269d3::llv_math::mul_div(0xc0b2d3f71a30453e0606923a024acf9597909c8c5ec78ee84ee00d2d26f269d3::llv_math::scale(), 0xc0b2d3f71a30453e0606923a024acf9597909c8c5ec78ee84ee00d2d26f269d3::llv_pool::get_total_assets<T0, T1>(arg0) + 0xc0b2d3f71a30453e0606923a024acf9597909c8c5ec78ee84ee00d2d26f269d3::llv_math::virtual_offset(), v0 + 0xc0b2d3f71a30453e0606923a024acf9597909c8c5ec78ee84ee00d2d26f269d3::llv_math::virtual_offset())
    }

    public fun is_pool_paused<T0, T1>(arg0: &0xc0b2d3f71a30453e0606923a024acf9597909c8c5ec78ee84ee00d2d26f269d3::llv_pool::LLVPool<T0, T1>) : bool {
        0xc0b2d3f71a30453e0606923a024acf9597909c8c5ec78ee84ee00d2d26f269d3::llv_pool::is_paused<T0, T1>(arg0)
    }

    public fun keeper_sync_protocol_balance<T0, T1>(arg0: &mut 0xc0b2d3f71a30453e0606923a024acf9597909c8c5ec78ee84ee00d2d26f269d3::llv_pool::LLVPool<T0, T1>, arg1: u8, arg2: u128, arg3: &0x2::clock::Clock, arg4: &mut 0x2::tx_context::TxContext) {
        0xc0b2d3f71a30453e0606923a024acf9597909c8c5ec78ee84ee00d2d26f269d3::llv_pool::assert_keeper<T0, T1>(arg0, 0x2::tx_context::sender(arg4));
        0xc0b2d3f71a30453e0606923a024acf9597909c8c5ec78ee84ee00d2d26f269d3::llv_sync::sync_protocol_balance<T0, T1>(arg0, arg1, arg2, arg3);
    }

    public fun pool_total_assets<T0, T1>(arg0: &0xc0b2d3f71a30453e0606923a024acf9597909c8c5ec78ee84ee00d2d26f269d3::llv_pool::LLVPool<T0, T1>) : u128 {
        0xc0b2d3f71a30453e0606923a024acf9597909c8c5ec78ee84ee00d2d26f269d3::llv_pool::get_total_assets<T0, T1>(arg0)
    }

    public fun pool_total_shares<T0, T1>(arg0: &0xc0b2d3f71a30453e0606923a024acf9597909c8c5ec78ee84ee00d2d26f269d3::llv_pool::LLVPool<T0, T1>) : u64 {
        (0xc0b2d3f71a30453e0606923a024acf9597909c8c5ec78ee84ee00d2d26f269d3::llv_pool::total_shares<T0, T1>(arg0) as u64)
    }

    public fun preview_deposit<T0, T1>(arg0: &0xc0b2d3f71a30453e0606923a024acf9597909c8c5ec78ee84ee00d2d26f269d3::llv_pool::LLVPool<T0, T1>, arg1: u64) : (u128, vector<0xc0b2d3f71a30453e0606923a024acf9597909c8c5ec78ee84ee00d2d26f269d3::llv_allocation_plan::ProtocolAmount>) {
        let v0 = 0xc0b2d3f71a30453e0606923a024acf9597909c8c5ec78ee84ee00d2d26f269d3::llv_deposit::calculate_deposit<T0, T1>(arg0, arg1);
        (0xc0b2d3f71a30453e0606923a024acf9597909c8c5ec78ee84ee00d2d26f269d3::llv_deposit::shares_to_mint(&v0), *0xc0b2d3f71a30453e0606923a024acf9597909c8c5ec78ee84ee00d2d26f269d3::llv_deposit::allocation(&v0))
    }

    public fun preview_withdraw_by_assets<T0, T1>(arg0: &0xc0b2d3f71a30453e0606923a024acf9597909c8c5ec78ee84ee00d2d26f269d3::llv_pool::LLVPool<T0, T1>, arg1: u64) : (u128, vector<0xc0b2d3f71a30453e0606923a024acf9597909c8c5ec78ee84ee00d2d26f269d3::llv_allocation_plan::ProtocolAmount>) {
        let v0 = 0xc0b2d3f71a30453e0606923a024acf9597909c8c5ec78ee84ee00d2d26f269d3::llv_withdraw::calculate_withdraw_by_assets<T0, T1>(arg0, arg1);
        (0xc0b2d3f71a30453e0606923a024acf9597909c8c5ec78ee84ee00d2d26f269d3::llv_withdraw::shares_to_burn(&v0), *0xc0b2d3f71a30453e0606923a024acf9597909c8c5ec78ee84ee00d2d26f269d3::llv_withdraw::recall_plan(&v0))
    }

    public fun preview_withdraw_by_assets_safe<T0, T1>(arg0: &0xc0b2d3f71a30453e0606923a024acf9597909c8c5ec78ee84ee00d2d26f269d3::llv_pool::LLVPool<T0, T1>, arg1: u64) : (u128, u128, u128, vector<0xc0b2d3f71a30453e0606923a024acf9597909c8c5ec78ee84ee00d2d26f269d3::llv_allocation_plan::ProtocolAmount>) {
        assert!(arg1 > 0, 2);
        let v0 = 0xc0b2d3f71a30453e0606923a024acf9597909c8c5ec78ee84ee00d2d26f269d3::llv_pool::total_shares<T0, T1>(arg0);
        let v1 = 0xc0b2d3f71a30453e0606923a024acf9597909c8c5ec78ee84ee00d2d26f269d3::llv_pool::get_total_assets<T0, T1>(arg0);
        let v2 = 0xc0b2d3f71a30453e0606923a024acf9597909c8c5ec78ee84ee00d2d26f269d3::llv_math::calculate_shares_for_assets(v0, v1, arg1);
        let (v3, v4) = 0xc0b2d3f71a30453e0606923a024acf9597909c8c5ec78ee84ee00d2d26f269d3::llv_withdraw::calculate_recall_plan_best_effort<T0, T1>(arg0, (arg1 as u128));
        let v5 = if (v4 == (arg1 as u128)) {
            v2
        } else {
            0xc0b2d3f71a30453e0606923a024acf9597909c8c5ec78ee84ee00d2d26f269d3::llv_math::calculate_max_shares_for_assets_u128(v0, v1, v4)
        };
        (v2, v5, v4, v3)
    }

    public fun preview_withdraw_by_shares<T0, T1>(arg0: &0xc0b2d3f71a30453e0606923a024acf9597909c8c5ec78ee84ee00d2d26f269d3::llv_pool::LLVPool<T0, T1>, arg1: u128) : (u128, vector<0xc0b2d3f71a30453e0606923a024acf9597909c8c5ec78ee84ee00d2d26f269d3::llv_allocation_plan::ProtocolAmount>) {
        let v0 = 0xc0b2d3f71a30453e0606923a024acf9597909c8c5ec78ee84ee00d2d26f269d3::llv_withdraw::calculate_withdraw_by_shares<T0, T1>(arg0, arg1);
        (0xc0b2d3f71a30453e0606923a024acf9597909c8c5ec78ee84ee00d2d26f269d3::llv_withdraw::assets_to_receive(&v0), *0xc0b2d3f71a30453e0606923a024acf9597909c8c5ec78ee84ee00d2d26f269d3::llv_withdraw::recall_plan(&v0))
    }

    public fun preview_withdraw_by_shares_safe<T0, T1>(arg0: &0xc0b2d3f71a30453e0606923a024acf9597909c8c5ec78ee84ee00d2d26f269d3::llv_pool::LLVPool<T0, T1>, arg1: u128) : (u128, u128, vector<0xc0b2d3f71a30453e0606923a024acf9597909c8c5ec78ee84ee00d2d26f269d3::llv_allocation_plan::ProtocolAmount>) {
        assert!(arg1 > 0, 2);
        let v0 = 0xc0b2d3f71a30453e0606923a024acf9597909c8c5ec78ee84ee00d2d26f269d3::llv_pool::get_total_assets<T0, T1>(arg0);
        let v1 = 0xc0b2d3f71a30453e0606923a024acf9597909c8c5ec78ee84ee00d2d26f269d3::llv_math::calculate_assets_for_shares(0xc0b2d3f71a30453e0606923a024acf9597909c8c5ec78ee84ee00d2d26f269d3::llv_pool::total_shares<T0, T1>(arg0), v0, arg1);
        let v2 = v1;
        if (v1 > v0) {
            v2 = v0;
        };
        let (v3, v4) = 0xc0b2d3f71a30453e0606923a024acf9597909c8c5ec78ee84ee00d2d26f269d3::llv_withdraw::calculate_recall_plan_best_effort<T0, T1>(arg0, v2);
        (v2, v4, v3)
    }

    public fun resolve_requested_deposit_amount<T0>(arg0: &DepositReceipt<T0>, arg1: u8, arg2: u64) : u64 {
        assert!(arg1 <= 5 || 0xc0b2d3f71a30453e0606923a024acf9597909c8c5ec78ee84ee00d2d26f269d3::llv_allocation_plan::is_idle_protocol(arg1), 15);
        resolve_requested_deposit_amount_from_plan(&arg0.expected_allocation_plan, arg1, arg2)
    }

    fun resolve_requested_deposit_amount_from_plan(arg0: &vector<0xc0b2d3f71a30453e0606923a024acf9597909c8c5ec78ee84ee00d2d26f269d3::llv_allocation_plan::ProtocolAmount>, arg1: u8, arg2: u64) : u64 {
        let v0 = 0xc0b2d3f71a30453e0606923a024acf9597909c8c5ec78ee84ee00d2d26f269d3::llv_allocation_plan::get_amount(arg0, arg1);
        let v1 = if (arg2 == 0) {
            v0
        } else {
            let v2 = (arg2 as u128);
            if (v2 < v0) {
                v2
            } else {
                v0
            }
        };
        (v1 as u64)
    }

    public fun resolve_requested_withdraw_assets<T0, T1>(arg0: &WithdrawReceipt<T0, T1>, arg1: u8, arg2: u128) : u128 {
        assert!(arg1 <= 5 || 0xc0b2d3f71a30453e0606923a024acf9597909c8c5ec78ee84ee00d2d26f269d3::llv_allocation_plan::is_idle_protocol(arg1), 15);
        resolve_requested_withdraw_assets_from_plan(&arg0.expected_recall_plan, arg1, arg2)
    }

    fun resolve_requested_withdraw_assets_from_plan(arg0: &vector<0xc0b2d3f71a30453e0606923a024acf9597909c8c5ec78ee84ee00d2d26f269d3::llv_allocation_plan::ProtocolAmount>, arg1: u8, arg2: u128) : u128 {
        let v0 = 0xc0b2d3f71a30453e0606923a024acf9597909c8c5ec78ee84ee00d2d26f269d3::llv_allocation_plan::get_amount(arg0, arg1);
        if (arg2 == 0) {
            v0
        } else if (arg2 < v0) {
            arg2
        } else {
            v0
        }
    }

    public fun store_deposit_holding<T0, T1, T2, T3>(arg0: &DepositReceipt<T0>, arg1: &mut 0xc0b2d3f71a30453e0606923a024acf9597909c8c5ec78ee84ee00d2d26f269d3::llv_pool::LLVPool<T0, T1>, arg2: u8, arg3: 0x2::balance::Balance<T2>, arg4: &T3) {
        assert!(arg0.pool_id == 0x2::object::id<0xc0b2d3f71a30453e0606923a024acf9597909c8c5ec78ee84ee00d2d26f269d3::llv_pool::LLVPool<T0, T1>>(arg1), 8);
        0xc0b2d3f71a30453e0606923a024acf9597909c8c5ec78ee84ee00d2d26f269d3::llv_pool::assert_protocol_leg_auth<T0, T1, T3>(arg1, arg2);
        0xc0b2d3f71a30453e0606923a024acf9597909c8c5ec78ee84ee00d2d26f269d3::llv_pool::store_or_join_balance<T0, T1, T2>(arg1, arg2, arg3);
    }

    public fun store_withdraw_holding<T0, T1, T2, T3>(arg0: &WithdrawReceipt<T0, T1>, arg1: &mut 0xc0b2d3f71a30453e0606923a024acf9597909c8c5ec78ee84ee00d2d26f269d3::llv_pool::LLVPool<T0, T1>, arg2: u8, arg3: 0x2::balance::Balance<T2>, arg4: &T3) {
        assert!(arg0.pool_id == 0x2::object::id<0xc0b2d3f71a30453e0606923a024acf9597909c8c5ec78ee84ee00d2d26f269d3::llv_pool::LLVPool<T0, T1>>(arg1), 8);
        0xc0b2d3f71a30453e0606923a024acf9597909c8c5ec78ee84ee00d2d26f269d3::llv_pool::assert_protocol_leg_auth<T0, T1, T3>(arg1, arg2);
        0xc0b2d3f71a30453e0606923a024acf9597909c8c5ec78ee84ee00d2d26f269d3::llv_pool::store_or_join_balance<T0, T1, T2>(arg1, arg2, arg3);
    }

    public fun sync_for_deposit<T0, T1, T2>(arg0: &mut 0xc0b2d3f71a30453e0606923a024acf9597909c8c5ec78ee84ee00d2d26f269d3::llv_pool::LLVPool<T0, T1>, arg1: &DepositReceipt<T0>, arg2: u8, arg3: u128, arg4: &0x2::clock::Clock, arg5: &T2) {
        assert!(arg1.pool_id == 0x2::object::id<0xc0b2d3f71a30453e0606923a024acf9597909c8c5ec78ee84ee00d2d26f269d3::llv_pool::LLVPool<T0, T1>>(arg0), 8);
        0xc0b2d3f71a30453e0606923a024acf9597909c8c5ec78ee84ee00d2d26f269d3::llv_pool::assert_protocol_leg_auth<T0, T1, T2>(arg0, arg2);
        0xc0b2d3f71a30453e0606923a024acf9597909c8c5ec78ee84ee00d2d26f269d3::llv_sync::sync_protocol_balance<T0, T1>(arg0, arg2, arg3, arg4);
    }

    public fun sync_for_withdraw<T0, T1, T2>(arg0: &mut 0xc0b2d3f71a30453e0606923a024acf9597909c8c5ec78ee84ee00d2d26f269d3::llv_pool::LLVPool<T0, T1>, arg1: &WithdrawReceipt<T0, T1>, arg2: u8, arg3: u128, arg4: &0x2::clock::Clock, arg5: &T2) {
        assert!(arg1.pool_id == 0x2::object::id<0xc0b2d3f71a30453e0606923a024acf9597909c8c5ec78ee84ee00d2d26f269d3::llv_pool::LLVPool<T0, T1>>(arg0), 8);
        0xc0b2d3f71a30453e0606923a024acf9597909c8c5ec78ee84ee00d2d26f269d3::llv_pool::assert_protocol_leg_auth<T0, T1, T2>(arg0, arg2);
        0xc0b2d3f71a30453e0606923a024acf9597909c8c5ec78ee84ee00d2d26f269d3::llv_sync::sync_protocol_balance<T0, T1>(arg0, arg2, arg3, arg4);
    }

    public fun sync_protocol_balance_by_auth<T0, T1, T2>(arg0: &mut 0xc0b2d3f71a30453e0606923a024acf9597909c8c5ec78ee84ee00d2d26f269d3::llv_pool::LLVPool<T0, T1>, arg1: u8, arg2: u128, arg3: &0x2::clock::Clock, arg4: &T2) {
        0xc0b2d3f71a30453e0606923a024acf9597909c8c5ec78ee84ee00d2d26f269d3::llv_pool::assert_protocol_leg_auth<T0, T1, T2>(arg0, arg1);
        0xc0b2d3f71a30453e0606923a024acf9597909c8c5ec78ee84ee00d2d26f269d3::llv_sync::sync_protocol_balance<T0, T1>(arg0, arg1, arg2, arg3);
    }

    public fun withdraw_receipt_pool_id<T0, T1>(arg0: &WithdrawReceipt<T0, T1>) : 0x2::object::ID {
        arg0.pool_id
    }

    public fun withdraw_receipt_shares<T0, T1>(arg0: &WithdrawReceipt<T0, T1>) : u128 {
        arg0.shares_to_withdraw
    }

    // decompiled from Move bytecode v6
}

