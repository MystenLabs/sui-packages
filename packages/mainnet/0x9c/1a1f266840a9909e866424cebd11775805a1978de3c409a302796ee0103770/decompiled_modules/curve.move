module 0x9c1a1f266840a9909e866424cebd11775805a1978de3c409a302796ee0103770::curve {
    struct LockKey has copy, drop, store {
        dummy_field: bool,
    }

    struct PoolCapKey has copy, drop, store {
        dummy_field: bool,
    }

    struct Curve<phantom T0> has key {
        id: 0x2::object::UID,
        creator: 0x2::object::ID,
        name: 0x1::string::String,
        symbol: 0x1::string::String,
        decimals: u8,
        virtual_sui: u128,
        virtual_tokens: u128,
        initial_virtual_sui: u64,
        sui: 0x2::balance::Balance<0x2::sui::SUI>,
        tokens: 0x2::balance::Balance<T0>,
        sold: u64,
        curve_supply: u64,
        trade_fee_bps: u64,
        creator_fee_bps: u64,
        creator_fees: 0x2::balance::Balance<0x2::sui::SUI>,
        creator_token_fees: 0x2::balance::Balance<T0>,
        complete: bool,
        pool: 0x1::option::Option<0x2::object::ID>,
    }

    struct Graduation<phantom T0> {
        curve: 0x2::object::ID,
    }

    struct Traded has copy, drop {
        curve: 0x2::object::ID,
        account: 0x2::object::ID,
        is_buy: bool,
        sui_amount: u64,
        token_amount: u64,
        fee: u64,
        creator_fee: u64,
        virtual_sui: u64,
        virtual_tokens: u64,
        sold: u64,
        complete: bool,
    }

    struct RoutedTrade has copy, drop {
        curve: 0x2::object::ID,
        account: 0x2::object::ID,
        is_buy: bool,
        amount_in: u64,
        min_out: u64,
    }

    struct Completed has copy, drop {
        curve: 0x2::object::ID,
        sui_reserve: u64,
    }

    struct Graduated has copy, drop {
        curve: 0x2::object::ID,
        pool: 0x2::object::ID,
        sui: u64,
        tokens: u64,
    }

    struct CreatorFeesClaimed has copy, drop {
        curve: 0x2::object::ID,
        account: 0x2::object::ID,
        sui: u64,
        tokens: u64,
    }

    public(friend) fun new<T0>(arg0: &0x9c1a1f266840a9909e866424cebd11775805a1978de3c409a302796ee0103770::config::Config, arg1: 0x2::object::ID, arg2: 0x1::string::String, arg3: 0x1::string::String, arg4: u8, arg5: 0x2::balance::Balance<T0>, arg6: &mut 0x2::tx_context::TxContext) : Curve<T0> {
        Curve<T0>{
            id                  : 0x2::object::new(arg6),
            creator             : arg1,
            name                : arg2,
            symbol              : arg3,
            decimals            : arg4,
            virtual_sui         : (0x9c1a1f266840a9909e866424cebd11775805a1978de3c409a302796ee0103770::config::virtual_sui(arg0) as u128),
            virtual_tokens      : (0x9c1a1f266840a9909e866424cebd11775805a1978de3c409a302796ee0103770::config::virtual_tokens(arg0) as u128),
            initial_virtual_sui : 0x9c1a1f266840a9909e866424cebd11775805a1978de3c409a302796ee0103770::config::virtual_sui(arg0),
            sui                 : 0x2::balance::zero<0x2::sui::SUI>(),
            tokens              : arg5,
            sold                : 0,
            curve_supply        : 0x9c1a1f266840a9909e866424cebd11775805a1978de3c409a302796ee0103770::config::curve_supply(arg0),
            trade_fee_bps       : 0x9c1a1f266840a9909e866424cebd11775805a1978de3c409a302796ee0103770::config::trade_fee_bps(arg0),
            creator_fee_bps     : 0x9c1a1f266840a9909e866424cebd11775805a1978de3c409a302796ee0103770::config::creator_fee_bps(arg0),
            creator_fees        : 0x2::balance::zero<0x2::sui::SUI>(),
            creator_token_fees  : 0x2::balance::zero<T0>(),
            complete            : false,
            pool                : 0x1::option::none<0x2::object::ID>(),
        }
    }

    public fun curve_supply<T0>(arg0: &Curve<T0>) : u64 {
        arg0.curve_supply
    }

    fun action<T0>(arg0: vector<u8>, arg1: &Curve<T0>, arg2: vector<u8>) : vector<u8> {
        0x1::vector::append<u8>(&mut arg0, b" $");
        0x1::vector::append<u8>(&mut arg0, sym<T0>(arg1));
        0x1::vector::append<u8>(&mut arg0, arg2);
        0x9c1a1f266840a9909e866424cebd11775805a1978de3c409a302796ee0103770::account::headline(arg0)
    }

    public fun add_creator_fees<T0>(arg0: &mut Curve<T0>, arg1: 0x2::balance::Balance<0x2::sui::SUI>, arg2: 0x2::balance::Balance<T0>) {
        0x2::balance::join<0x2::sui::SUI>(&mut arg0.creator_fees, arg1);
        0x2::balance::join<T0>(&mut arg0.creator_token_fees, arg2);
    }

    public(friend) fun attach_pool_cap<T0, T1: store + key>(arg0: &mut Curve<T0>, arg1: T1) {
        let v0 = PoolCapKey{dummy_field: false};
        0x2::dynamic_object_field::add<PoolCapKey, T1>(&mut arg0.id, v0, arg1);
    }

    public fun begin_graduation<T0, T1: drop>(arg0: &0x9c1a1f266840a9909e866424cebd11775805a1978de3c409a302796ee0103770::config::Config, arg1: T1, arg2: &mut Curve<T0>, arg3: &mut 0x2::tx_context::TxContext) : (0x2::coin::Coin<0x2::sui::SUI>, 0x2::coin::Coin<T0>, Graduation<T0>) {
        0x9c1a1f266840a9909e866424cebd11775805a1978de3c409a302796ee0103770::config::assert_graduator<T1>(arg0, &arg1);
        assert!(arg2.complete, 13906836141438664709);
        assert!(0x1::option::is_none<0x2::object::ID>(&arg2.pool), 13906836145733894153);
        let v0 = Graduation<T0>{curve: 0x2::object::id<Curve<T0>>(arg2)};
        (0x2::coin::from_balance<0x2::sui::SUI>(0x2::balance::withdraw_all<0x2::sui::SUI>(&mut arg2.sui), arg3), 0x2::coin::from_balance<T0>(0x2::balance::withdraw_all<T0>(&mut arg2.tokens), arg3), v0)
    }

    public fun borrow_lock_mut<T0, T1: store + key, T2: drop>(arg0: &0x9c1a1f266840a9909e866424cebd11775805a1978de3c409a302796ee0103770::config::Config, arg1: T2, arg2: &mut Curve<T0>) : &mut T1 {
        0x9c1a1f266840a9909e866424cebd11775805a1978de3c409a302796ee0103770::config::assert_graduator<T2>(arg0, &arg1);
        let v0 = LockKey{dummy_field: false};
        0x2::dynamic_object_field::borrow_mut<LockKey, T1>(&mut arg2.id, v0)
    }

    public fun borrow_pool_cap<T0, T1: store + key, T2: drop>(arg0: &0x9c1a1f266840a9909e866424cebd11775805a1978de3c409a302796ee0103770::config::Config, arg1: T2, arg2: &Curve<T0>) : &T1 {
        0x9c1a1f266840a9909e866424cebd11775805a1978de3c409a302796ee0103770::config::assert_graduator<T2>(arg0, &arg1);
        let v0 = PoolCapKey{dummy_field: false};
        0x2::dynamic_object_field::borrow<PoolCapKey, T1>(&arg2.id, v0)
    }

    public fun buy<T0>(arg0: &mut 0x9c1a1f266840a9909e866424cebd11775805a1978de3c409a302796ee0103770::config::Config, arg1: &mut 0x9c1a1f266840a9909e866424cebd11775805a1978de3c409a302796ee0103770::account::Account, arg2: &mut Curve<T0>, arg3: u64, arg4: u64, arg5: u64, arg6: u64, arg7: u64, arg8: vector<u8>, arg9: &0x2::clock::Clock, arg10: &mut 0x2::tx_context::TxContext) {
        let v0 = action<T0>(b"buy", arg2, b"");
        0x1::vector::append<u8>(&mut v0, 0x9c1a1f266840a9909e866424cebd11775805a1978de3c409a302796ee0103770::fmt::line(b"Pay", sui_amount(arg3)));
        0x1::vector::append<u8>(&mut v0, 0x9c1a1f266840a9909e866424cebd11775805a1978de3c409a302796ee0103770::fmt::line(b"Get at least", tok_amount<T0>(arg2, arg4)));
        0x1::vector::append<u8>(&mut v0, token_line<T0>());
        0x9c1a1f266840a9909e866424cebd11775805a1978de3c409a302796ee0103770::account::authorize(arg0, arg1, v0, arg5, arg6, arg7, arg8, arg9, arg10);
        let (v1, v2) = buy_balance<T0>(arg0, arg2, 0x2::object::id<0x9c1a1f266840a9909e866424cebd11775805a1978de3c409a302796ee0103770::account::Account>(arg1), 0x9c1a1f266840a9909e866424cebd11775805a1978de3c409a302796ee0103770::account::take_sui(arg1, arg3));
        let v3 = v1;
        assert!(0x2::balance::value<T0>(&v3) >= arg4, 13906835583093309451);
        0x9c1a1f266840a9909e866424cebd11775805a1978de3c409a302796ee0103770::account::put_token<T0>(arg1, v3);
        0x9c1a1f266840a9909e866424cebd11775805a1978de3c409a302796ee0103770::account::put_sui(arg1, v2);
        0x9c1a1f266840a9909e866424cebd11775805a1978de3c409a302796ee0103770::account::charge_relay_fee(arg1, arg5, arg10);
    }

    public(friend) fun buy_balance<T0>(arg0: &mut 0x9c1a1f266840a9909e866424cebd11775805a1978de3c409a302796ee0103770::config::Config, arg1: &mut Curve<T0>, arg2: 0x2::object::ID, arg3: 0x2::balance::Balance<0x2::sui::SUI>) : (0x2::balance::Balance<T0>, 0x2::balance::Balance<0x2::sui::SUI>) {
        assert!(!arg1.complete, 13906835149301088259);
        let v0 = 0x2::balance::value<0x2::sui::SUI>(&arg3);
        assert!(v0 > 0, 13906835157891678221);
        let (v1, v2, v3) = quote_buy<T0>(arg1, v0);
        arg1.virtual_sui = arg1.virtual_sui + (0x2::balance::value<0x2::sui::SUI>(&arg3) as u128);
        arg1.virtual_tokens = arg1.virtual_tokens - (v1 as u128);
        arg1.sold = arg1.sold + v1;
        0x2::balance::join<0x2::sui::SUI>(&mut arg1.sui, arg3);
        let v4 = split_fee<T0>(arg0, arg1, 0x2::balance::split<0x2::sui::SUI>(&mut arg3, v3));
        if (arg1.sold == arg1.curve_supply) {
            arg1.complete = true;
            let v5 = Completed{
                curve       : 0x2::object::id<Curve<T0>>(arg1),
                sui_reserve : 0x2::balance::value<0x2::sui::SUI>(&arg1.sui),
            };
            0x2::event::emit<Completed>(v5);
        };
        let v6 = Traded{
            curve          : 0x2::object::id<Curve<T0>>(arg1),
            account        : arg2,
            is_buy         : true,
            sui_amount     : v2,
            token_amount   : v1,
            fee            : v3,
            creator_fee    : v4,
            virtual_sui    : (arg1.virtual_sui as u64),
            virtual_tokens : (arg1.virtual_tokens as u64),
            sold           : arg1.sold,
            complete       : arg1.complete,
        };
        0x2::event::emit<Traded>(v6);
        (0x2::balance::split<T0>(&mut arg1.tokens, v1), 0x2::balance::split<0x2::sui::SUI>(&mut arg3, v0 - v2))
    }

    public fun buy_routed<T0>(arg0: &0x9c1a1f266840a9909e866424cebd11775805a1978de3c409a302796ee0103770::config::Config, arg1: &mut 0x9c1a1f266840a9909e866424cebd11775805a1978de3c409a302796ee0103770::account::Account, arg2: &Curve<T0>, arg3: u64, arg4: u64, arg5: u64, arg6: u64, arg7: u64, arg8: vector<u8>, arg9: &0x2::clock::Clock, arg10: &mut 0x2::tx_context::TxContext) : (0x2::coin::Coin<0x2::sui::SUI>, 0x9c1a1f266840a9909e866424cebd11775805a1978de3c409a302796ee0103770::account::Ticket<T0>) {
        assert!(0x1::option::is_some<0x2::object::ID>(&arg2.pool), 13906835900920627207);
        assert!(arg3 > 0, 13906835905215987725);
        let v0 = action<T0>(b"buy", arg2, b" on Cetus");
        0x1::vector::append<u8>(&mut v0, 0x9c1a1f266840a9909e866424cebd11775805a1978de3c409a302796ee0103770::fmt::line(b"Pay", sui_amount(arg3)));
        0x1::vector::append<u8>(&mut v0, 0x9c1a1f266840a9909e866424cebd11775805a1978de3c409a302796ee0103770::fmt::line(b"Get at least", tok_amount<T0>(arg2, arg4)));
        0x1::vector::append<u8>(&mut v0, token_line<T0>());
        0x9c1a1f266840a9909e866424cebd11775805a1978de3c409a302796ee0103770::account::authorize(arg0, arg1, v0, arg5, arg6, arg7, arg8, arg9, arg10);
        let v1 = RoutedTrade{
            curve     : 0x2::object::id<Curve<T0>>(arg2),
            account   : 0x2::object::id<0x9c1a1f266840a9909e866424cebd11775805a1978de3c409a302796ee0103770::account::Account>(arg1),
            is_buy    : true,
            amount_in : arg3,
            min_out   : arg4,
        };
        0x2::event::emit<RoutedTrade>(v1);
        0x9c1a1f266840a9909e866424cebd11775805a1978de3c409a302796ee0103770::account::begin_swap_from_sui<T0>(arg1, arg3, arg4, arg5, arg10)
    }

    fun ceil_div(arg0: u128, arg1: u128) : u128 {
        (arg0 + arg1 - 1) / arg1
    }

    public fun claim_creator_fees<T0>(arg0: &mut Curve<T0>, arg1: &mut 0x9c1a1f266840a9909e866424cebd11775805a1978de3c409a302796ee0103770::account::Account) {
        assert!(0x2::object::id<0x9c1a1f266840a9909e866424cebd11775805a1978de3c409a302796ee0103770::account::Account>(arg1) == arg0.creator, 13906836068425007121);
        let v0 = 0x2::balance::value<0x2::sui::SUI>(&arg0.creator_fees);
        let v1 = 0x2::balance::value<T0>(&arg0.creator_token_fees);
        if (v0 > 0) {
            0x9c1a1f266840a9909e866424cebd11775805a1978de3c409a302796ee0103770::account::credit_fees(arg1, 0x2::balance::withdraw_all<0x2::sui::SUI>(&mut arg0.creator_fees));
        };
        if (v1 > 0) {
            0x9c1a1f266840a9909e866424cebd11775805a1978de3c409a302796ee0103770::account::credit_fees_token<T0>(arg1, 0x2::balance::withdraw_all<T0>(&mut arg0.creator_token_fees));
        };
        let v2 = CreatorFeesClaimed{
            curve   : 0x2::object::id<Curve<T0>>(arg0),
            account : arg0.creator,
            sui     : v0,
            tokens  : v1,
        };
        0x2::event::emit<CreatorFeesClaimed>(v2);
    }

    public fun coin_type_bytes<T0>() : vector<u8> {
        0x1::ascii::into_bytes(0x1::type_name::into_string(0x1::type_name::with_defining_ids<T0>()))
    }

    public fun creator<T0>(arg0: &Curve<T0>) : 0x2::object::ID {
        arg0.creator
    }

    public fun creator_fees<T0>(arg0: &Curve<T0>) : (u64, u64) {
        (0x2::balance::value<0x2::sui::SUI>(&arg0.creator_fees), 0x2::balance::value<T0>(&arg0.creator_token_fees))
    }

    fun fee_of(arg0: u64, arg1: u64) : u64 {
        (((arg0 as u128) * (arg1 as u128) / (10000 as u128)) as u64)
    }

    public fun finish_graduation<T0, T1: store + key>(arg0: &mut Curve<T0>, arg1: Graduation<T0>, arg2: 0x2::object::ID, arg3: T1, arg4: 0x2::coin::Coin<0x2::sui::SUI>, arg5: 0x2::coin::Coin<T0>) {
        let Graduation { curve: v0 } = arg1;
        assert!(v0 == 0x2::object::id<Curve<T0>>(arg0), 13906836218748993555);
        0x2::balance::join<0x2::sui::SUI>(&mut arg0.sui, 0x2::coin::into_balance<0x2::sui::SUI>(arg4));
        0x2::balance::join<T0>(&mut arg0.tokens, 0x2::coin::into_balance<T0>(arg5));
        let v1 = LockKey{dummy_field: false};
        0x2::dynamic_object_field::add<LockKey, T1>(&mut arg0.id, v1, arg3);
        arg0.pool = 0x1::option::some<0x2::object::ID>(arg2);
        let v2 = Graduated{
            curve  : v0,
            pool   : arg2,
            sui    : (arg0.virtual_sui as u64) - arg0.initial_virtual_sui - 0x2::coin::value<0x2::sui::SUI>(&arg4),
            tokens : 0x2::coin::value<T0>(&arg5),
        };
        0x2::event::emit<Graduated>(v2);
    }

    public fun has_pool_cap<T0>(arg0: &Curve<T0>) : bool {
        let v0 = PoolCapKey{dummy_field: false};
        0x2::dynamic_object_field::exists<PoolCapKey>(&arg0.id, v0)
    }

    public fun is_complete<T0>(arg0: &Curve<T0>) : bool {
        arg0.complete
    }

    public fun pool<T0>(arg0: &Curve<T0>) : 0x1::option::Option<0x2::object::ID> {
        arg0.pool
    }

    public fun quote_buy<T0>(arg0: &Curve<T0>, arg1: u64) : (u64, u64, u64) {
        let v0 = fee_of(arg1, arg0.trade_fee_bps);
        let v1 = arg0.virtual_sui * arg0.virtual_tokens;
        let v2 = arg0.virtual_tokens - ceil_div(v1, arg0.virtual_sui + ((arg1 - v0) as u128));
        let v3 = ((arg0.curve_supply - arg0.sold) as u128);
        if (v2 < v3) {
            return ((v2 as u64), arg1, v0)
        };
        let v4 = ceil_div(v1, arg0.virtual_tokens - v3) - arg0.virtual_sui;
        let v5 = ceil_div(v4 * (arg0.trade_fee_bps as u128), ((10000 - arg0.trade_fee_bps) as u128));
        let v6 = v4 + v5;
        if (v6 >= (arg1 as u128)) {
            ((v3 as u64), arg1, v0)
        } else {
            ((v3 as u64), (v6 as u64), (v5 as u64))
        }
    }

    public fun quote_sell<T0>(arg0: &Curve<T0>, arg1: u64) : (u64, u64) {
        let v0 = ((arg0.virtual_sui - ceil_div(arg0.virtual_sui * arg0.virtual_tokens, arg0.virtual_tokens + (arg1 as u128))) as u64);
        let v1 = fee_of(v0, arg0.trade_fee_bps);
        (v0 - v1, v1)
    }

    public fun sell<T0>(arg0: &mut 0x9c1a1f266840a9909e866424cebd11775805a1978de3c409a302796ee0103770::config::Config, arg1: &mut 0x9c1a1f266840a9909e866424cebd11775805a1978de3c409a302796ee0103770::account::Account, arg2: &mut Curve<T0>, arg3: u64, arg4: u64, arg5: u64, arg6: u64, arg7: u64, arg8: vector<u8>, arg9: &0x2::clock::Clock, arg10: &mut 0x2::tx_context::TxContext) {
        let v0 = action<T0>(b"sell", arg2, b"");
        0x1::vector::append<u8>(&mut v0, 0x9c1a1f266840a9909e866424cebd11775805a1978de3c409a302796ee0103770::fmt::line(b"Sell", tok_amount<T0>(arg2, arg3)));
        0x1::vector::append<u8>(&mut v0, 0x9c1a1f266840a9909e866424cebd11775805a1978de3c409a302796ee0103770::fmt::line(b"Get at least", sui_amount(arg4)));
        0x1::vector::append<u8>(&mut v0, token_line<T0>());
        0x9c1a1f266840a9909e866424cebd11775805a1978de3c409a302796ee0103770::account::authorize(arg0, arg1, v0, arg5, arg6, arg7, arg8, arg9, arg10);
        let v1 = sell_balance<T0>(arg0, arg2, 0x2::object::id<0x9c1a1f266840a9909e866424cebd11775805a1978de3c409a302796ee0103770::account::Account>(arg1), 0x9c1a1f266840a9909e866424cebd11775805a1978de3c409a302796ee0103770::account::take_token<T0>(arg1, arg3));
        assert!(0x2::balance::value<0x2::sui::SUI>(&v1) >= arg4, 13906835694762459147);
        0x9c1a1f266840a9909e866424cebd11775805a1978de3c409a302796ee0103770::account::credit_trade_sui(arg1, v1);
        0x9c1a1f266840a9909e866424cebd11775805a1978de3c409a302796ee0103770::account::charge_relay_fee(arg1, arg5, arg10);
    }

    fun sell_balance<T0>(arg0: &mut 0x9c1a1f266840a9909e866424cebd11775805a1978de3c409a302796ee0103770::config::Config, arg1: &mut Curve<T0>, arg2: 0x2::object::ID, arg3: 0x2::balance::Balance<T0>) : 0x2::balance::Balance<0x2::sui::SUI> {
        assert!(!arg1.complete, 13906835291035009027);
        let v0 = 0x2::balance::value<T0>(&arg3);
        assert!(v0 > 0, 13906835299625598989);
        assert!(v0 <= arg1.sold, 13906835303920697359);
        let (v1, v2) = quote_sell<T0>(arg1, v0);
        let v3 = v1 + v2;
        arg1.virtual_sui = arg1.virtual_sui - (v3 as u128);
        arg1.virtual_tokens = arg1.virtual_tokens + (v0 as u128);
        arg1.sold = arg1.sold - v0;
        0x2::balance::join<T0>(&mut arg1.tokens, arg3);
        let v4 = 0x2::balance::split<0x2::sui::SUI>(&mut arg1.sui, v3);
        let v5 = split_fee<T0>(arg0, arg1, 0x2::balance::split<0x2::sui::SUI>(&mut v4, v2));
        let v6 = Traded{
            curve          : 0x2::object::id<Curve<T0>>(arg1),
            account        : arg2,
            is_buy         : false,
            sui_amount     : v1,
            token_amount   : v0,
            fee            : v2,
            creator_fee    : v5,
            virtual_sui    : (arg1.virtual_sui as u64),
            virtual_tokens : (arg1.virtual_tokens as u64),
            sold           : arg1.sold,
            complete       : false,
        };
        0x2::event::emit<Traded>(v6);
        v4
    }

    public fun sell_routed<T0>(arg0: &0x9c1a1f266840a9909e866424cebd11775805a1978de3c409a302796ee0103770::config::Config, arg1: &mut 0x9c1a1f266840a9909e866424cebd11775805a1978de3c409a302796ee0103770::account::Account, arg2: &Curve<T0>, arg3: u64, arg4: u64, arg5: u64, arg6: u64, arg7: u64, arg8: vector<u8>, arg9: &0x2::clock::Clock, arg10: &mut 0x2::tx_context::TxContext) : (0x2::coin::Coin<T0>, 0x9c1a1f266840a9909e866424cebd11775805a1978de3c409a302796ee0103770::account::Ticket<0x2::sui::SUI>) {
        assert!(0x1::option::is_some<0x2::object::ID>(&arg2.pool), 13906836003999842311);
        assert!(arg3 > 0, 13906836008295202829);
        let v0 = action<T0>(b"sell", arg2, b" on Cetus");
        0x1::vector::append<u8>(&mut v0, 0x9c1a1f266840a9909e866424cebd11775805a1978de3c409a302796ee0103770::fmt::line(b"Sell", tok_amount<T0>(arg2, arg3)));
        0x1::vector::append<u8>(&mut v0, 0x9c1a1f266840a9909e866424cebd11775805a1978de3c409a302796ee0103770::fmt::line(b"Get at least", sui_amount(arg4)));
        0x1::vector::append<u8>(&mut v0, token_line<T0>());
        0x9c1a1f266840a9909e866424cebd11775805a1978de3c409a302796ee0103770::account::authorize(arg0, arg1, v0, arg5, arg6, arg7, arg8, arg9, arg10);
        let v1 = RoutedTrade{
            curve     : 0x2::object::id<Curve<T0>>(arg2),
            account   : 0x2::object::id<0x9c1a1f266840a9909e866424cebd11775805a1978de3c409a302796ee0103770::account::Account>(arg1),
            is_buy    : false,
            amount_in : arg3,
            min_out   : arg4,
        };
        0x2::event::emit<RoutedTrade>(v1);
        0x9c1a1f266840a9909e866424cebd11775805a1978de3c409a302796ee0103770::account::begin_swap_from_token<T0>(arg1, arg3, arg4, arg5, arg10)
    }

    public fun send_token<T0>(arg0: &0x9c1a1f266840a9909e866424cebd11775805a1978de3c409a302796ee0103770::config::Config, arg1: &mut 0x9c1a1f266840a9909e866424cebd11775805a1978de3c409a302796ee0103770::account::Account, arg2: &Curve<T0>, arg3: u64, arg4: address, arg5: u64, arg6: u64, arg7: u64, arg8: vector<u8>, arg9: &0x2::clock::Clock, arg10: &mut 0x2::tx_context::TxContext) {
        assert!(arg3 > 0, 13906835776366968845);
        let v0 = action<T0>(b"send", arg2, b"");
        0x1::vector::append<u8>(&mut v0, 0x9c1a1f266840a9909e866424cebd11775805a1978de3c409a302796ee0103770::fmt::line(b"Amount", tok_amount<T0>(arg2, arg3)));
        0x1::vector::append<u8>(&mut v0, 0x9c1a1f266840a9909e866424cebd11775805a1978de3c409a302796ee0103770::fmt::line(b"To", 0x9c1a1f266840a9909e866424cebd11775805a1978de3c409a302796ee0103770::fmt::addr(arg4)));
        0x1::vector::append<u8>(&mut v0, token_line<T0>());
        0x9c1a1f266840a9909e866424cebd11775805a1978de3c409a302796ee0103770::account::authorize(arg0, arg1, v0, arg5, arg6, arg7, arg8, arg9, arg10);
        0x9c1a1f266840a9909e866424cebd11775805a1978de3c409a302796ee0103770::account::charge_relay_fee(arg1, arg5, arg10);
        0x2::transfer::public_transfer<0x2::coin::Coin<T0>>(0x2::coin::from_balance<T0>(0x9c1a1f266840a9909e866424cebd11775805a1978de3c409a302796ee0103770::account::take_token<T0>(arg1, arg3), arg10), arg4);
        0x9c1a1f266840a9909e866424cebd11775805a1978de3c409a302796ee0103770::account::emit_sent<T0>(arg1, arg3, arg4);
    }

    public(friend) fun share<T0>(arg0: Curve<T0>) {
        0x2::transfer::share_object<Curve<T0>>(arg0);
    }

    public fun sold<T0>(arg0: &Curve<T0>) : u64 {
        arg0.sold
    }

    fun split_fee<T0>(arg0: &mut 0x9c1a1f266840a9909e866424cebd11775805a1978de3c409a302796ee0103770::config::Config, arg1: &mut Curve<T0>, arg2: 0x2::balance::Balance<0x2::sui::SUI>) : u64 {
        let v0 = if (arg1.trade_fee_bps == 0) {
            0
        } else {
            (((0x2::balance::value<0x2::sui::SUI>(&arg2) as u128) * (arg1.creator_fee_bps as u128) / (arg1.trade_fee_bps as u128)) as u64)
        };
        0x2::balance::join<0x2::sui::SUI>(&mut arg1.creator_fees, 0x2::balance::split<0x2::sui::SUI>(&mut arg2, v0));
        0x9c1a1f266840a9909e866424cebd11775805a1978de3c409a302796ee0103770::config::collect(arg0, arg2);
        v0
    }

    fun sui_amount(arg0: u64) : vector<u8> {
        0x9c1a1f266840a9909e866424cebd11775805a1978de3c409a302796ee0103770::fmt::with_unit(0x9c1a1f266840a9909e866424cebd11775805a1978de3c409a302796ee0103770::fmt::amount(arg0, 9), b"SUI")
    }

    public fun sui_reserve<T0>(arg0: &Curve<T0>) : u64 {
        0x2::balance::value<0x2::sui::SUI>(&arg0.sui)
    }

    fun sym<T0>(arg0: &Curve<T0>) : vector<u8> {
        *0x1::string::as_bytes(&arg0.symbol)
    }

    public fun symbol<T0>(arg0: &Curve<T0>) : 0x1::string::String {
        arg0.symbol
    }

    fun tok_amount<T0>(arg0: &Curve<T0>, arg1: u64) : vector<u8> {
        0x9c1a1f266840a9909e866424cebd11775805a1978de3c409a302796ee0103770::fmt::with_unit(0x9c1a1f266840a9909e866424cebd11775805a1978de3c409a302796ee0103770::fmt::amount(arg1, arg0.decimals), sym<T0>(arg0))
    }

    fun token_line<T0>() : vector<u8> {
        0x9c1a1f266840a9909e866424cebd11775805a1978de3c409a302796ee0103770::fmt::line(b"Token", 0x9c1a1f266840a9909e866424cebd11775805a1978de3c409a302796ee0103770::fmt::type_of<T0>())
    }

    public fun token_reserve<T0>(arg0: &Curve<T0>) : u64 {
        0x2::balance::value<T0>(&arg0.tokens)
    }

    public fun virtual_reserves<T0>(arg0: &Curve<T0>) : (u64, u64) {
        ((arg0.virtual_sui as u64), (arg0.virtual_tokens as u64))
    }

    // decompiled from Move bytecode v7
}

