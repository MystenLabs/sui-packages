module 0x2c3e6c21a70afd50f39daad3b7f62a7309fdbc6d42ffb489a2de5dff780d3c75::token {
    struct TOKEN has drop {
        dummy_field: bool,
    }

    struct LaunchCap has store, key {
        id: 0x2::object::UID,
    }

    struct Launch has key {
        id: 0x2::object::UID,
        phase: u8,
        treasury: address,
        tokens: 0x2::balance::Balance<TOKEN>,
        reserve: 0x2::balance::Balance<0x2::sui::SUI>,
        buyback: 0x2::balance::Balance<0x2::sui::SUI>,
        burned: 0x2::balance::Balance<TOKEN>,
        p0: u64,
        p1: u64,
        slot_price: u64,
        slot_to_pool: u64,
        round_end: u64,
        used: 0x2::table::Table<0x2::object::ID, bool>,
        filled: u64,
        open_tokens: u64,
        curve_size: u64,
        curve_sold: u64,
        curve_reserve: u64,
        slot_reserve: u64,
        pool_sui: u64,
        pool_tokens: u64,
    }

    struct Opened has copy, drop {
        p0: u64,
        p1: u64,
        slot_price: u64,
        round_end: u64,
    }

    struct SlotBought has copy, drop {
        hashbit: 0x2::object::ID,
        buyer: address,
    }

    struct CurveStarted has copy, drop {
        curve_size: u64,
        open_tokens: u64,
    }

    struct Trade has copy, drop {
        trader: address,
        buy: bool,
        tokens: u64,
        sui: u64,
        fee: u64,
        phase: u8,
    }

    struct Breakout has copy, drop {
        pool_sui: u64,
        pool_tokens: u64,
    }

    struct Buyback has copy, drop {
        sui: u64,
        tokens: u64,
    }

    public fun burned(arg0: &Launch) : u64 {
        0x2::balance::value<TOKEN>(&arg0.burned)
    }

    public fun buy(arg0: &mut Launch, arg1: u64, arg2: &mut 0x2::coin::Coin<0x2::sui::SUI>, arg3: u64, arg4: &mut 0x2::tx_context::TxContext) : 0x2::coin::Coin<TOKEN> {
        assert!(arg0.phase == 2, 13906835608864292893);
        let v0 = arg0.curve_sold;
        assert!(arg1 > 0, 13906835617454358559);
        assert!(v0 + arg1 <= arg0.curve_size, 13906835621749456929);
        let v1 = curve_cost(arg0, v0, v0 + arg1, true);
        let v2 = fee_of(v1);
        assert!(v1 + v2 <= arg3, 13906835634634489891);
        let v3 = 0x2::balance::split<0x2::sui::SUI>(0x2::coin::balance_mut<0x2::sui::SUI>(arg2), v1 + v2);
        let v4 = &mut v3;
        pay_fee(arg0, v4, v2, arg4);
        0x2::balance::join<0x2::sui::SUI>(&mut arg0.reserve, v3);
        arg0.curve_sold = v0 + arg1;
        arg0.curve_reserve = arg0.curve_reserve + v1;
        let v5 = Trade{
            trader : 0x2::tx_context::sender(arg4),
            buy    : true,
            tokens : arg1,
            sui    : v1,
            fee    : v2,
            phase  : 2,
        };
        0x2::event::emit<Trade>(v5);
        if (v0 + arg1 == arg0.curve_size) {
            arg0.pool_sui = arg0.slot_reserve + arg0.curve_reserve;
            arg0.pool_tokens = arg0.open_tokens - arg0.curve_size;
            arg0.phase = 3;
            let v6 = Breakout{
                pool_sui    : arg0.pool_sui,
                pool_tokens : arg0.pool_tokens,
            };
            0x2::event::emit<Breakout>(v6);
        };
        0x2::coin::from_balance<TOKEN>(0x2::balance::split<TOKEN>(&mut arg0.tokens, arg1), arg4)
    }

    public fun buy_from_pool(arg0: &mut Launch, arg1: 0x2::coin::Coin<0x2::sui::SUI>, arg2: u64, arg3: &mut 0x2::tx_context::TxContext) : 0x2::coin::Coin<TOKEN> {
        assert!(arg0.phase == 3, 13906835827908542507);
        let v0 = 0x2::coin::value<0x2::sui::SUI>(&arg1);
        let v1 = fee_of(v0);
        assert!(v0 > v1, 13906835840793182247);
        let v2 = v0 - v1;
        let v3 = arg0.pool_sui;
        let v4 = arg0.pool_tokens;
        let v5 = (((v4 as u128) * (v2 as u128) / ((v3 + v2) as u128)) as u64);
        assert!(v5 > 0, 13906835857973051431);
        assert!(v5 >= arg2, 13906835862268149801);
        let v6 = 0x2::coin::into_balance<0x2::sui::SUI>(arg1);
        let v7 = &mut v6;
        pay_fee(arg0, v7, v1, arg3);
        0x2::balance::join<0x2::sui::SUI>(&mut arg0.reserve, v6);
        arg0.pool_sui = v3 + v2;
        arg0.pool_tokens = v4 - v5;
        let v8 = Trade{
            trader : 0x2::tx_context::sender(arg3),
            buy    : true,
            tokens : v5,
            sui    : v0,
            fee    : v1,
            phase  : 3,
        };
        0x2::event::emit<Trade>(v8);
        0x2::coin::from_balance<TOKEN>(0x2::balance::split<TOKEN>(&mut arg0.tokens, v5), arg3)
    }

    public fun buy_slot(arg0: &mut Launch, arg1: &0x2c3e6c21a70afd50f39daad3b7f62a7309fdbc6d42ffb489a2de5dff780d3c75::hashbits::Hashbit, arg2: &mut 0x2::coin::Coin<0x2::sui::SUI>, arg3: &0x2::clock::Clock, arg4: &mut 0x2::tx_context::TxContext) : 0x2::coin::Coin<TOKEN> {
        assert!(arg0.phase == 1, 13906835432769716239);
        assert!(0x2::clock::timestamp_ms(arg3) < arg0.round_end, 13906835437064814609);
        assert!(arg0.filled < 5555, 13906835441360437275);
        let v0 = 0x2::object::id<0x2c3e6c21a70afd50f39daad3b7f62a7309fdbc6d42ffb489a2de5dff780d3c75::hashbits::Hashbit>(arg1);
        assert!(!0x2::table::contains<0x2::object::ID, bool>(&arg0.used, v0), 13906835449949978645);
        0x2::table::add<0x2::object::ID, bool>(&mut arg0.used, v0, true);
        let v1 = 0x2::balance::split<0x2::sui::SUI>(0x2::coin::balance_mut<0x2::sui::SUI>(arg2), arg0.slot_price);
        let v2 = &mut v1;
        pay_fee(arg0, v2, arg0.slot_price - arg0.slot_to_pool, arg4);
        0x2::balance::join<0x2::sui::SUI>(&mut arg0.reserve, v1);
        arg0.filled = arg0.filled + 1;
        let v3 = SlotBought{
            hashbit : v0,
            buyer   : 0x2::tx_context::sender(arg4),
        };
        0x2::event::emit<SlotBought>(v3);
        0x2::coin::from_balance<TOKEN>(0x2::balance::split<TOKEN>(&mut arg0.tokens, 150000), arg4)
    }

    public fun buyback(arg0: &LaunchCap, arg1: &mut Launch, arg2: u64, arg3: u64) {
        assert!(arg1.phase == 3, 13906836051246841899);
        assert!(arg2 > 0, 13906836055541022751);
        assert!(arg2 <= 0x2::balance::value<0x2::sui::SUI>(&arg1.buyback), 13906836059836907565);
        let v0 = arg1.pool_sui;
        let v1 = arg1.pool_tokens;
        let v2 = (((v1 as u128) * (arg2 as u128) / ((v0 + arg2) as u128)) as u64);
        assert!(v2 > 0, 13906836072721416231);
        assert!(v2 >= arg3, 13906836077016514601);
        0x2::balance::join<0x2::sui::SUI>(&mut arg1.reserve, 0x2::balance::split<0x2::sui::SUI>(&mut arg1.buyback, arg2));
        arg1.pool_sui = v0 + arg2;
        arg1.pool_tokens = v1 - v2;
        0x2::balance::join<TOKEN>(&mut arg1.burned, 0x2::balance::split<TOKEN>(&mut arg1.tokens, v2));
        let v3 = Buyback{
            sui    : arg2,
            tokens : v2,
        };
        0x2::event::emit<Buyback>(v3);
    }

    public fun buyback_reserve(arg0: &Launch) : u64 {
        0x2::balance::value<0x2::sui::SUI>(&arg0.buyback)
    }

    public fun curve(arg0: &Launch) : (u64, u64, u64) {
        (arg0.curve_size, arg0.curve_sold, arg0.curve_reserve)
    }

    fun curve_cost(arg0: &Launch, arg1: u64, arg2: u64, arg3: bool) : u64 {
        let v0 = (arg1 as u128);
        let v1 = (arg2 as u128);
        let v2 = if (arg3) {
            div_ceil(((arg0.p1 - arg0.p0) as u128) * (v1 * v1 - v0 * v0), (arg0.curve_size as u128) * 2)
        } else {
            ((arg0.p1 - arg0.p0) as u128) * (v1 * v1 - v0 * v0) / (arg0.curve_size as u128) * 2
        };
        (((arg0.p0 as u128) * (v1 - v0) + v2) as u64)
    }

    fun curve_size_for(arg0: u64, arg1: u64, arg2: u64, arg3: u64) : u64 {
        let v0 = (arg2 as u128) * (arg3 as u128);
        let v1 = (arg1 as u128) * ((1000000000 - arg3 * 150000) as u128) * 2;
        if (v1 <= v0 * 2) {
            return 0
        };
        (((v1 - v0 * 2) / ((arg1 as u128) * 3 + (arg0 as u128))) as u64)
    }

    fun div_ceil(arg0: u128, arg1: u128) : u128 {
        (arg0 + arg1 - 1) / arg1
    }

    fun fee_of(arg0: u64) : u64 {
        (div_ceil((arg0 as u128) * 2, 100) as u64)
    }

    public fun filled(arg0: &Launch) : u64 {
        arg0.filled
    }

    public fun fund_buyback(arg0: &mut Launch, arg1: 0x2::coin::Coin<0x2::sui::SUI>) {
        assert!(0x2::coin::value<0x2::sui::SUI>(&arg1) > 0, 13906836016886317087);
        0x2::balance::join<0x2::sui::SUI>(&mut arg0.buyback, 0x2::coin::into_balance<0x2::sui::SUI>(arg1));
    }

    fun init(arg0: TOKEN, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin_registry::new_currency_with_otw<TOKEN>(arg0, 0, 0x1::string::utf8(b"HASHBITS"), 0x1::string::utf8(b"Hashbits"), 0x1::string::utf8(b"The Hashbits token. Holders of a Hashbit buy first."), 0x1::string::utf8(b""), arg1);
        let v2 = v1;
        let v3 = v0;
        0x2::coin_registry::make_supply_fixed_init<TOKEN>(&mut v3, v2);
        0x2::transfer::public_transfer<0x2::coin_registry::MetadataCap<TOKEN>>(0x2::coin_registry::finalize<TOKEN>(v3, arg1), 0x2::tx_context::sender(arg1));
        let v4 = LaunchCap{id: 0x2::object::new(arg1)};
        0x2::transfer::public_transfer<LaunchCap>(v4, 0x2::tx_context::sender(arg1));
        let v5 = 0x2::tx_context::sender(arg1);
        0x2::transfer::share_object<Launch>(new_launch(v5, 0x2::coin::mint_balance<TOKEN>(&mut v2, 1000000000), arg1));
    }

    fun new_launch(arg0: address, arg1: 0x2::balance::Balance<TOKEN>, arg2: &mut 0x2::tx_context::TxContext) : Launch {
        Launch{
            id            : 0x2::object::new(arg2),
            phase         : 0,
            treasury      : arg0,
            tokens        : arg1,
            reserve       : 0x2::balance::zero<0x2::sui::SUI>(),
            buyback       : 0x2::balance::zero<0x2::sui::SUI>(),
            burned        : 0x2::balance::zero<TOKEN>(),
            p0            : 0,
            p1            : 0,
            slot_price    : 0,
            slot_to_pool  : 0,
            round_end     : 0,
            used          : 0x2::table::new<0x2::object::ID, bool>(arg2),
            filled        : 0,
            open_tokens   : 0,
            curve_size    : 0,
            curve_sold    : 0,
            curve_reserve : 0,
            slot_reserve  : 0,
            pool_sui      : 0,
            pool_tokens   : 0,
        }
    }

    public fun open(arg0: &LaunchCap, arg1: &mut Launch, arg2: u64, arg3: u64, arg4: u64, arg5: &0x2::clock::Clock) {
        assert!(arg1.phase == 0, 13906835346869977097);
        assert!(arg2 > 0 && arg3 > arg2, 13906835351165075467);
        let v0 = arg2 * 150000;
        assert!(arg4 <= v0, 13906835359755141133);
        assert!(curve_size_for(arg2, arg3, arg4, 5555) > 0, 13906835376935796761);
        arg1.p0 = arg2;
        arg1.p1 = arg3;
        arg1.slot_price = v0;
        arg1.slot_to_pool = arg4;
        arg1.round_end = 0x2::clock::timestamp_ms(arg5) + 3540000;
        arg1.phase = 1;
        let v1 = Opened{
            p0         : arg2,
            p1         : arg3,
            slot_price : v0,
            round_end  : arg1.round_end,
        };
        0x2::event::emit<Opened>(v1);
    }

    fun pay_fee(arg0: &Launch, arg1: &mut 0x2::balance::Balance<0x2::sui::SUI>, arg2: u64, arg3: &mut 0x2::tx_context::TxContext) {
        if (arg2 == 0) {
            return
        };
        0x2::transfer::public_transfer<0x2::coin::Coin<0x2::sui::SUI>>(0x2::coin::from_balance<0x2::sui::SUI>(0x2::balance::split<0x2::sui::SUI>(arg1, arg2), arg3), arg0.treasury);
    }

    public fun phase(arg0: &Launch) : u8 {
        arg0.phase
    }

    public fun pool(arg0: &Launch) : (u64, u64) {
        (arg0.pool_sui, arg0.pool_tokens)
    }

    public fun prices(arg0: &Launch) : (u64, u64, u64) {
        (arg0.p0, arg0.p1, arg0.slot_price)
    }

    public fun quote_buy(arg0: &Launch, arg1: u64) : u64 {
        let v0 = curve_cost(arg0, arg0.curve_sold, arg0.curve_sold + arg1, true);
        v0 + fee_of(v0)
    }

    public fun round_end(arg0: &Launch) : u64 {
        arg0.round_end
    }

    public fun sell(arg0: &mut Launch, arg1: 0x2::coin::Coin<TOKEN>, arg2: u64, arg3: &mut 0x2::tx_context::TxContext) : 0x2::coin::Coin<0x2::sui::SUI> {
        assert!(arg0.phase == 2, 13906835720533442589);
        let v0 = 0x2::coin::value<TOKEN>(&arg1);
        let v1 = arg0.curve_sold;
        assert!(v0 > 0, 13906835733418475551);
        assert!(v0 <= v1, 13906835737713836069);
        let v2 = curve_cost(arg0, v1 - v0, v1, false);
        assert!(v2 <= arg0.curve_reserve, 13906835746304294957);
        let v3 = fee_of(v2);
        assert!(v2 > v3, 13906835754893836327);
        assert!(v2 - v3 >= arg2, 13906835763483901993);
        0x2::balance::join<TOKEN>(&mut arg0.tokens, 0x2::coin::into_balance<TOKEN>(arg1));
        let v4 = 0x2::balance::split<0x2::sui::SUI>(&mut arg0.reserve, v2);
        let v5 = &mut v4;
        pay_fee(arg0, v5, v3, arg3);
        arg0.curve_sold = v1 - v0;
        arg0.curve_reserve = arg0.curve_reserve - v2;
        let v6 = Trade{
            trader : 0x2::tx_context::sender(arg3),
            buy    : false,
            tokens : v0,
            sui    : v2,
            fee    : v3,
            phase  : 2,
        };
        0x2::event::emit<Trade>(v6);
        0x2::coin::from_balance<0x2::sui::SUI>(v4, arg3)
    }

    public fun sell_to_pool(arg0: &mut Launch, arg1: 0x2::coin::Coin<TOKEN>, arg2: u64, arg3: &mut 0x2::tx_context::TxContext) : 0x2::coin::Coin<0x2::sui::SUI> {
        assert!(arg0.phase == 3, 13906835918102855723);
        let v0 = 0x2::coin::value<TOKEN>(&arg1);
        assert!(v0 > 0, 13906835926692003871);
        let v1 = arg0.pool_sui;
        let v2 = arg0.pool_tokens;
        let v3 = (((v1 as u128) * (v0 as u128) / ((v2 + v0) as u128)) as u64);
        let v4 = fee_of(v3);
        assert!(v3 > v4, 13906835943872397351);
        assert!(v3 - v4 >= arg2, 13906835952462463017);
        0x2::balance::join<TOKEN>(&mut arg0.tokens, 0x2::coin::into_balance<TOKEN>(arg1));
        let v5 = 0x2::balance::split<0x2::sui::SUI>(&mut arg0.reserve, v3);
        let v6 = &mut v5;
        pay_fee(arg0, v6, v4, arg3);
        arg0.pool_sui = v1 - v3;
        arg0.pool_tokens = v2 + v0;
        let v7 = Trade{
            trader : 0x2::tx_context::sender(arg3),
            buy    : false,
            tokens : v0,
            sui    : v3,
            fee    : v4,
            phase  : 3,
        };
        0x2::event::emit<Trade>(v7);
        0x2::coin::from_balance<0x2::sui::SUI>(v5, arg3)
    }

    public fun set_treasury(arg0: &LaunchCap, arg1: &mut Launch, arg2: address) {
        assert!(arg1.phase == 0, 13906835295330369545);
        arg1.treasury = arg2;
    }

    public fun slot_used(arg0: &Launch, arg1: 0x2::object::ID) : bool {
        0x2::table::contains<0x2::object::ID, bool>(&arg0.used, arg1)
    }

    public fun start_curve(arg0: &mut Launch, arg1: &0x2::clock::Clock) {
        assert!(arg0.phase == 1, 13906835535848931343);
        assert!(0x2::clock::timestamp_ms(arg1) >= arg0.round_end, 13906835540144160787);
        let v0 = 1000000000 - arg0.filled * 150000;
        let v1 = curve_size_for(arg0.p0, arg0.p1, arg0.slot_to_pool, arg0.filled);
        assert!(v1 > 0 && v1 < v0, 13906835557324292119);
        arg0.open_tokens = v0;
        arg0.curve_size = v1;
        arg0.slot_reserve = (((arg0.slot_to_pool as u128) * (arg0.filled as u128)) as u64);
        arg0.phase = 2;
        let v2 = CurveStarted{
            curve_size  : v1,
            open_tokens : v0,
        };
        0x2::event::emit<CurveStarted>(v2);
    }

    // decompiled from Move bytecode v7
}

