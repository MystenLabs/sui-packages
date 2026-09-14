module 0xf44e1655cdedd2ac83485c3184b955df52a9a7c1a332472662fa056aeb20de27::pool {
    struct Pool<phantom T0, phantom T1> has key {
        id: 0x2::object::UID,
        config: 0x2::object::ID,
        meme: 0x2::balance::Balance<T0>,
        quote: 0x2::balance::Balance<T1>,
        treasury: 0xf44e1655cdedd2ac83485c3184b955df52a9a7c1a332472662fa056aeb20de27::treasury::Treasury<T1>,
        dividends: 0x2::balance::Balance<T1>,
        platform: 0x2::balance::Balance<T1>,
        rollover: u64,
        state: u8,
        settings: 0xf44e1655cdedd2ac83485c3184b955df52a9a7c1a332472662fa056aeb20de27::settings::Settings,
        proposal: 0x1::option::Option<SettingsProposal>,
        records: 0x2::table::Table<0x2::object::ID, Record>,
        ids: vector<0x2::object::ID>,
        epoch_ms: u64,
        created_ms: u64,
        last_trade_ms: u64,
        state_changed_ms: u64,
        lp_supply: u64,
    }

    struct Record has store {
        lots: vector<0xf44e1655cdedd2ac83485c3184b955df52a9a7c1a332472662fa056aeb20de27::position::Lot>,
        amount: u64,
        lock: 0xf44e1655cdedd2ac83485c3184b955df52a9a7c1a332472662fa056aeb20de27::locks::Lock,
        credit: u64,
    }

    struct SettingsProposal has drop, store {
        settings: 0xf44e1655cdedd2ac83485c3184b955df52a9a7c1a332472662fa056aeb20de27::settings::Settings,
        execute_ms: u64,
    }

    struct PoolCap has store, key {
        id: 0x2::object::UID,
        pool: 0x2::object::ID,
    }

    struct LpPosition has store, key {
        id: 0x2::object::UID,
        pool: 0x2::object::ID,
        shares: u64,
    }

    struct Swap has copy, drop {
        pool: 0x2::object::ID,
        position: 0x2::object::ID,
        buyer: address,
        buy: bool,
        input: u64,
        output: u64,
        fee: u64,
        meme_reserve: u64,
        quote_reserve: u64,
        timestamp_ms: u64,
    }

    struct PoolCreated has copy, drop {
        pool: 0x2::object::ID,
        creator: address,
        meme_type: 0x1::type_name::TypeName,
        quote_type: 0x1::type_name::TypeName,
        meme_reserve: u64,
        quote_reserve: u64,
        timestamp_ms: u64,
    }

    struct LiquidityChanged has copy, drop {
        pool: 0x2::object::ID,
        meme_reserve: u64,
        quote_reserve: u64,
        lp_supply: u64,
    }

    struct StateChanged has copy, drop {
        pool: 0x2::object::ID,
        state: u8,
    }

    struct EpochFunded has copy, drop {
        pool: 0x2::object::ID,
        timestamp_ms: u64,
        amount: u64,
        rollover: u64,
    }

    fun remove<T0, T1>(arg0: &mut Pool<T0, T1>, arg1: 0x2::object::ID) : Record {
        let v0 = 0;
        while (*0x1::vector::borrow<0x2::object::ID>(&arg0.ids, v0) != arg1) {
            v0 = v0 + 1;
        };
        0x1::vector::remove<0x2::object::ID>(&mut arg0.ids, v0);
        0x2::table::remove<0x2::object::ID, Record>(&mut arg0.records, arg1)
    }

    public fun join<T0, T1>(arg0: &mut Pool<T0, T1>, arg1: &mut 0xf44e1655cdedd2ac83485c3184b955df52a9a7c1a332472662fa056aeb20de27::position::Position<T0>, arg2: 0xf44e1655cdedd2ac83485c3184b955df52a9a7c1a332472662fa056aeb20de27::position::Position<T0>) {
        assert!(0xf44e1655cdedd2ac83485c3184b955df52a9a7c1a332472662fa056aeb20de27::position::pool_id<T0>(arg1) == 0x2::object::id<Pool<T0, T1>>(arg0) && 0xf44e1655cdedd2ac83485c3184b955df52a9a7c1a332472662fa056aeb20de27::position::pool_id<T0>(&arg2) == 0x2::object::id<Pool<T0, T1>>(arg0), 4);
        let v0 = remove<T0, T1>(arg0, 0x2::object::id<0xf44e1655cdedd2ac83485c3184b955df52a9a7c1a332472662fa056aeb20de27::position::Position<T0>>(&arg2));
        let Record {
            lots   : _,
            amount : _,
            lock   : _,
            credit : v4,
        } = v0;
        0xf44e1655cdedd2ac83485c3184b955df52a9a7c1a332472662fa056aeb20de27::position::join<T0>(arg1, arg2);
        let v5 = 0x2::table::borrow_mut<0x2::object::ID, Record>(&mut arg0.records, 0x2::object::id<0xf44e1655cdedd2ac83485c3184b955df52a9a7c1a332472662fa056aeb20de27::position::Position<T0>>(arg1));
        v5.credit = v5.credit + v4;
        v5.amount = 0xf44e1655cdedd2ac83485c3184b955df52a9a7c1a332472662fa056aeb20de27::position::amount<T0>(arg1);
        v5.lots = 0xf44e1655cdedd2ac83485c3184b955df52a9a7c1a332472662fa056aeb20de27::position::lots<T0>(arg1);
    }

    public fun split<T0, T1>(arg0: &mut Pool<T0, T1>, arg1: &0xf44e1655cdedd2ac83485c3184b955df52a9a7c1a332472662fa056aeb20de27::config::Config, arg2: &mut 0xf44e1655cdedd2ac83485c3184b955df52a9a7c1a332472662fa056aeb20de27::position::Position<T0>, arg3: u64, arg4: &mut 0x2::tx_context::TxContext) : 0xf44e1655cdedd2ac83485c3184b955df52a9a7c1a332472662fa056aeb20de27::position::Position<T0> {
        check<T0, T1>(arg0, arg1);
        assert!(0xf44e1655cdedd2ac83485c3184b955df52a9a7c1a332472662fa056aeb20de27::position::pool_id<T0>(arg2) == 0x2::object::id<Pool<T0, T1>>(arg0), 4);
        let v0 = 0xf44e1655cdedd2ac83485c3184b955df52a9a7c1a332472662fa056aeb20de27::position::split<T0>(arg2, arg3, arg4);
        let v1 = 0x2::table::borrow_mut<0x2::object::ID, Record>(&mut arg0.records, 0x2::object::id<0xf44e1655cdedd2ac83485c3184b955df52a9a7c1a332472662fa056aeb20de27::position::Position<T0>>(arg2));
        let v2 = 0xf44e1655cdedd2ac83485c3184b955df52a9a7c1a332472662fa056aeb20de27::math::mul_div(v1.credit, arg3, 0xf44e1655cdedd2ac83485c3184b955df52a9a7c1a332472662fa056aeb20de27::position::amount<T0>(arg2));
        v1.credit = v1.credit - v2;
        v1.amount = 0xf44e1655cdedd2ac83485c3184b955df52a9a7c1a332472662fa056aeb20de27::position::amount<T0>(arg2);
        v1.lots = 0xf44e1655cdedd2ac83485c3184b955df52a9a7c1a332472662fa056aeb20de27::position::lots<T0>(arg2);
        register<T0, T1>(arg0, &v0, v2, arg1);
        v0
    }

    fun authorize<T0, T1>(arg0: &Pool<T0, T1>, arg1: &PoolCap) {
        assert!(arg1.pool == 0x2::object::id<Pool<T0, T1>>(arg0), 4);
    }

    public fun add_liquidity<T0, T1>(arg0: &mut Pool<T0, T1>, arg1: &0xf44e1655cdedd2ac83485c3184b955df52a9a7c1a332472662fa056aeb20de27::config::Config, arg2: 0x2::coin::Coin<T0>, arg3: 0x2::coin::Coin<T1>, arg4: u64, arg5: &mut 0x2::tx_context::TxContext) : (LpPosition, 0x2::coin::Coin<T0>, 0x2::coin::Coin<T1>) {
        check<T0, T1>(arg0, arg1);
        assert!(!0xf44e1655cdedd2ac83485c3184b955df52a9a7c1a332472662fa056aeb20de27::config::paused(arg1) && arg0.state == 0, 1);
        let v0 = 0x1::u64::min(0xf44e1655cdedd2ac83485c3184b955df52a9a7c1a332472662fa056aeb20de27::math::mul_div(0x2::coin::value<T0>(&arg2), arg0.lp_supply, 0x2::balance::value<T0>(&arg0.meme)), 0xf44e1655cdedd2ac83485c3184b955df52a9a7c1a332472662fa056aeb20de27::math::mul_div(0x2::coin::value<T1>(&arg3), arg0.lp_supply, 0x2::balance::value<T1>(&arg0.quote)));
        assert!(v0 > 0 && v0 >= arg4, 2);
        0x2::balance::join<T0>(&mut arg0.meme, 0x2::coin::into_balance<T0>(0x2::coin::split<T0>(&mut arg2, 0xf44e1655cdedd2ac83485c3184b955df52a9a7c1a332472662fa056aeb20de27::math::mul_div_ceil(v0, 0x2::balance::value<T0>(&arg0.meme), arg0.lp_supply), arg5)));
        0x2::balance::join<T1>(&mut arg0.quote, 0x2::coin::into_balance<T1>(0x2::coin::split<T1>(&mut arg3, 0xf44e1655cdedd2ac83485c3184b955df52a9a7c1a332472662fa056aeb20de27::math::mul_div_ceil(v0, 0x2::balance::value<T1>(&arg0.quote), arg0.lp_supply), arg5)));
        arg0.lp_supply = arg0.lp_supply + v0;
        let v1 = LiquidityChanged{
            pool          : 0x2::object::id<Pool<T0, T1>>(arg0),
            meme_reserve  : 0x2::balance::value<T0>(&arg0.meme),
            quote_reserve : 0x2::balance::value<T1>(&arg0.quote),
            lp_supply     : arg0.lp_supply,
        };
        0x2::event::emit<LiquidityChanged>(v1);
        let v2 = LpPosition{
            id     : 0x2::object::new(arg5),
            pool   : 0x2::object::id<Pool<T0, T1>>(arg0),
            shares : v0,
        };
        (v2, arg2, arg3)
    }

    public fun buy<T0, T1>(arg0: &mut Pool<T0, T1>, arg1: &0xf44e1655cdedd2ac83485c3184b955df52a9a7c1a332472662fa056aeb20de27::config::Config, arg2: 0x2::coin::Coin<T1>, arg3: u64, arg4: u64, arg5: &0x2::clock::Clock, arg6: &mut 0x2::tx_context::TxContext) : 0xf44e1655cdedd2ac83485c3184b955df52a9a7c1a332472662fa056aeb20de27::position::Position<T0> {
        check<T0, T1>(arg0, arg1);
        assert!(!0xf44e1655cdedd2ac83485c3184b955df52a9a7c1a332472662fa056aeb20de27::config::paused(arg1) && arg0.state == 0, 1);
        let v0 = 0x2::clock::timestamp_ms(arg5);
        assert!(v0 <= arg4, 2);
        let v1 = 0x2::coin::value<T1>(&arg2);
        assert!(v1 > 0 && (v1 as u128) * 10000 <= (0x2::balance::value<T1>(&arg0.quote) as u128) * (0x1::u64::min(0xf44e1655cdedd2ac83485c3184b955df52a9a7c1a332472662fa056aeb20de27::settings::max_trade(&arg0.settings), 0xf44e1655cdedd2ac83485c3184b955df52a9a7c1a332472662fa056aeb20de27::config::max_trade(0xf44e1655cdedd2ac83485c3184b955df52a9a7c1a332472662fa056aeb20de27::config::params(arg1))) as u128), 3);
        let v2 = 0xf44e1655cdedd2ac83485c3184b955df52a9a7c1a332472662fa056aeb20de27::math::mul_div_ceil(v1, 0xf44e1655cdedd2ac83485c3184b955df52a9a7c1a332472662fa056aeb20de27::config::base_fee(0xf44e1655cdedd2ac83485c3184b955df52a9a7c1a332472662fa056aeb20de27::config::params(arg1)), 10000);
        assert!(v1 > v2, 3);
        let v3 = 0xf44e1655cdedd2ac83485c3184b955df52a9a7c1a332472662fa056aeb20de27::math::output(v1 - v2, 0x2::balance::value<T1>(&arg0.quote), 0x2::balance::value<T0>(&arg0.meme));
        assert!(v3 > 0 && v3 >= arg3, 2);
        route_fee<T0, T1>(arg0, arg1, 0x2::coin::into_balance<T1>(0x2::coin::split<T1>(&mut arg2, v2, arg6)));
        0x2::balance::join<T1>(&mut arg0.quote, 0x2::coin::into_balance<T1>(arg2));
        let v4 = 0xf44e1655cdedd2ac83485c3184b955df52a9a7c1a332472662fa056aeb20de27::position::new<T0>(0x2::object::id<Pool<T0, T1>>(arg0), 0x2::balance::split<T0>(&mut arg0.meme, v3), v0, arg6);
        register<T0, T1>(arg0, &v4, 0, arg1);
        arg0.last_trade_ms = v0;
        let v5 = Swap{
            pool          : 0x2::object::id<Pool<T0, T1>>(arg0),
            position      : 0x2::object::id<0xf44e1655cdedd2ac83485c3184b955df52a9a7c1a332472662fa056aeb20de27::position::Position<T0>>(&v4),
            buyer         : 0x2::tx_context::sender(arg6),
            buy           : true,
            input         : v1,
            output        : v3,
            fee           : v2,
            meme_reserve  : 0x2::balance::value<T0>(&arg0.meme),
            quote_reserve : 0x2::balance::value<T1>(&arg0.quote),
            timestamp_ms  : v0,
        };
        0x2::event::emit<Swap>(v5);
        v4
    }

    public fun cancel_funding_buffer<T0, T1>(arg0: &mut Pool<T0, T1>, arg1: &PoolCap) {
        authorize<T0, T1>(arg0, arg1);
        0xf44e1655cdedd2ac83485c3184b955df52a9a7c1a332472662fa056aeb20de27::funding_policy::cancel(&mut arg0.id);
    }

    public fun cancel_settings<T0, T1>(arg0: &mut Pool<T0, T1>, arg1: &PoolCap) {
        authorize<T0, T1>(arg0, arg1);
        arg0.proposal = 0x1::option::none<SettingsProposal>();
    }

    fun check<T0, T1>(arg0: &Pool<T0, T1>, arg1: &0xf44e1655cdedd2ac83485c3184b955df52a9a7c1a332472662fa056aeb20de27::config::Config) {
        assert!(arg0.config == 0x2::object::id<0xf44e1655cdedd2ac83485c3184b955df52a9a7c1a332472662fa056aeb20de27::config::Config>(arg1), 5);
    }

    public fun claim<T0, T1>(arg0: &mut Pool<T0, T1>, arg1: &0xf44e1655cdedd2ac83485c3184b955df52a9a7c1a332472662fa056aeb20de27::position::Position<T0>, arg2: &mut 0x2::tx_context::TxContext) : 0x2::coin::Coin<T1> {
        assert!(0xf44e1655cdedd2ac83485c3184b955df52a9a7c1a332472662fa056aeb20de27::position::pool_id<T0>(arg1) == 0x2::object::id<Pool<T0, T1>>(arg0), 4);
        let v0 = 0x2::table::borrow_mut<0x2::object::ID, Record>(&mut arg0.records, 0x2::object::id<0xf44e1655cdedd2ac83485c3184b955df52a9a7c1a332472662fa056aeb20de27::position::Position<T0>>(arg1));
        let v1 = v0.credit;
        assert!(v1 > 0, 3);
        v0.credit = 0;
        0x2::coin::from_balance<T1>(0x2::balance::split<T1>(&mut arg0.dividends, v1), arg2)
    }

    public fun claimable<T0, T1>(arg0: &Pool<T0, T1>, arg1: 0x2::object::ID) : u64 {
        0x2::table::borrow<0x2::object::ID, Record>(&arg0.records, arg1).credit
    }

    public fun collect_platform<T0, T1>(arg0: &mut Pool<T0, T1>, arg1: &0xf44e1655cdedd2ac83485c3184b955df52a9a7c1a332472662fa056aeb20de27::config::Config, arg2: &0xf44e1655cdedd2ac83485c3184b955df52a9a7c1a332472662fa056aeb20de27::config::AdminCap, arg3: &mut 0x2::tx_context::TxContext) : 0x2::coin::Coin<T1> {
        check<T0, T1>(arg0, arg1);
        0xf44e1655cdedd2ac83485c3184b955df52a9a7c1a332472662fa056aeb20de27::config::authorize(arg1, arg2);
        let v0 = 0x2::balance::value<T1>(&arg0.platform);
        0xf44e1655cdedd2ac83485c3184b955df52a9a7c1a332472662fa056aeb20de27::platform_fees::collected<T1>(0x2::object::id<Pool<T0, T1>>(arg0), 0x2::object::id<0xf44e1655cdedd2ac83485c3184b955df52a9a7c1a332472662fa056aeb20de27::config::Config>(arg1), v0, 0x2::balance::value<T1>(&arg0.platform), 0x2::tx_context::sender(arg3));
        0x2::coin::from_balance<T1>(0x2::balance::split<T1>(&mut arg0.platform, v0), arg3)
    }

    public(friend) fun create<T0, T1>(arg0: &0xf44e1655cdedd2ac83485c3184b955df52a9a7c1a332472662fa056aeb20de27::config::Config, arg1: 0x2::coin::Coin<T0>, arg2: 0x2::coin::Coin<T1>, arg3: 0xf44e1655cdedd2ac83485c3184b955df52a9a7c1a332472662fa056aeb20de27::settings::Settings, arg4: &0x2::clock::Clock, arg5: &mut 0x2::tx_context::TxContext) : (Pool<T0, T1>, PoolCap, LpPosition) {
        assert!(!0xf44e1655cdedd2ac83485c3184b955df52a9a7c1a332472662fa056aeb20de27::config::paused(arg0), 1);
        0xf44e1655cdedd2ac83485c3184b955df52a9a7c1a332472662fa056aeb20de27::settings::validate(&arg3);
        let v0 = 0xf44e1655cdedd2ac83485c3184b955df52a9a7c1a332472662fa056aeb20de27::math::sqrt((0x2::coin::value<T0>(&arg1) as u256) * (0x2::coin::value<T1>(&arg2) as u256));
        assert!(v0 > 1000, 3);
        let v1 = 0x2::clock::timestamp_ms(arg4);
        let v2 = Pool<T0, T1>{
            id               : 0x2::object::new(arg5),
            config           : 0x2::object::id<0xf44e1655cdedd2ac83485c3184b955df52a9a7c1a332472662fa056aeb20de27::config::Config>(arg0),
            meme             : 0x2::coin::into_balance<T0>(arg1),
            quote            : 0x2::coin::into_balance<T1>(arg2),
            treasury         : 0xf44e1655cdedd2ac83485c3184b955df52a9a7c1a332472662fa056aeb20de27::treasury::new<T1>(),
            dividends        : 0x2::balance::zero<T1>(),
            platform         : 0x2::balance::zero<T1>(),
            rollover         : 0,
            state            : 0,
            settings         : arg3,
            proposal         : 0x1::option::none<SettingsProposal>(),
            records          : 0x2::table::new<0x2::object::ID, Record>(arg5),
            ids              : 0x1::vector::empty<0x2::object::ID>(),
            epoch_ms         : v1,
            created_ms       : v1,
            last_trade_ms    : v1,
            state_changed_ms : v1,
            lp_supply        : v0,
        };
        let v3 = 0x2::object::id<Pool<T0, T1>>(&v2);
        let v4 = PoolCreated{
            pool          : v3,
            creator       : 0x2::tx_context::sender(arg5),
            meme_type     : 0x1::type_name::with_defining_ids<T0>(),
            quote_type    : 0x1::type_name::with_defining_ids<T1>(),
            meme_reserve  : 0x2::balance::value<T0>(&v2.meme),
            quote_reserve : 0x2::balance::value<T1>(&v2.quote),
            timestamp_ms  : v1,
        };
        0x2::event::emit<PoolCreated>(v4);
        let v5 = PoolCap{
            id   : 0x2::object::new(arg5),
            pool : v3,
        };
        let v6 = LpPosition{
            id     : 0x2::object::new(arg5),
            pool   : v3,
            shares : v0 - 1000,
        };
        (v2, v5, v6)
    }

    public fun execute_funding_buffer<T0, T1>(arg0: &mut Pool<T0, T1>, arg1: &0x2::clock::Clock) {
        0xf44e1655cdedd2ac83485c3184b955df52a9a7c1a332472662fa056aeb20de27::treasury::set_buffer<T1>(&mut arg0.treasury, 0xf44e1655cdedd2ac83485c3184b955df52a9a7c1a332472662fa056aeb20de27::funding_policy::execute(&mut arg0.id, arg1));
    }

    public fun execute_settings<T0, T1>(arg0: &mut Pool<T0, T1>, arg1: &0x2::clock::Clock) {
        assert!(0x1::option::is_some<SettingsProposal>(&arg0.proposal), 7);
        assert!(0x2::clock::timestamp_ms(arg1) >= 0x1::option::borrow<SettingsProposal>(&arg0.proposal).execute_ms, 7);
        let SettingsProposal {
            settings   : v0,
            execute_ms : _,
        } = 0x1::option::extract<SettingsProposal>(&mut arg0.proposal);
        arg0.settings = v0;
    }

    public fun fund_epoch<T0, T1>(arg0: &mut Pool<T0, T1>, arg1: &0xf44e1655cdedd2ac83485c3184b955df52a9a7c1a332472662fa056aeb20de27::config::Config, arg2: &0x2::clock::Clock) {
        check<T0, T1>(arg0, arg1);
        let v0 = 0x2::clock::timestamp_ms(arg2);
        assert!(v0 >= arg0.epoch_ms + 0xf44e1655cdedd2ac83485c3184b955df52a9a7c1a332472662fa056aeb20de27::config::epoch_ms(0xf44e1655cdedd2ac83485c3184b955df52a9a7c1a332472662fa056aeb20de27::config::params(arg1)), 9);
        let v1 = 0xf44e1655cdedd2ac83485c3184b955df52a9a7c1a332472662fa056aeb20de27::treasury::surplus<T1>(&mut arg0.treasury);
        arg0.rollover = arg0.rollover + 0x2::balance::value<T1>(&v1);
        0x2::balance::join<T1>(&mut arg0.dividends, v1);
        let v2 = vector[];
        let v3 = 0;
        while (v3 < 0x1::vector::length<0x2::object::ID>(&arg0.ids)) {
            let v4 = 0x2::table::borrow<0x2::object::ID, Record>(&arg0.records, *0x1::vector::borrow<0x2::object::ID>(&arg0.ids, v3));
            let v5 = 0;
            let v6 = &v4.lots;
            let v7 = 0;
            while (v7 < 0x1::vector::length<0xf44e1655cdedd2ac83485c3184b955df52a9a7c1a332472662fa056aeb20de27::position::Lot>(v6)) {
                let v8 = 0x1::vector::borrow<0xf44e1655cdedd2ac83485c3184b955df52a9a7c1a332472662fa056aeb20de27::position::Lot>(v6, v7);
                v5 = v5 + 0xf44e1655cdedd2ac83485c3184b955df52a9a7c1a332472662fa056aeb20de27::dividends::weight(0xf44e1655cdedd2ac83485c3184b955df52a9a7c1a332472662fa056aeb20de27::position::lot_amount(v8), v0 - 0xf44e1655cdedd2ac83485c3184b955df52a9a7c1a332472662fa056aeb20de27::position::lot_entry(v8), 0xf44e1655cdedd2ac83485c3184b955df52a9a7c1a332472662fa056aeb20de27::locks::multiplier(&v4.lock, v0));
                v7 = v7 + 1;
            };
            0x1::vector::push_back<u128>(&mut v2, v5);
            v3 = v3 + 1;
        };
        let v9 = arg0.rollover;
        let (v10, v11) = 0xf44e1655cdedd2ac83485c3184b955df52a9a7c1a332472662fa056aeb20de27::dividends::allocate(v9, &v2);
        let v12 = v10;
        v3 = 0;
        while (v3 < 0x1::vector::length<0x2::object::ID>(&arg0.ids)) {
            let v13 = 0x2::table::borrow_mut<0x2::object::ID, Record>(&mut arg0.records, *0x1::vector::borrow<0x2::object::ID>(&arg0.ids, v3));
            v13.credit = v13.credit + *0x1::vector::borrow<u64>(&v12, v3);
            v3 = v3 + 1;
        };
        arg0.rollover = v11;
        arg0.epoch_ms = v0;
        let v14 = EpochFunded{
            pool         : 0x2::object::id<Pool<T0, T1>>(arg0),
            timestamp_ms : v0,
            amount       : v9 - v11,
            rollover     : v11,
        };
        0x2::event::emit<EpochFunded>(v14);
    }

    public fun funding_buffer_status<T0, T1>(arg0: &Pool<T0, T1>) : (u64, bool, u64, u64) {
        let (v0, v1, v2) = 0xf44e1655cdedd2ac83485c3184b955df52a9a7c1a332472662fa056aeb20de27::funding_policy::status(&arg0.id);
        (0xf44e1655cdedd2ac83485c3184b955df52a9a7c1a332472662fa056aeb20de27::treasury::buffer<T1>(&arg0.treasury), v0, v1, v2)
    }

    public(friend) fun hibernate<T0, T1>(arg0: &mut Pool<T0, T1>) {
        assert!(arg0.state == 1, 8);
        arg0.state = 2;
        let v0 = StateChanged{
            pool  : 0x2::object::id<Pool<T0, T1>>(arg0),
            state : arg0.state,
        };
        0x2::event::emit<StateChanged>(v0);
    }

    public fun policy<T0, T1>(arg0: &Pool<T0, T1>) : &0xf44e1655cdedd2ac83485c3184b955df52a9a7c1a332472662fa056aeb20de27::settings::Settings {
        &arg0.settings
    }

    public fun propose_funding_buffer<T0, T1>(arg0: &mut Pool<T0, T1>, arg1: &0xf44e1655cdedd2ac83485c3184b955df52a9a7c1a332472662fa056aeb20de27::config::Config, arg2: &PoolCap, arg3: u64, arg4: &0x2::clock::Clock) {
        check<T0, T1>(arg0, arg1);
        authorize<T0, T1>(arg0, arg2);
        0xf44e1655cdedd2ac83485c3184b955df52a9a7c1a332472662fa056aeb20de27::funding_policy::propose(&mut arg0.id, arg1, arg3, arg4);
    }

    public fun propose_settings<T0, T1>(arg0: &mut Pool<T0, T1>, arg1: &0xf44e1655cdedd2ac83485c3184b955df52a9a7c1a332472662fa056aeb20de27::config::Config, arg2: &PoolCap, arg3: 0xf44e1655cdedd2ac83485c3184b955df52a9a7c1a332472662fa056aeb20de27::settings::Settings, arg4: &0x2::clock::Clock) {
        check<T0, T1>(arg0, arg1);
        authorize<T0, T1>(arg0, arg2);
        0xf44e1655cdedd2ac83485c3184b955df52a9a7c1a332472662fa056aeb20de27::settings::validate(&arg3);
        let v0 = SettingsProposal{
            settings   : arg3,
            execute_ms : 0x2::clock::timestamp_ms(arg4) + 0xf44e1655cdedd2ac83485c3184b955df52a9a7c1a332472662fa056aeb20de27::config::timelock(0xf44e1655cdedd2ac83485c3184b955df52a9a7c1a332472662fa056aeb20de27::config::params(arg1)),
        };
        arg0.proposal = 0x1::option::some<SettingsProposal>(v0);
    }

    public fun ragequit<T0, T1>(arg0: &mut Pool<T0, T1>, arg1: &0xf44e1655cdedd2ac83485c3184b955df52a9a7c1a332472662fa056aeb20de27::config::Config, arg2: 0xf44e1655cdedd2ac83485c3184b955df52a9a7c1a332472662fa056aeb20de27::position::Position<T0>, arg3: u64, arg4: u64, arg5: &0x2::clock::Clock, arg6: &mut 0x2::tx_context::TxContext) : 0x2::coin::Coin<T1> {
        let v0 = arg0.state == 0;
        sell_internal<T0, T1>(arg0, arg1, arg2, arg3, arg4, v0, arg5, arg6)
    }

    public fun ragequit_partial<T0, T1>(arg0: &mut Pool<T0, T1>, arg1: &0xf44e1655cdedd2ac83485c3184b955df52a9a7c1a332472662fa056aeb20de27::config::Config, arg2: &mut 0xf44e1655cdedd2ac83485c3184b955df52a9a7c1a332472662fa056aeb20de27::position::Position<T0>, arg3: u64, arg4: u64, arg5: u64, arg6: &0x2::clock::Clock, arg7: &mut 0x2::tx_context::TxContext) : 0x2::coin::Coin<T1> {
        let v0 = split_for_exit<T0, T1>(arg0, arg1, arg2, arg3, arg7);
        let v1 = arg0.state == 0;
        sell_internal<T0, T1>(arg0, arg1, v0, arg4, arg5, v1, arg6, arg7)
    }

    public fun record_count<T0, T1>(arg0: &Pool<T0, T1>) : u64 {
        0x1::vector::length<0x2::object::ID>(&arg0.ids)
    }

    fun register<T0, T1>(arg0: &mut Pool<T0, T1>, arg1: &0xf44e1655cdedd2ac83485c3184b955df52a9a7c1a332472662fa056aeb20de27::position::Position<T0>, arg2: u64, arg3: &0xf44e1655cdedd2ac83485c3184b955df52a9a7c1a332472662fa056aeb20de27::config::Config) {
        assert!(0x1::vector::length<0x2::object::ID>(&arg0.ids) < 0xf44e1655cdedd2ac83485c3184b955df52a9a7c1a332472662fa056aeb20de27::config::max_positions(0xf44e1655cdedd2ac83485c3184b955df52a9a7c1a332472662fa056aeb20de27::config::params(arg3)), 6);
        register_record<T0, T1>(arg0, arg1, arg2);
    }

    fun register_record<T0, T1>(arg0: &mut Pool<T0, T1>, arg1: &0xf44e1655cdedd2ac83485c3184b955df52a9a7c1a332472662fa056aeb20de27::position::Position<T0>, arg2: u64) {
        let v0 = 0x2::object::id<0xf44e1655cdedd2ac83485c3184b955df52a9a7c1a332472662fa056aeb20de27::position::Position<T0>>(arg1);
        0x1::vector::push_back<0x2::object::ID>(&mut arg0.ids, v0);
        let v1 = Record{
            lots   : 0xf44e1655cdedd2ac83485c3184b955df52a9a7c1a332472662fa056aeb20de27::position::lots<T0>(arg1),
            amount : 0xf44e1655cdedd2ac83485c3184b955df52a9a7c1a332472662fa056aeb20de27::position::amount<T0>(arg1),
            lock   : *0xf44e1655cdedd2ac83485c3184b955df52a9a7c1a332472662fa056aeb20de27::position::lock<T0>(arg1),
            credit : arg2,
        };
        0x2::table::add<0x2::object::ID, Record>(&mut arg0.records, v0, v1);
    }

    public fun remove_liquidity<T0, T1>(arg0: &mut Pool<T0, T1>, arg1: LpPosition, arg2: u64, arg3: u64, arg4: &mut 0x2::tx_context::TxContext) : (0x2::coin::Coin<T0>, 0x2::coin::Coin<T1>) {
        let LpPosition {
            id     : v0,
            pool   : v1,
            shares : v2,
        } = arg1;
        assert!(v1 == 0x2::object::id<Pool<T0, T1>>(arg0), 4);
        let v3 = 0xf44e1655cdedd2ac83485c3184b955df52a9a7c1a332472662fa056aeb20de27::math::mul_div(v2, 0x2::balance::value<T0>(&arg0.meme), arg0.lp_supply);
        let v4 = 0xf44e1655cdedd2ac83485c3184b955df52a9a7c1a332472662fa056aeb20de27::math::mul_div(v2, 0x2::balance::value<T1>(&arg0.quote), arg0.lp_supply);
        assert!(v3 >= arg2 && v4 >= arg3, 2);
        arg0.lp_supply = arg0.lp_supply - v2;
        0x2::object::delete(v0);
        let v5 = LiquidityChanged{
            pool          : 0x2::object::id<Pool<T0, T1>>(arg0),
            meme_reserve  : 0x2::balance::value<T0>(&arg0.meme),
            quote_reserve : 0x2::balance::value<T1>(&arg0.quote),
            lp_supply     : arg0.lp_supply,
        };
        0x2::event::emit<LiquidityChanged>(v5);
        (0x2::coin::from_balance<T0>(0x2::balance::split<T0>(&mut arg0.meme, v3), arg4), 0x2::coin::from_balance<T1>(0x2::balance::split<T1>(&mut arg0.quote, v4), arg4))
    }

    public fun reserves<T0, T1>(arg0: &Pool<T0, T1>) : (u64, u64) {
        (0x2::balance::value<T0>(&arg0.meme), 0x2::balance::value<T1>(&arg0.quote))
    }

    fun route_fee<T0, T1>(arg0: &mut Pool<T0, T1>, arg1: &0xf44e1655cdedd2ac83485c3184b955df52a9a7c1a332472662fa056aeb20de27::config::Config, arg2: 0x2::balance::Balance<T1>) {
        let v0 = 0x2::balance::value<T1>(&arg2);
        let (v1, v2, _) = 0xf44e1655cdedd2ac83485c3184b955df52a9a7c1a332472662fa056aeb20de27::config::splits(0xf44e1655cdedd2ac83485c3184b955df52a9a7c1a332472662fa056aeb20de27::config::params(arg1));
        0xf44e1655cdedd2ac83485c3184b955df52a9a7c1a332472662fa056aeb20de27::treasury::deposit<T1>(&mut arg0.treasury, 0x2::balance::split<T1>(&mut arg2, 0xf44e1655cdedd2ac83485c3184b955df52a9a7c1a332472662fa056aeb20de27::math::mul_div(v0, v1, 10000)));
        let v4 = 0xf44e1655cdedd2ac83485c3184b955df52a9a7c1a332472662fa056aeb20de27::math::mul_div(v0, v2, 10000);
        0x2::balance::join<T1>(&mut arg0.dividends, 0x2::balance::split<T1>(&mut arg2, v4));
        arg0.rollover = arg0.rollover + v4;
        0x2::balance::join<T1>(&mut arg0.platform, arg2);
        0xf44e1655cdedd2ac83485c3184b955df52a9a7c1a332472662fa056aeb20de27::platform_fees::accrued<T1>(0x2::object::id<Pool<T0, T1>>(arg0), 0x2::object::id<0xf44e1655cdedd2ac83485c3184b955df52a9a7c1a332472662fa056aeb20de27::config::Config>(arg1), 0x2::balance::value<T1>(&arg2), 0x2::balance::value<T1>(&arg0.platform));
    }

    public fun sell<T0, T1>(arg0: &mut Pool<T0, T1>, arg1: &0xf44e1655cdedd2ac83485c3184b955df52a9a7c1a332472662fa056aeb20de27::config::Config, arg2: 0xf44e1655cdedd2ac83485c3184b955df52a9a7c1a332472662fa056aeb20de27::position::Position<T0>, arg3: u64, arg4: u64, arg5: &0x2::clock::Clock, arg6: &mut 0x2::tx_context::TxContext) : 0x2::coin::Coin<T1> {
        0xf44e1655cdedd2ac83485c3184b955df52a9a7c1a332472662fa056aeb20de27::locks::assert_unlocked(0xf44e1655cdedd2ac83485c3184b955df52a9a7c1a332472662fa056aeb20de27::position::lock<T0>(&arg2), 0x2::clock::timestamp_ms(arg5), arg0.state);
        sell_internal<T0, T1>(arg0, arg1, arg2, arg3, arg4, false, arg5, arg6)
    }

    fun sell_internal<T0, T1>(arg0: &mut Pool<T0, T1>, arg1: &0xf44e1655cdedd2ac83485c3184b955df52a9a7c1a332472662fa056aeb20de27::config::Config, arg2: 0xf44e1655cdedd2ac83485c3184b955df52a9a7c1a332472662fa056aeb20de27::position::Position<T0>, arg3: u64, arg4: u64, arg5: bool, arg6: &0x2::clock::Clock, arg7: &mut 0x2::tx_context::TxContext) : 0x2::coin::Coin<T1> {
        check<T0, T1>(arg0, arg1);
        let v0 = 0x2::clock::timestamp_ms(arg6);
        assert!(v0 <= arg4, 2);
        let v1 = 0xf44e1655cdedd2ac83485c3184b955df52a9a7c1a332472662fa056aeb20de27::position::amount<T0>(&arg2);
        let v2 = 0x2::object::id<0xf44e1655cdedd2ac83485c3184b955df52a9a7c1a332472662fa056aeb20de27::position::Position<T0>>(&arg2);
        let v3 = 0xf44e1655cdedd2ac83485c3184b955df52a9a7c1a332472662fa056aeb20de27::config::params(arg1);
        assert!((v1 as u128) * 10000 <= (0x2::balance::value<T0>(&arg0.meme) as u128) * (0x1::u64::min(0xf44e1655cdedd2ac83485c3184b955df52a9a7c1a332472662fa056aeb20de27::settings::max_trade(&arg0.settings), 0xf44e1655cdedd2ac83485c3184b955df52a9a7c1a332472662fa056aeb20de27::config::max_trade(v3)) as u128), 3);
        let v4 = if (arg5) {
            0xf44e1655cdedd2ac83485c3184b955df52a9a7c1a332472662fa056aeb20de27::math::mul_div_ceil(v1, 0xf44e1655cdedd2ac83485c3184b955df52a9a7c1a332472662fa056aeb20de27::config::exit_max(v3), 10000)
        } else if (arg0.state != 0) {
            0xf44e1655cdedd2ac83485c3184b955df52a9a7c1a332472662fa056aeb20de27::math::mul_div_ceil(v1, 0xf44e1655cdedd2ac83485c3184b955df52a9a7c1a332472662fa056aeb20de27::config::exit_min(v3), 10000)
        } else {
            0xf44e1655cdedd2ac83485c3184b955df52a9a7c1a332472662fa056aeb20de27::position::fee<T0>(&arg2, v0, 0xf44e1655cdedd2ac83485c3184b955df52a9a7c1a332472662fa056aeb20de27::config::exit_max(v3), 0xf44e1655cdedd2ac83485c3184b955df52a9a7c1a332472662fa056aeb20de27::config::exit_min(v3), 0xf44e1655cdedd2ac83485c3184b955df52a9a7c1a332472662fa056aeb20de27::config::tau(v3))
        };
        let v5 = 0xf44e1655cdedd2ac83485c3184b955df52a9a7c1a332472662fa056aeb20de27::math::output(v1, 0x2::balance::value<T0>(&arg0.meme), 0x2::balance::value<T1>(&arg0.quote));
        let v6 = 0xf44e1655cdedd2ac83485c3184b955df52a9a7c1a332472662fa056aeb20de27::math::mul_div_ceil(v5, v4, v1);
        assert!(v5 > v6, 3);
        let v7 = v5 - v6;
        assert!(v7 >= arg3, 2);
        0x2::balance::join<T0>(&mut arg0.meme, 0xf44e1655cdedd2ac83485c3184b955df52a9a7c1a332472662fa056aeb20de27::position::destroy<T0>(arg2, 0x2::object::id<Pool<T0, T1>>(arg0)));
        let v8 = remove<T0, T1>(arg0, v2);
        let Record {
            lots   : _,
            amount : _,
            lock   : _,
            credit : v12,
        } = v8;
        let v13 = 0x2::balance::split<T1>(&mut arg0.quote, v7);
        let v14 = 0x2::balance::split<T1>(&mut arg0.quote, v6);
        route_fee<T0, T1>(arg0, arg1, v14);
        if (arg5) {
            let (v15, v16, v17) = 0xf44e1655cdedd2ac83485c3184b955df52a9a7c1a332472662fa056aeb20de27::dividends::ragequit_forfeit(v12);
            0x2::balance::join<T1>(&mut v13, 0x2::balance::split<T1>(&mut arg0.dividends, v15));
            arg0.rollover = arg0.rollover + v16;
            0xf44e1655cdedd2ac83485c3184b955df52a9a7c1a332472662fa056aeb20de27::treasury::deposit<T1>(&mut arg0.treasury, 0x2::balance::split<T1>(&mut arg0.dividends, v17));
        } else {
            0x2::balance::join<T1>(&mut v13, 0x2::balance::split<T1>(&mut arg0.dividends, v12));
        };
        arg0.last_trade_ms = v0;
        let v18 = Swap{
            pool          : 0x2::object::id<Pool<T0, T1>>(arg0),
            position      : v2,
            buyer         : 0x2::tx_context::sender(arg7),
            buy           : false,
            input         : v1,
            output        : v7,
            fee           : v6,
            meme_reserve  : 0x2::balance::value<T0>(&arg0.meme),
            quote_reserve : 0x2::balance::value<T1>(&arg0.quote),
            timestamp_ms  : v0,
        };
        0x2::event::emit<Swap>(v18);
        0x2::coin::from_balance<T1>(v13, arg7)
    }

    public fun sell_partial<T0, T1>(arg0: &mut Pool<T0, T1>, arg1: &0xf44e1655cdedd2ac83485c3184b955df52a9a7c1a332472662fa056aeb20de27::config::Config, arg2: &mut 0xf44e1655cdedd2ac83485c3184b955df52a9a7c1a332472662fa056aeb20de27::position::Position<T0>, arg3: u64, arg4: u64, arg5: u64, arg6: &0x2::clock::Clock, arg7: &mut 0x2::tx_context::TxContext) : 0x2::coin::Coin<T1> {
        0xf44e1655cdedd2ac83485c3184b955df52a9a7c1a332472662fa056aeb20de27::locks::assert_unlocked(0xf44e1655cdedd2ac83485c3184b955df52a9a7c1a332472662fa056aeb20de27::position::lock<T0>(arg2), 0x2::clock::timestamp_ms(arg6), arg0.state);
        let v0 = split_for_exit<T0, T1>(arg0, arg1, arg2, arg3, arg7);
        sell_internal<T0, T1>(arg0, arg1, v0, arg4, arg5, false, arg6, arg7)
    }

    public fun set_funding_buffer<T0, T1>(arg0: &mut Pool<T0, T1>, arg1: &PoolCap, arg2: u64) {
        authorize<T0, T1>(arg0, arg1);
        abort 7
    }

    public fun share<T0, T1>(arg0: Pool<T0, T1>) {
        0x2::transfer::share_object<Pool<T0, T1>>(arg0);
    }

    public fun share_count<T0, T1>(arg0: &Pool<T0, T1>) : u64 {
        arg0.lp_supply
    }

    fun split_for_exit<T0, T1>(arg0: &mut Pool<T0, T1>, arg1: &0xf44e1655cdedd2ac83485c3184b955df52a9a7c1a332472662fa056aeb20de27::config::Config, arg2: &mut 0xf44e1655cdedd2ac83485c3184b955df52a9a7c1a332472662fa056aeb20de27::position::Position<T0>, arg3: u64, arg4: &mut 0x2::tx_context::TxContext) : 0xf44e1655cdedd2ac83485c3184b955df52a9a7c1a332472662fa056aeb20de27::position::Position<T0> {
        check<T0, T1>(arg0, arg1);
        assert!(0xf44e1655cdedd2ac83485c3184b955df52a9a7c1a332472662fa056aeb20de27::position::pool_id<T0>(arg2) == 0x2::object::id<Pool<T0, T1>>(arg0), 4);
        let v0 = 0xf44e1655cdedd2ac83485c3184b955df52a9a7c1a332472662fa056aeb20de27::position::split<T0>(arg2, arg3, arg4);
        let v1 = 0x2::table::borrow_mut<0x2::object::ID, Record>(&mut arg0.records, 0x2::object::id<0xf44e1655cdedd2ac83485c3184b955df52a9a7c1a332472662fa056aeb20de27::position::Position<T0>>(arg2));
        let v2 = 0xf44e1655cdedd2ac83485c3184b955df52a9a7c1a332472662fa056aeb20de27::math::mul_div(v1.credit, arg3, 0xf44e1655cdedd2ac83485c3184b955df52a9a7c1a332472662fa056aeb20de27::position::amount<T0>(arg2));
        v1.credit = v1.credit - v2;
        v1.amount = 0xf44e1655cdedd2ac83485c3184b955df52a9a7c1a332472662fa056aeb20de27::position::amount<T0>(arg2);
        v1.lots = 0xf44e1655cdedd2ac83485c3184b955df52a9a7c1a332472662fa056aeb20de27::position::lots<T0>(arg2);
        register_record<T0, T1>(arg0, &v0, v2);
        v0
    }

    public fun state<T0, T1>(arg0: &Pool<T0, T1>) : u8 {
        arg0.state
    }

    public fun upgrade_lock<T0, T1>(arg0: &mut Pool<T0, T1>, arg1: &0xf44e1655cdedd2ac83485c3184b955df52a9a7c1a332472662fa056aeb20de27::config::Config, arg2: &mut 0xf44e1655cdedd2ac83485c3184b955df52a9a7c1a332472662fa056aeb20de27::position::Position<T0>, arg3: u8, arg4: &0x2::clock::Clock) {
        check<T0, T1>(arg0, arg1);
        assert!(0xf44e1655cdedd2ac83485c3184b955df52a9a7c1a332472662fa056aeb20de27::position::pool_id<T0>(arg2) == 0x2::object::id<Pool<T0, T1>>(arg0) && arg0.state == 0, 8);
        0xf44e1655cdedd2ac83485c3184b955df52a9a7c1a332472662fa056aeb20de27::position::upgrade<T0>(arg2, arg3, 0x2::clock::timestamp_ms(arg4), 0xf44e1655cdedd2ac83485c3184b955df52a9a7c1a332472662fa056aeb20de27::config::params(arg1));
        0x2::table::borrow_mut<0x2::object::ID, Record>(&mut arg0.records, 0x2::object::id<0xf44e1655cdedd2ac83485c3184b955df52a9a7c1a332472662fa056aeb20de27::position::Position<T0>>(arg2)).lock = *0xf44e1655cdedd2ac83485c3184b955df52a9a7c1a332472662fa056aeb20de27::position::lock<T0>(arg2);
    }

    public(friend) fun wake<T0, T1>(arg0: &mut Pool<T0, T1>, arg1: &0xf44e1655cdedd2ac83485c3184b955df52a9a7c1a332472662fa056aeb20de27::config::Config, arg2: &PoolCap, arg3: &0x2::clock::Clock) {
        check<T0, T1>(arg0, arg1);
        authorize<T0, T1>(arg0, arg2);
        assert!(arg0.state == 2 && !0xf44e1655cdedd2ac83485c3184b955df52a9a7c1a332472662fa056aeb20de27::config::paused(arg1), 8);
        let v0 = 0x2::clock::timestamp_ms(arg3);
        assert!(v0 >= arg0.state_changed_ms + 0xf44e1655cdedd2ac83485c3184b955df52a9a7c1a332472662fa056aeb20de27::config::cooldown(0xf44e1655cdedd2ac83485c3184b955df52a9a7c1a332472662fa056aeb20de27::config::params(arg1)), 8);
        arg0.state = 0;
        arg0.state_changed_ms = v0;
        arg0.last_trade_ms = v0;
        let v1 = StateChanged{
            pool  : 0x2::object::id<Pool<T0, T1>>(arg0),
            state : arg0.state,
        };
        0x2::event::emit<StateChanged>(v1);
    }

    public(friend) fun wind_down<T0, T1>(arg0: &mut Pool<T0, T1>, arg1: &0x2::clock::Clock) {
        let v0 = 0x2::clock::timestamp_ms(arg1);
        assert!(arg0.state == 0 && 0xf44e1655cdedd2ac83485c3184b955df52a9a7c1a332472662fa056aeb20de27::settings::hibernation_enabled(&arg0.settings), 8);
        assert!(v0 >= arg0.last_trade_ms + 604800000, 8);
        arg0.state = 1;
        arg0.state_changed_ms = v0;
        let v1 = StateChanged{
            pool  : 0x2::object::id<Pool<T0, T1>>(arg0),
            state : arg0.state,
        };
        0x2::event::emit<StateChanged>(v1);
    }

    // decompiled from Move bytecode v7
}

