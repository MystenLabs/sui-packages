module 0x2ba57e9bd6f4a86ef3861f8317cae4c54c40a45027b5f161dda79f4e5c1e023a::clob_registry {
    struct CLOBRegistry has key {
        id: 0x2::object::UID,
        version: u64,
        admin: address,
        operator: address,
        fee_recipient: address,
        market_count: u64,
        markets: 0x2::table::Table<u64, CLOBMarketInfo>,
    }

    struct CLOBMarketInfo has copy, drop, store {
        market_object_id: 0x2::object::ID,
        oracle_object_id: 0x2::object::ID,
        creator: address,
        resolved: bool,
    }

    struct MarketLivenessKey has copy, drop, store {
        market_id: u64,
    }

    struct ResolutionExecutorKey has copy, drop, store {
        executor: address,
    }

    struct CLOBRegistryCreated has copy, drop {
        registry_id: 0x2::object::ID,
        admin: address,
        operator: address,
        fee_recipient: address,
    }

    struct CLOBMarketCreated has copy, drop {
        market_id: u64,
        market_object_id: 0x2::object::ID,
        creator: address,
    }

    struct CLOBResolutionRequested has copy, drop {
        market_id: u64,
        ancillary_data: vector<u8>,
    }

    struct CLOBResolutionFinalized has copy, drop {
        market_id: u64,
        outcome: u8,
    }

    struct CLOBMarketCanceled has copy, drop {
        market_id: u64,
    }

    struct OperatorUpdated has copy, drop {
        old_operator: address,
        new_operator: address,
    }

    struct FeeRecipientUpdated has copy, drop {
        old_fee_recipient: address,
        new_fee_recipient: address,
    }

    struct ResolutionExecutorUpdated has copy, drop {
        executor: address,
        authorized: bool,
    }

    public fun admin(arg0: &CLOBRegistry) : address {
        assert_version(arg0);
        arg0.admin
    }

    fun assert_admin(arg0: &CLOBRegistry, arg1: &0x2::tx_context::TxContext) {
        assert_version(arg0);
        assert!(0x2::tx_context::sender(arg1) == arg0.admin, 0x2ba57e9bd6f4a86ef3861f8317cae4c54c40a45027b5f161dda79f4e5c1e023a::clob_types::e_not_authorized());
    }

    fun assert_operator(arg0: &CLOBRegistry, arg1: &0x2::tx_context::TxContext) {
        assert_version(arg0);
        let v0 = 0x2::tx_context::sender(arg1);
        assert!(v0 == arg0.admin || v0 == arg0.operator, 0x2ba57e9bd6f4a86ef3861f8317cae4c54c40a45027b5f161dda79f4e5c1e023a::clob_types::e_not_authorized());
    }

    fun assert_registered_market(arg0: &CLOBRegistry, arg1: u64, arg2: 0x2::object::ID, arg3: 0x2::object::ID) {
        assert_version(arg0);
        assert!(0x2::table::contains<u64, CLOBMarketInfo>(&arg0.markets, arg1), 100);
        let v0 = 0x2::table::borrow<u64, CLOBMarketInfo>(&arg0.markets, arg1);
        assert!(v0.market_object_id == arg2, 100);
        assert!(v0.oracle_object_id == arg3, 100);
    }

    fun assert_registered_market_object(arg0: &CLOBRegistry, arg1: u64, arg2: 0x2::object::ID) {
        assert_version(arg0);
        assert!(0x2::table::contains<u64, CLOBMarketInfo>(&arg0.markets, arg1), 100);
        assert!(0x2::table::borrow<u64, CLOBMarketInfo>(&arg0.markets, arg1).market_object_id == arg2, 100);
    }

    fun assert_resolution_executor(arg0: &CLOBRegistry, arg1: &0x2::tx_context::TxContext) {
        assert_version(arg0);
        assert!(is_resolution_executor(arg0, 0x2::tx_context::sender(arg1)), 0x2ba57e9bd6f4a86ef3861f8317cae4c54c40a45027b5f161dda79f4e5c1e023a::clob_types::e_not_authorized());
    }

    fun assert_version(arg0: &CLOBRegistry) {
        assert!(arg0.version == 1, 103);
    }

    public fun cancel_market(arg0: &mut CLOBRegistry, arg1: &0xccb197b4f19c0052c2b9ecad6d408713f127b7e03a4d06eed421263772b0d39d::optimistic_oracle::Oracle, arg2: &mut 0x2ba57e9bd6f4a86ef3861f8317cae4c54c40a45027b5f161dda79f4e5c1e023a::clob_market::CLOBMarket, arg3: &mut 0x2::tx_context::TxContext) {
        assert_operator(arg0, arg3);
        let v0 = 0x2ba57e9bd6f4a86ef3861f8317cae4c54c40a45027b5f161dda79f4e5c1e023a::clob_market::market_id(arg2);
        assert_registered_market(arg0, v0, 0x2ba57e9bd6f4a86ef3861f8317cae4c54c40a45027b5f161dda79f4e5c1e023a::clob_market::id(arg2), 0x2::object::id<0xccb197b4f19c0052c2b9ecad6d408713f127b7e03a4d06eed421263772b0d39d::optimistic_oracle::Oracle>(arg1));
        assert!(!0xccb197b4f19c0052c2b9ecad6d408713f127b7e03a4d06eed421263772b0d39d::optimistic_oracle::is_resolution_requested(arg1, v0), 0x2ba57e9bd6f4a86ef3861f8317cae4c54c40a45027b5f161dda79f4e5c1e023a::clob_types::e_invalid_state());
        let v1 = 0x2::table::borrow_mut<u64, CLOBMarketInfo>(&mut arg0.markets, v0);
        assert!(!v1.resolved, 101);
        v1.resolved = true;
        0x2ba57e9bd6f4a86ef3861f8317cae4c54c40a45027b5f161dda79f4e5c1e023a::clob_market::cancel(arg2);
        let v2 = CLOBMarketCanceled{market_id: v0};
        0x2::event::emit<CLOBMarketCanceled>(v2);
    }

    public fun create_clob_market(arg0: &mut CLOBRegistry, arg1: &mut 0xccb197b4f19c0052c2b9ecad6d408713f127b7e03a4d06eed421263772b0d39d::optimistic_oracle::Oracle, arg2: address, arg3: &mut 0x2::tx_context::TxContext) {
        let v0 = 0xccb197b4f19c0052c2b9ecad6d408713f127b7e03a4d06eed421263772b0d39d::optimistic_oracle::liveness_period_ms(arg1);
        0x2ba57e9bd6f4a86ef3861f8317cae4c54c40a45027b5f161dda79f4e5c1e023a::clob_market::share(create_clob_market_internal(arg0, arg1, arg2, v0, arg3));
    }

    fun create_clob_market_internal(arg0: &mut CLOBRegistry, arg1: &mut 0xccb197b4f19c0052c2b9ecad6d408713f127b7e03a4d06eed421263772b0d39d::optimistic_oracle::Oracle, arg2: address, arg3: u64, arg4: &mut 0x2::tx_context::TxContext) : 0x2ba57e9bd6f4a86ef3861f8317cae4c54c40a45027b5f161dda79f4e5c1e023a::clob_market::CLOBMarket {
        let v0 = arg0.market_count;
        arg0.market_count = arg0.market_count + 1;
        let v1 = 0x2ba57e9bd6f4a86ef3861f8317cae4c54c40a45027b5f161dda79f4e5c1e023a::clob_market::new_market(v0, arg2, arg4);
        let v2 = 0x2ba57e9bd6f4a86ef3861f8317cae4c54c40a45027b5f161dda79f4e5c1e023a::clob_market::id(&v1);
        let v3 = CLOBMarketInfo{
            market_object_id : v2,
            oracle_object_id : 0x2::object::id<0xccb197b4f19c0052c2b9ecad6d408713f127b7e03a4d06eed421263772b0d39d::optimistic_oracle::Oracle>(arg1),
            creator          : arg2,
            resolved         : false,
        };
        0x2::table::add<u64, CLOBMarketInfo>(&mut arg0.markets, v0, v3);
        let v4 = MarketLivenessKey{market_id: v0};
        0x2::dynamic_field::add<MarketLivenessKey, u64>(&mut arg0.id, v4, arg3);
        0x2ba57e9bd6f4a86ef3861f8317cae4c54c40a45027b5f161dda79f4e5c1e023a::clob_market::emit_created(&v1);
        let v5 = CLOBMarketCreated{
            market_id        : v0,
            market_object_id : v2,
            creator          : arg2,
        };
        0x2::event::emit<CLOBMarketCreated>(v5);
        v1
    }

    public fun create_clob_market_with_liveness(arg0: &mut CLOBRegistry, arg1: &mut 0xccb197b4f19c0052c2b9ecad6d408713f127b7e03a4d06eed421263772b0d39d::optimistic_oracle::Oracle, arg2: address, arg3: u64, arg4: &mut 0x2::tx_context::TxContext) {
        0x2ba57e9bd6f4a86ef3861f8317cae4c54c40a45027b5f161dda79f4e5c1e023a::clob_market::share(create_clob_market_internal(arg0, arg1, arg2, arg3, arg4));
    }

    public fun fee_recipient(arg0: &CLOBRegistry) : address {
        assert_version(arg0);
        arg0.fee_recipient
    }

    public fun finalize_resolution(arg0: &mut CLOBRegistry, arg1: &0xccb197b4f19c0052c2b9ecad6d408713f127b7e03a4d06eed421263772b0d39d::optimistic_oracle::Oracle, arg2: &mut 0x2ba57e9bd6f4a86ef3861f8317cae4c54c40a45027b5f161dda79f4e5c1e023a::clob_market::CLOBMarket, arg3: &mut 0x2::tx_context::TxContext) {
        assert_resolution_executor(arg0, arg3);
        let v0 = 0x2ba57e9bd6f4a86ef3861f8317cae4c54c40a45027b5f161dda79f4e5c1e023a::clob_market::market_id(arg2);
        assert_registered_market(arg0, v0, 0x2ba57e9bd6f4a86ef3861f8317cae4c54c40a45027b5f161dda79f4e5c1e023a::clob_market::id(arg2), 0x2::object::id<0xccb197b4f19c0052c2b9ecad6d408713f127b7e03a4d06eed421263772b0d39d::optimistic_oracle::Oracle>(arg1));
        let v1 = 0x2::table::borrow_mut<u64, CLOBMarketInfo>(&mut arg0.markets, v0);
        assert!(!v1.resolved, 101);
        let (v2, v3) = 0xccb197b4f19c0052c2b9ecad6d408713f127b7e03a4d06eed421263772b0d39d::optimistic_oracle::get_outcome(arg1, v0);
        assert!(v3, 0x2ba57e9bd6f4a86ef3861f8317cae4c54c40a45027b5f161dda79f4e5c1e023a::clob_types::e_invalid_state());
        v1.resolved = true;
        0x2ba57e9bd6f4a86ef3861f8317cae4c54c40a45027b5f161dda79f4e5c1e023a::clob_market::settle(arg2, v2);
        let v4 = CLOBResolutionFinalized{
            market_id : v0,
            outcome   : v2,
        };
        0x2::event::emit<CLOBResolutionFinalized>(v4);
    }

    public fun get_market(arg0: &CLOBRegistry, arg1: u64) : CLOBMarketInfo {
        assert_version(arg0);
        assert!(0x2::table::contains<u64, CLOBMarketInfo>(&arg0.markets, arg1), 100);
        *0x2::table::borrow<u64, CLOBMarketInfo>(&arg0.markets, arg1)
    }

    public fun has_market(arg0: &CLOBRegistry, arg1: u64) : bool {
        assert_version(arg0);
        0x2::table::contains<u64, CLOBMarketInfo>(&arg0.markets, arg1)
    }

    public fun init_registry(arg0: address, arg1: address, arg2: &mut 0x2::tx_context::TxContext) {
        let v0 = 0x2::tx_context::sender(arg2);
        let v1 = new_registry(v0, arg0, arg1, arg2);
        let v2 = CLOBRegistryCreated{
            registry_id   : 0x2::object::id<CLOBRegistry>(&v1),
            admin         : v0,
            operator      : arg0,
            fee_recipient : arg1,
        };
        0x2::event::emit<CLOBRegistryCreated>(v2);
        0x2::transfer::share_object<CLOBRegistry>(v1);
    }

    public fun is_resolution_executor(arg0: &CLOBRegistry, arg1: address) : bool {
        assert_version(arg0);
        if (arg1 == arg0.admin) {
            true
        } else if (arg1 == arg0.operator) {
            true
        } else {
            resolution_executor_authorized(arg0, arg1)
        }
    }

    public fun market_count(arg0: &CLOBRegistry) : u64 {
        assert_version(arg0);
        arg0.market_count
    }

    public fun market_info_creator(arg0: CLOBMarketInfo) : address {
        arg0.creator
    }

    public fun market_info_object_ids(arg0: CLOBMarketInfo) : (0x2::object::ID, 0x2::object::ID) {
        (arg0.market_object_id, arg0.oracle_object_id)
    }

    public fun market_info_resolved(arg0: CLOBMarketInfo) : bool {
        arg0.resolved
    }

    public fun market_liveness_period_ms(arg0: &CLOBRegistry, arg1: u64) : u64 {
        assert_version(arg0);
        assert!(0x2::table::contains<u64, CLOBMarketInfo>(&arg0.markets, arg1), 100);
        let v0 = MarketLivenessKey{market_id: arg1};
        if (0x2::dynamic_field::exists_with_type<MarketLivenessKey, u64>(&arg0.id, v0)) {
            *0x2::dynamic_field::borrow<MarketLivenessKey, u64>(&arg0.id, v0)
        } else {
            0
        }
    }

    fun market_liveness_period_or_default(arg0: &CLOBRegistry, arg1: &0xccb197b4f19c0052c2b9ecad6d408713f127b7e03a4d06eed421263772b0d39d::optimistic_oracle::Oracle, arg2: u64) : u64 {
        let v0 = market_liveness_period_ms(arg0, arg2);
        if (v0 == 0) {
            0xccb197b4f19c0052c2b9ecad6d408713f127b7e03a4d06eed421263772b0d39d::optimistic_oracle::liveness_period_ms(arg1)
        } else {
            v0
        }
    }

    fun new_registry(arg0: address, arg1: address, arg2: address, arg3: &mut 0x2::tx_context::TxContext) : CLOBRegistry {
        CLOBRegistry{
            id            : 0x2::object::new(arg3),
            version       : 1,
            admin         : arg0,
            operator      : arg1,
            fee_recipient : arg2,
            market_count  : 0,
            markets       : 0x2::table::new<u64, CLOBMarketInfo>(arg3),
        }
    }

    public fun operator(arg0: &CLOBRegistry) : address {
        assert_version(arg0);
        arg0.operator
    }

    public fun pause_market(arg0: &CLOBRegistry, arg1: &mut 0x2ba57e9bd6f4a86ef3861f8317cae4c54c40a45027b5f161dda79f4e5c1e023a::clob_market::CLOBMarket, arg2: &mut 0x2::tx_context::TxContext) {
        assert_operator(arg0, arg2);
        assert_registered_market_object(arg0, 0x2ba57e9bd6f4a86ef3861f8317cae4c54c40a45027b5f161dda79f4e5c1e023a::clob_market::market_id(arg1), 0x2ba57e9bd6f4a86ef3861f8317cae4c54c40a45027b5f161dda79f4e5c1e023a::clob_market::id(arg1));
        0x2ba57e9bd6f4a86ef3861f8317cae4c54c40a45027b5f161dda79f4e5c1e023a::clob_market::pause(arg1);
    }

    public fun request_resolution(arg0: &CLOBRegistry, arg1: &mut 0xccb197b4f19c0052c2b9ecad6d408713f127b7e03a4d06eed421263772b0d39d::optimistic_oracle::Oracle, arg2: &mut 0x2ba57e9bd6f4a86ef3861f8317cae4c54c40a45027b5f161dda79f4e5c1e023a::clob_market::CLOBMarket, arg3: vector<u8>, arg4: &mut 0x2::tx_context::TxContext) {
        assert_resolution_executor(arg0, arg4);
        let v0 = 0x2ba57e9bd6f4a86ef3861f8317cae4c54c40a45027b5f161dda79f4e5c1e023a::clob_market::market_id(arg2);
        assert_registered_market(arg0, v0, 0x2ba57e9bd6f4a86ef3861f8317cae4c54c40a45027b5f161dda79f4e5c1e023a::clob_market::id(arg2), 0x2::object::id<0xccb197b4f19c0052c2b9ecad6d408713f127b7e03a4d06eed421263772b0d39d::optimistic_oracle::Oracle>(arg1));
        0x2ba57e9bd6f4a86ef3861f8317cae4c54c40a45027b5f161dda79f4e5c1e023a::clob_market::pause(arg2);
        if (!0xccb197b4f19c0052c2b9ecad6d408713f127b7e03a4d06eed421263772b0d39d::optimistic_oracle::is_market_registered(arg1, v0)) {
            0xccb197b4f19c0052c2b9ecad6d408713f127b7e03a4d06eed421263772b0d39d::optimistic_oracle::register_market_with_liveness(arg1, v0, 2, 0xccb197b4f19c0052c2b9ecad6d408713f127b7e03a4d06eed421263772b0d39d::optimistic_oracle::outcome_invalid(), market_liveness_period_or_default(arg0, arg1, v0), arg4);
        };
        0xccb197b4f19c0052c2b9ecad6d408713f127b7e03a4d06eed421263772b0d39d::optimistic_oracle::request_resolution(arg1, v0, arg3, arg4);
        let v1 = CLOBResolutionRequested{
            market_id      : v0,
            ancillary_data : arg3,
        };
        0x2::event::emit<CLOBResolutionRequested>(v1);
    }

    fun resolution_executor_authorized(arg0: &CLOBRegistry, arg1: address) : bool {
        let v0 = ResolutionExecutorKey{executor: arg1};
        0x2::dynamic_field::exists_with_type<ResolutionExecutorKey, bool>(&arg0.id, v0) && *0x2::dynamic_field::borrow<ResolutionExecutorKey, bool>(&arg0.id, v0)
    }

    public fun set_fee_recipient(arg0: &mut CLOBRegistry, arg1: address, arg2: &0x2::tx_context::TxContext) {
        assert_admin(arg0, arg2);
        arg0.fee_recipient = arg1;
        let v0 = FeeRecipientUpdated{
            old_fee_recipient : arg0.fee_recipient,
            new_fee_recipient : arg1,
        };
        0x2::event::emit<FeeRecipientUpdated>(v0);
    }

    public fun set_operator(arg0: &mut CLOBRegistry, arg1: address, arg2: &0x2::tx_context::TxContext) {
        assert_admin(arg0, arg2);
        arg0.operator = arg1;
        let v0 = OperatorUpdated{
            old_operator : arg0.operator,
            new_operator : arg1,
        };
        0x2::event::emit<OperatorUpdated>(v0);
    }

    public fun set_resolution_executor(arg0: &mut CLOBRegistry, arg1: address, arg2: bool, arg3: &0x2::tx_context::TxContext) {
        assert_admin(arg0, arg3);
        let v0 = ResolutionExecutorKey{executor: arg1};
        if (0x2::dynamic_field::exists_with_type<ResolutionExecutorKey, bool>(&arg0.id, v0)) {
            *0x2::dynamic_field::borrow_mut<ResolutionExecutorKey, bool>(&mut arg0.id, v0) = arg2;
        } else {
            0x2::dynamic_field::add<ResolutionExecutorKey, bool>(&mut arg0.id, v0, arg2);
        };
        let v1 = ResolutionExecutorUpdated{
            executor   : arg1,
            authorized : arg2,
        };
        0x2::event::emit<ResolutionExecutorUpdated>(v1);
    }

    public fun unpause_market(arg0: &CLOBRegistry, arg1: &0xccb197b4f19c0052c2b9ecad6d408713f127b7e03a4d06eed421263772b0d39d::optimistic_oracle::Oracle, arg2: &mut 0x2ba57e9bd6f4a86ef3861f8317cae4c54c40a45027b5f161dda79f4e5c1e023a::clob_market::CLOBMarket, arg3: &mut 0x2::tx_context::TxContext) {
        assert_operator(arg0, arg3);
        let v0 = 0x2ba57e9bd6f4a86ef3861f8317cae4c54c40a45027b5f161dda79f4e5c1e023a::clob_market::market_id(arg2);
        assert_registered_market(arg0, v0, 0x2ba57e9bd6f4a86ef3861f8317cae4c54c40a45027b5f161dda79f4e5c1e023a::clob_market::id(arg2), 0x2::object::id<0xccb197b4f19c0052c2b9ecad6d408713f127b7e03a4d06eed421263772b0d39d::optimistic_oracle::Oracle>(arg1));
        assert!(!0xccb197b4f19c0052c2b9ecad6d408713f127b7e03a4d06eed421263772b0d39d::optimistic_oracle::is_resolution_requested(arg1, v0), 0x2ba57e9bd6f4a86ef3861f8317cae4c54c40a45027b5f161dda79f4e5c1e023a::clob_types::e_invalid_state());
        0x2ba57e9bd6f4a86ef3861f8317cae4c54c40a45027b5f161dda79f4e5c1e023a::clob_market::unpause(arg2);
    }

    public fun version(arg0: &CLOBRegistry) : u64 {
        assert_version(arg0);
        arg0.version
    }

    // decompiled from Move bytecode v7
}

