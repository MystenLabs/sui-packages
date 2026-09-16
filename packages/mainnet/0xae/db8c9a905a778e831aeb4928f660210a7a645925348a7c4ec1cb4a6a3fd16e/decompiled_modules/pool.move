module 0xaedb8c9a905a778e831aeb4928f660210a7a645925348a7c4ec1cb4a6a3fd16e::pool {
    struct Pool<phantom T0, phantom T1> has key {
        id: 0x2::object::UID,
        config: 0x2::object::ID,
        meme: 0x2::balance::Balance<T0>,
        quote: 0x2::balance::Balance<T1>,
        treasury: 0xaedb8c9a905a778e831aeb4928f660210a7a645925348a7c4ec1cb4a6a3fd16e::treasury::Treasury<T1>,
        dividends: 0x2::balance::Balance<T1>,
        platform: 0x2::balance::Balance<T1>,
        rollover: u64,
        state: u8,
        settings: 0xaedb8c9a905a778e831aeb4928f660210a7a645925348a7c4ec1cb4a6a3fd16e::settings::Settings,
        proposal: 0x1::option::Option<SettingsProposal>,
        records: 0x2::table::Table<0x2::object::ID, Record>,
        ledger: 0xaedb8c9a905a778e831aeb4928f660210a7a645925348a7c4ec1cb4a6a3fd16e::conviction::Ledger,
        epoch_ms: u64,
        created_ms: u64,
        last_trade_ms: u64,
        state_changed_ms: u64,
        lp_supply: u64,
    }

    struct Record has store {
        lots: vector<0xaedb8c9a905a778e831aeb4928f660210a7a645925348a7c4ec1cb4a6a3fd16e::position::Lot>,
        amount: u64,
        lock: 0xaedb8c9a905a778e831aeb4928f660210a7a645925348a7c4ec1cb4a6a3fd16e::locks::Lock,
        account: 0xaedb8c9a905a778e831aeb4928f660210a7a645925348a7c4ec1cb4a6a3fd16e::conviction::Account,
    }

    struct SettingsProposal has drop, store {
        settings: 0xaedb8c9a905a778e831aeb4928f660210a7a645925348a7c4ec1cb4a6a3fd16e::settings::Settings,
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

    struct CurveMoved has copy, drop {
        pool: 0x2::object::ID,
        virtual_quote: u64,
        basis: u64,
        bond_target: u64,
        depth: u64,
        meme_reserve: u64,
        timestamp_ms: u64,
    }

    struct Bonded has copy, drop {
        pool: 0x2::object::ID,
        real: u64,
        virtual_quote: u64,
        burned: u64,
        meme_reserve: u64,
        timestamp_ms: u64,
    }

    struct CreatorKey has copy, drop, store {
        dummy_field: bool,
    }

    struct CreatorFees<phantom T0> has store {
        creator: address,
        funds: 0x2::balance::Balance<T0>,
    }

    struct CreatorPaid has copy, drop {
        pool: 0x2::object::ID,
        creator: address,
        amount: u64,
    }

    struct Withdrawn has copy, drop {
        pool: 0x2::object::ID,
        position: 0x2::object::ID,
        owner: address,
        amount: u64,
        burned: u64,
        timestamp_ms: u64,
    }

    struct Deposited has copy, drop {
        pool: 0x2::object::ID,
        position: 0x2::object::ID,
        owner: address,
        amount: u64,
        timestamp_ms: u64,
    }

    public fun join<T0, T1>(arg0: &mut Pool<T0, T1>, arg1: &mut 0xaedb8c9a905a778e831aeb4928f660210a7a645925348a7c4ec1cb4a6a3fd16e::position::Position<T0>, arg2: 0xaedb8c9a905a778e831aeb4928f660210a7a645925348a7c4ec1cb4a6a3fd16e::position::Position<T0>) {
        assert!(0xaedb8c9a905a778e831aeb4928f660210a7a645925348a7c4ec1cb4a6a3fd16e::position::pool_id<T0>(arg1) == 0x2::object::id<Pool<T0, T1>>(arg0) && 0xaedb8c9a905a778e831aeb4928f660210a7a645925348a7c4ec1cb4a6a3fd16e::position::pool_id<T0>(&arg2) == 0x2::object::id<Pool<T0, T1>>(arg0), 4);
        let v0 = 0x2::object::id<0xaedb8c9a905a778e831aeb4928f660210a7a645925348a7c4ec1cb4a6a3fd16e::position::Position<T0>>(arg1);
        let v1 = 0x2::object::id<0xaedb8c9a905a778e831aeb4928f660210a7a645925348a7c4ec1cb4a6a3fd16e::position::Position<T0>>(&arg2);
        settle_record<T0, T1>(arg0, v0);
        settle_record<T0, T1>(arg0, v1);
        let Record {
            lots    : _,
            amount  : _,
            lock    : _,
            account : v5,
        } = 0x2::table::remove<0x2::object::ID, Record>(&mut arg0.records, v1);
        0xaedb8c9a905a778e831aeb4928f660210a7a645925348a7c4ec1cb4a6a3fd16e::position::join<T0>(arg1, arg2);
        let v6 = 0x2::table::borrow_mut<0x2::object::ID, Record>(&mut arg0.records, v0);
        0xaedb8c9a905a778e831aeb4928f660210a7a645925348a7c4ec1cb4a6a3fd16e::conviction::merge(&mut v6.account, v5);
        v6.amount = 0xaedb8c9a905a778e831aeb4928f660210a7a645925348a7c4ec1cb4a6a3fd16e::position::amount<T0>(arg1);
        v6.lots = 0xaedb8c9a905a778e831aeb4928f660210a7a645925348a7c4ec1cb4a6a3fd16e::position::lots<T0>(arg1);
    }

    public fun split<T0, T1>(arg0: &mut Pool<T0, T1>, arg1: &0xaedb8c9a905a778e831aeb4928f660210a7a645925348a7c4ec1cb4a6a3fd16e::config::Config, arg2: &mut 0xaedb8c9a905a778e831aeb4928f660210a7a645925348a7c4ec1cb4a6a3fd16e::position::Position<T0>, arg3: u64, arg4: &mut 0x2::tx_context::TxContext) : 0xaedb8c9a905a778e831aeb4928f660210a7a645925348a7c4ec1cb4a6a3fd16e::position::Position<T0> {
        split_for_exit<T0, T1>(arg0, arg1, arg2, arg3, arg4)
    }

    fun authorize<T0, T1>(arg0: &Pool<T0, T1>, arg1: &PoolCap) {
        assert!(arg1.pool == 0x2::object::id<Pool<T0, T1>>(arg0), 4);
    }

    public fun claimable<T0, T1>(arg0: &Pool<T0, T1>, arg1: 0x2::object::ID) : u64 {
        let v0 = 0x2::table::borrow<0x2::object::ID, Record>(&arg0.records, arg1);
        0xaedb8c9a905a778e831aeb4928f660210a7a645925348a7c4ec1cb4a6a3fd16e::conviction::claimable(&arg0.ledger, &v0.account, &v0.lots, &v0.lock)
    }

    public fun total_weight<T0, T1>(arg0: &Pool<T0, T1>) : u256 {
        0xaedb8c9a905a778e831aeb4928f660210a7a645925348a7c4ec1cb4a6a3fd16e::conviction::total_weight(&arg0.ledger)
    }

    public fun curve<T0, T1>(arg0: &Pool<T0, T1>) : (u64, u64, u64) {
        (0xaedb8c9a905a778e831aeb4928f660210a7a645925348a7c4ec1cb4a6a3fd16e::curve::virtual_quote(&arg0.id), 0xaedb8c9a905a778e831aeb4928f660210a7a645925348a7c4ec1cb4a6a3fd16e::curve::basis(&arg0.id), 0xaedb8c9a905a778e831aeb4928f660210a7a645925348a7c4ec1cb4a6a3fd16e::curve::bond_target(&arg0.id))
    }

    public fun buy<T0, T1>(arg0: &mut Pool<T0, T1>, arg1: &0xaedb8c9a905a778e831aeb4928f660210a7a645925348a7c4ec1cb4a6a3fd16e::config::Config, arg2: 0x2::coin::Coin<T1>, arg3: u64, arg4: u64, arg5: &0x2::clock::Clock, arg6: &mut 0x2::tx_context::TxContext) : 0xaedb8c9a905a778e831aeb4928f660210a7a645925348a7c4ec1cb4a6a3fd16e::position::Position<T0> {
        check<T0, T1>(arg0, arg1);
        assert!(!0xaedb8c9a905a778e831aeb4928f660210a7a645925348a7c4ec1cb4a6a3fd16e::config::paused(arg1) && arg0.state == 0, 1);
        let v0 = 0x2::clock::timestamp_ms(arg5);
        assert!(v0 <= arg4, 2);
        let v1 = 0x2::coin::value<T1>(&arg2);
        let v2 = 0xaedb8c9a905a778e831aeb4928f660210a7a645925348a7c4ec1cb4a6a3fd16e::settings::trade_cap(&arg0.settings, 0xaedb8c9a905a778e831aeb4928f660210a7a645925348a7c4ec1cb4a6a3fd16e::config::max_trade(0xaedb8c9a905a778e831aeb4928f660210a7a645925348a7c4ec1cb4a6a3fd16e::config::params(arg1)));
        assert!(v1 > 0 && (v2 == 0 || (v1 as u128) * 10000 <= (0x2::balance::value<T1>(&arg0.quote) as u128) * (v2 as u128)), 3);
        let v3 = 0xaedb8c9a905a778e831aeb4928f660210a7a645925348a7c4ec1cb4a6a3fd16e::math::mul_div_ceil(v1, 0xaedb8c9a905a778e831aeb4928f660210a7a645925348a7c4ec1cb4a6a3fd16e::config::base_fee(0xaedb8c9a905a778e831aeb4928f660210a7a645925348a7c4ec1cb4a6a3fd16e::config::params(arg1)), 10000);
        assert!(v1 > v3, 3);
        let v4 = 0xaedb8c9a905a778e831aeb4928f660210a7a645925348a7c4ec1cb4a6a3fd16e::curve::buy(&mut arg0.id, 0x2::balance::value<T0>(&arg0.meme), 0x2::balance::value<T1>(&arg0.quote), v1 - v3);
        assert!(v4 > 0 && v4 >= arg3, 2);
        route_fee<T0, T1>(arg0, arg1, 0x2::coin::into_balance<T1>(0x2::coin::split<T1>(&mut arg2, v3, arg6)));
        0x2::balance::join<T1>(&mut arg0.quote, 0x2::coin::into_balance<T1>(arg2));
        let v5 = 0xaedb8c9a905a778e831aeb4928f660210a7a645925348a7c4ec1cb4a6a3fd16e::position::new<T0>(0x2::object::id<Pool<T0, T1>>(arg0), 0x2::balance::split<T0>(&mut arg0.meme, v4), v0, arg6);
        register_new<T0, T1>(arg0, &v5, v0);
        arg0.last_trade_ms = v0;
        let v6 = Swap{
            pool          : 0x2::object::id<Pool<T0, T1>>(arg0),
            position      : 0x2::object::id<0xaedb8c9a905a778e831aeb4928f660210a7a645925348a7c4ec1cb4a6a3fd16e::position::Position<T0>>(&v5),
            buyer         : 0x2::tx_context::sender(arg6),
            buy           : true,
            input         : v1,
            output        : v4,
            fee           : v3,
            meme_reserve  : 0x2::balance::value<T0>(&arg0.meme),
            quote_reserve : 0x2::balance::value<T1>(&arg0.quote),
            timestamp_ms  : v0,
        };
        0x2::event::emit<Swap>(v6);
        emit_curve<T0, T1>(arg0, v0);
        v5
    }

    public fun sell<T0, T1>(arg0: &mut Pool<T0, T1>, arg1: &0xaedb8c9a905a778e831aeb4928f660210a7a645925348a7c4ec1cb4a6a3fd16e::config::Config, arg2: 0xaedb8c9a905a778e831aeb4928f660210a7a645925348a7c4ec1cb4a6a3fd16e::position::Position<T0>, arg3: u64, arg4: u64, arg5: &0x2::clock::Clock, arg6: &mut 0x2::tx_context::TxContext) : 0x2::coin::Coin<T1> {
        0xaedb8c9a905a778e831aeb4928f660210a7a645925348a7c4ec1cb4a6a3fd16e::locks::assert_unlocked(0xaedb8c9a905a778e831aeb4928f660210a7a645925348a7c4ec1cb4a6a3fd16e::position::lock<T0>(&arg2), 0x2::clock::timestamp_ms(arg5), arg0.state);
        sell_internal<T0, T1>(arg0, arg1, arg2, arg3, arg4, false, arg5, arg6)
    }

    public fun add_liquidity<T0, T1>(arg0: &mut Pool<T0, T1>, arg1: &0xaedb8c9a905a778e831aeb4928f660210a7a645925348a7c4ec1cb4a6a3fd16e::config::Config, arg2: 0x2::coin::Coin<T0>, arg3: 0x2::coin::Coin<T1>, arg4: u64, arg5: &mut 0x2::tx_context::TxContext) : (LpPosition, 0x2::coin::Coin<T0>, 0x2::coin::Coin<T1>) {
        check<T0, T1>(arg0, arg1);
        assert!(!0xaedb8c9a905a778e831aeb4928f660210a7a645925348a7c4ec1cb4a6a3fd16e::config::paused(arg1) && arg0.state == 0, 1);
        assert!(0xaedb8c9a905a778e831aeb4928f660210a7a645925348a7c4ec1cb4a6a3fd16e::curve::virtual_quote(&arg0.id) == 0, 10);
        let v0 = 0x1::u64::min(0xaedb8c9a905a778e831aeb4928f660210a7a645925348a7c4ec1cb4a6a3fd16e::math::mul_div(0x2::coin::value<T0>(&arg2), arg0.lp_supply, 0x2::balance::value<T0>(&arg0.meme)), 0xaedb8c9a905a778e831aeb4928f660210a7a645925348a7c4ec1cb4a6a3fd16e::math::mul_div(0x2::coin::value<T1>(&arg3), arg0.lp_supply, 0x2::balance::value<T1>(&arg0.quote)));
        assert!(v0 > 0 && v0 >= arg4, 2);
        0x2::balance::join<T0>(&mut arg0.meme, 0x2::coin::into_balance<T0>(0x2::coin::split<T0>(&mut arg2, 0xaedb8c9a905a778e831aeb4928f660210a7a645925348a7c4ec1cb4a6a3fd16e::math::mul_div_ceil(v0, 0x2::balance::value<T0>(&arg0.meme), arg0.lp_supply), arg5)));
        0x2::balance::join<T1>(&mut arg0.quote, 0x2::coin::into_balance<T1>(0x2::coin::split<T1>(&mut arg3, 0xaedb8c9a905a778e831aeb4928f660210a7a645925348a7c4ec1cb4a6a3fd16e::math::mul_div_ceil(v0, 0x2::balance::value<T1>(&arg0.quote), arg0.lp_supply), arg5)));
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

    public fun bond<T0, T1>(arg0: &mut Pool<T0, T1>, arg1: &0xaedb8c9a905a778e831aeb4928f660210a7a645925348a7c4ec1cb4a6a3fd16e::config::Config, arg2: &0x2::clock::Clock, arg3: &mut 0x2::tx_context::TxContext) {
        check<T0, T1>(arg0, arg1);
        assert!(arg0.state == 0, 8);
        let (v0, v1) = 0xaedb8c9a905a778e831aeb4928f660210a7a645925348a7c4ec1cb4a6a3fd16e::curve::retire(&mut arg0.id);
        let v2 = 0xaedb8c9a905a778e831aeb4928f660210a7a645925348a7c4ec1cb4a6a3fd16e::curve::burn_share(0x2::balance::value<T0>(&arg0.meme), v0, v1);
        if (v2 > 0) {
            0x2::transfer::public_transfer<0x2::coin::Coin<T0>>(0x2::coin::from_balance<T0>(0x2::balance::split<T0>(&mut arg0.meme, v2), arg3), @0x0);
        };
        let v3 = 0x2::clock::timestamp_ms(arg2);
        let v4 = Bonded{
            pool          : 0x2::object::id<Pool<T0, T1>>(arg0),
            real          : v1,
            virtual_quote : v0,
            burned        : v2,
            meme_reserve  : 0x2::balance::value<T0>(&arg0.meme),
            timestamp_ms  : v3,
        };
        0x2::event::emit<Bonded>(v4);
        let v5 = CurveMoved{
            pool          : 0x2::object::id<Pool<T0, T1>>(arg0),
            virtual_quote : 0,
            basis         : 0,
            bond_target   : 0,
            depth         : 0x2::balance::value<T1>(&arg0.quote),
            meme_reserve  : 0x2::balance::value<T0>(&arg0.meme),
            timestamp_ms  : v3,
        };
        0x2::event::emit<CurveMoved>(v5);
    }

    public fun cancel_funding_buffer<T0, T1>(arg0: &mut Pool<T0, T1>, arg1: &PoolCap) {
        authorize<T0, T1>(arg0, arg1);
        0xaedb8c9a905a778e831aeb4928f660210a7a645925348a7c4ec1cb4a6a3fd16e::funding_policy::cancel(&mut arg0.id);
    }

    public fun cancel_settings<T0, T1>(arg0: &mut Pool<T0, T1>, arg1: &PoolCap) {
        authorize<T0, T1>(arg0, arg1);
        arg0.proposal = 0x1::option::none<SettingsProposal>();
    }

    fun check<T0, T1>(arg0: &Pool<T0, T1>, arg1: &0xaedb8c9a905a778e831aeb4928f660210a7a645925348a7c4ec1cb4a6a3fd16e::config::Config) {
        assert!(arg0.config == 0x2::object::id<0xaedb8c9a905a778e831aeb4928f660210a7a645925348a7c4ec1cb4a6a3fd16e::config::Config>(arg1), 5);
    }

    public fun claim<T0, T1>(arg0: &mut Pool<T0, T1>, arg1: &0xaedb8c9a905a778e831aeb4928f660210a7a645925348a7c4ec1cb4a6a3fd16e::position::Position<T0>, arg2: &mut 0x2::tx_context::TxContext) : 0x2::coin::Coin<T1> {
        assert!(0xaedb8c9a905a778e831aeb4928f660210a7a645925348a7c4ec1cb4a6a3fd16e::position::pool_id<T0>(arg1) == 0x2::object::id<Pool<T0, T1>>(arg0), 4);
        let v0 = 0x2::object::id<0xaedb8c9a905a778e831aeb4928f660210a7a645925348a7c4ec1cb4a6a3fd16e::position::Position<T0>>(arg1);
        settle_record<T0, T1>(arg0, v0);
        let v1 = 0xaedb8c9a905a778e831aeb4928f660210a7a645925348a7c4ec1cb4a6a3fd16e::conviction::take(&mut 0x2::table::borrow_mut<0x2::object::ID, Record>(&mut arg0.records, v0).account);
        assert!(v1 > 0, 3);
        0x2::coin::from_balance<T1>(0x2::balance::split<T1>(&mut arg0.dividends, v1), arg2)
    }

    public fun collect_platform<T0, T1>(arg0: &mut Pool<T0, T1>, arg1: &0xaedb8c9a905a778e831aeb4928f660210a7a645925348a7c4ec1cb4a6a3fd16e::config::Config, arg2: &0xaedb8c9a905a778e831aeb4928f660210a7a645925348a7c4ec1cb4a6a3fd16e::config::AdminCap, arg3: &mut 0x2::tx_context::TxContext) : 0x2::coin::Coin<T1> {
        check<T0, T1>(arg0, arg1);
        0xaedb8c9a905a778e831aeb4928f660210a7a645925348a7c4ec1cb4a6a3fd16e::config::authorize(arg1, arg2);
        let v0 = 0x2::balance::value<T1>(&arg0.platform);
        0xaedb8c9a905a778e831aeb4928f660210a7a645925348a7c4ec1cb4a6a3fd16e::platform_fees::collected<T1>(0x2::object::id<Pool<T0, T1>>(arg0), 0x2::object::id<0xaedb8c9a905a778e831aeb4928f660210a7a645925348a7c4ec1cb4a6a3fd16e::config::Config>(arg1), v0, 0x2::balance::value<T1>(&arg0.platform), 0x2::tx_context::sender(arg3));
        0x2::coin::from_balance<T1>(0x2::balance::split<T1>(&mut arg0.platform, v0), arg3)
    }

    public(friend) fun create<T0, T1>(arg0: &0xaedb8c9a905a778e831aeb4928f660210a7a645925348a7c4ec1cb4a6a3fd16e::config::Config, arg1: 0x2::coin::Coin<T0>, arg2: 0x2::coin::Coin<T1>, arg3: 0xaedb8c9a905a778e831aeb4928f660210a7a645925348a7c4ec1cb4a6a3fd16e::settings::Settings, arg4: u64, arg5: &0x2::clock::Clock, arg6: &mut 0x2::tx_context::TxContext) : (Pool<T0, T1>, PoolCap, LpPosition) {
        assert!(!0xaedb8c9a905a778e831aeb4928f660210a7a645925348a7c4ec1cb4a6a3fd16e::config::paused(arg0), 1);
        0xaedb8c9a905a778e831aeb4928f660210a7a645925348a7c4ec1cb4a6a3fd16e::settings::validate(&arg3);
        let v0 = 0xaedb8c9a905a778e831aeb4928f660210a7a645925348a7c4ec1cb4a6a3fd16e::math::sqrt((0x2::coin::value<T0>(&arg1) as u256) * (0x2::coin::value<T1>(&arg2) as u256));
        assert!(v0 > 1000, 3);
        let v1 = 0x2::clock::timestamp_ms(arg5);
        let v2 = Pool<T0, T1>{
            id               : 0x2::object::new(arg6),
            config           : 0x2::object::id<0xaedb8c9a905a778e831aeb4928f660210a7a645925348a7c4ec1cb4a6a3fd16e::config::Config>(arg0),
            meme             : 0x2::coin::into_balance<T0>(arg1),
            quote            : 0x2::coin::into_balance<T1>(arg2),
            treasury         : 0xaedb8c9a905a778e831aeb4928f660210a7a645925348a7c4ec1cb4a6a3fd16e::treasury::new<T1>(),
            dividends        : 0x2::balance::zero<T1>(),
            platform         : 0x2::balance::zero<T1>(),
            rollover         : 0,
            state            : 0,
            settings         : arg3,
            proposal         : 0x1::option::none<SettingsProposal>(),
            records          : 0x2::table::new<0x2::object::ID, Record>(arg6),
            ledger           : 0xaedb8c9a905a778e831aeb4928f660210a7a645925348a7c4ec1cb4a6a3fd16e::conviction::new(v1, arg6),
            epoch_ms         : v1,
            created_ms       : v1,
            last_trade_ms    : v1,
            state_changed_ms : v1,
            lp_supply        : v0,
        };
        let v3 = CreatorKey{dummy_field: false};
        let v4 = CreatorFees<T1>{
            creator : 0x2::tx_context::sender(arg6),
            funds   : 0x2::balance::zero<T1>(),
        };
        0x2::dynamic_field::add<CreatorKey, CreatorFees<T1>>(&mut v2.id, v3, v4);
        0xaedb8c9a905a778e831aeb4928f660210a7a645925348a7c4ec1cb4a6a3fd16e::curve::install(&mut v2.id, arg4, 0x2::balance::value<T1>(&v2.quote));
        emit_curve<T0, T1>(&v2, v1);
        let v5 = 0x2::object::id<Pool<T0, T1>>(&v2);
        let v6 = PoolCreated{
            pool          : v5,
            creator       : 0x2::tx_context::sender(arg6),
            meme_type     : 0x1::type_name::with_defining_ids<T0>(),
            quote_type    : 0x1::type_name::with_defining_ids<T1>(),
            meme_reserve  : 0x2::balance::value<T0>(&v2.meme),
            quote_reserve : 0x2::balance::value<T1>(&v2.quote),
            timestamp_ms  : v1,
        };
        0x2::event::emit<PoolCreated>(v6);
        let v7 = PoolCap{
            id   : 0x2::object::new(arg6),
            pool : v5,
        };
        let v8 = LpPosition{
            id     : 0x2::object::new(arg6),
            pool   : v5,
            shares : v0 - 1000,
        };
        (v2, v7, v8)
    }

    public fun creator_fees<T0, T1>(arg0: &Pool<T0, T1>) : (address, u64) {
        let v0 = CreatorKey{dummy_field: false};
        let v1 = 0x2::dynamic_field::borrow<CreatorKey, CreatorFees<T1>>(&arg0.id, v0);
        (v1.creator, 0x2::balance::value<T1>(&v1.funds))
    }

    public fun deposit<T0, T1>(arg0: &mut Pool<T0, T1>, arg1: &0xaedb8c9a905a778e831aeb4928f660210a7a645925348a7c4ec1cb4a6a3fd16e::config::Config, arg2: 0x2::coin::Coin<T0>, arg3: &0x2::clock::Clock, arg4: &mut 0x2::tx_context::TxContext) : 0xaedb8c9a905a778e831aeb4928f660210a7a645925348a7c4ec1cb4a6a3fd16e::position::Position<T0> {
        check<T0, T1>(arg0, arg1);
        assert!(!0xaedb8c9a905a778e831aeb4928f660210a7a645925348a7c4ec1cb4a6a3fd16e::config::paused(arg1) && arg0.state == 0, 1);
        let v0 = 0x2::clock::timestamp_ms(arg3);
        let v1 = 0x2::coin::value<T0>(&arg2);
        assert!(v1 > 0, 3);
        let v2 = 0xaedb8c9a905a778e831aeb4928f660210a7a645925348a7c4ec1cb4a6a3fd16e::position::new<T0>(0x2::object::id<Pool<T0, T1>>(arg0), 0x2::coin::into_balance<T0>(arg2), v0, arg4);
        register_new<T0, T1>(arg0, &v2, v0);
        let v3 = Deposited{
            pool         : 0x2::object::id<Pool<T0, T1>>(arg0),
            position     : 0x2::object::id<0xaedb8c9a905a778e831aeb4928f660210a7a645925348a7c4ec1cb4a6a3fd16e::position::Position<T0>>(&v2),
            owner        : 0x2::tx_context::sender(arg4),
            amount       : v1,
            timestamp_ms : v0,
        };
        0x2::event::emit<Deposited>(v3);
        v2
    }

    fun emit_curve<T0, T1>(arg0: &Pool<T0, T1>, arg1: u64) {
        if (0xaedb8c9a905a778e831aeb4928f660210a7a645925348a7c4ec1cb4a6a3fd16e::curve::virtual_quote(&arg0.id) == 0) {
            return
        };
        let v0 = CurveMoved{
            pool          : 0x2::object::id<Pool<T0, T1>>(arg0),
            virtual_quote : 0xaedb8c9a905a778e831aeb4928f660210a7a645925348a7c4ec1cb4a6a3fd16e::curve::virtual_quote(&arg0.id),
            basis         : 0xaedb8c9a905a778e831aeb4928f660210a7a645925348a7c4ec1cb4a6a3fd16e::curve::basis(&arg0.id),
            bond_target   : 0xaedb8c9a905a778e831aeb4928f660210a7a645925348a7c4ec1cb4a6a3fd16e::curve::bond_target(&arg0.id),
            depth         : 0xaedb8c9a905a778e831aeb4928f660210a7a645925348a7c4ec1cb4a6a3fd16e::curve::depth(&arg0.id, 0x2::balance::value<T1>(&arg0.quote)),
            meme_reserve  : 0x2::balance::value<T0>(&arg0.meme),
            timestamp_ms  : arg1,
        };
        0x2::event::emit<CurveMoved>(v0);
    }

    public fun execute_funding_buffer<T0, T1>(arg0: &mut Pool<T0, T1>, arg1: &0x2::clock::Clock) {
        0xaedb8c9a905a778e831aeb4928f660210a7a645925348a7c4ec1cb4a6a3fd16e::treasury::set_buffer<T1>(&mut arg0.treasury, 0xaedb8c9a905a778e831aeb4928f660210a7a645925348a7c4ec1cb4a6a3fd16e::funding_policy::execute(&mut arg0.id, arg1));
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

    public fun fund_epoch<T0, T1>(arg0: &mut Pool<T0, T1>, arg1: &0xaedb8c9a905a778e831aeb4928f660210a7a645925348a7c4ec1cb4a6a3fd16e::config::Config, arg2: &0x2::clock::Clock) {
        check<T0, T1>(arg0, arg1);
        let v0 = 0x2::clock::timestamp_ms(arg2);
        assert!(v0 >= arg0.epoch_ms + 0xaedb8c9a905a778e831aeb4928f660210a7a645925348a7c4ec1cb4a6a3fd16e::config::epoch_ms(0xaedb8c9a905a778e831aeb4928f660210a7a645925348a7c4ec1cb4a6a3fd16e::config::params(arg1)), 9);
        let v1 = 0xaedb8c9a905a778e831aeb4928f660210a7a645925348a7c4ec1cb4a6a3fd16e::treasury::surplus<T1>(&mut arg0.treasury);
        arg0.rollover = arg0.rollover + 0x2::balance::value<T1>(&v1);
        0x2::balance::join<T1>(&mut arg0.dividends, v1);
        let v2 = arg0.rollover;
        let v3 = 0xaedb8c9a905a778e831aeb4928f660210a7a645925348a7c4ec1cb4a6a3fd16e::conviction::fund(&mut arg0.ledger, v2, v0);
        arg0.rollover = v2 - v3;
        arg0.epoch_ms = v0;
        let v4 = EpochFunded{
            pool         : 0x2::object::id<Pool<T0, T1>>(arg0),
            timestamp_ms : v0,
            amount       : v3,
            rollover     : arg0.rollover,
        };
        0x2::event::emit<EpochFunded>(v4);
    }

    public fun funding_buffer_status<T0, T1>(arg0: &Pool<T0, T1>) : (u64, bool, u64, u64) {
        let (v0, v1, v2) = 0xaedb8c9a905a778e831aeb4928f660210a7a645925348a7c4ec1cb4a6a3fd16e::funding_policy::status(&arg0.id);
        (0xaedb8c9a905a778e831aeb4928f660210a7a645925348a7c4ec1cb4a6a3fd16e::treasury::buffer<T1>(&arg0.treasury), v0, v1, v2)
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

    public fun pay_creator<T0, T1>(arg0: &mut Pool<T0, T1>, arg1: &mut 0x2::tx_context::TxContext) {
        let v0 = CreatorKey{dummy_field: false};
        let v1 = 0x2::dynamic_field::borrow_mut<CreatorKey, CreatorFees<T1>>(&mut arg0.id, v0);
        let v2 = 0x2::balance::value<T1>(&v1.funds);
        assert!(v2 > 0, 3);
        let v3 = v1.creator;
        0x2::transfer::public_transfer<0x2::coin::Coin<T1>>(0x2::coin::from_balance<T1>(0x2::balance::split<T1>(&mut v1.funds, v2), arg1), v3);
        let v4 = CreatorPaid{
            pool    : 0x2::object::id<Pool<T0, T1>>(arg0),
            creator : v3,
            amount  : v2,
        };
        0x2::event::emit<CreatorPaid>(v4);
    }

    public fun policy<T0, T1>(arg0: &Pool<T0, T1>) : &0xaedb8c9a905a778e831aeb4928f660210a7a645925348a7c4ec1cb4a6a3fd16e::settings::Settings {
        &arg0.settings
    }

    public fun propose_funding_buffer<T0, T1>(arg0: &mut Pool<T0, T1>, arg1: &0xaedb8c9a905a778e831aeb4928f660210a7a645925348a7c4ec1cb4a6a3fd16e::config::Config, arg2: &PoolCap, arg3: u64, arg4: &0x2::clock::Clock) {
        check<T0, T1>(arg0, arg1);
        authorize<T0, T1>(arg0, arg2);
        0xaedb8c9a905a778e831aeb4928f660210a7a645925348a7c4ec1cb4a6a3fd16e::funding_policy::propose(&mut arg0.id, arg1, arg3, arg4);
    }

    public fun propose_settings<T0, T1>(arg0: &mut Pool<T0, T1>, arg1: &0xaedb8c9a905a778e831aeb4928f660210a7a645925348a7c4ec1cb4a6a3fd16e::config::Config, arg2: &PoolCap, arg3: 0xaedb8c9a905a778e831aeb4928f660210a7a645925348a7c4ec1cb4a6a3fd16e::settings::Settings, arg4: &0x2::clock::Clock) {
        check<T0, T1>(arg0, arg1);
        authorize<T0, T1>(arg0, arg2);
        0xaedb8c9a905a778e831aeb4928f660210a7a645925348a7c4ec1cb4a6a3fd16e::settings::validate(&arg3);
        let v0 = SettingsProposal{
            settings   : arg3,
            execute_ms : 0x2::clock::timestamp_ms(arg4) + 0xaedb8c9a905a778e831aeb4928f660210a7a645925348a7c4ec1cb4a6a3fd16e::config::timelock(0xaedb8c9a905a778e831aeb4928f660210a7a645925348a7c4ec1cb4a6a3fd16e::config::params(arg1)),
        };
        arg0.proposal = 0x1::option::some<SettingsProposal>(v0);
    }

    public fun ragequit<T0, T1>(arg0: &mut Pool<T0, T1>, arg1: &0xaedb8c9a905a778e831aeb4928f660210a7a645925348a7c4ec1cb4a6a3fd16e::config::Config, arg2: 0xaedb8c9a905a778e831aeb4928f660210a7a645925348a7c4ec1cb4a6a3fd16e::position::Position<T0>, arg3: u64, arg4: u64, arg5: &0x2::clock::Clock, arg6: &mut 0x2::tx_context::TxContext) : 0x2::coin::Coin<T1> {
        let v0 = arg0.state == 0;
        sell_internal<T0, T1>(arg0, arg1, arg2, arg3, arg4, v0, arg5, arg6)
    }

    public fun ragequit_partial<T0, T1>(arg0: &mut Pool<T0, T1>, arg1: &0xaedb8c9a905a778e831aeb4928f660210a7a645925348a7c4ec1cb4a6a3fd16e::config::Config, arg2: &mut 0xaedb8c9a905a778e831aeb4928f660210a7a645925348a7c4ec1cb4a6a3fd16e::position::Position<T0>, arg3: u64, arg4: u64, arg5: u64, arg6: &0x2::clock::Clock, arg7: &mut 0x2::tx_context::TxContext) : 0x2::coin::Coin<T1> {
        let v0 = split_for_exit<T0, T1>(arg0, arg1, arg2, arg3, arg7);
        let v1 = arg0.state == 0;
        sell_internal<T0, T1>(arg0, arg1, v0, arg4, arg5, v1, arg6, arg7)
    }

    public fun record_count<T0, T1>(arg0: &Pool<T0, T1>) : u64 {
        0x2::table::length<0x2::object::ID, Record>(&arg0.records)
    }

    fun register_new<T0, T1>(arg0: &mut Pool<T0, T1>, arg1: &0xaedb8c9a905a778e831aeb4928f660210a7a645925348a7c4ec1cb4a6a3fd16e::position::Position<T0>, arg2: u64) {
        let v0 = 0xaedb8c9a905a778e831aeb4928f660210a7a645925348a7c4ec1cb4a6a3fd16e::position::lots<T0>(arg1);
        let v1 = *0xaedb8c9a905a778e831aeb4928f660210a7a645925348a7c4ec1cb4a6a3fd16e::position::lock<T0>(arg1);
        0xaedb8c9a905a778e831aeb4928f660210a7a645925348a7c4ec1cb4a6a3fd16e::conviction::insert_position(&mut arg0.ledger, &v0, &v1, arg2);
        let v2 = Record{
            lots    : v0,
            amount  : 0xaedb8c9a905a778e831aeb4928f660210a7a645925348a7c4ec1cb4a6a3fd16e::position::amount<T0>(arg1),
            lock    : v1,
            account : 0xaedb8c9a905a778e831aeb4928f660210a7a645925348a7c4ec1cb4a6a3fd16e::conviction::open(&arg0.ledger),
        };
        0x2::table::add<0x2::object::ID, Record>(&mut arg0.records, 0x2::object::id<0xaedb8c9a905a778e831aeb4928f660210a7a645925348a7c4ec1cb4a6a3fd16e::position::Position<T0>>(arg1), v2);
    }

    fun register_split<T0, T1>(arg0: &mut Pool<T0, T1>, arg1: &0xaedb8c9a905a778e831aeb4928f660210a7a645925348a7c4ec1cb4a6a3fd16e::position::Position<T0>, arg2: 0xaedb8c9a905a778e831aeb4928f660210a7a645925348a7c4ec1cb4a6a3fd16e::conviction::Account) {
        let v0 = Record{
            lots    : 0xaedb8c9a905a778e831aeb4928f660210a7a645925348a7c4ec1cb4a6a3fd16e::position::lots<T0>(arg1),
            amount  : 0xaedb8c9a905a778e831aeb4928f660210a7a645925348a7c4ec1cb4a6a3fd16e::position::amount<T0>(arg1),
            lock    : *0xaedb8c9a905a778e831aeb4928f660210a7a645925348a7c4ec1cb4a6a3fd16e::position::lock<T0>(arg1),
            account : arg2,
        };
        0x2::table::add<0x2::object::ID, Record>(&mut arg0.records, 0x2::object::id<0xaedb8c9a905a778e831aeb4928f660210a7a645925348a7c4ec1cb4a6a3fd16e::position::Position<T0>>(arg1), v0);
    }

    fun remove_exit<T0, T1>(arg0: &mut Pool<T0, T1>, arg1: 0x2::object::ID, arg2: u64) : 0xaedb8c9a905a778e831aeb4928f660210a7a645925348a7c4ec1cb4a6a3fd16e::conviction::Account {
        let Record {
            lots    : v0,
            amount  : _,
            lock    : v2,
            account : v3,
        } = 0x2::table::remove<0x2::object::ID, Record>(&mut arg0.records, arg1);
        let v4 = v3;
        let v5 = v2;
        let v6 = v0;
        0xaedb8c9a905a778e831aeb4928f660210a7a645925348a7c4ec1cb4a6a3fd16e::conviction::settle(&arg0.ledger, &mut v4, &v6, &v5);
        0xaedb8c9a905a778e831aeb4928f660210a7a645925348a7c4ec1cb4a6a3fd16e::conviction::remove_position(&mut arg0.ledger, &v6, &v5, arg2);
        v4
    }

    public fun remove_liquidity<T0, T1>(arg0: &mut Pool<T0, T1>, arg1: LpPosition, arg2: u64, arg3: u64, arg4: &mut 0x2::tx_context::TxContext) : (0x2::coin::Coin<T0>, 0x2::coin::Coin<T1>) {
        let LpPosition {
            id     : v0,
            pool   : v1,
            shares : v2,
        } = arg1;
        assert!(v1 == 0x2::object::id<Pool<T0, T1>>(arg0), 4);
        assert!(0xaedb8c9a905a778e831aeb4928f660210a7a645925348a7c4ec1cb4a6a3fd16e::curve::virtual_quote(&arg0.id) == 0, 10);
        let v3 = 0xaedb8c9a905a778e831aeb4928f660210a7a645925348a7c4ec1cb4a6a3fd16e::math::mul_div(v2, 0x2::balance::value<T0>(&arg0.meme), arg0.lp_supply);
        let v4 = 0xaedb8c9a905a778e831aeb4928f660210a7a645925348a7c4ec1cb4a6a3fd16e::math::mul_div(v2, 0x2::balance::value<T1>(&arg0.quote), arg0.lp_supply);
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

    fun route_fee<T0, T1>(arg0: &mut Pool<T0, T1>, arg1: &0xaedb8c9a905a778e831aeb4928f660210a7a645925348a7c4ec1cb4a6a3fd16e::config::Config, arg2: 0x2::balance::Balance<T1>) {
        let v0 = 0x2::balance::value<T1>(&arg2);
        let (v1, v2, _) = 0xaedb8c9a905a778e831aeb4928f660210a7a645925348a7c4ec1cb4a6a3fd16e::config::splits(0xaedb8c9a905a778e831aeb4928f660210a7a645925348a7c4ec1cb4a6a3fd16e::config::params(arg1));
        0xaedb8c9a905a778e831aeb4928f660210a7a645925348a7c4ec1cb4a6a3fd16e::treasury::deposit<T1>(&mut arg0.treasury, 0x2::balance::split<T1>(&mut arg2, 0xaedb8c9a905a778e831aeb4928f660210a7a645925348a7c4ec1cb4a6a3fd16e::math::mul_div(v0, v1, 10000)));
        let v4 = if (v2 > 1000) {
            1000
        } else {
            0
        };
        let v5 = 0xaedb8c9a905a778e831aeb4928f660210a7a645925348a7c4ec1cb4a6a3fd16e::math::mul_div(v0, v4, 10000);
        if (v5 > 0) {
            let v6 = CreatorKey{dummy_field: false};
            0x2::balance::join<T1>(&mut 0x2::dynamic_field::borrow_mut<CreatorKey, CreatorFees<T1>>(&mut arg0.id, v6).funds, 0x2::balance::split<T1>(&mut arg2, v5));
        };
        let v7 = 0xaedb8c9a905a778e831aeb4928f660210a7a645925348a7c4ec1cb4a6a3fd16e::math::mul_div(v0, v2 - v4, 10000);
        0x2::balance::join<T1>(&mut arg0.dividends, 0x2::balance::split<T1>(&mut arg2, v7));
        arg0.rollover = arg0.rollover + v7;
        0x2::balance::join<T1>(&mut arg0.platform, arg2);
        0xaedb8c9a905a778e831aeb4928f660210a7a645925348a7c4ec1cb4a6a3fd16e::platform_fees::accrued<T1>(0x2::object::id<Pool<T0, T1>>(arg0), 0x2::object::id<0xaedb8c9a905a778e831aeb4928f660210a7a645925348a7c4ec1cb4a6a3fd16e::config::Config>(arg1), 0x2::balance::value<T1>(&arg2), 0x2::balance::value<T1>(&arg0.platform));
    }

    fun sell_internal<T0, T1>(arg0: &mut Pool<T0, T1>, arg1: &0xaedb8c9a905a778e831aeb4928f660210a7a645925348a7c4ec1cb4a6a3fd16e::config::Config, arg2: 0xaedb8c9a905a778e831aeb4928f660210a7a645925348a7c4ec1cb4a6a3fd16e::position::Position<T0>, arg3: u64, arg4: u64, arg5: bool, arg6: &0x2::clock::Clock, arg7: &mut 0x2::tx_context::TxContext) : 0x2::coin::Coin<T1> {
        check<T0, T1>(arg0, arg1);
        let v0 = 0x2::clock::timestamp_ms(arg6);
        assert!(v0 <= arg4, 2);
        let v1 = 0xaedb8c9a905a778e831aeb4928f660210a7a645925348a7c4ec1cb4a6a3fd16e::position::amount<T0>(&arg2);
        let v2 = 0x2::object::id<0xaedb8c9a905a778e831aeb4928f660210a7a645925348a7c4ec1cb4a6a3fd16e::position::Position<T0>>(&arg2);
        let v3 = 0xaedb8c9a905a778e831aeb4928f660210a7a645925348a7c4ec1cb4a6a3fd16e::config::params(arg1);
        let v4 = 0xaedb8c9a905a778e831aeb4928f660210a7a645925348a7c4ec1cb4a6a3fd16e::settings::trade_cap(&arg0.settings, 0xaedb8c9a905a778e831aeb4928f660210a7a645925348a7c4ec1cb4a6a3fd16e::config::max_trade(v3));
        assert!(v4 == 0 || (v1 as u128) * 10000 <= (0x2::balance::value<T0>(&arg0.meme) as u128) * (v4 as u128), 3);
        let v5 = if (arg5) {
            0xaedb8c9a905a778e831aeb4928f660210a7a645925348a7c4ec1cb4a6a3fd16e::math::mul_div_ceil(v1, 0xaedb8c9a905a778e831aeb4928f660210a7a645925348a7c4ec1cb4a6a3fd16e::config::exit_max(v3), 10000)
        } else if (arg0.state != 0) {
            0xaedb8c9a905a778e831aeb4928f660210a7a645925348a7c4ec1cb4a6a3fd16e::math::mul_div_ceil(v1, 0xaedb8c9a905a778e831aeb4928f660210a7a645925348a7c4ec1cb4a6a3fd16e::config::exit_min(v3), 10000)
        } else {
            0xaedb8c9a905a778e831aeb4928f660210a7a645925348a7c4ec1cb4a6a3fd16e::position::fee<T0>(&arg2, v0, 0xaedb8c9a905a778e831aeb4928f660210a7a645925348a7c4ec1cb4a6a3fd16e::config::exit_max(v3), 0xaedb8c9a905a778e831aeb4928f660210a7a645925348a7c4ec1cb4a6a3fd16e::config::exit_min(v3), 0xaedb8c9a905a778e831aeb4928f660210a7a645925348a7c4ec1cb4a6a3fd16e::config::tau(v3))
        };
        let v6 = 0xaedb8c9a905a778e831aeb4928f660210a7a645925348a7c4ec1cb4a6a3fd16e::curve::sell(&mut arg0.id, 0x2::balance::value<T0>(&arg0.meme), 0x2::balance::value<T1>(&arg0.quote), v1);
        let v7 = 0xaedb8c9a905a778e831aeb4928f660210a7a645925348a7c4ec1cb4a6a3fd16e::math::mul_div_ceil(v6, v5, v1);
        assert!(v6 > v7, 3);
        let v8 = v6 - v7;
        assert!(v8 >= arg3, 2);
        0x2::balance::join<T0>(&mut arg0.meme, 0xaedb8c9a905a778e831aeb4928f660210a7a645925348a7c4ec1cb4a6a3fd16e::position::destroy<T0>(arg2, 0x2::object::id<Pool<T0, T1>>(arg0)));
        let v9 = remove_exit<T0, T1>(arg0, v2, v0);
        let v10 = 0x2::balance::split<T1>(&mut arg0.quote, v8);
        let v11 = 0x2::balance::split<T1>(&mut arg0.quote, v7);
        route_fee<T0, T1>(arg0, arg1, v11);
        if (arg5) {
            let (v12, v13, v14) = 0xaedb8c9a905a778e831aeb4928f660210a7a645925348a7c4ec1cb4a6a3fd16e::conviction::forfeit_half(&mut v9);
            0x2::balance::join<T1>(&mut v10, 0x2::balance::split<T1>(&mut arg0.dividends, v12));
            arg0.rollover = arg0.rollover + v13;
            0xaedb8c9a905a778e831aeb4928f660210a7a645925348a7c4ec1cb4a6a3fd16e::treasury::deposit<T1>(&mut arg0.treasury, 0x2::balance::split<T1>(&mut arg0.dividends, v14));
        } else {
            0x2::balance::join<T1>(&mut v10, 0x2::balance::split<T1>(&mut arg0.dividends, 0xaedb8c9a905a778e831aeb4928f660210a7a645925348a7c4ec1cb4a6a3fd16e::conviction::take(&mut v9)));
        };
        arg0.last_trade_ms = v0;
        let v15 = Swap{
            pool          : 0x2::object::id<Pool<T0, T1>>(arg0),
            position      : v2,
            buyer         : 0x2::tx_context::sender(arg7),
            buy           : false,
            input         : v1,
            output        : v8,
            fee           : v7,
            meme_reserve  : 0x2::balance::value<T0>(&arg0.meme),
            quote_reserve : 0x2::balance::value<T1>(&arg0.quote),
            timestamp_ms  : v0,
        };
        0x2::event::emit<Swap>(v15);
        emit_curve<T0, T1>(arg0, v0);
        0x2::coin::from_balance<T1>(v10, arg7)
    }

    public fun sell_partial<T0, T1>(arg0: &mut Pool<T0, T1>, arg1: &0xaedb8c9a905a778e831aeb4928f660210a7a645925348a7c4ec1cb4a6a3fd16e::config::Config, arg2: &mut 0xaedb8c9a905a778e831aeb4928f660210a7a645925348a7c4ec1cb4a6a3fd16e::position::Position<T0>, arg3: u64, arg4: u64, arg5: u64, arg6: &0x2::clock::Clock, arg7: &mut 0x2::tx_context::TxContext) : 0x2::coin::Coin<T1> {
        0xaedb8c9a905a778e831aeb4928f660210a7a645925348a7c4ec1cb4a6a3fd16e::locks::assert_unlocked(0xaedb8c9a905a778e831aeb4928f660210a7a645925348a7c4ec1cb4a6a3fd16e::position::lock<T0>(arg2), 0x2::clock::timestamp_ms(arg6), arg0.state);
        let v0 = split_for_exit<T0, T1>(arg0, arg1, arg2, arg3, arg7);
        sell_internal<T0, T1>(arg0, arg1, v0, arg4, arg5, false, arg6, arg7)
    }

    public fun set_funding_buffer<T0, T1>(arg0: &mut Pool<T0, T1>, arg1: &PoolCap, arg2: u64) {
        authorize<T0, T1>(arg0, arg1);
        abort 7
    }

    fun settle_record<T0, T1>(arg0: &mut Pool<T0, T1>, arg1: 0x2::object::ID) {
        let v0 = 0x2::table::borrow_mut<0x2::object::ID, Record>(&mut arg0.records, arg1);
        0xaedb8c9a905a778e831aeb4928f660210a7a645925348a7c4ec1cb4a6a3fd16e::conviction::settle(&arg0.ledger, &mut v0.account, &v0.lots, &v0.lock);
    }

    public fun share<T0, T1>(arg0: Pool<T0, T1>) {
        0x2::transfer::share_object<Pool<T0, T1>>(arg0);
    }

    public fun share_count<T0, T1>(arg0: &Pool<T0, T1>) : u64 {
        arg0.lp_supply
    }

    fun split_for_exit<T0, T1>(arg0: &mut Pool<T0, T1>, arg1: &0xaedb8c9a905a778e831aeb4928f660210a7a645925348a7c4ec1cb4a6a3fd16e::config::Config, arg2: &mut 0xaedb8c9a905a778e831aeb4928f660210a7a645925348a7c4ec1cb4a6a3fd16e::position::Position<T0>, arg3: u64, arg4: &mut 0x2::tx_context::TxContext) : 0xaedb8c9a905a778e831aeb4928f660210a7a645925348a7c4ec1cb4a6a3fd16e::position::Position<T0> {
        check<T0, T1>(arg0, arg1);
        assert!(0xaedb8c9a905a778e831aeb4928f660210a7a645925348a7c4ec1cb4a6a3fd16e::position::pool_id<T0>(arg2) == 0x2::object::id<Pool<T0, T1>>(arg0), 4);
        let v0 = 0x2::object::id<0xaedb8c9a905a778e831aeb4928f660210a7a645925348a7c4ec1cb4a6a3fd16e::position::Position<T0>>(arg2);
        settle_record<T0, T1>(arg0, v0);
        let v1 = 0xaedb8c9a905a778e831aeb4928f660210a7a645925348a7c4ec1cb4a6a3fd16e::position::split<T0>(arg2, arg3, arg4);
        let v2 = 0x2::table::borrow_mut<0x2::object::ID, Record>(&mut arg0.records, v0);
        v2.amount = 0xaedb8c9a905a778e831aeb4928f660210a7a645925348a7c4ec1cb4a6a3fd16e::position::amount<T0>(arg2);
        v2.lots = 0xaedb8c9a905a778e831aeb4928f660210a7a645925348a7c4ec1cb4a6a3fd16e::position::lots<T0>(arg2);
        register_split<T0, T1>(arg0, &v1, 0xaedb8c9a905a778e831aeb4928f660210a7a645925348a7c4ec1cb4a6a3fd16e::conviction::split(&mut v2.account, arg3, 0xaedb8c9a905a778e831aeb4928f660210a7a645925348a7c4ec1cb4a6a3fd16e::position::amount<T0>(arg2)));
        v1
    }

    public fun state<T0, T1>(arg0: &Pool<T0, T1>) : u8 {
        arg0.state
    }

    public fun upgrade_lock<T0, T1>(arg0: &mut Pool<T0, T1>, arg1: &0xaedb8c9a905a778e831aeb4928f660210a7a645925348a7c4ec1cb4a6a3fd16e::config::Config, arg2: &mut 0xaedb8c9a905a778e831aeb4928f660210a7a645925348a7c4ec1cb4a6a3fd16e::position::Position<T0>, arg3: u8, arg4: &0x2::clock::Clock) {
        check<T0, T1>(arg0, arg1);
        assert!(0xaedb8c9a905a778e831aeb4928f660210a7a645925348a7c4ec1cb4a6a3fd16e::position::pool_id<T0>(arg2) == 0x2::object::id<Pool<T0, T1>>(arg0) && arg0.state == 0, 8);
        let v0 = 0x2::object::id<0xaedb8c9a905a778e831aeb4928f660210a7a645925348a7c4ec1cb4a6a3fd16e::position::Position<T0>>(arg2);
        let v1 = 0x2::clock::timestamp_ms(arg4);
        settle_record<T0, T1>(arg0, v0);
        let v2 = 0x2::table::borrow<0x2::object::ID, Record>(&arg0.records, v0);
        let v3 = v2.lock;
        let v4 = v2.lots;
        0xaedb8c9a905a778e831aeb4928f660210a7a645925348a7c4ec1cb4a6a3fd16e::conviction::remove_position(&mut arg0.ledger, &v4, &v3, v1);
        0xaedb8c9a905a778e831aeb4928f660210a7a645925348a7c4ec1cb4a6a3fd16e::position::upgrade<T0>(arg2, arg3, v1, 0xaedb8c9a905a778e831aeb4928f660210a7a645925348a7c4ec1cb4a6a3fd16e::config::params(arg1));
        let v5 = *0xaedb8c9a905a778e831aeb4928f660210a7a645925348a7c4ec1cb4a6a3fd16e::position::lock<T0>(arg2);
        0x2::table::borrow_mut<0x2::object::ID, Record>(&mut arg0.records, v0).lock = v5;
        0xaedb8c9a905a778e831aeb4928f660210a7a645925348a7c4ec1cb4a6a3fd16e::conviction::insert_position(&mut arg0.ledger, &v4, &v5, v1);
    }

    public(friend) fun wake<T0, T1>(arg0: &mut Pool<T0, T1>, arg1: &0xaedb8c9a905a778e831aeb4928f660210a7a645925348a7c4ec1cb4a6a3fd16e::config::Config, arg2: &PoolCap, arg3: &0x2::clock::Clock) {
        check<T0, T1>(arg0, arg1);
        authorize<T0, T1>(arg0, arg2);
        assert!(arg0.state == 2 && !0xaedb8c9a905a778e831aeb4928f660210a7a645925348a7c4ec1cb4a6a3fd16e::config::paused(arg1), 8);
        let v0 = 0x2::clock::timestamp_ms(arg3);
        assert!(v0 >= arg0.state_changed_ms + 0xaedb8c9a905a778e831aeb4928f660210a7a645925348a7c4ec1cb4a6a3fd16e::config::cooldown(0xaedb8c9a905a778e831aeb4928f660210a7a645925348a7c4ec1cb4a6a3fd16e::config::params(arg1)), 8);
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
        assert!(arg0.state == 0 && 0xaedb8c9a905a778e831aeb4928f660210a7a645925348a7c4ec1cb4a6a3fd16e::settings::hibernation_enabled(&arg0.settings), 8);
        assert!(v0 >= arg0.last_trade_ms + 604800000, 8);
        arg0.state = 1;
        arg0.state_changed_ms = v0;
        let v1 = StateChanged{
            pool  : 0x2::object::id<Pool<T0, T1>>(arg0),
            state : arg0.state,
        };
        0x2::event::emit<StateChanged>(v1);
    }

    public fun withdraw<T0, T1>(arg0: &mut Pool<T0, T1>, arg1: &0xaedb8c9a905a778e831aeb4928f660210a7a645925348a7c4ec1cb4a6a3fd16e::config::Config, arg2: 0xaedb8c9a905a778e831aeb4928f660210a7a645925348a7c4ec1cb4a6a3fd16e::position::Position<T0>, arg3: &0x2::clock::Clock, arg4: &mut 0x2::tx_context::TxContext) : (0x2::coin::Coin<T0>, 0x2::coin::Coin<T1>) {
        0xaedb8c9a905a778e831aeb4928f660210a7a645925348a7c4ec1cb4a6a3fd16e::locks::assert_unlocked(0xaedb8c9a905a778e831aeb4928f660210a7a645925348a7c4ec1cb4a6a3fd16e::position::lock<T0>(&arg2), 0x2::clock::timestamp_ms(arg3), arg0.state);
        withdraw_internal<T0, T1>(arg0, arg1, arg2, arg3, arg4)
    }

    fun withdraw_internal<T0, T1>(arg0: &mut Pool<T0, T1>, arg1: &0xaedb8c9a905a778e831aeb4928f660210a7a645925348a7c4ec1cb4a6a3fd16e::config::Config, arg2: 0xaedb8c9a905a778e831aeb4928f660210a7a645925348a7c4ec1cb4a6a3fd16e::position::Position<T0>, arg3: &0x2::clock::Clock, arg4: &mut 0x2::tx_context::TxContext) : (0x2::coin::Coin<T0>, 0x2::coin::Coin<T1>) {
        check<T0, T1>(arg0, arg1);
        let v0 = 0x2::clock::timestamp_ms(arg3);
        let v1 = 0xaedb8c9a905a778e831aeb4928f660210a7a645925348a7c4ec1cb4a6a3fd16e::config::params(arg1);
        let v2 = 0xaedb8c9a905a778e831aeb4928f660210a7a645925348a7c4ec1cb4a6a3fd16e::position::amount<T0>(&arg2);
        let v3 = 0x2::object::id<0xaedb8c9a905a778e831aeb4928f660210a7a645925348a7c4ec1cb4a6a3fd16e::position::Position<T0>>(&arg2);
        let v4 = if (arg0.state != 0) {
            0xaedb8c9a905a778e831aeb4928f660210a7a645925348a7c4ec1cb4a6a3fd16e::math::mul_div_ceil(v2, 0xaedb8c9a905a778e831aeb4928f660210a7a645925348a7c4ec1cb4a6a3fd16e::config::exit_min(v1), 10000)
        } else {
            0xaedb8c9a905a778e831aeb4928f660210a7a645925348a7c4ec1cb4a6a3fd16e::position::fee<T0>(&arg2, v0, 0xaedb8c9a905a778e831aeb4928f660210a7a645925348a7c4ec1cb4a6a3fd16e::config::exit_max(v1), 0xaedb8c9a905a778e831aeb4928f660210a7a645925348a7c4ec1cb4a6a3fd16e::config::exit_min(v1), 0xaedb8c9a905a778e831aeb4928f660210a7a645925348a7c4ec1cb4a6a3fd16e::config::tau(v1))
        };
        assert!(v4 < v2, 3);
        let v5 = 0x2::object::id<Pool<T0, T1>>(arg0);
        let v6 = 0xaedb8c9a905a778e831aeb4928f660210a7a645925348a7c4ec1cb4a6a3fd16e::position::destroy<T0>(arg2, v5);
        let v7 = remove_exit<T0, T1>(arg0, v3, v0);
        if (v4 > 0) {
            0x2::transfer::public_transfer<0x2::coin::Coin<T0>>(0x2::coin::from_balance<T0>(0x2::balance::split<T0>(&mut v6, v4), arg4), @0x0);
        };
        let v8 = Withdrawn{
            pool         : v5,
            position     : v3,
            owner        : 0x2::tx_context::sender(arg4),
            amount       : 0x2::balance::value<T0>(&v6),
            burned       : v4,
            timestamp_ms : v0,
        };
        0x2::event::emit<Withdrawn>(v8);
        (0x2::coin::from_balance<T0>(v6, arg4), 0x2::coin::from_balance<T1>(0x2::balance::split<T1>(&mut arg0.dividends, 0xaedb8c9a905a778e831aeb4928f660210a7a645925348a7c4ec1cb4a6a3fd16e::conviction::take(&mut v7)), arg4))
    }

    public fun withdraw_partial<T0, T1>(arg0: &mut Pool<T0, T1>, arg1: &0xaedb8c9a905a778e831aeb4928f660210a7a645925348a7c4ec1cb4a6a3fd16e::config::Config, arg2: &mut 0xaedb8c9a905a778e831aeb4928f660210a7a645925348a7c4ec1cb4a6a3fd16e::position::Position<T0>, arg3: u64, arg4: &0x2::clock::Clock, arg5: &mut 0x2::tx_context::TxContext) : (0x2::coin::Coin<T0>, 0x2::coin::Coin<T1>) {
        0xaedb8c9a905a778e831aeb4928f660210a7a645925348a7c4ec1cb4a6a3fd16e::locks::assert_unlocked(0xaedb8c9a905a778e831aeb4928f660210a7a645925348a7c4ec1cb4a6a3fd16e::position::lock<T0>(arg2), 0x2::clock::timestamp_ms(arg4), arg0.state);
        let v0 = split_for_exit<T0, T1>(arg0, arg1, arg2, arg3, arg5);
        withdraw_internal<T0, T1>(arg0, arg1, v0, arg4, arg5)
    }

    // decompiled from Move bytecode v7
}

