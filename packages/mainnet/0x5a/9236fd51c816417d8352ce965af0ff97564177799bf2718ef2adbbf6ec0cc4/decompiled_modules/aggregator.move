module 0x74bce93b827addba14d1c50a0bea79d6e77b6ee7d95edd9c2dd07fe86541e40b::aggregator {
    struct AggregatorCreated has copy, drop {
        id: 0x2::object::ID,
        timestamp: u64,
    }

    struct AdminCapCreated has copy, drop {
        id: 0x2::object::ID,
        admin: address,
        timestamp: u64,
    }

    struct AdminCapRevoked has copy, drop {
        admin: address,
        timestamp: u64,
    }

    struct Deposited has copy, drop {
        trade_id: 0x2::object::ID,
        coin: 0x1::type_name::TypeName,
        amount: u64,
        sender: address,
        timestamp: u64,
    }

    struct Withdrawn has copy, drop {
        trade_id: 0x2::object::ID,
        coin: 0x1::type_name::TypeName,
        amount: u64,
        receivor: address,
        timestamp: u64,
    }

    struct Traded has copy, drop {
        trade_id: 0x2::object::ID,
        from: 0x1::type_name::TypeName,
        from_amount: u64,
        steps: vector<TradeStep>,
        to: 0x1::type_name::TypeName,
        to_amount: u64,
        timestamp: u64,
    }

    struct AGGREGATOR has drop {
        dummy_field: bool,
    }

    struct Aggregator has key {
        id: 0x2::object::UID,
        admin_caps: 0x2::table::Table<address, bool>,
        receipts: 0x2::table::Table<0x2::object::ID, TradeReceipt>,
    }

    struct SuperAdminCap has store, key {
        id: 0x2::object::UID,
    }

    struct AdminCap has store, key {
        id: 0x2::object::UID,
        admin_address: address,
    }

    struct TradeStep has copy, drop, store {
        dex: u8,
        coin: 0x1::type_name::TypeName,
        amount: u64,
    }

    struct TradeReceipt has copy, drop, store {
        id: 0x2::object::ID,
        from: 0x1::type_name::TypeName,
        from_amount: u64,
        steps: vector<TradeStep>,
        to: 0x1::type_name::TypeName,
        to_amount: u64,
        receivor: address,
    }

    struct CoinKey<phantom T0> has copy, drop, store {
        dummy_field: bool,
    }

    fun after_execute<T0>(arg0: &mut Aggregator, arg1: u8, arg2: 0x2::coin::Coin<T0>, arg3: u64, arg4: 0x2::object::ID, arg5: &0x2::tx_context::TxContext) {
        assert!(exists_trade_receipt(arg0, arg4), 6);
        let v0 = get_trade_receipt(arg0, arg4);
        let v1 = 0x2::coin::value<T0>(&arg2);
        let v2 = 0x1::type_name::get<T0>();
        let v3 = TradeStep{
            dex    : arg1,
            coin   : v2,
            amount : v1,
        };
        0x1::vector::push_back<TradeStep>(&mut v0.steps, v3);
        v0.to = v2;
        v0.to_amount = v1;
        update_trade_receipt(arg0, v0);
        if (arg3 != 0) {
            assert!(v1 >= arg3, 5);
        };
        store_intermediate_coin<T0>(arg0, arg2);
    }

    fun before_execute<T0>(arg0: &mut Aggregator, arg1: u8, arg2: u64, arg3: 0x2::object::ID, arg4: &mut 0x2::tx_context::TxContext) : 0x2::coin::Coin<T0> {
        assert!(exists_trade_receipt(arg0, arg3), 6);
        assert!(arg2 > 0, 4);
        extract_intermediate_coin<T0>(arg0, arg2, arg4)
    }

    public entry fun create_admin_batch(arg0: &mut Aggregator, arg1: &SuperAdminCap, arg2: vector<address>, arg3: &mut 0x2::tx_context::TxContext) {
        let v0 = 0;
        while (v0 < 0x1::vector::length<address>(&arg2)) {
            let v1 = *0x1::vector::borrow<address>(&arg2, v0);
            if (!0x2::table::contains<address, bool>(&arg0.admin_caps, v1)) {
                0x2::table::add<address, bool>(&mut arg0.admin_caps, v1, true);
                let v2 = AdminCap{
                    id            : 0x2::object::new(arg3),
                    admin_address : v1,
                };
                let v3 = AdminCapCreated{
                    id        : 0x2::object::id<AdminCap>(&v2),
                    admin     : v1,
                    timestamp : 0x2::tx_context::epoch_timestamp_ms(arg3),
                };
                0x2::event::emit<AdminCapCreated>(v3);
                0x2::transfer::transfer<AdminCap>(v2, v1);
            };
            if (!*0x2::table::borrow<address, bool>(&arg0.admin_caps, v1)) {
                0x2::table::remove<address, bool>(&mut arg0.admin_caps, v1);
                0x2::table::add<address, bool>(&mut arg0.admin_caps, v1, true);
            };
            v0 = v0 + 1;
        };
    }

    fun create_aggregator(arg0: &mut 0x2::tx_context::TxContext) : SuperAdminCap {
        let v0 = Aggregator{
            id         : 0x2::object::new(arg0),
            admin_caps : 0x2::table::new<address, bool>(arg0),
            receipts   : 0x2::table::new<0x2::object::ID, TradeReceipt>(arg0),
        };
        let v1 = SuperAdminCap{id: 0x2::object::new(arg0)};
        let v2 = AggregatorCreated{
            id        : 0x2::object::id<Aggregator>(&v0),
            timestamp : 0x2::tx_context::epoch_timestamp_ms(arg0),
        };
        0x2::event::emit<AggregatorCreated>(v2);
        0x2::transfer::share_object<Aggregator>(v0);
        v1
    }

    fun create_trade_receipt(arg0: &mut Aggregator, arg1: 0x1::type_name::TypeName, arg2: u64, arg3: &mut 0x2::tx_context::TxContext) : 0x2::object::ID {
        let v0 = 0x2::object::new(arg3);
        let v1 = TradeReceipt{
            id          : *0x2::object::uid_as_inner(&v0),
            from        : arg1,
            from_amount : arg2,
            steps       : 0x1::vector::empty<TradeStep>(),
            to          : arg1,
            to_amount   : arg2,
            receivor    : 0x2::tx_context::sender(arg3),
        };
        0x2::object::delete(v0);
        0x2::table::add<0x2::object::ID, TradeReceipt>(&mut arg0.receipts, v1.id, v1);
        v1.id
    }

    fun delete_trade_receipt(arg0: &mut Aggregator, arg1: 0x2::object::ID) {
        assert!(exists_trade_receipt(arg0, arg1), 6);
        0x2::table::remove<0x2::object::ID, TradeReceipt>(&mut arg0.receipts, arg1);
    }

    public entry fun deposit<T0>(arg0: &mut Aggregator, arg1: 0x2::coin::Coin<T0>, arg2: &mut 0x2::tx_context::TxContext) : 0x2::object::ID {
        let v0 = 0x2::coin::value<T0>(&arg1);
        assert!(v0 > 0, 4);
        store_intermediate_coin<T0>(arg0, arg1);
        let v1 = create_trade_receipt(arg0, 0x1::type_name::get<T0>(), v0, arg2);
        let v2 = Deposited{
            trade_id  : v1,
            coin      : 0x1::type_name::get<T0>(),
            amount    : v0,
            sender    : 0x2::tx_context::sender(arg2),
            timestamp : 0x2::tx_context::epoch_timestamp_ms(arg2),
        };
        0x2::event::emit<Deposited>(v2);
        v1
    }

    public entry fun execute_bluefin_swap<T0, T1>(arg0: &mut Aggregator, arg1: bool, arg2: u64, arg3: u64, arg4: 0x2::object::ID, arg5: &0x2::clock::Clock, arg6: &0x3492c874c1e3b3e2984e8c41b589e642d4d0a5d6459e5a9cfc2d52fd7c89c267::config::GlobalConfig, arg7: &mut 0x3492c874c1e3b3e2984e8c41b589e642d4d0a5d6459e5a9cfc2d52fd7c89c267::pool::Pool<T0, T1>, arg8: &mut 0x2::tx_context::TxContext) : u64 {
        let v0 = 4;
        if (arg1) {
            let v2 = before_execute<T0>(arg0, v0, arg2, arg4, arg8);
            let v3 = 0x74bce93b827addba14d1c50a0bea79d6e77b6ee7d95edd9c2dd07fe86541e40b::bluefin_wrapper::swap_a2b<T0, T1>(arg5, arg6, arg7, v2, arg8);
            after_execute<T1>(arg0, v0, v3, arg3, arg4, arg8);
            0x2::coin::value<T1>(&v3)
        } else {
            let v4 = before_execute<T1>(arg0, v0, arg2, arg4, arg8);
            let v5 = 0x74bce93b827addba14d1c50a0bea79d6e77b6ee7d95edd9c2dd07fe86541e40b::bluefin_wrapper::swap_b2a<T0, T1>(arg5, arg6, arg7, v4, arg8);
            after_execute<T0>(arg0, v0, v5, arg3, arg4, arg8);
            0x2::coin::value<T0>(&v5)
        }
    }

    public entry fun execute_cetus_swap<T0, T1>(arg0: &mut Aggregator, arg1: bool, arg2: u64, arg3: u64, arg4: 0x2::object::ID, arg5: &0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::config::GlobalConfig, arg6: &mut 0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool::Pool<T0, T1>, arg7: &mut 0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::partner::Partner, arg8: &0x2::clock::Clock, arg9: &mut 0x2::tx_context::TxContext) : u64 {
        let v0 = 1;
        if (arg1) {
            let v2 = before_execute<T0>(arg0, v0, arg2, arg4, arg9);
            let v3 = 0x74bce93b827addba14d1c50a0bea79d6e77b6ee7d95edd9c2dd07fe86541e40b::cetus_wrapper::swap_a2b<T0, T1>(arg5, arg6, arg7, v2, arg8, arg9);
            after_execute<T1>(arg0, v0, v3, arg3, arg4, arg9);
            0x2::coin::value<T1>(&v3)
        } else {
            let v4 = before_execute<T1>(arg0, v0, arg2, arg4, arg9);
            let v5 = 0x74bce93b827addba14d1c50a0bea79d6e77b6ee7d95edd9c2dd07fe86541e40b::cetus_wrapper::swap_b2a<T0, T1>(arg5, arg6, arg7, v4, arg8, arg9);
            after_execute<T0>(arg0, v0, v5, arg3, arg4, arg9);
            0x2::coin::value<T0>(&v5)
        }
    }

    public entry fun execute_flowx_swap<T0, T1>(arg0: &mut Aggregator, arg1: bool, arg2: u64, arg3: u64, arg4: 0x2::object::ID, arg5: &mut 0xba153169476e8c3114962261d1edc70de5ad9781b83cc617ecc8c1923191cae0::factory::Container, arg6: &mut 0x2::tx_context::TxContext) : u64 {
        let v0 = 3;
        if (arg1) {
            let v2 = before_execute<T0>(arg0, v0, arg2, arg4, arg6);
            let v3 = 0x74bce93b827addba14d1c50a0bea79d6e77b6ee7d95edd9c2dd07fe86541e40b::flowx_wrapper::swap_a2b<T0, T1>(arg5, v2, arg6);
            after_execute<T1>(arg0, v0, v3, arg3, arg4, arg6);
            0x2::coin::value<T1>(&v3)
        } else {
            let v4 = before_execute<T1>(arg0, v0, arg2, arg4, arg6);
            let v5 = 0x74bce93b827addba14d1c50a0bea79d6e77b6ee7d95edd9c2dd07fe86541e40b::flowx_wrapper::swap_b2a<T0, T1>(arg5, v4, arg6);
            after_execute<T0>(arg0, v0, v5, arg3, arg4, arg6);
            0x2::coin::value<T0>(&v5)
        }
    }

    public entry fun execute_turbos_swap<T0, T1, T2>(arg0: &mut Aggregator, arg1: bool, arg2: u64, arg3: u64, arg4: 0x2::object::ID, arg5: &mut 0x91bfbc386a41afcfd9b2533058d7e915a1d3829089cc268ff4333d54d6339ca1::pool::Pool<T0, T1, T2>, arg6: &0x2::clock::Clock, arg7: &0x91bfbc386a41afcfd9b2533058d7e915a1d3829089cc268ff4333d54d6339ca1::pool::Versioned, arg8: &mut 0x2::tx_context::TxContext) : u64 {
        let v0 = 2;
        if (arg1) {
            let v2 = before_execute<T0>(arg0, v0, arg2, arg4, arg8);
            let v3 = 0x74bce93b827addba14d1c50a0bea79d6e77b6ee7d95edd9c2dd07fe86541e40b::turbos_wrapper::swap_a2b<T0, T1, T2>(arg5, v2, arg6, arg7, arg8);
            after_execute<T1>(arg0, v0, v3, arg3, arg4, arg8);
            0x2::coin::value<T1>(&v3)
        } else {
            let v4 = before_execute<T1>(arg0, v0, arg2, arg4, arg8);
            let v5 = 0x74bce93b827addba14d1c50a0bea79d6e77b6ee7d95edd9c2dd07fe86541e40b::turbos_wrapper::swap_b2a<T0, T1, T2>(arg5, v4, arg6, arg7, arg8);
            after_execute<T0>(arg0, v0, v5, arg3, arg4, arg8);
            0x2::coin::value<T0>(&v5)
        }
    }

    fun exists_trade_receipt(arg0: &Aggregator, arg1: 0x2::object::ID) : bool {
        0x2::table::contains<0x2::object::ID, TradeReceipt>(&arg0.receipts, arg1)
    }

    fun extract_intermediate_coin<T0>(arg0: &mut Aggregator, arg1: u64, arg2: &mut 0x2::tx_context::TxContext) : 0x2::coin::Coin<T0> {
        let v0 = CoinKey<T0>{dummy_field: false};
        assert!(0x2::dynamic_field::exists_<CoinKey<T0>>(&arg0.id, v0), 8);
        let v1 = 0x2::dynamic_field::borrow_mut<CoinKey<T0>, 0x2::coin::Coin<T0>>(&mut arg0.id, v0);
        assert!(0x2::coin::value<T0>(v1) >= arg1, 8);
        0x2::coin::split<T0>(v1, arg1, arg2)
    }

    public fun get_intermediate_balance<T0>(arg0: &Aggregator) : u64 {
        let v0 = CoinKey<T0>{dummy_field: false};
        if (0x2::dynamic_field::exists_<CoinKey<T0>>(&arg0.id, v0)) {
            0x2::coin::value<T0>(0x2::dynamic_field::borrow<CoinKey<T0>, 0x2::coin::Coin<T0>>(&arg0.id, v0))
        } else {
            0
        }
    }

    fun get_trade_receipt(arg0: &Aggregator, arg1: 0x2::object::ID) : TradeReceipt {
        assert!(exists_trade_receipt(arg0, arg1), 6);
        *0x2::table::borrow<0x2::object::ID, TradeReceipt>(&arg0.receipts, arg1)
    }

    fun init(arg0: AGGREGATOR, arg1: &mut 0x2::tx_context::TxContext) {
        let v0 = create_aggregator(arg1);
        0x2::transfer::public_transfer<SuperAdminCap>(v0, 0x2::tx_context::sender(arg1));
    }

    public entry fun revoke_admin_batch(arg0: &mut Aggregator, arg1: &SuperAdminCap, arg2: vector<address>, arg3: &mut 0x2::tx_context::TxContext) {
        let v0 = 0;
        while (v0 < 0x1::vector::length<address>(&arg2)) {
            let v1 = *0x1::vector::borrow<address>(&arg2, v0);
            if (0x2::table::contains<address, bool>(&arg0.admin_caps, v1) && *0x2::table::borrow<address, bool>(&arg0.admin_caps, v1)) {
                0x2::table::remove<address, bool>(&mut arg0.admin_caps, v1);
                0x2::table::add<address, bool>(&mut arg0.admin_caps, v1, false);
                let v2 = AdminCapRevoked{
                    admin     : v1,
                    timestamp : 0x2::tx_context::epoch_timestamp_ms(arg3),
                };
                0x2::event::emit<AdminCapRevoked>(v2);
            };
            v0 = v0 + 1;
        };
    }

    fun store_intermediate_coin<T0>(arg0: &mut Aggregator, arg1: 0x2::coin::Coin<T0>) {
        let v0 = CoinKey<T0>{dummy_field: false};
        if (0x2::dynamic_field::exists_<CoinKey<T0>>(&arg0.id, v0)) {
            0x2::coin::join<T0>(0x2::dynamic_field::borrow_mut<CoinKey<T0>, 0x2::coin::Coin<T0>>(&mut arg0.id, v0), arg1);
        } else {
            0x2::dynamic_field::add<CoinKey<T0>, 0x2::coin::Coin<T0>>(&mut arg0.id, v0, arg1);
        };
    }

    fun update_trade_receipt(arg0: &mut Aggregator, arg1: TradeReceipt) {
        assert!(exists_trade_receipt(arg0, arg1.id), 6);
        0x2::table::remove<0x2::object::ID, TradeReceipt>(&mut arg0.receipts, arg1.id);
        0x2::table::add<0x2::object::ID, TradeReceipt>(&mut arg0.receipts, arg1.id, arg1);
    }

    fun verify_admin_cap(arg0: &Aggregator, arg1: &AdminCap, arg2: &0x2::tx_context::TxContext) {
        let v0 = 0x2::tx_context::sender(arg2);
        assert!(arg1.admin_address == v0, 3);
        assert!(0x2::table::contains<address, bool>(&arg0.admin_caps, v0) && *0x2::table::borrow<address, bool>(&arg0.admin_caps, v0), 1);
    }

    public entry fun withdraw<T0>(arg0: &mut Aggregator, arg1: 0x2::object::ID, arg2: &mut 0x2::tx_context::TxContext) {
        assert!(exists_trade_receipt(arg0, arg1), 6);
        let v0 = get_trade_receipt(arg0, arg1);
        assert!(v0.to == 0x1::type_name::get<T0>(), 7);
        let v1 = extract_intermediate_coin<T0>(arg0, v0.to_amount, arg2);
        let v2 = Traded{
            trade_id    : arg1,
            from        : v0.from,
            from_amount : v0.from_amount,
            steps       : v0.steps,
            to          : v0.to,
            to_amount   : v0.to_amount,
            timestamp   : 0x2::tx_context::epoch_timestamp_ms(arg2),
        };
        0x2::event::emit<Traded>(v2);
        let v3 = Withdrawn{
            trade_id  : arg1,
            coin      : 0x1::type_name::get<T0>(),
            amount    : v0.to_amount,
            receivor  : v0.receivor,
            timestamp : 0x2::tx_context::epoch_timestamp_ms(arg2),
        };
        0x2::event::emit<Withdrawn>(v3);
        delete_trade_receipt(arg0, arg1);
        0x2::transfer::public_transfer<0x2::coin::Coin<T0>>(v1, v0.receivor);
    }

    // decompiled from Move bytecode v6
}

