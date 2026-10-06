module 0xa5cfafe6660a8bf37eedf1a09dba633048da374c30b835668473689668f9ef57::view {
    struct RegistryView has copy, drop {
        balance: u64,
        min_reserve: u64,
        order_cancel_cooldown_ms: u64,
        next_order_id: u64,
        next_position_id: u64,
        order_count: u64,
        position_count: u64,
        unresolved_market_count: u64,
        resolved_market_count: u64,
    }

    struct OrderView has copy, drop {
        order_id: u64,
        kind: 0xa5cfafe6660a8bf37eedf1a09dba633048da374c30b835668473689668f9ef57::order::OrderKind,
        account_id: 0x2::object::ID,
        receiver_account_id: 0x2::object::ID,
        market_id: vector<u8>,
        selection: 0xa5cfafe6660a8bf37eedf1a09dba633048da374c30b835668473689668f9ef57::position::Selection,
        position_id: 0x1::option::Option<u64>,
        max_spend: u64,
        min_shares: u64,
        price_cap: u64,
        min_proceeds: u64,
        expiry_ts: u64,
        self_cancel_after_ts: u64,
        created_ts: u64,
        by_admin: bool,
    }

    struct PositionView has copy, drop {
        position_id: u64,
        account_id: 0x2::object::ID,
        market_id: vector<u8>,
        selection: 0xa5cfafe6660a8bf37eedf1a09dba633048da374c30b835668473689668f9ef57::position::Selection,
        status: 0xa5cfafe6660a8bf37eedf1a09dba633048da374c30b835668473689668f9ef57::position::Status,
        filled_shares: u64,
        filled_cost: u64,
        opened_ts: u64,
        payout: u64,
        close_order_id: 0x1::option::Option<u64>,
        close_min_proceeds: u64,
        close_expiry_ts: u64,
        close_self_cancel_after_ts: u64,
    }

    struct MarketView has copy, drop {
        market_key: u64,
        market_id: vector<u8>,
        resolved: bool,
        paused: bool,
        outcome: 0x1::option::Option<0xa5cfafe6660a8bf37eedf1a09dba633048da374c30b835668473689668f9ef57::outcome::Outcome>,
        unclaimed_count: u64,
        yes_shares: u64,
        yes_cost: u64,
        no_shares: u64,
        no_cost: u64,
    }

    struct AccountDataView has drop {
        account_id: 0x2::object::ID,
        has_data: bool,
        order_count: u64,
        position_count: u64,
        order_front: 0x1::option::Option<u64>,
        order_back: 0x1::option::Option<u64>,
        position_front: 0x1::option::Option<u64>,
        position_back: 0x1::option::Option<u64>,
    }

    public fun order<T0>(arg0: &0xa5cfafe6660a8bf37eedf1a09dba633048da374c30b835668473689668f9ef57::waterx_prediction::MarketRegistry<T0>, arg1: u64) : OrderView {
        OrderView{
            order_id             : 0xa5cfafe6660a8bf37eedf1a09dba633048da374c30b835668473689668f9ef57::waterx_prediction::order_id<T0>(arg0, arg1),
            kind                 : 0xa5cfafe6660a8bf37eedf1a09dba633048da374c30b835668473689668f9ef57::waterx_prediction::order_kind<T0>(arg0, arg1),
            account_id           : 0xa5cfafe6660a8bf37eedf1a09dba633048da374c30b835668473689668f9ef57::waterx_prediction::order_account_id<T0>(arg0, arg1),
            receiver_account_id  : 0xa5cfafe6660a8bf37eedf1a09dba633048da374c30b835668473689668f9ef57::waterx_prediction::order_receiver_account_id<T0>(arg0, arg1),
            market_id            : 0xa5cfafe6660a8bf37eedf1a09dba633048da374c30b835668473689668f9ef57::waterx_prediction::order_market_id<T0>(arg0, arg1),
            selection            : 0xa5cfafe6660a8bf37eedf1a09dba633048da374c30b835668473689668f9ef57::waterx_prediction::order_selection<T0>(arg0, arg1),
            position_id          : 0xa5cfafe6660a8bf37eedf1a09dba633048da374c30b835668473689668f9ef57::waterx_prediction::order_position_id<T0>(arg0, arg1),
            max_spend            : 0xa5cfafe6660a8bf37eedf1a09dba633048da374c30b835668473689668f9ef57::waterx_prediction::order_max_spend<T0>(arg0, arg1),
            min_shares           : 0xa5cfafe6660a8bf37eedf1a09dba633048da374c30b835668473689668f9ef57::waterx_prediction::order_min_shares<T0>(arg0, arg1),
            price_cap            : 0xa5cfafe6660a8bf37eedf1a09dba633048da374c30b835668473689668f9ef57::waterx_prediction::order_price_cap<T0>(arg0, arg1),
            min_proceeds         : 0xa5cfafe6660a8bf37eedf1a09dba633048da374c30b835668473689668f9ef57::waterx_prediction::order_min_proceeds<T0>(arg0, arg1),
            expiry_ts            : 0xa5cfafe6660a8bf37eedf1a09dba633048da374c30b835668473689668f9ef57::waterx_prediction::order_expiry<T0>(arg0, arg1),
            self_cancel_after_ts : 0xa5cfafe6660a8bf37eedf1a09dba633048da374c30b835668473689668f9ef57::waterx_prediction::order_self_cancel_after_ts<T0>(arg0, arg1),
            created_ts           : 0xa5cfafe6660a8bf37eedf1a09dba633048da374c30b835668473689668f9ef57::waterx_prediction::order_created_ts<T0>(arg0, arg1),
            by_admin             : 0xa5cfafe6660a8bf37eedf1a09dba633048da374c30b835668473689668f9ef57::waterx_prediction::order_is_by_admin<T0>(arg0, arg1),
        }
    }

    public fun position<T0>(arg0: &0xa5cfafe6660a8bf37eedf1a09dba633048da374c30b835668473689668f9ef57::waterx_prediction::MarketRegistry<T0>, arg1: u64) : PositionView {
        let (v0, v1) = 0xa5cfafe6660a8bf37eedf1a09dba633048da374c30b835668473689668f9ef57::waterx_prediction::position_filled<T0>(arg0, arg1);
        PositionView{
            position_id                : arg1,
            account_id                 : 0xa5cfafe6660a8bf37eedf1a09dba633048da374c30b835668473689668f9ef57::waterx_prediction::position_account_id<T0>(arg0, arg1),
            market_id                  : 0xa5cfafe6660a8bf37eedf1a09dba633048da374c30b835668473689668f9ef57::waterx_prediction::position_market_id<T0>(arg0, arg1),
            selection                  : 0xa5cfafe6660a8bf37eedf1a09dba633048da374c30b835668473689668f9ef57::waterx_prediction::position_selection<T0>(arg0, arg1),
            status                     : 0xa5cfafe6660a8bf37eedf1a09dba633048da374c30b835668473689668f9ef57::waterx_prediction::position_status<T0>(arg0, arg1),
            filled_shares              : v0,
            filled_cost                : v1,
            opened_ts                  : 0xa5cfafe6660a8bf37eedf1a09dba633048da374c30b835668473689668f9ef57::waterx_prediction::position_opened_ts<T0>(arg0, arg1),
            payout                     : 0xa5cfafe6660a8bf37eedf1a09dba633048da374c30b835668473689668f9ef57::waterx_prediction::position_payout<T0>(arg0, arg1),
            close_order_id             : 0xa5cfafe6660a8bf37eedf1a09dba633048da374c30b835668473689668f9ef57::waterx_prediction::position_close_order_id<T0>(arg0, arg1),
            close_min_proceeds         : 0xa5cfafe6660a8bf37eedf1a09dba633048da374c30b835668473689668f9ef57::waterx_prediction::position_close_min_proceeds<T0>(arg0, arg1),
            close_expiry_ts            : 0xa5cfafe6660a8bf37eedf1a09dba633048da374c30b835668473689668f9ef57::waterx_prediction::position_close_expiry<T0>(arg0, arg1),
            close_self_cancel_after_ts : 0xa5cfafe6660a8bf37eedf1a09dba633048da374c30b835668473689668f9ef57::waterx_prediction::position_close_self_cancel_after_ts<T0>(arg0, arg1),
        }
    }

    public fun account(arg0: &0xe308bd40bd81aa42b9245e4b51b3fe63801c77c78a76be4ce5902aae549f7221::account::AccountRegistry, arg1: 0x2::object::ID) : AccountDataView {
        if (!0xa5cfafe6660a8bf37eedf1a09dba633048da374c30b835668473689668f9ef57::account_data::has_account(arg0, arg1)) {
            return AccountDataView{
                account_id     : arg1,
                has_data       : false,
                order_count    : 0,
                position_count : 0,
                order_front    : 0x1::option::none<u64>(),
                order_back     : 0x1::option::none<u64>(),
                position_front : 0x1::option::none<u64>(),
                position_back  : 0x1::option::none<u64>(),
            }
        };
        let v0 = 0xa5cfafe6660a8bf37eedf1a09dba633048da374c30b835668473689668f9ef57::account_data::borrow_account(arg0, arg1);
        AccountDataView{
            account_id     : arg1,
            has_data       : true,
            order_count    : 0xa5cfafe6660a8bf37eedf1a09dba633048da374c30b835668473689668f9ef57::account_data::order_count(v0),
            position_count : 0xa5cfafe6660a8bf37eedf1a09dba633048da374c30b835668473689668f9ef57::account_data::position_count(v0),
            order_front    : 0xa5cfafe6660a8bf37eedf1a09dba633048da374c30b835668473689668f9ef57::account_data::order_front(v0),
            order_back     : 0xa5cfafe6660a8bf37eedf1a09dba633048da374c30b835668473689668f9ef57::account_data::order_back(v0),
            position_front : 0xa5cfafe6660a8bf37eedf1a09dba633048da374c30b835668473689668f9ef57::account_data::position_front(v0),
            position_back  : 0xa5cfafe6660a8bf37eedf1a09dba633048da374c30b835668473689668f9ef57::account_data::position_back(v0),
        }
    }

    public fun account_market_order_cursor(arg0: &0xe308bd40bd81aa42b9245e4b51b3fe63801c77c78a76be4ce5902aae549f7221::account::AccountRegistry, arg1: 0x2::object::ID, arg2: u64) : (u64, 0x1::option::Option<u64>, 0x1::option::Option<u64>) {
        if (!0xa5cfafe6660a8bf37eedf1a09dba633048da374c30b835668473689668f9ef57::account_data::has_account(arg0, arg1)) {
            return (0, 0x1::option::none<u64>(), 0x1::option::none<u64>())
        };
        let v0 = 0xa5cfafe6660a8bf37eedf1a09dba633048da374c30b835668473689668f9ef57::account_data::borrow_account(arg0, arg1);
        (0xa5cfafe6660a8bf37eedf1a09dba633048da374c30b835668473689668f9ef57::account_data::market_order_count(v0, arg2), 0xa5cfafe6660a8bf37eedf1a09dba633048da374c30b835668473689668f9ef57::account_data::market_order_front(v0, arg2), 0xa5cfafe6660a8bf37eedf1a09dba633048da374c30b835668473689668f9ef57::account_data::market_order_back(v0, arg2))
    }

    public fun account_market_order_next(arg0: &0xe308bd40bd81aa42b9245e4b51b3fe63801c77c78a76be4ce5902aae549f7221::account::AccountRegistry, arg1: 0x2::object::ID, arg2: u64, arg3: u64) : 0x1::option::Option<u64> {
        if (!0xa5cfafe6660a8bf37eedf1a09dba633048da374c30b835668473689668f9ef57::account_data::has_account(arg0, arg1)) {
            return 0x1::option::none<u64>()
        };
        0xa5cfafe6660a8bf37eedf1a09dba633048da374c30b835668473689668f9ef57::account_data::market_order_next(0xa5cfafe6660a8bf37eedf1a09dba633048da374c30b835668473689668f9ef57::account_data::borrow_account(arg0, arg1), arg2, arg3)
    }

    public fun account_market_position_cursor(arg0: &0xe308bd40bd81aa42b9245e4b51b3fe63801c77c78a76be4ce5902aae549f7221::account::AccountRegistry, arg1: 0x2::object::ID, arg2: u64) : (u64, 0x1::option::Option<u64>, 0x1::option::Option<u64>) {
        if (!0xa5cfafe6660a8bf37eedf1a09dba633048da374c30b835668473689668f9ef57::account_data::has_account(arg0, arg1)) {
            return (0, 0x1::option::none<u64>(), 0x1::option::none<u64>())
        };
        let v0 = 0xa5cfafe6660a8bf37eedf1a09dba633048da374c30b835668473689668f9ef57::account_data::borrow_account(arg0, arg1);
        (0xa5cfafe6660a8bf37eedf1a09dba633048da374c30b835668473689668f9ef57::account_data::market_position_count(v0, arg2), 0xa5cfafe6660a8bf37eedf1a09dba633048da374c30b835668473689668f9ef57::account_data::market_position_front(v0, arg2), 0xa5cfafe6660a8bf37eedf1a09dba633048da374c30b835668473689668f9ef57::account_data::market_position_back(v0, arg2))
    }

    public fun account_market_position_next(arg0: &0xe308bd40bd81aa42b9245e4b51b3fe63801c77c78a76be4ce5902aae549f7221::account::AccountRegistry, arg1: 0x2::object::ID, arg2: u64, arg3: u64) : 0x1::option::Option<u64> {
        if (!0xa5cfafe6660a8bf37eedf1a09dba633048da374c30b835668473689668f9ef57::account_data::has_account(arg0, arg1)) {
            return 0x1::option::none<u64>()
        };
        0xa5cfafe6660a8bf37eedf1a09dba633048da374c30b835668473689668f9ef57::account_data::market_position_next(0xa5cfafe6660a8bf37eedf1a09dba633048da374c30b835668473689668f9ef57::account_data::borrow_account(arg0, arg1), arg2, arg3)
    }

    public fun account_order_cursor(arg0: &0xe308bd40bd81aa42b9245e4b51b3fe63801c77c78a76be4ce5902aae549f7221::account::AccountRegistry, arg1: 0x2::object::ID) : (u64, 0x1::option::Option<u64>, 0x1::option::Option<u64>) {
        if (!0xa5cfafe6660a8bf37eedf1a09dba633048da374c30b835668473689668f9ef57::account_data::has_account(arg0, arg1)) {
            return (0, 0x1::option::none<u64>(), 0x1::option::none<u64>())
        };
        let v0 = 0xa5cfafe6660a8bf37eedf1a09dba633048da374c30b835668473689668f9ef57::account_data::borrow_account(arg0, arg1);
        (0xa5cfafe6660a8bf37eedf1a09dba633048da374c30b835668473689668f9ef57::account_data::order_count(v0), 0xa5cfafe6660a8bf37eedf1a09dba633048da374c30b835668473689668f9ef57::account_data::order_front(v0), 0xa5cfafe6660a8bf37eedf1a09dba633048da374c30b835668473689668f9ef57::account_data::order_back(v0))
    }

    public fun account_order_ids(arg0: &0xe308bd40bd81aa42b9245e4b51b3fe63801c77c78a76be4ce5902aae549f7221::account::AccountRegistry, arg1: 0x2::object::ID, arg2: u64) : vector<u64> {
        if (!0xa5cfafe6660a8bf37eedf1a09dba633048da374c30b835668473689668f9ef57::account_data::has_account(arg0, arg1)) {
            return vector[]
        };
        0xa5cfafe6660a8bf37eedf1a09dba633048da374c30b835668473689668f9ef57::account_data::order_ids_by_market(0xa5cfafe6660a8bf37eedf1a09dba633048da374c30b835668473689668f9ef57::account_data::borrow_account(arg0, arg1), arg2)
    }

    public fun account_order_ids_by_market_id<T0>(arg0: &0xa5cfafe6660a8bf37eedf1a09dba633048da374c30b835668473689668f9ef57::waterx_prediction::MarketRegistry<T0>, arg1: &0xe308bd40bd81aa42b9245e4b51b3fe63801c77c78a76be4ce5902aae549f7221::account::AccountRegistry, arg2: 0x2::object::ID, arg3: vector<u8>) : vector<u64> {
        account_order_ids(arg1, arg2, 0xa5cfafe6660a8bf37eedf1a09dba633048da374c30b835668473689668f9ef57::waterx_prediction::market_key<T0>(arg0, arg3))
    }

    public fun account_order_market_key(arg0: &0xe308bd40bd81aa42b9245e4b51b3fe63801c77c78a76be4ce5902aae549f7221::account::AccountRegistry, arg1: 0x2::object::ID, arg2: u64) : 0x1::option::Option<u64> {
        if (!0xa5cfafe6660a8bf37eedf1a09dba633048da374c30b835668473689668f9ef57::account_data::has_account(arg0, arg1)) {
            return 0x1::option::none<u64>()
        };
        let v0 = 0xa5cfafe6660a8bf37eedf1a09dba633048da374c30b835668473689668f9ef57::account_data::borrow_account(arg0, arg1);
        if (!0x665188033384920a5bb5dcfb2ef21f54b4568d08b431718b97e02e5c184b92cc::linked_table::contains<u64, u64>(0xa5cfafe6660a8bf37eedf1a09dba633048da374c30b835668473689668f9ef57::account_data::account_orders(v0), arg2)) {
            return 0x1::option::none<u64>()
        };
        0x1::option::some<u64>(0xa5cfafe6660a8bf37eedf1a09dba633048da374c30b835668473689668f9ef57::account_data::order_market_key(v0, arg2))
    }

    public fun account_order_next(arg0: &0xe308bd40bd81aa42b9245e4b51b3fe63801c77c78a76be4ce5902aae549f7221::account::AccountRegistry, arg1: 0x2::object::ID, arg2: u64) : 0x1::option::Option<u64> {
        if (!0xa5cfafe6660a8bf37eedf1a09dba633048da374c30b835668473689668f9ef57::account_data::has_account(arg0, arg1)) {
            return 0x1::option::none<u64>()
        };
        0xa5cfafe6660a8bf37eedf1a09dba633048da374c30b835668473689668f9ef57::account_data::order_next(0xa5cfafe6660a8bf37eedf1a09dba633048da374c30b835668473689668f9ef57::account_data::borrow_account(arg0, arg1), arg2)
    }

    public fun account_position_cursor(arg0: &0xe308bd40bd81aa42b9245e4b51b3fe63801c77c78a76be4ce5902aae549f7221::account::AccountRegistry, arg1: 0x2::object::ID) : (u64, 0x1::option::Option<u64>, 0x1::option::Option<u64>) {
        if (!0xa5cfafe6660a8bf37eedf1a09dba633048da374c30b835668473689668f9ef57::account_data::has_account(arg0, arg1)) {
            return (0, 0x1::option::none<u64>(), 0x1::option::none<u64>())
        };
        let v0 = 0xa5cfafe6660a8bf37eedf1a09dba633048da374c30b835668473689668f9ef57::account_data::borrow_account(arg0, arg1);
        (0xa5cfafe6660a8bf37eedf1a09dba633048da374c30b835668473689668f9ef57::account_data::position_count(v0), 0xa5cfafe6660a8bf37eedf1a09dba633048da374c30b835668473689668f9ef57::account_data::position_front(v0), 0xa5cfafe6660a8bf37eedf1a09dba633048da374c30b835668473689668f9ef57::account_data::position_back(v0))
    }

    public fun account_position_ids(arg0: &0xe308bd40bd81aa42b9245e4b51b3fe63801c77c78a76be4ce5902aae549f7221::account::AccountRegistry, arg1: 0x2::object::ID, arg2: u64) : vector<u64> {
        if (!0xa5cfafe6660a8bf37eedf1a09dba633048da374c30b835668473689668f9ef57::account_data::has_account(arg0, arg1)) {
            return vector[]
        };
        0xa5cfafe6660a8bf37eedf1a09dba633048da374c30b835668473689668f9ef57::account_data::position_ids_by_market(0xa5cfafe6660a8bf37eedf1a09dba633048da374c30b835668473689668f9ef57::account_data::borrow_account(arg0, arg1), arg2)
    }

    public fun account_position_ids_by_market_id<T0>(arg0: &0xa5cfafe6660a8bf37eedf1a09dba633048da374c30b835668473689668f9ef57::waterx_prediction::MarketRegistry<T0>, arg1: &0xe308bd40bd81aa42b9245e4b51b3fe63801c77c78a76be4ce5902aae549f7221::account::AccountRegistry, arg2: 0x2::object::ID, arg3: vector<u8>) : vector<u64> {
        account_position_ids(arg1, arg2, 0xa5cfafe6660a8bf37eedf1a09dba633048da374c30b835668473689668f9ef57::waterx_prediction::market_key<T0>(arg0, arg3))
    }

    public fun account_position_market_key(arg0: &0xe308bd40bd81aa42b9245e4b51b3fe63801c77c78a76be4ce5902aae549f7221::account::AccountRegistry, arg1: 0x2::object::ID, arg2: u64) : 0x1::option::Option<u64> {
        if (!0xa5cfafe6660a8bf37eedf1a09dba633048da374c30b835668473689668f9ef57::account_data::has_account(arg0, arg1)) {
            return 0x1::option::none<u64>()
        };
        let v0 = 0xa5cfafe6660a8bf37eedf1a09dba633048da374c30b835668473689668f9ef57::account_data::borrow_account(arg0, arg1);
        if (!0x665188033384920a5bb5dcfb2ef21f54b4568d08b431718b97e02e5c184b92cc::linked_table::contains<u64, u64>(0xa5cfafe6660a8bf37eedf1a09dba633048da374c30b835668473689668f9ef57::account_data::account_positions(v0), arg2)) {
            return 0x1::option::none<u64>()
        };
        0x1::option::some<u64>(0xa5cfafe6660a8bf37eedf1a09dba633048da374c30b835668473689668f9ef57::account_data::position_market_key(v0, arg2))
    }

    public fun account_position_next(arg0: &0xe308bd40bd81aa42b9245e4b51b3fe63801c77c78a76be4ce5902aae549f7221::account::AccountRegistry, arg1: 0x2::object::ID, arg2: u64) : 0x1::option::Option<u64> {
        if (!0xa5cfafe6660a8bf37eedf1a09dba633048da374c30b835668473689668f9ef57::account_data::has_account(arg0, arg1)) {
            return 0x1::option::none<u64>()
        };
        0xa5cfafe6660a8bf37eedf1a09dba633048da374c30b835668473689668f9ef57::account_data::position_next(0xa5cfafe6660a8bf37eedf1a09dba633048da374c30b835668473689668f9ef57::account_data::borrow_account(arg0, arg1), arg2)
    }

    public fun market_by_id<T0>(arg0: &0xa5cfafe6660a8bf37eedf1a09dba633048da374c30b835668473689668f9ef57::waterx_prediction::MarketRegistry<T0>, arg1: vector<u8>) : MarketView {
        market_by_key<T0>(arg0, 0xa5cfafe6660a8bf37eedf1a09dba633048da374c30b835668473689668f9ef57::waterx_prediction::market_key<T0>(arg0, arg1))
    }

    public fun market_by_key<T0>(arg0: &0xa5cfafe6660a8bf37eedf1a09dba633048da374c30b835668473689668f9ef57::waterx_prediction::MarketRegistry<T0>, arg1: u64) : MarketView {
        let (v0, v1, v2, v3) = 0xa5cfafe6660a8bf37eedf1a09dba633048da374c30b835668473689668f9ef57::waterx_prediction::market_exposure_by_key<T0>(arg0, arg1);
        MarketView{
            market_key      : arg1,
            market_id       : 0xa5cfafe6660a8bf37eedf1a09dba633048da374c30b835668473689668f9ef57::waterx_prediction::market_id_by_key<T0>(arg0, arg1),
            resolved        : 0xa5cfafe6660a8bf37eedf1a09dba633048da374c30b835668473689668f9ef57::waterx_prediction::market_is_resolved_by_key<T0>(arg0, arg1),
            paused          : 0xa5cfafe6660a8bf37eedf1a09dba633048da374c30b835668473689668f9ef57::waterx_prediction::is_market_paused_by_key<T0>(arg0, arg1),
            outcome         : 0xa5cfafe6660a8bf37eedf1a09dba633048da374c30b835668473689668f9ef57::waterx_prediction::market_outcome_by_key<T0>(arg0, arg1),
            unclaimed_count : 0xa5cfafe6660a8bf37eedf1a09dba633048da374c30b835668473689668f9ef57::waterx_prediction::market_unclaimed_count_by_key<T0>(arg0, arg1),
            yes_shares      : v0,
            yes_cost        : v1,
            no_shares       : v2,
            no_cost         : v3,
        }
    }

    public fun order_cursor<T0>(arg0: &0xa5cfafe6660a8bf37eedf1a09dba633048da374c30b835668473689668f9ef57::waterx_prediction::MarketRegistry<T0>) : (u64, 0x1::option::Option<u64>, 0x1::option::Option<u64>) {
        (0xa5cfafe6660a8bf37eedf1a09dba633048da374c30b835668473689668f9ef57::waterx_prediction::order_count<T0>(arg0), 0xa5cfafe6660a8bf37eedf1a09dba633048da374c30b835668473689668f9ef57::waterx_prediction::order_front<T0>(arg0), 0xa5cfafe6660a8bf37eedf1a09dba633048da374c30b835668473689668f9ef57::waterx_prediction::order_back<T0>(arg0))
    }

    public fun position_cursor<T0>(arg0: &0xa5cfafe6660a8bf37eedf1a09dba633048da374c30b835668473689668f9ef57::waterx_prediction::MarketRegistry<T0>) : (u64, 0x1::option::Option<u64>, 0x1::option::Option<u64>) {
        (0xa5cfafe6660a8bf37eedf1a09dba633048da374c30b835668473689668f9ef57::waterx_prediction::position_count<T0>(arg0), 0xa5cfafe6660a8bf37eedf1a09dba633048da374c30b835668473689668f9ef57::waterx_prediction::position_front<T0>(arg0), 0xa5cfafe6660a8bf37eedf1a09dba633048da374c30b835668473689668f9ef57::waterx_prediction::position_back<T0>(arg0))
    }

    public fun positions_page<T0>(arg0: &0xa5cfafe6660a8bf37eedf1a09dba633048da374c30b835668473689668f9ef57::waterx_prediction::MarketRegistry<T0>, arg1: 0x1::option::Option<u64>, arg2: u64) : (vector<PositionView>, 0x1::option::Option<u64>) {
        let v0 = if (0x1::option::is_some<u64>(&arg1)) {
            arg1
        } else {
            0xa5cfafe6660a8bf37eedf1a09dba633048da374c30b835668473689668f9ef57::waterx_prediction::position_front<T0>(arg0)
        };
        let v1 = v0;
        let v2 = 0x1::vector::empty<PositionView>();
        let v3 = 0;
        while (v3 < arg2 && 0x1::option::is_some<u64>(&v1)) {
            let v4 = *0x1::option::borrow<u64>(&v1);
            0x1::vector::push_back<PositionView>(&mut v2, position<T0>(arg0, v4));
            v1 = 0xa5cfafe6660a8bf37eedf1a09dba633048da374c30b835668473689668f9ef57::waterx_prediction::position_next<T0>(arg0, v4);
            v3 = v3 + 1;
        };
        (v2, v1)
    }

    public fun registry<T0>(arg0: &0xa5cfafe6660a8bf37eedf1a09dba633048da374c30b835668473689668f9ef57::waterx_prediction::MarketRegistry<T0>) : RegistryView {
        RegistryView{
            balance                  : 0xa5cfafe6660a8bf37eedf1a09dba633048da374c30b835668473689668f9ef57::waterx_prediction::market_registry_balance<T0>(arg0),
            min_reserve              : 0xa5cfafe6660a8bf37eedf1a09dba633048da374c30b835668473689668f9ef57::waterx_prediction::market_registry_min_reserve<T0>(arg0),
            order_cancel_cooldown_ms : 0xa5cfafe6660a8bf37eedf1a09dba633048da374c30b835668473689668f9ef57::waterx_prediction::market_registry_order_cancel_cooldown_ms<T0>(arg0),
            next_order_id            : 0xa5cfafe6660a8bf37eedf1a09dba633048da374c30b835668473689668f9ef57::waterx_prediction::next_order_id<T0>(arg0),
            next_position_id         : 0xa5cfafe6660a8bf37eedf1a09dba633048da374c30b835668473689668f9ef57::waterx_prediction::next_position_id<T0>(arg0),
            order_count              : 0xa5cfafe6660a8bf37eedf1a09dba633048da374c30b835668473689668f9ef57::waterx_prediction::order_count<T0>(arg0),
            position_count           : 0xa5cfafe6660a8bf37eedf1a09dba633048da374c30b835668473689668f9ef57::waterx_prediction::position_count<T0>(arg0),
            unresolved_market_count  : 0xa5cfafe6660a8bf37eedf1a09dba633048da374c30b835668473689668f9ef57::waterx_prediction::unresolved_market_count<T0>(arg0),
            resolved_market_count    : 0xa5cfafe6660a8bf37eedf1a09dba633048da374c30b835668473689668f9ef57::waterx_prediction::resolved_market_count<T0>(arg0),
        }
    }

    public fun resolved_market_cursor<T0>(arg0: &0xa5cfafe6660a8bf37eedf1a09dba633048da374c30b835668473689668f9ef57::waterx_prediction::MarketRegistry<T0>) : (u64, 0x1::option::Option<u64>, 0x1::option::Option<u64>) {
        (0xa5cfafe6660a8bf37eedf1a09dba633048da374c30b835668473689668f9ef57::waterx_prediction::resolved_market_count<T0>(arg0), 0xa5cfafe6660a8bf37eedf1a09dba633048da374c30b835668473689668f9ef57::waterx_prediction::resolved_market_front<T0>(arg0), 0xa5cfafe6660a8bf37eedf1a09dba633048da374c30b835668473689668f9ef57::waterx_prediction::resolved_market_back<T0>(arg0))
    }

    public fun resolved_markets_page<T0>(arg0: &0xa5cfafe6660a8bf37eedf1a09dba633048da374c30b835668473689668f9ef57::waterx_prediction::MarketRegistry<T0>, arg1: 0x1::option::Option<u64>, arg2: u64) : (vector<MarketView>, 0x1::option::Option<u64>) {
        let v0 = if (0x1::option::is_some<u64>(&arg1)) {
            arg1
        } else {
            0xa5cfafe6660a8bf37eedf1a09dba633048da374c30b835668473689668f9ef57::waterx_prediction::resolved_market_front<T0>(arg0)
        };
        let v1 = v0;
        let v2 = 0x1::vector::empty<MarketView>();
        let v3 = 0;
        while (v3 < arg2 && 0x1::option::is_some<u64>(&v1)) {
            let v4 = *0x1::option::borrow<u64>(&v1);
            0x1::vector::push_back<MarketView>(&mut v2, market_by_key<T0>(arg0, v4));
            v1 = 0xa5cfafe6660a8bf37eedf1a09dba633048da374c30b835668473689668f9ef57::waterx_prediction::resolved_market_next<T0>(arg0, v4);
            v3 = v3 + 1;
        };
        (v2, v1)
    }

    public fun unresolved_market_cursor<T0>(arg0: &0xa5cfafe6660a8bf37eedf1a09dba633048da374c30b835668473689668f9ef57::waterx_prediction::MarketRegistry<T0>) : (u64, 0x1::option::Option<u64>, 0x1::option::Option<u64>) {
        (0xa5cfafe6660a8bf37eedf1a09dba633048da374c30b835668473689668f9ef57::waterx_prediction::unresolved_market_count<T0>(arg0), 0xa5cfafe6660a8bf37eedf1a09dba633048da374c30b835668473689668f9ef57::waterx_prediction::unresolved_market_front<T0>(arg0), 0xa5cfafe6660a8bf37eedf1a09dba633048da374c30b835668473689668f9ef57::waterx_prediction::unresolved_market_back<T0>(arg0))
    }

    public fun unresolved_markets<T0>(arg0: &0xa5cfafe6660a8bf37eedf1a09dba633048da374c30b835668473689668f9ef57::waterx_prediction::MarketRegistry<T0>) : vector<MarketView> {
        let v0 = 0x1::vector::empty<MarketView>();
        let v1 = 0xa5cfafe6660a8bf37eedf1a09dba633048da374c30b835668473689668f9ef57::waterx_prediction::unresolved_market_front<T0>(arg0);
        while (0x1::option::is_some<u64>(&v1)) {
            let v2 = *0x1::option::borrow<u64>(&v1);
            0x1::vector::push_back<MarketView>(&mut v0, market_by_key<T0>(arg0, v2));
            v1 = 0xa5cfafe6660a8bf37eedf1a09dba633048da374c30b835668473689668f9ef57::waterx_prediction::unresolved_market_next<T0>(arg0, v2);
        };
        v0
    }

    public fun unresolved_markets_page<T0>(arg0: &0xa5cfafe6660a8bf37eedf1a09dba633048da374c30b835668473689668f9ef57::waterx_prediction::MarketRegistry<T0>, arg1: 0x1::option::Option<u64>, arg2: u64) : (vector<MarketView>, 0x1::option::Option<u64>) {
        let v0 = if (0x1::option::is_some<u64>(&arg1)) {
            arg1
        } else {
            0xa5cfafe6660a8bf37eedf1a09dba633048da374c30b835668473689668f9ef57::waterx_prediction::unresolved_market_front<T0>(arg0)
        };
        let v1 = v0;
        let v2 = 0x1::vector::empty<MarketView>();
        let v3 = 0;
        while (v3 < arg2 && 0x1::option::is_some<u64>(&v1)) {
            let v4 = *0x1::option::borrow<u64>(&v1);
            0x1::vector::push_back<MarketView>(&mut v2, market_by_key<T0>(arg0, v4));
            v1 = 0xa5cfafe6660a8bf37eedf1a09dba633048da374c30b835668473689668f9ef57::waterx_prediction::unresolved_market_next<T0>(arg0, v4);
            v3 = v3 + 1;
        };
        (v2, v1)
    }

    // decompiled from Move bytecode v7
}

