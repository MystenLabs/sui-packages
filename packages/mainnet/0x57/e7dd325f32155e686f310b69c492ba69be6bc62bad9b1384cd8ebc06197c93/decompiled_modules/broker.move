module 0x7b4f376227734969c53d303d5ccf80fed8247528624b2421f4cbfb87ffafd619::broker {
    struct BuyOrderCreated has copy, drop {
        order_id: u64,
        owner: address,
        market_id: u64,
        usdc_amount: u64,
        min_shares_out: u64,
        client_order_id: 0x1::string::String,
        expires_at_ms: u64,
    }

    struct BuyOrderSettled has copy, drop {
        order_id: u64,
        owner: address,
        market_id: u64,
        shares_out: u64,
        external_execution_id: 0x1::string::String,
        proof_hash: address,
    }

    struct BuyOrderRefunded has copy, drop {
        order_id: u64,
        owner: address,
        market_id: u64,
        usdc_amount: u64,
    }

    struct SellOrderCreated has copy, drop {
        order_id: u64,
        owner: address,
        market_id: u64,
        share_amount: u64,
        min_usdc_out: u64,
        client_order_id: 0x1::string::String,
        expires_at_ms: u64,
    }

    struct SellOrderSettled has copy, drop {
        order_id: u64,
        owner: address,
        market_id: u64,
        usdc_amount: u64,
        external_execution_id: 0x1::string::String,
        proof_hash: address,
    }

    struct SellOrderRefunded has copy, drop {
        order_id: u64,
        owner: address,
        market_id: u64,
        share_amount: u64,
    }

    struct ProtocolPaused has copy, drop {
        dummy_field: bool,
    }

    struct ProtocolUnpaused has copy, drop {
        dummy_field: bool,
    }

    struct BROKER has drop {
        dummy_field: bool,
    }

    struct BrokerConfig<phantom T0> has key {
        id: 0x2::object::UID,
        admin: address,
        settlement_authority: address,
        paused: bool,
        next_order_id: u64,
        version: u64,
        usdc_treasury: 0x2::balance::Balance<T0>,
        share_cap: 0x1::option::Option<0x2::coin::TreasuryCap<0x7b4f376227734969c53d303d5ccf80fed8247528624b2421f4cbfb87ffafd619::shares::SHARES>>,
        markets: 0x2::table::Table<u64, Market>,
        client_order_ids: 0x2::table::Table<address, 0x2::table::Table<0x1::string::String, u64>>,
    }

    struct BrokerBootstrap has key {
        id: 0x2::object::UID,
        admin: address,
        settlement_authority: address,
        initialized: bool,
    }

    struct CanaryConfig has key {
        id: 0x2::object::UID,
        canary_mode: bool,
        allowed_buyer: address,
        max_open_orders: u64,
        max_total_open_buy_usdc: u64,
        max_single_buy_usdc: u64,
        open_orders: u64,
        total_open_buy_usdc: u64,
    }

    struct Market has store {
        market_id: u64,
        symbol: 0x1::string::String,
        enabled: bool,
        buy_enabled: bool,
        sell_enabled: bool,
        min_buy: u64,
        max_buy: u64,
        min_sell: u64,
        max_sell: u64,
    }

    struct BuyOrder<phantom T0> has key {
        id: 0x2::object::UID,
        order_id: u64,
        owner: address,
        market_id: u64,
        usdc_amount: u64,
        min_shares_out: u64,
        client_order_id: 0x1::string::String,
        created_at_ms: u64,
        expires_at_ms: u64,
        status: u8,
        escrowed_usdc: 0x2::balance::Balance<T0>,
        proof_hash: address,
    }

    struct SellOrder has key {
        id: 0x2::object::UID,
        order_id: u64,
        owner: address,
        market_id: u64,
        share_amount: u64,
        min_usdc_out: u64,
        client_order_id: 0x1::string::String,
        created_at_ms: u64,
        expires_at_ms: u64,
        status: u8,
        escrowed_shares: 0x2::balance::Balance<0x7b4f376227734969c53d303d5ccf80fed8247528624b2421f4cbfb87ffafd619::shares::SHARES>,
        proof_hash: address,
    }

    public fun add_market<T0>(arg0: &mut BrokerConfig<T0>, arg1: u64, arg2: 0x1::string::String, arg3: u64, arg4: u64, arg5: u64, arg6: u64, arg7: &0x2::tx_context::TxContext) {
        only_admin<T0>(arg0, arg7);
        assert!(arg4 >= arg3, 7);
        assert!(arg6 >= arg5, 7);
        assert!(!0x2::table::contains<u64, Market>(&arg0.markets, arg1), 13);
        let v0 = Market{
            market_id    : arg1,
            symbol       : arg2,
            enabled      : false,
            buy_enabled  : false,
            sell_enabled : false,
            min_buy      : arg3,
            max_buy      : arg4,
            min_sell     : arg5,
            max_sell     : arg6,
        };
        0x2::table::add<u64, Market>(&mut arg0.markets, arg1, v0);
    }

    public fun admin<T0>(arg0: &BrokerConfig<T0>) : address {
        arg0.admin
    }

    fun assert_settlement_prereqs<T0>(arg0: &BrokerConfig<T0>, arg1: &0x2::tx_context::TxContext) {
        only_settlement_authority<T0>(arg0, arg1);
        assert!(!arg0.paused, 2);
    }

    public fun buy_escrowed_usdc<T0>(arg0: &BuyOrder<T0>) : u64 {
        0x2::balance::value<T0>(&arg0.escrowed_usdc)
    }

    public fun buy_market_id<T0>(arg0: &BuyOrder<T0>) : u64 {
        arg0.market_id
    }

    public fun buy_min_shares_out<T0>(arg0: &BuyOrder<T0>) : u64 {
        arg0.min_shares_out
    }

    public fun buy_order_id<T0>(arg0: &BuyOrder<T0>) : u64 {
        arg0.order_id
    }

    public fun buy_owner<T0>(arg0: &BuyOrder<T0>) : address {
        arg0.owner
    }

    public fun buy_proof_hash<T0>(arg0: &BuyOrder<T0>) : address {
        arg0.proof_hash
    }

    public fun buy_status<T0>(arg0: &BuyOrder<T0>) : u8 {
        arg0.status
    }

    public fun buy_usdc_amount<T0>(arg0: &BuyOrder<T0>) : u64 {
        arg0.usdc_amount
    }

    public fun canary_allowed_buyer(arg0: &CanaryConfig) : address {
        arg0.allowed_buyer
    }

    public fun canary_open_orders(arg0: &CanaryConfig) : u64 {
        arg0.open_orders
    }

    public fun canary_total_open_buy_usdc(arg0: &CanaryConfig) : u64 {
        arg0.total_open_buy_usdc
    }

    public fun create_buy_order<T0>(arg0: &mut BrokerConfig<T0>, arg1: 0x2::coin::Coin<T0>, arg2: u64, arg3: u64, arg4: 0x1::string::String, arg5: u64, arg6: &mut 0x2::tx_context::TxContext) {
        abort 18
    }

    public fun create_buy_order_canary<T0>(arg0: &mut BrokerConfig<T0>, arg1: &mut CanaryConfig, arg2: 0x2::coin::Coin<T0>, arg3: u64, arg4: u64, arg5: 0x1::string::String, arg6: u64, arg7: &mut 0x2::tx_context::TxContext) {
        assert!(!arg0.paused, 2);
        let v0 = market<T0>(arg0, arg3);
        assert!(v0.enabled, 4);
        assert!(v0.buy_enabled, 5);
        let v1 = 0x2::coin::value<T0>(&arg2);
        assert!(v1 >= v0.min_buy, 7);
        assert!(v1 <= v0.max_buy, 8);
        if (arg1.canary_mode) {
            assert!(0x2::tx_context::sender(arg7) == arg1.allowed_buyer, 16);
            assert!(arg1.open_orders < arg1.max_open_orders, 17);
            assert!(v1 <= arg1.max_single_buy_usdc, 8);
            assert!(arg1.total_open_buy_usdc + v1 <= arg1.max_total_open_buy_usdc, 8);
            arg1.open_orders = arg1.open_orders + 1;
            arg1.total_open_buy_usdc = arg1.total_open_buy_usdc + v1;
        };
        let v2 = 0x2::tx_context::sender(arg7);
        let v3 = next_order_id<T0>(arg0);
        register_client_order_id<T0>(arg0, v2, arg5, v3, arg7);
        let v4 = BuyOrder<T0>{
            id              : 0x2::object::new(arg7),
            order_id        : v3,
            owner           : v2,
            market_id       : arg3,
            usdc_amount     : v1,
            min_shares_out  : arg4,
            client_order_id : arg5,
            created_at_ms   : 0x2::tx_context::epoch_timestamp_ms(arg7),
            expires_at_ms   : arg6,
            status          : 0,
            escrowed_usdc   : 0x2::coin::into_balance<T0>(arg2),
            proof_hash      : @0x0,
        };
        0x2::transfer::share_object<BuyOrder<T0>>(v4);
        let v5 = BuyOrderCreated{
            order_id        : v3,
            owner           : v2,
            market_id       : arg3,
            usdc_amount     : v1,
            min_shares_out  : arg4,
            client_order_id : arg5,
            expires_at_ms   : arg6,
        };
        0x2::event::emit<BuyOrderCreated>(v5);
    }

    public fun create_canary_config<T0>(arg0: &BrokerConfig<T0>, arg1: &mut 0x2::tx_context::TxContext) {
        only_admin<T0>(arg0, arg1);
        let v0 = CanaryConfig{
            id                      : 0x2::object::new(arg1),
            canary_mode             : false,
            allowed_buyer           : @0x0,
            max_open_orders         : 1,
            max_total_open_buy_usdc : 0,
            max_single_buy_usdc     : 0,
            open_orders             : 0,
            total_open_buy_usdc     : 0,
        };
        0x2::transfer::share_object<CanaryConfig>(v0);
    }

    public fun create_config<T0>(arg0: &mut BrokerBootstrap, arg1: &mut 0x2::tx_context::TxContext) {
        assert!(0x2::tx_context::sender(arg1) == arg0.admin, 0);
        assert!(!arg0.initialized, 13);
        arg0.initialized = true;
        let v0 = BrokerConfig<T0>{
            id                   : 0x2::object::new(arg1),
            admin                : arg0.admin,
            settlement_authority : arg0.settlement_authority,
            paused               : true,
            next_order_id        : 1,
            version              : 2,
            usdc_treasury        : 0x2::balance::zero<T0>(),
            share_cap            : 0x1::option::none<0x2::coin::TreasuryCap<0x7b4f376227734969c53d303d5ccf80fed8247528624b2421f4cbfb87ffafd619::shares::SHARES>>(),
            markets              : 0x2::table::new<u64, Market>(arg1),
            client_order_ids     : 0x2::table::new<address, 0x2::table::Table<0x1::string::String, u64>>(arg1),
        };
        0x2::transfer::share_object<BrokerConfig<T0>>(v0);
    }

    public fun create_sell_order<T0>(arg0: &mut BrokerConfig<T0>, arg1: 0x2::coin::Coin<0x7b4f376227734969c53d303d5ccf80fed8247528624b2421f4cbfb87ffafd619::shares::SHARES>, arg2: u64, arg3: u64, arg4: 0x1::string::String, arg5: u64, arg6: &mut 0x2::tx_context::TxContext) {
        assert!(!arg0.paused, 2);
        let v0 = market<T0>(arg0, arg2);
        assert!(v0.enabled, 4);
        assert!(v0.sell_enabled, 6);
        let v1 = 0x2::coin::value<0x7b4f376227734969c53d303d5ccf80fed8247528624b2421f4cbfb87ffafd619::shares::SHARES>(&arg1);
        assert!(v1 >= v0.min_sell, 7);
        assert!(v1 <= v0.max_sell, 8);
        let v2 = 0x2::tx_context::sender(arg6);
        let v3 = next_order_id<T0>(arg0);
        register_client_order_id<T0>(arg0, v2, arg4, v3, arg6);
        let v4 = SellOrder{
            id              : 0x2::object::new(arg6),
            order_id        : v3,
            owner           : v2,
            market_id       : arg2,
            share_amount    : v1,
            min_usdc_out    : arg3,
            client_order_id : arg4,
            created_at_ms   : 0x2::tx_context::epoch_timestamp_ms(arg6),
            expires_at_ms   : arg5,
            status          : 0,
            escrowed_shares : 0x2::coin::into_balance<0x7b4f376227734969c53d303d5ccf80fed8247528624b2421f4cbfb87ffafd619::shares::SHARES>(arg1),
            proof_hash      : @0x0,
        };
        0x2::transfer::share_object<SellOrder>(v4);
        let v5 = SellOrderCreated{
            order_id        : v3,
            owner           : v2,
            market_id       : arg2,
            share_amount    : v1,
            min_usdc_out    : arg3,
            client_order_id : arg4,
            expires_at_ms   : arg5,
        };
        0x2::event::emit<SellOrderCreated>(v5);
    }

    public fun disable_market<T0>(arg0: &mut BrokerConfig<T0>, arg1: u64, arg2: &0x2::tx_context::TxContext) {
        only_admin<T0>(arg0, arg2);
        0x2::table::borrow_mut<u64, Market>(&mut arg0.markets, arg1).enabled = false;
    }

    public fun enable_market<T0>(arg0: &mut BrokerConfig<T0>, arg1: u64, arg2: &0x2::tx_context::TxContext) {
        only_admin<T0>(arg0, arg2);
        0x2::table::borrow_mut<u64, Market>(&mut arg0.markets, arg1).enabled = true;
    }

    fun init(arg0: BROKER, arg1: &mut 0x2::tx_context::TxContext) {
        let v0 = BrokerBootstrap{
            id                   : 0x2::object::new(arg1),
            admin                : 0x2::tx_context::sender(arg1),
            settlement_authority : 0x2::tx_context::sender(arg1),
            initialized          : false,
        };
        0x2::transfer::share_object<BrokerBootstrap>(v0);
    }

    public fun is_canary_mode(arg0: &CanaryConfig) : bool {
        arg0.canary_mode
    }

    fun is_expired(arg0: u64, arg1: &0x2::tx_context::TxContext) : bool {
        arg0 < 0x2::tx_context::epoch_timestamp_ms(arg1)
    }

    public fun is_paused<T0>(arg0: &BrokerConfig<T0>) : bool {
        arg0.paused
    }

    fun market<T0>(arg0: &BrokerConfig<T0>, arg1: u64) : &Market {
        assert!(0x2::table::contains<u64, Market>(&arg0.markets, arg1), 3);
        0x2::table::borrow<u64, Market>(&arg0.markets, arg1)
    }

    fun next_order_id<T0>(arg0: &mut BrokerConfig<T0>) : u64 {
        arg0.next_order_id = arg0.next_order_id + 1;
        arg0.next_order_id
    }

    fun only_admin<T0>(arg0: &BrokerConfig<T0>, arg1: &0x2::tx_context::TxContext) {
        assert!(0x2::tx_context::sender(arg1) == arg0.admin, 0);
    }

    fun only_settlement_authority<T0>(arg0: &BrokerConfig<T0>, arg1: &0x2::tx_context::TxContext) {
        assert!(0x2::tx_context::sender(arg1) == arg0.settlement_authority, 1);
    }

    public fun pause<T0>(arg0: &mut BrokerConfig<T0>, arg1: &0x2::tx_context::TxContext) {
        only_admin<T0>(arg0, arg1);
        assert!(!arg0.paused, 2);
        arg0.paused = true;
        let v0 = ProtocolPaused{dummy_field: false};
        0x2::event::emit<ProtocolPaused>(v0);
    }

    public fun refund_buy<T0>(arg0: &mut BrokerConfig<T0>, arg1: &mut BuyOrder<T0>, arg2: &mut 0x2::tx_context::TxContext) {
        assert!(arg1.status == 0, 9);
        assert!(0x2::tx_context::sender(arg2) == arg0.settlement_authority || is_expired(arg1.expires_at_ms, arg2), 1);
        0x2::transfer::public_transfer<0x2::coin::Coin<T0>>(0x2::coin::from_balance<T0>(0x2::balance::withdraw_all<T0>(&mut arg1.escrowed_usdc), arg2), arg1.owner);
        arg1.status = 2;
        let v0 = BuyOrderRefunded{
            order_id    : arg1.order_id,
            owner       : arg1.owner,
            market_id   : arg1.market_id,
            usdc_amount : arg1.usdc_amount,
        };
        0x2::event::emit<BuyOrderRefunded>(v0);
    }

    public fun refund_sell<T0>(arg0: &mut BrokerConfig<T0>, arg1: &mut SellOrder, arg2: &mut 0x2::tx_context::TxContext) {
        assert!(arg1.status == 0, 9);
        assert!(0x2::tx_context::sender(arg2) == arg0.settlement_authority || is_expired(arg1.expires_at_ms, arg2), 1);
        0x2::transfer::public_transfer<0x2::coin::Coin<0x7b4f376227734969c53d303d5ccf80fed8247528624b2421f4cbfb87ffafd619::shares::SHARES>>(0x2::coin::from_balance<0x7b4f376227734969c53d303d5ccf80fed8247528624b2421f4cbfb87ffafd619::shares::SHARES>(0x2::balance::withdraw_all<0x7b4f376227734969c53d303d5ccf80fed8247528624b2421f4cbfb87ffafd619::shares::SHARES>(&mut arg1.escrowed_shares), arg2), arg1.owner);
        arg1.status = 2;
        let v0 = SellOrderRefunded{
            order_id     : arg1.order_id,
            owner        : arg1.owner,
            market_id    : arg1.market_id,
            share_amount : arg1.share_amount,
        };
        0x2::event::emit<SellOrderRefunded>(v0);
    }

    fun register_client_order_id<T0>(arg0: &mut BrokerConfig<T0>, arg1: address, arg2: 0x1::string::String, arg3: u64, arg4: &mut 0x2::tx_context::TxContext) {
        if (!0x2::table::contains<address, 0x2::table::Table<0x1::string::String, u64>>(&arg0.client_order_ids, arg1)) {
            0x2::table::add<address, 0x2::table::Table<0x1::string::String, u64>>(&mut arg0.client_order_ids, arg1, 0x2::table::new<0x1::string::String, u64>(arg4));
        };
        let v0 = 0x2::table::borrow_mut<address, 0x2::table::Table<0x1::string::String, u64>>(&mut arg0.client_order_ids, arg1);
        assert!(!0x2::table::contains<0x1::string::String, u64>(v0, arg2), 12);
        0x2::table::add<0x1::string::String, u64>(v0, arg2, arg3);
    }

    public fun sell_escrowed_shares(arg0: &SellOrder) : u64 {
        0x2::balance::value<0x7b4f376227734969c53d303d5ccf80fed8247528624b2421f4cbfb87ffafd619::shares::SHARES>(&arg0.escrowed_shares)
    }

    public fun sell_market_id(arg0: &SellOrder) : u64 {
        arg0.market_id
    }

    public fun sell_min_usdc_out(arg0: &SellOrder) : u64 {
        arg0.min_usdc_out
    }

    public fun sell_order_id(arg0: &SellOrder) : u64 {
        arg0.order_id
    }

    public fun sell_owner(arg0: &SellOrder) : address {
        arg0.owner
    }

    public fun sell_proof_hash(arg0: &SellOrder) : address {
        arg0.proof_hash
    }

    public fun sell_share_amount(arg0: &SellOrder) : u64 {
        arg0.share_amount
    }

    public fun sell_status(arg0: &SellOrder) : u8 {
        arg0.status
    }

    public fun set_canary_controls<T0>(arg0: &BrokerConfig<T0>, arg1: &mut CanaryConfig, arg2: bool, arg3: address, arg4: u64, arg5: u64, arg6: u64, arg7: &0x2::tx_context::TxContext) {
        only_admin<T0>(arg0, arg7);
        arg1.canary_mode = arg2;
        arg1.allowed_buyer = arg3;
        arg1.max_open_orders = arg4;
        arg1.max_total_open_buy_usdc = arg5;
        arg1.max_single_buy_usdc = arg6;
    }

    public fun set_market_buy_enabled<T0>(arg0: &mut BrokerConfig<T0>, arg1: u64, arg2: bool, arg3: &0x2::tx_context::TxContext) {
        only_admin<T0>(arg0, arg3);
        0x2::table::borrow_mut<u64, Market>(&mut arg0.markets, arg1).buy_enabled = arg2;
    }

    public fun set_market_sell_enabled<T0>(arg0: &mut BrokerConfig<T0>, arg1: u64, arg2: bool, arg3: &0x2::tx_context::TxContext) {
        only_admin<T0>(arg0, arg3);
        0x2::table::borrow_mut<u64, Market>(&mut arg0.markets, arg1).sell_enabled = arg2;
    }

    public fun set_share_cap<T0>(arg0: &mut BrokerConfig<T0>, arg1: 0x2::coin::TreasuryCap<0x7b4f376227734969c53d303d5ccf80fed8247528624b2421f4cbfb87ffafd619::shares::SHARES>, arg2: &0x2::tx_context::TxContext) {
        only_admin<T0>(arg0, arg2);
        assert!(0x1::option::is_none<0x2::coin::TreasuryCap<0x7b4f376227734969c53d303d5ccf80fed8247528624b2421f4cbfb87ffafd619::shares::SHARES>>(&arg0.share_cap), 15);
        0x1::option::fill<0x2::coin::TreasuryCap<0x7b4f376227734969c53d303d5ccf80fed8247528624b2421f4cbfb87ffafd619::shares::SHARES>>(&mut arg0.share_cap, arg1);
    }

    public fun settle_buy<T0>(arg0: &mut BrokerConfig<T0>, arg1: &mut BuyOrder<T0>, arg2: u64, arg3: 0x1::string::String, arg4: address, arg5: &mut 0x2::tx_context::TxContext) {
        assert_settlement_prereqs<T0>(arg0, arg5);
        assert!(arg1.status == 0, 9);
        assert!(arg2 >= arg1.min_shares_out, 10);
        assert!(0x1::string::length(&arg3) > 0, 11);
        0x2::balance::join<T0>(&mut arg0.usdc_treasury, 0x2::balance::withdraw_all<T0>(&mut arg1.escrowed_usdc));
        0x2::coin::mint_and_transfer<0x7b4f376227734969c53d303d5ccf80fed8247528624b2421f4cbfb87ffafd619::shares::SHARES>(0x1::option::borrow_mut<0x2::coin::TreasuryCap<0x7b4f376227734969c53d303d5ccf80fed8247528624b2421f4cbfb87ffafd619::shares::SHARES>>(&mut arg0.share_cap), arg2, arg1.owner, arg5);
        arg1.status = 1;
        arg1.proof_hash = arg4;
        let v0 = BuyOrderSettled{
            order_id              : arg1.order_id,
            owner                 : arg1.owner,
            market_id             : arg1.market_id,
            shares_out            : arg2,
            external_execution_id : arg3,
            proof_hash            : arg4,
        };
        0x2::event::emit<BuyOrderSettled>(v0);
    }

    public fun settle_sell<T0>(arg0: &mut BrokerConfig<T0>, arg1: &mut SellOrder, arg2: u64, arg3: 0x1::string::String, arg4: address, arg5: &mut 0x2::tx_context::TxContext) {
        assert_settlement_prereqs<T0>(arg0, arg5);
        assert!(arg1.status == 0, 9);
        assert!(arg2 >= arg1.min_usdc_out, 10);
        assert!(0x1::string::length(&arg3) > 0, 11);
        assert!(0x2::balance::value<T0>(&arg0.usdc_treasury) >= arg2, 14);
        0x2::coin::burn<0x7b4f376227734969c53d303d5ccf80fed8247528624b2421f4cbfb87ffafd619::shares::SHARES>(0x1::option::borrow_mut<0x2::coin::TreasuryCap<0x7b4f376227734969c53d303d5ccf80fed8247528624b2421f4cbfb87ffafd619::shares::SHARES>>(&mut arg0.share_cap), 0x2::coin::from_balance<0x7b4f376227734969c53d303d5ccf80fed8247528624b2421f4cbfb87ffafd619::shares::SHARES>(0x2::balance::withdraw_all<0x7b4f376227734969c53d303d5ccf80fed8247528624b2421f4cbfb87ffafd619::shares::SHARES>(&mut arg1.escrowed_shares), arg5));
        0x2::transfer::public_transfer<0x2::coin::Coin<T0>>(0x2::coin::from_balance<T0>(0x2::balance::split<T0>(&mut arg0.usdc_treasury, arg2), arg5), arg1.owner);
        arg1.status = 1;
        arg1.proof_hash = arg4;
        let v0 = SellOrderSettled{
            order_id              : arg1.order_id,
            owner                 : arg1.owner,
            market_id             : arg1.market_id,
            usdc_amount           : arg2,
            external_execution_id : arg3,
            proof_hash            : arg4,
        };
        0x2::event::emit<SellOrderSettled>(v0);
    }

    public fun settlement_authority<T0>(arg0: &BrokerConfig<T0>) : address {
        arg0.settlement_authority
    }

    public fun share_cap_set<T0>(arg0: &BrokerConfig<T0>) : bool {
        0x1::option::is_some<0x2::coin::TreasuryCap<0x7b4f376227734969c53d303d5ccf80fed8247528624b2421f4cbfb87ffafd619::shares::SHARES>>(&arg0.share_cap)
    }

    public fun treasury_balance<T0>(arg0: &BrokerConfig<T0>) : u64 {
        0x2::balance::value<T0>(&arg0.usdc_treasury)
    }

    public fun unpause<T0>(arg0: &mut BrokerConfig<T0>, arg1: &0x2::tx_context::TxContext) {
        only_admin<T0>(arg0, arg1);
        arg0.paused = false;
        let v0 = ProtocolUnpaused{dummy_field: false};
        0x2::event::emit<ProtocolUnpaused>(v0);
    }

    public fun update_market_limits<T0>(arg0: &mut BrokerConfig<T0>, arg1: u64, arg2: u64, arg3: u64, arg4: u64, arg5: u64, arg6: &0x2::tx_context::TxContext) {
        only_admin<T0>(arg0, arg6);
        assert!(arg3 >= arg2, 7);
        assert!(arg5 >= arg4, 7);
        let v0 = 0x2::table::borrow_mut<u64, Market>(&mut arg0.markets, arg1);
        v0.min_buy = arg2;
        v0.max_buy = arg3;
        v0.min_sell = arg4;
        v0.max_sell = arg5;
    }

    public fun update_settlement_authority<T0>(arg0: &mut BrokerConfig<T0>, arg1: address, arg2: &0x2::tx_context::TxContext) {
        only_admin<T0>(arg0, arg2);
        arg0.settlement_authority = arg1;
    }

    // decompiled from Move bytecode v7
}

