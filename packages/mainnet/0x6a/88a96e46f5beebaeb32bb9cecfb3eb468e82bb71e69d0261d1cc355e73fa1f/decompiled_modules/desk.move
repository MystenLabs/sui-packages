module 0x6a88a96e46f5beebaeb32bb9cecfb3eb468e82bb71e69d0261d1cc355e73fa1f::desk {
    struct AdminCap has key {
        id: 0x2::object::UID,
    }

    struct AgentTicket has key {
        id: 0x2::object::UID,
        policy_id: 0x2::object::ID,
    }

    struct FeedPin has copy, drop, store {
        base: 0x1::type_name::TypeName,
        quote: 0x1::type_name::TypeName,
        pio_id: 0x2::object::ID,
        feed_id: vector<u8>,
        base_decimals: u8,
        quote_decimals: u8,
    }

    struct OrderKey has copy, drop, store {
        pool_id: 0x2::object::ID,
        order_id: u128,
    }

    struct Spend has copy, drop, store {
        t_ms: u64,
        amount: u64,
    }

    struct DeskPolicy has key {
        id: 0x2::object::UID,
        admin: address,
        balance_manager_id: 0x2::object::ID,
        halt_id: 0x2::object::ID,
        lease_id: 0x2::object::ID,
        cap: 0x1::option::Option<0x2c8d603bc51326b8c13cef9dd07031a408a48dddb541963357661df5d3204809::balance_manager::TradeCap>,
        ticket_id: 0x1::option::Option<0x2::object::ID>,
        ticket_holder: address,
        expires_ms: u64,
        runner_cap_id: 0x1::option::Option<0x2::object::ID>,
        cap_mult_bps: u64,
        spends: vector<Spend>,
        usd_quote: 0x1::type_name::TypeName,
        band_x_bps: u64,
        diverge_y_bps: u64,
        max_age_s: u64,
        max_conf_bps: u64,
        pins: 0x2::vec_map::VecMap<0x2::object::ID, FeedPin>,
        denied: 0x2::vec_set::VecSet<0x1::type_name::TypeName>,
        sui_ltv_cap_bps: u64,
        sui_min_health_bps: u64,
        orders: 0x2::table::Table<OrderKey, 0x2::object::ID>,
    }

    struct OrderChecked has copy, drop {
        pool_id: 0x2::object::ID,
        price: u64,
        quantity: u64,
        is_bid: bool,
        notional: u64,
        ref_price: u64,
        token: u64,
    }

    fun assert_admin(arg0: &DeskPolicy, arg1: &0x2::tx_context::TxContext) {
        assert!(0x2::tx_context::sender(arg1) == arg0.admin, 1);
    }

    public(friend) fun assert_limit(arg0: u8) {
        assert!(arg0 == 0 || arg0 == 3, 8);
    }

    public(friend) fun assert_mainnet_halt(arg0: 0x2::object::ID) {
        assert!(0x2::object::id_to_address(&arg0) == @0x4c778a601e9620bc85b7b1389f7321dafc2838ed0f4780670ae9b5f87e887770, 4);
    }

    public(friend) fun assert_mainnet_lease(arg0: 0x2::object::ID) {
        check_lease_pin(@0x4ae35c009516dc3eb2c0601cbe0e6fa04fdf2b3b1cdd994764c1aab8226a6807, arg0);
    }

    public(friend) fun assert_publisher(arg0: address) {
        assert!(arg0 == @0x4b178f7855b2e84ae9c1585093009bb6c212cd3b5ccf9c76672dda04be087e0, 27);
    }

    public fun band(arg0: &DeskPolicy) : (u64, u64, u64, u64) {
        (arg0.band_x_bps, arg0.diverge_y_bps, arg0.max_age_s, arg0.max_conf_bps)
    }

    public(friend) fun band_check(arg0: &DeskPolicy, arg1: &FeedPin, arg2: 0x2::object::ID, arg3: vector<u8>, arg4: 0x55300367a2d40813727ccac4ecee977a39fb9cdb46f2e6b2c354b9798f5de2c0::i64::I64, arg5: u64, arg6: 0x55300367a2d40813727ccac4ecee977a39fb9cdb46f2e6b2c354b9798f5de2c0::i64::I64, arg7: u64, arg8: 0x1::option::Option<u64>, arg9: 0x1::option::Option<u64>, arg10: u64, arg11: bool, arg12: u64) : u64 {
        assert!(arg2 == arg1.pio_id && arg3 == arg1.feed_id, 9);
        let v0 = (arg7 as u128) * 1000;
        assert!(v0 <= (arg12 as u128) && (arg12 as u128) - v0 <= (arg0.max_age_s as u128) * 1000, 10);
        assert!(!0x55300367a2d40813727ccac4ecee977a39fb9cdb46f2e6b2c354b9798f5de2c0::i64::get_is_negative(&arg4), 18);
        let v1 = 0x55300367a2d40813727ccac4ecee977a39fb9cdb46f2e6b2c354b9798f5de2c0::i64::get_magnitude_if_positive(&arg4);
        assert!(v1 > 0 && arg10 > 0, 18);
        assert!((arg5 as u128) * (10000 as u128) <= (v1 as u128) * (arg0.max_conf_bps as u128), 10);
        let v2 = to_book_units(v1, &arg6, arg1.base_decimals, arg1.quote_decimals);
        assert!(v2 > 0 && v2 <= 18446744073709551615, 18);
        assert!(0x1::option::is_some<u64>(&arg8) && 0x1::option::is_some<u64>(&arg9), 24);
        let v3 = (*0x1::option::borrow<u64>(&arg8) as u128);
        let v4 = if (v3 > v2) {
            v3 - v2
        } else {
            v2 - v3
        };
        assert!(v4 * (10000 as u128) <= v2 * (arg0.diverge_y_bps as u128), 11);
        if (0x1::option::is_some<u64>(&arg9)) {
            if (arg11) {
                assert!(arg10 < *0x1::option::borrow<u64>(&arg9), 21);
            } else {
                assert!(arg10 > *0x1::option::borrow<u64>(&arg9), 21);
            };
        };
        if (arg11) {
            assert!((arg10 as u128) * (10000 as u128) <= v2 * ((10000 + arg0.band_x_bps) as u128), 12);
        } else {
            assert!((arg10 as u128) * (10000 as u128) >= v2 * ((10000 - arg0.band_x_bps) as u128), 12);
        };
        let v5 = (*0x1::option::borrow<u64>(&arg8) as u128);
        let v6 = (arg10 as u128);
        let v7 = if (v6 > v5) {
            v6 - v5
        } else {
            v5 - v6
        };
        assert!(v7 * (10000 as u128) <= v5 * (300 as u128), 23);
        (v2 as u64)
    }

    public(friend) fun bm_basis(arg0: u64, arg1: u64, arg2: u64) : u64 {
        let v0 = (arg1 as u128) + (arg0 as u128) * (arg2 as u128) / 1000000000;
        if (v0 > 18446744073709551615) {
            18446744073709551615
        } else {
            (v0 as u64)
        }
    }

    entry fun cancel<T0, T1>(arg0: &mut DeskPolicy, arg1: &AgentTicket, arg2: &0xb96353c6eb846d4cf1a42f7fd05815993ed8ae68926cf41637a8a41b96597577::lease::RunnerLease, arg3: u64, arg4: &mut 0x2c8d603bc51326b8c13cef9dd07031a408a48dddb541963357661df5d3204809::pool::Pool<T0, T1>, arg5: &mut 0x2c8d603bc51326b8c13cef9dd07031a408a48dddb541963357661df5d3204809::balance_manager::BalanceManager, arg6: u128, arg7: &0x2::clock::Clock, arg8: &0x2::tx_context::TxContext) {
        cancel_check(arg0, arg1, arg2, arg3, 0x2::object::id<0x2c8d603bc51326b8c13cef9dd07031a408a48dddb541963357661df5d3204809::pool::Pool<T0, T1>>(arg4), 0x1::type_name::with_defining_ids<T0>(), 0x1::type_name::with_defining_ids<T1>(), arg6, arg7);
        assert!(0x2::object::id<0x2c8d603bc51326b8c13cef9dd07031a408a48dddb541963357661df5d3204809::balance_manager::BalanceManager>(arg5) == arg0.balance_manager_id, 16);
        let v0 = 0x2c8d603bc51326b8c13cef9dd07031a408a48dddb541963357661df5d3204809::balance_manager::generate_proof_as_trader(arg5, 0x1::option::borrow<0x2c8d603bc51326b8c13cef9dd07031a408a48dddb541963357661df5d3204809::balance_manager::TradeCap>(&arg0.cap), arg8);
        0x2c8d603bc51326b8c13cef9dd07031a408a48dddb541963357661df5d3204809::pool::cancel_order<T0, T1>(arg4, arg5, &v0, arg6, arg7, arg8);
    }

    public(friend) fun cancel_check(arg0: &mut DeskPolicy, arg1: &AgentTicket, arg2: &0xb96353c6eb846d4cf1a42f7fd05815993ed8ae68926cf41637a8a41b96597577::lease::RunnerLease, arg3: u64, arg4: 0x2::object::ID, arg5: 0x1::type_name::TypeName, arg6: 0x1::type_name::TypeName, arg7: u128, arg8: &0x2::clock::Clock) {
        check_ticket(arg0, arg1, arg8);
        post_halt(arg0, arg2, arg3, arg4, arg5, arg6, arg8);
        let v0 = OrderKey{
            pool_id  : arg4,
            order_id : arg7,
        };
        assert!(0x2::table::contains<OrderKey, 0x2::object::ID>(&arg0.orders, v0), 19);
        0x2::table::remove<OrderKey, 0x2::object::ID>(&mut arg0.orders, v0);
    }

    public fun cap_mult_bps(arg0: &DeskPolicy) : u64 {
        arg0.cap_mult_bps
    }

    public(friend) fun charge(arg0: &mut DeskPolicy, arg1: u64, arg2: u64, arg3: u64, arg4: u64) : u64 {
        while (!0x1::vector::is_empty<Spend>(&arg0.spends) && 0x1::vector::borrow<Spend>(&arg0.spends, 0).t_ms + 86400000 <= arg4) {
            0x1::vector::remove<Spend>(&mut arg0.spends, 0);
        };
        let v0 = (arg2 as u128) * (arg3 as u128) / 1000000000;
        let v1 = if (v0 > 0) {
            if ((spent_24h(arg0) as u128) + v0 <= (arg1 as u128) * (arg0.cap_mult_bps as u128) / (10000 as u128)) {
                0x1::vector::length<Spend>(&arg0.spends) < 512
            } else {
                false
            }
        } else {
            false
        };
        assert!(v1, 13);
        let v2 = Spend{
            t_ms   : arg4,
            amount : (v0 as u64),
        };
        0x1::vector::push_back<Spend>(&mut arg0.spends, v2);
        (v0 as u64)
    }

    public(friend) fun check_lease_pin(arg0: address, arg1: 0x2::object::ID) {
        assert!(arg0 != @0x0, 26);
        assert!(0x2::object::id_to_address(&arg1) == arg0, 5);
    }

    fun check_ticket(arg0: &DeskPolicy, arg1: &AgentTicket, arg2: &0x2::clock::Clock) {
        assert!(arg1.policy_id == 0x2::object::id<DeskPolicy>(arg0) && arg0.ticket_id == 0x1::option::some<0x2::object::ID>(0x2::object::id<AgentTicket>(arg1)), 2);
        assert!(0x2::clock::timestamp_ms(arg2) < arg0.expires_ms, 3);
    }

    public fun create_policy(arg0: &AdminCap, arg1: &0x2c8d603bc51326b8c13cef9dd07031a408a48dddb541963357661df5d3204809::balance_manager::BalanceManager, arg2: &0xe94269354ceb0d88dc01e0705865f7ec0b6593c46877c5200d7c452f1bbfa10c::halt::HaltFlag, arg3: &0xb96353c6eb846d4cf1a42f7fd05815993ed8ae68926cf41637a8a41b96597577::lease::RunnerLease, arg4: 0x1::type_name::TypeName, arg5: vector<0x1::type_name::TypeName>, arg6: 0x1::type_name::TypeName, arg7: &mut 0x2::tx_context::TxContext) {
        assert_mainnet_halt(0x2::object::id<0xe94269354ceb0d88dc01e0705865f7ec0b6593c46877c5200d7c452f1bbfa10c::halt::HaltFlag>(arg2));
        assert_mainnet_lease(0x2::object::id<0xb96353c6eb846d4cf1a42f7fd05815993ed8ae68926cf41637a8a41b96597577::lease::RunnerLease>(arg3));
        assert_publisher(0x2::tx_context::sender(arg7));
        assert!(0x2c8d603bc51326b8c13cef9dd07031a408a48dddb541963357661df5d3204809::balance_manager::owner(arg1) == 0x2::tx_context::sender(arg7), 16);
        assert!(*0x1::ascii::as_bytes(0x1::type_name::as_string(&arg6)) == b"dba34672e30cb065b1f93e3ab55318768fd6fef66c15942c9f7cb846e2f900e7::usdc::USDC", 22);
        0x2::transfer::share_object<DeskPolicy>(new_policy(@0x4b178f7855b2e84ae9c1585093009bb6c212cd3b5ccf9c76672dda04be087e0, 0x2::object::id<0x2c8d603bc51326b8c13cef9dd07031a408a48dddb541963357661df5d3204809::balance_manager::BalanceManager>(arg1), 0x2::object::id<0xe94269354ceb0d88dc01e0705865f7ec0b6593c46877c5200d7c452f1bbfa10c::halt::HaltFlag>(arg2), 0x2::object::id<0xb96353c6eb846d4cf1a42f7fd05815993ed8ae68926cf41637a8a41b96597577::lease::RunnerLease>(arg3), arg4, arg5, arg6, arg7));
    }

    public fun deny_coin(arg0: &AdminCap, arg1: &mut DeskPolicy, arg2: 0x1::type_name::TypeName, arg3: &0x2::tx_context::TxContext) {
        assert_admin(arg1, arg3);
        if (!0x2::vec_set::contains<0x1::type_name::TypeName>(&arg1.denied, &arg2)) {
            0x2::vec_set::insert<0x1::type_name::TypeName>(&mut arg1.denied, arg2);
        };
    }

    public fun deposit_cap(arg0: &AdminCap, arg1: &mut DeskPolicy, arg2: 0x2c8d603bc51326b8c13cef9dd07031a408a48dddb541963357661df5d3204809::balance_manager::TradeCap, arg3: &0x2::tx_context::TxContext) {
        assert_admin(arg1, arg3);
        assert!(0x1::option::is_none<0x2c8d603bc51326b8c13cef9dd07031a408a48dddb541963357661df5d3204809::balance_manager::TradeCap>(&arg1.cap), 15);
        0x1::option::fill<0x2c8d603bc51326b8c13cef9dd07031a408a48dddb541963357661df5d3204809::balance_manager::TradeCap>(&mut arg1.cap, arg2);
    }

    public fun expires_ms(arg0: &DeskPolicy) : u64 {
        arg0.expires_ms
    }

    public fun has_cap(arg0: &DeskPolicy) : bool {
        0x1::option::is_some<0x2c8d603bc51326b8c13cef9dd07031a408a48dddb541963357661df5d3204809::balance_manager::TradeCap>(&arg0.cap)
    }

    public fun has_order(arg0: &DeskPolicy, arg1: 0x2::object::ID, arg2: u128) : bool {
        let v0 = OrderKey{
            pool_id  : arg1,
            order_id : arg2,
        };
        0x2::table::contains<OrderKey, 0x2::object::ID>(&arg0.orders, v0)
    }

    fun init(arg0: &mut 0x2::tx_context::TxContext) {
        assert_publisher(0x2::tx_context::sender(arg0));
        let v0 = AdminCap{id: 0x2::object::new(arg0)};
        0x2::transfer::transfer<AdminCap>(v0, @0x4b178f7855b2e84ae9c1585093009bb6c212cd3b5ccf9c76672dda04be087e0);
    }

    public fun is_denied(arg0: &DeskPolicy, arg1: 0x1::type_name::TypeName) : bool {
        0x2::vec_set::contains<0x1::type_name::TypeName>(&arg0.denied, &arg1)
    }

    public fun issue_ticket(arg0: &AdminCap, arg1: &mut DeskPolicy, arg2: &0xb96353c6eb846d4cf1a42f7fd05815993ed8ae68926cf41637a8a41b96597577::lease::RunnerLease, arg3: address, arg4: 0x2::object::ID, arg5: &0x2::clock::Clock, arg6: &mut 0x2::tx_context::TxContext) {
        assert_admin(arg1, arg6);
        assert!(0x2::object::id<0xb96353c6eb846d4cf1a42f7fd05815993ed8ae68926cf41637a8a41b96597577::lease::RunnerLease>(arg2) == arg1.lease_id && 0xb96353c6eb846d4cf1a42f7fd05815993ed8ae68926cf41637a8a41b96597577::lease::is_runner_cap(arg2, arg4), 20);
        arg1.runner_cap_id = 0x1::option::some<0x2::object::ID>(arg4);
        let v0 = AgentTicket{
            id        : 0x2::object::new(arg6),
            policy_id : 0x2::object::id<DeskPolicy>(arg1),
        };
        arg1.ticket_id = 0x1::option::some<0x2::object::ID>(0x2::object::id<AgentTicket>(&v0));
        arg1.ticket_holder = arg3;
        arg1.expires_ms = 0x2::clock::timestamp_ms(arg5) + 2592000000;
        0x2::transfer::transfer<AgentTicket>(v0, arg3);
    }

    public fun leverage_caps(arg0: &DeskPolicy) : (u64, u64) {
        (arg0.sui_ltv_cap_bps, arg0.sui_min_health_bps)
    }

    public(friend) fun new_policy(arg0: address, arg1: 0x2::object::ID, arg2: 0x2::object::ID, arg3: 0x2::object::ID, arg4: 0x1::type_name::TypeName, arg5: vector<0x1::type_name::TypeName>, arg6: 0x1::type_name::TypeName, arg7: &mut 0x2::tx_context::TxContext) : DeskPolicy {
        assert!(!0x1::vector::is_empty<0x1::type_name::TypeName>(&arg5), 17);
        assert!(arg4 != arg6 && !0x1::vector::contains<0x1::type_name::TypeName>(&arg5, &arg6), 17);
        let v0 = 0x2::vec_set::singleton<0x1::type_name::TypeName>(arg4);
        0x1::vector::reverse<0x1::type_name::TypeName>(&mut arg5);
        let v1 = 0;
        while (v1 < 0x1::vector::length<0x1::type_name::TypeName>(&arg5)) {
            let v2 = 0x1::vector::pop_back<0x1::type_name::TypeName>(&mut arg5);
            if (!0x2::vec_set::contains<0x1::type_name::TypeName>(&v0, &v2)) {
                0x2::vec_set::insert<0x1::type_name::TypeName>(&mut v0, v2);
            };
            v1 = v1 + 1;
        };
        0x1::vector::destroy_empty<0x1::type_name::TypeName>(arg5);
        DeskPolicy{
            id                 : 0x2::object::new(arg7),
            admin              : arg0,
            balance_manager_id : arg1,
            halt_id            : arg2,
            lease_id           : arg3,
            cap                : 0x1::option::none<0x2c8d603bc51326b8c13cef9dd07031a408a48dddb541963357661df5d3204809::balance_manager::TradeCap>(),
            ticket_id          : 0x1::option::none<0x2::object::ID>(),
            ticket_holder      : @0x0,
            expires_ms         : 0,
            runner_cap_id      : 0x1::option::none<0x2::object::ID>(),
            cap_mult_bps       : 20000,
            spends             : 0x1::vector::empty<Spend>(),
            usd_quote          : arg6,
            band_x_bps         : 200,
            diverge_y_bps      : 300,
            max_age_s          : 60,
            max_conf_bps       : 100,
            pins               : 0x2::vec_map::empty<0x2::object::ID, FeedPin>(),
            denied             : v0,
            sui_ltv_cap_bps    : 0,
            sui_min_health_bps : 0,
            orders             : 0x2::table::new<OrderKey, 0x2::object::ID>(arg7),
        }
    }

    entry fun place_limit<T0, T1>(arg0: &mut DeskPolicy, arg1: &AgentTicket, arg2: &0xe94269354ceb0d88dc01e0705865f7ec0b6593c46877c5200d7c452f1bbfa10c::halt::HaltFlag, arg3: &0xb96353c6eb846d4cf1a42f7fd05815993ed8ae68926cf41637a8a41b96597577::lease::RunnerLease, arg4: u64, arg5: &mut 0x2c8d603bc51326b8c13cef9dd07031a408a48dddb541963357661df5d3204809::pool::Pool<T0, T1>, arg6: &mut 0x2c8d603bc51326b8c13cef9dd07031a408a48dddb541963357661df5d3204809::balance_manager::BalanceManager, arg7: &0x55300367a2d40813727ccac4ecee977a39fb9cdb46f2e6b2c354b9798f5de2c0::price_info::PriceInfoObject, arg8: u64, arg9: u8, arg10: u64, arg11: u64, arg12: bool, arg13: bool, arg14: u64, arg15: &0x2::clock::Clock, arg16: &0x2::tx_context::TxContext) {
        let v0 = 0x2::object::id<0x2c8d603bc51326b8c13cef9dd07031a408a48dddb541963357661df5d3204809::pool::Pool<T0, T1>>(arg5);
        let v1 = pre_trade(arg0, arg1, arg2, arg3, arg4, v0, 0x1::type_name::with_defining_ids<T0>(), 0x1::type_name::with_defining_ids<T1>(), arg15);
        assert_limit(arg9);
        assert!(arg14 <= arg0.expires_ms, 3);
        let v2 = 0x55300367a2d40813727ccac4ecee977a39fb9cdb46f2e6b2c354b9798f5de2c0::price_info::get_price_info_from_price_info_object(arg7);
        let v3 = 0x55300367a2d40813727ccac4ecee977a39fb9cdb46f2e6b2c354b9798f5de2c0::price_info::get_price_identifier(&v2);
        let v4 = 0x55300367a2d40813727ccac4ecee977a39fb9cdb46f2e6b2c354b9798f5de2c0::price_feed::get_price(0x55300367a2d40813727ccac4ecee977a39fb9cdb46f2e6b2c354b9798f5de2c0::price_info::get_price_feed(&v2));
        let v5 = 0x2c8d603bc51326b8c13cef9dd07031a408a48dddb541963357661df5d3204809::pool::best_bid_price<T0, T1>(arg5, arg15);
        let v6 = 0x2c8d603bc51326b8c13cef9dd07031a408a48dddb541963357661df5d3204809::pool::best_ask_price<T0, T1>(arg5, arg15);
        assert!(0x1::option::is_some<u64>(&v5) && 0x1::option::is_some<u64>(&v6), 24);
        let v7 = if (arg12) {
            v6
        } else {
            v5
        };
        let v8 = band_check(arg0, &v1, 0x2::object::id<0x55300367a2d40813727ccac4ecee977a39fb9cdb46f2e6b2c354b9798f5de2c0::price_info::PriceInfoObject>(arg7), 0x55300367a2d40813727ccac4ecee977a39fb9cdb46f2e6b2c354b9798f5de2c0::price_identifier::get_bytes(&v3), 0x55300367a2d40813727ccac4ecee977a39fb9cdb46f2e6b2c354b9798f5de2c0::price::get_price(&v4), 0x55300367a2d40813727ccac4ecee977a39fb9cdb46f2e6b2c354b9798f5de2c0::price::get_conf(&v4), 0x55300367a2d40813727ccac4ecee977a39fb9cdb46f2e6b2c354b9798f5de2c0::price::get_expo(&v4), 0x55300367a2d40813727ccac4ecee977a39fb9cdb46f2e6b2c354b9798f5de2c0::price::get_timestamp(&v4), 0x1::option::some<u64>(((((*0x1::option::borrow<u64>(&v5) as u128) + (*0x1::option::borrow<u64>(&v6) as u128)) / 2) as u64)), v7, arg10, arg12, 0x2::clock::timestamp_ms(arg15));
        assert!(0x2::object::id<0x2c8d603bc51326b8c13cef9dd07031a408a48dddb541963357661df5d3204809::balance_manager::BalanceManager>(arg6) == arg0.balance_manager_id, 16);
        let v9 = charge(arg0, bm_basis(0x2c8d603bc51326b8c13cef9dd07031a408a48dddb541963357661df5d3204809::balance_manager::balance<T0>(arg6), 0x2c8d603bc51326b8c13cef9dd07031a408a48dddb541963357661df5d3204809::balance_manager::balance<T1>(arg6), v8), arg10, arg11, 0x2::clock::timestamp_ms(arg15));
        let v10 = 0x2c8d603bc51326b8c13cef9dd07031a408a48dddb541963357661df5d3204809::balance_manager::generate_proof_as_trader(arg6, 0x1::option::borrow<0x2c8d603bc51326b8c13cef9dd07031a408a48dddb541963357661df5d3204809::balance_manager::TradeCap>(&arg0.cap), arg16);
        let v11 = 0x2c8d603bc51326b8c13cef9dd07031a408a48dddb541963357661df5d3204809::pool::place_limit_order<T0, T1>(arg5, arg6, &v10, arg8, arg9, 1, arg10, arg11, arg12, arg13, arg14, arg15, arg16);
        record_order(arg0, v0, 0x2c8d603bc51326b8c13cef9dd07031a408a48dddb541963357661df5d3204809::order_info::order_id(&v11), 0x2::object::id<AgentTicket>(arg1));
        let v12 = OrderChecked{
            pool_id   : v0,
            price     : arg10,
            quantity  : arg11,
            is_bid    : arg12,
            notional  : v9,
            ref_price : v8,
            token     : arg4,
        };
        0x2::event::emit<OrderChecked>(v12);
    }

    fun post_halt(arg0: &DeskPolicy, arg1: &0xb96353c6eb846d4cf1a42f7fd05815993ed8ae68926cf41637a8a41b96597577::lease::RunnerLease, arg2: u64, arg3: 0x2::object::ID, arg4: 0x1::type_name::TypeName, arg5: 0x1::type_name::TypeName, arg6: &0x2::clock::Clock) : FeedPin {
        assert!(0x2::object::id<0xb96353c6eb846d4cf1a42f7fd05815993ed8ae68926cf41637a8a41b96597577::lease::RunnerLease>(arg1) == arg0.lease_id, 5);
        0xb96353c6eb846d4cf1a42f7fd05815993ed8ae68926cf41637a8a41b96597577::lease::assert_valid(arg1, arg2, arg6);
        assert!(0x1::option::is_some<0x2::object::ID>(&arg0.runner_cap_id) && 0xb96353c6eb846d4cf1a42f7fd05815993ed8ae68926cf41637a8a41b96597577::lease::holder_cap(arg1) == arg0.runner_cap_id, 20);
        assert!(!0x2::vec_set::contains<0x1::type_name::TypeName>(&arg0.denied, &arg4) && !0x2::vec_set::contains<0x1::type_name::TypeName>(&arg0.denied, &arg5), 7);
        assert!(0x2::vec_map::contains<0x2::object::ID, FeedPin>(&arg0.pins, &arg3), 6);
        let v0 = *0x2::vec_map::get<0x2::object::ID, FeedPin>(&arg0.pins, &arg3);
        assert!(v0.base == arg4 && v0.quote == arg5, 6);
        assert!(0x1::option::is_some<0x2c8d603bc51326b8c13cef9dd07031a408a48dddb541963357661df5d3204809::balance_manager::TradeCap>(&arg0.cap), 14);
        v0
    }

    fun pow10(arg0: u64) : u128 {
        let v0 = 1;
        let v1 = 0;
        while (v1 < arg0) {
            v0 = v0 * 10;
            v1 = v1 + 1;
        };
        v0
    }

    public(friend) fun pre_trade(arg0: &DeskPolicy, arg1: &AgentTicket, arg2: &0xe94269354ceb0d88dc01e0705865f7ec0b6593c46877c5200d7c452f1bbfa10c::halt::HaltFlag, arg3: &0xb96353c6eb846d4cf1a42f7fd05815993ed8ae68926cf41637a8a41b96597577::lease::RunnerLease, arg4: u64, arg5: 0x2::object::ID, arg6: 0x1::type_name::TypeName, arg7: 0x1::type_name::TypeName, arg8: &0x2::clock::Clock) : FeedPin {
        check_ticket(arg0, arg1, arg8);
        assert!(0x2::object::id<0xe94269354ceb0d88dc01e0705865f7ec0b6593c46877c5200d7c452f1bbfa10c::halt::HaltFlag>(arg2) == arg0.halt_id, 4);
        0xe94269354ceb0d88dc01e0705865f7ec0b6593c46877c5200d7c452f1bbfa10c::halt::assert_live(arg2);
        post_halt(arg0, arg3, arg4, arg5, arg6, arg7, arg8)
    }

    public(friend) fun prune_closed(arg0: &mut DeskPolicy, arg1: 0x2::object::ID, arg2: &0x2::vec_set::VecSet<u128>, arg3: vector<u128>) : u64 {
        let v0 = 0;
        0x1::vector::reverse<u128>(&mut arg3);
        let v1 = 0;
        while (v1 < 0x1::vector::length<u128>(&arg3)) {
            let v2 = 0x1::vector::pop_back<u128>(&mut arg3);
            let v3 = OrderKey{
                pool_id  : arg1,
                order_id : v2,
            };
            if (!0x2::vec_set::contains<u128>(arg2, &v2) && 0x2::table::contains<OrderKey, 0x2::object::ID>(&arg0.orders, v3)) {
                0x2::table::remove<OrderKey, 0x2::object::ID>(&mut arg0.orders, v3);
                v0 = v0 + 1;
            };
            v1 = v1 + 1;
        };
        0x1::vector::destroy_empty<u128>(arg3);
        v0
    }

    entry fun prune_orders<T0, T1>(arg0: &mut DeskPolicy, arg1: &0x2c8d603bc51326b8c13cef9dd07031a408a48dddb541963357661df5d3204809::pool::Pool<T0, T1>, arg2: &0x2c8d603bc51326b8c13cef9dd07031a408a48dddb541963357661df5d3204809::balance_manager::BalanceManager, arg3: vector<u128>) {
        assert!(0x2::object::id<0x2c8d603bc51326b8c13cef9dd07031a408a48dddb541963357661df5d3204809::balance_manager::BalanceManager>(arg2) == arg0.balance_manager_id, 16);
        let v0 = 0x2c8d603bc51326b8c13cef9dd07031a408a48dddb541963357661df5d3204809::pool::account_open_orders<T0, T1>(arg1, arg2);
        prune_closed(arg0, 0x2::object::id<0x2c8d603bc51326b8c13cef9dd07031a408a48dddb541963357661df5d3204809::pool::Pool<T0, T1>>(arg1), &v0, arg3);
    }

    public fun reclaim_cap(arg0: &AdminCap, arg1: &mut DeskPolicy, arg2: &0x2::tx_context::TxContext) {
        assert_admin(arg1, arg2);
        assert!(0x1::option::is_some<0x2c8d603bc51326b8c13cef9dd07031a408a48dddb541963357661df5d3204809::balance_manager::TradeCap>(&arg1.cap), 14);
        0x2::transfer::public_transfer<0x2c8d603bc51326b8c13cef9dd07031a408a48dddb541963357661df5d3204809::balance_manager::TradeCap>(0x1::option::extract<0x2c8d603bc51326b8c13cef9dd07031a408a48dddb541963357661df5d3204809::balance_manager::TradeCap>(&mut arg1.cap), arg1.admin);
    }

    public(friend) fun record_order(arg0: &mut DeskPolicy, arg1: 0x2::object::ID, arg2: u128, arg3: 0x2::object::ID) {
        let v0 = OrderKey{
            pool_id  : arg1,
            order_id : arg2,
        };
        if (0x2::table::contains<OrderKey, 0x2::object::ID>(&arg0.orders, v0)) {
            *0x2::table::borrow_mut<OrderKey, 0x2::object::ID>(&mut arg0.orders, v0) = arg3;
        } else {
            0x2::table::add<OrderKey, 0x2::object::ID>(&mut arg0.orders, v0, arg3);
        };
    }

    public fun remove_pool(arg0: &AdminCap, arg1: &mut DeskPolicy, arg2: 0x2::object::ID, arg3: &0x2::tx_context::TxContext) {
        assert_admin(arg1, arg3);
        assert!(0x2::vec_map::contains<0x2::object::ID, FeedPin>(&arg1.pins, &arg2), 6);
        let (_, _) = 0x2::vec_map::remove<0x2::object::ID, FeedPin>(&mut arg1.pins, &arg2);
    }

    public fun renew_ticket(arg0: &AdminCap, arg1: &mut DeskPolicy, arg2: &0x2::clock::Clock, arg3: &0x2::tx_context::TxContext) {
        assert_admin(arg1, arg3);
        assert!(0x1::option::is_some<0x2::object::ID>(&arg1.ticket_id), 2);
        arg1.expires_ms = 0x2::clock::timestamp_ms(arg2) + 2592000000;
    }

    public fun revoke_ticket(arg0: &AdminCap, arg1: &mut DeskPolicy, arg2: &0x2::tx_context::TxContext) {
        assert_admin(arg1, arg2);
        arg1.ticket_id = 0x1::option::none<0x2::object::ID>();
        arg1.ticket_holder = @0x0;
        arg1.expires_ms = 0;
        arg1.runner_cap_id = 0x1::option::none<0x2::object::ID>();
    }

    public fun runner_cap_id(arg0: &DeskPolicy) : 0x1::option::Option<0x2::object::ID> {
        arg0.runner_cap_id
    }

    public fun set_band(arg0: &AdminCap, arg1: &mut DeskPolicy, arg2: u64, arg3: u64, arg4: u64, arg5: u64, arg6: &0x2::tx_context::TxContext) {
        assert_admin(arg1, arg6);
        let v0 = if (arg2 > 0) {
            if (arg2 < 10000) {
                if (arg3 > 0) {
                    if (arg3 < 10000) {
                        if (arg4 > 0) {
                            if (arg5 > 0) {
                                arg5 < 10000
                            } else {
                                false
                            }
                        } else {
                            false
                        }
                    } else {
                        false
                    }
                } else {
                    false
                }
            } else {
                false
            }
        } else {
            false
        };
        assert!(v0, 17);
        arg1.band_x_bps = arg2;
        arg1.diverge_y_bps = arg3;
        arg1.max_age_s = arg4;
        arg1.max_conf_bps = arg5;
    }

    public fun set_daily_cap(arg0: &AdminCap, arg1: &mut DeskPolicy, arg2: u64, arg3: &0x2::tx_context::TxContext) {
        assert_admin(arg1, arg3);
        assert!(arg2 <= 20000, 17);
        arg1.cap_mult_bps = arg2;
    }

    public fun set_feed<T0, T1>(arg0: &AdminCap, arg1: &mut DeskPolicy, arg2: &0x2c8d603bc51326b8c13cef9dd07031a408a48dddb541963357661df5d3204809::pool::Pool<T0, T1>, arg3: &0x55300367a2d40813727ccac4ecee977a39fb9cdb46f2e6b2c354b9798f5de2c0::price_info::PriceInfoObject, arg4: u8, arg5: u8, arg6: &0x2::tx_context::TxContext) {
        let v0 = 0x55300367a2d40813727ccac4ecee977a39fb9cdb46f2e6b2c354b9798f5de2c0::price_info::get_price_info_from_price_info_object(arg3);
        let v1 = 0x55300367a2d40813727ccac4ecee977a39fb9cdb46f2e6b2c354b9798f5de2c0::price_info::get_price_identifier(&v0);
        set_feed_raw(arg1, 0x2::object::id<0x2c8d603bc51326b8c13cef9dd07031a408a48dddb541963357661df5d3204809::pool::Pool<T0, T1>>(arg2), 0x1::type_name::with_defining_ids<T0>(), 0x1::type_name::with_defining_ids<T1>(), 0x2::object::id<0x55300367a2d40813727ccac4ecee977a39fb9cdb46f2e6b2c354b9798f5de2c0::price_info::PriceInfoObject>(arg3), 0x55300367a2d40813727ccac4ecee977a39fb9cdb46f2e6b2c354b9798f5de2c0::price_identifier::get_bytes(&v1), arg4, arg5, arg6);
    }

    public(friend) fun set_feed_raw(arg0: &mut DeskPolicy, arg1: 0x2::object::ID, arg2: 0x1::type_name::TypeName, arg3: 0x1::type_name::TypeName, arg4: 0x2::object::ID, arg5: vector<u8>, arg6: u8, arg7: u8, arg8: &0x2::tx_context::TxContext) {
        assert_admin(arg0, arg8);
        assert!(!0x2::vec_set::contains<0x1::type_name::TypeName>(&arg0.denied, &arg2) && !0x2::vec_set::contains<0x1::type_name::TypeName>(&arg0.denied, &arg3), 7);
        assert!(arg3 == arg0.usd_quote && arg2 != arg3, 22);
        assert!(arg7 == 6 && arg6 <= 18, 25);
        let v0 = FeedPin{
            base           : arg2,
            quote          : arg3,
            pio_id         : arg4,
            feed_id        : arg5,
            base_decimals  : arg6,
            quote_decimals : arg7,
        };
        if (0x2::vec_map::contains<0x2::object::ID, FeedPin>(&arg0.pins, &arg1)) {
            *0x2::vec_map::get_mut<0x2::object::ID, FeedPin>(&mut arg0.pins, &arg1) = v0;
        } else {
            0x2::vec_map::insert<0x2::object::ID, FeedPin>(&mut arg0.pins, arg1, v0);
        };
    }

    public fun set_leverage_caps(arg0: &AdminCap, arg1: &mut DeskPolicy, arg2: u64, arg3: u64, arg4: &0x2::tx_context::TxContext) {
        assert_admin(arg1, arg4);
        assert!(arg2 <= 3820 && (arg2 == 0 || arg3 >= 16180), 17);
        arg1.sui_ltv_cap_bps = arg2;
        arg1.sui_min_health_bps = arg3;
    }

    fun spent_24h(arg0: &DeskPolicy) : u64 {
        let v0 = 0;
        let v1 = &arg0.spends;
        let v2 = 0;
        while (v2 < 0x1::vector::length<Spend>(v1)) {
            v0 = v0 + 0x1::vector::borrow<Spend>(v1, v2).amount;
            v2 = v2 + 1;
        };
        v0
    }

    public fun spent_24h_recorded(arg0: &DeskPolicy) : u64 {
        spent_24h(arg0)
    }

    public fun ticket_holder(arg0: &DeskPolicy) : address {
        arg0.ticket_holder
    }

    public fun ticket_ttl_ms() : u64 {
        2592000000
    }

    public(friend) fun to_book_units(arg0: u64, arg1: &0x55300367a2d40813727ccac4ecee977a39fb9cdb46f2e6b2c354b9798f5de2c0::i64::I64, arg2: u8, arg3: u8) : u128 {
        let v0 = 0x55300367a2d40813727ccac4ecee977a39fb9cdb46f2e6b2c354b9798f5de2c0::i64::get_is_negative(arg1);
        let v1 = if (v0) {
            0x55300367a2d40813727ccac4ecee977a39fb9cdb46f2e6b2c354b9798f5de2c0::i64::get_magnitude_if_negative(arg1)
        } else {
            0x55300367a2d40813727ccac4ecee977a39fb9cdb46f2e6b2c354b9798f5de2c0::i64::get_magnitude_if_positive(arg1)
        };
        let v2 = if (v0) {
            0
        } else {
            v1
        };
        let v3 = 9 + (arg3 as u64) + v2;
        let v4 = if (v0) {
            v1
        } else {
            0
        };
        let v5 = (arg2 as u64) + v4;
        if (v3 >= v5) {
            (arg0 as u128) * pow10(v3 - v5)
        } else {
            (arg0 as u128) / pow10(v5 - v3)
        }
    }

    // decompiled from Move bytecode v7
}

