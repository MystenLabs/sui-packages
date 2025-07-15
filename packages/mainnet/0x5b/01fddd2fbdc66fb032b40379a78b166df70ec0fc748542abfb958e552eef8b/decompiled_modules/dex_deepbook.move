module 0x5b01fddd2fbdc66fb032b40379a78b166df70ec0fc748542abfb958e552eef8b::dex_deepbook {
    struct DeepBookPool has store, key {
        id: 0x2::object::UID,
        base_asset: vector<u8>,
        quote_asset: vector<u8>,
        tick_size: u64,
        lot_size: u64,
        base_custodian: 0x2::object::ID,
        quote_custodian: 0x2::object::ID,
        fee_rate: u64,
        min_size: u64,
        created_at: u64,
    }

    struct DeepBookOrder has store, key {
        id: 0x2::object::UID,
        pool_id: 0x2::object::ID,
        price: u64,
        quantity: u64,
        is_bid: bool,
        owner: address,
        client_order_id: u64,
        expire_timestamp: u64,
        restriction: u8,
        created_at: u64,
    }

    struct DeepBookAccountCap has store, key {
        id: 0x2::object::UID,
        owner: address,
        created_at: u64,
    }

    struct DeepBookSwapParams has copy, drop, store {
        pool_id: 0x2::object::ID,
        base_asset: vector<u8>,
        quote_asset: vector<u8>,
        amount_in: u64,
        min_amount_out: u64,
        is_base_to_quote: bool,
        deadline: u64,
        client_order_id: u64,
    }

    struct DeepBookSwapRoute has copy, drop, store {
        pool_id: 0x2::object::ID,
        base_asset: vector<u8>,
        quote_asset: vector<u8>,
        amount_in: u64,
        amount_out: u64,
        fee: u64,
        tick_size: u64,
        lot_size: u64,
    }

    struct DeepBookSwapEvent has copy, drop, store {
        pool_id: 0x2::object::ID,
        user: address,
        base_asset: vector<u8>,
        quote_asset: vector<u8>,
        amount_in: u64,
        amount_out: u64,
        fee_paid: u64,
        is_base_to_quote: bool,
        timestamp: u64,
    }

    public fun build_deepbook_swap_route(arg0: 0x2::object::ID, arg1: vector<u8>, arg2: vector<u8>, arg3: u64, arg4: u64, arg5: u64) : DeepBookSwapRoute {
        DeepBookSwapRoute{
            pool_id     : arg0,
            base_asset  : arg1,
            quote_asset : arg2,
            amount_in   : arg3,
            amount_out  : calculate_deepbook_swap_amount_out(arg3, arg0, true),
            fee         : arg3 * 25 / 10000,
            tick_size   : arg4,
            lot_size    : arg5,
        }
    }

    public fun calculate_deepbook_swap_amount_out(arg0: u64, arg1: 0x2::object::ID, arg2: bool) : u64 {
        let (v0, v1, v2, _) = get_deepbook_pool_info(arg1);
        if (arg2) {
            arg0 * (10000 - v2) / 10000 / v1 * v1 * v0 / 1000
        } else {
            arg0 * (10000 - v2) / 10000 / v1 * v1 * 1000 / v0
        }
    }

    public fun create_deepbook_account_cap(arg0: address, arg1: &mut 0x2::tx_context::TxContext) : DeepBookAccountCap {
        DeepBookAccountCap{
            id         : 0x2::object::new(arg1),
            owner      : arg0,
            created_at : 0,
        }
    }

    public fun create_deepbook_pool(arg0: vector<u8>, arg1: vector<u8>, arg2: u64, arg3: u64, arg4: u64, arg5: u64, arg6: &mut 0x2::tx_context::TxContext) : DeepBookPool {
        DeepBookPool{
            id              : 0x2::object::new(arg6),
            base_asset      : arg0,
            quote_asset     : arg1,
            tick_size       : arg2,
            lot_size        : arg3,
            base_custodian  : 0x2::object::id_from_address(@0x0),
            quote_custodian : 0x2::object::id_from_address(@0x0),
            fee_rate        : arg4,
            min_size        : arg5,
            created_at      : 0,
        }
    }

    public fun deepbook_atomic_arbitrage_swap<T0>(arg0: 0x2::object::ID, arg1: 0x2::object::ID, arg2: &DeepBookAccountCap, arg3: 0x2::coin::Coin<0x2::sui::SUI>, arg4: u64, arg5: u64, arg6: u64, arg7: u64, arg8: &0x2::clock::Clock, arg9: &mut 0x2::tx_context::TxContext) : 0x2::coin::Coin<0x2::sui::SUI> {
        let v0 = 0x2::coin::value<0x2::sui::SUI>(&arg3);
        assert!(v0 == 10000000, 4);
        assert!(0x2::clock::timestamp_ms(arg8) <= arg7, 6);
        let v1 = swap_exact_base_for_quote<0x2::sui::SUI, T0>(arg0, arg2, arg3, 0, arg5, arg7, arg8, arg9);
        let v2 = swap_exact_quote_for_base<0x2::sui::SUI, T0>(arg1, arg2, v1, v0 + arg4, arg6, arg7, arg8, arg9);
        assert!(0x2::coin::value<0x2::sui::SUI>(&v2) > v0 + arg4, 3);
        v2
    }

    public fun deepbook_balance_to_coin<T0>(arg0: 0x2::balance::Balance<T0>, arg1: &mut 0x2::tx_context::TxContext) : 0x2::coin::Coin<T0> {
        0x2::coin::from_balance<T0>(arg0, arg1)
    }

    public fun deepbook_coin_to_balance<T0>(arg0: 0x2::coin::Coin<T0>) : 0x2::balance::Balance<T0> {
        0x2::coin::into_balance<T0>(arg0)
    }

    public fun deepbook_merge_balances<T0>(arg0: &mut 0x2::balance::Balance<T0>, arg1: 0x2::balance::Balance<T0>) {
        0x2::balance::join<T0>(arg0, arg1);
    }

    public fun deepbook_split_balance<T0>(arg0: &mut 0x2::balance::Balance<T0>, arg1: u64, arg2: &mut 0x2::tx_context::TxContext) : 0x2::coin::Coin<T0> {
        0x2::coin::from_balance<T0>(0x2::balance::split<T0>(arg0, arg1), arg2)
    }

    public fun get_account_cap_owner(arg0: &DeepBookAccountCap) : address {
        arg0.owner
    }

    public fun get_deepbook_pool_info(arg0: 0x2::object::ID) : (u64, u64, u64, u64) {
        (1000, 1000, 25, 1000)
    }

    public fun get_pool_base_asset(arg0: &DeepBookPool) : vector<u8> {
        arg0.base_asset
    }

    public fun get_pool_fee_rate(arg0: &DeepBookPool) : u64 {
        arg0.fee_rate
    }

    public fun get_pool_lot_size(arg0: &DeepBookPool) : u64 {
        arg0.lot_size
    }

    public fun get_pool_min_size(arg0: &DeepBookPool) : u64 {
        arg0.min_size
    }

    public fun get_pool_quote_asset(arg0: &DeepBookPool) : vector<u8> {
        arg0.quote_asset
    }

    public fun get_pool_tick_size(arg0: &DeepBookPool) : u64 {
        arg0.tick_size
    }

    public fun swap_exact_base_for_quote<T0, T1>(arg0: 0x2::object::ID, arg1: &DeepBookAccountCap, arg2: 0x2::coin::Coin<T0>, arg3: u64, arg4: u64, arg5: u64, arg6: &0x2::clock::Clock, arg7: &mut 0x2::tx_context::TxContext) : 0x2::coin::Coin<T1> {
        let v0 = 0x2::clock::timestamp_ms(arg6);
        assert!(v0 <= arg5, 6);
        let v1 = 0x2::coin::value<T0>(&arg2);
        assert!(v1 > 0, 4);
        let v2 = 0x2::coin::into_balance<T0>(arg2);
        let v3 = calculate_deepbook_swap_amount_out(v1, arg0, true);
        assert!(v3 >= arg3, 3);
        let v4 = DeepBookSwapEvent{
            pool_id          : arg0,
            user             : 0x2::tx_context::sender(arg7),
            base_asset       : b"BaseAsset",
            quote_asset      : b"QuoteAsset",
            amount_in        : v1,
            amount_out       : v3,
            fee_paid         : v1 * 25 / 10000,
            is_base_to_quote : true,
            timestamp        : v0,
        };
        0x2::event::emit<DeepBookSwapEvent>(v4);
        if (0x2::balance::value<T0>(&v2) > 0) {
            0x2::balance::destroy_zero<T0>(v2);
        } else {
            0x2::balance::destroy_zero<T0>(v2);
        };
        0x2::coin::from_balance<T1>(0x2::balance::zero<T1>(), arg7)
    }

    public fun swap_exact_quote_for_base<T0, T1>(arg0: 0x2::object::ID, arg1: &DeepBookAccountCap, arg2: 0x2::coin::Coin<T1>, arg3: u64, arg4: u64, arg5: u64, arg6: &0x2::clock::Clock, arg7: &mut 0x2::tx_context::TxContext) : 0x2::coin::Coin<T0> {
        let v0 = 0x2::clock::timestamp_ms(arg6);
        assert!(v0 <= arg5, 6);
        let v1 = 0x2::coin::value<T1>(&arg2);
        assert!(v1 > 0, 4);
        let v2 = 0x2::coin::into_balance<T1>(arg2);
        let v3 = calculate_deepbook_swap_amount_out(v1, arg0, false);
        assert!(v3 >= arg3, 3);
        let v4 = DeepBookSwapEvent{
            pool_id          : arg0,
            user             : 0x2::tx_context::sender(arg7),
            base_asset       : b"BaseAsset",
            quote_asset      : b"QuoteAsset",
            amount_in        : v1,
            amount_out       : v3,
            fee_paid         : v1 * 25 / 10000,
            is_base_to_quote : false,
            timestamp        : v0,
        };
        0x2::event::emit<DeepBookSwapEvent>(v4);
        if (0x2::balance::value<T1>(&v2) > 0) {
            0x2::balance::destroy_zero<T1>(v2);
        } else {
            0x2::balance::destroy_zero<T1>(v2);
        };
        0x2::coin::from_balance<T0>(0x2::balance::zero<T0>(), arg7)
    }

    // decompiled from Move bytecode v6
}

