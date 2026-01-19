module 0x4713a25ca8908d18cbe93b6584621f4825fd30b408d2d9a8cfd60cc306373c3b::margin_utils {
    struct CreateMarginManagerEvent has copy, drop, store {
        margin_manager_id: 0x2::object::ID,
        deepbook_pool_id: 0x2::object::ID,
        base_coin_type: 0x1::type_name::TypeName,
        quote_coin_type: 0x1::type_name::TypeName,
        owner: address,
        timestamp: u64,
    }

    struct MarginDepositEvent has copy, drop, store {
        margin_manager_id: 0x2::object::ID,
        coin_type: 0x1::type_name::TypeName,
        amount: u64,
        trader: address,
        timestamp: u64,
    }

    struct MarginWithdrawEvent has copy, drop, store {
        margin_manager_id: 0x2::object::ID,
        coin_type: 0x1::type_name::TypeName,
        amount: u64,
        trader: address,
        timestamp: u64,
    }

    struct MarginBorrowEvent has copy, drop, store {
        margin_manager_id: 0x2::object::ID,
        margin_pool_id: 0x2::object::ID,
        is_base: bool,
        coin_type: 0x1::type_name::TypeName,
        amount: u64,
        borrowed_shares: u64,
        trader: address,
        timestamp: u64,
    }

    struct MarginRepayEvent has copy, drop, store {
        margin_manager_id: 0x2::object::ID,
        margin_pool_id: 0x2::object::ID,
        is_base: bool,
        coin_type: 0x1::type_name::TypeName,
        amount: u64,
        trader: address,
        timestamp: u64,
    }

    struct MarginPlaceLimitOrderEvent has copy, drop, store {
        margin_manager_id: 0x2::object::ID,
        pool_id: 0x2::object::ID,
        order_id: u128,
        client_order_id: u64,
        trader: address,
        price: u64,
        quantity: u64,
        is_bid: bool,
        expire_timestamp: u64,
        order_type: u8,
        self_matching_option: u8,
        original_quantity: u64,
        executed_quantity: u64,
        cumulative_quote_quantity: u64,
        paid_fees: u64,
        maker_fees: u64,
        epoch: u64,
        fee_is_deep: bool,
        status: u8,
    }

    struct MarginPlaceMarketOrderEvent has copy, drop, store {
        margin_manager_id: 0x2::object::ID,
        pool_id: 0x2::object::ID,
        order_id: u128,
        client_order_id: u64,
        trader: address,
        quantity: u64,
        is_bid: bool,
        self_matching_option: u8,
        original_quantity: u64,
        executed_quantity: u64,
        cumulative_quote_quantity: u64,
        paid_fees: u64,
        epoch: u64,
        fee_is_deep: bool,
        status: u8,
    }

    struct MarginCancelOrderEvent has copy, drop, store {
        margin_manager_id: 0x2::object::ID,
        pool_id: 0x2::object::ID,
        order_id: u128,
        trader: address,
        timestamp: u64,
    }

    struct MarginModifyOrderEvent has copy, drop, store {
        margin_manager_id: 0x2::object::ID,
        pool_id: 0x2::object::ID,
        order_id: u128,
        old_quantity: u64,
        new_quantity: u64,
        trader: address,
        timestamp: u64,
    }

    struct MarginLiquidateEvent has copy, drop, store {
        margin_manager_id: 0x2::object::ID,
        debt_type: 0x1::type_name::TypeName,
        liquidator: address,
        repaid_amount: u64,
        base_received: u64,
        quote_received: u64,
        timestamp: u64,
    }

    struct ConditionalOrderAddedEvent has copy, drop, store {
        margin_manager_id: 0x2::object::ID,
        conditional_order_id: u64,
        trader: address,
        timestamp: u64,
    }

    struct ConditionalOrderCanceledEvent has copy, drop, store {
        margin_manager_id: 0x2::object::ID,
        conditional_order_id: u64,
        trader: address,
        timestamp: u64,
    }

    struct ConditionalOrdersExecutedEvent has copy, drop, store {
        margin_manager_id: 0x2::object::ID,
        executed_count: u64,
        executor: address,
        timestamp: u64,
    }

    struct SupplierCapCreatedEvent has copy, drop, store {
        supplier_cap_id: 0x2::object::ID,
        owner: address,
        timestamp: u64,
    }

    struct SupplyEvent has copy, drop, store {
        margin_pool_id: 0x2::object::ID,
        supplier_cap_id: 0x2::object::ID,
        coin_type: 0x1::type_name::TypeName,
        supply_amount: u64,
        total_supply_shares: u64,
        referral_id: 0x1::option::Option<0x2::object::ID>,
        supplier: address,
        timestamp: u64,
    }

    struct SupplierWithdrawEvent has copy, drop, store {
        margin_pool_id: 0x2::object::ID,
        supplier_cap_id: 0x2::object::ID,
        coin_type: 0x1::type_name::TypeName,
        withdraw_amount: u64,
        supplier: address,
        timestamp: u64,
    }

    struct SupplyReferralCreatedEvent has copy, drop, store {
        margin_pool_id: 0x2::object::ID,
        supply_referral_id: 0x2::object::ID,
        owner: address,
        timestamp: u64,
    }

    struct ReferralFeesWithdrawnEvent has copy, drop, store {
        margin_pool_id: 0x2::object::ID,
        supply_referral_id: 0x2::object::ID,
        coin_type: 0x1::type_name::TypeName,
        amount: u64,
        owner: address,
        timestamp: u64,
    }

    struct MarginCancelAllOrdersEvent has copy, drop, store {
        margin_manager_id: 0x2::object::ID,
        pool_id: 0x2::object::ID,
        trader: address,
        timestamp: u64,
    }

    struct MarginCancelOrdersEvent has copy, drop, store {
        margin_manager_id: 0x2::object::ID,
        pool_id: 0x2::object::ID,
        order_ids: vector<u128>,
        trader: address,
        timestamp: u64,
    }

    struct ConditionalOrdersCanceledAllEvent has copy, drop, store {
        margin_manager_id: 0x2::object::ID,
        trader: address,
        timestamp: u64,
    }

    struct StakeEvent has copy, drop, store {
        margin_manager_id: 0x2::object::ID,
        pool_id: 0x2::object::ID,
        amount: u64,
        trader: address,
        timestamp: u64,
    }

    struct UnstakeEvent has copy, drop, store {
        margin_manager_id: 0x2::object::ID,
        pool_id: 0x2::object::ID,
        trader: address,
        timestamp: u64,
    }

    struct ClaimRebatesEvent has copy, drop, store {
        margin_manager_id: 0x2::object::ID,
        pool_id: 0x2::object::ID,
        trader: address,
        timestamp: u64,
    }

    struct SubmitProposalEvent has copy, drop, store {
        margin_manager_id: 0x2::object::ID,
        pool_id: 0x2::object::ID,
        taker_fee: u64,
        maker_fee: u64,
        stake_required: u64,
        proposer: address,
        timestamp: u64,
    }

    struct VoteEvent has copy, drop, store {
        margin_manager_id: 0x2::object::ID,
        pool_id: 0x2::object::ID,
        proposal_id: 0x2::object::ID,
        voter: address,
        timestamp: u64,
    }

    public fun account_open_orders<T0, T1>(arg0: &0x97d9473771b01f77b0940c589484184b49f6444627ec121314fae6a6d36fb86b::margin_manager::MarginManager<T0, T1>, arg1: &0x2c8d603bc51326b8c13cef9dd07031a408a48dddb541963357661df5d3204809::pool::Pool<T0, T1>) : 0x2::vec_set::VecSet<u128> {
        0x2c8d603bc51326b8c13cef9dd07031a408a48dddb541963357661df5d3204809::pool::account_open_orders<T0, T1>(arg1, 0x97d9473771b01f77b0940c589484184b49f6444627ec121314fae6a6d36fb86b::margin_manager::balance_manager<T0, T1>(arg0))
    }

    public fun get_account_order_details<T0, T1>(arg0: &0x97d9473771b01f77b0940c589484184b49f6444627ec121314fae6a6d36fb86b::margin_manager::MarginManager<T0, T1>, arg1: &0x2c8d603bc51326b8c13cef9dd07031a408a48dddb541963357661df5d3204809::pool::Pool<T0, T1>) : vector<0x2c8d603bc51326b8c13cef9dd07031a408a48dddb541963357661df5d3204809::order::Order> {
        0x2c8d603bc51326b8c13cef9dd07031a408a48dddb541963357661df5d3204809::pool::get_account_order_details<T0, T1>(arg1, 0x97d9473771b01f77b0940c589484184b49f6444627ec121314fae6a6d36fb86b::margin_manager::balance_manager<T0, T1>(arg0))
    }

    public fun add_conditional_order<T0, T1>(arg0: &0x4713a25ca8908d18cbe93b6584621f4825fd30b408d2d9a8cfd60cc306373c3b::global_config::GlobalConfig, arg1: &0x4713a25ca8908d18cbe93b6584621f4825fd30b408d2d9a8cfd60cc306373c3b::versioned::Versioned, arg2: &mut 0x97d9473771b01f77b0940c589484184b49f6444627ec121314fae6a6d36fb86b::margin_manager::MarginManager<T0, T1>, arg3: &0x2c8d603bc51326b8c13cef9dd07031a408a48dddb541963357661df5d3204809::pool::Pool<T0, T1>, arg4: &0x8d97f1cd6ac663735be08d1d2b6d02a159e711586461306ce60a2b7a6a565a9e::price_info::PriceInfoObject, arg5: &0x8d97f1cd6ac663735be08d1d2b6d02a159e711586461306ce60a2b7a6a565a9e::price_info::PriceInfoObject, arg6: &0x97d9473771b01f77b0940c589484184b49f6444627ec121314fae6a6d36fb86b::margin_registry::MarginRegistry, arg7: u64, arg8: 0x97d9473771b01f77b0940c589484184b49f6444627ec121314fae6a6d36fb86b::tpsl::Condition, arg9: 0x97d9473771b01f77b0940c589484184b49f6444627ec121314fae6a6d36fb86b::tpsl::PendingOrder, arg10: &0x2::clock::Clock, arg11: &mut 0x2::tx_context::TxContext) {
        0x4713a25ca8908d18cbe93b6584621f4825fd30b408d2d9a8cfd60cc306373c3b::versioned::check_version(arg1);
        0x4713a25ca8908d18cbe93b6584621f4825fd30b408d2d9a8cfd60cc306373c3b::global_config::check_conditional_order_permission(arg0);
        0x97d9473771b01f77b0940c589484184b49f6444627ec121314fae6a6d36fb86b::margin_manager::add_conditional_order<T0, T1>(arg2, arg3, arg4, arg5, arg6, arg7, arg8, arg9, arg10, arg11);
        let v0 = ConditionalOrderAddedEvent{
            margin_manager_id    : 0x2::object::id<0x97d9473771b01f77b0940c589484184b49f6444627ec121314fae6a6d36fb86b::margin_manager::MarginManager<T0, T1>>(arg2),
            conditional_order_id : arg7,
            trader               : 0x2::tx_context::sender(arg11),
            timestamp            : 0x2::clock::timestamp_ms(arg10),
        };
        0x2::event::emit<ConditionalOrderAddedEvent>(v0);
    }

    public fun borrow_base<T0, T1>(arg0: &0x4713a25ca8908d18cbe93b6584621f4825fd30b408d2d9a8cfd60cc306373c3b::global_config::GlobalConfig, arg1: &0x4713a25ca8908d18cbe93b6584621f4825fd30b408d2d9a8cfd60cc306373c3b::versioned::Versioned, arg2: &mut 0x97d9473771b01f77b0940c589484184b49f6444627ec121314fae6a6d36fb86b::margin_manager::MarginManager<T0, T1>, arg3: &0x97d9473771b01f77b0940c589484184b49f6444627ec121314fae6a6d36fb86b::margin_registry::MarginRegistry, arg4: &mut 0x97d9473771b01f77b0940c589484184b49f6444627ec121314fae6a6d36fb86b::margin_pool::MarginPool<T0>, arg5: &0x8d97f1cd6ac663735be08d1d2b6d02a159e711586461306ce60a2b7a6a565a9e::price_info::PriceInfoObject, arg6: &0x8d97f1cd6ac663735be08d1d2b6d02a159e711586461306ce60a2b7a6a565a9e::price_info::PriceInfoObject, arg7: &0x2c8d603bc51326b8c13cef9dd07031a408a48dddb541963357661df5d3204809::pool::Pool<T0, T1>, arg8: u64, arg9: &0x2::clock::Clock, arg10: &mut 0x2::tx_context::TxContext) {
        0x4713a25ca8908d18cbe93b6584621f4825fd30b408d2d9a8cfd60cc306373c3b::versioned::check_version(arg1);
        0x4713a25ca8908d18cbe93b6584621f4825fd30b408d2d9a8cfd60cc306373c3b::global_config::check_borrow_permission(arg0);
        0x97d9473771b01f77b0940c589484184b49f6444627ec121314fae6a6d36fb86b::margin_manager::borrow_base<T0, T1>(arg2, arg3, arg4, arg5, arg6, arg7, arg8, arg9, arg10);
        let (v0, _) = 0x97d9473771b01f77b0940c589484184b49f6444627ec121314fae6a6d36fb86b::margin_manager::borrowed_shares<T0, T1>(arg2);
        let v2 = MarginBorrowEvent{
            margin_manager_id : 0x2::object::id<0x97d9473771b01f77b0940c589484184b49f6444627ec121314fae6a6d36fb86b::margin_manager::MarginManager<T0, T1>>(arg2),
            margin_pool_id    : 0x2::object::id<0x97d9473771b01f77b0940c589484184b49f6444627ec121314fae6a6d36fb86b::margin_pool::MarginPool<T0>>(arg4),
            is_base           : true,
            coin_type         : 0x1::type_name::with_original_ids<T0>(),
            amount            : arg8,
            borrowed_shares   : v0,
            trader            : 0x2::tx_context::sender(arg10),
            timestamp         : 0x2::clock::timestamp_ms(arg9),
        };
        0x2::event::emit<MarginBorrowEvent>(v2);
    }

    public fun borrow_quote<T0, T1>(arg0: &0x4713a25ca8908d18cbe93b6584621f4825fd30b408d2d9a8cfd60cc306373c3b::global_config::GlobalConfig, arg1: &0x4713a25ca8908d18cbe93b6584621f4825fd30b408d2d9a8cfd60cc306373c3b::versioned::Versioned, arg2: &mut 0x97d9473771b01f77b0940c589484184b49f6444627ec121314fae6a6d36fb86b::margin_manager::MarginManager<T0, T1>, arg3: &0x97d9473771b01f77b0940c589484184b49f6444627ec121314fae6a6d36fb86b::margin_registry::MarginRegistry, arg4: &mut 0x97d9473771b01f77b0940c589484184b49f6444627ec121314fae6a6d36fb86b::margin_pool::MarginPool<T1>, arg5: &0x8d97f1cd6ac663735be08d1d2b6d02a159e711586461306ce60a2b7a6a565a9e::price_info::PriceInfoObject, arg6: &0x8d97f1cd6ac663735be08d1d2b6d02a159e711586461306ce60a2b7a6a565a9e::price_info::PriceInfoObject, arg7: &0x2c8d603bc51326b8c13cef9dd07031a408a48dddb541963357661df5d3204809::pool::Pool<T0, T1>, arg8: u64, arg9: &0x2::clock::Clock, arg10: &mut 0x2::tx_context::TxContext) {
        0x4713a25ca8908d18cbe93b6584621f4825fd30b408d2d9a8cfd60cc306373c3b::versioned::check_version(arg1);
        0x4713a25ca8908d18cbe93b6584621f4825fd30b408d2d9a8cfd60cc306373c3b::global_config::check_borrow_permission(arg0);
        0x97d9473771b01f77b0940c589484184b49f6444627ec121314fae6a6d36fb86b::margin_manager::borrow_quote<T0, T1>(arg2, arg3, arg4, arg5, arg6, arg7, arg8, arg9, arg10);
        let (_, v1) = 0x97d9473771b01f77b0940c589484184b49f6444627ec121314fae6a6d36fb86b::margin_manager::borrowed_shares<T0, T1>(arg2);
        let v2 = MarginBorrowEvent{
            margin_manager_id : 0x2::object::id<0x97d9473771b01f77b0940c589484184b49f6444627ec121314fae6a6d36fb86b::margin_manager::MarginManager<T0, T1>>(arg2),
            margin_pool_id    : 0x2::object::id<0x97d9473771b01f77b0940c589484184b49f6444627ec121314fae6a6d36fb86b::margin_pool::MarginPool<T1>>(arg4),
            is_base           : false,
            coin_type         : 0x1::type_name::with_original_ids<T1>(),
            amount            : arg8,
            borrowed_shares   : v1,
            trader            : 0x2::tx_context::sender(arg10),
            timestamp         : 0x2::clock::timestamp_ms(arg9),
        };
        0x2::event::emit<MarginBorrowEvent>(v2);
    }

    public fun cancel_all_conditional_orders<T0, T1>(arg0: &0x4713a25ca8908d18cbe93b6584621f4825fd30b408d2d9a8cfd60cc306373c3b::global_config::GlobalConfig, arg1: &0x4713a25ca8908d18cbe93b6584621f4825fd30b408d2d9a8cfd60cc306373c3b::versioned::Versioned, arg2: &mut 0x97d9473771b01f77b0940c589484184b49f6444627ec121314fae6a6d36fb86b::margin_manager::MarginManager<T0, T1>, arg3: &0x2::clock::Clock, arg4: &0x2::tx_context::TxContext) {
        0x4713a25ca8908d18cbe93b6584621f4825fd30b408d2d9a8cfd60cc306373c3b::versioned::check_version(arg1);
        0x4713a25ca8908d18cbe93b6584621f4825fd30b408d2d9a8cfd60cc306373c3b::global_config::check_conditional_order_permission(arg0);
        0x97d9473771b01f77b0940c589484184b49f6444627ec121314fae6a6d36fb86b::margin_manager::cancel_all_conditional_orders<T0, T1>(arg2, arg3, arg4);
        let v0 = ConditionalOrdersCanceledAllEvent{
            margin_manager_id : 0x2::object::id<0x97d9473771b01f77b0940c589484184b49f6444627ec121314fae6a6d36fb86b::margin_manager::MarginManager<T0, T1>>(arg2),
            trader            : 0x2::tx_context::sender(arg4),
            timestamp         : 0x2::clock::timestamp_ms(arg3),
        };
        0x2::event::emit<ConditionalOrdersCanceledAllEvent>(v0);
    }

    public fun cancel_all_margin_orders<T0, T1>(arg0: &0x4713a25ca8908d18cbe93b6584621f4825fd30b408d2d9a8cfd60cc306373c3b::global_config::GlobalConfig, arg1: &0x4713a25ca8908d18cbe93b6584621f4825fd30b408d2d9a8cfd60cc306373c3b::versioned::Versioned, arg2: &mut 0x97d9473771b01f77b0940c589484184b49f6444627ec121314fae6a6d36fb86b::margin_manager::MarginManager<T0, T1>, arg3: &0x97d9473771b01f77b0940c589484184b49f6444627ec121314fae6a6d36fb86b::margin_registry::MarginRegistry, arg4: &mut 0x2c8d603bc51326b8c13cef9dd07031a408a48dddb541963357661df5d3204809::pool::Pool<T0, T1>, arg5: &0x2::clock::Clock, arg6: &0x2::tx_context::TxContext) {
        0x4713a25ca8908d18cbe93b6584621f4825fd30b408d2d9a8cfd60cc306373c3b::versioned::check_version(arg1);
        0x4713a25ca8908d18cbe93b6584621f4825fd30b408d2d9a8cfd60cc306373c3b::global_config::check_trade_permission(arg0);
        0x97d9473771b01f77b0940c589484184b49f6444627ec121314fae6a6d36fb86b::pool_proxy::cancel_all_orders<T0, T1>(arg3, arg2, arg4, arg5, arg6);
        let v0 = MarginCancelAllOrdersEvent{
            margin_manager_id : 0x2::object::id<0x97d9473771b01f77b0940c589484184b49f6444627ec121314fae6a6d36fb86b::margin_manager::MarginManager<T0, T1>>(arg2),
            pool_id           : 0x2::object::id<0x2c8d603bc51326b8c13cef9dd07031a408a48dddb541963357661df5d3204809::pool::Pool<T0, T1>>(arg4),
            trader            : 0x2::tx_context::sender(arg6),
            timestamp         : 0x2::clock::timestamp_ms(arg5),
        };
        0x2::event::emit<MarginCancelAllOrdersEvent>(v0);
    }

    public fun cancel_conditional_order<T0, T1>(arg0: &0x4713a25ca8908d18cbe93b6584621f4825fd30b408d2d9a8cfd60cc306373c3b::global_config::GlobalConfig, arg1: &0x4713a25ca8908d18cbe93b6584621f4825fd30b408d2d9a8cfd60cc306373c3b::versioned::Versioned, arg2: &mut 0x97d9473771b01f77b0940c589484184b49f6444627ec121314fae6a6d36fb86b::margin_manager::MarginManager<T0, T1>, arg3: u64, arg4: &0x2::clock::Clock, arg5: &0x2::tx_context::TxContext) {
        0x4713a25ca8908d18cbe93b6584621f4825fd30b408d2d9a8cfd60cc306373c3b::versioned::check_version(arg1);
        0x4713a25ca8908d18cbe93b6584621f4825fd30b408d2d9a8cfd60cc306373c3b::global_config::check_conditional_order_permission(arg0);
        0x97d9473771b01f77b0940c589484184b49f6444627ec121314fae6a6d36fb86b::margin_manager::cancel_conditional_order<T0, T1>(arg2, arg3, arg4, arg5);
        let v0 = ConditionalOrderCanceledEvent{
            margin_manager_id    : 0x2::object::id<0x97d9473771b01f77b0940c589484184b49f6444627ec121314fae6a6d36fb86b::margin_manager::MarginManager<T0, T1>>(arg2),
            conditional_order_id : arg3,
            trader               : 0x2::tx_context::sender(arg5),
            timestamp            : 0x2::clock::timestamp_ms(arg4),
        };
        0x2::event::emit<ConditionalOrderCanceledEvent>(v0);
    }

    public fun cancel_margin_order<T0, T1>(arg0: &0x4713a25ca8908d18cbe93b6584621f4825fd30b408d2d9a8cfd60cc306373c3b::global_config::GlobalConfig, arg1: &0x4713a25ca8908d18cbe93b6584621f4825fd30b408d2d9a8cfd60cc306373c3b::versioned::Versioned, arg2: &mut 0x97d9473771b01f77b0940c589484184b49f6444627ec121314fae6a6d36fb86b::margin_manager::MarginManager<T0, T1>, arg3: &0x97d9473771b01f77b0940c589484184b49f6444627ec121314fae6a6d36fb86b::margin_registry::MarginRegistry, arg4: &mut 0x2c8d603bc51326b8c13cef9dd07031a408a48dddb541963357661df5d3204809::pool::Pool<T0, T1>, arg5: u128, arg6: &0x2::clock::Clock, arg7: &0x2::tx_context::TxContext) {
        0x4713a25ca8908d18cbe93b6584621f4825fd30b408d2d9a8cfd60cc306373c3b::versioned::check_version(arg1);
        0x4713a25ca8908d18cbe93b6584621f4825fd30b408d2d9a8cfd60cc306373c3b::global_config::check_trade_permission(arg0);
        0x97d9473771b01f77b0940c589484184b49f6444627ec121314fae6a6d36fb86b::pool_proxy::cancel_order<T0, T1>(arg3, arg2, arg4, arg5, arg6, arg7);
        let v0 = MarginCancelOrderEvent{
            margin_manager_id : 0x2::object::id<0x97d9473771b01f77b0940c589484184b49f6444627ec121314fae6a6d36fb86b::margin_manager::MarginManager<T0, T1>>(arg2),
            pool_id           : 0x2::object::id<0x2c8d603bc51326b8c13cef9dd07031a408a48dddb541963357661df5d3204809::pool::Pool<T0, T1>>(arg4),
            order_id          : arg5,
            trader            : 0x2::tx_context::sender(arg7),
            timestamp         : 0x2::clock::timestamp_ms(arg6),
        };
        0x2::event::emit<MarginCancelOrderEvent>(v0);
    }

    public fun cancel_margin_orders<T0, T1>(arg0: &0x4713a25ca8908d18cbe93b6584621f4825fd30b408d2d9a8cfd60cc306373c3b::global_config::GlobalConfig, arg1: &0x4713a25ca8908d18cbe93b6584621f4825fd30b408d2d9a8cfd60cc306373c3b::versioned::Versioned, arg2: &mut 0x97d9473771b01f77b0940c589484184b49f6444627ec121314fae6a6d36fb86b::margin_manager::MarginManager<T0, T1>, arg3: &0x97d9473771b01f77b0940c589484184b49f6444627ec121314fae6a6d36fb86b::margin_registry::MarginRegistry, arg4: &mut 0x2c8d603bc51326b8c13cef9dd07031a408a48dddb541963357661df5d3204809::pool::Pool<T0, T1>, arg5: vector<u128>, arg6: &0x2::clock::Clock, arg7: &0x2::tx_context::TxContext) {
        0x4713a25ca8908d18cbe93b6584621f4825fd30b408d2d9a8cfd60cc306373c3b::versioned::check_version(arg1);
        0x4713a25ca8908d18cbe93b6584621f4825fd30b408d2d9a8cfd60cc306373c3b::global_config::check_trade_permission(arg0);
        0x97d9473771b01f77b0940c589484184b49f6444627ec121314fae6a6d36fb86b::pool_proxy::cancel_orders<T0, T1>(arg3, arg2, arg4, arg5, arg6, arg7);
        let v0 = MarginCancelOrdersEvent{
            margin_manager_id : 0x2::object::id<0x97d9473771b01f77b0940c589484184b49f6444627ec121314fae6a6d36fb86b::margin_manager::MarginManager<T0, T1>>(arg2),
            pool_id           : 0x2::object::id<0x2c8d603bc51326b8c13cef9dd07031a408a48dddb541963357661df5d3204809::pool::Pool<T0, T1>>(arg4),
            order_ids         : arg5,
            trader            : 0x2::tx_context::sender(arg7),
            timestamp         : 0x2::clock::timestamp_ms(arg6),
        };
        0x2::event::emit<MarginCancelOrdersEvent>(v0);
    }

    public fun claim_rebates<T0, T1>(arg0: &0x4713a25ca8908d18cbe93b6584621f4825fd30b408d2d9a8cfd60cc306373c3b::versioned::Versioned, arg1: &mut 0x97d9473771b01f77b0940c589484184b49f6444627ec121314fae6a6d36fb86b::margin_manager::MarginManager<T0, T1>, arg2: &0x97d9473771b01f77b0940c589484184b49f6444627ec121314fae6a6d36fb86b::margin_registry::MarginRegistry, arg3: &mut 0x2c8d603bc51326b8c13cef9dd07031a408a48dddb541963357661df5d3204809::pool::Pool<T0, T1>, arg4: &0x2::clock::Clock, arg5: &mut 0x2::tx_context::TxContext) {
        0x4713a25ca8908d18cbe93b6584621f4825fd30b408d2d9a8cfd60cc306373c3b::versioned::check_version(arg0);
        0x97d9473771b01f77b0940c589484184b49f6444627ec121314fae6a6d36fb86b::pool_proxy::claim_rebates<T0, T1>(arg2, arg1, arg3, arg5);
        let v0 = ClaimRebatesEvent{
            margin_manager_id : 0x2::object::id<0x97d9473771b01f77b0940c589484184b49f6444627ec121314fae6a6d36fb86b::margin_manager::MarginManager<T0, T1>>(arg1),
            pool_id           : 0x2::object::id<0x2c8d603bc51326b8c13cef9dd07031a408a48dddb541963357661df5d3204809::pool::Pool<T0, T1>>(arg3),
            trader            : 0x2::tx_context::sender(arg5),
            timestamp         : 0x2::clock::timestamp_ms(arg4),
        };
        0x2::event::emit<ClaimRebatesEvent>(v0);
    }

    public fun create_margin_manager<T0, T1>(arg0: &0x4713a25ca8908d18cbe93b6584621f4825fd30b408d2d9a8cfd60cc306373c3b::versioned::Versioned, arg1: &0x2c8d603bc51326b8c13cef9dd07031a408a48dddb541963357661df5d3204809::pool::Pool<T0, T1>, arg2: &0x2c8d603bc51326b8c13cef9dd07031a408a48dddb541963357661df5d3204809::registry::Registry, arg3: &mut 0x97d9473771b01f77b0940c589484184b49f6444627ec121314fae6a6d36fb86b::margin_registry::MarginRegistry, arg4: &0x2::clock::Clock, arg5: &mut 0x2::tx_context::TxContext) : (0x97d9473771b01f77b0940c589484184b49f6444627ec121314fae6a6d36fb86b::margin_manager::MarginManager<T0, T1>, 0x97d9473771b01f77b0940c589484184b49f6444627ec121314fae6a6d36fb86b::margin_manager::ManagerInitializer) {
        0x4713a25ca8908d18cbe93b6584621f4825fd30b408d2d9a8cfd60cc306373c3b::versioned::check_version(arg0);
        let (v0, v1) = 0x97d9473771b01f77b0940c589484184b49f6444627ec121314fae6a6d36fb86b::margin_manager::new_with_initializer<T0, T1>(arg1, arg2, arg3, arg4, arg5);
        let v2 = v0;
        let v3 = CreateMarginManagerEvent{
            margin_manager_id : 0x2::object::id<0x97d9473771b01f77b0940c589484184b49f6444627ec121314fae6a6d36fb86b::margin_manager::MarginManager<T0, T1>>(&v2),
            deepbook_pool_id  : 0x2::object::id<0x2c8d603bc51326b8c13cef9dd07031a408a48dddb541963357661df5d3204809::pool::Pool<T0, T1>>(arg1),
            base_coin_type    : 0x1::type_name::with_original_ids<T0>(),
            quote_coin_type   : 0x1::type_name::with_original_ids<T1>(),
            owner             : 0x2::tx_context::sender(arg5),
            timestamp         : 0x2::clock::timestamp_ms(arg4),
        };
        0x2::event::emit<CreateMarginManagerEvent>(v3);
        (v2, v1)
    }

    public fun deposit<T0, T1, T2>(arg0: &0x4713a25ca8908d18cbe93b6584621f4825fd30b408d2d9a8cfd60cc306373c3b::global_config::GlobalConfig, arg1: &0x4713a25ca8908d18cbe93b6584621f4825fd30b408d2d9a8cfd60cc306373c3b::versioned::Versioned, arg2: &mut 0x97d9473771b01f77b0940c589484184b49f6444627ec121314fae6a6d36fb86b::margin_manager::MarginManager<T0, T1>, arg3: &0x97d9473771b01f77b0940c589484184b49f6444627ec121314fae6a6d36fb86b::margin_registry::MarginRegistry, arg4: &0x8d97f1cd6ac663735be08d1d2b6d02a159e711586461306ce60a2b7a6a565a9e::price_info::PriceInfoObject, arg5: &0x8d97f1cd6ac663735be08d1d2b6d02a159e711586461306ce60a2b7a6a565a9e::price_info::PriceInfoObject, arg6: 0x2::coin::Coin<T2>, arg7: &0x2::clock::Clock, arg8: &mut 0x2::tx_context::TxContext) {
        0x4713a25ca8908d18cbe93b6584621f4825fd30b408d2d9a8cfd60cc306373c3b::versioned::check_version(arg1);
        0x4713a25ca8908d18cbe93b6584621f4825fd30b408d2d9a8cfd60cc306373c3b::global_config::check_deposit_permission(arg0);
        0x97d9473771b01f77b0940c589484184b49f6444627ec121314fae6a6d36fb86b::margin_manager::deposit<T0, T1, T2>(arg2, arg3, arg4, arg5, arg6, arg7, arg8);
        let v0 = MarginDepositEvent{
            margin_manager_id : 0x2::object::id<0x97d9473771b01f77b0940c589484184b49f6444627ec121314fae6a6d36fb86b::margin_manager::MarginManager<T0, T1>>(arg2),
            coin_type         : 0x1::type_name::with_original_ids<T2>(),
            amount            : 0x2::coin::value<T2>(&arg6),
            trader            : 0x2::tx_context::sender(arg8),
            timestamp         : 0x2::clock::timestamp_ms(arg7),
        };
        0x2::event::emit<MarginDepositEvent>(v0);
    }

    public fun execute_conditional_orders<T0, T1>(arg0: &0x4713a25ca8908d18cbe93b6584621f4825fd30b408d2d9a8cfd60cc306373c3b::versioned::Versioned, arg1: &mut 0x97d9473771b01f77b0940c589484184b49f6444627ec121314fae6a6d36fb86b::margin_manager::MarginManager<T0, T1>, arg2: &mut 0x2c8d603bc51326b8c13cef9dd07031a408a48dddb541963357661df5d3204809::pool::Pool<T0, T1>, arg3: &0x8d97f1cd6ac663735be08d1d2b6d02a159e711586461306ce60a2b7a6a565a9e::price_info::PriceInfoObject, arg4: &0x8d97f1cd6ac663735be08d1d2b6d02a159e711586461306ce60a2b7a6a565a9e::price_info::PriceInfoObject, arg5: &0x97d9473771b01f77b0940c589484184b49f6444627ec121314fae6a6d36fb86b::margin_registry::MarginRegistry, arg6: u64, arg7: &0x2::clock::Clock, arg8: &0x2::tx_context::TxContext) {
        0x4713a25ca8908d18cbe93b6584621f4825fd30b408d2d9a8cfd60cc306373c3b::versioned::check_version(arg0);
        let v0 = 0x97d9473771b01f77b0940c589484184b49f6444627ec121314fae6a6d36fb86b::margin_manager::execute_conditional_orders<T0, T1>(arg1, arg2, arg3, arg4, arg5, arg6, arg7, arg8);
        let v1 = ConditionalOrdersExecutedEvent{
            margin_manager_id : 0x2::object::id<0x97d9473771b01f77b0940c589484184b49f6444627ec121314fae6a6d36fb86b::margin_manager::MarginManager<T0, T1>>(arg1),
            executed_count    : 0x1::vector::length<0x2c8d603bc51326b8c13cef9dd07031a408a48dddb541963357661df5d3204809::order_info::OrderInfo>(&v0),
            executor          : 0x2::tx_context::sender(arg8),
            timestamp         : 0x2::clock::timestamp_ms(arg7),
        };
        0x2::event::emit<ConditionalOrdersExecutedEvent>(v1);
    }

    public fun get_available_withdrawal<T0>(arg0: &0x97d9473771b01f77b0940c589484184b49f6444627ec121314fae6a6d36fb86b::margin_pool::MarginPool<T0>, arg1: &0x2::clock::Clock) : u64 {
        0x97d9473771b01f77b0940c589484184b49f6444627ec121314fae6a6d36fb86b::margin_pool::get_available_withdrawal<T0>(arg0, arg1)
    }

    public fun get_interest_rate<T0>(arg0: &0x97d9473771b01f77b0940c589484184b49f6444627ec121314fae6a6d36fb86b::margin_pool::MarginPool<T0>) : u64 {
        0x97d9473771b01f77b0940c589484184b49f6444627ec121314fae6a6d36fb86b::margin_pool::interest_rate<T0>(arg0)
    }

    public fun get_supply_cap<T0>(arg0: &0x97d9473771b01f77b0940c589484184b49f6444627ec121314fae6a6d36fb86b::margin_pool::MarginPool<T0>) : u64 {
        0x97d9473771b01f77b0940c589484184b49f6444627ec121314fae6a6d36fb86b::margin_pool::supply_cap<T0>(arg0)
    }

    public fun get_total_supply<T0>(arg0: &0x97d9473771b01f77b0940c589484184b49f6444627ec121314fae6a6d36fb86b::margin_pool::MarginPool<T0>) : u64 {
        0x97d9473771b01f77b0940c589484184b49f6444627ec121314fae6a6d36fb86b::margin_pool::total_supply<T0>(arg0)
    }

    public fun get_total_supply_with_interest<T0>(arg0: &0x97d9473771b01f77b0940c589484184b49f6444627ec121314fae6a6d36fb86b::margin_pool::MarginPool<T0>, arg1: &0x2::clock::Clock) : u64 {
        0x97d9473771b01f77b0940c589484184b49f6444627ec121314fae6a6d36fb86b::margin_pool::total_supply_with_interest<T0>(arg0, arg1)
    }

    public fun get_user_supply_amount<T0>(arg0: &0x97d9473771b01f77b0940c589484184b49f6444627ec121314fae6a6d36fb86b::margin_pool::MarginPool<T0>, arg1: &0x97d9473771b01f77b0940c589484184b49f6444627ec121314fae6a6d36fb86b::margin_pool::SupplierCap, arg2: &0x2::clock::Clock) : u64 {
        0x97d9473771b01f77b0940c589484184b49f6444627ec121314fae6a6d36fb86b::margin_pool::user_supply_amount<T0>(arg0, 0x2::object::id<0x97d9473771b01f77b0940c589484184b49f6444627ec121314fae6a6d36fb86b::margin_pool::SupplierCap>(arg1), arg2)
    }

    public fun get_user_supply_shares<T0>(arg0: &0x97d9473771b01f77b0940c589484184b49f6444627ec121314fae6a6d36fb86b::margin_pool::MarginPool<T0>, arg1: &0x97d9473771b01f77b0940c589484184b49f6444627ec121314fae6a6d36fb86b::margin_pool::SupplierCap) : u64 {
        0x97d9473771b01f77b0940c589484184b49f6444627ec121314fae6a6d36fb86b::margin_pool::user_supply_shares<T0>(arg0, 0x2::object::id<0x97d9473771b01f77b0940c589484184b49f6444627ec121314fae6a6d36fb86b::margin_pool::SupplierCap>(arg1))
    }

    public fun get_vault_balance<T0>(arg0: &0x97d9473771b01f77b0940c589484184b49f6444627ec121314fae6a6d36fb86b::margin_pool::MarginPool<T0>) : u64 {
        0x97d9473771b01f77b0940c589484184b49f6444627ec121314fae6a6d36fb86b::margin_pool::vault_balance<T0>(arg0)
    }

    public fun liquidate<T0, T1, T2>(arg0: &0x4713a25ca8908d18cbe93b6584621f4825fd30b408d2d9a8cfd60cc306373c3b::global_config::GlobalConfig, arg1: &0x4713a25ca8908d18cbe93b6584621f4825fd30b408d2d9a8cfd60cc306373c3b::versioned::Versioned, arg2: &mut 0x97d9473771b01f77b0940c589484184b49f6444627ec121314fae6a6d36fb86b::margin_manager::MarginManager<T0, T1>, arg3: &0x97d9473771b01f77b0940c589484184b49f6444627ec121314fae6a6d36fb86b::margin_registry::MarginRegistry, arg4: &0x8d97f1cd6ac663735be08d1d2b6d02a159e711586461306ce60a2b7a6a565a9e::price_info::PriceInfoObject, arg5: &0x8d97f1cd6ac663735be08d1d2b6d02a159e711586461306ce60a2b7a6a565a9e::price_info::PriceInfoObject, arg6: &mut 0x97d9473771b01f77b0940c589484184b49f6444627ec121314fae6a6d36fb86b::margin_pool::MarginPool<T2>, arg7: &mut 0x2c8d603bc51326b8c13cef9dd07031a408a48dddb541963357661df5d3204809::pool::Pool<T0, T1>, arg8: 0x2::coin::Coin<T2>, arg9: &0x2::clock::Clock, arg10: &mut 0x2::tx_context::TxContext) : (0x2::coin::Coin<T0>, 0x2::coin::Coin<T1>, 0x2::coin::Coin<T2>) {
        0x4713a25ca8908d18cbe93b6584621f4825fd30b408d2d9a8cfd60cc306373c3b::versioned::check_version(arg1);
        0x4713a25ca8908d18cbe93b6584621f4825fd30b408d2d9a8cfd60cc306373c3b::global_config::check_liquidate_permission(arg0);
        let (v0, v1, v2) = 0x97d9473771b01f77b0940c589484184b49f6444627ec121314fae6a6d36fb86b::margin_manager::liquidate<T0, T1, T2>(arg2, arg3, arg4, arg5, arg6, arg7, arg8, arg9, arg10);
        let v3 = v1;
        let v4 = v0;
        let v5 = MarginLiquidateEvent{
            margin_manager_id : 0x2::object::id<0x97d9473771b01f77b0940c589484184b49f6444627ec121314fae6a6d36fb86b::margin_manager::MarginManager<T0, T1>>(arg2),
            debt_type         : 0x1::type_name::with_original_ids<T2>(),
            liquidator        : 0x2::tx_context::sender(arg10),
            repaid_amount     : 0x2::coin::value<T2>(&arg8),
            base_received     : 0x2::coin::value<T0>(&v4),
            quote_received    : 0x2::coin::value<T1>(&v3),
            timestamp         : 0x2::clock::timestamp_ms(arg9),
        };
        0x2::event::emit<MarginLiquidateEvent>(v5);
        (v4, v3, v2)
    }

    public fun mint_supplier_cap(arg0: &0x4713a25ca8908d18cbe93b6584621f4825fd30b408d2d9a8cfd60cc306373c3b::versioned::Versioned, arg1: &0x97d9473771b01f77b0940c589484184b49f6444627ec121314fae6a6d36fb86b::margin_registry::MarginRegistry, arg2: &0x2::clock::Clock, arg3: &mut 0x2::tx_context::TxContext) : 0x97d9473771b01f77b0940c589484184b49f6444627ec121314fae6a6d36fb86b::margin_pool::SupplierCap {
        0x4713a25ca8908d18cbe93b6584621f4825fd30b408d2d9a8cfd60cc306373c3b::versioned::check_version(arg0);
        let v0 = 0x97d9473771b01f77b0940c589484184b49f6444627ec121314fae6a6d36fb86b::margin_pool::mint_supplier_cap(arg1, arg2, arg3);
        let v1 = SupplierCapCreatedEvent{
            supplier_cap_id : 0x2::object::id<0x97d9473771b01f77b0940c589484184b49f6444627ec121314fae6a6d36fb86b::margin_pool::SupplierCap>(&v0),
            owner           : 0x2::tx_context::sender(arg3),
            timestamp       : 0x2::clock::timestamp_ms(arg2),
        };
        0x2::event::emit<SupplierCapCreatedEvent>(v1);
        v0
    }

    public fun mint_supply_referral<T0>(arg0: &0x4713a25ca8908d18cbe93b6584621f4825fd30b408d2d9a8cfd60cc306373c3b::versioned::Versioned, arg1: &mut 0x97d9473771b01f77b0940c589484184b49f6444627ec121314fae6a6d36fb86b::margin_pool::MarginPool<T0>, arg2: &0x97d9473771b01f77b0940c589484184b49f6444627ec121314fae6a6d36fb86b::margin_registry::MarginRegistry, arg3: &0x2::clock::Clock, arg4: &mut 0x2::tx_context::TxContext) : 0x2::object::ID {
        0x4713a25ca8908d18cbe93b6584621f4825fd30b408d2d9a8cfd60cc306373c3b::versioned::check_version(arg0);
        let v0 = 0x97d9473771b01f77b0940c589484184b49f6444627ec121314fae6a6d36fb86b::margin_pool::mint_supply_referral<T0>(arg1, arg2, arg3, arg4);
        let v1 = SupplyReferralCreatedEvent{
            margin_pool_id     : 0x2::object::id<0x97d9473771b01f77b0940c589484184b49f6444627ec121314fae6a6d36fb86b::margin_pool::MarginPool<T0>>(arg1),
            supply_referral_id : v0,
            owner              : 0x2::tx_context::sender(arg4),
            timestamp          : 0x2::clock::timestamp_ms(arg3),
        };
        0x2::event::emit<SupplyReferralCreatedEvent>(v1);
        v0
    }

    public fun modify_margin_order<T0, T1>(arg0: &0x4713a25ca8908d18cbe93b6584621f4825fd30b408d2d9a8cfd60cc306373c3b::global_config::GlobalConfig, arg1: &0x4713a25ca8908d18cbe93b6584621f4825fd30b408d2d9a8cfd60cc306373c3b::versioned::Versioned, arg2: &mut 0x97d9473771b01f77b0940c589484184b49f6444627ec121314fae6a6d36fb86b::margin_manager::MarginManager<T0, T1>, arg3: &0x97d9473771b01f77b0940c589484184b49f6444627ec121314fae6a6d36fb86b::margin_registry::MarginRegistry, arg4: &mut 0x2c8d603bc51326b8c13cef9dd07031a408a48dddb541963357661df5d3204809::pool::Pool<T0, T1>, arg5: u128, arg6: u64, arg7: &0x2::clock::Clock, arg8: &0x2::tx_context::TxContext) {
        0x4713a25ca8908d18cbe93b6584621f4825fd30b408d2d9a8cfd60cc306373c3b::versioned::check_version(arg1);
        0x4713a25ca8908d18cbe93b6584621f4825fd30b408d2d9a8cfd60cc306373c3b::global_config::check_trade_permission(arg0);
        let v0 = 0x2c8d603bc51326b8c13cef9dd07031a408a48dddb541963357661df5d3204809::pool::get_order<T0, T1>(arg4, arg5);
        0x97d9473771b01f77b0940c589484184b49f6444627ec121314fae6a6d36fb86b::pool_proxy::modify_order<T0, T1>(arg3, arg2, arg4, arg5, arg6, arg7, arg8);
        let v1 = MarginModifyOrderEvent{
            margin_manager_id : 0x2::object::id<0x97d9473771b01f77b0940c589484184b49f6444627ec121314fae6a6d36fb86b::margin_manager::MarginManager<T0, T1>>(arg2),
            pool_id           : 0x2::object::id<0x2c8d603bc51326b8c13cef9dd07031a408a48dddb541963357661df5d3204809::pool::Pool<T0, T1>>(arg4),
            order_id          : arg5,
            old_quantity      : 0x2c8d603bc51326b8c13cef9dd07031a408a48dddb541963357661df5d3204809::order::quantity(&v0) - 0x2c8d603bc51326b8c13cef9dd07031a408a48dddb541963357661df5d3204809::order::filled_quantity(&v0),
            new_quantity      : arg6,
            trader            : 0x2::tx_context::sender(arg8),
            timestamp         : 0x2::clock::timestamp_ms(arg7),
        };
        0x2::event::emit<MarginModifyOrderEvent>(v1);
    }

    public fun new_condition(arg0: bool, arg1: u64) : 0x97d9473771b01f77b0940c589484184b49f6444627ec121314fae6a6d36fb86b::tpsl::Condition {
        0x97d9473771b01f77b0940c589484184b49f6444627ec121314fae6a6d36fb86b::tpsl::new_condition(arg0, arg1)
    }

    public fun new_pending_limit_order(arg0: u64, arg1: u8, arg2: u8, arg3: u64, arg4: u64, arg5: bool, arg6: bool, arg7: u64) : 0x97d9473771b01f77b0940c589484184b49f6444627ec121314fae6a6d36fb86b::tpsl::PendingOrder {
        0x97d9473771b01f77b0940c589484184b49f6444627ec121314fae6a6d36fb86b::tpsl::new_pending_limit_order(arg0, arg1, arg2, arg3, arg4, arg5, arg6, arg7)
    }

    public fun new_pending_market_order(arg0: u64, arg1: u8, arg2: u64, arg3: bool, arg4: bool) : 0x97d9473771b01f77b0940c589484184b49f6444627ec121314fae6a6d36fb86b::tpsl::PendingOrder {
        0x97d9473771b01f77b0940c589484184b49f6444627ec121314fae6a6d36fb86b::tpsl::new_pending_market_order(arg0, arg1, arg2, arg3, arg4)
    }

    public fun place_margin_limit_order<T0, T1>(arg0: &0x4713a25ca8908d18cbe93b6584621f4825fd30b408d2d9a8cfd60cc306373c3b::global_config::GlobalConfig, arg1: &0x4713a25ca8908d18cbe93b6584621f4825fd30b408d2d9a8cfd60cc306373c3b::versioned::Versioned, arg2: &mut 0x97d9473771b01f77b0940c589484184b49f6444627ec121314fae6a6d36fb86b::margin_manager::MarginManager<T0, T1>, arg3: &0x97d9473771b01f77b0940c589484184b49f6444627ec121314fae6a6d36fb86b::margin_registry::MarginRegistry, arg4: &mut 0x2c8d603bc51326b8c13cef9dd07031a408a48dddb541963357661df5d3204809::pool::Pool<T0, T1>, arg5: u8, arg6: u8, arg7: u64, arg8: u64, arg9: bool, arg10: bool, arg11: u64, arg12: &0x2::clock::Clock, arg13: &mut 0x2::tx_context::TxContext) {
        0x4713a25ca8908d18cbe93b6584621f4825fd30b408d2d9a8cfd60cc306373c3b::versioned::check_version(arg1);
        0x4713a25ca8908d18cbe93b6584621f4825fd30b408d2d9a8cfd60cc306373c3b::global_config::check_trade_permission(arg0);
        let v0 = 0x97d9473771b01f77b0940c589484184b49f6444627ec121314fae6a6d36fb86b::pool_proxy::place_limit_order<T0, T1>(arg3, arg2, arg4, 1107, arg5, arg6, arg7, arg8, arg9, arg10, arg11, arg12, arg13);
        let v1 = MarginPlaceLimitOrderEvent{
            margin_manager_id         : 0x2::object::id<0x97d9473771b01f77b0940c589484184b49f6444627ec121314fae6a6d36fb86b::margin_manager::MarginManager<T0, T1>>(arg2),
            pool_id                   : 0x2::object::id<0x2c8d603bc51326b8c13cef9dd07031a408a48dddb541963357661df5d3204809::pool::Pool<T0, T1>>(arg4),
            order_id                  : 0x2c8d603bc51326b8c13cef9dd07031a408a48dddb541963357661df5d3204809::order_info::order_id(&v0),
            client_order_id           : 0x2c8d603bc51326b8c13cef9dd07031a408a48dddb541963357661df5d3204809::order_info::client_order_id(&v0),
            trader                    : 0x2::tx_context::sender(arg13),
            price                     : 0x2c8d603bc51326b8c13cef9dd07031a408a48dddb541963357661df5d3204809::order_info::price(&v0),
            quantity                  : arg8,
            is_bid                    : 0x2c8d603bc51326b8c13cef9dd07031a408a48dddb541963357661df5d3204809::order_info::is_bid(&v0),
            expire_timestamp          : 0x2c8d603bc51326b8c13cef9dd07031a408a48dddb541963357661df5d3204809::order_info::expire_timestamp(&v0),
            order_type                : 0x2c8d603bc51326b8c13cef9dd07031a408a48dddb541963357661df5d3204809::order_info::order_type(&v0),
            self_matching_option      : 0x2c8d603bc51326b8c13cef9dd07031a408a48dddb541963357661df5d3204809::order_info::self_matching_option(&v0),
            original_quantity         : 0x2c8d603bc51326b8c13cef9dd07031a408a48dddb541963357661df5d3204809::order_info::original_quantity(&v0),
            executed_quantity         : 0x2c8d603bc51326b8c13cef9dd07031a408a48dddb541963357661df5d3204809::order_info::executed_quantity(&v0),
            cumulative_quote_quantity : 0x2c8d603bc51326b8c13cef9dd07031a408a48dddb541963357661df5d3204809::order_info::cumulative_quote_quantity(&v0),
            paid_fees                 : 0x2c8d603bc51326b8c13cef9dd07031a408a48dddb541963357661df5d3204809::order_info::paid_fees(&v0),
            maker_fees                : 0x2c8d603bc51326b8c13cef9dd07031a408a48dddb541963357661df5d3204809::order_info::maker_fees(&v0),
            epoch                     : 0x2c8d603bc51326b8c13cef9dd07031a408a48dddb541963357661df5d3204809::order_info::epoch(&v0),
            fee_is_deep               : 0x2c8d603bc51326b8c13cef9dd07031a408a48dddb541963357661df5d3204809::order_info::fee_is_deep(&v0),
            status                    : 0x2c8d603bc51326b8c13cef9dd07031a408a48dddb541963357661df5d3204809::order_info::status(&v0),
        };
        0x2::event::emit<MarginPlaceLimitOrderEvent>(v1);
    }

    public fun place_margin_market_order<T0, T1>(arg0: &0x4713a25ca8908d18cbe93b6584621f4825fd30b408d2d9a8cfd60cc306373c3b::global_config::GlobalConfig, arg1: &0x4713a25ca8908d18cbe93b6584621f4825fd30b408d2d9a8cfd60cc306373c3b::versioned::Versioned, arg2: &mut 0x97d9473771b01f77b0940c589484184b49f6444627ec121314fae6a6d36fb86b::margin_manager::MarginManager<T0, T1>, arg3: &0x97d9473771b01f77b0940c589484184b49f6444627ec121314fae6a6d36fb86b::margin_registry::MarginRegistry, arg4: &mut 0x2c8d603bc51326b8c13cef9dd07031a408a48dddb541963357661df5d3204809::pool::Pool<T0, T1>, arg5: u8, arg6: u64, arg7: bool, arg8: bool, arg9: bool, arg10: u64, arg11: &0x2::clock::Clock, arg12: &mut 0x2::tx_context::TxContext) {
        0x4713a25ca8908d18cbe93b6584621f4825fd30b408d2d9a8cfd60cc306373c3b::versioned::check_version(arg1);
        0x4713a25ca8908d18cbe93b6584621f4825fd30b408d2d9a8cfd60cc306373c3b::global_config::check_trade_permission(arg0);
        assert!(arg9 || arg7, 0x4713a25ca8908d18cbe93b6584621f4825fd30b408d2d9a8cfd60cc306373c3b::errors::not_support_exact_quote_when_is_bid_false());
        let v0 = if (!arg9 && arg7) {
            if (arg8) {
                let (v1, _, _) = 0x2c8d603bc51326b8c13cef9dd07031a408a48dddb541963357661df5d3204809::pool::get_quantity_out<T0, T1>(arg4, 0, arg6, arg11);
                v1
            } else {
                let (v4, _, _) = 0x2c8d603bc51326b8c13cef9dd07031a408a48dddb541963357661df5d3204809::pool::get_quantity_out_input_fee<T0, T1>(arg4, 0, arg6, arg11);
                v4
            }
        } else {
            arg6
        };
        let v7 = if (arg7) {
            0x97d9473771b01f77b0940c589484184b49f6444627ec121314fae6a6d36fb86b::margin_manager::base_balance<T0, T1>(arg2)
        } else {
            0x97d9473771b01f77b0940c589484184b49f6444627ec121314fae6a6d36fb86b::margin_manager::quote_balance<T0, T1>(arg2)
        };
        let v8 = 0x97d9473771b01f77b0940c589484184b49f6444627ec121314fae6a6d36fb86b::pool_proxy::place_market_order<T0, T1>(arg3, arg2, arg4, 1107, arg5, v0, arg7, arg8, arg11, arg12);
        let v9 = if (arg7) {
            0x97d9473771b01f77b0940c589484184b49f6444627ec121314fae6a6d36fb86b::margin_manager::base_balance<T0, T1>(arg2)
        } else {
            0x97d9473771b01f77b0940c589484184b49f6444627ec121314fae6a6d36fb86b::margin_manager::quote_balance<T0, T1>(arg2)
        };
        assert!(v9 - v7 >= arg10, 0);
        let v10 = MarginPlaceMarketOrderEvent{
            margin_manager_id         : 0x2::object::id<0x97d9473771b01f77b0940c589484184b49f6444627ec121314fae6a6d36fb86b::margin_manager::MarginManager<T0, T1>>(arg2),
            pool_id                   : 0x2::object::id<0x2c8d603bc51326b8c13cef9dd07031a408a48dddb541963357661df5d3204809::pool::Pool<T0, T1>>(arg4),
            order_id                  : 0x2c8d603bc51326b8c13cef9dd07031a408a48dddb541963357661df5d3204809::order_info::order_id(&v8),
            client_order_id           : 0x2c8d603bc51326b8c13cef9dd07031a408a48dddb541963357661df5d3204809::order_info::client_order_id(&v8),
            trader                    : 0x2::tx_context::sender(arg12),
            quantity                  : v0,
            is_bid                    : 0x2c8d603bc51326b8c13cef9dd07031a408a48dddb541963357661df5d3204809::order_info::is_bid(&v8),
            self_matching_option      : 0x2c8d603bc51326b8c13cef9dd07031a408a48dddb541963357661df5d3204809::order_info::self_matching_option(&v8),
            original_quantity         : 0x2c8d603bc51326b8c13cef9dd07031a408a48dddb541963357661df5d3204809::order_info::original_quantity(&v8),
            executed_quantity         : 0x2c8d603bc51326b8c13cef9dd07031a408a48dddb541963357661df5d3204809::order_info::executed_quantity(&v8),
            cumulative_quote_quantity : 0x2c8d603bc51326b8c13cef9dd07031a408a48dddb541963357661df5d3204809::order_info::cumulative_quote_quantity(&v8),
            paid_fees                 : 0x2c8d603bc51326b8c13cef9dd07031a408a48dddb541963357661df5d3204809::order_info::paid_fees(&v8),
            epoch                     : 0x2c8d603bc51326b8c13cef9dd07031a408a48dddb541963357661df5d3204809::order_info::epoch(&v8),
            fee_is_deep               : 0x2c8d603bc51326b8c13cef9dd07031a408a48dddb541963357661df5d3204809::order_info::fee_is_deep(&v8),
            status                    : 0x2c8d603bc51326b8c13cef9dd07031a408a48dddb541963357661df5d3204809::order_info::status(&v8),
        };
        0x2::event::emit<MarginPlaceMarketOrderEvent>(v10);
    }

    public fun place_reduce_only_limit_order<T0, T1, T2>(arg0: &0x4713a25ca8908d18cbe93b6584621f4825fd30b408d2d9a8cfd60cc306373c3b::global_config::GlobalConfig, arg1: &0x4713a25ca8908d18cbe93b6584621f4825fd30b408d2d9a8cfd60cc306373c3b::versioned::Versioned, arg2: &mut 0x97d9473771b01f77b0940c589484184b49f6444627ec121314fae6a6d36fb86b::margin_manager::MarginManager<T0, T1>, arg3: &0x97d9473771b01f77b0940c589484184b49f6444627ec121314fae6a6d36fb86b::margin_registry::MarginRegistry, arg4: &mut 0x2c8d603bc51326b8c13cef9dd07031a408a48dddb541963357661df5d3204809::pool::Pool<T0, T1>, arg5: &0x97d9473771b01f77b0940c589484184b49f6444627ec121314fae6a6d36fb86b::margin_pool::MarginPool<T2>, arg6: u8, arg7: u8, arg8: u64, arg9: u64, arg10: bool, arg11: bool, arg12: u64, arg13: &0x2::clock::Clock, arg14: &0x2::tx_context::TxContext) {
        0x4713a25ca8908d18cbe93b6584621f4825fd30b408d2d9a8cfd60cc306373c3b::versioned::check_version(arg1);
        0x4713a25ca8908d18cbe93b6584621f4825fd30b408d2d9a8cfd60cc306373c3b::global_config::check_trade_permission(arg0);
        let v0 = 0x97d9473771b01f77b0940c589484184b49f6444627ec121314fae6a6d36fb86b::pool_proxy::place_reduce_only_limit_order<T0, T1, T2>(arg3, arg2, arg4, arg5, 1107, arg6, arg7, arg8, arg9, arg10, arg11, arg12, arg13, arg14);
        let v1 = MarginPlaceLimitOrderEvent{
            margin_manager_id         : 0x2::object::id<0x97d9473771b01f77b0940c589484184b49f6444627ec121314fae6a6d36fb86b::margin_manager::MarginManager<T0, T1>>(arg2),
            pool_id                   : 0x2::object::id<0x2c8d603bc51326b8c13cef9dd07031a408a48dddb541963357661df5d3204809::pool::Pool<T0, T1>>(arg4),
            order_id                  : 0x2c8d603bc51326b8c13cef9dd07031a408a48dddb541963357661df5d3204809::order_info::order_id(&v0),
            client_order_id           : 0x2c8d603bc51326b8c13cef9dd07031a408a48dddb541963357661df5d3204809::order_info::client_order_id(&v0),
            trader                    : 0x2::tx_context::sender(arg14),
            price                     : 0x2c8d603bc51326b8c13cef9dd07031a408a48dddb541963357661df5d3204809::order_info::price(&v0),
            quantity                  : arg9,
            is_bid                    : 0x2c8d603bc51326b8c13cef9dd07031a408a48dddb541963357661df5d3204809::order_info::is_bid(&v0),
            expire_timestamp          : 0x2c8d603bc51326b8c13cef9dd07031a408a48dddb541963357661df5d3204809::order_info::expire_timestamp(&v0),
            order_type                : 0x2c8d603bc51326b8c13cef9dd07031a408a48dddb541963357661df5d3204809::order_info::order_type(&v0),
            self_matching_option      : 0x2c8d603bc51326b8c13cef9dd07031a408a48dddb541963357661df5d3204809::order_info::self_matching_option(&v0),
            original_quantity         : 0x2c8d603bc51326b8c13cef9dd07031a408a48dddb541963357661df5d3204809::order_info::original_quantity(&v0),
            executed_quantity         : 0x2c8d603bc51326b8c13cef9dd07031a408a48dddb541963357661df5d3204809::order_info::executed_quantity(&v0),
            cumulative_quote_quantity : 0x2c8d603bc51326b8c13cef9dd07031a408a48dddb541963357661df5d3204809::order_info::cumulative_quote_quantity(&v0),
            paid_fees                 : 0x2c8d603bc51326b8c13cef9dd07031a408a48dddb541963357661df5d3204809::order_info::paid_fees(&v0),
            maker_fees                : 0x2c8d603bc51326b8c13cef9dd07031a408a48dddb541963357661df5d3204809::order_info::maker_fees(&v0),
            epoch                     : 0x2c8d603bc51326b8c13cef9dd07031a408a48dddb541963357661df5d3204809::order_info::epoch(&v0),
            fee_is_deep               : 0x2c8d603bc51326b8c13cef9dd07031a408a48dddb541963357661df5d3204809::order_info::fee_is_deep(&v0),
            status                    : 0x2c8d603bc51326b8c13cef9dd07031a408a48dddb541963357661df5d3204809::order_info::status(&v0),
        };
        0x2::event::emit<MarginPlaceLimitOrderEvent>(v1);
    }

    public fun place_reduce_only_market_order<T0, T1, T2>(arg0: &0x4713a25ca8908d18cbe93b6584621f4825fd30b408d2d9a8cfd60cc306373c3b::global_config::GlobalConfig, arg1: &0x4713a25ca8908d18cbe93b6584621f4825fd30b408d2d9a8cfd60cc306373c3b::versioned::Versioned, arg2: &mut 0x97d9473771b01f77b0940c589484184b49f6444627ec121314fae6a6d36fb86b::margin_manager::MarginManager<T0, T1>, arg3: &0x97d9473771b01f77b0940c589484184b49f6444627ec121314fae6a6d36fb86b::margin_registry::MarginRegistry, arg4: &mut 0x2c8d603bc51326b8c13cef9dd07031a408a48dddb541963357661df5d3204809::pool::Pool<T0, T1>, arg5: &0x97d9473771b01f77b0940c589484184b49f6444627ec121314fae6a6d36fb86b::margin_pool::MarginPool<T2>, arg6: u8, arg7: u64, arg8: bool, arg9: bool, arg10: &0x2::clock::Clock, arg11: &0x2::tx_context::TxContext) {
        0x4713a25ca8908d18cbe93b6584621f4825fd30b408d2d9a8cfd60cc306373c3b::versioned::check_version(arg1);
        0x4713a25ca8908d18cbe93b6584621f4825fd30b408d2d9a8cfd60cc306373c3b::global_config::check_trade_permission(arg0);
        let v0 = 0x97d9473771b01f77b0940c589484184b49f6444627ec121314fae6a6d36fb86b::pool_proxy::place_reduce_only_market_order<T0, T1, T2>(arg3, arg2, arg4, arg5, 1107, arg6, arg7, arg8, arg9, arg10, arg11);
        let v1 = MarginPlaceMarketOrderEvent{
            margin_manager_id         : 0x2::object::id<0x97d9473771b01f77b0940c589484184b49f6444627ec121314fae6a6d36fb86b::margin_manager::MarginManager<T0, T1>>(arg2),
            pool_id                   : 0x2::object::id<0x2c8d603bc51326b8c13cef9dd07031a408a48dddb541963357661df5d3204809::pool::Pool<T0, T1>>(arg4),
            order_id                  : 0x2c8d603bc51326b8c13cef9dd07031a408a48dddb541963357661df5d3204809::order_info::order_id(&v0),
            client_order_id           : 0x2c8d603bc51326b8c13cef9dd07031a408a48dddb541963357661df5d3204809::order_info::client_order_id(&v0),
            trader                    : 0x2::tx_context::sender(arg11),
            quantity                  : arg7,
            is_bid                    : 0x2c8d603bc51326b8c13cef9dd07031a408a48dddb541963357661df5d3204809::order_info::is_bid(&v0),
            self_matching_option      : 0x2c8d603bc51326b8c13cef9dd07031a408a48dddb541963357661df5d3204809::order_info::self_matching_option(&v0),
            original_quantity         : 0x2c8d603bc51326b8c13cef9dd07031a408a48dddb541963357661df5d3204809::order_info::original_quantity(&v0),
            executed_quantity         : 0x2c8d603bc51326b8c13cef9dd07031a408a48dddb541963357661df5d3204809::order_info::executed_quantity(&v0),
            cumulative_quote_quantity : 0x2c8d603bc51326b8c13cef9dd07031a408a48dddb541963357661df5d3204809::order_info::cumulative_quote_quantity(&v0),
            paid_fees                 : 0x2c8d603bc51326b8c13cef9dd07031a408a48dddb541963357661df5d3204809::order_info::paid_fees(&v0),
            epoch                     : 0x2c8d603bc51326b8c13cef9dd07031a408a48dddb541963357661df5d3204809::order_info::epoch(&v0),
            fee_is_deep               : 0x2c8d603bc51326b8c13cef9dd07031a408a48dddb541963357661df5d3204809::order_info::fee_is_deep(&v0),
            status                    : 0x2c8d603bc51326b8c13cef9dd07031a408a48dddb541963357661df5d3204809::order_info::status(&v0),
        };
        0x2::event::emit<MarginPlaceMarketOrderEvent>(v1);
    }

    public fun repay_base<T0, T1>(arg0: &0x4713a25ca8908d18cbe93b6584621f4825fd30b408d2d9a8cfd60cc306373c3b::global_config::GlobalConfig, arg1: &0x4713a25ca8908d18cbe93b6584621f4825fd30b408d2d9a8cfd60cc306373c3b::versioned::Versioned, arg2: &mut 0x97d9473771b01f77b0940c589484184b49f6444627ec121314fae6a6d36fb86b::margin_manager::MarginManager<T0, T1>, arg3: &0x97d9473771b01f77b0940c589484184b49f6444627ec121314fae6a6d36fb86b::margin_registry::MarginRegistry, arg4: &mut 0x97d9473771b01f77b0940c589484184b49f6444627ec121314fae6a6d36fb86b::margin_pool::MarginPool<T0>, arg5: 0x1::option::Option<u64>, arg6: &0x2::clock::Clock, arg7: &mut 0x2::tx_context::TxContext) : u64 {
        0x4713a25ca8908d18cbe93b6584621f4825fd30b408d2d9a8cfd60cc306373c3b::versioned::check_version(arg1);
        0x4713a25ca8908d18cbe93b6584621f4825fd30b408d2d9a8cfd60cc306373c3b::global_config::check_repay_permission(arg0);
        let v0 = 0x97d9473771b01f77b0940c589484184b49f6444627ec121314fae6a6d36fb86b::margin_manager::repay_base<T0, T1>(arg2, arg3, arg4, arg5, arg6, arg7);
        let v1 = MarginRepayEvent{
            margin_manager_id : 0x2::object::id<0x97d9473771b01f77b0940c589484184b49f6444627ec121314fae6a6d36fb86b::margin_manager::MarginManager<T0, T1>>(arg2),
            margin_pool_id    : 0x2::object::id<0x97d9473771b01f77b0940c589484184b49f6444627ec121314fae6a6d36fb86b::margin_pool::MarginPool<T0>>(arg4),
            is_base           : true,
            coin_type         : 0x1::type_name::with_original_ids<T0>(),
            amount            : v0,
            trader            : 0x2::tx_context::sender(arg7),
            timestamp         : 0x2::clock::timestamp_ms(arg6),
        };
        0x2::event::emit<MarginRepayEvent>(v1);
        v0
    }

    public fun repay_quote<T0, T1>(arg0: &0x4713a25ca8908d18cbe93b6584621f4825fd30b408d2d9a8cfd60cc306373c3b::global_config::GlobalConfig, arg1: &0x4713a25ca8908d18cbe93b6584621f4825fd30b408d2d9a8cfd60cc306373c3b::versioned::Versioned, arg2: &mut 0x97d9473771b01f77b0940c589484184b49f6444627ec121314fae6a6d36fb86b::margin_manager::MarginManager<T0, T1>, arg3: &0x97d9473771b01f77b0940c589484184b49f6444627ec121314fae6a6d36fb86b::margin_registry::MarginRegistry, arg4: &mut 0x97d9473771b01f77b0940c589484184b49f6444627ec121314fae6a6d36fb86b::margin_pool::MarginPool<T1>, arg5: 0x1::option::Option<u64>, arg6: &0x2::clock::Clock, arg7: &mut 0x2::tx_context::TxContext) : u64 {
        0x4713a25ca8908d18cbe93b6584621f4825fd30b408d2d9a8cfd60cc306373c3b::versioned::check_version(arg1);
        0x4713a25ca8908d18cbe93b6584621f4825fd30b408d2d9a8cfd60cc306373c3b::global_config::check_repay_permission(arg0);
        let v0 = 0x97d9473771b01f77b0940c589484184b49f6444627ec121314fae6a6d36fb86b::margin_manager::repay_quote<T0, T1>(arg2, arg3, arg4, arg5, arg6, arg7);
        let v1 = MarginRepayEvent{
            margin_manager_id : 0x2::object::id<0x97d9473771b01f77b0940c589484184b49f6444627ec121314fae6a6d36fb86b::margin_manager::MarginManager<T0, T1>>(arg2),
            margin_pool_id    : 0x2::object::id<0x97d9473771b01f77b0940c589484184b49f6444627ec121314fae6a6d36fb86b::margin_pool::MarginPool<T1>>(arg4),
            is_base           : false,
            coin_type         : 0x1::type_name::with_original_ids<T1>(),
            amount            : v0,
            trader            : 0x2::tx_context::sender(arg7),
            timestamp         : 0x2::clock::timestamp_ms(arg6),
        };
        0x2::event::emit<MarginRepayEvent>(v1);
        v0
    }

    public fun share_margin_manager<T0, T1>(arg0: 0x97d9473771b01f77b0940c589484184b49f6444627ec121314fae6a6d36fb86b::margin_manager::MarginManager<T0, T1>, arg1: 0x97d9473771b01f77b0940c589484184b49f6444627ec121314fae6a6d36fb86b::margin_manager::ManagerInitializer) {
        0x97d9473771b01f77b0940c589484184b49f6444627ec121314fae6a6d36fb86b::margin_manager::share<T0, T1>(arg0, arg1);
    }

    public fun stake<T0, T1>(arg0: &0x4713a25ca8908d18cbe93b6584621f4825fd30b408d2d9a8cfd60cc306373c3b::versioned::Versioned, arg1: &mut 0x97d9473771b01f77b0940c589484184b49f6444627ec121314fae6a6d36fb86b::margin_manager::MarginManager<T0, T1>, arg2: &0x97d9473771b01f77b0940c589484184b49f6444627ec121314fae6a6d36fb86b::margin_registry::MarginRegistry, arg3: &mut 0x2c8d603bc51326b8c13cef9dd07031a408a48dddb541963357661df5d3204809::pool::Pool<T0, T1>, arg4: u64, arg5: &0x2::clock::Clock, arg6: &0x2::tx_context::TxContext) {
        0x4713a25ca8908d18cbe93b6584621f4825fd30b408d2d9a8cfd60cc306373c3b::versioned::check_version(arg0);
        0x97d9473771b01f77b0940c589484184b49f6444627ec121314fae6a6d36fb86b::pool_proxy::stake<T0, T1>(arg2, arg1, arg3, arg4, arg6);
        let v0 = StakeEvent{
            margin_manager_id : 0x2::object::id<0x97d9473771b01f77b0940c589484184b49f6444627ec121314fae6a6d36fb86b::margin_manager::MarginManager<T0, T1>>(arg1),
            pool_id           : 0x2::object::id<0x2c8d603bc51326b8c13cef9dd07031a408a48dddb541963357661df5d3204809::pool::Pool<T0, T1>>(arg3),
            amount            : arg4,
            trader            : 0x2::tx_context::sender(arg6),
            timestamp         : 0x2::clock::timestamp_ms(arg5),
        };
        0x2::event::emit<StakeEvent>(v0);
    }

    public fun submit_proposal<T0, T1>(arg0: &0x4713a25ca8908d18cbe93b6584621f4825fd30b408d2d9a8cfd60cc306373c3b::versioned::Versioned, arg1: &mut 0x97d9473771b01f77b0940c589484184b49f6444627ec121314fae6a6d36fb86b::margin_manager::MarginManager<T0, T1>, arg2: &0x97d9473771b01f77b0940c589484184b49f6444627ec121314fae6a6d36fb86b::margin_registry::MarginRegistry, arg3: &mut 0x2c8d603bc51326b8c13cef9dd07031a408a48dddb541963357661df5d3204809::pool::Pool<T0, T1>, arg4: u64, arg5: u64, arg6: u64, arg7: &0x2::clock::Clock, arg8: &0x2::tx_context::TxContext) {
        0x4713a25ca8908d18cbe93b6584621f4825fd30b408d2d9a8cfd60cc306373c3b::versioned::check_version(arg0);
        0x97d9473771b01f77b0940c589484184b49f6444627ec121314fae6a6d36fb86b::pool_proxy::submit_proposal<T0, T1>(arg2, arg1, arg3, arg4, arg5, arg6, arg8);
        let v0 = SubmitProposalEvent{
            margin_manager_id : 0x2::object::id<0x97d9473771b01f77b0940c589484184b49f6444627ec121314fae6a6d36fb86b::margin_manager::MarginManager<T0, T1>>(arg1),
            pool_id           : 0x2::object::id<0x2c8d603bc51326b8c13cef9dd07031a408a48dddb541963357661df5d3204809::pool::Pool<T0, T1>>(arg3),
            taker_fee         : arg4,
            maker_fee         : arg5,
            stake_required    : arg6,
            proposer          : 0x2::tx_context::sender(arg8),
            timestamp         : 0x2::clock::timestamp_ms(arg7),
        };
        0x2::event::emit<SubmitProposalEvent>(v0);
    }

    public fun supplier_withdraw<T0>(arg0: &0x4713a25ca8908d18cbe93b6584621f4825fd30b408d2d9a8cfd60cc306373c3b::global_config::GlobalConfig, arg1: &0x4713a25ca8908d18cbe93b6584621f4825fd30b408d2d9a8cfd60cc306373c3b::versioned::Versioned, arg2: &mut 0x97d9473771b01f77b0940c589484184b49f6444627ec121314fae6a6d36fb86b::margin_pool::MarginPool<T0>, arg3: &0x97d9473771b01f77b0940c589484184b49f6444627ec121314fae6a6d36fb86b::margin_registry::MarginRegistry, arg4: &0x97d9473771b01f77b0940c589484184b49f6444627ec121314fae6a6d36fb86b::margin_pool::SupplierCap, arg5: 0x1::option::Option<u64>, arg6: &0x2::clock::Clock, arg7: &mut 0x2::tx_context::TxContext) : 0x2::coin::Coin<T0> {
        0x4713a25ca8908d18cbe93b6584621f4825fd30b408d2d9a8cfd60cc306373c3b::versioned::check_version(arg1);
        0x4713a25ca8908d18cbe93b6584621f4825fd30b408d2d9a8cfd60cc306373c3b::global_config::check_supplier_withdraw_permission(arg0);
        let v0 = 0x97d9473771b01f77b0940c589484184b49f6444627ec121314fae6a6d36fb86b::margin_pool::withdraw<T0>(arg2, arg3, arg4, arg5, arg6, arg7);
        let v1 = SupplierWithdrawEvent{
            margin_pool_id  : 0x2::object::id<0x97d9473771b01f77b0940c589484184b49f6444627ec121314fae6a6d36fb86b::margin_pool::MarginPool<T0>>(arg2),
            supplier_cap_id : 0x2::object::id<0x97d9473771b01f77b0940c589484184b49f6444627ec121314fae6a6d36fb86b::margin_pool::SupplierCap>(arg4),
            coin_type       : 0x1::type_name::with_original_ids<T0>(),
            withdraw_amount : 0x2::coin::value<T0>(&v0),
            supplier        : 0x2::tx_context::sender(arg7),
            timestamp       : 0x2::clock::timestamp_ms(arg6),
        };
        0x2::event::emit<SupplierWithdrawEvent>(v1);
        v0
    }

    public fun supply<T0>(arg0: &0x4713a25ca8908d18cbe93b6584621f4825fd30b408d2d9a8cfd60cc306373c3b::global_config::GlobalConfig, arg1: &0x4713a25ca8908d18cbe93b6584621f4825fd30b408d2d9a8cfd60cc306373c3b::versioned::Versioned, arg2: &mut 0x97d9473771b01f77b0940c589484184b49f6444627ec121314fae6a6d36fb86b::margin_pool::MarginPool<T0>, arg3: &0x97d9473771b01f77b0940c589484184b49f6444627ec121314fae6a6d36fb86b::margin_registry::MarginRegistry, arg4: &0x97d9473771b01f77b0940c589484184b49f6444627ec121314fae6a6d36fb86b::margin_pool::SupplierCap, arg5: 0x2::coin::Coin<T0>, arg6: 0x1::option::Option<0x2::object::ID>, arg7: &0x2::clock::Clock, arg8: &mut 0x2::tx_context::TxContext) : u64 {
        0x4713a25ca8908d18cbe93b6584621f4825fd30b408d2d9a8cfd60cc306373c3b::versioned::check_version(arg1);
        0x4713a25ca8908d18cbe93b6584621f4825fd30b408d2d9a8cfd60cc306373c3b::global_config::check_supply_permission(arg0);
        let v0 = 0x97d9473771b01f77b0940c589484184b49f6444627ec121314fae6a6d36fb86b::margin_pool::supply<T0>(arg2, arg3, arg4, arg5, arg6, arg7);
        let v1 = SupplyEvent{
            margin_pool_id      : 0x2::object::id<0x97d9473771b01f77b0940c589484184b49f6444627ec121314fae6a6d36fb86b::margin_pool::MarginPool<T0>>(arg2),
            supplier_cap_id     : 0x2::object::id<0x97d9473771b01f77b0940c589484184b49f6444627ec121314fae6a6d36fb86b::margin_pool::SupplierCap>(arg4),
            coin_type           : 0x1::type_name::with_original_ids<T0>(),
            supply_amount       : 0x2::coin::value<T0>(&arg5),
            total_supply_shares : v0,
            referral_id         : arg6,
            supplier            : 0x2::tx_context::sender(arg8),
            timestamp           : 0x2::clock::timestamp_ms(arg7),
        };
        0x2::event::emit<SupplyEvent>(v1);
        v0
    }

    public fun unstake<T0, T1>(arg0: &0x4713a25ca8908d18cbe93b6584621f4825fd30b408d2d9a8cfd60cc306373c3b::versioned::Versioned, arg1: &mut 0x97d9473771b01f77b0940c589484184b49f6444627ec121314fae6a6d36fb86b::margin_manager::MarginManager<T0, T1>, arg2: &0x97d9473771b01f77b0940c589484184b49f6444627ec121314fae6a6d36fb86b::margin_registry::MarginRegistry, arg3: &mut 0x2c8d603bc51326b8c13cef9dd07031a408a48dddb541963357661df5d3204809::pool::Pool<T0, T1>, arg4: &0x2::clock::Clock, arg5: &0x2::tx_context::TxContext) {
        0x4713a25ca8908d18cbe93b6584621f4825fd30b408d2d9a8cfd60cc306373c3b::versioned::check_version(arg0);
        0x97d9473771b01f77b0940c589484184b49f6444627ec121314fae6a6d36fb86b::pool_proxy::unstake<T0, T1>(arg2, arg1, arg3, arg5);
        let v0 = UnstakeEvent{
            margin_manager_id : 0x2::object::id<0x97d9473771b01f77b0940c589484184b49f6444627ec121314fae6a6d36fb86b::margin_manager::MarginManager<T0, T1>>(arg1),
            pool_id           : 0x2::object::id<0x2c8d603bc51326b8c13cef9dd07031a408a48dddb541963357661df5d3204809::pool::Pool<T0, T1>>(arg3),
            trader            : 0x2::tx_context::sender(arg5),
            timestamp         : 0x2::clock::timestamp_ms(arg4),
        };
        0x2::event::emit<UnstakeEvent>(v0);
    }

    public fun vote<T0, T1>(arg0: &0x4713a25ca8908d18cbe93b6584621f4825fd30b408d2d9a8cfd60cc306373c3b::versioned::Versioned, arg1: &mut 0x97d9473771b01f77b0940c589484184b49f6444627ec121314fae6a6d36fb86b::margin_manager::MarginManager<T0, T1>, arg2: &0x97d9473771b01f77b0940c589484184b49f6444627ec121314fae6a6d36fb86b::margin_registry::MarginRegistry, arg3: &mut 0x2c8d603bc51326b8c13cef9dd07031a408a48dddb541963357661df5d3204809::pool::Pool<T0, T1>, arg4: 0x2::object::ID, arg5: &0x2::clock::Clock, arg6: &0x2::tx_context::TxContext) {
        0x4713a25ca8908d18cbe93b6584621f4825fd30b408d2d9a8cfd60cc306373c3b::versioned::check_version(arg0);
        0x97d9473771b01f77b0940c589484184b49f6444627ec121314fae6a6d36fb86b::pool_proxy::vote<T0, T1>(arg2, arg1, arg3, arg4, arg6);
        let v0 = VoteEvent{
            margin_manager_id : 0x2::object::id<0x97d9473771b01f77b0940c589484184b49f6444627ec121314fae6a6d36fb86b::margin_manager::MarginManager<T0, T1>>(arg1),
            pool_id           : 0x2::object::id<0x2c8d603bc51326b8c13cef9dd07031a408a48dddb541963357661df5d3204809::pool::Pool<T0, T1>>(arg3),
            proposal_id       : arg4,
            voter             : 0x2::tx_context::sender(arg6),
            timestamp         : 0x2::clock::timestamp_ms(arg5),
        };
        0x2::event::emit<VoteEvent>(v0);
    }

    public fun withdraw<T0, T1, T2>(arg0: &0x4713a25ca8908d18cbe93b6584621f4825fd30b408d2d9a8cfd60cc306373c3b::global_config::GlobalConfig, arg1: &0x4713a25ca8908d18cbe93b6584621f4825fd30b408d2d9a8cfd60cc306373c3b::versioned::Versioned, arg2: &mut 0x97d9473771b01f77b0940c589484184b49f6444627ec121314fae6a6d36fb86b::margin_manager::MarginManager<T0, T1>, arg3: &0x97d9473771b01f77b0940c589484184b49f6444627ec121314fae6a6d36fb86b::margin_registry::MarginRegistry, arg4: &0x97d9473771b01f77b0940c589484184b49f6444627ec121314fae6a6d36fb86b::margin_pool::MarginPool<T0>, arg5: &0x97d9473771b01f77b0940c589484184b49f6444627ec121314fae6a6d36fb86b::margin_pool::MarginPool<T1>, arg6: &0x8d97f1cd6ac663735be08d1d2b6d02a159e711586461306ce60a2b7a6a565a9e::price_info::PriceInfoObject, arg7: &0x8d97f1cd6ac663735be08d1d2b6d02a159e711586461306ce60a2b7a6a565a9e::price_info::PriceInfoObject, arg8: &0x2c8d603bc51326b8c13cef9dd07031a408a48dddb541963357661df5d3204809::pool::Pool<T0, T1>, arg9: u64, arg10: &0x2::clock::Clock, arg11: &mut 0x2::tx_context::TxContext) : 0x2::coin::Coin<T2> {
        0x4713a25ca8908d18cbe93b6584621f4825fd30b408d2d9a8cfd60cc306373c3b::versioned::check_version(arg1);
        0x4713a25ca8908d18cbe93b6584621f4825fd30b408d2d9a8cfd60cc306373c3b::global_config::check_withdraw_permission(arg0);
        let v0 = MarginWithdrawEvent{
            margin_manager_id : 0x2::object::id<0x97d9473771b01f77b0940c589484184b49f6444627ec121314fae6a6d36fb86b::margin_manager::MarginManager<T0, T1>>(arg2),
            coin_type         : 0x1::type_name::with_original_ids<T2>(),
            amount            : arg9,
            trader            : 0x2::tx_context::sender(arg11),
            timestamp         : 0x2::clock::timestamp_ms(arg10),
        };
        0x2::event::emit<MarginWithdrawEvent>(v0);
        0x97d9473771b01f77b0940c589484184b49f6444627ec121314fae6a6d36fb86b::margin_manager::withdraw<T0, T1, T2>(arg2, arg3, arg4, arg5, arg6, arg7, arg8, arg9, arg10, arg11)
    }

    public fun withdraw_referral_fees<T0>(arg0: &0x4713a25ca8908d18cbe93b6584621f4825fd30b408d2d9a8cfd60cc306373c3b::versioned::Versioned, arg1: &mut 0x97d9473771b01f77b0940c589484184b49f6444627ec121314fae6a6d36fb86b::margin_pool::MarginPool<T0>, arg2: &0x97d9473771b01f77b0940c589484184b49f6444627ec121314fae6a6d36fb86b::margin_registry::MarginRegistry, arg3: &0x97d9473771b01f77b0940c589484184b49f6444627ec121314fae6a6d36fb86b::protocol_fees::SupplyReferral, arg4: &0x2::clock::Clock, arg5: &mut 0x2::tx_context::TxContext) : 0x2::coin::Coin<T0> {
        0x4713a25ca8908d18cbe93b6584621f4825fd30b408d2d9a8cfd60cc306373c3b::versioned::check_version(arg0);
        let v0 = 0x97d9473771b01f77b0940c589484184b49f6444627ec121314fae6a6d36fb86b::margin_pool::withdraw_referral_fees<T0>(arg1, arg2, arg3, arg5);
        let v1 = ReferralFeesWithdrawnEvent{
            margin_pool_id     : 0x2::object::id<0x97d9473771b01f77b0940c589484184b49f6444627ec121314fae6a6d36fb86b::margin_pool::MarginPool<T0>>(arg1),
            supply_referral_id : 0x2::object::id<0x97d9473771b01f77b0940c589484184b49f6444627ec121314fae6a6d36fb86b::protocol_fees::SupplyReferral>(arg3),
            coin_type          : 0x1::type_name::with_original_ids<T0>(),
            amount             : 0x2::coin::value<T0>(&v0),
            owner              : 0x2::tx_context::sender(arg5),
            timestamp          : 0x2::clock::timestamp_ms(arg4),
        };
        0x2::event::emit<ReferralFeesWithdrawnEvent>(v1);
        v0
    }

    // decompiled from Move bytecode v6
}

