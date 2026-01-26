module 0x1ffaf092ba4c8b863a637738ce1a7a6cb6b12fa8cddf1dcfe6137b30a8ee9e8c::limit_order {
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
        indexer: 0x2::table::Table<u128, 0x2::table::Table<0x2::object::ID, bool>>,
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
        if (!0x2::table::contains<u128, 0x2::table::Table<0x2::object::ID, bool>>(&arg1.indexer, arg0.rate)) {
            0x2::table::add<u128, 0x2::table::Table<0x2::object::ID, bool>>(&mut arg1.indexer, arg0.rate, 0x2::table::new<0x2::object::ID, bool>(arg3));
        };
        let v1 = 0x2::table::borrow_mut<u128, 0x2::table::Table<0x2::object::ID, bool>>(&mut arg1.indexer, arg0.rate);
        assert!(!0x2::table::contains<0x2::object::ID, bool>(v1, v0), 10);
        0x2::table::add<0x2::object::ID, bool>(v1, v0, true);
        arg1.size = arg1.size + 1;
        let v2 = 0x2::tx_context::sender(arg3);
        if (!0x2::table::contains<address, 0x2::table::Table<0x2::object::ID, bool>>(&arg2.indexer, v2)) {
            0x2::table::add<address, 0x2::table::Table<0x2::object::ID, bool>>(&mut arg2.indexer, v2, 0x2::table::new<0x2::object::ID, bool>(arg3));
        };
        let v3 = 0x2::table::borrow_mut<address, 0x2::table::Table<0x2::object::ID, bool>>(&mut arg2.indexer, v2);
        assert!(!0x2::table::contains<0x2::object::ID, bool>(v3, v0), 11);
        0x2::table::add<0x2::object::ID, bool>(v3, v0, true);
        arg2.size = arg2.size + 1;
    }

    fun cancel_order<T0, T1>(arg0: &mut RateOrdersIndexer<T0, T1>, arg1: &mut LimitOrder<T0, T1>, arg2: u8, arg3: &0x2::clock::Clock, arg4: &mut 0x2::tx_context::TxContext) {
        delete_rate_order_indexes<T0, T1>(arg1, arg0);
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

    public fun cancel_order_by_keeper<T0, T1>(arg0: &0x1ffaf092ba4c8b863a637738ce1a7a6cb6b12fa8cddf1dcfe6137b30a8ee9e8c::base_config::BaseConfig, arg1: &mut RateOrdersIndexer<T0, T1>, arg2: &mut LimitOrder<T0, T1>, arg3: &0x2::clock::Clock, arg4: &mut 0x2::tx_context::TxContext) {
        0x1ffaf092ba4c8b863a637738ce1a7a6cb6b12fa8cddf1dcfe6137b30a8ee9e8c::base_config::checked_package_version(arg0);
        0x1ffaf092ba4c8b863a637738ce1a7a6cb6b12fa8cddf1dcfe6137b30a8ee9e8c::limit_order_config::checked_keeper(arg0, 0x2::tx_context::sender(arg4));
        let v0 = 0;
        if (0x2::balance::value<T0>(&arg2.pay_balance) == 0) {
            v0 = 3;
        } else if (arg2.expire_ts < 0x2::clock::timestamp_ms(arg3)) {
            v0 = 1;
        };
        assert!(v0 > 0, 9);
        cancel_order<T0, T1>(arg1, arg2, v0, arg3, arg4);
    }

    public fun cancel_order_by_owner<T0, T1>(arg0: &0x1ffaf092ba4c8b863a637738ce1a7a6cb6b12fa8cddf1dcfe6137b30a8ee9e8c::base_config::BaseConfig, arg1: &mut RateOrdersIndexer<T0, T1>, arg2: &mut LimitOrder<T0, T1>, arg3: &0x2::clock::Clock, arg4: &mut 0x2::tx_context::TxContext) {
        0x1ffaf092ba4c8b863a637738ce1a7a6cb6b12fa8cddf1dcfe6137b30a8ee9e8c::base_config::checked_package_version(arg0);
        assert!(arg2.owner == 0x2::tx_context::sender(arg4), 13);
        cancel_order<T0, T1>(arg1, arg2, 2, arg3, arg4);
    }

    public fun claim_target_coin<T0, T1>(arg0: &0x1ffaf092ba4c8b863a637738ce1a7a6cb6b12fa8cddf1dcfe6137b30a8ee9e8c::base_config::BaseConfig, arg1: &mut LimitOrder<T0, T1>, arg2: &mut 0x2::tx_context::TxContext) {
        0x1ffaf092ba4c8b863a637738ce1a7a6cb6b12fa8cddf1dcfe6137b30a8ee9e8c::base_config::checked_package_version(arg0);
        let v0 = 0x2::tx_context::sender(arg2);
        assert!(arg1.owner == v0, 13);
        0x2::transfer::public_transfer<0x2::coin::Coin<T1>>(0x2::coin::from_balance<T1>(0x2::balance::withdraw_all<T1>(&mut arg1.target_balance), arg2), v0);
        let v1 = ClaimTargetCoinEvent{
            order_id       : 0x2::object::id<LimitOrder<T0, T1>>(arg1),
            claimed_amount : 0x2::balance::value<T1>(&arg1.target_balance),
        };
        0x2::event::emit<ClaimTargetCoinEvent>(v1);
    }

    public fun create_indexer_and_place_limit_order<T0, T1>(arg0: &0x1ffaf092ba4c8b863a637738ce1a7a6cb6b12fa8cddf1dcfe6137b30a8ee9e8c::base_config::BaseConfig, arg1: &0x1ffaf092ba4c8b863a637738ce1a7a6cb6b12fa8cddf1dcfe6137b30a8ee9e8c::limit_order_config::LimitOrderConfig, arg2: &mut RateOrdersIndexers, arg3: &mut UserOrdersIndexer, arg4: 0x2::coin::Coin<T0>, arg5: u128, arg6: u64, arg7: &0x2::clock::Clock, arg8: &mut 0x2::tx_context::TxContext) {
        0x1ffaf092ba4c8b863a637738ce1a7a6cb6b12fa8cddf1dcfe6137b30a8ee9e8c::base_config::checked_package_version(arg0);
        0x1ffaf092ba4c8b863a637738ce1a7a6cb6b12fa8cddf1dcfe6137b30a8ee9e8c::limit_order_config::checked_pool_token_types<T0, T1>(arg1);
        assert!(arg5 > 0, 15);
        let v0 = 0x2::clock::timestamp_ms(arg7);
        assert!(arg6 > v0, 18);
        let v1 = create_rate_orders_indexer_internal<T0, T1>(arg1, arg2, arg8);
        assert!(0x2::coin::value<T0>(&arg4) > 0, 19);
        let v2 = 0x2::coin::into_balance<T0>(arg4);
        let v3 = 0x2::object::id<RateOrdersIndexer<T0, T1>>(&v1);
        assert!(mul_div_ceil((0x2::balance::value<T0>(&v2) as u128), 1000000000000000000, arg5) <= (18446744073709551615 as u128), 16);
        let v4 = new_limit_order<T0, T1>(v2, v3, arg5, v0, arg6, arg8);
        let v5 = OrderPlacedEvent{
            order_id               : 0x2::object::id<LimitOrder<T0, T1>>(&v4),
            owner                  : 0x2::tx_context::sender(arg8),
            rate_orders_indexer_id : v3,
            pay_coin               : 0x1::type_name::into_string(0x1::type_name::get<T0>()),
            target_coin            : 0x1::type_name::into_string(0x1::type_name::get<T1>()),
            total_pay_amount       : v4.total_pay_amount,
            rate                   : arg5,
            created_ts             : v0,
            expire_ts              : arg6,
        };
        0x2::event::emit<OrderPlacedEvent>(v5);
        let v6 = &mut v1;
        add_order_indexes<T0, T1>(&v4, v6, arg3, arg8);
        0x2::transfer::public_share_object<RateOrdersIndexer<T0, T1>>(v1);
        0x2::transfer::public_share_object<LimitOrder<T0, T1>>(v4);
    }

    public fun create_rate_orders_indexer<T0, T1>(arg0: &0x1ffaf092ba4c8b863a637738ce1a7a6cb6b12fa8cddf1dcfe6137b30a8ee9e8c::base_config::BaseConfig, arg1: &0x1ffaf092ba4c8b863a637738ce1a7a6cb6b12fa8cddf1dcfe6137b30a8ee9e8c::limit_order_config::LimitOrderConfig, arg2: &mut RateOrdersIndexers, arg3: &mut 0x2::tx_context::TxContext) {
        0x1ffaf092ba4c8b863a637738ce1a7a6cb6b12fa8cddf1dcfe6137b30a8ee9e8c::base_config::checked_package_version(arg0);
        0x2::transfer::public_share_object<RateOrdersIndexer<T0, T1>>(create_rate_orders_indexer_internal<T0, T1>(arg1, arg2, arg3));
    }

    fun create_rate_orders_indexer_internal<T0, T1>(arg0: &0x1ffaf092ba4c8b863a637738ce1a7a6cb6b12fa8cddf1dcfe6137b30a8ee9e8c::limit_order_config::LimitOrderConfig, arg1: &mut RateOrdersIndexers, arg2: &mut 0x2::tx_context::TxContext) : RateOrdersIndexer<T0, T1> {
        0x1ffaf092ba4c8b863a637738ce1a7a6cb6b12fa8cddf1dcfe6137b30a8ee9e8c::limit_order_config::checked_pool_token_types<T0, T1>(arg0);
        let v0 = 0x1::type_name::get<T0>();
        let v1 = 0x1::type_name::get<T1>();
        assert!(v0 != v1, 1);
        let v2 = new_rate_orders_indexer<T0, T1>(arg2);
        let v3 = 0x2::object::id<RateOrdersIndexer<T0, T1>>(&v2);
        let v4 = new_pool_key<T0, T1>();
        let v5 = RateOrdersIndexerSimpleInfo{
            indexer_id  : v3,
            indexer_key : v4,
            pay_coin    : v0,
            target_coin : v1,
        };
        assert!(!0x2::table::contains<0x2::object::ID, RateOrdersIndexerSimpleInfo>(&arg1.list, v4), 0);
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

    fun delete_limit_order<T0, T1>(arg0: &0x1ffaf092ba4c8b863a637738ce1a7a6cb6b12fa8cddf1dcfe6137b30a8ee9e8c::limit_order_config::LimitOrderConfig, arg1: LimitOrder<T0, T1>, arg2: &mut UserOrdersIndexer, arg3: &0x2::clock::Clock, arg4: &0x2::tx_context::TxContext) {
        assert!(arg1.canceled_ts != 18446744073709551615, 8);
        assert!(0x2::clock::timestamp_ms(arg3) > arg1.canceled_ts + 0x1ffaf092ba4c8b863a637738ce1a7a6cb6b12fa8cddf1dcfe6137b30a8ee9e8c::limit_order_config::get_deletion_grace_period(arg0), 12);
        delete_user_order_indexes<T0, T1>(&arg1, arg2, arg4);
        destroy_limit_order<T0, T1>(arg1);
    }

    public fun delete_order<T0, T1>(arg0: &0x1ffaf092ba4c8b863a637738ce1a7a6cb6b12fa8cddf1dcfe6137b30a8ee9e8c::base_config::BaseConfig, arg1: &0x1ffaf092ba4c8b863a637738ce1a7a6cb6b12fa8cddf1dcfe6137b30a8ee9e8c::limit_order_config::LimitOrderConfig, arg2: LimitOrder<T0, T1>, arg3: &mut UserOrdersIndexer, arg4: &0x2::clock::Clock, arg5: &0x2::tx_context::TxContext) {
        0x1ffaf092ba4c8b863a637738ce1a7a6cb6b12fa8cddf1dcfe6137b30a8ee9e8c::base_config::checked_package_version(arg0);
        0x1ffaf092ba4c8b863a637738ce1a7a6cb6b12fa8cddf1dcfe6137b30a8ee9e8c::limit_order_config::checked_keeper(arg0, 0x2::tx_context::sender(arg5));
        delete_limit_order<T0, T1>(arg1, arg2, arg3, arg4, arg5);
    }

    fun delete_rate_order_indexes<T0, T1>(arg0: &LimitOrder<T0, T1>, arg1: &mut RateOrdersIndexer<T0, T1>) {
        assert!(0x2::table::contains<u128, 0x2::table::Table<0x2::object::ID, bool>>(&arg1.indexer, arg0.rate), 3);
        0x2::table::remove<0x2::object::ID, bool>(0x2::table::borrow_mut<u128, 0x2::table::Table<0x2::object::ID, bool>>(&mut arg1.indexer, arg0.rate), 0x2::object::uid_to_inner(&arg0.id));
        arg1.size = arg1.size - 1;
    }

    fun delete_user_order_indexes<T0, T1>(arg0: &LimitOrder<T0, T1>, arg1: &mut UserOrdersIndexer, arg2: &0x2::tx_context::TxContext) {
        let v0 = 0x2::tx_context::sender(arg2);
        assert!(0x2::table::contains<address, 0x2::table::Table<0x2::object::ID, bool>>(&arg1.indexer, v0), 4);
        0x2::table::remove<0x2::object::ID, bool>(0x2::table::borrow_mut<address, 0x2::table::Table<0x2::object::ID, bool>>(&mut arg1.indexer, v0), 0x2::object::uid_to_inner(&arg0.id));
        arg1.size = arg1.size - 1;
    }

    fun destroy_limit_order<T0, T1>(arg0: LimitOrder<T0, T1>) {
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

    public fun flash_loan<T0, T1>(arg0: &0x1ffaf092ba4c8b863a637738ce1a7a6cb6b12fa8cddf1dcfe6137b30a8ee9e8c::base_config::BaseConfig, arg1: &0x1ffaf092ba4c8b863a637738ce1a7a6cb6b12fa8cddf1dcfe6137b30a8ee9e8c::limit_order_config::LimitOrderConfig, arg2: &mut LimitOrder<T0, T1>, arg3: u64, arg4: &0x2::clock::Clock, arg5: &mut 0x2::tx_context::TxContext) : (0x2::coin::Coin<T0>, FlashLoanReceipt<T1>) {
        0x1ffaf092ba4c8b863a637738ce1a7a6cb6b12fa8cddf1dcfe6137b30a8ee9e8c::base_config::checked_package_version(arg0);
        let v0 = 0x2::tx_context::sender(arg5);
        if (0x1ffaf092ba4c8b863a637738ce1a7a6cb6b12fa8cddf1dcfe6137b30a8ee9e8c::limit_order_config::get_require_flash_loan_auth(arg1)) {
            0x1ffaf092ba4c8b863a637738ce1a7a6cb6b12fa8cddf1dcfe6137b30a8ee9e8c::limit_order_config::checked_keeper(arg0, v0);
        };
        assert!(arg3 > 0, 5);
        assert!(0x2::clock::timestamp_ms(arg4) < arg2.expire_ts, 6);
        assert!(0x1ffaf092ba4c8b863a637738ce1a7a6cb6b12fa8cddf1dcfe6137b30a8ee9e8c::limit_order_config::check_token_and_min_trade_amount<T0>(arg1, arg3), 14);
        assert!(arg2.rate > 0, 15);
        let v1 = mul_div_ceil((arg3 as u128), 1000000000000000000, arg2.rate);
        assert!(v1 <= (18446744073709551615 as u128), 16);
        let v2 = (v1 as u64);
        let v3 = v2;
        let v4 = FlashLoanReceipt<T1>{
            order_id            : 0x2::object::id<LimitOrder<T0, T1>>(arg2),
            owner               : arg2.owner,
            target_repay_amount : v2,
        };
        let v5 = mul_div_ceil((arg2.total_pay_amount as u128), 1000000000000000000, arg2.rate);
        assert!(v5 <= (18446744073709551615 as u128), 16);
        let v6 = (v5 as u64);
        if (arg2.obtained_amount + v2 >= v6) {
            v3 = v6 - arg2.obtained_amount;
            arg2.obtained_amount = v6;
        } else {
            arg2.obtained_amount = arg2.obtained_amount + v2;
        };
        let v7 = FlashLoanEvent{
            order_id            : 0x2::object::id<LimitOrder<T0, T1>>(arg2),
            amount              : arg3,
            remaining_amount    : 0x2::balance::value<T0>(&arg2.pay_balance),
            target_repay_amount : v3,
            owner               : arg2.owner,
            borrower            : v0,
        };
        0x2::event::emit<FlashLoanEvent>(v7);
        (0x2::coin::from_balance<T0>(0x2::balance::split<T0>(&mut arg2.pay_balance, arg3), arg5), v4)
    }

    public fun get_orders_indexer_by_owner(arg0: address, arg1: &UserOrdersIndexer) {
        let v0 = QueryUserIndexerEvent{
            owner           : arg0,
            orders_table_id : 0x2::object::id<0x2::table::Table<0x2::object::ID, bool>>(0x2::table::borrow<address, 0x2::table::Table<0x2::object::ID, bool>>(&arg1.indexer, arg0)),
        };
        0x2::event::emit<QueryUserIndexerEvent>(v0);
    }

    public fun get_orders_indexer_by_rate<T0, T1>(arg0: u128, arg1: &RateOrdersIndexer<T0, T1>) {
        let v0 = QueryRateIndexerEvent{
            rate            : arg0,
            orders_table_id : 0x2::object::id<0x2::table::Table<0x2::object::ID, bool>>(0x2::table::borrow<u128, 0x2::table::Table<0x2::object::ID, bool>>(&arg1.indexer, arg0)),
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

    fun mul_div_ceil(arg0: u128, arg1: u128, arg2: u128) : u128 {
        if (arg0 * arg1 % arg2 > 0) {
            arg0 * arg1 / arg2 + 1
        } else {
            arg0 * arg1 / arg2
        }
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
        let v1 = 0x1::type_name::into_string(0x1::type_name::get<T1>());
        let v2 = *0x1::ascii::as_bytes(&v0);
        0x1::vector::append<u8>(&mut v2, *0x1::ascii::as_bytes(&v1));
        0x2::object::id_from_bytes(0x2::hash::blake2b256(&v2))
    }

    fun new_rate_orders_indexer<T0, T1>(arg0: &mut 0x2::tx_context::TxContext) : RateOrdersIndexer<T0, T1> {
        RateOrdersIndexer<T0, T1>{
            id      : 0x2::object::new(arg0),
            indexer : 0x2::table::new<u128, 0x2::table::Table<0x2::object::ID, bool>>(arg0),
            size    : 0,
        }
    }

    public fun place_limit_order<T0, T1>(arg0: &0x1ffaf092ba4c8b863a637738ce1a7a6cb6b12fa8cddf1dcfe6137b30a8ee9e8c::base_config::BaseConfig, arg1: &0x1ffaf092ba4c8b863a637738ce1a7a6cb6b12fa8cddf1dcfe6137b30a8ee9e8c::limit_order_config::LimitOrderConfig, arg2: &mut RateOrdersIndexer<T0, T1>, arg3: &mut UserOrdersIndexer, arg4: 0x2::coin::Coin<T0>, arg5: u128, arg6: u64, arg7: &0x2::clock::Clock, arg8: &mut 0x2::tx_context::TxContext) {
        0x1ffaf092ba4c8b863a637738ce1a7a6cb6b12fa8cddf1dcfe6137b30a8ee9e8c::base_config::checked_package_version(arg0);
        0x1ffaf092ba4c8b863a637738ce1a7a6cb6b12fa8cddf1dcfe6137b30a8ee9e8c::limit_order_config::checked_pool_token_types<T0, T1>(arg1);
        assert!(arg5 > 0, 15);
        assert!(0x2::coin::value<T0>(&arg4) > 0, 19);
        let v0 = 0x2::coin::into_balance<T0>(arg4);
        let v1 = 0x2::clock::timestamp_ms(arg7);
        assert!(arg6 > v1, 18);
        let v2 = 0x2::object::id<RateOrdersIndexer<T0, T1>>(arg2);
        assert!(mul_div_ceil((0x2::balance::value<T0>(&v0) as u128), 1000000000000000000, arg5) <= (18446744073709551615 as u128), 16);
        let v3 = new_limit_order<T0, T1>(v0, v2, arg5, v1, arg6, arg8);
        let v4 = OrderPlacedEvent{
            order_id               : 0x2::object::id<LimitOrder<T0, T1>>(&v3),
            owner                  : 0x2::tx_context::sender(arg8),
            rate_orders_indexer_id : v2,
            pay_coin               : 0x1::type_name::into_string(0x1::type_name::get<T0>()),
            target_coin            : 0x1::type_name::into_string(0x1::type_name::get<T1>()),
            total_pay_amount       : v3.total_pay_amount,
            rate                   : arg5,
            created_ts             : v1,
            expire_ts              : arg6,
        };
        0x2::event::emit<OrderPlacedEvent>(v4);
        add_order_indexes<T0, T1>(&v3, arg2, arg3, arg8);
        0x2::transfer::public_share_object<LimitOrder<T0, T1>>(v3);
    }

    public fun repay_flash_loan<T0, T1>(arg0: &0x1ffaf092ba4c8b863a637738ce1a7a6cb6b12fa8cddf1dcfe6137b30a8ee9e8c::base_config::BaseConfig, arg1: &0x1ffaf092ba4c8b863a637738ce1a7a6cb6b12fa8cddf1dcfe6137b30a8ee9e8c::limit_order_config::LimitOrderConfig, arg2: &mut 0x2::coin::Coin<T1>, arg3: &mut LimitOrder<T0, T1>, arg4: FlashLoanReceipt<T1>, arg5: &mut 0x2::tx_context::TxContext) {
        0x1ffaf092ba4c8b863a637738ce1a7a6cb6b12fa8cddf1dcfe6137b30a8ee9e8c::base_config::checked_package_version(arg0);
        let v0 = 0x2::tx_context::sender(arg5);
        if (0x1ffaf092ba4c8b863a637738ce1a7a6cb6b12fa8cddf1dcfe6137b30a8ee9e8c::limit_order_config::get_require_flash_loan_auth(arg1)) {
            0x1ffaf092ba4c8b863a637738ce1a7a6cb6b12fa8cddf1dcfe6137b30a8ee9e8c::limit_order_config::checked_keeper(arg0, v0);
        };
        assert!(arg4.order_id == 0x2::object::id<LimitOrder<T0, T1>>(arg3), 17);
        assert!(0x2::coin::value<T1>(arg2) >= arg4.target_repay_amount, 7);
        let FlashLoanReceipt {
            order_id            : v1,
            owner               : _,
            target_repay_amount : v3,
        } = arg4;
        0x2::balance::join<T1>(&mut arg3.target_balance, 0x2::coin::into_balance<T1>(0x2::coin::split<T1>(arg2, v3, arg5)));
        if (0x2::balance::value<T0>(&arg3.pay_balance) == 0) {
            0x2::transfer::public_transfer<0x2::coin::Coin<T1>>(0x2::coin::from_balance<T1>(0x2::balance::withdraw_all<T1>(&mut arg3.target_balance), arg5), arg3.owner);
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

