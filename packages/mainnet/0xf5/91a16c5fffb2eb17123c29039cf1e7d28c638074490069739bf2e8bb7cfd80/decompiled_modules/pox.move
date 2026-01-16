module 0x385a98463c0ec72939a25ebb5baa140465bfffd27135977f2cee7349a998d03c::pox {
    struct POX has drop {
        dummy_field: bool,
    }

    struct EventStop has copy, drop, store {
        pool_id: 0x2::object::ID,
        stopped: bool,
    }

    struct LiquidityProviderCap has store, key {
        id: 0x2::object::UID,
        pool: 0x2::object::ID,
    }

    struct PoolRegistry has store, key {
        id: 0x2::object::UID,
        pools: vector<address>,
    }

    struct Depth has drop, store {
        amount: u64,
        price: u64,
    }

    struct Pool<phantom T0, phantom T1> has store, key {
        id: 0x2::object::UID,
        stopped: bool,
        price_feeder: 0x2::vec_set::VecSet<address>,
        price_decimals: u8,
        ask_ref_price: u64,
        bid_ref_price: u64,
        ref_price_step: u8,
        asks: vector<u64>,
        bids: vector<u64>,
        x_decimals: u8,
        y_decimals: u8,
        fee_millionth: u64,
        reserve_x: 0x2::balance::Balance<T0>,
        reserve_y: 0x2::balance::Balance<T1>,
        fee_collector: address,
        fee_x: u64,
        fee_y: u64,
    }

    struct UpdateAskEvent has copy, drop, store {
        pool_id: 0x2::object::ID,
        price: u64,
        amount: u64,
        ts: u64,
    }

    struct UpdateBidEvent has copy, drop, store {
        pool_id: 0x2::object::ID,
        price: u64,
        amount: u64,
        ts: u64,
    }

    struct UpdateAsksEvent has copy, drop, store {
        pool_id: 0x2::object::ID,
        prices: vector<u64>,
        amounts: vector<u64>,
        ts: u64,
    }

    struct UpdateBidsEvent has copy, drop, store {
        pool_id: 0x2::object::ID,
        prices: vector<u64>,
        amounts: vector<u64>,
        ts: u64,
    }

    struct SwapEvent has copy, drop, store {
        pool_id: 0x2::object::ID,
        x2y: bool,
        in_amount: u64,
        out_amount: u64,
        fee_amount: u64,
        ts: u64,
    }

    struct CreatePoolEvent has copy, drop, store {
        pool_id: 0x2::object::ID,
        x: 0x1::type_name::TypeName,
        y: 0x1::type_name::TypeName,
        x_decimals: u8,
        y_decimals: u8,
        fee_millionth: u64,
    }

    public fun add_price_feeders<T0, T1>(arg0: &mut Pool<T0, T1>, arg1: &0x2::package::Publisher, arg2: vector<address>) {
        assert!(0x2::package::from_module<POX>(arg1), 13906836901647613951);
        0x1::vector::reverse<address>(&mut arg2);
        let v0 = 0;
        while (v0 < 0x1::vector::length<address>(&arg2)) {
            0x2::vec_set::insert<address>(&mut arg0.price_feeder, 0x1::vector::pop_back<address>(&mut arg2));
            v0 = v0 + 1;
        };
        0x1::vector::destroy_empty<address>(arg2);
    }

    fun address_is_price_feeder<T0, T1>(arg0: &Pool<T0, T1>, arg1: address) : bool {
        0x2::vec_set::contains<address>(&arg0.price_feeder, &arg1)
    }

    public fun collect_fee<T0, T1>(arg0: &mut Pool<T0, T1>, arg1: &mut 0x2::tx_context::TxContext) : (0x2::balance::Balance<T0>, 0x2::balance::Balance<T1>) {
        assert!(arg0.fee_collector == 0x2::tx_context::sender(arg1), 5);
        arg0.fee_x = 0;
        arg0.fee_y = 0;
        (0x2::balance::split<T0>(&mut arg0.reserve_x, arg0.fee_x), 0x2::balance::split<T1>(&mut arg0.reserve_y, arg0.fee_y))
    }

    public fun create_pool<T0, T1>(arg0: &0x2::package::Publisher, arg1: &mut PoolRegistry, arg2: u8, arg3: u8, arg4: u8, arg5: u64, arg6: &0x2::clock::Clock, arg7: &mut 0x2::tx_context::TxContext) : Pool<T0, T1> {
        assert!(0x2::package::from_module<POX>(arg0), 13906835114941218815);
        let v0 = 0x2::object::new(arg7);
        0x1::vector::push_back<address>(&mut arg1.pools, 0x2::object::uid_to_address(&v0));
        let v1 = vector[];
        let v2 = 0;
        while (v2 < 50) {
            0x1::vector::push_back<u64>(&mut v1, 0);
            v2 = v2 + 1;
        };
        let v3 = vector[];
        let v4 = 0;
        while (v4 < 50) {
            0x1::vector::push_back<u64>(&mut v3, 0);
            v4 = v4 + 1;
        };
        let v5 = CreatePoolEvent{
            pool_id       : *0x2::object::uid_as_inner(&v0),
            x             : 0x1::type_name::with_defining_ids<T0>(),
            y             : 0x1::type_name::with_defining_ids<T1>(),
            x_decimals    : arg3,
            y_decimals    : arg4,
            fee_millionth : arg5,
        };
        0x2::event::emit<CreatePoolEvent>(v5);
        Pool<T0, T1>{
            id             : v0,
            stopped        : false,
            price_feeder   : 0x2::vec_set::empty<address>(),
            price_decimals : arg2,
            ask_ref_price  : 0,
            bid_ref_price  : 0,
            ref_price_step : 1,
            asks           : v1,
            bids           : v3,
            x_decimals     : arg3,
            y_decimals     : arg4,
            fee_millionth  : arg5,
            reserve_x      : 0x2::balance::zero<T0>(),
            reserve_y      : 0x2::balance::zero<T1>(),
            fee_collector  : 0x2::tx_context::sender(arg7),
            fee_x          : 0,
            fee_y          : 0,
        }
    }

    public fun create_pool_shared<T0, T1>(arg0: &0x2::package::Publisher, arg1: &mut PoolRegistry, arg2: u8, arg3: u8, arg4: u8, arg5: u64, arg6: &0x2::clock::Clock, arg7: &mut 0x2::tx_context::TxContext) {
        0x2::transfer::share_object<Pool<T0, T1>>(create_pool<T0, T1>(arg0, arg1, arg2, arg3, arg4, arg5, arg6, arg7));
    }

    public fun deposit<T0, T1>(arg0: &mut Pool<T0, T1>, arg1: &LiquidityProviderCap, arg2: 0x2::balance::Balance<T0>, arg3: 0x2::balance::Balance<T1>) {
        assert!(0x2::object::id<Pool<T0, T1>>(arg0) == arg1.pool, 13906834548005535743);
        if (0x2::balance::value<T0>(&arg2) == 0) {
            0x2::balance::destroy_zero<T0>(arg2);
        } else {
            0x2::balance::join<T0>(&mut arg0.reserve_x, arg2);
        };
        if (0x2::balance::value<T1>(&arg3) == 0) {
            0x2::balance::destroy_zero<T1>(arg3);
        } else {
            0x2::balance::join<T1>(&mut arg0.reserve_y, arg3);
        };
    }

    public fun deposit_external<T0, T1>(arg0: &mut Pool<T0, T1>, arg1: &LiquidityProviderCap, arg2: 0x2::coin::Coin<T0>, arg3: 0x2::coin::Coin<T1>) {
        deposit<T0, T1>(arg0, arg1, 0x2::coin::into_balance<T0>(arg2), 0x2::coin::into_balance<T1>(arg3));
    }

    fun from_x_to_y_at_price<T0, T1>(arg0: &Pool<T0, T1>, arg1: u64, arg2: u64) : u64 {
        (((arg1 as u128) * (arg2 as u128) * 0x1::u128::pow(10, arg0.y_decimals) / 0x1::u128::pow(10, arg0.x_decimals) / 0x1::u128::pow(10, arg0.price_decimals)) as u64)
    }

    fun from_y_to_x_at_price<T0, T1>(arg0: &Pool<T0, T1>, arg1: u64, arg2: u64) : u64 {
        (((arg1 as u128) * 0x1::u128::pow(10, arg0.price_decimals) * 0x1::u128::pow(10, arg0.x_decimals) / 0x1::u128::pow(10, arg0.y_decimals) / (arg2 as u128)) as u64)
    }

    public fun grant_lp_cap<T0, T1>(arg0: &0x2::package::Publisher, arg1: &Pool<T0, T1>, arg2: address, arg3: &mut 0x2::tx_context::TxContext) {
        assert!(0x2::package::from_module<POX>(arg0), 13906834462106189823);
        let v0 = LiquidityProviderCap{
            id   : 0x2::object::new(arg3),
            pool : 0x2::object::id<Pool<T0, T1>>(arg1),
        };
        0x2::transfer::transfer<LiquidityProviderCap>(v0, arg2);
    }

    fun init(arg0: POX, arg1: &mut 0x2::tx_context::TxContext) {
        0x2::package::claim_and_keep<POX>(arg0, arg1);
        let v0 = PoolRegistry{
            id    : 0x2::object::new(arg1),
            pools : 0x1::vector::empty<address>(),
        };
        0x2::transfer::share_object<PoolRegistry>(v0);
    }

    public fun quote_x_to_y<T0, T1>(arg0: &Pool<T0, T1>, arg1: u64) : (u64, u64, u64) {
        quote_x_to_y_readonly<T0, T1>(arg0, arg1)
    }

    fun quote_x_to_y_internal<T0, T1>(arg0: &mut Pool<T0, T1>, arg1: u64) : (u64, u64, u64) {
        assert!(!arg0.stopped, 1);
        let v0 = 0;
        let v1 = 0;
        let v2 = arg1;
        while (v1 < 0x1::vector::length<u64>(&arg0.bids) && v2 > 0) {
            if (v2 >= *0x1::vector::borrow<u64>(&arg0.bids, v1)) {
                let v3 = *0x1::vector::borrow<u64>(&arg0.bids, v1);
                if (v3 > 0) {
                    v0 = v0 + (from_x_to_y_at_price<T0, T1>(arg0, v3, (arg0.bid_ref_price as u64) - (arg0.ref_price_step as u64) * (v1 as u64)) as u128);
                    v2 = v2 - v3;
                    *0x1::vector::borrow_mut<u64>(&mut arg0.bids, v1) = 0;
                };
            } else {
                v0 = v0 + (from_x_to_y_at_price<T0, T1>(arg0, v2, (arg0.bid_ref_price as u64) - (arg0.ref_price_step as u64) * (v1 as u64)) as u128);
                let v4 = 0x1::vector::borrow_mut<u64>(&mut arg0.bids, v1);
                *v4 = *v4 - v2;
                v2 = 0;
            };
            v1 = v1 + 1;
        };
        let v5 = (arg0.fee_millionth as u128) * v0 / 1000000;
        (((v0 - v5) as u64), (v5 as u64), v2)
    }

    public(friend) fun quote_x_to_y_readonly<T0, T1>(arg0: &Pool<T0, T1>, arg1: u64) : (u64, u64, u64) {
        let v0 = 0;
        let v1 = 0;
        let v2 = arg1;
        while (v1 < 0x1::vector::length<u64>(&arg0.bids) && v2 > 0) {
            if (v2 >= *0x1::vector::borrow<u64>(&arg0.bids, v1)) {
                let v3 = *0x1::vector::borrow<u64>(&arg0.bids, v1);
                if (v3 > 0) {
                    v0 = v0 + (from_x_to_y_at_price<T0, T1>(arg0, v3, (arg0.bid_ref_price as u64) - (arg0.ref_price_step as u64) * (v1 as u64)) as u128);
                    v2 = v2 - v3;
                };
            } else {
                v0 = v0 + (from_x_to_y_at_price<T0, T1>(arg0, v2, (arg0.bid_ref_price as u64) - (arg0.ref_price_step as u64) * (v1 as u64)) as u128);
                v2 = 0;
            };
            v1 = v1 + 1;
        };
        let v4 = (arg0.fee_millionth as u128) * v0 / 1000000;
        (((v0 - v4) as u64), (v4 as u64), v2)
    }

    public fun quote_y_to_x<T0, T1>(arg0: &Pool<T0, T1>, arg1: u64) : (u64, u64, u64) {
        quote_y_to_x_readonly<T0, T1>(arg0, arg1)
    }

    fun quote_y_to_x_internal<T0, T1>(arg0: &mut Pool<T0, T1>, arg1: u64) : (u64, u64, u64) {
        assert!(!arg0.stopped, 1);
        let v0 = 0;
        let v1 = 0;
        let v2 = arg1;
        while (v1 < 0x1::vector::length<u64>(&arg0.asks) && v2 > 0) {
            let v3 = arg0.ask_ref_price + (arg0.ref_price_step as u64) * (v1 as u64);
            let v4 = from_y_to_x_at_price<T0, T1>(arg0, v2, v3);
            if (v4 >= *0x1::vector::borrow<u64>(&arg0.asks, v1)) {
                let v5 = *0x1::vector::borrow<u64>(&arg0.asks, v1);
                if (v5 > 0) {
                    v0 = v0 + (v5 as u128);
                    v2 = v2 - from_x_to_y_at_price<T0, T1>(arg0, v5, v3);
                    *0x1::vector::borrow_mut<u64>(&mut arg0.asks, v1) = 0;
                };
            } else {
                v0 = v0 + (v4 as u128);
                v2 = 0;
                let v6 = 0x1::vector::borrow_mut<u64>(&mut arg0.asks, v1);
                *v6 = *v6 - (v4 as u64);
            };
            v1 = v1 + 1;
        };
        let v7 = (arg0.fee_millionth as u128) * v0 / 1000000;
        (((v0 - v7) as u64), (v7 as u64), v2)
    }

    public(friend) fun quote_y_to_x_readonly<T0, T1>(arg0: &Pool<T0, T1>, arg1: u64) : (u64, u64, u64) {
        let v0 = 0;
        let v1 = 0;
        let v2 = arg1;
        while (v1 < 0x1::vector::length<u64>(&arg0.asks) && v2 > 0) {
            let v3 = arg0.ask_ref_price + (arg0.ref_price_step as u64) * (v1 as u64);
            let v4 = from_y_to_x_at_price<T0, T1>(arg0, v2, v3);
            if (v4 >= *0x1::vector::borrow<u64>(&arg0.asks, v1)) {
                let v5 = *0x1::vector::borrow<u64>(&arg0.asks, v1);
                if (v5 > 0) {
                    v0 = v0 + (v5 as u128);
                    v2 = v2 - from_x_to_y_at_price<T0, T1>(arg0, v5, v3);
                };
            } else {
                v0 = v0 + (v4 as u128);
                v2 = 0;
            };
            v1 = v1 + 1;
        };
        let v6 = (arg0.fee_millionth as u128) * v0 / 1000000;
        (((v0 - v6) as u64), (v6 as u64), v2)
    }

    public fun remove_price_feeders<T0, T1>(arg0: &mut Pool<T0, T1>, arg1: &0x2::package::Publisher, arg2: vector<address>) {
        assert!(0x2::package::from_module<POX>(arg1), 13906836940302319615);
        0x1::vector::reverse<address>(&mut arg2);
        let v0 = 0;
        while (v0 < 0x1::vector::length<address>(&arg2)) {
            let v1 = 0x1::vector::pop_back<address>(&mut arg2);
            0x2::vec_set::remove<address>(&mut arg0.price_feeder, &v1);
            v0 = v0 + 1;
        };
        0x1::vector::destroy_empty<address>(arg2);
    }

    public fun set_fee_collector<T0, T1>(arg0: &0x2::package::Publisher, arg1: &mut Pool<T0, T1>, arg2: address) {
        assert!(0x2::package::from_module<POX>(arg0), 13906835802135986175);
        arg1.fee_collector = arg2;
    }

    public fun stop<T0, T1>(arg0: &0x2::package::Publisher, arg1: &mut Pool<T0, T1>) {
        assert!(0x2::package::from_module<POX>(arg0), 13906834350437040127);
        arg1.stopped = true;
        let v0 = EventStop{
            pool_id : 0x2::object::id<Pool<T0, T1>>(arg1),
            stopped : true,
        };
        0x2::event::emit<EventStop>(v0);
    }

    public fun stopped<T0, T1>(arg0: &Pool<T0, T1>) : bool {
        arg0.stopped
    }

    public fun swap_x_to_y<T0, T1>(arg0: &mut Pool<T0, T1>, arg1: 0x2::balance::Balance<T0>, arg2: &0x2::clock::Clock, arg3: &mut 0x2::tx_context::TxContext) : (0x2::balance::Balance<T0>, 0x2::balance::Balance<T1>) {
        assert!(!arg0.stopped, 1);
        let v0 = 0x2::balance::value<T0>(&arg1);
        let (v1, v2, v3) = quote_x_to_y_internal<T0, T1>(arg0, v0);
        let v4 = if (v3 > 0) {
            0x2::balance::split<T0>(&mut arg1, v3)
        } else {
            0x2::balance::zero<T0>()
        };
        0x2::balance::join<T0>(&mut arg0.reserve_x, arg1);
        arg0.fee_y = arg0.fee_y + v2;
        let v5 = SwapEvent{
            pool_id    : 0x2::object::id<Pool<T0, T1>>(arg0),
            x2y        : true,
            in_amount  : v0 - v3,
            out_amount : v1,
            fee_amount : v2,
            ts         : 0x2::clock::timestamp_ms(arg2),
        };
        0x2::event::emit<SwapEvent>(v5);
        (v4, 0x2::balance::split<T1>(&mut arg0.reserve_y, v1))
    }

    public fun swap_x_to_y_transfer<T0, T1>(arg0: &mut Pool<T0, T1>, arg1: 0x2::coin::Coin<T0>, arg2: &0x2::clock::Clock, arg3: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = swap_x_to_y<T0, T1>(arg0, 0x2::coin::into_balance<T0>(arg1), arg2, arg3);
        let v2 = v0;
        if (0x2::balance::value<T0>(&v2) == 0) {
            0x2::balance::destroy_zero<T0>(v2);
        } else {
            0x2::transfer::public_transfer<0x2::coin::Coin<T0>>(0x2::coin::from_balance<T0>(v2, arg3), 0x2::tx_context::sender(arg3));
        };
        0x2::transfer::public_transfer<0x2::coin::Coin<T1>>(0x2::coin::from_balance<T1>(v1, arg3), 0x2::tx_context::sender(arg3));
    }

    public fun swap_y_to_x<T0, T1>(arg0: &mut Pool<T0, T1>, arg1: 0x2::balance::Balance<T1>, arg2: &0x2::clock::Clock, arg3: &mut 0x2::tx_context::TxContext) : (0x2::balance::Balance<T0>, 0x2::balance::Balance<T1>) {
        assert!(!arg0.stopped, 1);
        let v0 = 0x2::balance::value<T1>(&arg1);
        let (v1, v2, v3) = quote_y_to_x_internal<T0, T1>(arg0, v0);
        let v4 = if (v3 > 0) {
            0x2::balance::split<T1>(&mut arg1, v3)
        } else {
            0x2::balance::zero<T1>()
        };
        0x2::balance::join<T1>(&mut arg0.reserve_y, arg1);
        arg0.fee_x = arg0.fee_x + v2;
        let v5 = SwapEvent{
            pool_id    : 0x2::object::id<Pool<T0, T1>>(arg0),
            x2y        : false,
            in_amount  : v0 - v3,
            out_amount : v1,
            fee_amount : v2,
            ts         : 0x2::clock::timestamp_ms(arg2),
        };
        0x2::event::emit<SwapEvent>(v5);
        (0x2::balance::split<T0>(&mut arg0.reserve_x, v1), v4)
    }

    public fun swap_y_to_x_transfer<T0, T1>(arg0: &mut Pool<T0, T1>, arg1: 0x2::coin::Coin<T1>, arg2: &0x2::clock::Clock, arg3: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = swap_y_to_x<T0, T1>(arg0, 0x2::coin::into_balance<T1>(arg1), arg2, arg3);
        let v2 = v1;
        if (0x2::balance::value<T1>(&v2) == 0) {
            0x2::balance::destroy_zero<T1>(v2);
        } else {
            0x2::transfer::public_transfer<0x2::coin::Coin<T1>>(0x2::coin::from_balance<T1>(v2, arg3), 0x2::tx_context::sender(arg3));
        };
        0x2::transfer::public_transfer<0x2::coin::Coin<T0>>(0x2::coin::from_balance<T0>(v0, arg3), 0x2::tx_context::sender(arg3));
    }

    public fun unstop<T0, T1>(arg0: &0x2::package::Publisher, arg1: &mut Pool<T0, T1>) {
        assert!(0x2::package::from_module<POX>(arg0), 13906834376206843903);
        arg1.stopped = false;
        let v0 = EventStop{
            pool_id : 0x2::object::id<Pool<T0, T1>>(arg1),
            stopped : false,
        };
        0x2::event::emit<EventStop>(v0);
    }

    public fun update_all_asks<T0, T1>(arg0: &mut Pool<T0, T1>, arg1: u64, arg2: vector<u64>, arg3: &0x2::clock::Clock, arg4: &mut 0x2::tx_context::TxContext) {
        assert!(!arg0.stopped, 1);
        assert!(address_is_price_feeder<T0, T1>(arg0, 0x2::tx_context::sender(arg4)), 3);
        assert!(0x1::vector::length<u64>(&arg2) <= 0x1::vector::length<u64>(&arg0.asks), 13906836162913239039);
        arg0.ask_ref_price = arg1;
        let v0 = 0;
        while (v0 < 0x1::vector::length<u64>(&arg2)) {
            *0x1::vector::borrow_mut<u64>(&mut arg0.asks, v0) = *0x1::vector::borrow<u64>(&arg2, v0);
            v0 = v0 + 1;
        };
    }

    public fun update_all_bids<T0, T1>(arg0: &mut Pool<T0, T1>, arg1: u64, arg2: vector<u64>, arg3: &0x2::clock::Clock, arg4: &mut 0x2::tx_context::TxContext) {
        assert!(!arg0.stopped, 1);
        assert!(address_is_price_feeder<T0, T1>(arg0, 0x2::tx_context::sender(arg4)), 3);
        assert!(0x1::vector::length<u64>(&arg2) <= 0x1::vector::length<u64>(&arg0.bids), 13906836248812584959);
        arg0.bid_ref_price = arg1;
        let v0 = 0;
        while (v0 < 0x1::vector::length<u64>(&arg2)) {
            *0x1::vector::borrow_mut<u64>(&mut arg0.bids, v0) = *0x1::vector::borrow<u64>(&arg2, v0);
            v0 = v0 + 1;
        };
    }

    public fun update_ask<T0, T1>(arg0: &mut Pool<T0, T1>, arg1: u64, arg2: u64, arg3: &0x2::clock::Clock, arg4: &mut 0x2::tx_context::TxContext) {
        assert!(!arg0.stopped, 1);
        assert!(address_is_price_feeder<T0, T1>(arg0, 0x2::tx_context::sender(arg4)), 3);
        let v0 = 0;
        let v1 = false;
        while (v0 < 0x1::vector::length<u64>(&arg0.asks)) {
            if (arg0.ask_ref_price + (arg0.ref_price_step as u64) * (v0 as u64) == arg1) {
                *0x1::vector::borrow_mut<u64>(&mut arg0.asks, v0) = arg2;
                v1 = true;
                break
            };
            v0 = v0 + 1;
        };
        assert!(v1, 13906836012589383679);
    }

    public fun update_bid<T0, T1>(arg0: &mut Pool<T0, T1>, arg1: u64, arg2: u64, arg3: &0x2::clock::Clock, arg4: &mut 0x2::tx_context::TxContext) {
        assert!(!arg0.stopped, 1);
        assert!(address_is_price_feeder<T0, T1>(arg0, 0x2::tx_context::sender(arg4)), 3);
        let v0 = 0;
        let v1 = false;
        while (v0 < 0x1::vector::length<u64>(&arg0.bids)) {
            if (arg0.bid_ref_price - (arg0.ref_price_step as u64) * (v0 as u64) == arg1) {
                *0x1::vector::borrow_mut<u64>(&mut arg0.bids, v0) = arg2;
                v1 = true;
                break
            };
            v0 = v0 + 1;
        };
        assert!(v1, 13906836111373631487);
    }

    public fun update_ref_price<T0, T1>(arg0: &mut Pool<T0, T1>, arg1: u64, arg2: u64) {
        assert!(!arg0.stopped, 1);
        assert!(arg1 > arg2, 4);
        arg0.ask_ref_price = arg1;
        arg0.bid_ref_price = arg2;
    }

    public fun withdraw<T0, T1>(arg0: &mut Pool<T0, T1>, arg1: &LiquidityProviderCap, arg2: u64, arg3: u64) : (0x2::balance::Balance<T0>, 0x2::balance::Balance<T1>) {
        assert!(0x2::object::id<Pool<T0, T1>>(arg0) == arg1.pool, 13906834685444489215);
        let v0 = if (arg2 == 0) {
            0x2::balance::zero<T0>()
        } else {
            0x2::balance::split<T0>(&mut arg0.reserve_x, arg2)
        };
        let v1 = if (arg3 == 0) {
            0x2::balance::zero<T1>()
        } else {
            0x2::balance::split<T1>(&mut arg0.reserve_y, arg3)
        };
        (v0, v1)
    }

    public fun withdraw_extenral<T0, T1>(arg0: &mut Pool<T0, T1>, arg1: &LiquidityProviderCap, arg2: u64, arg3: u64, arg4: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = withdraw<T0, T1>(arg0, arg1, arg2, arg3);
        0x2::transfer::public_transfer<0x2::coin::Coin<T0>>(0x2::coin::from_balance<T0>(v0, arg4), 0x2::tx_context::sender(arg4));
        0x2::transfer::public_transfer<0x2::coin::Coin<T1>>(0x2::coin::from_balance<T1>(v1, arg4), 0x2::tx_context::sender(arg4));
    }

    // decompiled from Move bytecode v6
}

