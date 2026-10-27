module 0x80bb9362e8a0068283729c3c02b6c9dd142962b2b70a1fde5327ca2a1ee3673a::launchpad {
    struct AdminCap has store, key {
        id: 0x2::object::UID,
    }

    struct Config has key {
        id: 0x2::object::UID,
        version: u64,
        fee_recipient: address,
        create_fee: u64,
        trade_fee_bps: u64,
        curve_supply: u64,
        liquidity_supply: u64,
        virtual_sui: u64,
        virtual_token: u64,
        creation_paused: bool,
    }

    struct Pool<phantom T0> has key {
        id: 0x2::object::UID,
        version: u64,
        creator: address,
        sui: 0x2::balance::Balance<0x2::sui::SUI>,
        tokens: 0x2::balance::Balance<T0>,
        liquidity: 0x2::balance::Balance<T0>,
        virtual_sui: u64,
        virtual_token_offset: u64,
        trade_fee_bps: u64,
        graduated: bool,
        total_supply: u64,
        treasury_cap: 0x1::option::Option<0x2::coin::TreasuryCap<T0>>,
        metadata_cap: 0x1::option::Option<0x2::coin_registry::MetadataCap<T0>>,
        created_at_ms: u64,
    }

    struct PoolCreated has copy, drop {
        pool_id: 0x2::object::ID,
        coin_type: 0x1::string::String,
        creator: address,
        total_supply: u64,
        curve_supply: u64,
        liquidity_supply: u64,
        virtual_sui: u64,
        virtual_token: u64,
        trade_fee_bps: u64,
        created_at_ms: u64,
    }

    struct Trade has copy, drop {
        pool_id: 0x2::object::ID,
        coin_type: 0x1::string::String,
        trader: address,
        is_buy: bool,
        sui_amount: u64,
        token_amount: u64,
        fee: u64,
        sui_reserve: u64,
        token_reserve: u64,
        graduated: bool,
        timestamp_ms: u64,
    }

    struct Graduated has copy, drop {
        pool_id: 0x2::object::ID,
        coin_type: 0x1::string::String,
        sui_reserve: u64,
        token_reserve: u64,
        timestamp_ms: u64,
    }

    struct Sealed has copy, drop {
        pool_id: 0x2::object::ID,
        coin_type: 0x1::string::String,
    }

    public fun buy<T0>(arg0: &mut Pool<T0>, arg1: &Config, arg2: 0x2::coin::Coin<0x2::sui::SUI>, arg3: u64, arg4: &0x2::clock::Clock, arg5: &mut 0x2::tx_context::TxContext) : 0x2::coin::Coin<T0> {
        buy_internal<T0>(arg0, arg1, arg2, arg3, arg4, arg5)
    }

    fun buy_internal<T0>(arg0: &mut Pool<T0>, arg1: &Config, arg2: 0x2::coin::Coin<0x2::sui::SUI>, arg3: u64, arg4: &0x2::clock::Clock, arg5: &mut 0x2::tx_context::TxContext) : 0x2::coin::Coin<T0> {
        assert!(arg0.version == 1, 0);
        let v0 = 0x2::coin::value<0x2::sui::SUI>(&arg2);
        assert!(v0 > 0, 4);
        let v1 = mul_div(v0, arg0.trade_fee_bps, 10000);
        let v2 = v1;
        let v3 = v0 - v1;
        let v4 = v3;
        let (v5, v6) = reserves<T0>(arg0);
        let v7 = mul_div(v6, v3, v5 + v3);
        let v8 = v7;
        if (!arg0.graduated && v7 >= 0x2::balance::value<T0>(&arg0.tokens)) {
            let v9 = 0x2::balance::value<T0>(&arg0.tokens);
            v8 = v9;
            let v10 = mul_div_up(v5, v9, v6 - v9);
            v4 = v10;
            let v11 = mul_div_up(v10, arg0.trade_fee_bps, 10000 - arg0.trade_fee_bps);
            let v12 = if (v11 < v0 - v10) {
                v11
            } else {
                v0 - v10
            };
            v2 = v12;
        };
        assert!(v8 > 0 && v8 >= arg3, 5);
        if (v2 > 0) {
            0x2::transfer::public_transfer<0x2::coin::Coin<0x2::sui::SUI>>(0x2::coin::split<0x2::sui::SUI>(&mut arg2, v2, arg5), arg1.fee_recipient);
        };
        0x2::balance::join<0x2::sui::SUI>(&mut arg0.sui, 0x2::coin::into_balance<0x2::sui::SUI>(0x2::coin::split<0x2::sui::SUI>(&mut arg2, v4, arg5)));
        if (0x2::coin::value<0x2::sui::SUI>(&arg2) > 0) {
            0x2::transfer::public_transfer<0x2::coin::Coin<0x2::sui::SUI>>(arg2, 0x2::tx_context::sender(arg5));
        } else {
            0x2::coin::destroy_zero<0x2::sui::SUI>(arg2);
        };
        let v13 = 0x2::coin::from_balance<T0>(0x2::balance::split<T0>(&mut arg0.tokens, v8), arg5);
        emit_trade<T0>(arg0, true, v4, v8, v2, arg4, arg5);
        if (!arg0.graduated && 0x2::balance::value<T0>(&arg0.tokens) == 0) {
            graduate<T0>(arg0, arg4);
        };
        v13
    }

    fun coin_type<T0>() : 0x1::string::String {
        0x1::string::from_ascii(0x1::type_name::into_string(0x1::type_name::with_defining_ids<T0>()))
    }

    public fun create<T0>(arg0: &Config, arg1: 0x2::coin::TreasuryCap<T0>, arg2: 0x2::coin_registry::MetadataCap<T0>, arg3: 0x2::coin::Coin<0x2::sui::SUI>, arg4: 0x2::coin::Coin<0x2::sui::SUI>, arg5: u64, arg6: &0x2::clock::Clock, arg7: &mut 0x2::tx_context::TxContext) : 0x2::coin::Coin<T0> {
        assert!(arg0.version == 1, 0);
        assert!(!arg0.creation_paused, 1);
        assert!(0x2::coin::total_supply<T0>(&arg1) == 0, 2);
        assert!(0x2::coin::value<0x2::sui::SUI>(&arg3) >= arg0.create_fee, 3);
        0x2::transfer::public_transfer<0x2::coin::Coin<0x2::sui::SUI>>(arg3, arg0.fee_recipient);
        let v0 = arg0.curve_supply + arg0.liquidity_supply;
        let v1 = 0x2::coin::mint_balance<T0>(&mut arg1, v0);
        let v2 = 0x2::clock::timestamp_ms(arg6);
        let v3 = Pool<T0>{
            id                   : 0x2::object::new(arg7),
            version              : 1,
            creator              : 0x2::tx_context::sender(arg7),
            sui                  : 0x2::balance::zero<0x2::sui::SUI>(),
            tokens               : v1,
            liquidity            : 0x2::balance::split<T0>(&mut v1, arg0.liquidity_supply),
            virtual_sui          : arg0.virtual_sui,
            virtual_token_offset : arg0.virtual_token - arg0.curve_supply,
            trade_fee_bps        : arg0.trade_fee_bps,
            graduated            : false,
            total_supply         : v0,
            treasury_cap         : 0x1::option::some<0x2::coin::TreasuryCap<T0>>(arg1),
            metadata_cap         : 0x1::option::some<0x2::coin_registry::MetadataCap<T0>>(arg2),
            created_at_ms        : v2,
        };
        let v4 = PoolCreated{
            pool_id          : 0x2::object::id<Pool<T0>>(&v3),
            coin_type        : coin_type<T0>(),
            creator          : 0x2::tx_context::sender(arg7),
            total_supply     : v0,
            curve_supply     : arg0.curve_supply,
            liquidity_supply : arg0.liquidity_supply,
            virtual_sui      : arg0.virtual_sui,
            virtual_token    : arg0.virtual_token,
            trade_fee_bps    : arg0.trade_fee_bps,
            created_at_ms    : v2,
        };
        0x2::event::emit<PoolCreated>(v4);
        let v5 = if (0x2::coin::value<0x2::sui::SUI>(&arg4) > 0) {
            let v6 = &mut v3;
            buy_internal<T0>(v6, arg0, arg4, arg5, arg6, arg7)
        } else {
            0x2::coin::destroy_zero<0x2::sui::SUI>(arg4);
            0x2::coin::zero<T0>(arg7)
        };
        0x2::transfer::share_object<Pool<T0>>(v3);
        v5
    }

    public fun creator<T0>(arg0: &Pool<T0>) : address {
        arg0.creator
    }

    fun emit_trade<T0>(arg0: &Pool<T0>, arg1: bool, arg2: u64, arg3: u64, arg4: u64, arg5: &0x2::clock::Clock, arg6: &0x2::tx_context::TxContext) {
        let (v0, v1) = reserves<T0>(arg0);
        let v2 = Trade{
            pool_id       : 0x2::object::id<Pool<T0>>(arg0),
            coin_type     : coin_type<T0>(),
            trader        : 0x2::tx_context::sender(arg6),
            is_buy        : arg1,
            sui_amount    : arg2,
            token_amount  : arg3,
            fee           : arg4,
            sui_reserve   : v0,
            token_reserve : v1,
            graduated     : arg0.graduated,
            timestamp_ms  : 0x2::clock::timestamp_ms(arg5),
        };
        0x2::event::emit<Trade>(v2);
    }

    fun graduate<T0>(arg0: &mut Pool<T0>, arg1: &0x2::clock::Clock) {
        arg0.graduated = true;
        0x2::balance::join<T0>(&mut arg0.tokens, 0x2::balance::withdraw_all<T0>(&mut arg0.liquidity));
        let v0 = Graduated{
            pool_id       : 0x2::object::id<Pool<T0>>(arg0),
            coin_type     : coin_type<T0>(),
            sui_reserve   : 0x2::balance::value<0x2::sui::SUI>(&arg0.sui),
            token_reserve : 0x2::balance::value<T0>(&arg0.tokens),
            timestamp_ms  : 0x2::clock::timestamp_ms(arg1),
        };
        0x2::event::emit<Graduated>(v0);
    }

    fun init(arg0: &mut 0x2::tx_context::TxContext) {
        let v0 = AdminCap{id: 0x2::object::new(arg0)};
        0x2::transfer::transfer<AdminCap>(v0, 0x2::tx_context::sender(arg0));
        let v1 = Config{
            id               : 0x2::object::new(arg0),
            version          : 1,
            fee_recipient    : 0x2::tx_context::sender(arg0),
            create_fee       : 500000000,
            trade_fee_bps    : 100,
            curve_supply     : 793100000000000,
            liquidity_supply : 206900000000000,
            virtual_sui      : 1000000000000,
            virtual_token    : 1073000000000000,
            creation_paused  : false,
        };
        0x2::transfer::share_object<Config>(v1);
    }

    public fun is_graduated<T0>(arg0: &Pool<T0>) : bool {
        arg0.graduated
    }

    public fun is_sealed<T0>(arg0: &Pool<T0>) : bool {
        0x1::option::is_none<0x2::coin::TreasuryCap<T0>>(&arg0.treasury_cap)
    }

    fun mul_div(arg0: u64, arg1: u64, arg2: u64) : u64 {
        (((arg0 as u128) * (arg1 as u128) / (arg2 as u128)) as u64)
    }

    fun mul_div_up(arg0: u64, arg1: u64, arg2: u64) : u64 {
        let v0 = (arg2 as u128);
        ((((arg0 as u128) * (arg1 as u128) + v0 - 1) / v0) as u64)
    }

    public fun quote_buy<T0>(arg0: &Pool<T0>, arg1: u64) : u64 {
        let v0 = mul_div(arg1, arg0.trade_fee_bps, 10000);
        let (v1, v2) = reserves<T0>(arg0);
        if (!arg0.graduated) {
            0x1::u64::min(mul_div(v2, arg1 - v0, v1 + arg1 - v0), 0x2::balance::value<T0>(&arg0.tokens))
        } else {
            mul_div(v2, arg1 - v0, v1 + arg1 - v0)
        }
    }

    public fun quote_sell<T0>(arg0: &Pool<T0>, arg1: u64) : u64 {
        let (v0, v1) = reserves<T0>(arg0);
        let v2 = mul_div(v0, arg1, v1 + arg1);
        v2 - mul_div(v2, arg0.trade_fee_bps, 10000)
    }

    public fun real_sui<T0>(arg0: &Pool<T0>) : u64 {
        0x2::balance::value<0x2::sui::SUI>(&arg0.sui)
    }

    public fun reserves<T0>(arg0: &Pool<T0>) : (u64, u64) {
        if (arg0.graduated) {
            (0x2::balance::value<0x2::sui::SUI>(&arg0.sui), 0x2::balance::value<T0>(&arg0.tokens))
        } else {
            (arg0.virtual_sui + 0x2::balance::value<0x2::sui::SUI>(&arg0.sui), arg0.virtual_token_offset + 0x2::balance::value<T0>(&arg0.tokens))
        }
    }

    public fun seal<T0>(arg0: &mut Pool<T0>, arg1: &mut 0x2::coin_registry::Currency<T0>) {
        assert!(0x1::option::is_some<0x2::coin::TreasuryCap<T0>>(&arg0.treasury_cap), 9);
        let v0 = 0x1::option::extract<0x2::coin::TreasuryCap<T0>>(&mut arg0.treasury_cap);
        assert!(0x2::coin_registry::treasury_cap_id<T0>(arg1) == 0x1::option::some<0x2::object::ID>(0x2::object::id<0x2::coin::TreasuryCap<T0>>(&v0)), 8);
        assert!(!0x2::coin_registry::is_regulated<T0>(arg1), 11);
        0x2::coin_registry::make_supply_fixed<T0>(arg1, v0);
        0x2::coin_registry::delete_metadata_cap<T0>(arg1, 0x1::option::extract<0x2::coin_registry::MetadataCap<T0>>(&mut arg0.metadata_cap));
        let v1 = Sealed{
            pool_id   : 0x2::object::id<Pool<T0>>(arg0),
            coin_type : coin_type<T0>(),
        };
        0x2::event::emit<Sealed>(v1);
    }

    public fun sell<T0>(arg0: &mut Pool<T0>, arg1: &Config, arg2: 0x2::coin::Coin<T0>, arg3: u64, arg4: &0x2::clock::Clock, arg5: &mut 0x2::tx_context::TxContext) : 0x2::coin::Coin<0x2::sui::SUI> {
        assert!(arg0.version == 1, 0);
        let v0 = 0x2::coin::value<T0>(&arg2);
        assert!(v0 > 0, 4);
        let (v1, v2) = reserves<T0>(arg0);
        let v3 = mul_div(v1, v0, v2 + v0);
        assert!(v3 <= 0x2::balance::value<0x2::sui::SUI>(&arg0.sui), 10);
        let v4 = mul_div(v3, arg0.trade_fee_bps, 10000);
        let v5 = v3 - v4;
        assert!(v5 >= arg3 && v5 > 0, 5);
        0x2::balance::join<T0>(&mut arg0.tokens, 0x2::coin::into_balance<T0>(arg2));
        let v6 = 0x2::balance::split<0x2::sui::SUI>(&mut arg0.sui, v3);
        if (v4 > 0) {
            0x2::transfer::public_transfer<0x2::coin::Coin<0x2::sui::SUI>>(0x2::coin::from_balance<0x2::sui::SUI>(0x2::balance::split<0x2::sui::SUI>(&mut v6, v4), arg5), arg1.fee_recipient);
        };
        emit_trade<T0>(arg0, false, v5, v0, v4, arg4, arg5);
        0x2::coin::from_balance<0x2::sui::SUI>(v6, arg5)
    }

    public fun set_creation_paused(arg0: &AdminCap, arg1: &mut Config, arg2: bool) {
        arg1.creation_paused = arg2;
    }

    public fun set_curve_params(arg0: &AdminCap, arg1: &mut Config, arg2: u64, arg3: u64, arg4: u64, arg5: u64) {
        let v0 = if (arg2 > 0) {
            if (arg3 > 0) {
                arg4 > 0
            } else {
                false
            }
        } else {
            false
        };
        assert!(v0, 7);
        assert!(arg5 > arg2, 7);
        assert!((arg2 as u128) + (arg3 as u128) <= 18446744073709551615, 7);
        arg1.curve_supply = arg2;
        arg1.liquidity_supply = arg3;
        arg1.virtual_sui = arg4;
        arg1.virtual_token = arg5;
    }

    public fun set_fee_recipient(arg0: &AdminCap, arg1: &mut Config, arg2: address) {
        arg1.fee_recipient = arg2;
    }

    public fun set_fees(arg0: &AdminCap, arg1: &mut Config, arg2: u64, arg3: u64) {
        assert!(arg2 <= 100000000000 && arg3 <= 200, 6);
        arg1.create_fee = arg2;
        arg1.trade_fee_bps = arg3;
    }

    public fun tokens_left<T0>(arg0: &Pool<T0>) : u64 {
        0x2::balance::value<T0>(&arg0.tokens)
    }

    // decompiled from Move bytecode v7
}

