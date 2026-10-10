module 0xbe9a7d44698458aea5bcf0ebe57b04ca620362644c1572b256ca831896c488c5::market {
    struct Settings has copy, drop, store {
        buys_enabled: bool,
        cap: u64,
        buy_fee_bps: u64,
        sell_fee_bps: u64,
        min_backing_bps: u64,
        target_backing_bps: u64,
        ready_cash_bps: u64,
        unhedged_bps: u64,
        unhedged_floor: u64,
        unhedged_max: u64,
        hedge_tolerance_bps: u64,
        hedge_step: u64,
        hedge_slippage_bps: u64,
        margin_bps: u64,
        max_funding_bps: u64,
        lend_bps: u64,
        mark_max_age_ms: u64,
        price_max_age_ms: u64,
        retain_bps: u64,
        trade_slippage_bps: u64,
        backer_notice_ms: u64,
    }

    struct PendingSettings has copy, drop, store {
        settings: Settings,
        effective_ms: u64,
    }

    struct PendingVenue has copy, drop, store {
        venue: 0x2::object::ID,
        effective_ms: u64,
    }

    struct Market<phantom T0, phantom T1> has key {
        id: 0x2::object::UID,
        config: 0x2::object::ID,
        treasury: 0x2::coin::TreasuryCap<T0>,
        decimals: u8,
        quote_decimals: u8,
        venue: 0x2::object::ID,
        settings: Settings,
        pending: 0x1::option::Option<PendingSettings>,
        pending_venue: 0x1::option::Option<PendingVenue>,
        state: u8,
        guard_paused: bool,
        cash: 0x2::balance::Balance<T1>,
        hedge_equity: u64,
        hedge_base: u64,
        mark_price: u256,
        mark_ms: u64,
        lent: u64,
        lent_ms: u64,
        last_price: u256,
        last_price_ms: u64,
        account: 0x1::option::Option<0xbe9a7d44698458aea5bcf0ebe57b04ca620362644c1572b256ca831896c488c5::custody::Vault<T1>>,
        fees_accrued: u64,
        settle_notice_ms: u64,
        settle_begun_ms: u64,
        settle_owed: u64,
        settle_supply: u64,
        shares: u128,
        protocol_shares: u128,
        totals: Totals,
    }

    struct Totals has copy, drop, store {
        bought: u128,
        sold: u128,
        fees_total: u128,
        retained_total: u128,
        treasury_in: u128,
        treasury_out: u128,
    }

    struct Backer has store, key {
        id: 0x2::object::UID,
        market: 0x2::object::ID,
        shares: u128,
        open_ms: u64,
        close_ms: u64,
        worth_at_notice: u64,
    }

    struct MarketCreated has copy, drop {
        schema: u8,
        market: 0x2::object::ID,
        config: 0x2::object::ID,
        venue: 0x2::object::ID,
        decimals: u8,
        quote_decimals: u8,
        settings: Settings,
        price: u256,
    }

    struct AccountOpened has copy, drop {
        schema: u8,
        market: 0x2::object::ID,
        account: 0x2::object::ID,
        venue: 0x2::object::ID,
    }

    struct Bought has copy, drop {
        schema: u8,
        market: 0x2::object::ID,
        buyer: address,
        paid: u64,
        fee: u64,
        retained: u64,
        hedge_cost: u64,
        coins: u64,
        price: u256,
        supply: u64,
        backing: u64,
        owed: u64,
    }

    struct Sold has copy, drop {
        schema: u8,
        market: 0x2::object::ID,
        seller: address,
        coins: u64,
        paid: u64,
        fee: u64,
        retained: u64,
        hedge_cost: u64,
        price: u256,
        pro_rata: bool,
        supply: u64,
        backing: u64,
        owed: u64,
    }

    struct Funded has copy, drop {
        schema: u8,
        market: 0x2::object::ID,
        by: address,
        amount: u64,
        cash: u64,
    }

    struct PaidOut has copy, drop {
        schema: u8,
        market: 0x2::object::ID,
        to: address,
        amount: u64,
        fees: u64,
        backing: u64,
        owed: u64,
    }

    struct SettingsProposed has copy, drop {
        schema: u8,
        market: 0x2::object::ID,
        settings: Settings,
        effective_ms: u64,
    }

    struct SettingsChanged has copy, drop {
        schema: u8,
        market: 0x2::object::ID,
        settings: Settings,
    }

    struct SettingsCancelled has copy, drop {
        schema: u8,
        market: 0x2::object::ID,
    }

    struct VenueProposed has copy, drop {
        schema: u8,
        market: 0x2::object::ID,
        venue: 0x2::object::ID,
        effective_ms: u64,
    }

    struct VenueChanged has copy, drop {
        schema: u8,
        market: 0x2::object::ID,
        venue: 0x2::object::ID,
        price: u256,
    }

    struct GuardChanged has copy, drop {
        schema: u8,
        market: 0x2::object::ID,
        paused: bool,
        by: address,
    }

    struct HedgeMarked has copy, drop {
        schema: u8,
        market: 0x2::object::ID,
        equity: u64,
        base: u64,
        price: u256,
        timestamp_ms: u64,
    }

    struct LentMarked has copy, drop {
        schema: u8,
        market: 0x2::object::ID,
        value: u64,
        timestamp_ms: u64,
    }

    struct CashMoved has copy, drop {
        schema: u8,
        market: 0x2::object::ID,
        place: u8,
        out: bool,
        amount: u64,
        cash: u64,
    }

    struct SettlementNoticed has copy, drop {
        schema: u8,
        market: 0x2::object::ID,
        at_ms: u64,
    }

    struct SettlementBegun has copy, drop {
        schema: u8,
        market: 0x2::object::ID,
        price: u256,
        by: address,
        timestamp_ms: u64,
    }

    struct Settled has copy, drop {
        schema: u8,
        market: 0x2::object::ID,
        owed: u64,
        cash: u64,
        supply: u64,
        forced: bool,
    }

    struct Redeemed has copy, drop {
        schema: u8,
        market: 0x2::object::ID,
        holder: address,
        coins: u64,
        paid: u64,
    }

    struct Backed has copy, drop {
        schema: u8,
        market: 0x2::object::ID,
        backer: 0x2::object::ID,
        by: address,
        amount: u64,
        shares: u128,
        total_shares: u128,
        protocol_shares: u128,
        buffer: u64,
    }

    struct BackerNoticed has copy, drop {
        schema: u8,
        market: 0x2::object::ID,
        backer: 0x2::object::ID,
        open_ms: u64,
        close_ms: u64,
        worth: u64,
    }

    struct Unbacked has copy, drop {
        schema: u8,
        market: 0x2::object::ID,
        backer: 0x2::object::ID,
        by: address,
        amount: u64,
        shares: u128,
        total_shares: u128,
        buffer: u64,
    }

    struct ProtocolSharesBurned has copy, drop {
        schema: u8,
        market: 0x2::object::ID,
        amount: u64,
        shares: u128,
        protocol_shares: u128,
    }

    fun new<T0, T1>(arg0: &0xbe9a7d44698458aea5bcf0ebe57b04ca620362644c1572b256ca831896c488c5::config::Config, arg1: 0x2::coin::TreasuryCap<T0>, arg2: u8, arg3: u8, arg4: 0x2::object::ID, arg5: Settings, arg6: u256, arg7: u64, arg8: &mut 0x2::tx_context::TxContext) : Market<T0, T1> {
        assert!(0x2::coin::total_supply<T0>(&arg1) == 0, 3);
        0xbe9a7d44698458aea5bcf0ebe57b04ca620362644c1572b256ca831896c488c5::math::assert_decimals(arg2, arg3);
        0xbe9a7d44698458aea5bcf0ebe57b04ca620362644c1572b256ca831896c488c5::math::assert_price(arg6);
        validate(&arg5);
        let v0 = Totals{
            bought         : 0,
            sold           : 0,
            fees_total     : 0,
            retained_total : 0,
            treasury_in    : 0,
            treasury_out   : 0,
        };
        let v1 = Market<T0, T1>{
            id               : 0x2::object::new(arg8),
            config           : 0xbe9a7d44698458aea5bcf0ebe57b04ca620362644c1572b256ca831896c488c5::config::id(arg0),
            treasury         : arg1,
            decimals         : arg2,
            quote_decimals   : arg3,
            venue            : arg4,
            settings         : arg5,
            pending          : 0x1::option::none<PendingSettings>(),
            pending_venue    : 0x1::option::none<PendingVenue>(),
            state            : 0,
            guard_paused     : false,
            cash             : 0x2::balance::zero<T1>(),
            hedge_equity     : 0,
            hedge_base       : 0,
            mark_price       : arg6,
            mark_ms          : arg7,
            lent             : 0,
            lent_ms          : arg7,
            last_price       : arg6,
            last_price_ms    : arg7,
            account          : 0x1::option::none<0xbe9a7d44698458aea5bcf0ebe57b04ca620362644c1572b256ca831896c488c5::custody::Vault<T1>>(),
            fees_accrued     : 0,
            settle_notice_ms : 0,
            settle_begun_ms  : 0,
            settle_owed      : 0,
            settle_supply    : 0,
            shares           : 0,
            protocol_shares  : 0,
            totals           : v0,
        };
        let v2 = MarketCreated{
            schema         : 0xbe9a7d44698458aea5bcf0ebe57b04ca620362644c1572b256ca831896c488c5::config::schema(),
            market         : 0x2::object::id<Market<T0, T1>>(&v1),
            config         : v1.config,
            venue          : arg4,
            decimals       : arg2,
            quote_decimals : arg3,
            settings       : arg5,
            price          : arg6,
        };
        0x2::event::emit<MarketCreated>(v2);
        v1
    }

    public fun account_id<T0, T1>(arg0: &Market<T0, T1>) : 0x1::option::Option<0x2::object::ID> {
        if (0x1::option::is_some<0xbe9a7d44698458aea5bcf0ebe57b04ca620362644c1572b256ca831896c488c5::custody::Vault<T1>>(&arg0.account)) {
            0x1::option::some<0x2::object::ID>(0xbe9a7d44698458aea5bcf0ebe57b04ca620362644c1572b256ca831896c488c5::custody::account_id<T1>(0x1::option::borrow<0xbe9a7d44698458aea5bcf0ebe57b04ca620362644c1572b256ca831896c488c5::custody::Vault<T1>>(&arg0.account)))
        } else {
            0x1::option::none<0x2::object::ID>()
        }
    }

    public(friend) fun account<T0, T1>(arg0: &Market<T0, T1>) : &0x1::option::Option<0xbe9a7d44698458aea5bcf0ebe57b04ca620362644c1572b256ca831896c488c5::custody::Vault<T1>> {
        &arg0.account
    }

    public fun admin_guard<T0, T1>(arg0: &0xbe9a7d44698458aea5bcf0ebe57b04ca620362644c1572b256ca831896c488c5::config::AdminCap, arg1: &mut Market<T0, T1>, arg2: &0xbe9a7d44698458aea5bcf0ebe57b04ca620362644c1572b256ca831896c488c5::config::Config, arg3: bool, arg4: &0x2::tx_context::TxContext) {
        check<T0, T1>(arg1, arg2);
        set_guard<T0, T1>(arg1, arg3, 0x2::tx_context::sender(arg4));
    }

    public fun ages(arg0: &Settings) : (u64, u64) {
        (arg0.mark_max_age_ms, arg0.price_max_age_ms)
    }

    public fun apply_settings<T0, T1>(arg0: &mut Market<T0, T1>, arg1: &0xbe9a7d44698458aea5bcf0ebe57b04ca620362644c1572b256ca831896c488c5::config::Config, arg2: &0x2::clock::Clock) {
        check<T0, T1>(arg0, arg1);
        assert!(0x1::option::is_some<PendingSettings>(&arg0.pending), 5);
        let PendingSettings {
            settings     : v0,
            effective_ms : v1,
        } = 0x1::option::extract<PendingSettings>(&mut arg0.pending);
        assert!(0x2::clock::timestamp_ms(arg2) >= v1, 6);
        arg0.settings = v0;
        let v2 = SettingsChanged{
            schema   : 0xbe9a7d44698458aea5bcf0ebe57b04ca620362644c1572b256ca831896c488c5::config::schema(),
            market   : 0x2::object::id<Market<T0, T1>>(arg0),
            settings : v0,
        };
        0x2::event::emit<SettingsChanged>(v2);
    }

    public fun apply_venue<T0, T1>(arg0: &0xbe9a7d44698458aea5bcf0ebe57b04ca620362644c1572b256ca831896c488c5::config::AdminCap, arg1: &mut Market<T0, T1>, arg2: &0xbe9a7d44698458aea5bcf0ebe57b04ca620362644c1572b256ca831896c488c5::config::Config, arg3: &0x3ec740df8428aa9c93aaef7f8cc1542ac3194fd014826b51bfe245346d64efc7::clearing_house::ClearingHouse<T1>, arg4: &0x9237337d846fc90b0a7acbdee4ab91809298691873d28e1d64d91e6303ff6ba4::price_feed_storage::PriceFeedStorage, arg5: &mut 0x3ec740df8428aa9c93aaef7f8cc1542ac3194fd014826b51bfe245346d64efc7::registry::Registry, arg6: u64, arg7: &0x2::clock::Clock, arg8: &mut 0x2::tx_context::TxContext) {
        check<T0, T1>(arg1, arg2);
        assert!(0x1::option::is_some<PendingVenue>(&arg1.pending_venue), 5);
        let PendingVenue {
            venue        : v0,
            effective_ms : v1,
        } = 0x1::option::extract<PendingVenue>(&mut arg1.pending_venue);
        assert!(0x2::clock::timestamp_ms(arg7) >= v1, 6);
        let v2 = if (0x2::object::id<0x3ec740df8428aa9c93aaef7f8cc1542ac3194fd014826b51bfe245346d64efc7::clearing_house::ClearingHouse<T1>>(arg3) == v0) {
            if (arg1.hedge_base == 0) {
                if (arg1.hedge_equity == 0) {
                    0x1::option::is_none<0xbe9a7d44698458aea5bcf0ebe57b04ca620362644c1572b256ca831896c488c5::custody::Vault<T1>>(&arg1.account)
                } else {
                    false
                }
            } else {
                false
            }
        } else {
            false
        };
        assert!(v2, 23);
        let v3 = 0xbe9a7d44698458aea5bcf0ebe57b04ca620362644c1572b256ca831896c488c5::oracle::price<T1>(arg3, arg4, arg7, v0, arg1.settings.price_max_age_ms);
        check_price(v3, arg1.last_price, arg6);
        arg1.venue = v0;
        arg1.mark_price = v3;
        note_price<T0, T1>(arg1, v3, 0x2::clock::timestamp_ms(arg7));
        let v4 = VenueChanged{
            schema : 0xbe9a7d44698458aea5bcf0ebe57b04ca620362644c1572b256ca831896c488c5::config::schema(),
            market : 0x2::object::id<Market<T0, T1>>(arg1),
            venue  : v0,
            price  : v3,
        };
        0x2::event::emit<VenueChanged>(v4);
        open_venue_account<T0, T1>(arg1, arg5, arg8);
    }

    public(friend) fun assert_config<T0, T1>(arg0: &Market<T0, T1>, arg1: &0xbe9a7d44698458aea5bcf0ebe57b04ca620362644c1572b256ca831896c488c5::config::Config) {
        check<T0, T1>(arg0, arg1);
    }

    public(friend) fun assert_room<T0, T1>(arg0: &Market<T0, T1>, arg1: u64, arg2: u256) {
        assert!(0xbe9a7d44698458aea5bcf0ebe57b04ca620362644c1572b256ca831896c488c5::math::value_up(0x2::coin::total_supply<T0>(&arg0.treasury) + arg1, arg2, arg0.decimals, arg0.quote_decimals) <= arg0.settings.cap, 12);
    }

    public fun back<T0, T1>(arg0: &mut Market<T0, T1>, arg1: &0xbe9a7d44698458aea5bcf0ebe57b04ca620362644c1572b256ca831896c488c5::config::Config, arg2: 0x2::coin::Coin<T1>, arg3: u128, arg4: &0x3ec740df8428aa9c93aaef7f8cc1542ac3194fd014826b51bfe245346d64efc7::clearing_house::ClearingHouse<T1>, arg5: &0x9237337d846fc90b0a7acbdee4ab91809298691873d28e1d64d91e6303ff6ba4::price_feed_storage::PriceFeedStorage, arg6: &0x2::clock::Clock, arg7: &mut 0x2::tx_context::TxContext) : Backer {
        check<T0, T1>(arg0, arg1);
        let v0 = 0xbe9a7d44698458aea5bcf0ebe57b04ca620362644c1572b256ca831896c488c5::oracle::feed_price<T1>(arg4, arg5, arg6, arg0.venue, arg0.settings.price_max_age_ms);
        back_at<T0, T1>(arg0, arg2, arg3, v0, 0x2::clock::timestamp_ms(arg6), arg7)
    }

    public(friend) fun back_at<T0, T1>(arg0: &mut Market<T0, T1>, arg1: 0x2::coin::Coin<T1>, arg2: u128, arg3: u256, arg4: u64, arg5: &mut 0x2::tx_context::TxContext) : Backer {
        assert!(arg0.state == 0, 7);
        assert!(!marks_stale<T0, T1>(arg0, arg4), 15);
        let v0 = 0x2::coin::value<T1>(&arg1);
        assert!(v0 > 0, 8);
        let (v1, _) = backing_at<T0, T1>(arg0, arg3, arg4);
        assert!(v1 >= owed_at<T0, T1>(arg0, arg3) + arg0.fees_accrued, 24);
        let v3 = buffer_at<T0, T1>(arg0, arg3, arg4);
        if (arg0.shares == 0 && v3 > 0) {
            let v4 = (v3 as u256) * 1000000 / 1;
            arg0.protocol_shares = (v4 as u128);
            arg0.shares = (v4 as u128);
        };
        let v5 = (v0 as u256) * ((arg0.shares as u256) + 1000000) / ((v3 as u256) + 1);
        assert!(v5 > 0 && (arg0.shares as u256) + v5 <= 1329227995784915872903807060280344576, 24);
        assert!(v5 >= (arg2 as u256), 9);
        0x2::balance::join<T1>(&mut arg0.cash, 0x2::coin::into_balance<T1>(arg1));
        arg0.shares = arg0.shares + (v5 as u128);
        arg0.totals.treasury_in = arg0.totals.treasury_in + (v0 as u128);
        let v6 = Backer{
            id              : 0x2::object::new(arg5),
            market          : 0x2::object::id<Market<T0, T1>>(arg0),
            shares          : (v5 as u128),
            open_ms         : 0,
            close_ms        : 0,
            worth_at_notice : 0,
        };
        let v7 = Backed{
            schema          : 0xbe9a7d44698458aea5bcf0ebe57b04ca620362644c1572b256ca831896c488c5::config::schema(),
            market          : 0x2::object::id<Market<T0, T1>>(arg0),
            backer          : 0x2::object::id<Backer>(&v6),
            by              : 0x2::tx_context::sender(arg5),
            amount          : v0,
            shares          : (v5 as u128),
            total_shares    : arg0.shares,
            protocol_shares : arg0.protocol_shares,
            buffer          : v3 + v0,
        };
        0x2::event::emit<Backed>(v7);
        v6
    }

    public fun backer_info(arg0: &Backer) : (0x2::object::ID, u128, u64, u64, u64) {
        (arg0.market, arg0.shares, arg0.open_ms, arg0.close_ms, arg0.worth_at_notice)
    }

    public(friend) fun backer_notice_at<T0, T1>(arg0: &Market<T0, T1>, arg1: &mut Backer, arg2: u256, arg3: u64) {
        assert!(arg1.market == 0x2::object::id<Market<T0, T1>>(arg0), 26);
        assert!(arg0.state == 0, 7);
        assert!(!marks_stale<T0, T1>(arg0, arg3), 15);
        let v0 = arg0.settings.backer_notice_ms;
        arg1.open_ms = arg3 + v0;
        arg1.close_ms = arg3 + 2 * v0;
        arg1.worth_at_notice = worth(arg1.shares, arg0.shares, buffer_at<T0, T1>(arg0, arg2, arg3));
        let v1 = BackerNoticed{
            schema   : 0xbe9a7d44698458aea5bcf0ebe57b04ca620362644c1572b256ca831896c488c5::config::schema(),
            market   : 0x2::object::id<Market<T0, T1>>(arg0),
            backer   : 0x2::object::id<Backer>(arg1),
            open_ms  : arg1.open_ms,
            close_ms : arg1.close_ms,
            worth    : arg1.worth_at_notice,
        };
        0x2::event::emit<BackerNoticed>(v1);
    }

    public fun backer_notice_ms(arg0: &Settings) : u64 {
        arg0.backer_notice_ms
    }

    public fun backer_worth<T0, T1>(arg0: &Market<T0, T1>, arg1: &Backer, arg2: u256, arg3: u64) : u64 {
        let v0 = if (arg0.state == 2) {
            settled_buffer<T0, T1>(arg0)
        } else {
            buffer_at<T0, T1>(arg0, arg2, arg3)
        };
        worth(arg1.shares, arg0.shares, v0)
    }

    public fun backing<T0, T1>(arg0: &Market<T0, T1>, arg1: u256, arg2: u64) : (u64, u64, bool) {
        let (v0, v1) = backing_at<T0, T1>(arg0, arg1, arg2);
        (v0, owed_at<T0, T1>(arg0, arg1), v1)
    }

    fun backing_at<T0, T1>(arg0: &Market<T0, T1>, arg1: u256, arg2: u64) : (u64, bool) {
        (0x2::balance::value<T1>(&arg0.cash) + arg0.lent + hedge_now<T0, T1>(arg0, arg1), !marks_stale<T0, T1>(arg0, arg2))
    }

    public fun backing_levels(arg0: &Settings) : (u64, u64) {
        (arg0.min_backing_bps, arg0.target_backing_bps)
    }

    public fun begin_settlement<T0, T1>(arg0: &mut Market<T0, T1>, arg1: &0xbe9a7d44698458aea5bcf0ebe57b04ca620362644c1572b256ca831896c488c5::config::Config, arg2: &0x2::clock::Clock, arg3: &0x2::tx_context::TxContext) {
        check<T0, T1>(arg0, arg1);
        assert!(arg0.state == 0, 7);
        let v0 = 0x2::clock::timestamp_ms(arg2);
        assert!(arg0.settle_notice_ms != 0 && v0 >= arg0.settle_notice_ms || v0 >= arg0.last_price_ms + 0xbe9a7d44698458aea5bcf0ebe57b04ca620362644c1572b256ca831896c488c5::config::settle_delay_ms(arg1), 22);
        arg0.state = 1;
        arg0.settle_begun_ms = v0;
        let v1 = SettlementBegun{
            schema       : 0xbe9a7d44698458aea5bcf0ebe57b04ca620362644c1572b256ca831896c488c5::config::schema(),
            market       : 0x2::object::id<Market<T0, T1>>(arg0),
            price        : arg0.last_price,
            by           : 0x2::tx_context::sender(arg3),
            timestamp_ms : v0,
        };
        0x2::event::emit<SettlementBegun>(v1);
    }

    fun buffer_at<T0, T1>(arg0: &Market<T0, T1>, arg1: u256, arg2: u64) : u64 {
        let (v0, _) = backing_at<T0, T1>(arg0, arg1, arg2);
        0xbe9a7d44698458aea5bcf0ebe57b04ca620362644c1572b256ca831896c488c5::math::sat_sub(v0, owed_at<T0, T1>(arg0, arg1) + arg0.fees_accrued)
    }

    public fun buffer_shares<T0, T1>(arg0: &Market<T0, T1>, arg1: u256, arg2: u64) : (u128, u128, u64) {
        let v0 = if (arg0.state == 2) {
            settled_buffer<T0, T1>(arg0)
        } else {
            buffer_at<T0, T1>(arg0, arg1, arg2)
        };
        (arg0.shares, arg0.protocol_shares, v0)
    }

    fun burn_protocol_shares<T0, T1>(arg0: &mut Market<T0, T1>, arg1: u64, arg2: u64) {
        let v0 = ((arg1 as u256) * ((arg0.shares as u256) + 1000000) + (arg2 as u256) + 1 - 1) / ((arg2 as u256) + 1);
        assert!(v0 <= (arg0.protocol_shares as u256), 21);
        arg0.protocol_shares = arg0.protocol_shares - (v0 as u128);
        arg0.shares = arg0.shares - (v0 as u128);
        let v1 = ProtocolSharesBurned{
            schema          : 0xbe9a7d44698458aea5bcf0ebe57b04ca620362644c1572b256ca831896c488c5::config::schema(),
            market          : 0x2::object::id<Market<T0, T1>>(arg0),
            amount          : arg1,
            shares          : (v0 as u128),
            protocol_shares : arg0.protocol_shares,
        };
        0x2::event::emit<ProtocolSharesBurned>(v1);
    }

    public(friend) fun buy_block<T0, T1>(arg0: &Market<T0, T1>, arg1: &0xbe9a7d44698458aea5bcf0ebe57b04ca620362644c1572b256ca831896c488c5::config::Config, arg2: u64, arg3: u64) : u64 {
        let v0 = buy_gate<T0, T1>(arg0, arg1, arg2);
        if (v0 != 0) {
            return v0
        };
        if (marks_stale<T0, T1>(arg0, arg3)) {
            return 15
        };
        0
    }

    public(friend) fun buy_gate<T0, T1>(arg0: &Market<T0, T1>, arg1: &0xbe9a7d44698458aea5bcf0ebe57b04ca620362644c1572b256ca831896c488c5::config::Config, arg2: u64) : u64 {
        if (arg0.state != 0) {
            return 7
        };
        if (0xbe9a7d44698458aea5bcf0ebe57b04ca620362644c1572b256ca831896c488c5::config::paused(arg1) || !arg0.settings.buys_enabled) {
            return 10
        };
        if (arg0.guard_paused) {
            return 11
        };
        if (arg0.settings.max_funding_bps > 0 && arg2 > arg0.settings.max_funding_bps) {
            return 16
        };
        0
    }

    public(friend) fun buy_paid<T0, T1>(arg0: &mut Market<T0, T1>, arg1: &0xbe9a7d44698458aea5bcf0ebe57b04ca620362644c1572b256ca831896c488c5::config::Config, arg2: u64, arg3: u64, arg4: u256, arg5: u64, arg6: u64, arg7: u64, arg8: &mut 0x2::tx_context::TxContext) : 0x2::coin::Coin<T0> {
        check<T0, T1>(arg0, arg1);
        0xbe9a7d44698458aea5bcf0ebe57b04ca620362644c1572b256ca831896c488c5::math::assert_price(arg4);
        let v0 = buy_block<T0, T1>(arg0, arg1, arg5, arg7);
        assert!(v0 == 0, v0);
        let v1 = 0xbe9a7d44698458aea5bcf0ebe57b04ca620362644c1572b256ca831896c488c5::math::share_up(arg2, arg0.settings.buy_fee_bps);
        let v2 = 0xbe9a7d44698458aea5bcf0ebe57b04ca620362644c1572b256ca831896c488c5::math::coins_down(0xbe9a7d44698458aea5bcf0ebe57b04ca620362644c1572b256ca831896c488c5::math::sat_sub(arg2 - v1, arg6), arg4, arg0.decimals, arg0.quote_decimals);
        assert!(v2 > 0, 8);
        assert!(v2 >= arg3, 9);
        let v3 = 0x2::coin::total_supply<T0>(&arg0.treasury) + v2;
        let v4 = 0xbe9a7d44698458aea5bcf0ebe57b04ca620362644c1572b256ca831896c488c5::math::value_up(v3, arg4, arg0.decimals, arg0.quote_decimals);
        assert!(v4 <= arg0.settings.cap, 12);
        assert!(0xbe9a7d44698458aea5bcf0ebe57b04ca620362644c1572b256ca831896c488c5::math::value_up(0xbe9a7d44698458aea5bcf0ebe57b04ca620362644c1572b256ca831896c488c5::math::sat_sub(v3, arg0.hedge_base), arg4, arg0.decimals, arg0.quote_decimals) <= unhedged_allowance(&arg0.settings, v4), 13);
        let (v5, _) = backing_at<T0, T1>(arg0, arg4, arg7);
        assert!(0xbe9a7d44698458aea5bcf0ebe57b04ca620362644c1572b256ca831896c488c5::math::covers(v5, v4, arg0.settings.min_backing_bps), 14);
        let v7 = take_fee<T0, T1>(arg0, v1);
        arg0.totals.bought = arg0.totals.bought + (arg2 as u128);
        note_price<T0, T1>(arg0, arg4, arg7);
        let v8 = Bought{
            schema     : 0xbe9a7d44698458aea5bcf0ebe57b04ca620362644c1572b256ca831896c488c5::config::schema(),
            market     : 0x2::object::id<Market<T0, T1>>(arg0),
            buyer      : 0x2::tx_context::sender(arg8),
            paid       : arg2,
            fee        : v1,
            retained   : v7,
            hedge_cost : arg6,
            coins      : v2,
            price      : arg4,
            supply     : v3,
            backing    : v5,
            owed       : v4,
        };
        0x2::event::emit<Bought>(v8);
        0x2::coin::mint<T0>(&mut arg0.treasury, v2, arg8)
    }

    public fun buys_enabled(arg0: &Settings) : bool {
        arg0.buys_enabled
    }

    public fun cancel_settings<T0, T1>(arg0: &0xbe9a7d44698458aea5bcf0ebe57b04ca620362644c1572b256ca831896c488c5::config::AdminCap, arg1: &mut Market<T0, T1>, arg2: &0xbe9a7d44698458aea5bcf0ebe57b04ca620362644c1572b256ca831896c488c5::config::Config) {
        check<T0, T1>(arg1, arg2);
        assert!(0x1::option::is_some<PendingSettings>(&arg1.pending), 5);
        arg1.pending = 0x1::option::none<PendingSettings>();
        let v0 = SettingsCancelled{
            schema : 0xbe9a7d44698458aea5bcf0ebe57b04ca620362644c1572b256ca831896c488c5::config::schema(),
            market : 0x2::object::id<Market<T0, T1>>(arg1),
        };
        0x2::event::emit<SettingsCancelled>(v0);
    }

    public fun cancel_venue<T0, T1>(arg0: &0xbe9a7d44698458aea5bcf0ebe57b04ca620362644c1572b256ca831896c488c5::config::AdminCap, arg1: &mut Market<T0, T1>, arg2: &0xbe9a7d44698458aea5bcf0ebe57b04ca620362644c1572b256ca831896c488c5::config::Config) {
        check<T0, T1>(arg1, arg2);
        arg1.pending_venue = 0x1::option::none<PendingVenue>();
    }

    public fun cap(arg0: &Settings) : u64 {
        arg0.cap
    }

    public fun cash<T0, T1>(arg0: &Market<T0, T1>) : u64 {
        0x2::balance::value<T1>(&arg0.cash)
    }

    public(friend) fun cash_in<T0, T1>(arg0: &mut Market<T0, T1>, arg1: 0x2::coin::Coin<T1>, arg2: u8) {
        let v0 = 0x2::coin::value<T1>(&arg1);
        0x2::balance::join<T1>(&mut arg0.cash, 0x2::coin::into_balance<T1>(arg1));
        if (v0 > 0 && arg2 != 0) {
            let v1 = CashMoved{
                schema : 0xbe9a7d44698458aea5bcf0ebe57b04ca620362644c1572b256ca831896c488c5::config::schema(),
                market : 0x2::object::id<Market<T0, T1>>(arg0),
                place  : arg2,
                out    : false,
                amount : v0,
                cash   : 0x2::balance::value<T1>(&arg0.cash),
            };
            0x2::event::emit<CashMoved>(v1);
        };
    }

    public(friend) fun cash_out<T0, T1>(arg0: &mut Market<T0, T1>, arg1: u64, arg2: u8, arg3: &mut 0x2::tx_context::TxContext) : 0x2::coin::Coin<T1> {
        assert!(arg1 > 0 && arg1 <= 0x2::balance::value<T1>(&arg0.cash), 20);
        let v0 = CashMoved{
            schema : 0xbe9a7d44698458aea5bcf0ebe57b04ca620362644c1572b256ca831896c488c5::config::schema(),
            market : 0x2::object::id<Market<T0, T1>>(arg0),
            place  : arg2,
            out    : true,
            amount : arg1,
            cash   : 0x2::balance::value<T1>(&arg0.cash),
        };
        0x2::event::emit<CashMoved>(v0);
        0x2::coin::take<T1>(&mut arg0.cash, arg1, arg3)
    }

    fun check<T0, T1>(arg0: &Market<T0, T1>, arg1: &0xbe9a7d44698458aea5bcf0ebe57b04ca620362644c1572b256ca831896c488c5::config::Config) {
        0xbe9a7d44698458aea5bcf0ebe57b04ca620362644c1572b256ca831896c488c5::config::assert_version(arg1);
        assert!(arg0.config == 0xbe9a7d44698458aea5bcf0ebe57b04ca620362644c1572b256ca831896c488c5::config::id(arg1), 1);
    }

    fun check_price(arg0: u256, arg1: u256, arg2: u64) {
        assert!(arg2 <= 500 && arg1 > 0, 2);
        let v0 = if (arg0 > arg1) {
            arg0 - arg1
        } else {
            arg1 - arg0
        };
        assert!(v0 * (0xbe9a7d44698458aea5bcf0ebe57b04ca620362644c1572b256ca831896c488c5::math::bps() as u256) <= arg1 * (arg2 as u256), 4);
    }

    public fun coins_for<T0, T1>(arg0: &Market<T0, T1>, arg1: u64, arg2: u256) : u64 {
        0xbe9a7d44698458aea5bcf0ebe57b04ca620362644c1572b256ca831896c488c5::math::coins_down(arg1 - 0xbe9a7d44698458aea5bcf0ebe57b04ca620362644c1572b256ca831896c488c5::math::share_up(arg1, arg0.settings.buy_fee_bps), arg2, arg0.decimals, arg0.quote_decimals)
    }

    public fun collect_fees<T0, T1>(arg0: &mut Market<T0, T1>, arg1: &0xbe9a7d44698458aea5bcf0ebe57b04ca620362644c1572b256ca831896c488c5::config::Config, arg2: &0x3ec740df8428aa9c93aaef7f8cc1542ac3194fd014826b51bfe245346d64efc7::clearing_house::ClearingHouse<T1>, arg3: &0x9237337d846fc90b0a7acbdee4ab91809298691873d28e1d64d91e6303ff6ba4::price_feed_storage::PriceFeedStorage, arg4: &0x2::clock::Clock, arg5: &mut 0x2::tx_context::TxContext) : u64 {
        check<T0, T1>(arg0, arg1);
        let v0 = 0xbe9a7d44698458aea5bcf0ebe57b04ca620362644c1572b256ca831896c488c5::oracle::feed_price<T1>(arg2, arg3, arg4, arg0.venue, arg0.settings.price_max_age_ms);
        collect_fees_at<T0, T1>(arg0, arg1, v0, 0x2::clock::timestamp_ms(arg4), arg5)
    }

    public(friend) fun collect_fees_at<T0, T1>(arg0: &mut Market<T0, T1>, arg1: &0xbe9a7d44698458aea5bcf0ebe57b04ca620362644c1572b256ca831896c488c5::config::Config, arg2: u256, arg3: u64, arg4: &mut 0x2::tx_context::TxContext) : u64 {
        let v0 = 0x1::u64::min(arg0.fees_accrued, surplus_at<T0, T1>(arg0, arg2, arg3));
        if (v0 > 0) {
            pay_out_at<T0, T1>(arg0, arg1, v0, v0, arg2, arg3, arg4);
        };
        v0
    }

    public fun create<T0, T1>(arg0: &0xbe9a7d44698458aea5bcf0ebe57b04ca620362644c1572b256ca831896c488c5::config::AdminCap, arg1: &0xbe9a7d44698458aea5bcf0ebe57b04ca620362644c1572b256ca831896c488c5::config::Config, arg2: 0x2::coin::TreasuryCap<T0>, arg3: u8, arg4: u8, arg5: &0x3ec740df8428aa9c93aaef7f8cc1542ac3194fd014826b51bfe245346d64efc7::clearing_house::ClearingHouse<T1>, arg6: &0x9237337d846fc90b0a7acbdee4ab91809298691873d28e1d64d91e6303ff6ba4::price_feed_storage::PriceFeedStorage, arg7: &mut 0x3ec740df8428aa9c93aaef7f8cc1542ac3194fd014826b51bfe245346d64efc7::registry::Registry, arg8: Settings, arg9: u256, arg10: u64, arg11: &0x2::clock::Clock, arg12: &mut 0x2::tx_context::TxContext) : 0x2::object::ID {
        0xbe9a7d44698458aea5bcf0ebe57b04ca620362644c1572b256ca831896c488c5::config::assert_version(arg1);
        let v0 = 0xbe9a7d44698458aea5bcf0ebe57b04ca620362644c1572b256ca831896c488c5::oracle::price<T1>(arg5, arg6, arg11, 0x2::object::id<0x3ec740df8428aa9c93aaef7f8cc1542ac3194fd014826b51bfe245346d64efc7::clearing_house::ClearingHouse<T1>>(arg5), arg8.price_max_age_ms);
        check_price(v0, arg9, arg10);
        let v1 = new<T0, T1>(arg1, arg2, arg3, arg4, 0x2::object::id<0x3ec740df8428aa9c93aaef7f8cc1542ac3194fd014826b51bfe245346d64efc7::clearing_house::ClearingHouse<T1>>(arg5), arg8, v0, 0x2::clock::timestamp_ms(arg11), arg12);
        let v2 = &mut v1;
        open_venue_account<T0, T1>(v2, arg7, arg12);
        0x2::transfer::share_object<Market<T0, T1>>(v1);
        0x2::object::id<Market<T0, T1>>(&v1)
    }

    public fun decimals<T0, T1>(arg0: &Market<T0, T1>) : (u8, u8) {
        (arg0.decimals, arg0.quote_decimals)
    }

    public fun fees(arg0: &Settings) : (u64, u64) {
        (arg0.buy_fee_bps, arg0.sell_fee_bps)
    }

    public fun fees_accrued<T0, T1>(arg0: &Market<T0, T1>) : u64 {
        arg0.fees_accrued
    }

    public fun finish_settlement<T0, T1>(arg0: &mut Market<T0, T1>, arg1: &0xbe9a7d44698458aea5bcf0ebe57b04ca620362644c1572b256ca831896c488c5::config::Config) {
        check<T0, T1>(arg0, arg1);
        assert!(arg0.state == 1, 7);
        let v0 = if (arg0.hedge_base == 0) {
            if (arg0.hedge_equity == 0) {
                arg0.lent == 0
            } else {
                false
            }
        } else {
            false
        };
        assert!(v0, 23);
        settle<T0, T1>(arg0, false);
    }

    public fun force_settlement<T0, T1>(arg0: &0xbe9a7d44698458aea5bcf0ebe57b04ca620362644c1572b256ca831896c488c5::config::AdminCap, arg1: &mut Market<T0, T1>, arg2: &0xbe9a7d44698458aea5bcf0ebe57b04ca620362644c1572b256ca831896c488c5::config::Config, arg3: &0x2::clock::Clock) {
        check<T0, T1>(arg1, arg2);
        assert!(arg1.state == 1 && 0x2::clock::timestamp_ms(arg3) >= arg1.settle_begun_ms + 0xbe9a7d44698458aea5bcf0ebe57b04ca620362644c1572b256ca831896c488c5::config::settle_delay_ms(arg2), 6);
        settle<T0, T1>(arg1, true);
    }

    public fun fund<T0, T1>(arg0: &mut Market<T0, T1>, arg1: &0xbe9a7d44698458aea5bcf0ebe57b04ca620362644c1572b256ca831896c488c5::config::Config, arg2: 0x2::coin::Coin<T1>, arg3: &0x2::tx_context::TxContext) {
        check<T0, T1>(arg0, arg1);
        let v0 = 0x2::coin::value<T1>(&arg2);
        assert!(v0 > 0, 8);
        0x2::balance::join<T1>(&mut arg0.cash, 0x2::coin::into_balance<T1>(arg2));
        arg0.totals.treasury_in = arg0.totals.treasury_in + (v0 as u128);
        let v1 = Funded{
            schema : 0xbe9a7d44698458aea5bcf0ebe57b04ca620362644c1572b256ca831896c488c5::config::schema(),
            market : 0x2::object::id<Market<T0, T1>>(arg0),
            by     : 0x2::tx_context::sender(arg3),
            amount : v0,
            cash   : 0x2::balance::value<T1>(&arg0.cash),
        };
        0x2::event::emit<Funded>(v1);
    }

    public fun give_backer_notice<T0, T1>(arg0: &Market<T0, T1>, arg1: &0xbe9a7d44698458aea5bcf0ebe57b04ca620362644c1572b256ca831896c488c5::config::Config, arg2: &mut Backer, arg3: &0x3ec740df8428aa9c93aaef7f8cc1542ac3194fd014826b51bfe245346d64efc7::clearing_house::ClearingHouse<T1>, arg4: &0x9237337d846fc90b0a7acbdee4ab91809298691873d28e1d64d91e6303ff6ba4::price_feed_storage::PriceFeedStorage, arg5: &0x2::clock::Clock) {
        check<T0, T1>(arg0, arg1);
        backer_notice_at<T0, T1>(arg0, arg2, 0xbe9a7d44698458aea5bcf0ebe57b04ca620362644c1572b256ca831896c488c5::oracle::feed_price<T1>(arg3, arg4, arg5, arg0.venue, arg0.settings.price_max_age_ms), 0x2::clock::timestamp_ms(arg5));
    }

    public fun give_settlement_notice<T0, T1>(arg0: &0xbe9a7d44698458aea5bcf0ebe57b04ca620362644c1572b256ca831896c488c5::config::AdminCap, arg1: &mut Market<T0, T1>, arg2: &0xbe9a7d44698458aea5bcf0ebe57b04ca620362644c1572b256ca831896c488c5::config::Config, arg3: &0x2::clock::Clock) {
        check<T0, T1>(arg1, arg2);
        assert!(arg1.state == 0, 7);
        arg1.settle_notice_ms = 0x2::clock::timestamp_ms(arg3) + 0xbe9a7d44698458aea5bcf0ebe57b04ca620362644c1572b256ca831896c488c5::config::settle_delay_ms(arg2);
        let v0 = SettlementNoticed{
            schema : 0xbe9a7d44698458aea5bcf0ebe57b04ca620362644c1572b256ca831896c488c5::config::schema(),
            market : 0x2::object::id<Market<T0, T1>>(arg1),
            at_ms  : arg1.settle_notice_ms,
        };
        0x2::event::emit<SettlementNoticed>(v0);
    }

    public fun guard_pause<T0, T1>(arg0: &mut Market<T0, T1>, arg1: &0xbe9a7d44698458aea5bcf0ebe57b04ca620362644c1572b256ca831896c488c5::config::Config, arg2: &0x2::tx_context::TxContext) {
        check<T0, T1>(arg0, arg1);
        0xbe9a7d44698458aea5bcf0ebe57b04ca620362644c1572b256ca831896c488c5::config::assert_keeper(arg1, arg2);
        set_guard<T0, T1>(arg0, true, 0x2::tx_context::sender(arg2));
    }

    public fun guard_paused<T0, T1>(arg0: &Market<T0, T1>) : bool {
        arg0.guard_paused
    }

    public fun hedge_mark<T0, T1>(arg0: &Market<T0, T1>) : (u64, u64, u256, u64) {
        (arg0.hedge_equity, arg0.hedge_base, arg0.mark_price, arg0.mark_ms)
    }

    fun hedge_now<T0, T1>(arg0: &Market<T0, T1>, arg1: u256) : u64 {
        let (v0, v1) = 0xbe9a7d44698458aea5bcf0ebe57b04ca620362644c1572b256ca831896c488c5::math::price_move(arg0.hedge_base, arg0.mark_price, arg1, arg0.decimals, arg0.quote_decimals);
        if (v0) {
            arg0.hedge_equity + v1
        } else {
            0xbe9a7d44698458aea5bcf0ebe57b04ca620362644c1572b256ca831896c488c5::math::sat_sub(arg0.hedge_equity, v1)
        }
    }

    public fun hedge_rules(arg0: &Settings) : (u64, u64, u64, u64) {
        (arg0.hedge_tolerance_bps, arg0.hedge_step, arg0.hedge_slippage_bps, arg0.margin_bps)
    }

    public(friend) fun hedge_target<T0, T1>(arg0: &Market<T0, T1>) : u64 {
        if (arg0.state == 0) {
            0x2::coin::total_supply<T0>(&arg0.treasury)
        } else {
            0
        }
    }

    public fun last_price<T0, T1>(arg0: &Market<T0, T1>) : (u256, u64) {
        (arg0.last_price, arg0.last_price_ms)
    }

    public fun lend_bps(arg0: &Settings) : u64 {
        arg0.lend_bps
    }

    public fun lent_mark<T0, T1>(arg0: &Market<T0, T1>) : (u64, u64) {
        (arg0.lent, arg0.lent_ms)
    }

    public fun loosens(arg0: &Settings, arg1: &Settings) : bool {
        if (arg1.buy_fee_bps > arg0.buy_fee_bps) {
            true
        } else if (arg1.sell_fee_bps > arg0.sell_fee_bps) {
            true
        } else if (arg1.min_backing_bps < arg0.min_backing_bps) {
            true
        } else if (arg1.target_backing_bps < arg0.target_backing_bps) {
            true
        } else if (arg1.ready_cash_bps < arg0.ready_cash_bps) {
            true
        } else if (arg1.unhedged_bps > arg0.unhedged_bps) {
            true
        } else if (arg1.unhedged_floor > arg0.unhedged_floor) {
            true
        } else if (arg1.unhedged_max > arg0.unhedged_max) {
            true
        } else if (arg1.hedge_slippage_bps > arg0.hedge_slippage_bps) {
            true
        } else if (arg1.margin_bps < arg0.margin_bps) {
            true
        } else if (arg1.lend_bps > arg0.lend_bps) {
            true
        } else if (arg1.mark_max_age_ms > arg0.mark_max_age_ms) {
            true
        } else if (arg0.price_max_age_ms != 0 && (arg1.price_max_age_ms == 0 || arg1.price_max_age_ms > arg0.price_max_age_ms)) {
            true
        } else if (arg1.retain_bps < arg0.retain_bps) {
            true
        } else if (arg1.trade_slippage_bps > arg0.trade_slippage_bps) {
            true
        } else {
            arg1.backer_notice_ms < arg0.backer_notice_ms
        }
    }

    fun marks_stale<T0, T1>(arg0: &Market<T0, T1>, arg1: u64) : bool {
        let v0 = arg0.settings.mark_max_age_ms;
        (arg0.hedge_base > 0 || arg0.hedge_equity > 0) && arg1 > arg0.mark_ms + v0 || arg0.lent > 0 && arg1 > arg0.lent_ms + v0
    }

    public fun max_funding_bps(arg0: &Settings) : u64 {
        arg0.max_funding_bps
    }

    public fun new_settings(arg0: bool, arg1: u64, arg2: u64, arg3: u64, arg4: u64, arg5: u64, arg6: u64, arg7: u64, arg8: u64, arg9: u64, arg10: u64, arg11: u64, arg12: u64, arg13: u64, arg14: u64, arg15: u64, arg16: u64, arg17: u64, arg18: u64, arg19: u64, arg20: u64) : Settings {
        let v0 = Settings{
            buys_enabled        : arg0,
            cap                 : arg1,
            buy_fee_bps         : arg2,
            sell_fee_bps        : arg3,
            min_backing_bps     : arg4,
            target_backing_bps  : arg5,
            ready_cash_bps      : arg6,
            unhedged_bps        : arg7,
            unhedged_floor      : arg8,
            unhedged_max        : arg9,
            hedge_tolerance_bps : arg10,
            hedge_step          : arg11,
            hedge_slippage_bps  : arg12,
            margin_bps          : arg13,
            max_funding_bps     : arg14,
            lend_bps            : arg15,
            mark_max_age_ms     : arg16,
            price_max_age_ms    : arg17,
            retain_bps          : arg18,
            trade_slippage_bps  : arg19,
            backer_notice_ms    : arg20,
        };
        validate(&v0);
        v0
    }

    fun note_price<T0, T1>(arg0: &mut Market<T0, T1>, arg1: u256, arg2: u64) {
        arg0.last_price = arg1;
        arg0.last_price_ms = arg2;
    }

    public(friend) fun open_venue_account<T0, T1>(arg0: &mut Market<T0, T1>, arg1: &mut 0x3ec740df8428aa9c93aaef7f8cc1542ac3194fd014826b51bfe245346d64efc7::registry::Registry, arg2: &mut 0x2::tx_context::TxContext) {
        assert!(arg0.state == 0, 7);
        assert!(0x1::option::is_none<0xbe9a7d44698458aea5bcf0ebe57b04ca620362644c1572b256ca831896c488c5::custody::Vault<T1>>(&arg0.account), 27);
        let v0 = 0xbe9a7d44698458aea5bcf0ebe57b04ca620362644c1572b256ca831896c488c5::custody::new<T1>(arg1, arg0.venue, arg2);
        let v1 = AccountOpened{
            schema  : 0xbe9a7d44698458aea5bcf0ebe57b04ca620362644c1572b256ca831896c488c5::config::schema(),
            market  : 0x2::object::id<Market<T0, T1>>(arg0),
            account : 0xbe9a7d44698458aea5bcf0ebe57b04ca620362644c1572b256ca831896c488c5::custody::account_id<T1>(&v0),
            venue   : arg0.venue,
        };
        0x2::event::emit<AccountOpened>(v1);
        0x1::option::fill<0xbe9a7d44698458aea5bcf0ebe57b04ca620362644c1572b256ca831896c488c5::custody::Vault<T1>>(&mut arg0.account, v0);
    }

    public fun owed_at<T0, T1>(arg0: &Market<T0, T1>, arg1: u256) : u64 {
        0xbe9a7d44698458aea5bcf0ebe57b04ca620362644c1572b256ca831896c488c5::math::value_up(0x2::coin::total_supply<T0>(&arg0.treasury), arg1, arg0.decimals, arg0.quote_decimals)
    }

    fun pay_out_at<T0, T1>(arg0: &mut Market<T0, T1>, arg1: &0xbe9a7d44698458aea5bcf0ebe57b04ca620362644c1572b256ca831896c488c5::config::Config, arg2: u64, arg3: u64, arg4: u256, arg5: u64, arg6: &mut 0x2::tx_context::TxContext) {
        assert!(arg2 > 0, 8);
        if (arg0.state == 2) {
            assert!(arg2 <= 0xbe9a7d44698458aea5bcf0ebe57b04ca620362644c1572b256ca831896c488c5::math::sat_sub(0x2::balance::value<T1>(&arg0.cash), still_due<T0, T1>(arg0)), 21);
        } else {
            assert!(arg2 <= surplus_at<T0, T1>(arg0, arg4, arg5), 21);
        };
        arg0.fees_accrued = arg0.fees_accrued - arg3;
        arg0.totals.treasury_out = arg0.totals.treasury_out + ((arg2 - arg3) as u128);
        let v0 = 0xbe9a7d44698458aea5bcf0ebe57b04ca620362644c1572b256ca831896c488c5::config::fee_recipient(arg1);
        let (v1, _) = backing_at<T0, T1>(arg0, arg4, arg5);
        let v3 = PaidOut{
            schema  : 0xbe9a7d44698458aea5bcf0ebe57b04ca620362644c1572b256ca831896c488c5::config::schema(),
            market  : 0x2::object::id<Market<T0, T1>>(arg0),
            to      : v0,
            amount  : arg2,
            fees    : arg3,
            backing : v1 - arg2,
            owed    : owed_at<T0, T1>(arg0, arg4),
        };
        0x2::event::emit<PaidOut>(v3);
        0x2::transfer::public_transfer<0x2::coin::Coin<T1>>(0x2::coin::take<T1>(&mut arg0.cash, arg2, arg6), v0);
    }

    public fun pending_settings<T0, T1>(arg0: &Market<T0, T1>) : (bool, Settings, u64) {
        if (0x1::option::is_some<PendingSettings>(&arg0.pending)) {
            let v3 = 0x1::option::borrow<PendingSettings>(&arg0.pending);
            (true, v3.settings, v3.effective_ms)
        } else {
            (false, arg0.settings, 0)
        }
    }

    public fun propose_venue<T0, T1>(arg0: &0xbe9a7d44698458aea5bcf0ebe57b04ca620362644c1572b256ca831896c488c5::config::AdminCap, arg1: &mut Market<T0, T1>, arg2: &0xbe9a7d44698458aea5bcf0ebe57b04ca620362644c1572b256ca831896c488c5::config::Config, arg3: 0x2::object::ID, arg4: &0x2::clock::Clock) {
        check<T0, T1>(arg1, arg2);
        let v0 = 0x2::clock::timestamp_ms(arg4) + 0xbe9a7d44698458aea5bcf0ebe57b04ca620362644c1572b256ca831896c488c5::config::change_delay_ms(arg2);
        let v1 = PendingVenue{
            venue        : arg3,
            effective_ms : v0,
        };
        arg1.pending_venue = 0x1::option::some<PendingVenue>(v1);
        let v2 = VenueProposed{
            schema       : 0xbe9a7d44698458aea5bcf0ebe57b04ca620362644c1572b256ca831896c488c5::config::schema(),
            market       : 0x2::object::id<Market<T0, T1>>(arg1),
            venue        : arg3,
            effective_ms : v0,
        };
        0x2::event::emit<VenueProposed>(v2);
    }

    public fun ready_cash_bps(arg0: &Settings) : u64 {
        arg0.ready_cash_bps
    }

    public(friend) fun ready_short<T0, T1>(arg0: &Market<T0, T1>, arg1: u256) : u64 {
        0xbe9a7d44698458aea5bcf0ebe57b04ca620362644c1572b256ca831896c488c5::math::sat_sub(ready_target<T0, T1>(arg0, arg1), 0x2::balance::value<T1>(&arg0.cash))
    }

    fun ready_target<T0, T1>(arg0: &Market<T0, T1>, arg1: u256) : u64 {
        if (arg0.state == 0) {
            0xbe9a7d44698458aea5bcf0ebe57b04ca620362644c1572b256ca831896c488c5::math::share_up(owed_at<T0, T1>(arg0, arg1), arg0.settings.ready_cash_bps)
        } else {
            0
        }
    }

    public fun redeem<T0, T1>(arg0: &mut Market<T0, T1>, arg1: &0xbe9a7d44698458aea5bcf0ebe57b04ca620362644c1572b256ca831896c488c5::config::Config, arg2: 0x2::coin::Coin<T0>, arg3: u64, arg4: &mut 0x2::tx_context::TxContext) : 0x2::coin::Coin<T1> {
        check<T0, T1>(arg0, arg1);
        assert!(arg0.state == 2, 7);
        let v0 = 0x2::coin::value<T0>(&arg2);
        assert!(v0 > 0, 8);
        let v1 = still_due<T0, T1>(arg0);
        let v2 = if (v1 == 0) {
            0
        } else {
            0xbe9a7d44698458aea5bcf0ebe57b04ca620362644c1572b256ca831896c488c5::math::mul_div_down(0xbe9a7d44698458aea5bcf0ebe57b04ca620362644c1572b256ca831896c488c5::math::mul_div_down(v0, arg0.settle_owed, arg0.settle_supply), 0x1::u64::min(0x2::balance::value<T1>(&arg0.cash), v1), v1)
        };
        assert!(v2 >= arg3, 9);
        0x2::coin::burn<T0>(&mut arg0.treasury, arg2);
        let v3 = Redeemed{
            schema : 0xbe9a7d44698458aea5bcf0ebe57b04ca620362644c1572b256ca831896c488c5::config::schema(),
            market : 0x2::object::id<Market<T0, T1>>(arg0),
            holder : 0x2::tx_context::sender(arg4),
            coins  : v0,
            paid   : v2,
        };
        0x2::event::emit<Redeemed>(v3);
        0x2::coin::take<T1>(&mut arg0.cash, v2, arg4)
    }

    public fun redeemable<T0, T1>(arg0: &Market<T0, T1>, arg1: u64) : u64 {
        if (arg0.state != 2 || arg0.settle_supply == 0) {
            return 0
        };
        let v0 = still_due<T0, T1>(arg0);
        if (v0 == 0) {
            0
        } else {
            0xbe9a7d44698458aea5bcf0ebe57b04ca620362644c1572b256ca831896c488c5::math::mul_div_down(0xbe9a7d44698458aea5bcf0ebe57b04ca620362644c1572b256ca831896c488c5::math::mul_div_down(arg1, arg0.settle_owed, arg0.settle_supply), 0x1::u64::min(0x2::balance::value<T1>(&arg0.cash), v0), v0)
        }
    }

    public fun retain_bps(arg0: &Settings) : u64 {
        arg0.retain_bps
    }

    public fun sale_payout<T0, T1>(arg0: &Market<T0, T1>, arg1: u64, arg2: u256, arg3: u64) : u64 {
        let (v0, v1, _, _) = sale_terms<T0, T1>(arg0, arg1, arg2, arg3);
        v0 - v1
    }

    fun sale_terms<T0, T1>(arg0: &Market<T0, T1>, arg1: u64, arg2: u256, arg3: u64) : (u64, u64, bool, u64) {
        let v0 = owed_at<T0, T1>(arg0, arg2);
        let (v1, v2) = backing_at<T0, T1>(arg0, arg2, arg3);
        let v3 = if (v2) {
            v1
        } else {
            v1 - 0xbe9a7d44698458aea5bcf0ebe57b04ca620362644c1572b256ca831896c488c5::math::share_down(arg0.lent + hedge_now<T0, T1>(arg0, arg2), 200)
        };
        let v4 = v3 < v0;
        let v5 = if (v4) {
            0xbe9a7d44698458aea5bcf0ebe57b04ca620362644c1572b256ca831896c488c5::math::mul_div_down(0xbe9a7d44698458aea5bcf0ebe57b04ca620362644c1572b256ca831896c488c5::math::value_down(arg1, arg2, arg0.decimals, arg0.quote_decimals), v3, v0)
        } else {
            0xbe9a7d44698458aea5bcf0ebe57b04ca620362644c1572b256ca831896c488c5::math::value_down(arg1, arg2, arg0.decimals, arg0.quote_decimals)
        };
        (v5, 0xbe9a7d44698458aea5bcf0ebe57b04ca620362644c1572b256ca831896c488c5::math::share_up(v5, arg0.settings.sell_fee_bps), v4, v1)
    }

    public fun sell<T0, T1>(arg0: &mut Market<T0, T1>, arg1: &0xbe9a7d44698458aea5bcf0ebe57b04ca620362644c1572b256ca831896c488c5::config::Config, arg2: 0x2::coin::Coin<T0>, arg3: u64, arg4: &0x3ec740df8428aa9c93aaef7f8cc1542ac3194fd014826b51bfe245346d64efc7::clearing_house::ClearingHouse<T1>, arg5: &0x9237337d846fc90b0a7acbdee4ab91809298691873d28e1d64d91e6303ff6ba4::price_feed_storage::PriceFeedStorage, arg6: &0x2::clock::Clock, arg7: &mut 0x2::tx_context::TxContext) : 0x2::coin::Coin<T1> {
        check<T0, T1>(arg0, arg1);
        let v0 = 0xbe9a7d44698458aea5bcf0ebe57b04ca620362644c1572b256ca831896c488c5::oracle::feed_price<T1>(arg4, arg5, arg6, arg0.venue, arg0.settings.price_max_age_ms);
        sell_costed<T0, T1>(arg0, arg2, arg3, v0, 0, 0x2::clock::timestamp_ms(arg6), arg7)
    }

    public(friend) fun sell_costed<T0, T1>(arg0: &mut Market<T0, T1>, arg1: 0x2::coin::Coin<T0>, arg2: u64, arg3: u256, arg4: u64, arg5: u64, arg6: &mut 0x2::tx_context::TxContext) : 0x2::coin::Coin<T1> {
        0xbe9a7d44698458aea5bcf0ebe57b04ca620362644c1572b256ca831896c488c5::math::assert_price(arg3);
        assert!(arg0.state == 0, 7);
        let v0 = 0x2::coin::value<T0>(&arg1);
        assert!(v0 > 0, 8);
        let v1 = 0x2::coin::total_supply<T0>(&arg0.treasury);
        let v2 = 0xbe9a7d44698458aea5bcf0ebe57b04ca620362644c1572b256ca831896c488c5::math::value_up(v1, arg3, arg0.decimals, arg0.quote_decimals);
        let (v3, v4, v5, v6) = sale_terms<T0, T1>(arg0, v0, arg3, arg5);
        let v7 = 0xbe9a7d44698458aea5bcf0ebe57b04ca620362644c1572b256ca831896c488c5::math::sat_sub(v3 - v4, arg4);
        assert!(v7 >= arg2, 9);
        assert!(0x2::balance::value<T1>(&arg0.cash) >= v7, 20);
        0x2::coin::burn<T0>(&mut arg0.treasury, arg1);
        let v8 = take_fee<T0, T1>(arg0, v4);
        arg0.totals.sold = arg0.totals.sold + (v3 as u128);
        note_price<T0, T1>(arg0, arg3, arg5);
        let v9 = Sold{
            schema     : 0xbe9a7d44698458aea5bcf0ebe57b04ca620362644c1572b256ca831896c488c5::config::schema(),
            market     : 0x2::object::id<Market<T0, T1>>(arg0),
            seller     : 0x2::tx_context::sender(arg6),
            coins      : v0,
            paid       : v7,
            fee        : v4,
            retained   : v8,
            hedge_cost : arg4,
            price      : arg3,
            pro_rata   : v5,
            supply     : v1 - v0,
            backing    : v6,
            owed       : v2,
        };
        0x2::event::emit<Sold>(v9);
        0x2::coin::take<T1>(&mut arg0.cash, v7, arg6)
    }

    fun set_guard<T0, T1>(arg0: &mut Market<T0, T1>, arg1: bool, arg2: address) {
        arg0.guard_paused = arg1;
        let v0 = GuardChanged{
            schema : 0xbe9a7d44698458aea5bcf0ebe57b04ca620362644c1572b256ca831896c488c5::config::schema(),
            market : 0x2::object::id<Market<T0, T1>>(arg0),
            paused : arg1,
            by     : arg2,
        };
        0x2::event::emit<GuardChanged>(v0);
    }

    public(friend) fun set_hedge_mark<T0, T1>(arg0: &mut Market<T0, T1>, arg1: u64, arg2: u64, arg3: u256, arg4: u64) {
        arg0.hedge_equity = arg1;
        arg0.hedge_base = arg2;
        arg0.mark_price = arg3;
        arg0.mark_ms = arg4;
        note_price<T0, T1>(arg0, arg3, arg4);
        let v0 = HedgeMarked{
            schema       : 0xbe9a7d44698458aea5bcf0ebe57b04ca620362644c1572b256ca831896c488c5::config::schema(),
            market       : 0x2::object::id<Market<T0, T1>>(arg0),
            equity       : arg1,
            base         : arg2,
            price        : arg3,
            timestamp_ms : arg4,
        };
        0x2::event::emit<HedgeMarked>(v0);
    }

    public(friend) fun set_lent_mark<T0, T1>(arg0: &mut Market<T0, T1>, arg1: u64, arg2: u64) {
        arg0.lent = arg1;
        arg0.lent_ms = arg2;
        let v0 = LentMarked{
            schema       : 0xbe9a7d44698458aea5bcf0ebe57b04ca620362644c1572b256ca831896c488c5::config::schema(),
            market       : 0x2::object::id<Market<T0, T1>>(arg0),
            value        : arg1,
            timestamp_ms : arg2,
        };
        0x2::event::emit<LentMarked>(v0);
    }

    public fun set_settings<T0, T1>(arg0: &0xbe9a7d44698458aea5bcf0ebe57b04ca620362644c1572b256ca831896c488c5::config::AdminCap, arg1: &mut Market<T0, T1>, arg2: &0xbe9a7d44698458aea5bcf0ebe57b04ca620362644c1572b256ca831896c488c5::config::Config, arg3: Settings, arg4: &0x2::clock::Clock) {
        check<T0, T1>(arg1, arg2);
        validate(&arg3);
        if (loosens(&arg1.settings, &arg3)) {
            let v0 = 0x2::clock::timestamp_ms(arg4) + 0xbe9a7d44698458aea5bcf0ebe57b04ca620362644c1572b256ca831896c488c5::config::change_delay_ms(arg2);
            let v1 = PendingSettings{
                settings     : arg3,
                effective_ms : v0,
            };
            arg1.pending = 0x1::option::some<PendingSettings>(v1);
            let v2 = SettingsProposed{
                schema       : 0xbe9a7d44698458aea5bcf0ebe57b04ca620362644c1572b256ca831896c488c5::config::schema(),
                market       : 0x2::object::id<Market<T0, T1>>(arg1),
                settings     : arg3,
                effective_ms : v0,
            };
            0x2::event::emit<SettingsProposed>(v2);
        } else {
            arg1.settings = arg3;
            arg1.pending = 0x1::option::none<PendingSettings>();
            let v3 = SettingsChanged{
                schema   : 0xbe9a7d44698458aea5bcf0ebe57b04ca620362644c1572b256ca831896c488c5::config::schema(),
                market   : 0x2::object::id<Market<T0, T1>>(arg1),
                settings : arg3,
            };
            0x2::event::emit<SettingsChanged>(v3);
        };
    }

    public fun settings<T0, T1>(arg0: &Market<T0, T1>) : Settings {
        arg0.settings
    }

    fun settle<T0, T1>(arg0: &mut Market<T0, T1>, arg1: bool) {
        let v0 = 0x2::coin::total_supply<T0>(&arg0.treasury);
        let v1 = 0xbe9a7d44698458aea5bcf0ebe57b04ca620362644c1572b256ca831896c488c5::math::value_down(v0, arg0.last_price, arg0.decimals, arg0.quote_decimals);
        arg0.settle_supply = v0;
        arg0.settle_owed = v1;
        arg0.state = 2;
        let v2 = Settled{
            schema : 0xbe9a7d44698458aea5bcf0ebe57b04ca620362644c1572b256ca831896c488c5::config::schema(),
            market : 0x2::object::id<Market<T0, T1>>(arg0),
            owed   : v1,
            cash   : 0x2::balance::value<T1>(&arg0.cash),
            supply : v0,
            forced : arg1,
        };
        0x2::event::emit<Settled>(v2);
    }

    fun settled_buffer<T0, T1>(arg0: &Market<T0, T1>) : u64 {
        0xbe9a7d44698458aea5bcf0ebe57b04ca620362644c1572b256ca831896c488c5::math::sat_sub(0x2::balance::value<T1>(&arg0.cash), still_due<T0, T1>(arg0) + arg0.fees_accrued)
    }

    public fun settlement<T0, T1>(arg0: &Market<T0, T1>) : (u64, u64) {
        (arg0.settle_owed, arg0.settle_supply)
    }

    public(friend) fun spare_cash<T0, T1>(arg0: &Market<T0, T1>, arg1: u256) : u64 {
        0xbe9a7d44698458aea5bcf0ebe57b04ca620362644c1572b256ca831896c488c5::math::sat_sub(0x2::balance::value<T1>(&arg0.cash), ready_target<T0, T1>(arg0, arg1))
    }

    public fun state<T0, T1>(arg0: &Market<T0, T1>) : u8 {
        arg0.state
    }

    public fun status<T0, T1>(arg0: &Market<T0, T1>, arg1: &0xbe9a7d44698458aea5bcf0ebe57b04ca620362644c1572b256ca831896c488c5::config::Config, arg2: &0x3ec740df8428aa9c93aaef7f8cc1542ac3194fd014826b51bfe245346d64efc7::clearing_house::ClearingHouse<T1>, arg3: &0x9237337d846fc90b0a7acbdee4ab91809298691873d28e1d64d91e6303ff6ba4::price_feed_storage::PriceFeedStorage, arg4: &0x2::clock::Clock) : (u256, u64, u64, bool, u64, u64) {
        check<T0, T1>(arg0, arg1);
        let v0 = 0xbe9a7d44698458aea5bcf0ebe57b04ca620362644c1572b256ca831896c488c5::oracle::price<T1>(arg2, arg3, arg4, arg0.venue, arg0.settings.price_max_age_ms);
        let v1 = 0xbe9a7d44698458aea5bcf0ebe57b04ca620362644c1572b256ca831896c488c5::oracle::long_funding_bps<T1>(arg2, v0 * 0xbe9a7d44698458aea5bcf0ebe57b04ca620362644c1572b256ca831896c488c5::math::price_scale());
        let (v2, v3) = backing_at<T0, T1>(arg0, v0, 0x2::clock::timestamp_ms(arg4));
        (v0, v2, owed_at<T0, T1>(arg0, v0), v3, buy_gate<T0, T1>(arg0, arg1, v1), v1)
    }

    fun still_due<T0, T1>(arg0: &Market<T0, T1>) : u64 {
        if (arg0.settle_supply == 0) {
            0
        } else {
            0xbe9a7d44698458aea5bcf0ebe57b04ca620362644c1572b256ca831896c488c5::math::mul_div_down(0x2::coin::total_supply<T0>(&arg0.treasury), arg0.settle_owed, arg0.settle_supply)
        }
    }

    public fun supply<T0, T1>(arg0: &Market<T0, T1>) : u64 {
        0x2::coin::total_supply<T0>(&arg0.treasury)
    }

    public fun surplus_at<T0, T1>(arg0: &Market<T0, T1>, arg1: u256, arg2: u64) : u64 {
        if (arg0.state != 0) {
            return 0
        };
        let (v0, v1) = backing_at<T0, T1>(arg0, arg1, arg2);
        if (!v1) {
            return 0
        };
        let v2 = owed_at<T0, T1>(arg0, arg1);
        0x1::u64::min(0xbe9a7d44698458aea5bcf0ebe57b04ca620362644c1572b256ca831896c488c5::math::sat_sub(v0, 0xbe9a7d44698458aea5bcf0ebe57b04ca620362644c1572b256ca831896c488c5::math::share_up(v2, arg0.settings.target_backing_bps)), 0xbe9a7d44698458aea5bcf0ebe57b04ca620362644c1572b256ca831896c488c5::math::sat_sub(0x2::balance::value<T1>(&arg0.cash), 0xbe9a7d44698458aea5bcf0ebe57b04ca620362644c1572b256ca831896c488c5::math::share_up(v2, arg0.settings.ready_cash_bps)))
    }

    public(friend) fun take_account<T0, T1>(arg0: &mut Market<T0, T1>) : 0xbe9a7d44698458aea5bcf0ebe57b04ca620362644c1572b256ca831896c488c5::custody::Vault<T1> {
        0x1::option::extract<0xbe9a7d44698458aea5bcf0ebe57b04ca620362644c1572b256ca831896c488c5::custody::Vault<T1>>(&mut arg0.account)
    }

    fun take_fee<T0, T1>(arg0: &mut Market<T0, T1>, arg1: u64) : u64 {
        let v0 = 0xbe9a7d44698458aea5bcf0ebe57b04ca620362644c1572b256ca831896c488c5::math::share_up(arg1, arg0.settings.retain_bps);
        arg0.fees_accrued = arg0.fees_accrued + arg1 - v0;
        arg0.totals.fees_total = arg0.totals.fees_total + (arg1 as u128);
        arg0.totals.retained_total = arg0.totals.retained_total + (v0 as u128);
        v0
    }

    public fun totals<T0, T1>(arg0: &Market<T0, T1>) : (u128, u128, u128, u128, u128, u128) {
        let v0 = &arg0.totals;
        (v0.bought, v0.sold, v0.fees_total, v0.retained_total, v0.treasury_in, v0.treasury_out)
    }

    public fun touch<T0, T1>(arg0: &mut Market<T0, T1>, arg1: &0xbe9a7d44698458aea5bcf0ebe57b04ca620362644c1572b256ca831896c488c5::config::Config, arg2: &0x3ec740df8428aa9c93aaef7f8cc1542ac3194fd014826b51bfe245346d64efc7::clearing_house::ClearingHouse<T1>, arg3: &0x9237337d846fc90b0a7acbdee4ab91809298691873d28e1d64d91e6303ff6ba4::price_feed_storage::PriceFeedStorage, arg4: &0x2::clock::Clock) {
        check<T0, T1>(arg0, arg1);
        assert!(arg0.state == 0, 7);
        let v0 = 0xbe9a7d44698458aea5bcf0ebe57b04ca620362644c1572b256ca831896c488c5::oracle::price<T1>(arg2, arg3, arg4, arg0.venue, arg0.settings.price_max_age_ms);
        note_price<T0, T1>(arg0, v0, 0x2::clock::timestamp_ms(arg4));
    }

    public fun trade_slippage_bps(arg0: &Settings) : u64 {
        arg0.trade_slippage_bps
    }

    public(friend) fun uid<T0, T1>(arg0: &Market<T0, T1>) : &0x2::object::UID {
        &arg0.id
    }

    public(friend) fun uid_mut<T0, T1>(arg0: &mut Market<T0, T1>) : &mut 0x2::object::UID {
        &mut arg0.id
    }

    public fun unback<T0, T1>(arg0: &mut Market<T0, T1>, arg1: &0xbe9a7d44698458aea5bcf0ebe57b04ca620362644c1572b256ca831896c488c5::config::Config, arg2: Backer, arg3: u64, arg4: &0x3ec740df8428aa9c93aaef7f8cc1542ac3194fd014826b51bfe245346d64efc7::clearing_house::ClearingHouse<T1>, arg5: &0x9237337d846fc90b0a7acbdee4ab91809298691873d28e1d64d91e6303ff6ba4::price_feed_storage::PriceFeedStorage, arg6: &0x2::clock::Clock, arg7: &mut 0x2::tx_context::TxContext) : 0x2::coin::Coin<T1> {
        check<T0, T1>(arg0, arg1);
        let v0 = if (arg0.state == 0) {
            0xbe9a7d44698458aea5bcf0ebe57b04ca620362644c1572b256ca831896c488c5::oracle::feed_price<T1>(arg4, arg5, arg6, arg0.venue, arg0.settings.price_max_age_ms)
        } else {
            arg0.last_price
        };
        unback_at<T0, T1>(arg0, arg2, arg3, v0, 0x2::clock::timestamp_ms(arg6), arg7)
    }

    public(friend) fun unback_at<T0, T1>(arg0: &mut Market<T0, T1>, arg1: Backer, arg2: u64, arg3: u256, arg4: u64, arg5: &mut 0x2::tx_context::TxContext) : 0x2::coin::Coin<T1> {
        assert!(arg1.market == 0x2::object::id<Market<T0, T1>>(arg0), 26);
        assert!(arg0.state != 1, 7);
        let Backer {
            id              : v0,
            market          : _,
            shares          : v2,
            open_ms         : v3,
            close_ms        : v4,
            worth_at_notice : v5,
        } = arg1;
        let v6 = v0;
        let (v7, v8) = if (arg0.state == 2) {
            let v9 = settled_buffer<T0, T1>(arg0);
            (v9, worth(v2, arg0.shares, v9))
        } else {
            let v10 = if (v3 != 0) {
                if (arg4 >= v3) {
                    arg4 <= v4
                } else {
                    false
                }
            } else {
                false
            };
            assert!(v10, 25);
            assert!(!marks_stale<T0, T1>(arg0, arg4), 15);
            let v11 = buffer_at<T0, T1>(arg0, arg3, arg4);
            (v11, 0x1::u64::min(worth(v2, arg0.shares, v11), v5))
        };
        assert!(v8 >= arg2, 9);
        if (arg0.state == 0 && v8 > 0) {
            let v12 = owed_at<T0, T1>(arg0, arg3);
            let (v13, _) = backing_at<T0, T1>(arg0, arg3, arg4);
            assert!(0xbe9a7d44698458aea5bcf0ebe57b04ca620362644c1572b256ca831896c488c5::math::covers(v13 - v8, v12, arg0.settings.min_backing_bps), 14);
            assert!(v8 <= 0xbe9a7d44698458aea5bcf0ebe57b04ca620362644c1572b256ca831896c488c5::math::sat_sub(0x2::balance::value<T1>(&arg0.cash), 0xbe9a7d44698458aea5bcf0ebe57b04ca620362644c1572b256ca831896c488c5::math::share_up(v12, arg0.settings.ready_cash_bps)), 20);
        };
        arg0.shares = arg0.shares - v2;
        arg0.totals.treasury_out = arg0.totals.treasury_out + (v8 as u128);
        let v15 = Unbacked{
            schema       : 0xbe9a7d44698458aea5bcf0ebe57b04ca620362644c1572b256ca831896c488c5::config::schema(),
            market       : 0x2::object::id<Market<T0, T1>>(arg0),
            backer       : 0x2::object::uid_to_inner(&v6),
            by           : 0x2::tx_context::sender(arg5),
            amount       : v8,
            shares       : v2,
            total_shares : arg0.shares,
            buffer       : v7 - v8,
        };
        0x2::event::emit<Unbacked>(v15);
        0x2::object::delete(v6);
        0x2::coin::take<T1>(&mut arg0.cash, v8, arg5)
    }

    public fun unhedged(arg0: &Settings) : (u64, u64, u64) {
        (arg0.unhedged_bps, arg0.unhedged_floor, arg0.unhedged_max)
    }

    fun unhedged_allowance(arg0: &Settings, arg1: u64) : u64 {
        0x1::u64::max(arg0.unhedged_floor, 0x1::u64::min(0xbe9a7d44698458aea5bcf0ebe57b04ca620362644c1572b256ca831896c488c5::math::share_down(arg1, arg0.unhedged_bps), arg0.unhedged_max))
    }

    public fun validate(arg0: &Settings) {
        assert!(arg0.buy_fee_bps <= 200 && arg0.sell_fee_bps <= 200, 2);
        let v0 = if (arg0.min_backing_bps >= 10000) {
            if (arg0.target_backing_bps >= arg0.min_backing_bps) {
                arg0.target_backing_bps <= 20000
            } else {
                false
            }
        } else {
            false
        };
        assert!(v0, 2);
        let v1 = if (arg0.ready_cash_bps >= 500) {
            if (arg0.margin_bps >= 1000) {
                arg0.margin_bps <= 0xbe9a7d44698458aea5bcf0ebe57b04ca620362644c1572b256ca831896c488c5::math::bps()
            } else {
                false
            }
        } else {
            false
        };
        assert!(v1, 2);
        assert!(arg0.lend_bps <= 7000 && arg0.ready_cash_bps + arg0.margin_bps + arg0.lend_bps <= 0xbe9a7d44698458aea5bcf0ebe57b04ca620362644c1572b256ca831896c488c5::math::bps(), 2);
        assert!(arg0.unhedged_bps <= 1000 && arg0.unhedged_floor <= arg0.unhedged_max, 2);
        assert!(arg0.hedge_tolerance_bps <= 500 && arg0.hedge_step > 0, 2);
        assert!(arg0.hedge_slippage_bps > 0 && arg0.hedge_slippage_bps <= 200, 2);
        assert!(2 * arg0.hedge_slippage_bps <= arg0.buy_fee_bps + arg0.sell_fee_bps, 2);
        assert!(arg0.trade_slippage_bps > 0 && arg0.trade_slippage_bps <= 500, 2);
        let v2 = if (arg0.mark_max_age_ms >= 60000) {
            if (arg0.mark_max_age_ms <= 3600000) {
                arg0.price_max_age_ms <= 60000
            } else {
                false
            }
        } else {
            false
        };
        assert!(v2, 2);
        assert!(arg0.retain_bps <= 0xbe9a7d44698458aea5bcf0ebe57b04ca620362644c1572b256ca831896c488c5::math::bps(), 2);
        assert!(arg0.backer_notice_ms >= 3600000 && arg0.backer_notice_ms <= 2592000000, 2);
    }

    public fun venue<T0, T1>(arg0: &Market<T0, T1>) : 0x2::object::ID {
        arg0.venue
    }

    public fun withdraw_settled_surplus<T0, T1>(arg0: &0xbe9a7d44698458aea5bcf0ebe57b04ca620362644c1572b256ca831896c488c5::config::AdminCap, arg1: &mut Market<T0, T1>, arg2: &0xbe9a7d44698458aea5bcf0ebe57b04ca620362644c1572b256ca831896c488c5::config::Config, arg3: u64, arg4: &mut 0x2::tx_context::TxContext) {
        check<T0, T1>(arg1, arg2);
        assert!(arg1.state == 2, 7);
        let v0 = arg1.last_price;
        let v1 = arg1.last_price_ms;
        let v2 = 0x1::u64::min(arg3, arg1.fees_accrued);
        if (arg1.shares > 0 && arg3 > v2) {
            let v3 = settled_buffer<T0, T1>(arg1);
            burn_protocol_shares<T0, T1>(arg1, arg3 - v2, v3);
        };
        pay_out_at<T0, T1>(arg1, arg2, arg3, v2, v0, v1, arg4);
    }

    public fun withdraw_settlement_notice<T0, T1>(arg0: &0xbe9a7d44698458aea5bcf0ebe57b04ca620362644c1572b256ca831896c488c5::config::AdminCap, arg1: &mut Market<T0, T1>, arg2: &0xbe9a7d44698458aea5bcf0ebe57b04ca620362644c1572b256ca831896c488c5::config::Config) {
        check<T0, T1>(arg1, arg2);
        assert!(arg1.state == 0, 7);
        arg1.settle_notice_ms = 0;
        let v0 = SettlementNoticed{
            schema : 0xbe9a7d44698458aea5bcf0ebe57b04ca620362644c1572b256ca831896c488c5::config::schema(),
            market : 0x2::object::id<Market<T0, T1>>(arg1),
            at_ms  : 0,
        };
        0x2::event::emit<SettlementNoticed>(v0);
    }

    public fun withdraw_surplus<T0, T1>(arg0: &0xbe9a7d44698458aea5bcf0ebe57b04ca620362644c1572b256ca831896c488c5::config::AdminCap, arg1: &mut Market<T0, T1>, arg2: &0xbe9a7d44698458aea5bcf0ebe57b04ca620362644c1572b256ca831896c488c5::config::Config, arg3: u64, arg4: &0x3ec740df8428aa9c93aaef7f8cc1542ac3194fd014826b51bfe245346d64efc7::clearing_house::ClearingHouse<T1>, arg5: &0x9237337d846fc90b0a7acbdee4ab91809298691873d28e1d64d91e6303ff6ba4::price_feed_storage::PriceFeedStorage, arg6: &0x2::clock::Clock, arg7: &mut 0x2::tx_context::TxContext) {
        check<T0, T1>(arg1, arg2);
        let v0 = 0xbe9a7d44698458aea5bcf0ebe57b04ca620362644c1572b256ca831896c488c5::oracle::feed_price<T1>(arg4, arg5, arg6, arg1.venue, arg1.settings.price_max_age_ms);
        withdraw_surplus_at<T0, T1>(arg1, arg2, arg3, v0, 0x2::clock::timestamp_ms(arg6), arg7);
    }

    public(friend) fun withdraw_surplus_at<T0, T1>(arg0: &mut Market<T0, T1>, arg1: &0xbe9a7d44698458aea5bcf0ebe57b04ca620362644c1572b256ca831896c488c5::config::Config, arg2: u64, arg3: u256, arg4: u64, arg5: &mut 0x2::tx_context::TxContext) {
        if (arg0.shares > 0) {
            let v0 = buffer_at<T0, T1>(arg0, arg3, arg4);
            burn_protocol_shares<T0, T1>(arg0, arg2, v0);
        };
        pay_out_at<T0, T1>(arg0, arg1, arg2, 0, arg3, arg4, arg5);
    }

    fun worth(arg0: u128, arg1: u128, arg2: u64) : u64 {
        let v0 = (arg0 as u256) * ((arg2 as u256) + 1) / ((arg1 as u256) + 1000000);
        if (v0 > (arg2 as u256)) {
            arg2
        } else {
            (v0 as u64)
        }
    }

    // decompiled from Move bytecode v7
}

