module 0x72a8521f978988834733b91c51ab34c14ac396922ba52bc419080c12ea0d2933::limit_order {
    struct LIMIT_ORDER has drop {
        dummy_field: bool,
    }

    struct LimitOrder<phantom T0, phantom T1> has store, key {
        id: 0x2::object::UID,
        owner: address,
        rate_order_indexer_id: 0x2::object::ID,
        pay_balance: 0x2::balance::Balance<T0>,
        target_balance: 0x2::balance::Balance<T1>,
        total_pay_amount: u64,
        obtained_amount: u64,
        claimed_amount: u64,
        rate: u128,
        created_ts: u64,
        expire_ts: u64,
        canceled_ts: u64,
    }

    struct RateOrdersIndexer<phantom T0, phantom T1> has store, key {
        id: 0x2::object::UID,
        indexer: 0x72a8521f978988834733b91c51ab34c14ac396922ba52bc419080c12ea0d2933::skip_list_u128::SkipList<0x2::table::Table<0x2::object::ID, bool>>,
        size: u64,
    }

    struct RateOrdersIndexerSimpleInfo has copy, drop, store {
        indexer_id: 0x2::object::ID,
        indexer_key: 0x2::object::ID,
        pay_coin: 0x1::type_name::TypeName,
        target_coin: 0x1::type_name::TypeName,
    }

    struct RateOrdersIndexers has store, key {
        id: 0x2::object::UID,
        list: 0x2::table::Table<0x2::object::ID, RateOrdersIndexerSimpleInfo>,
        size: u64,
    }

    struct UserOrdersIndexer has store, key {
        id: 0x2::object::UID,
        indexer: 0x2::table::Table<address, 0x2::table::Table<0x2::object::ID, bool>>,
        size: u64,
    }

    struct FlashLoanReceipt<phantom T0> {
        order_id: 0x2::object::ID,
        owner: address,
        target_repay_amount: u64,
    }

    struct InitEvent has copy, drop {
        rate_orders_indexer_id: 0x2::object::ID,
        user_orders_indexer_id: 0x2::object::ID,
    }

    struct RateOrdersIndexerCreatedEvent has copy, drop, store {
        rate_orders_indexer_id: 0x2::object::ID,
        pay_coin: 0x1::ascii::String,
        target_coin: 0x1::ascii::String,
    }

    struct OrderPlacedEvent has copy, drop, store {
        order_id: 0x2::object::ID,
        owner: address,
        rate_orders_indexer_id: 0x2::object::ID,
        pay_coin: 0x1::ascii::String,
        target_coin: 0x1::ascii::String,
        total_pay_amount: u64,
        rate: u128,
        created_ts: u64,
        expire_ts: u64,
    }

    struct OrderCanceledEvent has copy, drop, store {
        order_id: 0x2::object::ID,
        rate_orders_indexer_id: 0x2::object::ID,
        owner: address,
        total_pay_amount: u64,
        remaining_pay_amount: u64,
        remaining_target_amount: u64,
        rate: u128,
        expire_ts: u64,
        cancel_reason: u8,
    }

    struct FlashLoanEvent has copy, drop, store {
        order_id: 0x2::object::ID,
        amount: u64,
        remaining_amount: u64,
        target_repay_amount: u64,
        owner: address,
        borrower: address,
    }

    struct RepayFlashLoanEvent has copy, drop, store {
        order_id: 0x2::object::ID,
        repay_amount: u64,
        repayer: address,
    }

    struct ClaimTargetCoinEvent has copy, drop, store {
        order_id: 0x2::object::ID,
        claimed_amount: u64,
    }

    struct QueryUserIndexerEvent has copy, drop, store {
        owner: address,
        orders_table_id: 0x2::object::ID,
    }

    struct QueryRateIndexerEvent has copy, drop, store {
        rate: u128,
        orders_table_id: 0x2::object::ID,
    }

    fun add_order_indexes<T0, T1>(arg0: &LimitOrder<T0, T1>, arg1: &mut RateOrdersIndexer<T0, T1>, arg2: &mut UserOrdersIndexer, arg3: &mut 0x2::tx_context::TxContext) {
        let v0 = 0x2::object::uid_to_inner(&arg0.id);
        if (!0x72a8521f978988834733b91c51ab34c14ac396922ba52bc419080c12ea0d2933::skip_list_u128::contains<0x2::table::Table<0x2::object::ID, bool>>(&arg1.indexer, arg0.rate)) {
            0x72a8521f978988834733b91c51ab34c14ac396922ba52bc419080c12ea0d2933::skip_list_u128::insert<0x2::table::Table<0x2::object::ID, bool>>(&mut arg1.indexer, arg0.rate, 0x2::table::new<0x2::object::ID, bool>(arg3));
        };
        let v1 = 0x72a8521f978988834733b91c51ab34c14ac396922ba52bc419080c12ea0d2933::skip_list_u128::borrow_mut<0x2::table::Table<0x2::object::ID, bool>>(&mut arg1.indexer, arg0.rate);
        assert!(!0x2::table::contains<0x2::object::ID, bool>(v1, v0), 10);
        0x2::table::add<0x2::object::ID, bool>(v1, v0, true);
        arg1.size = arg1.size + 1;
        if (!0x2::table::contains<address, 0x2::table::Table<0x2::object::ID, bool>>(&arg2.indexer, 0x2::tx_context::sender(arg3))) {
            0x2::table::add<address, 0x2::table::Table<0x2::object::ID, bool>>(&mut arg2.indexer, 0x2::tx_context::sender(arg3), 0x2::table::new<0x2::object::ID, bool>(arg3));
        };
        let v2 = 0x2::table::borrow_mut<address, 0x2::table::Table<0x2::object::ID, bool>>(&mut arg2.indexer, 0x2::tx_context::sender(arg3));
        assert!(!0x2::table::contains<0x2::object::ID, bool>(v2, v0), 11);
        0x2::table::add<0x2::object::ID, bool>(v2, v0, true);
        arg2.size = arg2.size + 1;
    }

    fun cancel_order<T0, T1>(arg0: &mut RateOrdersIndexer<T0, T1>, arg1: &mut LimitOrder<T0, T1>, arg2: u8, arg3: &0x2::clock::Clock, arg4: &mut 0x2::tx_context::TxContext) {
        delete_rate_order_indexs<T0, T1>(arg1, arg0);
        let v0 = 0;
        let v1 = 0;
        if (0x2::balance::value<T0>(&arg1.pay_balance) > 0) {
            v0 = 0x2::balance::value<T0>(&arg1.pay_balance);
            v1 = 0x2::balance::value<T1>(&arg1.target_balance);
            0x2::transfer::public_transfer<0x2::coin::Coin<T0>>(0x2::coin::from_balance<T0>(0x2::balance::withdraw_all<T0>(&mut arg1.pay_balance), arg4), arg1.owner);
            0x2::transfer::public_transfer<0x2::coin::Coin<T1>>(0x2::coin::from_balance<T1>(0x2::balance::withdraw_all<T1>(&mut arg1.target_balance), arg4), arg1.owner);
        };
        arg1.canceled_ts = 0x2::clock::timestamp_ms(arg3);
        let v2 = OrderCanceledEvent{
            order_id                : 0x2::object::id<LimitOrder<T0, T1>>(arg1),
            rate_orders_indexer_id  : 0x2::object::id<RateOrdersIndexer<T0, T1>>(arg0),
            owner                   : arg1.owner,
            total_pay_amount        : arg1.total_pay_amount,
            remaining_pay_amount    : v0,
            remaining_target_amount : v1,
            rate                    : arg1.rate,
            expire_ts               : arg1.expire_ts,
            cancel_reason           : arg2,
        };
        0x2::event::emit<OrderCanceledEvent>(v2);
    }

    public fun cancel_order_by_keeper<T0, T1>(arg0: &0x72a8521f978988834733b91c51ab34c14ac396922ba52bc419080c12ea0d2933::config::GlobalConfig, arg1: &mut RateOrdersIndexer<T0, T1>, arg2: &mut LimitOrder<T0, T1>, arg3: &0x2::clock::Clock, arg4: &mut 0x2::tx_context::TxContext) {
        0x72a8521f978988834733b91c51ab34c14ac396922ba52bc419080c12ea0d2933::config::checked_package_version(arg0);
        0x72a8521f978988834733b91c51ab34c14ac396922ba52bc419080c12ea0d2933::config::checked_kepper(arg0, 0x2::tx_context::sender(arg4));
        let v0 = 0;
        if (0x2::balance::value<T0>(&arg2.pay_balance) == 0) {
            v0 = 3;
        } else if (arg2.expire_ts < 0x2::clock::timestamp_ms(arg3)) {
            v0 = 1;
        };
        assert!(v0 > 0, 9);
        cancel_order<T0, T1>(arg1, arg2, v0, arg3, arg4);
    }

    public fun cancel_order_by_owner<T0, T1>(arg0: &0x72a8521f978988834733b91c51ab34c14ac396922ba52bc419080c12ea0d2933::config::GlobalConfig, arg1: &mut RateOrdersIndexer<T0, T1>, arg2: &mut LimitOrder<T0, T1>, arg3: &0x2::clock::Clock, arg4: &mut 0x2::tx_context::TxContext) {
        0x72a8521f978988834733b91c51ab34c14ac396922ba52bc419080c12ea0d2933::config::checked_package_version(arg0);
        assert!(arg2.owner == 0x2::tx_context::sender(arg4), 13);
        cancel_order<T0, T1>(arg1, arg2, 2, arg3, arg4);
    }

    public fun claim_target_coin<T0, T1>(arg0: &0x72a8521f978988834733b91c51ab34c14ac396922ba52bc419080c12ea0d2933::config::GlobalConfig, arg1: &mut LimitOrder<T0, T1>, arg2: &mut 0x2::tx_context::TxContext) {
        0x72a8521f978988834733b91c51ab34c14ac396922ba52bc419080c12ea0d2933::config::checked_package_version(arg0);
        let v0 = 0x2::tx_context::sender(arg2);
        assert!(arg1.owner == v0, 13);
        0x2::transfer::public_transfer<0x2::coin::Coin<T1>>(0x2::coin::from_balance<T1>(0x2::balance::withdraw_all<T1>(&mut arg1.target_balance), arg2), v0);
        let v1 = ClaimTargetCoinEvent{
            order_id       : 0x2::object::id<LimitOrder<T0, T1>>(arg1),
            claimed_amount : 0x2::balance::value<T1>(&arg1.target_balance),
        };
        0x2::event::emit<ClaimTargetCoinEvent>(v1);
    }

    public entry fun create_indexer_and_place_limit_order<T0, T1>(arg0: &0x72a8521f978988834733b91c51ab34c14ac396922ba52bc419080c12ea0d2933::config::GlobalConfig, arg1: &mut RateOrdersIndexers, arg2: &mut UserOrdersIndexer, arg3: 0x2::coin::Coin<T0>, arg4: u128, arg5: u64, arg6: &0x2::clock::Clock, arg7: &mut 0x2::tx_context::TxContext) {
        0x72a8521f978988834733b91c51ab34c14ac396922ba52bc419080c12ea0d2933::config::checked_package_version(arg0);
        let v0 = 0x2::clock::timestamp_ms(arg6);
        let v1 = create_rate_orders_indexer_internal<T0, T1>(arg0, arg1, v0, arg7);
        let v2 = 0x2::object::id<RateOrdersIndexer<T0, T1>>(&v1);
        let v3 = new_limit_order<T0, T1>(0x2::coin::into_balance<T0>(arg3), v2, arg4, v0, arg5, arg7);
        let v4 = OrderPlacedEvent{
            order_id               : 0x2::object::id<LimitOrder<T0, T1>>(&v3),
            owner                  : 0x2::tx_context::sender(arg7),
            rate_orders_indexer_id : v2,
            pay_coin               : 0x1::type_name::into_string(0x1::type_name::get<T0>()),
            target_coin            : 0x1::type_name::into_string(0x1::type_name::get<T1>()),
            total_pay_amount       : v3.total_pay_amount,
            rate                   : v3.rate,
            created_ts             : v0,
            expire_ts              : arg5,
        };
        0x2::event::emit<OrderPlacedEvent>(v4);
        let v5 = &mut v1;
        add_order_indexes<T0, T1>(&v3, v5, arg2, arg7);
        0x2::transfer::public_share_object<RateOrdersIndexer<T0, T1>>(v1);
        0x2::transfer::public_share_object<LimitOrder<T0, T1>>(v3);
    }

    public entry fun create_rate_orders_indexer<T0, T1>(arg0: &0x72a8521f978988834733b91c51ab34c14ac396922ba52bc419080c12ea0d2933::config::GlobalConfig, arg1: &mut RateOrdersIndexers, arg2: &0x2::clock::Clock, arg3: &mut 0x2::tx_context::TxContext) {
        0x72a8521f978988834733b91c51ab34c14ac396922ba52bc419080c12ea0d2933::config::checked_package_version(arg0);
        0x2::transfer::public_share_object<RateOrdersIndexer<T0, T1>>(create_rate_orders_indexer_internal<T0, T1>(arg0, arg1, 0x2::clock::timestamp_ms(arg2), arg3));
    }

    fun create_rate_orders_indexer_internal<T0, T1>(arg0: &0x72a8521f978988834733b91c51ab34c14ac396922ba52bc419080c12ea0d2933::config::GlobalConfig, arg1: &mut RateOrdersIndexers, arg2: u64, arg3: &mut 0x2::tx_context::TxContext) : RateOrdersIndexer<T0, T1> {
        0x72a8521f978988834733b91c51ab34c14ac396922ba52bc419080c12ea0d2933::config::checked_pool_token_types<T0, T1>(arg0);
        let v0 = 0x1::type_name::get<T0>();
        let v1 = 0x1::type_name::get<T1>();
        assert!(v0 != v1, 1);
        let v2 = new_rate_orders_indexer<T0, T1>(arg2, arg3);
        let v3 = 0x2::object::id<RateOrdersIndexer<T0, T1>>(&v2);
        let v4 = new_pool_key<T0, T1>();
        let v5 = RateOrdersIndexerSimpleInfo{
            indexer_id  : v3,
            indexer_key : v4,
            pay_coin    : v0,
            target_coin : v1,
        };
        if (0x2::table::contains<0x2::object::ID, RateOrdersIndexerSimpleInfo>(&arg1.list, v4)) {
            abort 0
        };
        0x2::table::add<0x2::object::ID, RateOrdersIndexerSimpleInfo>(&mut arg1.list, v4, v5);
        arg1.size = arg1.size + 1;
        let v6 = RateOrdersIndexerCreatedEvent{
            rate_orders_indexer_id : v3,
            pay_coin               : 0x1::type_name::into_string(v0),
            target_coin            : 0x1::type_name::into_string(v1),
        };
        0x2::event::emit<RateOrdersIndexerCreatedEvent>(v6);
        v2
    }

    fun delete_limit_order<T0, T1>(arg0: &0x72a8521f978988834733b91c51ab34c14ac396922ba52bc419080c12ea0d2933::config::GlobalConfig, arg1: LimitOrder<T0, T1>, arg2: &mut UserOrdersIndexer, arg3: &0x2::clock::Clock, arg4: &0x2::tx_context::TxContext) {
        assert!(arg1.canceled_ts != 18446744073709551615, 8);
        assert!(0x2::clock::timestamp_ms(arg3) > arg1.canceled_ts + 0x72a8521f978988834733b91c51ab34c14ac396922ba52bc419080c12ea0d2933::config::get_config_deletion_grace_period(arg0), 12);
        delete_user_order_indexs<T0, T1>(&arg1, arg2, arg4);
        destory_limit_order<T0, T1>(arg1);
    }

    public fun delete_order<T0, T1>(arg0: &0x72a8521f978988834733b91c51ab34c14ac396922ba52bc419080c12ea0d2933::config::GlobalConfig, arg1: LimitOrder<T0, T1>, arg2: &mut UserOrdersIndexer, arg3: &0x2::clock::Clock, arg4: &0x2::tx_context::TxContext) {
        0x72a8521f978988834733b91c51ab34c14ac396922ba52bc419080c12ea0d2933::config::checked_package_version(arg0);
        0x72a8521f978988834733b91c51ab34c14ac396922ba52bc419080c12ea0d2933::config::checked_kepper(arg0, 0x2::tx_context::sender(arg4));
        delete_limit_order<T0, T1>(arg0, arg1, arg2, arg3, arg4);
    }

    fun delete_rate_order_indexs<T0, T1>(arg0: &LimitOrder<T0, T1>, arg1: &mut RateOrdersIndexer<T0, T1>) {
        if (!0x72a8521f978988834733b91c51ab34c14ac396922ba52bc419080c12ea0d2933::skip_list_u128::contains<0x2::table::Table<0x2::object::ID, bool>>(&arg1.indexer, arg0.rate)) {
            abort 3
        };
        0x2::table::remove<0x2::object::ID, bool>(0x72a8521f978988834733b91c51ab34c14ac396922ba52bc419080c12ea0d2933::skip_list_u128::borrow_mut<0x2::table::Table<0x2::object::ID, bool>>(&mut arg1.indexer, arg0.rate), 0x2::object::uid_to_inner(&arg0.id));
        arg1.size = arg1.size - 1;
    }

    fun delete_user_order_indexs<T0, T1>(arg0: &LimitOrder<T0, T1>, arg1: &mut UserOrdersIndexer, arg2: &0x2::tx_context::TxContext) {
        if (!0x2::table::contains<address, 0x2::table::Table<0x2::object::ID, bool>>(&arg1.indexer, 0x2::tx_context::sender(arg2))) {
            abort 4
        };
        0x2::table::remove<0x2::object::ID, bool>(0x2::table::borrow_mut<address, 0x2::table::Table<0x2::object::ID, bool>>(&mut arg1.indexer, 0x2::tx_context::sender(arg2)), 0x2::object::uid_to_inner(&arg0.id));
        arg1.size = arg1.size - 1;
    }

    fun destory_limit_order<T0, T1>(arg0: LimitOrder<T0, T1>) {
        let LimitOrder {
            id                    : v0,
            owner                 : _,
            rate_order_indexer_id : _,
            pay_balance           : v3,
            target_balance        : v4,
            total_pay_amount      : _,
            obtained_amount       : _,
            claimed_amount        : _,
            rate                  : _,
            created_ts            : _,
            expire_ts             : _,
            canceled_ts           : _,
        } = arg0;
        0x2::balance::destroy_zero<T0>(v3);
        0x2::balance::destroy_zero<T1>(v4);
        0x2::object::delete(v0);
    }

    public fun flash_loan<T0, T1>(arg0: &0x72a8521f978988834733b91c51ab34c14ac396922ba52bc419080c12ea0d2933::config::GlobalConfig, arg1: &mut LimitOrder<T0, T1>, arg2: u64, arg3: &0x2::clock::Clock, arg4: &mut 0x2::tx_context::TxContext) : (0x2::coin::Coin<T0>, FlashLoanReceipt<T1>) {
        0x72a8521f978988834733b91c51ab34c14ac396922ba52bc419080c12ea0d2933::config::checked_package_version(arg0);
        let v0 = 0x2::tx_context::sender(arg4);
        if (0x72a8521f978988834733b91c51ab34c14ac396922ba52bc419080c12ea0d2933::config::get_config_require_flash_loan_auth(arg0)) {
            0x72a8521f978988834733b91c51ab34c14ac396922ba52bc419080c12ea0d2933::config::checked_kepper(arg0, v0);
        };
        assert!(arg2 > 0, 5);
        assert!(0x2::clock::timestamp_ms(arg3) < arg1.expire_ts, 6);
        assert!(0x72a8521f978988834733b91c51ab34c14ac396922ba52bc419080c12ea0d2933::config::check_token_and_min_trade_amount<T0>(arg0, arg2), 14);
        assert!(arg1.rate > 0, 15);
        let v1 = 0x714a63a0dba6da4f017b42d5d0fb78867f18bcde904868e51d951a5a6f5b7f57::full_math_u128::mul_div_ceil((arg2 as u128), 1000000000000000000, arg1.rate);
        if (v1 > 18446744073709551615) {
            abort 16
        };
        let v2 = (v1 as u64);
        let v3 = v2;
        let v4 = FlashLoanReceipt<T1>{
            order_id            : 0x2::object::id<LimitOrder<T0, T1>>(arg1),
            owner               : arg1.owner,
            target_repay_amount : v2,
        };
        let v5 = 0x714a63a0dba6da4f017b42d5d0fb78867f18bcde904868e51d951a5a6f5b7f57::full_math_u128::mul_div_ceil((arg1.total_pay_amount as u128), 1000000000000000000, arg1.rate);
        if (v5 > 18446744073709551615) {
            abort 16
        };
        let v6 = (v5 as u64);
        if (arg1.obtained_amount + v2 >= v6) {
            v3 = v6 - arg1.obtained_amount;
            arg1.obtained_amount = v6;
        } else {
            arg1.obtained_amount = arg1.obtained_amount + v2;
        };
        let v7 = FlashLoanEvent{
            order_id            : 0x2::object::id<LimitOrder<T0, T1>>(arg1),
            amount              : arg2,
            remaining_amount    : 0x2::balance::value<T0>(&arg1.pay_balance),
            target_repay_amount : v3,
            owner               : arg1.owner,
            borrower            : v0,
        };
        0x2::event::emit<FlashLoanEvent>(v7);
        (0x2::coin::from_balance<T0>(0x2::balance::split<T0>(&mut arg1.pay_balance, arg2), arg4), v4)
    }

    public entry fun get_orders_indexer_by_owner(arg0: address, arg1: &UserOrdersIndexer) {
        let v0 = QueryUserIndexerEvent{
            owner           : arg0,
            orders_table_id : 0x2::object::id<0x2::table::Table<0x2::object::ID, bool>>(0x2::table::borrow<address, 0x2::table::Table<0x2::object::ID, bool>>(&arg1.indexer, arg0)),
        };
        0x2::event::emit<QueryUserIndexerEvent>(v0);
    }

    public entry fun get_orders_indexer_by_rate<T0, T1>(arg0: u128, arg1: &RateOrdersIndexer<T0, T1>) {
        let v0 = QueryRateIndexerEvent{
            rate            : arg0,
            orders_table_id : 0x2::object::id<0x2::table::Table<0x2::object::ID, bool>>(0x72a8521f978988834733b91c51ab34c14ac396922ba52bc419080c12ea0d2933::skip_list_u128::borrow<0x2::table::Table<0x2::object::ID, bool>>(&arg1.indexer, arg0)),
        };
        0x2::event::emit<QueryRateIndexerEvent>(v0);
    }

    fun init(arg0: LIMIT_ORDER, arg1: &mut 0x2::tx_context::TxContext) {
        0x2::transfer::public_transfer<0x2::package::Publisher>(0x2::package::claim<LIMIT_ORDER>(arg0, arg1), 0x2::tx_context::sender(arg1));
        let v0 = RateOrdersIndexers{
            id   : 0x2::object::new(arg1),
            list : 0x2::table::new<0x2::object::ID, RateOrdersIndexerSimpleInfo>(arg1),
            size : 0,
        };
        0x2::transfer::share_object<RateOrdersIndexers>(v0);
        let v1 = UserOrdersIndexer{
            id      : 0x2::object::new(arg1),
            indexer : 0x2::table::new<address, 0x2::table::Table<0x2::object::ID, bool>>(arg1),
            size    : 0,
        };
        0x2::transfer::share_object<UserOrdersIndexer>(v1);
        let v2 = InitEvent{
            rate_orders_indexer_id : 0x2::object::id<RateOrdersIndexers>(&v0),
            user_orders_indexer_id : 0x2::object::id<UserOrdersIndexer>(&v1),
        };
        0x2::event::emit<InitEvent>(v2);
    }

    public fun join_coin<T0>(arg0: &mut 0x2::coin::Coin<T0>, arg1: 0x2::coin::Coin<T0>) {
        0x2::coin::put<T0>(0x2::coin::balance_mut<T0>(arg0), arg1);
    }

    fun new_limit_order<T0, T1>(arg0: 0x2::balance::Balance<T0>, arg1: 0x2::object::ID, arg2: u128, arg3: u64, arg4: u64, arg5: &mut 0x2::tx_context::TxContext) : LimitOrder<T0, T1> {
        LimitOrder<T0, T1>{
            id                    : 0x2::object::new(arg5),
            owner                 : 0x2::tx_context::sender(arg5),
            rate_order_indexer_id : arg1,
            pay_balance           : arg0,
            target_balance        : 0x2::balance::zero<T1>(),
            total_pay_amount      : 0x2::balance::value<T0>(&arg0),
            obtained_amount       : 0,
            claimed_amount        : 0,
            rate                  : arg2,
            created_ts            : arg3,
            expire_ts             : arg4,
            canceled_ts           : 18446744073709551615,
        }
    }

    fun new_pool_key<T0, T1>() : 0x2::object::ID {
        let v0 = 0x1::type_name::into_string(0x1::type_name::get<T0>());
        let v1 = *0x1::ascii::as_bytes(&v0);
        let v2 = 0x1::type_name::into_string(0x1::type_name::get<T1>());
        0x1::vector::append<u8>(&mut v1, *0x1::ascii::as_bytes(&v2));
        0x2::object::id_from_bytes(0x2::hash::blake2b256(&v1))
    }

    fun new_rate_orders_indexer<T0, T1>(arg0: u64, arg1: &mut 0x2::tx_context::TxContext) : RateOrdersIndexer<T0, T1> {
        RateOrdersIndexer<T0, T1>{
            id      : 0x2::object::new(arg1),
            indexer : 0x72a8521f978988834733b91c51ab34c14ac396922ba52bc419080c12ea0d2933::skip_list_u128::new<0x2::table::Table<0x2::object::ID, bool>>(20, 2, arg0, arg1),
            size    : 0,
        }
    }

    public entry fun place_limit_order<T0, T1>(arg0: &0x72a8521f978988834733b91c51ab34c14ac396922ba52bc419080c12ea0d2933::config::GlobalConfig, arg1: &mut RateOrdersIndexer<T0, T1>, arg2: &mut UserOrdersIndexer, arg3: 0x2::coin::Coin<T0>, arg4: u128, arg5: u64, arg6: &0x2::clock::Clock, arg7: &mut 0x2::tx_context::TxContext) {
        0x72a8521f978988834733b91c51ab34c14ac396922ba52bc419080c12ea0d2933::config::checked_package_version(arg0);
        assert!(arg4 > 0, 15);
        let v0 = 0x2::coin::into_balance<T0>(arg3);
        let v1 = 0x2::clock::timestamp_ms(arg6);
        let v2 = 0x2::object::id<RateOrdersIndexer<T0, T1>>(arg1);
        if (0x714a63a0dba6da4f017b42d5d0fb78867f18bcde904868e51d951a5a6f5b7f57::full_math_u128::mul_div_ceil((0x2::balance::value<T0>(&v0) as u128), 1000000000000000000, arg4) > 18446744073709551615) {
            abort 16
        };
        let v3 = new_limit_order<T0, T1>(v0, v2, arg4, v1, arg5, arg7);
        let v4 = OrderPlacedEvent{
            order_id               : 0x2::object::id<LimitOrder<T0, T1>>(&v3),
            owner                  : 0x2::tx_context::sender(arg7),
            rate_orders_indexer_id : v2,
            pay_coin               : 0x1::type_name::into_string(0x1::type_name::get<T0>()),
            target_coin            : 0x1::type_name::into_string(0x1::type_name::get<T1>()),
            total_pay_amount       : v3.total_pay_amount,
            rate                   : v3.rate,
            created_ts             : v1,
            expire_ts              : arg5,
        };
        0x2::event::emit<OrderPlacedEvent>(v4);
        add_order_indexes<T0, T1>(&v3, arg1, arg2, arg7);
        0x2::transfer::public_share_object<LimitOrder<T0, T1>>(v3);
    }

    public fun repay_flash_loan<T0, T1>(arg0: &0x72a8521f978988834733b91c51ab34c14ac396922ba52bc419080c12ea0d2933::config::GlobalConfig, arg1: &mut 0x2::coin::Coin<T1>, arg2: &mut LimitOrder<T0, T1>, arg3: FlashLoanReceipt<T1>, arg4: &mut 0x2::tx_context::TxContext) {
        0x72a8521f978988834733b91c51ab34c14ac396922ba52bc419080c12ea0d2933::config::checked_package_version(arg0);
        let v0 = 0x2::tx_context::sender(arg4);
        if (0x72a8521f978988834733b91c51ab34c14ac396922ba52bc419080c12ea0d2933::config::get_config_require_flash_loan_auth(arg0)) {
            0x72a8521f978988834733b91c51ab34c14ac396922ba52bc419080c12ea0d2933::config::checked_kepper(arg0, v0);
        };
        assert!(0x2::coin::value<T1>(arg1) >= arg3.target_repay_amount, 7);
        let FlashLoanReceipt {
            order_id            : v1,
            owner               : _,
            target_repay_amount : v3,
        } = arg3;
        0x2::balance::join<T1>(&mut arg2.target_balance, 0x2::coin::into_balance<T1>(0x2::coin::split<T1>(arg1, v3, arg4)));
        if (0x2::balance::value<T0>(&arg2.pay_balance) == 0) {
            0x2::transfer::public_transfer<0x2::coin::Coin<T1>>(0x2::coin::from_balance<T1>(0x2::balance::withdraw_all<T1>(&mut arg2.target_balance), arg4), arg2.owner);
        };
        let v4 = RepayFlashLoanEvent{
            order_id     : v1,
            repay_amount : v3,
            repayer      : v0,
        };
        0x2::event::emit<RepayFlashLoanEvent>(v4);
    }

    // decompiled from Move bytecode v6
}

