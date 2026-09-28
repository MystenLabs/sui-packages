module 0x288bd69b11d4eeb690e48b03f7711fea7a6879df204f31301c1d535c5416fb61::curve {
    struct Params has copy, drop, store {
        virtual_sui: u64,
        virtual_tokens: u64,
        fee_bps: u64,
    }

    struct Launchpad has key {
        id: 0x2::object::UID,
        params: Params,
        paused: bool,
    }

    struct AdminCap has store, key {
        id: 0x2::object::UID,
    }

    struct Curve<phantom T0> has key {
        id: 0x2::object::UID,
        creator: address,
        name: 0x1::string::String,
        symbol: 0x1::string::String,
        description: 0x1::string::String,
        icon_url: 0x1::string::String,
        params: 0x1::option::Option<Params>,
        sui_reserve: 0x2::balance::Balance<0x2::sui::SUI>,
        token_reserve: 0x2::balance::Balance<T0>,
        migration_reserve: 0x2::balance::Balance<T0>,
        fees: 0x2::balance::Balance<0x2::sui::SUI>,
        complete: bool,
        treasury: 0x2::coin::TreasuryCap<T0>,
    }

    struct CurveCreated has copy, drop {
        curve_id: 0x2::object::ID,
        coin_type: 0x1::string::String,
        creator: address,
        name: 0x1::string::String,
        symbol: 0x1::string::String,
        description: 0x1::string::String,
        icon_url: 0x1::string::String,
    }

    struct Trade has copy, drop {
        curve_id: 0x2::object::ID,
        trader: address,
        is_buy: bool,
        sui_amount: u64,
        token_amount: u64,
        fee: u64,
        sui_reserve: u64,
        token_reserve: u64,
        virtual_sui: u64,
        virtual_tokens: u64,
    }

    struct Graduated has copy, drop {
        curve_id: 0x2::object::ID,
        sui_raised: u64,
    }

    struct Migrated has copy, drop {
        curve_id: 0x2::object::ID,
        sui: u64,
        tokens: u64,
    }

    public fun buy<T0>(arg0: &Launchpad, arg1: &mut Curve<T0>, arg2: 0x2::coin::Coin<0x2::sui::SUI>, arg3: u64, arg4: &mut 0x2::tx_context::TxContext) : (0x2::coin::Coin<T0>, 0x2::coin::Coin<0x2::sui::SUI>) {
        assert!(!arg0.paused, 5);
        assert!(!arg1.complete, 2);
        let v0 = snapshot<T0>(arg1, arg0);
        let v1 = 0x2::coin::value<0x2::sui::SUI>(&arg2);
        assert!(v1 > 0, 4);
        let (v2, v3) = reserves<T0>(arg1, &v0);
        let v4 = mul_div_up((v1 as u128), (v0.fee_bps as u128), 10000);
        let v5 = v4;
        let v6 = (v1 as u128) - v4;
        let v7 = v6;
        let v8 = v3 * v6 / (v2 + v6);
        let v9 = v8;
        let v10 = (0x2::balance::value<T0>(&arg1.token_reserve) as u128);
        if (v8 >= v10) {
            v9 = v10;
            let v11 = (v2 * v10 + v3 - v10 - 1) / (v3 - v10);
            v7 = v11;
            let v12 = mul_div_up(v11, (v0.fee_bps as u128), 10000 - (v0.fee_bps as u128));
            v5 = v12;
            if (v11 > (v1 as u128)) {
                v7 = (v1 as u128);
            };
            if (v7 + v12 > (v1 as u128)) {
                v5 = (v1 as u128) - v7;
            };
        };
        assert!(v9 > 0, 4);
        assert!(v9 >= (arg3 as u128), 3);
        let v13 = 0x2::coin::into_balance<0x2::sui::SUI>(arg2);
        0x2::balance::join<0x2::sui::SUI>(&mut arg1.fees, 0x2::balance::split<0x2::sui::SUI>(&mut v13, (v5 as u64)));
        0x2::balance::join<0x2::sui::SUI>(&mut arg1.sui_reserve, 0x2::balance::split<0x2::sui::SUI>(&mut v13, (v7 as u64)));
        emit_trade<T0>(arg1, &v0, true, (v7 as u64), (v9 as u64), (v5 as u64), arg4);
        if (0x2::balance::value<T0>(&arg1.token_reserve) == 0) {
            arg1.complete = true;
            let v14 = Graduated{
                curve_id   : 0x2::object::id<Curve<T0>>(arg1),
                sui_raised : 0x2::balance::value<0x2::sui::SUI>(&arg1.sui_reserve),
            };
            0x2::event::emit<Graduated>(v14);
        };
        (0x2::coin::from_balance<T0>(0x2::balance::split<T0>(&mut arg1.token_reserve, (v9 as u64)), arg4), 0x2::coin::from_balance<0x2::sui::SUI>(v13, arg4))
    }

    public fun collect_fees<T0>(arg0: &AdminCap, arg1: &mut Curve<T0>, arg2: &mut 0x2::tx_context::TxContext) : 0x2::coin::Coin<0x2::sui::SUI> {
        0x2::coin::from_balance<0x2::sui::SUI>(0x2::balance::withdraw_all<0x2::sui::SUI>(&mut arg1.fees), arg2)
    }

    public fun creator<T0>(arg0: &Curve<T0>) : address {
        arg0.creator
    }

    fun emit_trade<T0>(arg0: &Curve<T0>, arg1: &Params, arg2: bool, arg3: u64, arg4: u64, arg5: u64, arg6: &0x2::tx_context::TxContext) {
        let v0 = Trade{
            curve_id       : 0x2::object::id<Curve<T0>>(arg0),
            trader         : 0x2::tx_context::sender(arg6),
            is_buy         : arg2,
            sui_amount     : arg3,
            token_amount   : arg4,
            fee            : arg5,
            sui_reserve    : 0x2::balance::value<0x2::sui::SUI>(&arg0.sui_reserve),
            token_reserve  : 0x2::balance::value<T0>(&arg0.token_reserve),
            virtual_sui    : arg1.virtual_sui,
            virtual_tokens : arg1.virtual_tokens,
        };
        0x2::event::emit<Trade>(v0);
    }

    fun init(arg0: &mut 0x2::tx_context::TxContext) {
        let v0 = Params{
            virtual_sui    : 2000000000,
            virtual_tokens : 1073000000000000,
            fee_bps        : 100,
        };
        let v1 = Launchpad{
            id     : 0x2::object::new(arg0),
            params : v0,
            paused : false,
        };
        0x2::transfer::share_object<Launchpad>(v1);
        let v2 = AdminCap{id: 0x2::object::new(arg0)};
        0x2::transfer::public_transfer<AdminCap>(v2, 0x2::tx_context::sender(arg0));
    }

    public fun is_complete<T0>(arg0: &Curve<T0>) : bool {
        arg0.complete
    }

    public fun launch<T0>(arg0: 0x2::coin::TreasuryCap<T0>, arg1: 0x2::coin::CoinMetadata<T0>, arg2: &mut 0x2::tx_context::TxContext) {
        assert!(0x2::coin::total_supply<T0>(&arg0) == 0, 0);
        assert!(0x2::coin::get_decimals<T0>(&arg1) == 6, 1);
        let v0 = 0x2::coin::mint_balance<T0>(&mut arg0, 1000000000000000);
        let v1 = 0x2::coin::get_icon_url<T0>(&arg1);
        let v2 = if (0x1::option::is_some<0x2::url::Url>(&v1)) {
            0x1::string::from_ascii(0x2::url::inner_url(0x1::option::borrow<0x2::url::Url>(&v1)))
        } else {
            0x1::string::utf8(b"")
        };
        let v3 = Curve<T0>{
            id                : 0x2::object::new(arg2),
            creator           : 0x2::tx_context::sender(arg2),
            name              : 0x2::coin::get_name<T0>(&arg1),
            symbol            : 0x1::string::from_ascii(0x2::coin::get_symbol<T0>(&arg1)),
            description       : 0x2::coin::get_description<T0>(&arg1),
            icon_url          : v2,
            params            : 0x1::option::none<Params>(),
            sui_reserve       : 0x2::balance::zero<0x2::sui::SUI>(),
            token_reserve     : 0x2::balance::split<T0>(&mut v0, 800000000000000),
            migration_reserve : v0,
            fees              : 0x2::balance::zero<0x2::sui::SUI>(),
            complete          : false,
            treasury          : arg0,
        };
        let v4 = CurveCreated{
            curve_id    : 0x2::object::id<Curve<T0>>(&v3),
            coin_type   : 0x1::string::from_ascii(0x1::type_name::into_string(0x1::type_name::with_defining_ids<T0>())),
            creator     : v3.creator,
            name        : v3.name,
            symbol      : v3.symbol,
            description : v3.description,
            icon_url    : v3.icon_url,
        };
        0x2::event::emit<CurveCreated>(v4);
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<T0>>(arg1);
        0x2::transfer::share_object<Curve<T0>>(v3);
    }

    fun mul_div_up(arg0: u128, arg1: u128, arg2: u128) : u128 {
        (arg0 * arg1 + arg2 - 1) / arg2
    }

    public fun params(arg0: &Launchpad) : Params {
        arg0.params
    }

    fun reserves<T0>(arg0: &Curve<T0>, arg1: &Params) : (u128, u128) {
        ((arg1.virtual_sui as u128) + (0x2::balance::value<0x2::sui::SUI>(&arg0.sui_reserve) as u128), (arg1.virtual_tokens as u128) - ((800000000000000 - 0x2::balance::value<T0>(&arg0.token_reserve)) as u128))
    }

    public fun sell<T0>(arg0: &Launchpad, arg1: &mut Curve<T0>, arg2: 0x2::coin::Coin<T0>, arg3: u64, arg4: &mut 0x2::tx_context::TxContext) : 0x2::coin::Coin<0x2::sui::SUI> {
        assert!(!arg0.paused, 5);
        assert!(!arg1.complete, 2);
        let v0 = snapshot<T0>(arg1, arg0);
        let v1 = (0x2::coin::value<T0>(&arg2) as u128);
        assert!(v1 > 0, 4);
        let (v2, v3) = reserves<T0>(arg1, &v0);
        let v4 = v2 * v1 / (v3 + v1);
        let v5 = v4;
        let v6 = (0x2::balance::value<0x2::sui::SUI>(&arg1.sui_reserve) as u128);
        if (v4 > v6) {
            v5 = v6;
        };
        let v7 = mul_div_up(v5, (v0.fee_bps as u128), 10000);
        let v8 = v5 - v7;
        assert!(v8 > 0, 4);
        assert!(v8 >= (arg3 as u128), 3);
        0x2::balance::join<T0>(&mut arg1.token_reserve, 0x2::coin::into_balance<T0>(arg2));
        let v9 = 0x2::balance::split<0x2::sui::SUI>(&mut arg1.sui_reserve, (v5 as u64));
        0x2::balance::join<0x2::sui::SUI>(&mut arg1.fees, 0x2::balance::split<0x2::sui::SUI>(&mut v9, (v7 as u64)));
        emit_trade<T0>(arg1, &v0, false, (v8 as u64), (v1 as u64), (v7 as u64), arg4);
        0x2::coin::from_balance<0x2::sui::SUI>(v9, arg4)
    }

    public fun set_params(arg0: &AdminCap, arg1: &mut Launchpad, arg2: u64, arg3: u64, arg4: u64) {
        let v0 = if (arg2 > 0) {
            if (arg3 > 800000000000000) {
                arg4 <= 500
            } else {
                false
            }
        } else {
            false
        };
        assert!(v0, 7);
        let v1 = Params{
            virtual_sui    : arg2,
            virtual_tokens : arg3,
            fee_bps        : arg4,
        };
        arg1.params = v1;
    }

    public fun set_paused(arg0: &AdminCap, arg1: &mut Launchpad, arg2: bool) {
        arg1.paused = arg2;
    }

    fun snapshot<T0>(arg0: &mut Curve<T0>, arg1: &Launchpad) : Params {
        if (0x1::option::is_none<Params>(&arg0.params)) {
            0x1::option::fill<Params>(&mut arg0.params, arg1.params);
        };
        *0x1::option::borrow<Params>(&arg0.params)
    }

    public fun sui_reserve<T0>(arg0: &Curve<T0>) : u64 {
        0x2::balance::value<0x2::sui::SUI>(&arg0.sui_reserve)
    }

    public fun token_reserve<T0>(arg0: &Curve<T0>) : u64 {
        0x2::balance::value<T0>(&arg0.token_reserve)
    }

    public fun withdraw_for_migration<T0>(arg0: &AdminCap, arg1: &mut Curve<T0>, arg2: &mut 0x2::tx_context::TxContext) : (0x2::coin::Coin<0x2::sui::SUI>, 0x2::coin::Coin<T0>) {
        assert!(arg1.complete, 6);
        let v0 = 0x2::balance::withdraw_all<0x2::sui::SUI>(&mut arg1.sui_reserve);
        let v1 = 0x2::balance::withdraw_all<T0>(&mut arg1.migration_reserve);
        let v2 = Migrated{
            curve_id : 0x2::object::id<Curve<T0>>(arg1),
            sui      : 0x2::balance::value<0x2::sui::SUI>(&v0),
            tokens   : 0x2::balance::value<T0>(&v1),
        };
        0x2::event::emit<Migrated>(v2);
        (0x2::coin::from_balance<0x2::sui::SUI>(v0, arg2), 0x2::coin::from_balance<T0>(v1, arg2))
    }

    // decompiled from Move bytecode v7
}

