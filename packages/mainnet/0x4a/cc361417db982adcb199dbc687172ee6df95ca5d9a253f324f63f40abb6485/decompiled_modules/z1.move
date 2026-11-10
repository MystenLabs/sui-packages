module 0x8588bf772f76920555f443cccfee2fe1b37afb8241105141d3a5159e23d5c3c::z1 {
    struct Desk<phantom T0> has key {
        id: 0x2::object::UID,
        account: 0x2::object::ID,
        account_num: u64,
        cap: 0x4e2df80a5e2fd0392878298c51ce15164222111ccea05504b9291b158f552677::authority::AuthorityCap<0x3ec740df8428aa9c93aaef7f8cc1542ac3194fd014826b51bfe245346d64efc7::authority::ACCOUNT, 0x4e2df80a5e2fd0392878298c51ce15164222111ccea05504b9291b158f552677::authority::ADMIN>,
        owners: vector<address>,
        traders: vector<address>,
        paused: bool,
        max_order_e6: u64,
        max_position_e6: u64,
        max_mark_dev_bps: u64,
        max_flatten_band_bps: u64,
    }

    struct DeskCreated has copy, drop {
        desk: 0x2::object::ID,
        account: 0x2::object::ID,
        account_num: u64,
        owner: address,
    }

    struct Limits has copy, drop {
        desk: 0x2::object::ID,
        max_order_e6: u64,
        max_position_e6: u64,
        max_mark_dev_bps: u64,
        max_flatten_band_bps: u64,
    }

    struct Funds has copy, drop {
        desk: 0x2::object::ID,
        by: address,
        amount: u64,
        deposit: bool,
    }

    struct Dust has copy, drop {
        desk: 0x2::object::ID,
        house: 0x2::object::ID,
        reason: u8,
        bid_price: u64,
        ask_price: u64,
        size: u64,
        bids: vector<u128>,
        asks: vector<u128>,
        cancelled: u64,
        placed: u64,
        position_size: u64,
        position_long: bool,
    }

    struct Flat has copy, drop {
        desk: 0x2::object::ID,
        house: 0x2::object::ID,
        side_is_ask: bool,
        quantity: u64,
        limit: u64,
        before: u64,
        long_before: bool,
        after: u64,
        long_after: bool,
    }

    public fun account<T0>(arg0: &Desk<T0>) : 0x2::object::ID {
        arg0.account
    }

    public fun account_num<T0>(arg0: &Desk<T0>) : u64 {
        arg0.account_num
    }

    public fun add_owner<T0>(arg0: &mut Desk<T0>, arg1: address, arg2: &0x2::tx_context::TxContext) {
        assert_owner<T0>(arg0, arg2);
        if (!0x1::vector::contains<address>(&arg0.owners, &arg1)) {
            0x1::vector::push_back<address>(&mut arg0.owners, arg1);
        };
    }

    public fun add_trader<T0>(arg0: &mut Desk<T0>, arg1: address, arg2: &0x2::tx_context::TxContext) {
        assert_owner<T0>(arg0, arg2);
        if (!0x1::vector::contains<address>(&arg0.traders, &arg1)) {
            0x1::vector::push_back<address>(&mut arg0.traders, arg1);
        };
    }

    public fun allocate<T0>(arg0: &Desk<T0>, arg1: &mut 0x3ec740df8428aa9c93aaef7f8cc1542ac3194fd014826b51bfe245346d64efc7::clearing_house::ClearingHouse<T0>, arg2: &mut 0x3ec740df8428aa9c93aaef7f8cc1542ac3194fd014826b51bfe245346d64efc7::account::Account<T0>, arg3: u64, arg4: &0x2::tx_context::TxContext) {
        assert_trading<T0>(arg0, arg4);
        assert_account<T0>(arg0, arg2);
        0x3ec740df8428aa9c93aaef7f8cc1542ac3194fd014826b51bfe245346d64efc7::clearing_house::allocate_collateral<T0, 0x4e2df80a5e2fd0392878298c51ce15164222111ccea05504b9291b158f552677::authority::ADMIN>(arg1, &arg0.cap, arg2, arg3);
    }

    fun assert_account<T0>(arg0: &Desk<T0>, arg1: &0x3ec740df8428aa9c93aaef7f8cc1542ac3194fd014826b51bfe245346d64efc7::account::Account<T0>) {
        assert!(0x2::object::id<0x3ec740df8428aa9c93aaef7f8cc1542ac3194fd014826b51bfe245346d64efc7::account::Account<T0>>(arg1) == arg0.account, 4);
    }

    fun assert_operator<T0>(arg0: &Desk<T0>, arg1: &0x2::tx_context::TxContext) {
        let v0 = 0x2::tx_context::sender(arg1);
        assert!(0x1::vector::contains<address>(&arg0.traders, &v0) || 0x1::vector::contains<address>(&arg0.owners, &v0), 1);
    }

    fun assert_owner<T0>(arg0: &Desk<T0>, arg1: &0x2::tx_context::TxContext) {
        let v0 = 0x2::tx_context::sender(arg1);
        assert!(0x1::vector::contains<address>(&arg0.owners, &v0), 1);
    }

    fun assert_trading<T0>(arg0: &Desk<T0>, arg1: &0x2::tx_context::TxContext) {
        assert!(!arg0.paused, 3);
        assert_operator<T0>(arg0, arg1);
    }

    fun base_size<T0>(arg0: &0x3ec740df8428aa9c93aaef7f8cc1542ac3194fd014826b51bfe245346d64efc7::clearing_house::ClearingHouse<T0>, arg1: u64) : (u64, bool) {
        if (!0x3ec740df8428aa9c93aaef7f8cc1542ac3194fd014826b51bfe245346d64efc7::clearing_house::exists_position<T0>(arg0, arg1)) {
            return (0, true)
        };
        let (v0, _) = 0x9196fffe0341b2f0ca7424926b22d9e9e35b4807a1f625fc20eeea1382d08dec::position::base_and_quote_amounts(0x3ec740df8428aa9c93aaef7f8cc1542ac3194fd014826b51bfe245346d64efc7::clearing_house::position<T0>(arg0, arg1));
        (0x4b4703a7581781d74a4c7b0fb0836b2a67f34f1a377fb81aab6f5cad29d78760::ifixed::to_balance(0x4b4703a7581781d74a4c7b0fb0836b2a67f34f1a377fb81aab6f5cad29d78760::ifixed::abs(v0), 1000000000), !0x4b4703a7581781d74a4c7b0fb0836b2a67f34f1a377fb81aab6f5cad29d78760::ifixed::is_neg(v0))
    }

    public fun begin<T0>(arg0: &Desk<T0>, arg1: 0x3ec740df8428aa9c93aaef7f8cc1542ac3194fd014826b51bfe245346d64efc7::clearing_house::ClearingHouse<T0>, arg2: &mut 0x3ec740df8428aa9c93aaef7f8cc1542ac3194fd014826b51bfe245346d64efc7::account::Account<T0>, arg3: &0x9237337d846fc90b0a7acbdee4ab91809298691873d28e1d64d91e6303ff6ba4::price_feed_storage::PriceFeedStorage, arg4: &0x9237337d846fc90b0a7acbdee4ab91809298691873d28e1d64d91e6303ff6ba4::price_feed_storage::PriceFeedStorage, arg5: &0x2::clock::Clock, arg6: &0x2::tx_context::TxContext) : 0x3ec740df8428aa9c93aaef7f8cc1542ac3194fd014826b51bfe245346d64efc7::clearing_house::SessionHotPotato<T0> {
        assert_owner<T0>(arg0, arg6);
        assert_account<T0>(arg0, arg2);
        0x3ec740df8428aa9c93aaef7f8cc1542ac3194fd014826b51bfe245346d64efc7::clearing_house::start_session<T0, 0x4e2df80a5e2fd0392878298c51ce15164222111ccea05504b9291b158f552677::authority::ADMIN>(arg1, &arg0.cap, arg2, arg3, arg4, 0x1::option::none<0x3ec740df8428aa9c93aaef7f8cc1542ac3194fd014826b51bfe245346d64efc7::account::IntegratorInfo>(), arg5, arg6)
    }

    public fun cancel<T0>(arg0: &Desk<T0>, arg1: &mut 0x3ec740df8428aa9c93aaef7f8cc1542ac3194fd014826b51bfe245346d64efc7::clearing_house::ClearingHouse<T0>, arg2: &0x3ec740df8428aa9c93aaef7f8cc1542ac3194fd014826b51bfe245346d64efc7::account::Account<T0>, arg3: vector<u128>, arg4: &0x2::tx_context::TxContext) {
        assert_operator<T0>(arg0, arg4);
        assert_account<T0>(arg0, arg2);
        if (!0x1::vector::is_empty<u128>(&arg3)) {
            0x3ec740df8428aa9c93aaef7f8cc1542ac3194fd014826b51bfe245346d64efc7::clearing_house::try_cancel_orders<T0, 0x4e2df80a5e2fd0392878298c51ce15164222111ccea05504b9291b158f552677::authority::ADMIN>(arg1, &arg0.cap, arg2, &arg3);
        };
    }

    fun ceil_size(arg0: u256, arg1: u256, arg2: u64) : u64 {
        let v0 = if (arg0 == 0) {
            true
        } else if (arg1 == 0) {
            true
        } else {
            arg2 == 0
        };
        if (v0) {
            return 0
        };
        let v1 = ((arg0 * 1000000000 + arg1 - 1) / arg1 + (arg2 as u256) - 1) / (arg2 as u256) * (arg2 as u256);
        if (v1 > 18446744073709551615) {
            0
        } else {
            (v1 as u64)
        }
    }

    public fun create<T0>(arg0: &mut 0x3ec740df8428aa9c93aaef7f8cc1542ac3194fd014826b51bfe245346d64efc7::registry::Registry, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1, v2) = 0x3ec740df8428aa9c93aaef7f8cc1542ac3194fd014826b51bfe245346d64efc7::account::create_account<T0>(arg0, arg1);
        let v3 = v0;
        let v4 = 0x2::object::id<0x3ec740df8428aa9c93aaef7f8cc1542ac3194fd014826b51bfe245346d64efc7::account::Account<T0>>(&v3);
        let v5 = 0x3ec740df8428aa9c93aaef7f8cc1542ac3194fd014826b51bfe245346d64efc7::account::account_id<T0>(&v3);
        0x3ec740df8428aa9c93aaef7f8cc1542ac3194fd014826b51bfe245346d64efc7::account::consume_policy_and_share_account<T0>(v3, v1);
        let v6 = 0x1::vector::empty<address>();
        0x1::vector::push_back<address>(&mut v6, 0x2::tx_context::sender(arg1));
        let v7 = Desk<T0>{
            id                   : 0x2::object::new(arg1),
            account              : v4,
            account_num          : v5,
            cap                  : v2,
            owners               : v6,
            traders              : vector[],
            paused               : true,
            max_order_e6         : 30000000,
            max_position_e6      : 300000000,
            max_mark_dev_bps     : 50,
            max_flatten_band_bps : 50,
        };
        let v8 = DeskCreated{
            desk        : 0x2::object::id<Desk<T0>>(&v7),
            account     : v4,
            account_num : v5,
            owner       : 0x2::tx_context::sender(arg1),
        };
        0x2::event::emit<DeskCreated>(v8);
        0x2::transfer::share_object<Desk<T0>>(v7);
    }

    public fun deallocate<T0>(arg0: &Desk<T0>, arg1: &mut 0x3ec740df8428aa9c93aaef7f8cc1542ac3194fd014826b51bfe245346d64efc7::clearing_house::ClearingHouse<T0>, arg2: &mut 0x3ec740df8428aa9c93aaef7f8cc1542ac3194fd014826b51bfe245346d64efc7::account::Account<T0>, arg3: &0x9237337d846fc90b0a7acbdee4ab91809298691873d28e1d64d91e6303ff6ba4::price_feed_storage::PriceFeedStorage, arg4: &0x9237337d846fc90b0a7acbdee4ab91809298691873d28e1d64d91e6303ff6ba4::price_feed_storage::PriceFeedStorage, arg5: u64, arg6: &0x2::clock::Clock, arg7: &0x2::tx_context::TxContext) : u64 {
        assert_operator<T0>(arg0, arg7);
        assert_account<T0>(arg0, arg2);
        0x3ec740df8428aa9c93aaef7f8cc1542ac3194fd014826b51bfe245346d64efc7::clearing_house::deallocate_collateral<T0, 0x4e2df80a5e2fd0392878298c51ce15164222111ccea05504b9291b158f552677::authority::ADMIN>(arg1, &arg0.cap, arg2, arg3, arg4, arg5, arg6)
    }

    public fun deposit<T0>(arg0: &Desk<T0>, arg1: &mut 0x3ec740df8428aa9c93aaef7f8cc1542ac3194fd014826b51bfe245346d64efc7::account::Account<T0>, arg2: &0x3ec740df8428aa9c93aaef7f8cc1542ac3194fd014826b51bfe245346d64efc7::registry::Registry, arg3: 0x2::coin::Coin<T0>, arg4: &0x2::tx_context::TxContext) {
        assert_owner<T0>(arg0, arg4);
        assert_account<T0>(arg0, arg1);
        0x3ec740df8428aa9c93aaef7f8cc1542ac3194fd014826b51bfe245346d64efc7::account::deposit_collateral<T0, 0x4e2df80a5e2fd0392878298c51ce15164222111ccea05504b9291b158f552677::authority::ADMIN>(arg1, &arg0.cap, arg2, arg3);
        let v0 = Funds{
            desk    : 0x2::object::id<Desk<T0>>(arg0),
            by      : 0x2::tx_context::sender(arg4),
            amount  : 0x2::coin::value<T0>(&arg3),
            deposit : true,
        };
        0x2::event::emit<Funds>(v0);
    }

    fun external_best(arg0: &0x3ec740df8428aa9c93aaef7f8cc1542ac3194fd014826b51bfe245346d64efc7::orderbook::Orderbook, arg1: bool, arg2: &vector<u128>) : u64 {
        let v0 = option_u64(0x3ec740df8428aa9c93aaef7f8cc1542ac3194fd014826b51bfe245346d64efc7::orderbook::best_price(arg0, arg1));
        if (v0 == 0) {
            return 0
        };
        let v1 = if (arg1) {
            18446744073709551615
        } else {
            0
        };
        let (v2, _) = 0x3ec740df8428aa9c93aaef7f8cc1542ac3194fd014826b51bfe245346d64efc7::orderbook::inspect_orders(arg0, arg1, v0, v1, 0x1::u64::min(0x1::vector::length<u128>(arg2) + 1, 50));
        let v4 = v2;
        let v5 = 0;
        while (v5 < 0x1::vector::length<u128>(&v4)) {
            if (!0x1::vector::contains<u128>(arg2, 0x1::vector::borrow<u128>(&v4, v5))) {
                return order_price(*0x1::vector::borrow<u128>(&v4, v5), arg1)
            };
            v5 = v5 + 1;
        };
        0
    }

    public fun finish<T0>(arg0: &Desk<T0>, arg1: 0x3ec740df8428aa9c93aaef7f8cc1542ac3194fd014826b51bfe245346d64efc7::clearing_house::SessionHotPotato<T0>, arg2: &mut 0x3ec740df8428aa9c93aaef7f8cc1542ac3194fd014826b51bfe245346d64efc7::account::Account<T0>, arg3: &0x2::tx_context::TxContext) {
        assert_owner<T0>(arg0, arg3);
        assert_account<T0>(arg0, arg2);
        let (v0, _) = 0x3ec740df8428aa9c93aaef7f8cc1542ac3194fd014826b51bfe245346d64efc7::clearing_house::end_session<T0, 0x4e2df80a5e2fd0392878298c51ce15164222111ccea05504b9291b158f552677::authority::ADMIN>(arg1, &arg0.cap, arg2, false, false);
        0x3ec740df8428aa9c93aaef7f8cc1542ac3194fd014826b51bfe245346d64efc7::clearing_house::share<T0>(v0);
    }

    public fun flatten<T0>(arg0: &Desk<T0>, arg1: 0x3ec740df8428aa9c93aaef7f8cc1542ac3194fd014826b51bfe245346d64efc7::clearing_house::ClearingHouse<T0>, arg2: &mut 0x3ec740df8428aa9c93aaef7f8cc1542ac3194fd014826b51bfe245346d64efc7::account::Account<T0>, arg3: &0x9237337d846fc90b0a7acbdee4ab91809298691873d28e1d64d91e6303ff6ba4::price_feed_storage::PriceFeedStorage, arg4: &0x9237337d846fc90b0a7acbdee4ab91809298691873d28e1d64d91e6303ff6ba4::price_feed_storage::PriceFeedStorage, arg5: vector<u128>, arg6: u64, arg7: u64, arg8: &0x2::clock::Clock, arg9: &0x2::tx_context::TxContext) {
        assert_operator<T0>(arg0, arg9);
        assert_account<T0>(arg0, arg2);
        assert!(arg7 <= arg0.max_flatten_band_bps && 0x1::vector::length<u128>(&arg5) <= 50, 2);
        if (!0x1::vector::is_empty<u128>(&arg5)) {
            0x3ec740df8428aa9c93aaef7f8cc1542ac3194fd014826b51bfe245346d64efc7::clearing_house::try_cancel_orders<T0, 0x4e2df80a5e2fd0392878298c51ce15164222111ccea05504b9291b158f552677::authority::ADMIN>(&mut arg1, &arg0.cap, arg2, &arg5);
        };
        let (v0, v1) = base_size<T0>(&arg1, arg0.account_num);
        let v2 = 0x3ec740df8428aa9c93aaef7f8cc1542ac3194fd014826b51bfe245346d64efc7::clearing_house::market_params<T0>(&arg1);
        let v3 = 0x3ec740df8428aa9c93aaef7f8cc1542ac3194fd014826b51bfe245346d64efc7::market::lot_size(v2);
        let v4 = 0x3ec740df8428aa9c93aaef7f8cc1542ac3194fd014826b51bfe245346d64efc7::clearing_house::mark_price<T0>(&arg1, arg3, arg8);
        let v5 = 0x1::u64::min(v0, floor_size((0x1::u64::min(arg6, arg0.max_position_e6) as u256) * 1000000000000, v4, v3));
        let v6 = if (v3 == 0) {
            0
        } else {
            v5 - v5 % v3
        };
        let v7 = flatten_limit(option_u64(0x3ec740df8428aa9c93aaef7f8cc1542ac3194fd014826b51bfe245346d64efc7::orderbook::best_price(0x3ec740df8428aa9c93aaef7f8cc1542ac3194fd014826b51bfe245346d64efc7::clearing_house::orderbook<T0>(&arg1), !v1)), v4, v1, arg7, arg0.max_mark_dev_bps, 0x3ec740df8428aa9c93aaef7f8cc1542ac3194fd014826b51bfe245346d64efc7::market::tick_size(v2));
        if (v6 == 0 || v7 == 0) {
            0x3ec740df8428aa9c93aaef7f8cc1542ac3194fd014826b51bfe245346d64efc7::clearing_house::share<T0>(arg1);
            let v8 = Flat{
                desk        : 0x2::object::id<Desk<T0>>(arg0),
                house       : 0x2::object::id<0x3ec740df8428aa9c93aaef7f8cc1542ac3194fd014826b51bfe245346d64efc7::clearing_house::ClearingHouse<T0>>(&arg1),
                side_is_ask : v1,
                quantity    : 0,
                limit       : v7,
                before      : v0,
                long_before : v1,
                after       : v0,
                long_after  : v1,
            };
            0x2::event::emit<Flat>(v8);
            return
        };
        let v9 = 0x3ec740df8428aa9c93aaef7f8cc1542ac3194fd014826b51bfe245346d64efc7::clearing_house::start_session<T0, 0x4e2df80a5e2fd0392878298c51ce15164222111ccea05504b9291b158f552677::authority::ADMIN>(arg1, &arg0.cap, arg2, arg3, arg4, 0x1::option::none<0x3ec740df8428aa9c93aaef7f8cc1542ac3194fd014826b51bfe245346d64efc7::account::IntegratorInfo>(), arg8, arg9);
        0x3ec740df8428aa9c93aaef7f8cc1542ac3194fd014826b51bfe245346d64efc7::clearing_house::place_limit_order<T0>(&mut v9, v1, v6, v7, 3, 0x1::option::none<u64>(), true, 0x1::option::none<u64>());
        let (v10, _) = 0x3ec740df8428aa9c93aaef7f8cc1542ac3194fd014826b51bfe245346d64efc7::clearing_house::end_session<T0, 0x4e2df80a5e2fd0392878298c51ce15164222111ccea05504b9291b158f552677::authority::ADMIN>(v9, &arg0.cap, arg2, false, false);
        let v12 = v10;
        let (v13, v14) = base_size<T0>(&v12, arg0.account_num);
        0x3ec740df8428aa9c93aaef7f8cc1542ac3194fd014826b51bfe245346d64efc7::clearing_house::share<T0>(v12);
        let v15 = Flat{
            desk        : 0x2::object::id<Desk<T0>>(arg0),
            house       : 0x2::object::id<0x3ec740df8428aa9c93aaef7f8cc1542ac3194fd014826b51bfe245346d64efc7::clearing_house::ClearingHouse<T0>>(&arg1),
            side_is_ask : v1,
            quantity    : v6,
            limit       : v7,
            before      : v0,
            long_before : v1,
            after       : v13,
            long_after  : v14,
        };
        0x2::event::emit<Flat>(v15);
    }

    fun flatten_limit(arg0: u64, arg1: u256, arg2: bool, arg3: u64, arg4: u64, arg5: u64) : u64 {
        let v0 = if (arg0 == 0) {
            true
        } else if (arg1 == 0) {
            true
        } else {
            arg5 == 0
        };
        if (v0) {
            return 0
        };
        if (arg2) {
            let v2 = (0x1::u256::max((arg0 as u256) * (10000 - (arg3 as u256)) / 10000, (arg1 * (10000 - ((arg3 + arg4) as u256)) / 10000 + 1000000000 - 1) / 1000000000) + (arg5 as u256) - 1) / (arg5 as u256) * (arg5 as u256);
            if (v2 > 18446744073709551615) {
                0
            } else {
                (v2 as u64)
            }
        } else {
            let v3 = 0x1::u256::min(((arg0 as u256) * (10000 + (arg3 as u256)) + 10000 - 1) / 10000, arg1 * (10000 + ((arg3 + arg4) as u256)) / 10000 / 1000000000) / (arg5 as u256) * (arg5 as u256);
            if (v3 > 18446744073709551615) {
                0
            } else {
                (v3 as u64)
            }
        }
    }

    fun floor_size(arg0: u256, arg1: u256, arg2: u64) : u64 {
        if (arg1 == 0 || arg2 == 0) {
            return 0
        };
        let v0 = arg0 * 1000000000 / arg1 / (arg2 as u256) * (arg2 as u256);
        if (v0 > 18446744073709551615) {
            18446744073709551615
        } else {
            (v0 as u64)
        }
    }

    public fun is_owner<T0>(arg0: &Desk<T0>, arg1: address) : bool {
        0x1::vector::contains<address>(&arg0.owners, &arg1)
    }

    public fun is_trader<T0>(arg0: &Desk<T0>, arg1: address) : bool {
        0x1::vector::contains<address>(&arg0.traders, &arg1)
    }

    public fun open<T0>(arg0: &Desk<T0>, arg1: &mut 0x3ec740df8428aa9c93aaef7f8cc1542ac3194fd014826b51bfe245346d64efc7::clearing_house::ClearingHouse<T0>, arg2: &0x3ec740df8428aa9c93aaef7f8cc1542ac3194fd014826b51bfe245346d64efc7::account::Account<T0>, arg3: &0x2::tx_context::TxContext) {
        assert_trading<T0>(arg0, arg3);
        assert_account<T0>(arg0, arg2);
        0x3ec740df8428aa9c93aaef7f8cc1542ac3194fd014826b51bfe245346d64efc7::clearing_house::create_market_position<T0, 0x4e2df80a5e2fd0392878298c51ce15164222111ccea05504b9291b158f552677::authority::ADMIN>(arg1, &arg0.cap, arg2);
    }

    fun option_u64(arg0: 0x1::option::Option<u64>) : u64 {
        if (0x1::option::is_some<u64>(&arg0)) {
            0x1::option::destroy_some<u64>(arg0)
        } else {
            0x1::option::destroy_none<u64>(arg0);
            0
        }
    }

    fun order_price(arg0: u128, arg1: bool) : u64 {
        if (arg1) {
            ((arg0 >> 64) as u64)
        } else {
            18446744073709551615 - ((arg0 >> 64) as u64)
        }
    }

    public fun paused<T0>(arg0: &Desk<T0>) : bool {
        arg0.paused
    }

    fun place<T0>(arg0: &mut 0x3ec740df8428aa9c93aaef7f8cc1542ac3194fd014826b51bfe245346d64efc7::clearing_house::SessionHotPotato<T0>, arg1: bool, arg2: u64, arg3: u64, arg4: u64, arg5: &mut vector<u128>) {
        let v0 = 0x3ec740df8428aa9c93aaef7f8cc1542ac3194fd014826b51bfe245346d64efc7::clearing_house::place_limit_order<T0>(arg0, arg1, arg2, arg3, 2, 0x1::option::none<u64>(), false, 0x1::option::some<u64>(arg4));
        if (0x1::option::is_some<u128>(&v0)) {
            0x1::vector::push_back<u128>(arg5, 0x1::option::destroy_some<u128>(v0));
        } else {
            0x1::option::destroy_none<u128>(v0);
        };
    }

    fun plan_side(arg0: &0x3ec740df8428aa9c93aaef7f8cc1542ac3194fd014826b51bfe245346d64efc7::orderbook::Orderbook, arg1: &vector<u128>, arg2: u64, arg3: bool, arg4: u64, arg5: u64, arg6: bool, arg7: u64, arg8: u64) : (vector<u128>, vector<u128>) {
        let v0 = vector[];
        let v1 = vector[];
        let v2 = 0;
        while (v2 < 0x1::vector::length<u128>(arg1)) {
            let v3 = *0x1::vector::borrow<u128>(arg1, v2);
            let v4 = 0x3ec740df8428aa9c93aaef7f8cc1542ac3194fd014826b51bfe245346d64efc7::orderbook::get_order(arg0, v3);
            if (0x1::option::is_some<0x3ec740df8428aa9c93aaef7f8cc1542ac3194fd014826b51bfe245346d64efc7::orderbook::Order>(&v4)) {
                let (v5, _, _, v8, _, _) = 0x3ec740df8428aa9c93aaef7f8cc1542ac3194fd014826b51bfe245346d64efc7::orderbook::as_parts(0x1::option::borrow<0x3ec740df8428aa9c93aaef7f8cc1542ac3194fd014826b51bfe245346d64efc7::orderbook::Order>(&v4));
                let v11 = v8;
                let v12 = if (0x1::option::is_some<u64>(&v11)) {
                    let v13 = *0x1::option::borrow<u64>(&v11);
                    v13 > arg7 && v13 - arg7 > arg8
                } else {
                    true
                };
                let v14 = if (v5 == arg2) {
                    if (!0x1::vector::contains<u128>(&v0, &v3)) {
                        !0x1::vector::contains<u128>(&v1, &v3)
                    } else {
                        false
                    }
                } else {
                    false
                };
                if (v14) {
                    let v15 = if (arg3) {
                        if (0x1::vector::length<u128>(&v0) < arg5) {
                            if (v12) {
                                order_price(v3, arg6) == arg4
                            } else {
                                false
                            }
                        } else {
                            false
                        }
                    } else {
                        false
                    };
                    if (v15) {
                        0x1::vector::push_back<u128>(&mut v0, v3);
                    } else {
                        0x1::vector::push_back<u128>(&mut v1, v3);
                    };
                };
            };
            v2 = v2 + 1;
        };
        (v0, v1)
    }

    public fun quote<T0>(arg0: &Desk<T0>, arg1: 0x3ec740df8428aa9c93aaef7f8cc1542ac3194fd014826b51bfe245346d64efc7::clearing_house::ClearingHouse<T0>, arg2: &mut 0x3ec740df8428aa9c93aaef7f8cc1542ac3194fd014826b51bfe245346d64efc7::account::Account<T0>, arg3: &0x9237337d846fc90b0a7acbdee4ab91809298691873d28e1d64d91e6303ff6ba4::price_feed_storage::PriceFeedStorage, arg4: &0x9237337d846fc90b0a7acbdee4ab91809298691873d28e1d64d91e6303ff6ba4::price_feed_storage::PriceFeedStorage, arg5: vector<u128>, arg6: vector<u128>, arg7: u64, arg8: u64, arg9: u64, arg10: u64, arg11: bool, arg12: &0x2::clock::Clock, arg13: &0x2::tx_context::TxContext) {
        assert_trading<T0>(arg0, arg13);
        assert_account<T0>(arg0, arg2);
        let v0 = if (arg7 <= 16) {
            if (arg9 > arg10) {
                if (arg9 <= 3600000) {
                    if (0x1::vector::length<u128>(&arg5) <= 50) {
                        0x1::vector::length<u128>(&arg6) <= 50
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
        assert!(v0, 2);
        let v1 = 0x2::clock::timestamp_ms(arg12);
        let v2 = 0x3ec740df8428aa9c93aaef7f8cc1542ac3194fd014826b51bfe245346d64efc7::clearing_house::market_params<T0>(&arg1);
        let v3 = 0x3ec740df8428aa9c93aaef7f8cc1542ac3194fd014826b51bfe245346d64efc7::clearing_house::mark_price<T0>(&arg1, arg3, arg12);
        let v4 = (0x1::u64::min(arg8, arg0.max_order_e6) as u256) * 1000000000000;
        let v5 = ceil_size(v4, v3, 0x3ec740df8428aa9c93aaef7f8cc1542ac3194fd014826b51bfe245346d64efc7::market::lot_size(v2));
        let v6 = (v5 as u256) * v3 / 1000000000;
        let v7 = if (v5 > 0) {
            if (v6 >= 0x3ec740df8428aa9c93aaef7f8cc1542ac3194fd014826b51bfe245346d64efc7::market::min_order_usd_value(v2)) {
                v6 <= 2 * v4
            } else {
                false
            }
        } else {
            false
        };
        let (v8, v9) = base_size<T0>(&arg1, arg0.account_num);
        let v10 = (v8 as u256) * v3 / 1000000000;
        let v11 = (arg0.max_position_e6 as u256) * 1000000000000;
        let v12 = side_count(arg7, v6, v10, v9, v11, true);
        let v13 = side_count(arg7, v6, v10, v9, v11, false);
        let v14 = 0x3ec740df8428aa9c93aaef7f8cc1542ac3194fd014826b51bfe245346d64efc7::clearing_house::orderbook<T0>(&arg1);
        let (v15, v16) = targets(external_best(v14, false, &arg5), external_best(v14, true, &arg6), 0x3ec740df8428aa9c93aaef7f8cc1542ac3194fd014826b51bfe245346d64efc7::market::tick_size(v2), arg11);
        let v17 = (arg0.max_mark_dev_bps as u256);
        let v18 = if (v7) {
            if (v12 > 0) {
                if (v15 > 0) {
                    (v15 as u256) * 1000000000 * 10000 <= v3 * (10000 + v17)
                } else {
                    false
                }
            } else {
                false
            }
        } else {
            false
        };
        let v19 = if (v7) {
            if (v13 > 0) {
                if (v16 > 0) {
                    (v16 as u256) * 1000000000 * 10000 >= v3 * (10000 - v17)
                } else {
                    false
                }
            } else {
                false
            }
        } else {
            false
        };
        let v20 = 0x3ec740df8428aa9c93aaef7f8cc1542ac3194fd014826b51bfe245346d64efc7::clearing_house::orderbook<T0>(&arg1);
        let (v21, v22) = plan_side(v20, &arg5, arg0.account_num, v18, v15, v12, false, v1, arg10);
        let (v23, v24) = plan_side(v20, &arg6, arg0.account_num, v19, v16, v13, true, v1, arg10);
        let v25 = v23;
        let v26 = v21;
        let v27 = v22;
        0x1::vector::append<u128>(&mut v27, v24);
        if (!0x1::vector::is_empty<u128>(&v27)) {
            0x3ec740df8428aa9c93aaef7f8cc1542ac3194fd014826b51bfe245346d64efc7::clearing_house::try_cancel_orders<T0, 0x4e2df80a5e2fd0392878298c51ce15164222111ccea05504b9291b158f552677::authority::ADMIN>(&mut arg1, &arg0.cap, arg2, &v27);
        };
        let v28 = if (v18) {
            v12 - 0x1::vector::length<u128>(&v26)
        } else {
            0
        };
        let v29 = if (v19) {
            v13 - 0x1::vector::length<u128>(&v25)
        } else {
            0
        };
        if (v28 + v29 > 0) {
            let v30 = v1 + arg9;
            let v31 = 0x3ec740df8428aa9c93aaef7f8cc1542ac3194fd014826b51bfe245346d64efc7::clearing_house::start_session<T0, 0x4e2df80a5e2fd0392878298c51ce15164222111ccea05504b9291b158f552677::authority::ADMIN>(arg1, &arg0.cap, arg2, arg3, arg4, 0x1::option::none<0x3ec740df8428aa9c93aaef7f8cc1542ac3194fd014826b51bfe245346d64efc7::account::IntegratorInfo>(), arg12, arg13);
            let v32 = 0;
            while (v32 < 0x1::u64::max(v28, v29)) {
                if (v32 < v28) {
                    let v33 = &mut v31;
                    let v34 = &mut v26;
                    place<T0>(v33, false, v5, v15, v30, v34);
                };
                if (v32 < v29) {
                    let v35 = &mut v31;
                    let v36 = &mut v25;
                    place<T0>(v35, true, v5, v16, v30, v36);
                };
                v32 = v32 + 1;
            };
            let (v37, _) = 0x3ec740df8428aa9c93aaef7f8cc1542ac3194fd014826b51bfe245346d64efc7::clearing_house::end_session<T0, 0x4e2df80a5e2fd0392878298c51ce15164222111ccea05504b9291b158f552677::authority::ADMIN>(v31, &arg0.cap, arg2, false, false);
            0x3ec740df8428aa9c93aaef7f8cc1542ac3194fd014826b51bfe245346d64efc7::clearing_house::share<T0>(v37);
        } else {
            0x3ec740df8428aa9c93aaef7f8cc1542ac3194fd014826b51bfe245346d64efc7::clearing_house::share<T0>(arg1);
        };
        let v39 = if (v15 == 0 || v16 == 0) {
            1
        } else if (!v7) {
            2
        } else {
            0
        };
        let v40 = if (v18) {
            v15
        } else {
            0
        };
        let v41 = if (v19) {
            v16
        } else {
            0
        };
        let v42 = Dust{
            desk          : 0x2::object::id<Desk<T0>>(arg0),
            house         : 0x2::object::id<0x3ec740df8428aa9c93aaef7f8cc1542ac3194fd014826b51bfe245346d64efc7::clearing_house::ClearingHouse<T0>>(&arg1),
            reason        : v39,
            bid_price     : v40,
            ask_price     : v41,
            size          : v5,
            bids          : v26,
            asks          : v25,
            cancelled     : 0x1::vector::length<u128>(&v27),
            placed        : v28 + v29,
            position_size : v8,
            position_long : v9,
        };
        0x2::event::emit<Dust>(v42);
    }

    public fun remove_owner<T0>(arg0: &mut Desk<T0>, arg1: address, arg2: &0x2::tx_context::TxContext) {
        assert_owner<T0>(arg0, arg2);
        let (v0, v1) = 0x1::vector::index_of<address>(&arg0.owners, &arg1);
        if (v0) {
            assert!(0x1::vector::length<address>(&arg0.owners) > 1, 2);
            0x1::vector::remove<address>(&mut arg0.owners, v1);
        };
    }

    public fun remove_trader<T0>(arg0: &mut Desk<T0>, arg1: address, arg2: &0x2::tx_context::TxContext) {
        assert_owner<T0>(arg0, arg2);
        let (v0, v1) = 0x1::vector::index_of<address>(&arg0.traders, &arg1);
        if (v0) {
            0x1::vector::remove<address>(&mut arg0.traders, v1);
        };
    }

    public fun set_limits<T0>(arg0: &mut Desk<T0>, arg1: u64, arg2: u64, arg3: u64, arg4: u64, arg5: &0x2::tx_context::TxContext) {
        assert_owner<T0>(arg0, arg5);
        let v0 = if (arg1 > 0) {
            if (arg1 <= arg2) {
                if (arg2 <= 100000000000) {
                    if (arg3 <= 500) {
                        arg4 <= 500
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
        assert!(v0, 2);
        arg0.max_order_e6 = arg1;
        arg0.max_position_e6 = arg2;
        arg0.max_mark_dev_bps = arg3;
        arg0.max_flatten_band_bps = arg4;
        let v1 = Limits{
            desk                 : 0x2::object::id<Desk<T0>>(arg0),
            max_order_e6         : arg1,
            max_position_e6      : arg2,
            max_mark_dev_bps     : arg3,
            max_flatten_band_bps : arg4,
        };
        0x2::event::emit<Limits>(v1);
    }

    public fun set_margin_ratio<T0>(arg0: &Desk<T0>, arg1: &mut 0x3ec740df8428aa9c93aaef7f8cc1542ac3194fd014826b51bfe245346d64efc7::clearing_house::ClearingHouse<T0>, arg2: &0x3ec740df8428aa9c93aaef7f8cc1542ac3194fd014826b51bfe245346d64efc7::account::Account<T0>, arg3: u256, arg4: &0x2::tx_context::TxContext) {
        assert_owner<T0>(arg0, arg4);
        assert_account<T0>(arg0, arg2);
        0x3ec740df8428aa9c93aaef7f8cc1542ac3194fd014826b51bfe245346d64efc7::clearing_house::set_position_initial_margin_ratio<T0, 0x4e2df80a5e2fd0392878298c51ce15164222111ccea05504b9291b158f552677::authority::ADMIN>(arg1, &arg0.cap, arg2, arg3);
    }

    public fun set_paused<T0>(arg0: &mut Desk<T0>, arg1: bool, arg2: &0x2::tx_context::TxContext) {
        if (arg1) {
            assert_operator<T0>(arg0, arg2);
        } else {
            assert_owner<T0>(arg0, arg2);
        };
        arg0.paused = arg1;
    }

    fun side_count(arg0: u64, arg1: u256, arg2: u256, arg3: bool, arg4: u256, arg5: bool) : u64 {
        if (arg1 == 0) {
            return 0
        };
        let v0 = if (arg5 == arg3) {
            if (arg2 >= arg4) {
                0
            } else {
                arg4 - arg2
            }
        } else {
            arg4 + arg2
        };
        let v1 = v0 / arg1;
        if (v1 > (arg0 as u256)) {
            arg0
        } else {
            (v1 as u64)
        }
    }

    fun targets(arg0: u64, arg1: u64, arg2: u64, arg3: bool) : (u64, u64) {
        let v0 = if (arg0 == 0) {
            true
        } else if (arg1 == 0) {
            true
        } else if (arg1 <= arg0) {
            true
        } else {
            arg2 == 0
        };
        if (v0) {
            return (0, 0)
        };
        if (arg3 && arg1 - arg0 >= 3 * arg2) {
            (arg0 + arg2, arg1 - arg2)
        } else {
            (arg0, arg1)
        }
    }

    public fun withdraw<T0>(arg0: &Desk<T0>, arg1: &mut 0x3ec740df8428aa9c93aaef7f8cc1542ac3194fd014826b51bfe245346d64efc7::account::Account<T0>, arg2: &0x3ec740df8428aa9c93aaef7f8cc1542ac3194fd014826b51bfe245346d64efc7::registry::Registry, arg3: u64, arg4: &mut 0x2::tx_context::TxContext) {
        assert_owner<T0>(arg0, arg4);
        assert_account<T0>(arg0, arg1);
        0x2::transfer::public_transfer<0x2::coin::Coin<T0>>(0x3ec740df8428aa9c93aaef7f8cc1542ac3194fd014826b51bfe245346d64efc7::account::withdraw_collateral<T0>(arg1, &arg0.cap, arg2, arg3, arg4), 0x2::tx_context::sender(arg4));
        let v0 = Funds{
            desk    : 0x2::object::id<Desk<T0>>(arg0),
            by      : 0x2::tx_context::sender(arg4),
            amount  : arg3,
            deposit : false,
        };
        0x2::event::emit<Funds>(v0);
    }

    // decompiled from Move bytecode v7
}

