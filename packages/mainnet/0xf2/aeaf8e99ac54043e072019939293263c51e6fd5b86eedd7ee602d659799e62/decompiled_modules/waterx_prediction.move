module 0xa5cfafe6660a8bf37eedf1a09dba633048da374c30b835668473689668f9ef57::waterx_prediction {
    struct MarketRegistry<phantom T0> has key {
        id: 0x2::object::UID,
        balance: 0x2::balance::Balance<T0>,
        market_id_map: 0x2::table::Table<vector<u8>, MarketPointer>,
        unresolved_markets: 0x665188033384920a5bb5dcfb2ef21f54b4568d08b431718b97e02e5c184b92cc::linked_table::LinkedTable<u64, Market>,
        resolved_markets: 0x665188033384920a5bb5dcfb2ef21f54b4568d08b431718b97e02e5c184b92cc::linked_table::LinkedTable<u64, Market>,
        paused_markets: 0x2::table::Table<u64, bool>,
        orders: 0x665188033384920a5bb5dcfb2ef21f54b4568d08b431718b97e02e5c184b92cc::linked_table::LinkedTable<u64, 0xa5cfafe6660a8bf37eedf1a09dba633048da374c30b835668473689668f9ef57::order::Order>,
        positions: 0x665188033384920a5bb5dcfb2ef21f54b4568d08b431718b97e02e5c184b92cc::linked_table::LinkedTable<u64, 0xa5cfafe6660a8bf37eedf1a09dba633048da374c30b835668473689668f9ef57::position::Position>,
        position_id_by_order: 0x2::table::Table<u64, u64>,
        order_id_by_position: 0x2::table::Table<u64, u64>,
        next_order_id: u64,
        next_position_id: u64,
        next_market_key: u64,
        order_cancel_cooldown_ms: u64,
        min_reserve: u64,
    }

    struct Market has store {
        market_id: vector<u8>,
        outcome: 0x1::option::Option<0xa5cfafe6660a8bf37eedf1a09dba633048da374c30b835668473689668f9ef57::outcome::Outcome>,
        unclaimed_count: u64,
        yes_shares: u64,
        yes_cost: u64,
        no_shares: u64,
        no_cost: u64,
    }

    struct MarketPointer has copy, drop, store {
        key: u64,
        resolved: bool,
    }

    struct PriceSettlement has copy, drop, store {
        settle_ticker: 0x1::string::String,
        settle_timestamp_ms: u64,
        threshold: u128,
        comparison: u8,
    }

    struct PriceSettlementKey has copy, drop, store {
        market_id: vector<u8>,
    }

    public fun order_id<T0>(arg0: &MarketRegistry<T0>, arg1: u64) : u64 {
        0xa5cfafe6660a8bf37eedf1a09dba633048da374c30b835668473689668f9ef57::order::order_id(borrow_order<T0>(arg0, arg1))
    }

    public fun cancel_close<T0>(arg0: &0xa5cfafe6660a8bf37eedf1a09dba633048da374c30b835668473689668f9ef57::global_config::GlobalConfig, arg1: &0x665188033384920a5bb5dcfb2ef21f54b4568d08b431718b97e02e5c184b92cc::account::AccountRequest, arg2: &mut MarketRegistry<T0>, arg3: &mut 0xe308bd40bd81aa42b9245e4b51b3fe63801c77c78a76be4ce5902aae549f7221::account::AccountRegistry, arg4: u64, arg5: &0x2::clock::Clock) {
        assert_keeper(arg0, arg1);
        let v0 = borrow_position<T0>(arg2, arg4);
        assert!(0xa5cfafe6660a8bf37eedf1a09dba633048da374c30b835668473689668f9ef57::position::has_pending_close(v0), 1);
        let v1 = 0xa5cfafe6660a8bf37eedf1a09dba633048da374c30b835668473689668f9ef57::position::close_order_id(v0);
        let v2 = *0x1::option::borrow<u64>(&v1);
        let v3 = 0xa5cfafe6660a8bf37eedf1a09dba633048da374c30b835668473689668f9ef57::position::account_id(v0);
        let v4 = 0xa5cfafe6660a8bf37eedf1a09dba633048da374c30b835668473689668f9ef57::position::market_id(v0);
        let v5 = 0xa5cfafe6660a8bf37eedf1a09dba633048da374c30b835668473689668f9ef57::position::selection(v0);
        let v6 = market_key_internal<T0>(arg2, v4);
        assert!(0xa5cfafe6660a8bf37eedf1a09dba633048da374c30b835668473689668f9ef57::order::is_close(borrow_order<T0>(arg2, v2)), 1);
        let v7 = borrow_position_mut<T0>(arg2, arg4);
        0xa5cfafe6660a8bf37eedf1a09dba633048da374c30b835668473689668f9ef57::position::cancel_close(v7);
        0xa5cfafe6660a8bf37eedf1a09dba633048da374c30b835668473689668f9ef57::account_data::remove_order(arg3, v3, v6, v2);
        remove_and_drop_order<T0>(arg2, v2);
        0xa5cfafe6660a8bf37eedf1a09dba633048da374c30b835668473689668f9ef57::events::emit_close_cancelled(0x2::object::uid_to_address(&arg2.id), v2, v3, arg4, v6, v4, v5, false, 0x2::clock::timestamp_ms(arg5));
    }

    public fun request_close<T0>(arg0: &0xa5cfafe6660a8bf37eedf1a09dba633048da374c30b835668473689668f9ef57::global_config::GlobalConfig, arg1: &mut MarketRegistry<T0>, arg2: &mut 0xe308bd40bd81aa42b9245e4b51b3fe63801c77c78a76be4ce5902aae549f7221::account::AccountRegistry, arg3: &0x665188033384920a5bb5dcfb2ef21f54b4568d08b431718b97e02e5c184b92cc::account::AccountRequest, arg4: u64, arg5: u64, arg6: u64, arg7: &0x2::clock::Clock) {
        0xa5cfafe6660a8bf37eedf1a09dba633048da374c30b835668473689668f9ef57::global_config::assert_version(arg0);
        assert_account_position_perm<T0>(arg1, arg2, arg3, arg4, 0xa5cfafe6660a8bf37eedf1a09dba633048da374c30b835668473689668f9ef57::account_data::perm_request_close(), arg7);
        request_close_internal<T0>(arg1, arg2, arg4, arg5, arg6, arg7);
    }

    public fun status_is_open(arg0: 0xa5cfafe6660a8bf37eedf1a09dba633048da374c30b835668473689668f9ef57::position::Status) : bool {
        0xa5cfafe6660a8bf37eedf1a09dba633048da374c30b835668473689668f9ef57::position::status_is_open(arg0)
    }

    public fun status_is_pending_close(arg0: 0xa5cfafe6660a8bf37eedf1a09dba633048da374c30b835668473689668f9ef57::position::Status) : bool {
        0xa5cfafe6660a8bf37eedf1a09dba633048da374c30b835668473689668f9ef57::position::status_is_pending_close(arg0)
    }

    public fun admin_place_order_for<T0>(arg0: &0xa5cfafe6660a8bf37eedf1a09dba633048da374c30b835668473689668f9ef57::admin::AdminCap, arg1: &mut MarketRegistry<T0>, arg2: &mut 0xe308bd40bd81aa42b9245e4b51b3fe63801c77c78a76be4ce5902aae549f7221::account::AccountRegistry, arg3: 0x2::coin::Coin<T0>, arg4: 0x2::object::ID, arg5: vector<u8>, arg6: 0xa5cfafe6660a8bf37eedf1a09dba633048da374c30b835668473689668f9ef57::position::Selection, arg7: u64, arg8: u64, arg9: u64, arg10: &0x2::clock::Clock, arg11: &mut 0x2::tx_context::TxContext) {
        assert!(0xe308bd40bd81aa42b9245e4b51b3fe63801c77c78a76be4ce5902aae549f7221::account::has_account(arg2, arg4), 16);
        let v0 = place_order_internal<T0>(arg1, arg3, arg4, arg5, arg6, arg7, arg8, arg9, arg10, true);
        0xa5cfafe6660a8bf37eedf1a09dba633048da374c30b835668473689668f9ef57::account_data::add_order(arg2, arg4, market_key_internal<T0>(arg1, arg5), v0, arg11);
    }

    public fun admin_withdraw<T0>(arg0: &0xa5cfafe6660a8bf37eedf1a09dba633048da374c30b835668473689668f9ef57::admin::AdminCap, arg1: &mut MarketRegistry<T0>, arg2: u64, arg3: address, arg4: &mut 0x2::tx_context::TxContext) {
        let v0 = 0x2::balance::value<T0>(&arg1.balance);
        assert!(arg2 <= v0, 11);
        let v1 = v0 - arg2;
        assert!(v1 >= arg1.min_reserve, 11);
        0x2::transfer::public_transfer<0x2::coin::Coin<T0>>(0x2::coin::take<T0>(&mut arg1.balance, arg2, arg4), arg3);
        if (arg2 > 0) {
            0xa5cfafe6660a8bf37eedf1a09dba633048da374c30b835668473689668f9ef57::events::emit_market_registry_withdrawn(0x2::object::uid_to_address(&arg1.id), arg2, arg3, v1);
        };
    }

    fun assert_account_order_perm<T0>(arg0: &MarketRegistry<T0>, arg1: &0xe308bd40bd81aa42b9245e4b51b3fe63801c77c78a76be4ce5902aae549f7221::account::AccountRegistry, arg2: &0x665188033384920a5bb5dcfb2ef21f54b4568d08b431718b97e02e5c184b92cc::account::AccountRequest, arg3: u64, arg4: u32, arg5: &0x2::clock::Clock) : 0x2::object::ID {
        let v0 = 0xa5cfafe6660a8bf37eedf1a09dba633048da374c30b835668473689668f9ef57::order::account_id(borrow_order<T0>(arg0, arg3));
        assert_wxa_protocol_perm(arg1, v0, 0x665188033384920a5bb5dcfb2ef21f54b4568d08b431718b97e02e5c184b92cc::account::request_address(arg2), arg4, arg5);
        v0
    }

    fun assert_account_position_perm<T0>(arg0: &MarketRegistry<T0>, arg1: &0xe308bd40bd81aa42b9245e4b51b3fe63801c77c78a76be4ce5902aae549f7221::account::AccountRegistry, arg2: &0x665188033384920a5bb5dcfb2ef21f54b4568d08b431718b97e02e5c184b92cc::account::AccountRequest, arg3: u64, arg4: u32, arg5: &0x2::clock::Clock) : 0x2::object::ID {
        assert!(contains_position<T0>(arg0, arg3), 1);
        let v0 = 0xa5cfafe6660a8bf37eedf1a09dba633048da374c30b835668473689668f9ef57::position::account_id(borrow_position<T0>(arg0, arg3));
        assert_wxa_protocol_perm(arg1, v0, 0x665188033384920a5bb5dcfb2ef21f54b4568d08b431718b97e02e5c184b92cc::account::request_address(arg2), arg4, arg5);
        v0
    }

    fun assert_keeper(arg0: &0xa5cfafe6660a8bf37eedf1a09dba633048da374c30b835668473689668f9ef57::global_config::GlobalConfig, arg1: &0x665188033384920a5bb5dcfb2ef21f54b4568d08b431718b97e02e5c184b92cc::account::AccountRequest) {
        0xa5cfafe6660a8bf37eedf1a09dba633048da374c30b835668473689668f9ef57::global_config::assert_version(arg0);
        if (!0xa5cfafe6660a8bf37eedf1a09dba633048da374c30b835668473689668f9ef57::global_config::is_keeper(arg0, 0x665188033384920a5bb5dcfb2ef21f54b4568d08b431718b97e02e5c184b92cc::account::request_address(arg1))) {
            abort 14
        };
    }

    fun assert_wxa_protocol_perm(arg0: &0xe308bd40bd81aa42b9245e4b51b3fe63801c77c78a76be4ce5902aae549f7221::account::AccountRegistry, arg1: 0x2::object::ID, arg2: address, arg3: u32, arg4: &0x2::clock::Clock) {
        if (0xe308bd40bd81aa42b9245e4b51b3fe63801c77c78a76be4ce5902aae549f7221::account::effective_protocol_permissions<0xa5cfafe6660a8bf37eedf1a09dba633048da374c30b835668473689668f9ef57::account_data::WaterXPrediction>(arg0, arg1, arg2, 0x2::clock::timestamp_ms(arg4)) & arg3 != arg3) {
            abort 14
        };
    }

    fun borrow_market<T0>(arg0: &MarketRegistry<T0>, arg1: u64) : &Market {
        if (0x665188033384920a5bb5dcfb2ef21f54b4568d08b431718b97e02e5c184b92cc::linked_table::contains<u64, Market>(&arg0.unresolved_markets, arg1)) {
            0x665188033384920a5bb5dcfb2ef21f54b4568d08b431718b97e02e5c184b92cc::linked_table::borrow<u64, Market>(&arg0.unresolved_markets, arg1)
        } else {
            0x665188033384920a5bb5dcfb2ef21f54b4568d08b431718b97e02e5c184b92cc::linked_table::borrow<u64, Market>(&arg0.resolved_markets, arg1)
        }
    }

    fun borrow_market_by_id<T0>(arg0: &MarketRegistry<T0>, arg1: vector<u8>) : &Market {
        let v0 = market_pointer_internal<T0>(arg0, arg1);
        if (v0.resolved) {
            0x665188033384920a5bb5dcfb2ef21f54b4568d08b431718b97e02e5c184b92cc::linked_table::borrow<u64, Market>(&arg0.resolved_markets, v0.key)
        } else {
            0x665188033384920a5bb5dcfb2ef21f54b4568d08b431718b97e02e5c184b92cc::linked_table::borrow<u64, Market>(&arg0.unresolved_markets, v0.key)
        }
    }

    fun borrow_market_by_id_mut<T0>(arg0: &mut MarketRegistry<T0>, arg1: vector<u8>) : &mut Market {
        let v0 = market_pointer_internal<T0>(arg0, arg1);
        if (v0.resolved) {
            0x665188033384920a5bb5dcfb2ef21f54b4568d08b431718b97e02e5c184b92cc::linked_table::borrow_mut<u64, Market>(&mut arg0.resolved_markets, v0.key)
        } else {
            0x665188033384920a5bb5dcfb2ef21f54b4568d08b431718b97e02e5c184b92cc::linked_table::borrow_mut<u64, Market>(&mut arg0.unresolved_markets, v0.key)
        }
    }

    fun borrow_order<T0>(arg0: &MarketRegistry<T0>, arg1: u64) : &0xa5cfafe6660a8bf37eedf1a09dba633048da374c30b835668473689668f9ef57::order::Order {
        0x665188033384920a5bb5dcfb2ef21f54b4568d08b431718b97e02e5c184b92cc::linked_table::borrow<u64, 0xa5cfafe6660a8bf37eedf1a09dba633048da374c30b835668473689668f9ef57::order::Order>(&arg0.orders, arg1)
    }

    fun borrow_position<T0>(arg0: &MarketRegistry<T0>, arg1: u64) : &0xa5cfafe6660a8bf37eedf1a09dba633048da374c30b835668473689668f9ef57::position::Position {
        0x665188033384920a5bb5dcfb2ef21f54b4568d08b431718b97e02e5c184b92cc::linked_table::borrow<u64, 0xa5cfafe6660a8bf37eedf1a09dba633048da374c30b835668473689668f9ef57::position::Position>(&arg0.positions, arg1)
    }

    fun borrow_position_mut<T0>(arg0: &mut MarketRegistry<T0>, arg1: u64) : &mut 0xa5cfafe6660a8bf37eedf1a09dba633048da374c30b835668473689668f9ef57::position::Position {
        0x665188033384920a5bb5dcfb2ef21f54b4568d08b431718b97e02e5c184b92cc::linked_table::borrow_mut<u64, 0xa5cfafe6660a8bf37eedf1a09dba633048da374c30b835668473689668f9ef57::position::Position>(&mut arg0.positions, arg1)
    }

    public fun cancel_order<T0>(arg0: &0xa5cfafe6660a8bf37eedf1a09dba633048da374c30b835668473689668f9ef57::global_config::GlobalConfig, arg1: &0x665188033384920a5bb5dcfb2ef21f54b4568d08b431718b97e02e5c184b92cc::account::AccountRequest, arg2: &mut MarketRegistry<T0>, arg3: &mut 0xe308bd40bd81aa42b9245e4b51b3fe63801c77c78a76be4ce5902aae549f7221::account::AccountRegistry, arg4: u64, arg5: &0x2::clock::Clock) {
        assert_keeper(arg0, arg1);
        let v0 = borrow_order<T0>(arg2, arg4);
        assert!(0xa5cfafe6660a8bf37eedf1a09dba633048da374c30b835668473689668f9ef57::order::is_open(v0), 1);
        let v1 = 0xa5cfafe6660a8bf37eedf1a09dba633048da374c30b835668473689668f9ef57::order::account_id(v0);
        let v2 = 0xa5cfafe6660a8bf37eedf1a09dba633048da374c30b835668473689668f9ef57::order::market_id(v0);
        let v3 = 0xa5cfafe6660a8bf37eedf1a09dba633048da374c30b835668473689668f9ef57::order::selection(v0);
        let v4 = market_key_internal<T0>(arg2, v2);
        let v5 = 0xa5cfafe6660a8bf37eedf1a09dba633048da374c30b835668473689668f9ef57::order::max_spend(v0);
        0xe308bd40bd81aa42b9245e4b51b3fe63801c77c78a76be4ce5902aae549f7221::account::put<T0, 0xa5cfafe6660a8bf37eedf1a09dba633048da374c30b835668473689668f9ef57::account_data::WaterXPrediction>(arg3, v1, 0x2::balance::split<T0>(&mut arg2.balance, v5), 0xa5cfafe6660a8bf37eedf1a09dba633048da374c30b835668473689668f9ef57::account_data::witness());
        0xa5cfafe6660a8bf37eedf1a09dba633048da374c30b835668473689668f9ef57::account_data::remove_order(arg3, v1, v4, arg4);
        remove_and_drop_order<T0>(arg2, arg4);
        0xa5cfafe6660a8bf37eedf1a09dba633048da374c30b835668473689668f9ef57::events::emit_order_cancelled(0x2::object::uid_to_address(&arg2.id), arg4, v1, v4, v2, v3, v5, false, 0x2::clock::timestamp_ms(arg5));
    }

    public fun claim<T0>(arg0: &0xa5cfafe6660a8bf37eedf1a09dba633048da374c30b835668473689668f9ef57::global_config::GlobalConfig, arg1: &mut MarketRegistry<T0>, arg2: &mut 0xe308bd40bd81aa42b9245e4b51b3fe63801c77c78a76be4ce5902aae549f7221::account::AccountRegistry, arg3: &0x665188033384920a5bb5dcfb2ef21f54b4568d08b431718b97e02e5c184b92cc::account::AccountRequest, arg4: u64, arg5: &0x2::clock::Clock) {
        0xa5cfafe6660a8bf37eedf1a09dba633048da374c30b835668473689668f9ef57::global_config::assert_version(arg0);
        let v0 = assert_account_position_perm<T0>(arg1, arg2, arg3, arg4, 0xa5cfafe6660a8bf37eedf1a09dba633048da374c30b835668473689668f9ef57::account_data::perm_claim(), arg5);
        clear_pending_close_if_resolved<T0>(arg1, arg2, arg4, 0x2::clock::timestamp_ms(arg5));
        settle_position_to_wxa_internal<T0>(arg1, arg2, v0, arg4, 0x2::clock::timestamp_ms(arg5));
    }

    fun clear_pending_close_if_resolved<T0>(arg0: &mut MarketRegistry<T0>, arg1: &mut 0xe308bd40bd81aa42b9245e4b51b3fe63801c77c78a76be4ce5902aae549f7221::account::AccountRegistry, arg2: u64, arg3: u64) {
        if (!contains_position<T0>(arg0, arg2)) {
            return
        };
        let v0 = borrow_position<T0>(arg0, arg2);
        if (!0xa5cfafe6660a8bf37eedf1a09dba633048da374c30b835668473689668f9ef57::position::has_pending_close(v0)) {
            return
        };
        let v1 = 0xa5cfafe6660a8bf37eedf1a09dba633048da374c30b835668473689668f9ef57::position::market_id(v0);
        if (!is_market_resolved_internal<T0>(arg0, v1)) {
            return
        };
        let v2 = 0xa5cfafe6660a8bf37eedf1a09dba633048da374c30b835668473689668f9ef57::position::close_order_id(v0);
        let v3 = *0x1::option::borrow<u64>(&v2);
        let v4 = 0xa5cfafe6660a8bf37eedf1a09dba633048da374c30b835668473689668f9ef57::position::account_id(v0);
        let v5 = 0xa5cfafe6660a8bf37eedf1a09dba633048da374c30b835668473689668f9ef57::position::selection(v0);
        let v6 = market_key_internal<T0>(arg0, v1);
        let v7 = borrow_position_mut<T0>(arg0, arg2);
        0xa5cfafe6660a8bf37eedf1a09dba633048da374c30b835668473689668f9ef57::position::cancel_close(v7);
        0xa5cfafe6660a8bf37eedf1a09dba633048da374c30b835668473689668f9ef57::account_data::remove_order(arg1, v4, v6, v3);
        remove_and_drop_order<T0>(arg0, v3);
        0xa5cfafe6660a8bf37eedf1a09dba633048da374c30b835668473689668f9ef57::events::emit_close_cancelled(0x2::object::uid_to_address(&arg0.id), v3, v4, arg2, v6, v1, v5, true, arg3);
    }

    public fun confirm_close<T0>(arg0: &0xa5cfafe6660a8bf37eedf1a09dba633048da374c30b835668473689668f9ef57::global_config::GlobalConfig, arg1: &0x665188033384920a5bb5dcfb2ef21f54b4568d08b431718b97e02e5c184b92cc::account::AccountRequest, arg2: &mut MarketRegistry<T0>, arg3: &mut 0xe308bd40bd81aa42b9245e4b51b3fe63801c77c78a76be4ce5902aae549f7221::account::AccountRegistry, arg4: u64, arg5: u64, arg6: &0x2::clock::Clock) {
        assert_keeper(arg0, arg1);
        let v0 = borrow_position<T0>(arg2, arg4);
        assert!(0xa5cfafe6660a8bf37eedf1a09dba633048da374c30b835668473689668f9ef57::position::has_pending_close(v0), 1);
        let v1 = 0xa5cfafe6660a8bf37eedf1a09dba633048da374c30b835668473689668f9ef57::position::account_id(v0);
        let v2 = 0xa5cfafe6660a8bf37eedf1a09dba633048da374c30b835668473689668f9ef57::position::market_id(v0);
        let v3 = market_key_internal<T0>(arg2, v2);
        let v4 = 0xa5cfafe6660a8bf37eedf1a09dba633048da374c30b835668473689668f9ef57::position::selection(v0);
        let v5 = 0xa5cfafe6660a8bf37eedf1a09dba633048da374c30b835668473689668f9ef57::position::filled_shares(v0);
        let v6 = 0xa5cfafe6660a8bf37eedf1a09dba633048da374c30b835668473689668f9ef57::position::filled_cost(v0);
        let v7 = 0xa5cfafe6660a8bf37eedf1a09dba633048da374c30b835668473689668f9ef57::position::close_order_id(v0);
        let v8 = *0x1::option::borrow<u64>(&v7);
        let v9 = borrow_order<T0>(arg2, v8);
        assert!(0xa5cfafe6660a8bf37eedf1a09dba633048da374c30b835668473689668f9ef57::order::is_close(v9), 1);
        assert!(0x2::clock::timestamp_ms(arg6) <= 0xa5cfafe6660a8bf37eedf1a09dba633048da374c30b835668473689668f9ef57::order::expiry_ts(v9) + 300000, 18);
        assert!(arg5 >= 0xa5cfafe6660a8bf37eedf1a09dba633048da374c30b835668473689668f9ef57::order::min_proceeds(v9), 13);
        assert!(!is_market_resolved_internal<T0>(arg2, v2), 12);
        assert!(arg5 <= v5, 23);
        if (arg5 > 0) {
            0xe308bd40bd81aa42b9245e4b51b3fe63801c77c78a76be4ce5902aae549f7221::account::put<T0, 0xa5cfafe6660a8bf37eedf1a09dba633048da374c30b835668473689668f9ef57::account_data::WaterXPrediction>(arg3, v1, 0x2::balance::split<T0>(&mut arg2.balance, arg5), 0xa5cfafe6660a8bf37eedf1a09dba633048da374c30b835668473689668f9ef57::account_data::witness());
        };
        0xa5cfafe6660a8bf37eedf1a09dba633048da374c30b835668473689668f9ef57::account_data::remove_order(arg3, v1, v3, v8);
        0xa5cfafe6660a8bf37eedf1a09dba633048da374c30b835668473689668f9ef57::account_data::remove_position(arg3, v1, v3, arg4);
        remove_and_drop_order<T0>(arg2, v8);
        decrement_market_exposure<T0>(arg2, v2, v4, v5, v6);
        remove_and_drop_position<T0>(arg2, arg4);
        0xa5cfafe6660a8bf37eedf1a09dba633048da374c30b835668473689668f9ef57::events::emit_close_confirmed(0x2::object::uid_to_address(&arg2.id), v8, v1, arg4, v3, v2, v4, v5, v6, arg5, 0x2::clock::timestamp_ms(arg6));
    }

    fun contains_market<T0>(arg0: &MarketRegistry<T0>, arg1: vector<u8>) : bool {
        0x2::table::contains<vector<u8>, MarketPointer>(&arg0.market_id_map, arg1)
    }

    fun contains_order<T0>(arg0: &MarketRegistry<T0>, arg1: u64) : bool {
        0x665188033384920a5bb5dcfb2ef21f54b4568d08b431718b97e02e5c184b92cc::linked_table::contains<u64, 0xa5cfafe6660a8bf37eedf1a09dba633048da374c30b835668473689668f9ef57::order::Order>(&arg0.orders, arg1)
    }

    fun contains_position<T0>(arg0: &MarketRegistry<T0>, arg1: u64) : bool {
        0x665188033384920a5bb5dcfb2ef21f54b4568d08b431718b97e02e5c184b92cc::linked_table::contains<u64, 0xa5cfafe6660a8bf37eedf1a09dba633048da374c30b835668473689668f9ef57::position::Position>(&arg0.positions, arg1)
    }

    fun create_market<T0>(arg0: &mut MarketRegistry<T0>, arg1: vector<u8>, arg2: 0x1::option::Option<0xa5cfafe6660a8bf37eedf1a09dba633048da374c30b835668473689668f9ef57::outcome::Outcome>, arg3: u64, arg4: bool, arg5: bool, arg6: u64) : u64 {
        let v0 = arg0.next_market_key;
        arg0.next_market_key = v0 + 1;
        let v1 = MarketPointer{
            key      : v0,
            resolved : arg4,
        };
        0x2::table::add<vector<u8>, MarketPointer>(&mut arg0.market_id_map, arg1, v1);
        let v2 = Market{
            market_id       : arg1,
            outcome         : arg2,
            unclaimed_count : arg3,
            yes_shares      : 0,
            yes_cost        : 0,
            no_shares       : 0,
            no_cost         : 0,
        };
        if (arg4) {
            0x665188033384920a5bb5dcfb2ef21f54b4568d08b431718b97e02e5c184b92cc::linked_table::push_back<u64, Market>(&mut arg0.resolved_markets, v0, v2);
        } else {
            0x665188033384920a5bb5dcfb2ef21f54b4568d08b431718b97e02e5c184b92cc::linked_table::push_back<u64, Market>(&mut arg0.unresolved_markets, v0, v2);
        };
        0xa5cfafe6660a8bf37eedf1a09dba633048da374c30b835668473689668f9ef57::events::emit_market_created(0x2::object::uid_to_address(&arg0.id), v0, arg1, arg5, arg6);
        v0
    }

    public fun create_market_registry<T0>(arg0: &0xa5cfafe6660a8bf37eedf1a09dba633048da374c30b835668473689668f9ef57::admin::AdminCap, arg1: &mut 0x2::tx_context::TxContext) {
        let v0 = MarketRegistry<T0>{
            id                       : 0x2::object::new(arg1),
            balance                  : 0x2::balance::zero<T0>(),
            market_id_map            : 0x2::table::new<vector<u8>, MarketPointer>(arg1),
            unresolved_markets       : 0x665188033384920a5bb5dcfb2ef21f54b4568d08b431718b97e02e5c184b92cc::linked_table::new<u64, Market>(arg1),
            resolved_markets         : 0x665188033384920a5bb5dcfb2ef21f54b4568d08b431718b97e02e5c184b92cc::linked_table::new<u64, Market>(arg1),
            paused_markets           : 0x2::table::new<u64, bool>(arg1),
            orders                   : 0x665188033384920a5bb5dcfb2ef21f54b4568d08b431718b97e02e5c184b92cc::linked_table::new<u64, 0xa5cfafe6660a8bf37eedf1a09dba633048da374c30b835668473689668f9ef57::order::Order>(arg1),
            positions                : 0x665188033384920a5bb5dcfb2ef21f54b4568d08b431718b97e02e5c184b92cc::linked_table::new<u64, 0xa5cfafe6660a8bf37eedf1a09dba633048da374c30b835668473689668f9ef57::position::Position>(arg1),
            position_id_by_order     : 0x2::table::new<u64, u64>(arg1),
            order_id_by_position     : 0x2::table::new<u64, u64>(arg1),
            next_order_id            : 0,
            next_position_id         : 0,
            next_market_key          : 0,
            order_cancel_cooldown_ms : 30000,
            min_reserve              : 0,
        };
        0x2::transfer::share_object<MarketRegistry<T0>>(v0);
    }

    fun decrement_market_exposure<T0>(arg0: &mut MarketRegistry<T0>, arg1: vector<u8>, arg2: 0xa5cfafe6660a8bf37eedf1a09dba633048da374c30b835668473689668f9ef57::position::Selection, arg3: u64, arg4: u64) {
        let v0 = borrow_market_by_id_mut<T0>(arg0, arg1);
        v0.unclaimed_count = v0.unclaimed_count - 1;
        if (0xa5cfafe6660a8bf37eedf1a09dba633048da374c30b835668473689668f9ef57::position::selection_is_yes(arg2)) {
            v0.yes_shares = v0.yes_shares - arg3;
            v0.yes_cost = v0.yes_cost - arg4;
        } else {
            v0.no_shares = v0.no_shares - arg3;
            v0.no_cost = v0.no_cost - arg4;
        };
    }

    public fun deposit_settlement<T0>(arg0: &0xa5cfafe6660a8bf37eedf1a09dba633048da374c30b835668473689668f9ef57::admin::AdminCap, arg1: &mut MarketRegistry<T0>, arg2: 0x2::coin::Coin<T0>) {
        0x2::coin::put<T0>(&mut arg1.balance, arg2);
    }

    fun ensure_market_key_for_pause<T0>(arg0: &mut MarketRegistry<T0>, arg1: vector<u8>, arg2: u64) : u64 {
        if (contains_market<T0>(arg0, arg1)) {
            return market_key_internal<T0>(arg0, arg1)
        };
        create_market<T0>(arg0, arg1, 0x1::option::none<0xa5cfafe6660a8bf37eedf1a09dba633048da374c30b835668473689668f9ef57::outcome::Outcome>(), 0, false, true, arg2)
    }

    fun ensure_unresolved_market<T0>(arg0: &mut MarketRegistry<T0>, arg1: vector<u8>, arg2: bool, arg3: u64) : u64 {
        if (contains_market<T0>(arg0, arg1)) {
            let v0 = market_pointer_internal<T0>(arg0, arg1);
            assert!(!v0.resolved, 12);
            return v0.key
        };
        create_market<T0>(arg0, arg1, 0x1::option::none<0xa5cfafe6660a8bf37eedf1a09dba633048da374c30b835668473689668f9ef57::outcome::Outcome>(), 0, false, arg2, arg3)
    }

    public fun fill_order<T0>(arg0: &0xa5cfafe6660a8bf37eedf1a09dba633048da374c30b835668473689668f9ef57::global_config::GlobalConfig, arg1: &0x665188033384920a5bb5dcfb2ef21f54b4568d08b431718b97e02e5c184b92cc::account::AccountRequest, arg2: &mut MarketRegistry<T0>, arg3: &mut 0xe308bd40bd81aa42b9245e4b51b3fe63801c77c78a76be4ce5902aae549f7221::account::AccountRegistry, arg4: u64, arg5: u64, arg6: u64, arg7: &0x2::clock::Clock, arg8: &mut 0x2::tx_context::TxContext) {
        assert_keeper(arg0, arg1);
        let v0 = borrow_order<T0>(arg2, arg4);
        assert!(0xa5cfafe6660a8bf37eedf1a09dba633048da374c30b835668473689668f9ef57::order::is_open(v0), 1);
        assert!(0x2::clock::timestamp_ms(arg7) <= 0xa5cfafe6660a8bf37eedf1a09dba633048da374c30b835668473689668f9ef57::order::expiry_ts(v0) + 300000, 18);
        let v1 = 0xa5cfafe6660a8bf37eedf1a09dba633048da374c30b835668473689668f9ef57::order::account_id(v0);
        let v2 = 0xa5cfafe6660a8bf37eedf1a09dba633048da374c30b835668473689668f9ef57::order::receiver_account_id(v0);
        let v3 = 0xa5cfafe6660a8bf37eedf1a09dba633048da374c30b835668473689668f9ef57::order::market_id(v0);
        let v4 = market_key_internal<T0>(arg2, v3);
        let v5 = 0xa5cfafe6660a8bf37eedf1a09dba633048da374c30b835668473689668f9ef57::order::selection(v0);
        let v6 = 0xa5cfafe6660a8bf37eedf1a09dba633048da374c30b835668473689668f9ef57::order::max_spend(v0);
        assert!(!is_market_resolved_internal<T0>(arg2, v3), 12);
        assert!(arg6 <= v6, 6);
        assert!(arg5 >= 0xa5cfafe6660a8bf37eedf1a09dba633048da374c30b835668473689668f9ef57::order::min_shares(v0), 7);
        assert!(arg5 > 0, 22);
        assert!((arg6 as u128) * (10000 as u128) <= (arg5 as u128) * (0xa5cfafe6660a8bf37eedf1a09dba633048da374c30b835668473689668f9ef57::order::price_cap(v0) as u128), 20);
        assert!((arg5 as u128) * (10 as u128) <= (arg6 as u128) * (10000 as u128), 21);
        let v7 = v6 - arg6;
        if (v7 > 0) {
            0xe308bd40bd81aa42b9245e4b51b3fe63801c77c78a76be4ce5902aae549f7221::account::put<T0, 0xa5cfafe6660a8bf37eedf1a09dba633048da374c30b835668473689668f9ef57::account_data::WaterXPrediction>(arg3, v1, 0x2::balance::split<T0>(&mut arg2.balance, v7), 0xa5cfafe6660a8bf37eedf1a09dba633048da374c30b835668473689668f9ef57::account_data::witness());
        };
        let v8 = arg2.next_position_id;
        arg2.next_position_id = v8 + 1;
        0x665188033384920a5bb5dcfb2ef21f54b4568d08b431718b97e02e5c184b92cc::linked_table::push_back<u64, 0xa5cfafe6660a8bf37eedf1a09dba633048da374c30b835668473689668f9ef57::position::Position>(&mut arg2.positions, v8, 0xa5cfafe6660a8bf37eedf1a09dba633048da374c30b835668473689668f9ef57::position::new(v2, v3, v5, arg5, arg6, 0x2::clock::timestamp_ms(arg7)));
        0x2::table::add<u64, u64>(&mut arg2.position_id_by_order, arg4, v8);
        0x2::table::add<u64, u64>(&mut arg2.order_id_by_position, v8, arg4);
        0xa5cfafe6660a8bf37eedf1a09dba633048da374c30b835668473689668f9ef57::account_data::add_position(arg3, v2, v4, v8, arg8);
        0xa5cfafe6660a8bf37eedf1a09dba633048da374c30b835668473689668f9ef57::account_data::remove_order(arg3, v1, v4, arg4);
        remove_and_drop_order<T0>(arg2, arg4);
        increment_market_exposure<T0>(arg2, v3, v5, arg5, arg6);
        0xa5cfafe6660a8bf37eedf1a09dba633048da374c30b835668473689668f9ef57::events::emit_order_filled(0x2::object::uid_to_address(&arg2.id), arg4, v2, v8, v4, v3, v5, arg5, arg6, 0x2::clock::timestamp_ms(arg7));
    }

    public fun force_claim<T0>(arg0: &0xa5cfafe6660a8bf37eedf1a09dba633048da374c30b835668473689668f9ef57::global_config::GlobalConfig, arg1: &0x665188033384920a5bb5dcfb2ef21f54b4568d08b431718b97e02e5c184b92cc::account::AccountRequest, arg2: &mut MarketRegistry<T0>, arg3: &mut 0xe308bd40bd81aa42b9245e4b51b3fe63801c77c78a76be4ce5902aae549f7221::account::AccountRegistry, arg4: u64, arg5: &0x2::clock::Clock) {
        assert_keeper(arg0, arg1);
        assert!(contains_position<T0>(arg2, arg4), 1);
        let v0 = 0xa5cfafe6660a8bf37eedf1a09dba633048da374c30b835668473689668f9ef57::position::account_id(borrow_position<T0>(arg2, arg4));
        clear_pending_close_if_resolved<T0>(arg2, arg3, arg4, 0x2::clock::timestamp_ms(arg5));
        settle_position_to_wxa_internal<T0>(arg2, arg3, v0, arg4, 0x2::clock::timestamp_ms(arg5));
    }

    fun increment_market_exposure<T0>(arg0: &mut MarketRegistry<T0>, arg1: vector<u8>, arg2: 0xa5cfafe6660a8bf37eedf1a09dba633048da374c30b835668473689668f9ef57::position::Selection, arg3: u64, arg4: u64) {
        let v0 = borrow_market_by_id_mut<T0>(arg0, arg1);
        v0.unclaimed_count = v0.unclaimed_count + 1;
        if (0xa5cfafe6660a8bf37eedf1a09dba633048da374c30b835668473689668f9ef57::position::selection_is_yes(arg2)) {
            v0.yes_shares = v0.yes_shares + arg3;
            v0.yes_cost = v0.yes_cost + arg4;
        } else {
            v0.no_shares = v0.no_shares + arg3;
            v0.no_cost = v0.no_cost + arg4;
        };
    }

    fun increment_market_unclaimed_count<T0>(arg0: &mut MarketRegistry<T0>, arg1: vector<u8>) {
        let v0 = borrow_market_by_id_mut<T0>(arg0, arg1);
        v0.unclaimed_count = v0.unclaimed_count + 1;
    }

    public fun is_market_paused<T0>(arg0: &MarketRegistry<T0>, arg1: vector<u8>) : bool {
        is_market_paused_internal<T0>(arg0, arg1)
    }

    public fun is_market_paused_by_key<T0>(arg0: &MarketRegistry<T0>, arg1: u64) : bool {
        0x2::table::contains<u64, bool>(&arg0.paused_markets, arg1)
    }

    fun is_market_paused_internal<T0>(arg0: &MarketRegistry<T0>, arg1: vector<u8>) : bool {
        contains_market<T0>(arg0, arg1) && 0x2::table::contains<u64, bool>(&arg0.paused_markets, market_key_internal<T0>(arg0, arg1))
    }

    public fun is_market_resolved<T0>(arg0: &MarketRegistry<T0>, arg1: vector<u8>) : bool {
        is_market_resolved_internal<T0>(arg0, arg1)
    }

    fun is_market_resolved_internal<T0>(arg0: &MarketRegistry<T0>, arg1: vector<u8>) : bool {
        if (contains_market<T0>(arg0, arg1)) {
            let v1 = market_pointer_internal<T0>(arg0, arg1);
            v1.resolved
        } else {
            false
        }
    }

    fun is_valid_comparison(arg0: u8) : bool {
        if (arg0 == 0) {
            true
        } else if (arg0 == 1) {
            true
        } else if (arg0 == 2) {
            true
        } else {
            arg0 == 3
        }
    }

    fun linked_key_at<T0: store>(arg0: &0x665188033384920a5bb5dcfb2ef21f54b4568d08b431718b97e02e5c184b92cc::linked_table::LinkedTable<u64, T0>, arg1: u64) : u64 {
        let v0 = *0x665188033384920a5bb5dcfb2ef21f54b4568d08b431718b97e02e5c184b92cc::linked_table::front<u64, T0>(arg0);
        let v1 = 0;
        while (v1 < arg1) {
            let v2 = 0x665188033384920a5bb5dcfb2ef21f54b4568d08b431718b97e02e5c184b92cc::linked_table::next<u64, T0>(arg0, *0x1::option::borrow<u64>(&v0));
            v0 = *v2;
            v1 = v1 + 1;
        };
        *0x1::option::borrow<u64>(&v0)
    }

    public fun market_count<T0>(arg0: &MarketRegistry<T0>) : u64 {
        0x665188033384920a5bb5dcfb2ef21f54b4568d08b431718b97e02e5c184b92cc::linked_table::length<u64, Market>(&arg0.unresolved_markets) + 0x665188033384920a5bb5dcfb2ef21f54b4568d08b431718b97e02e5c184b92cc::linked_table::length<u64, Market>(&arg0.resolved_markets)
    }

    public fun market_exists<T0>(arg0: &MarketRegistry<T0>, arg1: vector<u8>) : bool {
        contains_market<T0>(arg0, arg1)
    }

    public fun market_exists_by_key<T0>(arg0: &MarketRegistry<T0>, arg1: u64) : bool {
        0x665188033384920a5bb5dcfb2ef21f54b4568d08b431718b97e02e5c184b92cc::linked_table::contains<u64, Market>(&arg0.unresolved_markets, arg1) || 0x665188033384920a5bb5dcfb2ef21f54b4568d08b431718b97e02e5c184b92cc::linked_table::contains<u64, Market>(&arg0.resolved_markets, arg1)
    }

    public fun market_exposure<T0>(arg0: &MarketRegistry<T0>, arg1: vector<u8>) : (u64, u64, u64, u64) {
        let v0 = borrow_market_by_id<T0>(arg0, arg1);
        (v0.yes_shares, v0.yes_cost, v0.no_shares, v0.no_cost)
    }

    public fun market_exposure_by_key<T0>(arg0: &MarketRegistry<T0>, arg1: u64) : (u64, u64, u64, u64) {
        let v0 = borrow_market<T0>(arg0, arg1);
        (v0.yes_shares, v0.yes_cost, v0.no_shares, v0.no_cost)
    }

    public fun market_id_by_key<T0>(arg0: &MarketRegistry<T0>, arg1: u64) : vector<u8> {
        borrow_market<T0>(arg0, arg1).market_id
    }

    public fun market_is_resolved_by_key<T0>(arg0: &MarketRegistry<T0>, arg1: u64) : bool {
        0x665188033384920a5bb5dcfb2ef21f54b4568d08b431718b97e02e5c184b92cc::linked_table::contains<u64, Market>(&arg0.resolved_markets, arg1)
    }

    public fun market_key<T0>(arg0: &MarketRegistry<T0>, arg1: vector<u8>) : u64 {
        market_key_internal<T0>(arg0, arg1)
    }

    public fun market_key_at<T0>(arg0: &MarketRegistry<T0>, arg1: u64) : u64 {
        let v0 = 0x665188033384920a5bb5dcfb2ef21f54b4568d08b431718b97e02e5c184b92cc::linked_table::length<u64, Market>(&arg0.unresolved_markets);
        if (arg1 < v0) {
            linked_key_at<Market>(&arg0.unresolved_markets, arg1)
        } else {
            linked_key_at<Market>(&arg0.resolved_markets, arg1 - v0)
        }
    }

    fun market_key_internal<T0>(arg0: &MarketRegistry<T0>, arg1: vector<u8>) : u64 {
        let v0 = market_pointer_internal<T0>(arg0, arg1);
        v0.key
    }

    public fun market_outcome<T0>(arg0: &MarketRegistry<T0>, arg1: vector<u8>) : 0xa5cfafe6660a8bf37eedf1a09dba633048da374c30b835668473689668f9ef57::outcome::Outcome {
        let v0 = borrow_market_by_id<T0>(arg0, arg1);
        if (0x1::option::is_none<0xa5cfafe6660a8bf37eedf1a09dba633048da374c30b835668473689668f9ef57::outcome::Outcome>(&v0.outcome)) {
            abort 3
        };
        *0x1::option::borrow<0xa5cfafe6660a8bf37eedf1a09dba633048da374c30b835668473689668f9ef57::outcome::Outcome>(&v0.outcome)
    }

    public fun market_outcome_by_key<T0>(arg0: &MarketRegistry<T0>, arg1: u64) : 0x1::option::Option<0xa5cfafe6660a8bf37eedf1a09dba633048da374c30b835668473689668f9ef57::outcome::Outcome> {
        borrow_market<T0>(arg0, arg1).outcome
    }

    fun market_pointer_internal<T0>(arg0: &MarketRegistry<T0>, arg1: vector<u8>) : MarketPointer {
        *0x2::table::borrow<vector<u8>, MarketPointer>(&arg0.market_id_map, arg1)
    }

    public fun market_registry_balance<T0>(arg0: &MarketRegistry<T0>) : u64 {
        0x2::balance::value<T0>(&arg0.balance)
    }

    public fun market_registry_min_reserve<T0>(arg0: &MarketRegistry<T0>) : u64 {
        arg0.min_reserve
    }

    public fun market_registry_order_cancel_cooldown_ms<T0>(arg0: &MarketRegistry<T0>) : u64 {
        arg0.order_cancel_cooldown_ms
    }

    public fun market_unclaimed_count<T0>(arg0: &MarketRegistry<T0>, arg1: vector<u8>) : u64 {
        borrow_market_by_id<T0>(arg0, arg1).unclaimed_count
    }

    public fun market_unclaimed_count_by_key<T0>(arg0: &MarketRegistry<T0>, arg1: u64) : u64 {
        borrow_market<T0>(arg0, arg1).unclaimed_count
    }

    public fun next_order_id<T0>(arg0: &MarketRegistry<T0>) : u64 {
        arg0.next_order_id
    }

    public fun next_position_id<T0>(arg0: &MarketRegistry<T0>) : u64 {
        arg0.next_position_id
    }

    public fun order_account_id<T0>(arg0: &MarketRegistry<T0>, arg1: u64) : 0x2::object::ID {
        0xa5cfafe6660a8bf37eedf1a09dba633048da374c30b835668473689668f9ef57::order::account_id(borrow_order<T0>(arg0, arg1))
    }

    public fun order_back<T0>(arg0: &MarketRegistry<T0>) : 0x1::option::Option<u64> {
        *0x665188033384920a5bb5dcfb2ef21f54b4568d08b431718b97e02e5c184b92cc::linked_table::back<u64, 0xa5cfafe6660a8bf37eedf1a09dba633048da374c30b835668473689668f9ef57::order::Order>(&arg0.orders)
    }

    public fun order_count<T0>(arg0: &MarketRegistry<T0>) : u64 {
        0x665188033384920a5bb5dcfb2ef21f54b4568d08b431718b97e02e5c184b92cc::linked_table::length<u64, 0xa5cfafe6660a8bf37eedf1a09dba633048da374c30b835668473689668f9ef57::order::Order>(&arg0.orders)
    }

    public fun order_created_ts<T0>(arg0: &MarketRegistry<T0>, arg1: u64) : u64 {
        0xa5cfafe6660a8bf37eedf1a09dba633048da374c30b835668473689668f9ef57::order::created_ts(borrow_order<T0>(arg0, arg1))
    }

    public fun order_exists<T0>(arg0: &MarketRegistry<T0>, arg1: u64) : bool {
        contains_order<T0>(arg0, arg1)
    }

    public fun order_expiry<T0>(arg0: &MarketRegistry<T0>, arg1: u64) : u64 {
        0xa5cfafe6660a8bf37eedf1a09dba633048da374c30b835668473689668f9ef57::order::expiry_ts(borrow_order<T0>(arg0, arg1))
    }

    public fun order_front<T0>(arg0: &MarketRegistry<T0>) : 0x1::option::Option<u64> {
        *0x665188033384920a5bb5dcfb2ef21f54b4568d08b431718b97e02e5c184b92cc::linked_table::front<u64, 0xa5cfafe6660a8bf37eedf1a09dba633048da374c30b835668473689668f9ef57::order::Order>(&arg0.orders)
    }

    public fun order_is_by_admin<T0>(arg0: &MarketRegistry<T0>, arg1: u64) : bool {
        0xa5cfafe6660a8bf37eedf1a09dba633048da374c30b835668473689668f9ef57::order::by_admin(borrow_order<T0>(arg0, arg1))
    }

    public fun order_key_at<T0>(arg0: &MarketRegistry<T0>, arg1: u64) : u64 {
        linked_key_at<0xa5cfafe6660a8bf37eedf1a09dba633048da374c30b835668473689668f9ef57::order::Order>(&arg0.orders, arg1)
    }

    public fun order_kind<T0>(arg0: &MarketRegistry<T0>, arg1: u64) : 0xa5cfafe6660a8bf37eedf1a09dba633048da374c30b835668473689668f9ef57::order::OrderKind {
        0xa5cfafe6660a8bf37eedf1a09dba633048da374c30b835668473689668f9ef57::order::kind(borrow_order<T0>(arg0, arg1))
    }

    public fun order_kind_is_close(arg0: 0xa5cfafe6660a8bf37eedf1a09dba633048da374c30b835668473689668f9ef57::order::OrderKind) : bool {
        0xa5cfafe6660a8bf37eedf1a09dba633048da374c30b835668473689668f9ef57::order::kind_is_close(arg0)
    }

    public fun order_kind_is_open(arg0: 0xa5cfafe6660a8bf37eedf1a09dba633048da374c30b835668473689668f9ef57::order::OrderKind) : bool {
        0xa5cfafe6660a8bf37eedf1a09dba633048da374c30b835668473689668f9ef57::order::kind_is_open(arg0)
    }

    public fun order_market_id<T0>(arg0: &MarketRegistry<T0>, arg1: u64) : vector<u8> {
        0xa5cfafe6660a8bf37eedf1a09dba633048da374c30b835668473689668f9ef57::order::market_id(borrow_order<T0>(arg0, arg1))
    }

    public fun order_max_spend<T0>(arg0: &MarketRegistry<T0>, arg1: u64) : u64 {
        0xa5cfafe6660a8bf37eedf1a09dba633048da374c30b835668473689668f9ef57::order::max_spend(borrow_order<T0>(arg0, arg1))
    }

    public fun order_min_proceeds<T0>(arg0: &MarketRegistry<T0>, arg1: u64) : u64 {
        0xa5cfafe6660a8bf37eedf1a09dba633048da374c30b835668473689668f9ef57::order::min_proceeds(borrow_order<T0>(arg0, arg1))
    }

    public fun order_min_shares<T0>(arg0: &MarketRegistry<T0>, arg1: u64) : u64 {
        0xa5cfafe6660a8bf37eedf1a09dba633048da374c30b835668473689668f9ef57::order::min_shares(borrow_order<T0>(arg0, arg1))
    }

    public fun order_next<T0>(arg0: &MarketRegistry<T0>, arg1: u64) : 0x1::option::Option<u64> {
        *0x665188033384920a5bb5dcfb2ef21f54b4568d08b431718b97e02e5c184b92cc::linked_table::next<u64, 0xa5cfafe6660a8bf37eedf1a09dba633048da374c30b835668473689668f9ef57::order::Order>(&arg0.orders, arg1)
    }

    public fun order_position_id<T0>(arg0: &MarketRegistry<T0>, arg1: u64) : 0x1::option::Option<u64> {
        0xa5cfafe6660a8bf37eedf1a09dba633048da374c30b835668473689668f9ef57::order::position_id(borrow_order<T0>(arg0, arg1))
    }

    public fun order_prev<T0>(arg0: &MarketRegistry<T0>, arg1: u64) : 0x1::option::Option<u64> {
        *0x665188033384920a5bb5dcfb2ef21f54b4568d08b431718b97e02e5c184b92cc::linked_table::prev<u64, 0xa5cfafe6660a8bf37eedf1a09dba633048da374c30b835668473689668f9ef57::order::Order>(&arg0.orders, arg1)
    }

    public fun order_price_cap<T0>(arg0: &MarketRegistry<T0>, arg1: u64) : u64 {
        0xa5cfafe6660a8bf37eedf1a09dba633048da374c30b835668473689668f9ef57::order::price_cap(borrow_order<T0>(arg0, arg1))
    }

    public fun order_receiver_account_id<T0>(arg0: &MarketRegistry<T0>, arg1: u64) : 0x2::object::ID {
        0xa5cfafe6660a8bf37eedf1a09dba633048da374c30b835668473689668f9ef57::order::receiver_account_id(borrow_order<T0>(arg0, arg1))
    }

    public fun order_selection<T0>(arg0: &MarketRegistry<T0>, arg1: u64) : 0xa5cfafe6660a8bf37eedf1a09dba633048da374c30b835668473689668f9ef57::position::Selection {
        0xa5cfafe6660a8bf37eedf1a09dba633048da374c30b835668473689668f9ef57::order::selection(borrow_order<T0>(arg0, arg1))
    }

    public fun order_self_cancel_after_ts<T0>(arg0: &MarketRegistry<T0>, arg1: u64) : u64 {
        0xa5cfafe6660a8bf37eedf1a09dba633048da374c30b835668473689668f9ef57::order::self_cancel_after_ts(borrow_order<T0>(arg0, arg1))
    }

    public fun orders<T0>(arg0: &MarketRegistry<T0>) : &0x665188033384920a5bb5dcfb2ef21f54b4568d08b431718b97e02e5c184b92cc::linked_table::LinkedTable<u64, 0xa5cfafe6660a8bf37eedf1a09dba633048da374c30b835668473689668f9ef57::order::Order> {
        &arg0.orders
    }

    public fun pause_market<T0>(arg0: &0xa5cfafe6660a8bf37eedf1a09dba633048da374c30b835668473689668f9ef57::admin::AdminCap, arg1: &mut MarketRegistry<T0>, arg2: vector<u8>, arg3: &0x2::clock::Clock) {
        let v0 = ensure_market_key_for_pause<T0>(arg1, arg2, 0x2::clock::timestamp_ms(arg3));
        if (!0x2::table::contains<u64, bool>(&arg1.paused_markets, v0)) {
            0x2::table::add<u64, bool>(&mut arg1.paused_markets, v0, true);
            0xa5cfafe6660a8bf37eedf1a09dba633048da374c30b835668473689668f9ef57::events::emit_market_paused(0x2::object::uid_to_address(&arg1.id), v0, arg2);
        };
    }

    public fun place_order<T0>(arg0: &0xa5cfafe6660a8bf37eedf1a09dba633048da374c30b835668473689668f9ef57::global_config::GlobalConfig, arg1: &mut MarketRegistry<T0>, arg2: &mut 0xe308bd40bd81aa42b9245e4b51b3fe63801c77c78a76be4ce5902aae549f7221::account::AccountRegistry, arg3: &0x665188033384920a5bb5dcfb2ef21f54b4568d08b431718b97e02e5c184b92cc::account::AccountRequest, arg4: 0x2::object::ID, arg5: 0x2::object::ID, arg6: u64, arg7: vector<u8>, arg8: 0xa5cfafe6660a8bf37eedf1a09dba633048da374c30b835668473689668f9ef57::position::Selection, arg9: u64, arg10: u64, arg11: u64, arg12: &0x2::clock::Clock, arg13: &mut 0x2::tx_context::TxContext) {
        0xa5cfafe6660a8bf37eedf1a09dba633048da374c30b835668473689668f9ef57::global_config::assert_version(arg0);
        assert!(0xe308bd40bd81aa42b9245e4b51b3fe63801c77c78a76be4ce5902aae549f7221::account::has_account(arg2, arg5), 16);
        assert_wxa_protocol_perm(arg2, arg4, 0x665188033384920a5bb5dcfb2ef21f54b4568d08b431718b97e02e5c184b92cc::account::request_address(arg3), 0xa5cfafe6660a8bf37eedf1a09dba633048da374c30b835668473689668f9ef57::account_data::perm_place_order(), arg12);
        if (arg5 != arg4) {
            assert_wxa_protocol_perm(arg2, arg4, 0x665188033384920a5bb5dcfb2ef21f54b4568d08b431718b97e02e5c184b92cc::account::request_address(arg3), 0xa5cfafe6660a8bf37eedf1a09dba633048da374c30b835668473689668f9ef57::account_data::perm_transfer_position(), arg12);
            let v0 = 0x665188033384920a5bb5dcfb2ef21f54b4568d08b431718b97e02e5c184b92cc::account::request_address(arg3);
            if (!0xe308bd40bd81aa42b9245e4b51b3fe63801c77c78a76be4ce5902aae549f7221::account::is_account_owner(arg2, arg4, v0)) {
                assert!(0xa5cfafe6660a8bf37eedf1a09dba633048da374c30b835668473689668f9ef57::global_config::is_transfer_operator(arg0, v0), 27);
            };
        };
        let v1 = place_order_balance_internal<T0>(arg1, 0xe308bd40bd81aa42b9245e4b51b3fe63801c77c78a76be4ce5902aae549f7221::account::take<T0, 0xa5cfafe6660a8bf37eedf1a09dba633048da374c30b835668473689668f9ef57::account_data::WaterXPrediction>(arg2, arg3, arg4, arg6, 0xa5cfafe6660a8bf37eedf1a09dba633048da374c30b835668473689668f9ef57::account_data::witness(), arg12), arg4, arg5, arg7, arg8, arg9, arg10, arg11, arg12, false);
        0xa5cfafe6660a8bf37eedf1a09dba633048da374c30b835668473689668f9ef57::account_data::add_order(arg2, arg4, market_key_internal<T0>(arg1, arg7), v1, arg13);
    }

    fun place_order_balance_internal<T0>(arg0: &mut MarketRegistry<T0>, arg1: 0x2::balance::Balance<T0>, arg2: 0x2::object::ID, arg3: 0x2::object::ID, arg4: vector<u8>, arg5: 0xa5cfafe6660a8bf37eedf1a09dba633048da374c30b835668473689668f9ef57::position::Selection, arg6: u64, arg7: u64, arg8: u64, arg9: &0x2::clock::Clock, arg10: bool) : u64 {
        assert!(arg7 <= 10000, 5);
        let v0 = 0x2::clock::timestamp_ms(arg9);
        assert!(arg8 > v0, 8);
        let v1 = ensure_unresolved_market<T0>(arg0, arg4, arg10, v0);
        assert!(!0x2::table::contains<u64, bool>(&arg0.paused_markets, v1), 10);
        let v2 = 0x2::balance::value<T0>(&arg1);
        assert!(v2 > 0, 9);
        0x2::balance::join<T0>(&mut arg0.balance, arg1);
        let v3 = arg0.next_order_id;
        arg0.next_order_id = v3 + 1;
        let v4 = v0 + arg0.order_cancel_cooldown_ms;
        0x665188033384920a5bb5dcfb2ef21f54b4568d08b431718b97e02e5c184b92cc::linked_table::push_back<u64, 0xa5cfafe6660a8bf37eedf1a09dba633048da374c30b835668473689668f9ef57::order::Order>(&mut arg0.orders, v3, 0xa5cfafe6660a8bf37eedf1a09dba633048da374c30b835668473689668f9ef57::order::new_open(v3, arg2, arg3, arg4, arg5, v2, arg6, arg7, arg8, v4, v0, arg10));
        0xa5cfafe6660a8bf37eedf1a09dba633048da374c30b835668473689668f9ef57::events::emit_order_placed(0x2::object::uid_to_address(&arg0.id), v3, arg2, arg3, v1, arg4, arg5, v2, arg6, arg7, arg8, v4, v0, arg10, v0);
        v3
    }

    fun place_order_internal<T0>(arg0: &mut MarketRegistry<T0>, arg1: 0x2::coin::Coin<T0>, arg2: 0x2::object::ID, arg3: vector<u8>, arg4: 0xa5cfafe6660a8bf37eedf1a09dba633048da374c30b835668473689668f9ef57::position::Selection, arg5: u64, arg6: u64, arg7: u64, arg8: &0x2::clock::Clock, arg9: bool) : u64 {
        place_order_balance_internal<T0>(arg0, 0x2::coin::into_balance<T0>(arg1), arg2, arg2, arg3, arg4, arg5, arg6, arg7, arg8, arg9)
    }

    public fun position_account_id<T0>(arg0: &MarketRegistry<T0>, arg1: u64) : 0x2::object::ID {
        0xa5cfafe6660a8bf37eedf1a09dba633048da374c30b835668473689668f9ef57::position::account_id(borrow_position<T0>(arg0, arg1))
    }

    public fun position_back<T0>(arg0: &MarketRegistry<T0>) : 0x1::option::Option<u64> {
        *0x665188033384920a5bb5dcfb2ef21f54b4568d08b431718b97e02e5c184b92cc::linked_table::back<u64, 0xa5cfafe6660a8bf37eedf1a09dba633048da374c30b835668473689668f9ef57::position::Position>(&arg0.positions)
    }

    public fun position_close_expiry<T0>(arg0: &MarketRegistry<T0>, arg1: u64) : u64 {
        let v0 = borrow_position<T0>(arg0, arg1);
        if (!0xa5cfafe6660a8bf37eedf1a09dba633048da374c30b835668473689668f9ef57::position::has_pending_close(v0)) {
            return 0
        };
        let v1 = 0xa5cfafe6660a8bf37eedf1a09dba633048da374c30b835668473689668f9ef57::position::close_order_id(v0);
        0xa5cfafe6660a8bf37eedf1a09dba633048da374c30b835668473689668f9ef57::order::expiry_ts(borrow_order<T0>(arg0, *0x1::option::borrow<u64>(&v1)))
    }

    public fun position_close_min_proceeds<T0>(arg0: &MarketRegistry<T0>, arg1: u64) : u64 {
        let v0 = borrow_position<T0>(arg0, arg1);
        if (!0xa5cfafe6660a8bf37eedf1a09dba633048da374c30b835668473689668f9ef57::position::has_pending_close(v0)) {
            return 0
        };
        let v1 = 0xa5cfafe6660a8bf37eedf1a09dba633048da374c30b835668473689668f9ef57::position::close_order_id(v0);
        0xa5cfafe6660a8bf37eedf1a09dba633048da374c30b835668473689668f9ef57::order::min_proceeds(borrow_order<T0>(arg0, *0x1::option::borrow<u64>(&v1)))
    }

    public fun position_close_order_id<T0>(arg0: &MarketRegistry<T0>, arg1: u64) : 0x1::option::Option<u64> {
        0xa5cfafe6660a8bf37eedf1a09dba633048da374c30b835668473689668f9ef57::position::close_order_id(borrow_position<T0>(arg0, arg1))
    }

    public fun position_close_self_cancel_after_ts<T0>(arg0: &MarketRegistry<T0>, arg1: u64) : u64 {
        let v0 = borrow_position<T0>(arg0, arg1);
        if (!0xa5cfafe6660a8bf37eedf1a09dba633048da374c30b835668473689668f9ef57::position::has_pending_close(v0)) {
            return 0
        };
        let v1 = 0xa5cfafe6660a8bf37eedf1a09dba633048da374c30b835668473689668f9ef57::position::close_order_id(v0);
        0xa5cfafe6660a8bf37eedf1a09dba633048da374c30b835668473689668f9ef57::order::self_cancel_after_ts(borrow_order<T0>(arg0, *0x1::option::borrow<u64>(&v1)))
    }

    public fun position_count<T0>(arg0: &MarketRegistry<T0>) : u64 {
        0x665188033384920a5bb5dcfb2ef21f54b4568d08b431718b97e02e5c184b92cc::linked_table::length<u64, 0xa5cfafe6660a8bf37eedf1a09dba633048da374c30b835668473689668f9ef57::position::Position>(&arg0.positions)
    }

    public fun position_exists<T0>(arg0: &MarketRegistry<T0>, arg1: u64) : bool {
        contains_position<T0>(arg0, arg1)
    }

    public fun position_filled<T0>(arg0: &MarketRegistry<T0>, arg1: u64) : (u64, u64) {
        let v0 = borrow_position<T0>(arg0, arg1);
        (0xa5cfafe6660a8bf37eedf1a09dba633048da374c30b835668473689668f9ef57::position::filled_shares(v0), 0xa5cfafe6660a8bf37eedf1a09dba633048da374c30b835668473689668f9ef57::position::filled_cost(v0))
    }

    public fun position_front<T0>(arg0: &MarketRegistry<T0>) : 0x1::option::Option<u64> {
        *0x665188033384920a5bb5dcfb2ef21f54b4568d08b431718b97e02e5c184b92cc::linked_table::front<u64, 0xa5cfafe6660a8bf37eedf1a09dba633048da374c30b835668473689668f9ef57::position::Position>(&arg0.positions)
    }

    public fun position_id_for_order<T0>(arg0: &MarketRegistry<T0>, arg1: u64) : 0x1::option::Option<u64> {
        if (!0x2::table::contains<u64, u64>(&arg0.position_id_by_order, arg1)) {
            return 0x1::option::none<u64>()
        };
        0x1::option::some<u64>(*0x2::table::borrow<u64, u64>(&arg0.position_id_by_order, arg1))
    }

    public fun position_key_at<T0>(arg0: &MarketRegistry<T0>, arg1: u64) : u64 {
        linked_key_at<0xa5cfafe6660a8bf37eedf1a09dba633048da374c30b835668473689668f9ef57::position::Position>(&arg0.positions, arg1)
    }

    public fun position_market_id<T0>(arg0: &MarketRegistry<T0>, arg1: u64) : vector<u8> {
        0xa5cfafe6660a8bf37eedf1a09dba633048da374c30b835668473689668f9ef57::position::market_id(borrow_position<T0>(arg0, arg1))
    }

    public fun position_next<T0>(arg0: &MarketRegistry<T0>, arg1: u64) : 0x1::option::Option<u64> {
        *0x665188033384920a5bb5dcfb2ef21f54b4568d08b431718b97e02e5c184b92cc::linked_table::next<u64, 0xa5cfafe6660a8bf37eedf1a09dba633048da374c30b835668473689668f9ef57::position::Position>(&arg0.positions, arg1)
    }

    public fun position_opened_ts<T0>(arg0: &MarketRegistry<T0>, arg1: u64) : u64 {
        0xa5cfafe6660a8bf37eedf1a09dba633048da374c30b835668473689668f9ef57::position::opened_ts(borrow_position<T0>(arg0, arg1))
    }

    public fun position_payout<T0>(arg0: &MarketRegistry<T0>, arg1: u64) : u64 {
        let v0 = 0xa5cfafe6660a8bf37eedf1a09dba633048da374c30b835668473689668f9ef57::position::market_id(borrow_position<T0>(arg0, arg1));
        if (!contains_market<T0>(arg0, v0)) {
            return 0
        };
        let v1 = borrow_market_by_id<T0>(arg0, v0);
        if (0x1::option::is_none<0xa5cfafe6660a8bf37eedf1a09dba633048da374c30b835668473689668f9ef57::outcome::Outcome>(&v1.outcome)) {
            return 0
        };
        let v2 = *0x1::option::borrow<0xa5cfafe6660a8bf37eedf1a09dba633048da374c30b835668473689668f9ef57::outcome::Outcome>(&v1.outcome);
        let v3 = borrow_position<T0>(arg0, arg1);
        if (0xa5cfafe6660a8bf37eedf1a09dba633048da374c30b835668473689668f9ef57::outcome::is_invalid(v2)) {
            0xa5cfafe6660a8bf37eedf1a09dba633048da374c30b835668473689668f9ef57::position::filled_cost(v3)
        } else if (0xa5cfafe6660a8bf37eedf1a09dba633048da374c30b835668473689668f9ef57::outcome::is_yes(v2)) {
            if (0xa5cfafe6660a8bf37eedf1a09dba633048da374c30b835668473689668f9ef57::position::selection_is_yes(0xa5cfafe6660a8bf37eedf1a09dba633048da374c30b835668473689668f9ef57::position::selection(v3))) {
                0xa5cfafe6660a8bf37eedf1a09dba633048da374c30b835668473689668f9ef57::position::filled_shares(v3)
            } else {
                0
            }
        } else if (0xa5cfafe6660a8bf37eedf1a09dba633048da374c30b835668473689668f9ef57::position::selection_is_no(0xa5cfafe6660a8bf37eedf1a09dba633048da374c30b835668473689668f9ef57::position::selection(v3))) {
            0xa5cfafe6660a8bf37eedf1a09dba633048da374c30b835668473689668f9ef57::position::filled_shares(v3)
        } else {
            0
        }
    }

    public fun position_prev<T0>(arg0: &MarketRegistry<T0>, arg1: u64) : 0x1::option::Option<u64> {
        *0x665188033384920a5bb5dcfb2ef21f54b4568d08b431718b97e02e5c184b92cc::linked_table::prev<u64, 0xa5cfafe6660a8bf37eedf1a09dba633048da374c30b835668473689668f9ef57::position::Position>(&arg0.positions, arg1)
    }

    public fun position_selection<T0>(arg0: &MarketRegistry<T0>, arg1: u64) : 0xa5cfafe6660a8bf37eedf1a09dba633048da374c30b835668473689668f9ef57::position::Selection {
        0xa5cfafe6660a8bf37eedf1a09dba633048da374c30b835668473689668f9ef57::position::selection(borrow_position<T0>(arg0, arg1))
    }

    public fun position_status<T0>(arg0: &MarketRegistry<T0>, arg1: u64) : 0xa5cfafe6660a8bf37eedf1a09dba633048da374c30b835668473689668f9ef57::position::Status {
        0xa5cfafe6660a8bf37eedf1a09dba633048da374c30b835668473689668f9ef57::position::status(borrow_position<T0>(arg0, arg1))
    }

    public fun positions<T0>(arg0: &MarketRegistry<T0>) : &0x665188033384920a5bb5dcfb2ef21f54b4568d08b431718b97e02e5c184b92cc::linked_table::LinkedTable<u64, 0xa5cfafe6660a8bf37eedf1a09dba633048da374c30b835668473689668f9ef57::position::Position> {
        &arg0.positions
    }

    fun price_meets_threshold(arg0: 0x665188033384920a5bb5dcfb2ef21f54b4568d08b431718b97e02e5c184b92cc::float::Float, arg1: 0x665188033384920a5bb5dcfb2ef21f54b4568d08b431718b97e02e5c184b92cc::float::Float, arg2: u8) : bool {
        arg2 == 0 && 0x665188033384920a5bb5dcfb2ef21f54b4568d08b431718b97e02e5c184b92cc::float::gt(arg0, arg1) || arg2 == 1 && 0x665188033384920a5bb5dcfb2ef21f54b4568d08b431718b97e02e5c184b92cc::float::gte(arg0, arg1) || arg2 == 2 && 0x665188033384920a5bb5dcfb2ef21f54b4568d08b431718b97e02e5c184b92cc::float::lt(arg0, arg1) || 0x665188033384920a5bb5dcfb2ef21f54b4568d08b431718b97e02e5c184b92cc::float::lte(arg0, arg1)
    }

    fun remove_and_drop_order<T0>(arg0: &mut MarketRegistry<T0>, arg1: u64) {
        0xa5cfafe6660a8bf37eedf1a09dba633048da374c30b835668473689668f9ef57::order::destroy(0x665188033384920a5bb5dcfb2ef21f54b4568d08b431718b97e02e5c184b92cc::linked_table::remove<u64, 0xa5cfafe6660a8bf37eedf1a09dba633048da374c30b835668473689668f9ef57::order::Order>(&mut arg0.orders, arg1));
    }

    fun remove_and_drop_position<T0>(arg0: &mut MarketRegistry<T0>, arg1: u64) {
        if (0x2::table::contains<u64, u64>(&arg0.order_id_by_position, arg1)) {
            let v0 = 0x2::table::remove<u64, u64>(&mut arg0.order_id_by_position, arg1);
            if (0x2::table::contains<u64, u64>(&arg0.position_id_by_order, v0)) {
                if (*0x2::table::borrow<u64, u64>(&arg0.position_id_by_order, v0) == arg1) {
                    0x2::table::remove<u64, u64>(&mut arg0.position_id_by_order, v0);
                };
            };
        };
        0xa5cfafe6660a8bf37eedf1a09dba633048da374c30b835668473689668f9ef57::position::destroy(0x665188033384920a5bb5dcfb2ef21f54b4568d08b431718b97e02e5c184b92cc::linked_table::remove<u64, 0xa5cfafe6660a8bf37eedf1a09dba633048da374c30b835668473689668f9ef57::position::Position>(&mut arg0.positions, arg1));
    }

    fun request_close_internal<T0>(arg0: &mut MarketRegistry<T0>, arg1: &mut 0xe308bd40bd81aa42b9245e4b51b3fe63801c77c78a76be4ce5902aae549f7221::account::AccountRegistry, arg2: u64, arg3: u64, arg4: u64, arg5: &0x2::clock::Clock) : u64 {
        assert!(arg4 > 0x2::clock::timestamp_ms(arg5), 8);
        assert!(contains_position<T0>(arg0, arg2), 1);
        let v0 = 0x2::clock::timestamp_ms(arg5);
        let v1 = v0 + arg0.order_cancel_cooldown_ms;
        let v2 = 0xa5cfafe6660a8bf37eedf1a09dba633048da374c30b835668473689668f9ef57::position::market_id(borrow_position<T0>(arg0, arg2));
        assert!(!is_market_resolved_internal<T0>(arg0, v2), 12);
        let v3 = market_key_internal<T0>(arg0, v2);
        let v4 = borrow_position<T0>(arg0, arg2);
        assert!(!0xa5cfafe6660a8bf37eedf1a09dba633048da374c30b835668473689668f9ef57::position::has_pending_close(v4), 1);
        let v5 = 0xa5cfafe6660a8bf37eedf1a09dba633048da374c30b835668473689668f9ef57::position::account_id(v4);
        let v6 = 0xa5cfafe6660a8bf37eedf1a09dba633048da374c30b835668473689668f9ef57::position::selection(v4);
        let v7 = arg0.next_order_id;
        arg0.next_order_id = v7 + 1;
        0x665188033384920a5bb5dcfb2ef21f54b4568d08b431718b97e02e5c184b92cc::linked_table::push_back<u64, 0xa5cfafe6660a8bf37eedf1a09dba633048da374c30b835668473689668f9ef57::order::Order>(&mut arg0.orders, v7, 0xa5cfafe6660a8bf37eedf1a09dba633048da374c30b835668473689668f9ef57::order::new_close(v7, v5, v2, v6, arg2, arg3, arg4, v1, v0));
        0xa5cfafe6660a8bf37eedf1a09dba633048da374c30b835668473689668f9ef57::account_data::add_order_for_existing_market(arg1, v5, v3, v7);
        let v8 = borrow_position_mut<T0>(arg0, arg2);
        0xa5cfafe6660a8bf37eedf1a09dba633048da374c30b835668473689668f9ef57::position::request_close(v8, v7);
        0xa5cfafe6660a8bf37eedf1a09dba633048da374c30b835668473689668f9ef57::events::emit_close_requested(0x2::object::uid_to_address(&arg0.id), v7, v5, arg2, v3, v2, v6, arg3, arg4, v1, v0, v0);
        v7
    }

    public fun request_partial_close<T0>(arg0: &0xa5cfafe6660a8bf37eedf1a09dba633048da374c30b835668473689668f9ef57::global_config::GlobalConfig, arg1: &mut MarketRegistry<T0>, arg2: &mut 0xe308bd40bd81aa42b9245e4b51b3fe63801c77c78a76be4ce5902aae549f7221::account::AccountRegistry, arg3: &0x665188033384920a5bb5dcfb2ef21f54b4568d08b431718b97e02e5c184b92cc::account::AccountRequest, arg4: u64, arg5: u64, arg6: u64, arg7: u64, arg8: &0x2::clock::Clock, arg9: &mut 0x2::tx_context::TxContext) : u64 {
        0xa5cfafe6660a8bf37eedf1a09dba633048da374c30b835668473689668f9ef57::global_config::assert_version(arg0);
        let v0 = assert_account_position_perm<T0>(arg1, arg2, arg3, arg4, 0xa5cfafe6660a8bf37eedf1a09dba633048da374c30b835668473689668f9ef57::account_data::perm_request_close(), arg8);
        let v1 = borrow_position<T0>(arg1, arg4);
        assert!(!0xa5cfafe6660a8bf37eedf1a09dba633048da374c30b835668473689668f9ef57::position::has_pending_close(v1), 1);
        assert!(arg5 > 0 && arg5 < 0xa5cfafe6660a8bf37eedf1a09dba633048da374c30b835668473689668f9ef57::position::filled_shares(v1), 24);
        assert!(arg7 > 0x2::clock::timestamp_ms(arg8), 8);
        let v2 = 0xa5cfafe6660a8bf37eedf1a09dba633048da374c30b835668473689668f9ef57::position::market_id(v1);
        let v3 = 0xa5cfafe6660a8bf37eedf1a09dba633048da374c30b835668473689668f9ef57::position::selection(v1);
        assert!(!is_market_resolved_internal<T0>(arg1, v2), 12);
        let v4 = market_key_internal<T0>(arg1, v2);
        let v5 = arg1.next_position_id;
        arg1.next_position_id = v5 + 1;
        let v6 = borrow_position_mut<T0>(arg1, arg4);
        let (v7, v8, v9, v10) = 0xa5cfafe6660a8bf37eedf1a09dba633048da374c30b835668473689668f9ef57::position::split(v6, v0, arg5);
        0x665188033384920a5bb5dcfb2ef21f54b4568d08b431718b97e02e5c184b92cc::linked_table::push_back<u64, 0xa5cfafe6660a8bf37eedf1a09dba633048da374c30b835668473689668f9ef57::position::Position>(&mut arg1.positions, v5, v7);
        0xa5cfafe6660a8bf37eedf1a09dba633048da374c30b835668473689668f9ef57::account_data::add_position(arg2, v0, v4, v5, arg9);
        increment_market_unclaimed_count<T0>(arg1, v2);
        0xa5cfafe6660a8bf37eedf1a09dba633048da374c30b835668473689668f9ef57::events::emit_position_split(0x2::object::uid_to_address(&arg1.id), arg4, v5, v0, v0, v4, v2, v3, arg5, v8, v9, v10, 0x2::clock::timestamp_ms(arg8));
        let v11 = request_close_internal<T0>(arg1, arg2, v5, arg6, arg7, arg8);
        0xa5cfafe6660a8bf37eedf1a09dba633048da374c30b835668473689668f9ef57::events::emit_partial_close_requested(0x2::object::uid_to_address(&arg1.id), arg4, v5, v11, v0, v4, v2, v3, arg5, v8, v9, v10, arg6, arg7, 0x2::clock::timestamp_ms(arg8));
        v5
    }

    public fun resolve_market<T0>(arg0: &0xa5cfafe6660a8bf37eedf1a09dba633048da374c30b835668473689668f9ef57::global_config::GlobalConfig, arg1: &0x665188033384920a5bb5dcfb2ef21f54b4568d08b431718b97e02e5c184b92cc::account::AccountRequest, arg2: &mut MarketRegistry<T0>, arg3: vector<u8>, arg4: 0xa5cfafe6660a8bf37eedf1a09dba633048da374c30b835668473689668f9ef57::outcome::Outcome, arg5: &0x2::clock::Clock) {
        assert_keeper(arg0, arg1);
        let (v0, v1) = resolve_market_internal<T0>(arg2, arg3, arg4, false, 0x2::clock::timestamp_ms(arg5));
        0xa5cfafe6660a8bf37eedf1a09dba633048da374c30b835668473689668f9ef57::events::emit_market_resolved(0x2::object::uid_to_address(&arg2.id), v0, arg3, arg4, v1, 0x2::clock::timestamp_ms(arg5));
    }

    fun resolve_market_internal<T0>(arg0: &mut MarketRegistry<T0>, arg1: vector<u8>, arg2: 0xa5cfafe6660a8bf37eedf1a09dba633048da374c30b835668473689668f9ef57::outcome::Outcome, arg3: bool, arg4: u64) : (u64, u64) {
        if (contains_market<T0>(arg0, arg1)) {
            let v2 = market_pointer_internal<T0>(arg0, arg1);
            assert!(!v2.resolved, 4);
            let v3 = 0x665188033384920a5bb5dcfb2ef21f54b4568d08b431718b97e02e5c184b92cc::linked_table::remove<u64, Market>(&mut arg0.unresolved_markets, v2.key);
            v3.outcome = 0x1::option::some<0xa5cfafe6660a8bf37eedf1a09dba633048da374c30b835668473689668f9ef57::outcome::Outcome>(arg2);
            0x665188033384920a5bb5dcfb2ef21f54b4568d08b431718b97e02e5c184b92cc::linked_table::push_back<u64, Market>(&mut arg0.resolved_markets, v2.key, v3);
            0x2::table::borrow_mut<vector<u8>, MarketPointer>(&mut arg0.market_id_map, arg1).resolved = true;
            (v2.key, v3.unclaimed_count)
        } else {
            (create_market<T0>(arg0, arg1, 0x1::option::some<0xa5cfafe6660a8bf37eedf1a09dba633048da374c30b835668473689668f9ef57::outcome::Outcome>(arg2), 0, true, arg3, arg4), 0)
        }
    }

    public fun resolve_with_oracle<T0>(arg0: &0xa5cfafe6660a8bf37eedf1a09dba633048da374c30b835668473689668f9ef57::global_config::GlobalConfig, arg1: &0x665188033384920a5bb5dcfb2ef21f54b4568d08b431718b97e02e5c184b92cc::account::AccountRequest, arg2: &mut MarketRegistry<T0>, arg3: &0xd6fd5fa8be2f2cb3042fbb11f31f26c27280676f6a08681b16cbb5e4cb64f24e::oracle::Oracle, arg4: vector<u8>, arg5: &0x2::clock::Clock) {
        assert_keeper(arg0, arg1);
        let v0 = PriceSettlementKey{market_id: arg4};
        assert!(0x2::dynamic_field::exists_with_type<PriceSettlementKey, PriceSettlement>(&arg2.id, v0), 25);
        let v1 = *0x2::dynamic_field::borrow<PriceSettlementKey, PriceSettlement>(&arg2.id, v0);
        let v2 = 0xd6fd5fa8be2f2cb3042fbb11f31f26c27280676f6a08681b16cbb5e4cb64f24e::oracle::get_price_at_timestamp(arg3, v1.settle_ticker, 0x1::option::some<u64>(v1.settle_timestamp_ms));
        let v3 = if (price_meets_threshold(v2, 0x665188033384920a5bb5dcfb2ef21f54b4568d08b431718b97e02e5c184b92cc::float::from_scaled_val(v1.threshold), v1.comparison)) {
            0xa5cfafe6660a8bf37eedf1a09dba633048da374c30b835668473689668f9ef57::outcome::yes()
        } else {
            0xa5cfafe6660a8bf37eedf1a09dba633048da374c30b835668473689668f9ef57::outcome::no()
        };
        let (v4, v5) = resolve_market_internal<T0>(arg2, arg4, v3, false, 0x2::clock::timestamp_ms(arg5));
        0xa5cfafe6660a8bf37eedf1a09dba633048da374c30b835668473689668f9ef57::events::emit_market_resolved_by_oracle(0x2::object::uid_to_address(&arg2.id), v4, arg4, v3, v1.settle_ticker, v1.settle_timestamp_ms, 0x665188033384920a5bb5dcfb2ef21f54b4568d08b431718b97e02e5c184b92cc::float::to_scaled_val(v2), v1.threshold, v1.comparison, v5, 0x2::clock::timestamp_ms(arg5));
    }

    public fun resolved_market_back<T0>(arg0: &MarketRegistry<T0>) : 0x1::option::Option<u64> {
        *0x665188033384920a5bb5dcfb2ef21f54b4568d08b431718b97e02e5c184b92cc::linked_table::back<u64, Market>(&arg0.resolved_markets)
    }

    public fun resolved_market_count<T0>(arg0: &MarketRegistry<T0>) : u64 {
        0x665188033384920a5bb5dcfb2ef21f54b4568d08b431718b97e02e5c184b92cc::linked_table::length<u64, Market>(&arg0.resolved_markets)
    }

    public fun resolved_market_front<T0>(arg0: &MarketRegistry<T0>) : 0x1::option::Option<u64> {
        *0x665188033384920a5bb5dcfb2ef21f54b4568d08b431718b97e02e5c184b92cc::linked_table::front<u64, Market>(&arg0.resolved_markets)
    }

    public fun resolved_market_next<T0>(arg0: &MarketRegistry<T0>, arg1: u64) : 0x1::option::Option<u64> {
        *0x665188033384920a5bb5dcfb2ef21f54b4568d08b431718b97e02e5c184b92cc::linked_table::next<u64, Market>(&arg0.resolved_markets, arg1)
    }

    public fun resolved_market_prev<T0>(arg0: &MarketRegistry<T0>, arg1: u64) : 0x1::option::Option<u64> {
        *0x665188033384920a5bb5dcfb2ef21f54b4568d08b431718b97e02e5c184b92cc::linked_table::prev<u64, Market>(&arg0.resolved_markets, arg1)
    }

    public fun resolved_markets<T0>(arg0: &MarketRegistry<T0>) : &0x665188033384920a5bb5dcfb2ef21f54b4568d08b431718b97e02e5c184b92cc::linked_table::LinkedTable<u64, Market> {
        &arg0.resolved_markets
    }

    public fun self_cancel_close<T0>(arg0: &0xa5cfafe6660a8bf37eedf1a09dba633048da374c30b835668473689668f9ef57::global_config::GlobalConfig, arg1: &mut MarketRegistry<T0>, arg2: &mut 0xe308bd40bd81aa42b9245e4b51b3fe63801c77c78a76be4ce5902aae549f7221::account::AccountRegistry, arg3: &0x665188033384920a5bb5dcfb2ef21f54b4568d08b431718b97e02e5c184b92cc::account::AccountRequest, arg4: u64, arg5: &0x2::clock::Clock) {
        0xa5cfafe6660a8bf37eedf1a09dba633048da374c30b835668473689668f9ef57::global_config::assert_version(arg0);
        assert_account_position_perm<T0>(arg1, arg2, arg3, arg4, 0xa5cfafe6660a8bf37eedf1a09dba633048da374c30b835668473689668f9ef57::account_data::perm_cancel_order(), arg5);
        self_cancel_close_internal<T0>(arg1, arg2, arg4, arg5);
    }

    fun self_cancel_close_internal<T0>(arg0: &mut MarketRegistry<T0>, arg1: &mut 0xe308bd40bd81aa42b9245e4b51b3fe63801c77c78a76be4ce5902aae549f7221::account::AccountRegistry, arg2: u64, arg3: &0x2::clock::Clock) {
        let v0 = borrow_position<T0>(arg0, arg2);
        assert!(0xa5cfafe6660a8bf37eedf1a09dba633048da374c30b835668473689668f9ef57::position::has_pending_close(v0), 1);
        let v1 = 0xa5cfafe6660a8bf37eedf1a09dba633048da374c30b835668473689668f9ef57::position::close_order_id(v0);
        let v2 = *0x1::option::borrow<u64>(&v1);
        let v3 = 0xa5cfafe6660a8bf37eedf1a09dba633048da374c30b835668473689668f9ef57::position::account_id(v0);
        let v4 = 0xa5cfafe6660a8bf37eedf1a09dba633048da374c30b835668473689668f9ef57::position::market_id(v0);
        let v5 = 0xa5cfafe6660a8bf37eedf1a09dba633048da374c30b835668473689668f9ef57::position::selection(v0);
        let v6 = market_key_internal<T0>(arg0, v4);
        let v7 = borrow_order<T0>(arg0, v2);
        assert!(0xa5cfafe6660a8bf37eedf1a09dba633048da374c30b835668473689668f9ef57::order::is_close(v7), 1);
        let v8 = 0x2::clock::timestamp_ms(arg3);
        assert!(v8 >= 0xa5cfafe6660a8bf37eedf1a09dba633048da374c30b835668473689668f9ef57::order::self_cancel_after_ts(v7), 17);
        assert!(v8 >= 0xa5cfafe6660a8bf37eedf1a09dba633048da374c30b835668473689668f9ef57::order::expiry_ts(v7) + 300000, 19);
        let v9 = borrow_position_mut<T0>(arg0, arg2);
        0xa5cfafe6660a8bf37eedf1a09dba633048da374c30b835668473689668f9ef57::position::cancel_close(v9);
        0xa5cfafe6660a8bf37eedf1a09dba633048da374c30b835668473689668f9ef57::account_data::remove_order(arg1, v3, v6, v2);
        remove_and_drop_order<T0>(arg0, v2);
        0xa5cfafe6660a8bf37eedf1a09dba633048da374c30b835668473689668f9ef57::events::emit_close_cancelled(0x2::object::uid_to_address(&arg0.id), v2, v3, arg2, v6, v4, v5, true, v8);
    }

    public fun self_cancel_order<T0>(arg0: &0xa5cfafe6660a8bf37eedf1a09dba633048da374c30b835668473689668f9ef57::global_config::GlobalConfig, arg1: &mut MarketRegistry<T0>, arg2: &mut 0xe308bd40bd81aa42b9245e4b51b3fe63801c77c78a76be4ce5902aae549f7221::account::AccountRegistry, arg3: &0x665188033384920a5bb5dcfb2ef21f54b4568d08b431718b97e02e5c184b92cc::account::AccountRequest, arg4: u64, arg5: &0x2::clock::Clock) {
        0xa5cfafe6660a8bf37eedf1a09dba633048da374c30b835668473689668f9ef57::global_config::assert_version(arg0);
        let v0 = assert_account_order_perm<T0>(arg1, arg2, arg3, arg4, 0xa5cfafe6660a8bf37eedf1a09dba633048da374c30b835668473689668f9ef57::account_data::perm_cancel_order(), arg5);
        let v1 = 0x2::clock::timestamp_ms(arg5);
        let v2 = borrow_order<T0>(arg1, arg4);
        assert!(0xa5cfafe6660a8bf37eedf1a09dba633048da374c30b835668473689668f9ef57::order::is_open(v2), 1);
        assert!(v1 >= 0xa5cfafe6660a8bf37eedf1a09dba633048da374c30b835668473689668f9ef57::order::self_cancel_after_ts(v2), 17);
        assert!(v1 >= 0xa5cfafe6660a8bf37eedf1a09dba633048da374c30b835668473689668f9ef57::order::expiry_ts(v2) + 300000, 19);
        let v3 = 0xa5cfafe6660a8bf37eedf1a09dba633048da374c30b835668473689668f9ef57::order::market_id(v2);
        let v4 = 0xa5cfafe6660a8bf37eedf1a09dba633048da374c30b835668473689668f9ef57::order::selection(v2);
        let v5 = market_key_internal<T0>(arg1, v3);
        let v6 = 0xa5cfafe6660a8bf37eedf1a09dba633048da374c30b835668473689668f9ef57::order::max_spend(v2);
        0xe308bd40bd81aa42b9245e4b51b3fe63801c77c78a76be4ce5902aae549f7221::account::put<T0, 0xa5cfafe6660a8bf37eedf1a09dba633048da374c30b835668473689668f9ef57::account_data::WaterXPrediction>(arg2, v0, 0x2::balance::split<T0>(&mut arg1.balance, v6), 0xa5cfafe6660a8bf37eedf1a09dba633048da374c30b835668473689668f9ef57::account_data::witness());
        0xa5cfafe6660a8bf37eedf1a09dba633048da374c30b835668473689668f9ef57::account_data::remove_order(arg2, v0, v5, arg4);
        remove_and_drop_order<T0>(arg1, arg4);
        0xa5cfafe6660a8bf37eedf1a09dba633048da374c30b835668473689668f9ef57::events::emit_order_cancelled(0x2::object::uid_to_address(&arg1.id), arg4, v0, v5, v3, v4, v6, true, v1);
    }

    public fun set_min_reserve<T0>(arg0: &0xa5cfafe6660a8bf37eedf1a09dba633048da374c30b835668473689668f9ef57::admin::AdminCap, arg1: &mut MarketRegistry<T0>, arg2: u64) {
        arg1.min_reserve = arg2;
        0xa5cfafe6660a8bf37eedf1a09dba633048da374c30b835668473689668f9ef57::events::emit_min_reserve_updated(0x2::object::uid_to_address(&arg1.id), arg1.min_reserve, arg2);
    }

    public fun set_order_cancel_cooldown_ms<T0>(arg0: &0xa5cfafe6660a8bf37eedf1a09dba633048da374c30b835668473689668f9ef57::admin::AdminCap, arg1: &mut MarketRegistry<T0>, arg2: u64) {
        arg1.order_cancel_cooldown_ms = arg2;
        0xa5cfafe6660a8bf37eedf1a09dba633048da374c30b835668473689668f9ef57::events::emit_order_cancel_cooldown_updated(0x2::object::uid_to_address(&arg1.id), arg1.order_cancel_cooldown_ms, arg2);
    }

    public fun set_price_settlement<T0>(arg0: &0xa5cfafe6660a8bf37eedf1a09dba633048da374c30b835668473689668f9ef57::admin::AdminCap, arg1: &mut MarketRegistry<T0>, arg2: vector<u8>, arg3: 0x1::string::String, arg4: u64, arg5: u128, arg6: u8, arg7: &0x2::clock::Clock) {
        assert!(is_valid_comparison(arg6), 26);
        let v0 = PriceSettlement{
            settle_ticker       : arg3,
            settle_timestamp_ms : arg4,
            threshold           : arg5,
            comparison          : arg6,
        };
        let v1 = PriceSettlementKey{market_id: arg2};
        if (0x2::dynamic_field::exists_with_type<PriceSettlementKey, PriceSettlement>(&arg1.id, v1)) {
            *0x2::dynamic_field::borrow_mut<PriceSettlementKey, PriceSettlement>(&mut arg1.id, v1) = v0;
        } else {
            0x2::dynamic_field::add<PriceSettlementKey, PriceSettlement>(&mut arg1.id, v1, v0);
        };
        0xa5cfafe6660a8bf37eedf1a09dba633048da374c30b835668473689668f9ef57::events::emit_price_settlement_set(0x2::object::uid_to_address(&arg1.id), arg2, arg3, arg4, arg5, arg6, 0x2::clock::timestamp_ms(arg7));
    }

    fun settle_position_to_wxa_internal<T0>(arg0: &mut MarketRegistry<T0>, arg1: &mut 0xe308bd40bd81aa42b9245e4b51b3fe63801c77c78a76be4ce5902aae549f7221::account::AccountRegistry, arg2: 0x2::object::ID, arg3: u64, arg4: u64) {
        assert!(contains_position<T0>(arg0, arg3), 1);
        let v0 = 0xa5cfafe6660a8bf37eedf1a09dba633048da374c30b835668473689668f9ef57::position::market_id(borrow_position<T0>(arg0, arg3));
        assert!(contains_market<T0>(arg0, v0), 3);
        let v1 = market_key_internal<T0>(arg0, v0);
        let v2 = borrow_market_by_id<T0>(arg0, v0);
        if (0x1::option::is_none<0xa5cfafe6660a8bf37eedf1a09dba633048da374c30b835668473689668f9ef57::outcome::Outcome>(&v2.outcome)) {
            abort 3
        };
        let v3 = *0x1::option::borrow<0xa5cfafe6660a8bf37eedf1a09dba633048da374c30b835668473689668f9ef57::outcome::Outcome>(&v2.outcome);
        let v4 = borrow_position<T0>(arg0, arg3);
        assert!(!0xa5cfafe6660a8bf37eedf1a09dba633048da374c30b835668473689668f9ef57::position::has_pending_close(v4), 1);
        let v5 = 0xa5cfafe6660a8bf37eedf1a09dba633048da374c30b835668473689668f9ef57::position::selection(v4);
        let v6 = 0xa5cfafe6660a8bf37eedf1a09dba633048da374c30b835668473689668f9ef57::position::filled_shares(v4);
        let v7 = 0xa5cfafe6660a8bf37eedf1a09dba633048da374c30b835668473689668f9ef57::position::filled_cost(v4);
        let v8 = if (0xa5cfafe6660a8bf37eedf1a09dba633048da374c30b835668473689668f9ef57::outcome::is_invalid(v3)) {
            v7
        } else if (0xa5cfafe6660a8bf37eedf1a09dba633048da374c30b835668473689668f9ef57::outcome::is_yes(v3)) {
            if (0xa5cfafe6660a8bf37eedf1a09dba633048da374c30b835668473689668f9ef57::position::selection_is_yes(v5)) {
                v6
            } else {
                0
            }
        } else if (0xa5cfafe6660a8bf37eedf1a09dba633048da374c30b835668473689668f9ef57::position::selection_is_no(v5)) {
            v6
        } else {
            0
        };
        if (v8 > 0) {
            0xe308bd40bd81aa42b9245e4b51b3fe63801c77c78a76be4ce5902aae549f7221::account::put<T0, 0xa5cfafe6660a8bf37eedf1a09dba633048da374c30b835668473689668f9ef57::account_data::WaterXPrediction>(arg1, arg2, 0x2::balance::split<T0>(&mut arg0.balance, v8), 0xa5cfafe6660a8bf37eedf1a09dba633048da374c30b835668473689668f9ef57::account_data::witness());
        };
        0xa5cfafe6660a8bf37eedf1a09dba633048da374c30b835668473689668f9ef57::account_data::remove_position(arg1, arg2, v1, arg3);
        decrement_market_exposure<T0>(arg0, v0, v5, v6, v7);
        remove_and_drop_position<T0>(arg0, arg3);
        0xa5cfafe6660a8bf37eedf1a09dba633048da374c30b835668473689668f9ef57::events::emit_position_claimed(0x2::object::uid_to_address(&arg0.id), arg2, arg3, v1, v0, v5, v3, v6, v7, v8, arg4);
    }

    public fun split_position<T0>(arg0: &0xa5cfafe6660a8bf37eedf1a09dba633048da374c30b835668473689668f9ef57::global_config::GlobalConfig, arg1: &mut MarketRegistry<T0>, arg2: &mut 0xe308bd40bd81aa42b9245e4b51b3fe63801c77c78a76be4ce5902aae549f7221::account::AccountRegistry, arg3: &0x665188033384920a5bb5dcfb2ef21f54b4568d08b431718b97e02e5c184b92cc::account::AccountRequest, arg4: u64, arg5: 0x2::object::ID, arg6: u64, arg7: &0x2::clock::Clock, arg8: &mut 0x2::tx_context::TxContext) : u64 {
        0xa5cfafe6660a8bf37eedf1a09dba633048da374c30b835668473689668f9ef57::global_config::assert_version(arg0);
        assert!(0xe308bd40bd81aa42b9245e4b51b3fe63801c77c78a76be4ce5902aae549f7221::account::has_account(arg2, arg5), 16);
        let v0 = assert_account_position_perm<T0>(arg1, arg2, arg3, arg4, 0xa5cfafe6660a8bf37eedf1a09dba633048da374c30b835668473689668f9ef57::account_data::perm_transfer_position(), arg7);
        let v1 = 0x665188033384920a5bb5dcfb2ef21f54b4568d08b431718b97e02e5c184b92cc::account::request_address(arg3);
        if (!0xe308bd40bd81aa42b9245e4b51b3fe63801c77c78a76be4ce5902aae549f7221::account::is_account_owner(arg2, v0, v1)) {
            assert!(0xa5cfafe6660a8bf37eedf1a09dba633048da374c30b835668473689668f9ef57::global_config::is_transfer_operator(arg0, v1), 27);
        };
        let v2 = borrow_position<T0>(arg1, arg4);
        assert!(!0xa5cfafe6660a8bf37eedf1a09dba633048da374c30b835668473689668f9ef57::position::has_pending_close(v2), 1);
        assert!(arg6 > 0 && arg6 < 0xa5cfafe6660a8bf37eedf1a09dba633048da374c30b835668473689668f9ef57::position::filled_shares(v2), 24);
        let v3 = 0xa5cfafe6660a8bf37eedf1a09dba633048da374c30b835668473689668f9ef57::position::market_id(v2);
        let v4 = 0xa5cfafe6660a8bf37eedf1a09dba633048da374c30b835668473689668f9ef57::position::selection(v2);
        let v5 = market_key_internal<T0>(arg1, v3);
        let v6 = arg1.next_position_id;
        arg1.next_position_id = v6 + 1;
        let v7 = borrow_position_mut<T0>(arg1, arg4);
        let (v8, v9, v10, v11) = 0xa5cfafe6660a8bf37eedf1a09dba633048da374c30b835668473689668f9ef57::position::split(v7, arg5, arg6);
        0x665188033384920a5bb5dcfb2ef21f54b4568d08b431718b97e02e5c184b92cc::linked_table::push_back<u64, 0xa5cfafe6660a8bf37eedf1a09dba633048da374c30b835668473689668f9ef57::position::Position>(&mut arg1.positions, v6, v8);
        0xa5cfafe6660a8bf37eedf1a09dba633048da374c30b835668473689668f9ef57::account_data::add_position(arg2, arg5, v5, v6, arg8);
        increment_market_unclaimed_count<T0>(arg1, v3);
        0xa5cfafe6660a8bf37eedf1a09dba633048da374c30b835668473689668f9ef57::events::emit_position_split(0x2::object::uid_to_address(&arg1.id), arg4, v6, v0, arg5, v5, v3, v4, arg6, v9, v10, v11, 0x2::clock::timestamp_ms(arg7));
        v6
    }

    public fun transfer_position<T0>(arg0: &0xa5cfafe6660a8bf37eedf1a09dba633048da374c30b835668473689668f9ef57::global_config::GlobalConfig, arg1: &mut MarketRegistry<T0>, arg2: &mut 0xe308bd40bd81aa42b9245e4b51b3fe63801c77c78a76be4ce5902aae549f7221::account::AccountRegistry, arg3: &0x665188033384920a5bb5dcfb2ef21f54b4568d08b431718b97e02e5c184b92cc::account::AccountRequest, arg4: u64, arg5: 0x2::object::ID, arg6: &0x2::clock::Clock, arg7: &mut 0x2::tx_context::TxContext) {
        0xa5cfafe6660a8bf37eedf1a09dba633048da374c30b835668473689668f9ef57::global_config::assert_version(arg0);
        assert!(0xe308bd40bd81aa42b9245e4b51b3fe63801c77c78a76be4ce5902aae549f7221::account::has_account(arg2, arg5), 16);
        let v0 = assert_account_position_perm<T0>(arg1, arg2, arg3, arg4, 0xa5cfafe6660a8bf37eedf1a09dba633048da374c30b835668473689668f9ef57::account_data::perm_transfer_position(), arg6);
        let v1 = 0x665188033384920a5bb5dcfb2ef21f54b4568d08b431718b97e02e5c184b92cc::account::request_address(arg3);
        if (!0xe308bd40bd81aa42b9245e4b51b3fe63801c77c78a76be4ce5902aae549f7221::account::is_account_owner(arg2, v0, v1)) {
            assert!(0xa5cfafe6660a8bf37eedf1a09dba633048da374c30b835668473689668f9ef57::global_config::is_transfer_operator(arg0, v1), 27);
        };
        if (v0 == arg5) {
            return
        };
        let v2 = borrow_position<T0>(arg1, arg4);
        assert!(!0xa5cfafe6660a8bf37eedf1a09dba633048da374c30b835668473689668f9ef57::position::has_pending_close(v2), 1);
        let v3 = 0xa5cfafe6660a8bf37eedf1a09dba633048da374c30b835668473689668f9ef57::position::market_id(v2);
        let v4 = 0xa5cfafe6660a8bf37eedf1a09dba633048da374c30b835668473689668f9ef57::position::filled_cost(v2);
        let v5 = market_key_internal<T0>(arg1, v3);
        0xa5cfafe6660a8bf37eedf1a09dba633048da374c30b835668473689668f9ef57::account_data::remove_position(arg2, v0, v5, arg4);
        0xa5cfafe6660a8bf37eedf1a09dba633048da374c30b835668473689668f9ef57::account_data::add_position(arg2, arg5, v5, arg4, arg7);
        let v6 = borrow_position_mut<T0>(arg1, arg4);
        0xa5cfafe6660a8bf37eedf1a09dba633048da374c30b835668473689668f9ef57::position::transfer(v6, arg5);
        0xa5cfafe6660a8bf37eedf1a09dba633048da374c30b835668473689668f9ef57::events::emit_position_transferred(0x2::object::uid_to_address(&arg1.id), arg4, v0, arg5, v5, v3, 0xa5cfafe6660a8bf37eedf1a09dba633048da374c30b835668473689668f9ef57::position::selection(v2), 0xa5cfafe6660a8bf37eedf1a09dba633048da374c30b835668473689668f9ef57::position::filled_shares(v2), v4, 0x2::clock::timestamp_ms(arg6));
    }

    public fun unpause_market<T0>(arg0: &0xa5cfafe6660a8bf37eedf1a09dba633048da374c30b835668473689668f9ef57::admin::AdminCap, arg1: &mut MarketRegistry<T0>, arg2: vector<u8>) {
        if (!contains_market<T0>(arg1, arg2)) {
            return
        };
        let v0 = market_key_internal<T0>(arg1, arg2);
        if (0x2::table::contains<u64, bool>(&arg1.paused_markets, v0)) {
            0x2::table::remove<u64, bool>(&mut arg1.paused_markets, v0);
            0xa5cfafe6660a8bf37eedf1a09dba633048da374c30b835668473689668f9ef57::events::emit_market_unpaused(0x2::object::uid_to_address(&arg1.id), v0, arg2);
        };
    }

    public fun unresolved_market_back<T0>(arg0: &MarketRegistry<T0>) : 0x1::option::Option<u64> {
        *0x665188033384920a5bb5dcfb2ef21f54b4568d08b431718b97e02e5c184b92cc::linked_table::back<u64, Market>(&arg0.unresolved_markets)
    }

    public fun unresolved_market_count<T0>(arg0: &MarketRegistry<T0>) : u64 {
        0x665188033384920a5bb5dcfb2ef21f54b4568d08b431718b97e02e5c184b92cc::linked_table::length<u64, Market>(&arg0.unresolved_markets)
    }

    public fun unresolved_market_front<T0>(arg0: &MarketRegistry<T0>) : 0x1::option::Option<u64> {
        *0x665188033384920a5bb5dcfb2ef21f54b4568d08b431718b97e02e5c184b92cc::linked_table::front<u64, Market>(&arg0.unresolved_markets)
    }

    public fun unresolved_market_next<T0>(arg0: &MarketRegistry<T0>, arg1: u64) : 0x1::option::Option<u64> {
        *0x665188033384920a5bb5dcfb2ef21f54b4568d08b431718b97e02e5c184b92cc::linked_table::next<u64, Market>(&arg0.unresolved_markets, arg1)
    }

    public fun unresolved_market_prev<T0>(arg0: &MarketRegistry<T0>, arg1: u64) : 0x1::option::Option<u64> {
        *0x665188033384920a5bb5dcfb2ef21f54b4568d08b431718b97e02e5c184b92cc::linked_table::prev<u64, Market>(&arg0.unresolved_markets, arg1)
    }

    public fun unresolved_markets<T0>(arg0: &MarketRegistry<T0>) : &0x665188033384920a5bb5dcfb2ef21f54b4568d08b431718b97e02e5c184b92cc::linked_table::LinkedTable<u64, Market> {
        &arg0.unresolved_markets
    }

    // decompiled from Move bytecode v7
}

