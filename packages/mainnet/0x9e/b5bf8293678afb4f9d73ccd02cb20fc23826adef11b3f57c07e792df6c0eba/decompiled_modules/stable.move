module 0xbe9a7d44698458aea5bcf0ebe57b04ca620362644c1572b256ca831896c488c5::stable {
    struct HoldKey has copy, drop, store {
        dummy_field: bool,
    }

    struct SleeveKey has copy, drop, store {
        dummy_field: bool,
    }

    struct HoldSettings has copy, drop, store {
        parking: bool,
        lending: bool,
        swap_slippage_bps: u64,
        rate_window_ms: u64,
        max_move_bps: u64,
    }

    struct Hold<phantom T0> has store {
        pool: 0x2::object::ID,
        held: 0x2::balance::Balance<T0>,
        lent: u64,
        rate: u64,
        read: u64,
        read_ms: u64,
        fresh_ms: u64,
        in_flight: u64,
        out_units: u64,
        cost_from_ms: u64,
        cost_used: u64,
        cost_base: u64,
        settings: HoldSettings,
        pending: 0x1::option::Option<PendingHold>,
        totals: HoldTotals,
    }

    struct PendingHold has copy, drop, store {
        settings: HoldSettings,
        pool: 0x2::object::ID,
        effective_ms: u64,
    }

    struct HoldTotals has copy, drop, store {
        parked: u128,
        unparked: u128,
        swap_cost: u128,
        paid_in_kind: u128,
        receipts_paid: u128,
        gifts: u128,
    }

    struct ParkTicket {
        market: 0x2::object::ID,
        amount: u64,
    }

    struct UnparkTicket {
        market: 0x2::object::ID,
        amount: u64,
        rate: u64,
    }

    struct HoldEnabled has copy, drop {
        schema: u8,
        market: 0x2::object::ID,
        pool: 0x2::object::ID,
        rate: u64,
        settings: HoldSettings,
    }

    struct HoldMarked has copy, drop {
        schema: u8,
        market: 0x2::object::ID,
        held: u64,
        lent: u64,
        rate: u64,
        read: u64,
        value: u64,
        par: u64,
        timestamp_ms: u64,
    }

    struct Swapped has copy, drop {
        schema: u8,
        market: 0x2::object::ID,
        park: bool,
        amount: u64,
        got: u64,
        cost: u64,
    }

    struct PaidInKind has copy, drop {
        schema: u8,
        market: 0x2::object::ID,
        seller: address,
        units: u64,
        receipts: u64,
        receipts_worth: u64,
    }

    struct HoldGift has copy, drop {
        schema: u8,
        market: 0x2::object::ID,
        by: address,
        units: u64,
        value: u64,
    }

    struct HoldLent has copy, drop {
        schema: u8,
        market: 0x2::object::ID,
        out: bool,
        amount: u64,
        lent: u64,
    }

    struct HoldSettingsProposed has copy, drop {
        schema: u8,
        market: 0x2::object::ID,
        settings: HoldSettings,
        pool: 0x2::object::ID,
        effective_ms: u64,
    }

    struct HoldSettingsChanged has copy, drop {
        schema: u8,
        market: 0x2::object::ID,
        settings: HoldSettings,
        pool: 0x2::object::ID,
    }

    public fun allowance_used<T0, T1, T2>(arg0: &0xbe9a7d44698458aea5bcf0ebe57b04ca620362644c1572b256ca831896c488c5::market::Market<T0, T1>) : (u64, u64) {
        let v0 = hold<T0, T1, T2>(arg0);
        (v0.cost_used, v0.cost_from_ms)
    }

    public fun apply_settings<T0, T1, T2>(arg0: &mut 0xbe9a7d44698458aea5bcf0ebe57b04ca620362644c1572b256ca831896c488c5::market::Market<T0, T1>, arg1: &0xbe9a7d44698458aea5bcf0ebe57b04ca620362644c1572b256ca831896c488c5::config::Config, arg2: &0x2::clock::Clock) {
        0xbe9a7d44698458aea5bcf0ebe57b04ca620362644c1572b256ca831896c488c5::market::assert_config<T0, T1>(arg0, arg1);
        let v0 = 0x2::object::id<0xbe9a7d44698458aea5bcf0ebe57b04ca620362644c1572b256ca831896c488c5::market::Market<T0, T1>>(arg0);
        let v1 = hold_mut<T0, T1, T2>(arg0);
        assert!(0x1::option::is_some<PendingHold>(&v1.pending), 515);
        let PendingHold {
            settings     : v2,
            pool         : v3,
            effective_ms : v4,
        } = 0x1::option::extract<PendingHold>(&mut v1.pending);
        assert!(0x2::clock::timestamp_ms(arg2) >= v4, 516);
        v1.settings = v2;
        v1.pool = v3;
        let v5 = HoldSettingsChanged{
            schema   : 0xbe9a7d44698458aea5bcf0ebe57b04ca620362644c1572b256ca831896c488c5::config::schema(),
            market   : v0,
            settings : v2,
            pool     : v3,
        };
        0x2::event::emit<HoldSettingsChanged>(v5);
    }

    public fun cancel_settings<T0, T1, T2>(arg0: &0xbe9a7d44698458aea5bcf0ebe57b04ca620362644c1572b256ca831896c488c5::config::AdminCap, arg1: &mut 0xbe9a7d44698458aea5bcf0ebe57b04ca620362644c1572b256ca831896c488c5::market::Market<T0, T1>, arg2: &0xbe9a7d44698458aea5bcf0ebe57b04ca620362644c1572b256ca831896c488c5::config::Config) {
        0xbe9a7d44698458aea5bcf0ebe57b04ca620362644c1572b256ca831896c488c5::market::assert_config<T0, T1>(arg1, arg2);
        let v0 = hold_mut<T0, T1, T2>(arg1);
        assert!(0x1::option::is_some<PendingHold>(&v0.pending), 515);
        v0.pending = 0x1::option::none<PendingHold>();
    }

    public fun enable<T0, T1, T2>(arg0: &0xbe9a7d44698458aea5bcf0ebe57b04ca620362644c1572b256ca831896c488c5::config::AdminCap, arg1: &mut 0xbe9a7d44698458aea5bcf0ebe57b04ca620362644c1572b256ca831896c488c5::market::Market<T0, T1>, arg2: &0xbe9a7d44698458aea5bcf0ebe57b04ca620362644c1572b256ca831896c488c5::config::Config, arg3: &0x2c8d603bc51326b8c13cef9dd07031a408a48dddb541963357661df5d3204809::pool::Pool<T2, T1>, arg4: u8, arg5: u64, arg6: u64, arg7: u64, arg8: &0x2::clock::Clock) {
        let (_, _, v2) = 0x2c8d603bc51326b8c13cef9dd07031a408a48dddb541963357661df5d3204809::pool::pool_book_params<T2, T1>(arg3);
        enable_at<T0, T1, T2>(arg1, arg2, 0x2::object::id<0x2c8d603bc51326b8c13cef9dd07031a408a48dddb541963357661df5d3204809::pool::Pool<T2, T1>>(arg3), arg4, arg5, arg6, arg7, read_rate<T2, T1>(arg3, v2, arg8), 0x2::clock::timestamp_ms(arg8));
    }

    public(friend) fun enable_at<T0, T1, T2>(arg0: &mut 0xbe9a7d44698458aea5bcf0ebe57b04ca620362644c1572b256ca831896c488c5::market::Market<T0, T1>, arg1: &0xbe9a7d44698458aea5bcf0ebe57b04ca620362644c1572b256ca831896c488c5::config::Config, arg2: 0x2::object::ID, arg3: u8, arg4: u64, arg5: u64, arg6: u64, arg7: 0x1::option::Option<u64>, arg8: u64) {
        0xbe9a7d44698458aea5bcf0ebe57b04ca620362644c1572b256ca831896c488c5::market::assert_config<T0, T1>(arg0, arg1);
        assert!(0xbe9a7d44698458aea5bcf0ebe57b04ca620362644c1572b256ca831896c488c5::market::state<T0, T1>(arg0) == 0, 517);
        let v0 = HoldKey{dummy_field: false};
        assert!(!0x2::dynamic_field::exists<HoldKey>(0xbe9a7d44698458aea5bcf0ebe57b04ca620362644c1572b256ca831896c488c5::market::uid<T0, T1>(arg0), v0), 501);
        let (_, v2) = 0xbe9a7d44698458aea5bcf0ebe57b04ca620362644c1572b256ca831896c488c5::market::decimals<T0, T1>(arg0);
        assert!(arg3 == v2, 504);
        let v3 = new_settings(false, false, arg4, arg5, arg6);
        validate<T0, T1>(arg0, &v3);
        assert!(0x1::option::is_some<u64>(&arg7), 503);
        let v4 = 0x1::option::destroy_some<u64>(arg7);
        let v5 = HoldTotals{
            parked        : 0,
            unparked      : 0,
            swap_cost     : 0,
            paid_in_kind  : 0,
            receipts_paid : 0,
            gifts         : 0,
        };
        let v6 = Hold<T2>{
            pool         : arg2,
            held         : 0x2::balance::zero<T2>(),
            lent         : 0,
            rate         : v4,
            read         : v4,
            read_ms      : arg8,
            fresh_ms     : arg8,
            in_flight    : 0,
            out_units    : 0,
            cost_from_ms : arg8,
            cost_used    : 0,
            cost_base    : 0,
            settings     : v3,
            pending      : 0x1::option::none<PendingHold>(),
            totals       : v5,
        };
        let v7 = HoldKey{dummy_field: false};
        0x2::dynamic_field::add<HoldKey, Hold<T2>>(0xbe9a7d44698458aea5bcf0ebe57b04ca620362644c1572b256ca831896c488c5::market::uid_mut<T0, T1>(arg0), v7, v6);
        0xbe9a7d44698458aea5bcf0ebe57b04ca620362644c1572b256ca831896c488c5::market::set_parked_mark<T0, T1>(arg0, 0, 0, arg8);
        let v8 = HoldEnabled{
            schema   : 0xbe9a7d44698458aea5bcf0ebe57b04ca620362644c1572b256ca831896c488c5::config::schema(),
            market   : 0x2::object::id<0xbe9a7d44698458aea5bcf0ebe57b04ca620362644c1572b256ca831896c488c5::market::Market<T0, T1>>(arg0),
            pool     : arg2,
            rate     : v4,
            settings : v3,
        };
        0x2::event::emit<HoldEnabled>(v8);
    }

    public fun finish_park<T0, T1, T2>(arg0: &mut 0xbe9a7d44698458aea5bcf0ebe57b04ca620362644c1572b256ca831896c488c5::market::Market<T0, T1>, arg1: &0xbe9a7d44698458aea5bcf0ebe57b04ca620362644c1572b256ca831896c488c5::config::Config, arg2: ParkTicket, arg3: 0x2::coin::Coin<T2>, arg4: 0x2::coin::Coin<T1>, arg5: &0x2c8d603bc51326b8c13cef9dd07031a408a48dddb541963357661df5d3204809::pool::Pool<T2, T1>, arg6: &0x2::clock::Clock) : u64 {
        let v0 = hold<T0, T1, T2>(arg0);
        assert!(v0.pool == 0x2::object::id<0x2c8d603bc51326b8c13cef9dd07031a408a48dddb541963357661df5d3204809::pool::Pool<T2, T1>>(arg5), 502);
        finish_park_at<T0, T1, T2>(arg0, arg1, arg2, arg3, arg4, read_rate<T2, T1>(arg5, units_out<T2>(v0) + 0x2::coin::value<T2>(&arg3), arg6), 0x2::clock::timestamp_ms(arg6))
    }

    public(friend) fun finish_park_at<T0, T1, T2>(arg0: &mut 0xbe9a7d44698458aea5bcf0ebe57b04ca620362644c1572b256ca831896c488c5::market::Market<T0, T1>, arg1: &0xbe9a7d44698458aea5bcf0ebe57b04ca620362644c1572b256ca831896c488c5::config::Config, arg2: ParkTicket, arg3: 0x2::coin::Coin<T2>, arg4: 0x2::coin::Coin<T1>, arg5: 0x1::option::Option<u64>, arg6: u64) : u64 {
        0xbe9a7d44698458aea5bcf0ebe57b04ca620362644c1572b256ca831896c488c5::market::assert_config<T0, T1>(arg0, arg1);
        let ParkTicket {
            market : v0,
            amount : v1,
        } = arg2;
        assert!(v0 == 0x2::object::id<0xbe9a7d44698458aea5bcf0ebe57b04ca620362644c1572b256ca831896c488c5::market::Market<T0, T1>>(arg0), 512);
        let v2 = 0x2::coin::value<T1>(&arg4);
        assert!(v2 <= v1, 507);
        if (v2 > 0) {
            0xbe9a7d44698458aea5bcf0ebe57b04ca620362644c1572b256ca831896c488c5::market::cash_in<T0, T1>(arg0, arg4, 3);
        } else {
            0x2::coin::destroy_zero<T1>(arg4);
        };
        let v3 = v1 - v2;
        let v4 = 0x2::coin::value<T2>(&arg3);
        assert!(0x1::option::is_some<u64>(&arg5), 503);
        let v5 = 0x1::option::destroy_some<u64>(arg5);
        let v6 = 0xbe9a7d44698458aea5bcf0ebe57b04ca620362644c1572b256ca831896c488c5::market::state<T0, T1>(arg0) == 0;
        let v7 = hold_mut<T0, T1, T2>(arg0);
        let v8 = v7.settings.swap_slippage_bps;
        assert!(v4 >= v3 - 0xbe9a7d44698458aea5bcf0ebe57b04ca620362644c1572b256ca831896c488c5::math::share_down(v3, v8), 507);
        assert!((v5 as u128) >= 1000000000 - 1000000000 * (v8 as u128) / 10000, 508);
        0x2::balance::join<T2>(&mut v7.held, 0x2::coin::into_balance<T2>(arg3));
        v7.in_flight = 0;
        observe<T2>(v7, v5, arg6);
        v7.fresh_ms = arg6;
        let v9 = 0xbe9a7d44698458aea5bcf0ebe57b04ca620362644c1572b256ca831896c488c5::math::sat_sub(v3, worth(v4, v7.rate));
        spend<T2>(v7, v9, v3, arg6, v6);
        v7.totals.parked = v7.totals.parked + (v3 as u128);
        let v10 = Swapped{
            schema : 0xbe9a7d44698458aea5bcf0ebe57b04ca620362644c1572b256ca831896c488c5::config::schema(),
            market : v0,
            park   : true,
            amount : v3,
            got    : v4,
            cost   : v9,
        };
        0x2::event::emit<Swapped>(v10);
        store<T0, T1, T2>(arg0)
    }

    public fun finish_unpark<T0, T1, T2>(arg0: &mut 0xbe9a7d44698458aea5bcf0ebe57b04ca620362644c1572b256ca831896c488c5::market::Market<T0, T1>, arg1: &0xbe9a7d44698458aea5bcf0ebe57b04ca620362644c1572b256ca831896c488c5::config::Config, arg2: UnparkTicket, arg3: 0x2::coin::Coin<T1>, arg4: 0x2::coin::Coin<T2>, arg5: &0x2::clock::Clock) {
        0xbe9a7d44698458aea5bcf0ebe57b04ca620362644c1572b256ca831896c488c5::market::assert_config<T0, T1>(arg0, arg1);
        let UnparkTicket {
            market : v0,
            amount : v1,
            rate   : v2,
        } = arg2;
        assert!(v0 == 0x2::object::id<0xbe9a7d44698458aea5bcf0ebe57b04ca620362644c1572b256ca831896c488c5::market::Market<T0, T1>>(arg0), 512);
        let v3 = 0x2::coin::value<T2>(&arg4);
        assert!(v3 <= v1, 507);
        let v4 = v1 - v3;
        let v5 = 0x2::coin::value<T1>(&arg3);
        let v6 = 0xbe9a7d44698458aea5bcf0ebe57b04ca620362644c1572b256ca831896c488c5::market::state<T0, T1>(arg0) == 0;
        let v7 = hold_mut<T0, T1, T2>(arg0);
        let v8 = worth(v4, v2);
        assert!(v5 >= v8 - 0xbe9a7d44698458aea5bcf0ebe57b04ca620362644c1572b256ca831896c488c5::math::share_down(v8, v7.settings.swap_slippage_bps), 507);
        let v9 = 0xbe9a7d44698458aea5bcf0ebe57b04ca620362644c1572b256ca831896c488c5::math::sat_sub(worth(v4, v7.rate), v5);
        spend<T2>(v7, v9, v4, 0x2::clock::timestamp_ms(arg5), v6);
        0x2::balance::join<T2>(&mut v7.held, 0x2::coin::into_balance<T2>(arg4));
        v7.out_units = 0;
        v7.totals.unparked = v7.totals.unparked + (v4 as u128);
        0xbe9a7d44698458aea5bcf0ebe57b04ca620362644c1572b256ca831896c488c5::market::cash_in<T0, T1>(arg0, arg3, 3);
        store<T0, T1, T2>(arg0);
        let v10 = Swapped{
            schema : 0xbe9a7d44698458aea5bcf0ebe57b04ca620362644c1572b256ca831896c488c5::config::schema(),
            market : v0,
            park   : false,
            amount : v4,
            got    : v5,
            cost   : v9,
        };
        0x2::event::emit<Swapped>(v10);
    }

    public fun fund<T0, T1, T2>(arg0: &mut 0xbe9a7d44698458aea5bcf0ebe57b04ca620362644c1572b256ca831896c488c5::market::Market<T0, T1>, arg1: &0xbe9a7d44698458aea5bcf0ebe57b04ca620362644c1572b256ca831896c488c5::config::Config, arg2: 0x2::coin::Coin<T2>, arg3: &0x2::tx_context::TxContext) {
        0xbe9a7d44698458aea5bcf0ebe57b04ca620362644c1572b256ca831896c488c5::market::assert_config<T0, T1>(arg0, arg1);
        assert!(0xbe9a7d44698458aea5bcf0ebe57b04ca620362644c1572b256ca831896c488c5::market::state<T0, T1>(arg0) == 0, 517);
        let v0 = 0x2::coin::value<T2>(&arg2);
        assert!(v0 > 0, 514);
        let v1 = 0x2::object::id<0xbe9a7d44698458aea5bcf0ebe57b04ca620362644c1572b256ca831896c488c5::market::Market<T0, T1>>(arg0);
        let v2 = hold_mut<T0, T1, T2>(arg0);
        0x2::balance::join<T2>(&mut v2.held, 0x2::coin::into_balance<T2>(arg2));
        v2.totals.gifts = v2.totals.gifts + (v0 as u128);
        let v3 = worth(v0, v2.rate);
        store<T0, T1, T2>(arg0);
        0xbe9a7d44698458aea5bcf0ebe57b04ca620362644c1572b256ca831896c488c5::market::note_gift<T0, T1>(arg0, v3, arg3);
        let v4 = HoldGift{
            schema : 0xbe9a7d44698458aea5bcf0ebe57b04ca620362644c1572b256ca831896c488c5::config::schema(),
            market : v1,
            by     : 0x2::tx_context::sender(arg3),
            units  : v0,
            value  : v3,
        };
        0x2::event::emit<HoldGift>(v4);
    }

    public fun has<T0, T1, T2>(arg0: &0xbe9a7d44698458aea5bcf0ebe57b04ca620362644c1572b256ca831896c488c5::market::Market<T0, T1>) : bool {
        has_hold<T0, T1, T2>(arg0)
    }

    fun has_hold<T0, T1, T2>(arg0: &0xbe9a7d44698458aea5bcf0ebe57b04ca620362644c1572b256ca831896c488c5::market::Market<T0, T1>) : bool {
        let v0 = HoldKey{dummy_field: false};
        0x2::dynamic_field::exists_with_type<HoldKey, Hold<T2>>(0xbe9a7d44698458aea5bcf0ebe57b04ca620362644c1572b256ca831896c488c5::market::uid<T0, T1>(arg0), v0)
    }

    fun held_units<T0, T1, T2>(arg0: &0xbe9a7d44698458aea5bcf0ebe57b04ca620362644c1572b256ca831896c488c5::market::Market<T0, T1>) : u64 {
        if (!has_hold<T0, T1, T2>(arg0)) {
            0
        } else {
            0x2::balance::value<T2>(&hold<T0, T1, T2>(arg0).held)
        }
    }

    fun hold<T0, T1, T2>(arg0: &0xbe9a7d44698458aea5bcf0ebe57b04ca620362644c1572b256ca831896c488c5::market::Market<T0, T1>) : &Hold<T2> {
        assert!(has_hold<T0, T1, T2>(arg0), 500);
        let v0 = HoldKey{dummy_field: false};
        0x2::dynamic_field::borrow<HoldKey, Hold<T2>>(0xbe9a7d44698458aea5bcf0ebe57b04ca620362644c1572b256ca831896c488c5::market::uid<T0, T1>(arg0), v0)
    }

    fun hold_mut<T0, T1, T2>(arg0: &mut 0xbe9a7d44698458aea5bcf0ebe57b04ca620362644c1572b256ca831896c488c5::market::Market<T0, T1>) : &mut Hold<T2> {
        assert!(has_hold<T0, T1, T2>(arg0), 500);
        let v0 = HoldKey{dummy_field: false};
        0x2::dynamic_field::borrow_mut<HoldKey, Hold<T2>>(0xbe9a7d44698458aea5bcf0ebe57b04ca620362644c1572b256ca831896c488c5::market::uid_mut<T0, T1>(arg0), v0)
    }

    public fun info<T0, T1, T2>(arg0: &0xbe9a7d44698458aea5bcf0ebe57b04ca620362644c1572b256ca831896c488c5::market::Market<T0, T1>) : (0x2::object::ID, u64, u64, u64, u64, u64, HoldSettings) {
        let v0 = hold<T0, T1, T2>(arg0);
        (v0.pool, 0x2::balance::value<T2>(&v0.held), v0.lent, v0.rate, v0.read, v0.fresh_ms, v0.settings)
    }

    public fun lend<T0, T1, T2, T3>(arg0: &mut 0xbe9a7d44698458aea5bcf0ebe57b04ca620362644c1572b256ca831896c488c5::market::Market<T1, T2>, arg1: &0xbe9a7d44698458aea5bcf0ebe57b04ca620362644c1572b256ca831896c488c5::config::Config, arg2: &mut 0xf95b06141ed4a174f239417323bde3f209b972f5930d8521ea38a52aff3a6ddf::lending_market::LendingMarket<T0>, arg3: u64, arg4: &0x2::clock::Clock, arg5: &mut 0x2::tx_context::TxContext) {
        0xbe9a7d44698458aea5bcf0ebe57b04ca620362644c1572b256ca831896c488c5::market::assert_config<T1, T2>(arg0, arg1);
        0xbe9a7d44698458aea5bcf0ebe57b04ca620362644c1572b256ca831896c488c5::config::assert_keeper(arg1, arg5);
        assert!(0xbe9a7d44698458aea5bcf0ebe57b04ca620362644c1572b256ca831896c488c5::market::state<T1, T2>(arg0) == 0, 517);
        let v0 = 0x2::object::id<0xbe9a7d44698458aea5bcf0ebe57b04ca620362644c1572b256ca831896c488c5::market::Market<T1, T2>>(arg0);
        let v1 = hold<T1, T2, T3>(arg0);
        assert!(v1.settings.lending, 510);
        assert!(arg3 > 0 && arg3 <= 0x2::balance::value<T3>(&v1.held), 514);
        assert!(0xbe9a7d44698458aea5bcf0ebe57b04ca620362644c1572b256ca831896c488c5::config::lending_market(arg1) == 0x1::option::some<0x2::object::ID>(0x2::object::id<0xf95b06141ed4a174f239417323bde3f209b972f5930d8521ea38a52aff3a6ddf::lending_market::LendingMarket<T0>>(arg2)), 511);
        let v2 = SleeveKey{dummy_field: false};
        if (!0x2::dynamic_field::exists<SleeveKey>(0xbe9a7d44698458aea5bcf0ebe57b04ca620362644c1572b256ca831896c488c5::market::uid<T1, T2>(arg0), v2)) {
            let v3 = SleeveKey{dummy_field: false};
            0x2::dynamic_field::add<SleeveKey, 0xbe9a7d44698458aea5bcf0ebe57b04ca620362644c1572b256ca831896c488c5::lending::Sleeve<T0, T3>>(0xbe9a7d44698458aea5bcf0ebe57b04ca620362644c1572b256ca831896c488c5::market::uid_mut<T1, T2>(arg0), v3, 0xbe9a7d44698458aea5bcf0ebe57b04ca620362644c1572b256ca831896c488c5::lending::new<T0, T3>(arg2));
        };
        let v4 = hold_mut<T1, T2, T3>(arg0);
        let v5 = 0x2::coin::from_balance<T3>(0x2::balance::split<T3>(&mut v4.held, arg3), arg5);
        let v6 = SleeveKey{dummy_field: false};
        let v7 = 0x2::dynamic_field::borrow_mut<SleeveKey, 0xbe9a7d44698458aea5bcf0ebe57b04ca620362644c1572b256ca831896c488c5::lending::Sleeve<T0, T3>>(0xbe9a7d44698458aea5bcf0ebe57b04ca620362644c1572b256ca831896c488c5::market::uid_mut<T1, T2>(arg0), v6);
        0xbe9a7d44698458aea5bcf0ebe57b04ca620362644c1572b256ca831896c488c5::lending::deposit<T0, T3>(v7, arg2, v5, arg4, arg5);
        let v8 = 0xbe9a7d44698458aea5bcf0ebe57b04ca620362644c1572b256ca831896c488c5::lending::value<T0, T3>(v7, arg2, arg4);
        let v9 = hold_mut<T1, T2, T3>(arg0);
        v9.lent = v8;
        store<T1, T2, T3>(arg0);
        let v10 = HoldLent{
            schema : 0xbe9a7d44698458aea5bcf0ebe57b04ca620362644c1572b256ca831896c488c5::config::schema(),
            market : v0,
            out    : true,
            amount : arg3,
            lent   : v8,
        };
        0x2::event::emit<HoldLent>(v10);
    }

    public fun lending_on(arg0: &HoldSettings) : bool {
        arg0.lending
    }

    fun lent_now<T0, T1, T2, T3>(arg0: &0xbe9a7d44698458aea5bcf0ebe57b04ca620362644c1572b256ca831896c488c5::market::Market<T1, T2>, arg1: &0xf95b06141ed4a174f239417323bde3f209b972f5930d8521ea38a52aff3a6ddf::lending_market::LendingMarket<T0>, arg2: &0x2::clock::Clock) : u64 {
        let v0 = SleeveKey{dummy_field: false};
        if (!0x2::dynamic_field::exists<SleeveKey>(0xbe9a7d44698458aea5bcf0ebe57b04ca620362644c1572b256ca831896c488c5::market::uid<T1, T2>(arg0), v0)) {
            return 0
        };
        let v1 = SleeveKey{dummy_field: false};
        0xbe9a7d44698458aea5bcf0ebe57b04ca620362644c1572b256ca831896c488c5::lending::value<T0, T3>(0x2::dynamic_field::borrow<SleeveKey, 0xbe9a7d44698458aea5bcf0ebe57b04ca620362644c1572b256ca831896c488c5::lending::Sleeve<T0, T3>>(0xbe9a7d44698458aea5bcf0ebe57b04ca620362644c1572b256ca831896c488c5::market::uid<T1, T2>(arg0), v1), arg1, arg2)
    }

    fun lent_units<T0, T1, T2>(arg0: &0xbe9a7d44698458aea5bcf0ebe57b04ca620362644c1572b256ca831896c488c5::market::Market<T0, T1>) : u64 {
        if (!has_hold<T0, T1, T2>(arg0)) {
            0
        } else {
            hold<T0, T1, T2>(arg0).lent
        }
    }

    public fun loosens(arg0: &HoldSettings, arg1: &HoldSettings) : bool {
        if (arg1.parking && !arg0.parking) {
            true
        } else if (arg1.lending && !arg0.lending) {
            true
        } else if (arg1.swap_slippage_bps > arg0.swap_slippage_bps) {
            true
        } else if (arg1.rate_window_ms < arg0.rate_window_ms) {
            true
        } else {
            arg1.max_move_bps != arg0.max_move_bps
        }
    }

    public fun mark<T0, T1, T2>(arg0: &mut 0xbe9a7d44698458aea5bcf0ebe57b04ca620362644c1572b256ca831896c488c5::market::Market<T0, T1>, arg1: &0xbe9a7d44698458aea5bcf0ebe57b04ca620362644c1572b256ca831896c488c5::config::Config, arg2: &0x2c8d603bc51326b8c13cef9dd07031a408a48dddb541963357661df5d3204809::pool::Pool<T2, T1>, arg3: &0x2::clock::Clock, arg4: &0x2::tx_context::TxContext) : u64 {
        0xbe9a7d44698458aea5bcf0ebe57b04ca620362644c1572b256ca831896c488c5::market::assert_config<T0, T1>(arg0, arg1);
        let v0 = hold<T0, T1, T2>(arg0);
        assert!(v0.pool == 0x2::object::id<0x2c8d603bc51326b8c13cef9dd07031a408a48dddb541963357661df5d3204809::pool::Pool<T2, T1>>(arg2), 502);
        let v1 = 0x2::tx_context::sender(arg4) == 0xbe9a7d44698458aea5bcf0ebe57b04ca620362644c1572b256ca831896c488c5::config::keeper(arg1);
        let v2 = if (v1) {
            read_rate<T2, T1>(arg2, units_out<T2>(v0), arg3)
        } else {
            0x1::option::none<u64>()
        };
        mark_at<T0, T1, T2>(arg0, arg1, v2, v1, 0x2::clock::timestamp_ms(arg3))
    }

    public(friend) fun mark_at<T0, T1, T2>(arg0: &mut 0xbe9a7d44698458aea5bcf0ebe57b04ca620362644c1572b256ca831896c488c5::market::Market<T0, T1>, arg1: &0xbe9a7d44698458aea5bcf0ebe57b04ca620362644c1572b256ca831896c488c5::config::Config, arg2: 0x1::option::Option<u64>, arg3: bool, arg4: u64) : u64 {
        0xbe9a7d44698458aea5bcf0ebe57b04ca620362644c1572b256ca831896c488c5::market::assert_config<T0, T1>(arg0, arg1);
        if (arg3) {
            let v0 = hold_mut<T0, T1, T2>(arg0);
            if (0x1::option::is_some<u64>(&arg2)) {
                observe<T2>(v0, 0x1::option::destroy_some<u64>(arg2), arg4);
                v0.fresh_ms = arg4;
            } else {
                let v1 = v0.rate;
                observe<T2>(v0, v1, arg4);
                v0.read = v0.rate;
            };
        };
        store<T0, T1, T2>(arg0)
    }

    public fun mark_lent<T0, T1, T2, T3>(arg0: &mut 0xbe9a7d44698458aea5bcf0ebe57b04ca620362644c1572b256ca831896c488c5::market::Market<T1, T2>, arg1: &0xbe9a7d44698458aea5bcf0ebe57b04ca620362644c1572b256ca831896c488c5::config::Config, arg2: &0xf95b06141ed4a174f239417323bde3f209b972f5930d8521ea38a52aff3a6ddf::lending_market::LendingMarket<T0>, arg3: &0x2::clock::Clock) : u64 {
        0xbe9a7d44698458aea5bcf0ebe57b04ca620362644c1572b256ca831896c488c5::market::assert_config<T1, T2>(arg0, arg1);
        let v0 = lent_now<T0, T1, T2, T3>(arg0, arg2, arg3);
        let v1 = hold_mut<T1, T2, T3>(arg0);
        v1.lent = v0;
        store<T1, T2, T3>(arg0)
    }

    public fun new_settings(arg0: bool, arg1: bool, arg2: u64, arg3: u64, arg4: u64) : HoldSettings {
        HoldSettings{
            parking           : arg0,
            lending           : arg1,
            swap_slippage_bps : arg2,
            rate_window_ms    : arg3,
            max_move_bps      : arg4,
        }
    }

    fun observe<T0>(arg0: &mut Hold<T0>, arg1: u64, arg2: u64) {
        let v0 = 0xbe9a7d44698458aea5bcf0ebe57b04ca620362644c1572b256ca831896c488c5::math::share_down(arg0.rate, arg0.settings.max_move_bps);
        let v1 = 0x1::u64::min(0x1::u64::max(arg0.read, arg0.rate - v0), 0x1::u64::min(arg0.rate + v0, (1000000000 as u64)));
        let v2 = if (v1 >= arg0.rate) {
            arg0.rate + ((((v1 - arg0.rate) as u128) * (0x1::u64::min(0xbe9a7d44698458aea5bcf0ebe57b04ca620362644c1572b256ca831896c488c5::math::sat_sub(arg2, arg0.read_ms), arg0.settings.rate_window_ms) as u128) / (arg0.settings.rate_window_ms as u128)) as u64)
        } else {
            arg0.rate - ((((arg0.rate - v1) as u128) * (0x1::u64::min(0xbe9a7d44698458aea5bcf0ebe57b04ca620362644c1572b256ca831896c488c5::math::sat_sub(arg2, arg0.read_ms), arg0.settings.rate_window_ms) as u128) / (arg0.settings.rate_window_ms as u128)) as u64)
        };
        arg0.rate = v2;
        arg0.read = arg1;
        arg0.read_ms = arg2;
    }

    public fun park<T0, T1, T2>(arg0: &mut 0xbe9a7d44698458aea5bcf0ebe57b04ca620362644c1572b256ca831896c488c5::market::Market<T0, T1>, arg1: &0xbe9a7d44698458aea5bcf0ebe57b04ca620362644c1572b256ca831896c488c5::config::Config, arg2: u64, arg3: &mut 0x2::tx_context::TxContext) : (0x2::coin::Coin<T1>, ParkTicket) {
        0xbe9a7d44698458aea5bcf0ebe57b04ca620362644c1572b256ca831896c488c5::market::assert_config<T0, T1>(arg0, arg1);
        0xbe9a7d44698458aea5bcf0ebe57b04ca620362644c1572b256ca831896c488c5::config::assert_keeper(arg1, arg3);
        assert!(0xbe9a7d44698458aea5bcf0ebe57b04ca620362644c1572b256ca831896c488c5::market::state<T0, T1>(arg0) == 0, 517);
        assert!(arg2 > 0, 514);
        let v0 = hold<T0, T1, T2>(arg0);
        assert!(v0.settings.parking, 505);
        assert!(slip_fits<T0, T1>(arg0, v0.settings.swap_slippage_bps), 504);
        let (v1, _) = 0xbe9a7d44698458aea5bcf0ebe57b04ca620362644c1572b256ca831896c488c5::market::last_price<T0, T1>(arg0);
        assert!(arg2 <= 0xbe9a7d44698458aea5bcf0ebe57b04ca620362644c1572b256ca831896c488c5::market::spare_cash<T0, T1>(arg0, v1), 506);
        let v3 = 0xbe9a7d44698458aea5bcf0ebe57b04ca620362644c1572b256ca831896c488c5::market::cash_out<T0, T1>(arg0, arg2, 3, arg3);
        let v4 = hold_mut<T0, T1, T2>(arg0);
        v4.in_flight = arg2;
        store<T0, T1, T2>(arg0);
        let v5 = ParkTicket{
            market : 0x2::object::id<0xbe9a7d44698458aea5bcf0ebe57b04ca620362644c1572b256ca831896c488c5::market::Market<T0, T1>>(arg0),
            amount : arg2,
        };
        (v3, v5)
    }

    public fun parking(arg0: &HoldSettings) : bool {
        arg0.parking
    }

    public(friend) fun pay<T0, T1, T2>(arg0: &mut 0xbe9a7d44698458aea5bcf0ebe57b04ca620362644c1572b256ca831896c488c5::market::Market<T0, T1>, arg1: 0x2::coin::Coin<T0>, arg2: u64, arg3: bool, arg4: u256, arg5: u64, arg6: u64, arg7: &mut 0x2::tx_context::TxContext) : (0x2::coin::Coin<T1>, 0x2::coin::Coin<T2>, 0x1::option::Option<u64>) {
        if (!has_hold<T0, T1, T2>(arg0)) {
            let (v0, v1) = 0xbe9a7d44698458aea5bcf0ebe57b04ca620362644c1572b256ca831896c488c5::market::sell_split<T0, T1>(arg0, arg1, arg2, arg4, arg5, arg6, 18446744073709551615, arg7);
            assert!(v1 == 0, 513);
            return (v0, 0x2::coin::zero<T2>(arg7), 0x1::option::none<u64>())
        };
        let v2 = hold<T0, T1, T2>(arg0);
        let v3 = 0x2::balance::value<T2>(&v2.held);
        let v4 = if (arg3) {
            0xbe9a7d44698458aea5bcf0ebe57b04ca620362644c1572b256ca831896c488c5::math::sat_sub(0xbe9a7d44698458aea5bcf0ebe57b04ca620362644c1572b256ca831896c488c5::math::sat_sub(0xbe9a7d44698458aea5bcf0ebe57b04ca620362644c1572b256ca831896c488c5::market::sale_payout<T0, T1>(arg0, 0x2::coin::value<T0>(&arg1), arg4, arg6), arg5), v3)
        } else if ((v2.rate as u128) < 1000000000 - 1000000000 * (v2.settings.swap_slippage_bps as u128) / 10000) {
            let v5 = 0xbe9a7d44698458aea5bcf0ebe57b04ca620362644c1572b256ca831896c488c5::market::cash<T0, T1>(arg0);
            if (v5 + v3 == 0) {
                0
            } else {
                0xbe9a7d44698458aea5bcf0ebe57b04ca620362644c1572b256ca831896c488c5::math::mul_div_down(0xbe9a7d44698458aea5bcf0ebe57b04ca620362644c1572b256ca831896c488c5::math::sat_sub(0xbe9a7d44698458aea5bcf0ebe57b04ca620362644c1572b256ca831896c488c5::market::sale_payout<T0, T1>(arg0, 0x2::coin::value<T0>(&arg1), arg4, arg6), arg5), v5, v5 + v3)
            }
        } else {
            18446744073709551615
        };
        let (v6, v7) = 0xbe9a7d44698458aea5bcf0ebe57b04ca620362644c1572b256ca831896c488c5::market::sell_split<T0, T1>(arg0, arg1, arg2, arg4, arg5, arg6, v4, arg7);
        let v8 = 0x2::object::id<0xbe9a7d44698458aea5bcf0ebe57b04ca620362644c1572b256ca831896c488c5::market::Market<T0, T1>>(arg0);
        let v9 = hold_mut<T0, T1, T2>(arg0);
        let v10 = 0x1::u64::min(v7, 0x2::balance::value<T2>(&v9.held));
        let v11 = v7 - v10;
        v9.totals.paid_in_kind = v9.totals.paid_in_kind + (v10 as u128);
        if (v10 > 0) {
            store<T0, T1, T2>(arg0);
            let v12 = PaidInKind{
                schema         : 0xbe9a7d44698458aea5bcf0ebe57b04ca620362644c1572b256ca831896c488c5::config::schema(),
                market         : v8,
                seller         : 0x2::tx_context::sender(arg7),
                units          : v10,
                receipts       : 0,
                receipts_worth : 0,
            };
            0x2::event::emit<PaidInKind>(v12);
        };
        let v13 = if (v11 == 0) {
            0x1::option::none<u64>()
        } else {
            0x1::option::some<u64>(v11)
        };
        (v6, 0x2::coin::from_balance<T2>(0x2::balance::split<T2>(&mut v9.held, v10), arg7), v13)
    }

    fun pay_receipts<T0, T1, T2, T3>(arg0: &mut 0xbe9a7d44698458aea5bcf0ebe57b04ca620362644c1572b256ca831896c488c5::market::Market<T1, T2>, arg1: 0x1::option::Option<u64>, arg2: &0xf95b06141ed4a174f239417323bde3f209b972f5930d8521ea38a52aff3a6ddf::lending_market::LendingMarket<T0>, arg3: &0x2::clock::Clock, arg4: &mut 0x2::tx_context::TxContext) : 0x2::coin::Coin<0xf95b06141ed4a174f239417323bde3f209b972f5930d8521ea38a52aff3a6ddf::reserve::CToken<T0, T3>> {
        if (0x1::option::is_none<u64>(&arg1)) {
            return 0x2::coin::zero<0xf95b06141ed4a174f239417323bde3f209b972f5930d8521ea38a52aff3a6ddf::reserve::CToken<T0, T3>>(arg4)
        };
        let v0 = SleeveKey{dummy_field: false};
        assert!(0x2::dynamic_field::exists<SleeveKey>(0xbe9a7d44698458aea5bcf0ebe57b04ca620362644c1572b256ca831896c488c5::market::uid<T1, T2>(arg0), v0), 513);
        let v1 = SleeveKey{dummy_field: false};
        let v2 = 0x2::dynamic_field::borrow_mut<SleeveKey, 0xbe9a7d44698458aea5bcf0ebe57b04ca620362644c1572b256ca831896c488c5::lending::Sleeve<T0, T3>>(0xbe9a7d44698458aea5bcf0ebe57b04ca620362644c1572b256ca831896c488c5::market::uid_mut<T1, T2>(arg0), v1);
        let (v3, v4, v5) = 0xbe9a7d44698458aea5bcf0ebe57b04ca620362644c1572b256ca831896c488c5::lending::take_ctokens<T0, T3>(v2, arg2, 0x1::option::destroy_some<u64>(arg1), arg3);
        let v6 = v3;
        assert!(v5, 513);
        let v7 = 0xbe9a7d44698458aea5bcf0ebe57b04ca620362644c1572b256ca831896c488c5::lending::value<T0, T3>(v2, arg2, arg3);
        let v8 = 0x2::object::id<0xbe9a7d44698458aea5bcf0ebe57b04ca620362644c1572b256ca831896c488c5::market::Market<T1, T2>>(arg0);
        let v9 = hold_mut<T1, T2, T3>(arg0);
        v9.lent = v7;
        v9.totals.receipts_paid = v9.totals.receipts_paid + (v4 as u128);
        store<T1, T2, T3>(arg0);
        let v10 = PaidInKind{
            schema         : 0xbe9a7d44698458aea5bcf0ebe57b04ca620362644c1572b256ca831896c488c5::config::schema(),
            market         : v8,
            seller         : 0x2::tx_context::sender(arg4),
            units          : 0,
            receipts       : 0x2::balance::value<0xf95b06141ed4a174f239417323bde3f209b972f5930d8521ea38a52aff3a6ddf::reserve::CToken<T0, T3>>(&v6),
            receipts_worth : v4,
        };
        0x2::event::emit<PaidInKind>(v10);
        0x2::coin::from_balance<0xf95b06141ed4a174f239417323bde3f209b972f5930d8521ea38a52aff3a6ddf::reserve::CToken<T0, T3>>(v6, arg4)
    }

    public fun pending<T0, T1, T2>(arg0: &0xbe9a7d44698458aea5bcf0ebe57b04ca620362644c1572b256ca831896c488c5::market::Market<T0, T1>) : (bool, HoldSettings, 0x2::object::ID, u64) {
        let v0 = hold<T0, T1, T2>(arg0);
        if (0x1::option::is_some<PendingHold>(&v0.pending)) {
            let v5 = 0x1::option::borrow<PendingHold>(&v0.pending);
            (true, v5.settings, v5.pool, v5.effective_ms)
        } else {
            (false, v0.settings, v0.pool, 0)
        }
    }

    public(friend) fun rate_of(arg0: u64, arg1: u64) : 0x1::option::Option<u64> {
        if (arg0 == 0 || arg1 == 0) {
            return 0x1::option::none<u64>()
        };
        let v0 = (arg1 as u128) * 1000000000 / (arg0 as u128);
        let v1 = if (v0 > 1000000000) {
            1000000000
        } else {
            v0
        };
        0x1::option::some<u64>((v1 as u64))
    }

    public fun rate_one() : u64 {
        (1000000000 as u64)
    }

    public fun rate_window_ms(arg0: &HoldSettings) : u64 {
        arg0.rate_window_ms
    }

    fun read_rate<T0, T1>(arg0: &0x2c8d603bc51326b8c13cef9dd07031a408a48dddb541963357661df5d3204809::pool::Pool<T0, T1>, arg1: u64, arg2: &0x2::clock::Clock) : 0x1::option::Option<u64> {
        let (_, v1, v2) = 0x2c8d603bc51326b8c13cef9dd07031a408a48dddb541963357661df5d3204809::pool::pool_book_params<T0, T1>(arg0);
        let v3 = 0x1::u64::max(arg1, 2 * v2);
        let (v4, v5, _) = 0x2c8d603bc51326b8c13cef9dd07031a408a48dddb541963357661df5d3204809::pool::get_quote_quantity_out_input_fee<T0, T1>(arg0, v3, arg2);
        if (v4 > v1) {
            return 0x1::option::none<u64>()
        };
        rate_of(v3 - v4, v5)
    }

    fun refresh_lent<T0, T1, T2, T3>(arg0: &mut 0xbe9a7d44698458aea5bcf0ebe57b04ca620362644c1572b256ca831896c488c5::market::Market<T1, T2>, arg1: &0xf95b06141ed4a174f239417323bde3f209b972f5930d8521ea38a52aff3a6ddf::lending_market::LendingMarket<T0>, arg2: &0x2::clock::Clock) {
        if (!has_hold<T1, T2, T3>(arg0)) {
            return
        };
        let v0 = lent_now<T0, T1, T2, T3>(arg0, arg1, arg2);
        let v1 = hold_mut<T1, T2, T3>(arg0);
        v1.lent = v0;
        store<T1, T2, T3>(arg0);
    }

    fun sale_price<T0, T1>(arg0: &0xbe9a7d44698458aea5bcf0ebe57b04ca620362644c1572b256ca831896c488c5::market::Market<T0, T1>, arg1: &0x3ec740df8428aa9c93aaef7f8cc1542ac3194fd014826b51bfe245346d64efc7::clearing_house::ClearingHouse<T1>, arg2: &0x9237337d846fc90b0a7acbdee4ab91809298691873d28e1d64d91e6303ff6ba4::price_feed_storage::PriceFeedStorage, arg3: &0x2::clock::Clock) : u256 {
        let v0 = 0xbe9a7d44698458aea5bcf0ebe57b04ca620362644c1572b256ca831896c488c5::market::settings<T0, T1>(arg0);
        let (_, v2) = 0xbe9a7d44698458aea5bcf0ebe57b04ca620362644c1572b256ca831896c488c5::market::ages(&v0);
        0xbe9a7d44698458aea5bcf0ebe57b04ca620362644c1572b256ca831896c488c5::oracle::feed_price<T1>(arg1, arg2, arg3, 0xbe9a7d44698458aea5bcf0ebe57b04ca620362644c1572b256ca831896c488c5::market::venue<T0, T1>(arg0), v2)
    }

    public fun sell<T0, T1, T2>(arg0: &mut 0xbe9a7d44698458aea5bcf0ebe57b04ca620362644c1572b256ca831896c488c5::market::Market<T0, T1>, arg1: &0xbe9a7d44698458aea5bcf0ebe57b04ca620362644c1572b256ca831896c488c5::config::Config, arg2: 0x2::coin::Coin<T0>, arg3: u64, arg4: bool, arg5: &mut 0x3ec740df8428aa9c93aaef7f8cc1542ac3194fd014826b51bfe245346d64efc7::account::Account<T1>, arg6: 0x3ec740df8428aa9c93aaef7f8cc1542ac3194fd014826b51bfe245346d64efc7::clearing_house::ClearingHouse<T1>, arg7: &0x3ec740df8428aa9c93aaef7f8cc1542ac3194fd014826b51bfe245346d64efc7::registry::Registry, arg8: &0x9237337d846fc90b0a7acbdee4ab91809298691873d28e1d64d91e6303ff6ba4::price_feed_storage::PriceFeedStorage, arg9: &0x9237337d846fc90b0a7acbdee4ab91809298691873d28e1d64d91e6303ff6ba4::price_feed_storage::PriceFeedStorage, arg10: &0x2::clock::Clock, arg11: &mut 0x2::tx_context::TxContext) : (0x2::coin::Coin<T1>, 0x2::coin::Coin<T2>, 0x3ec740df8428aa9c93aaef7f8cc1542ac3194fd014826b51bfe245346d64efc7::clearing_house::ClearingHouse<T1>) {
        0xbe9a7d44698458aea5bcf0ebe57b04ca620362644c1572b256ca831896c488c5::market::assert_config<T0, T1>(arg0, arg1);
        let v0 = sale_price<T0, T1>(arg0, &arg6, arg8, arg10);
        let (v1, v2) = 0xbe9a7d44698458aea5bcf0ebe57b04ca620362644c1572b256ca831896c488c5::hedge::sale_hedge<T0, T1>(arg0, arg5, arg6, arg7, arg8, arg9, v0, 0x2::coin::value<T0>(&arg2), held_units<T0, T1, T2>(arg0), arg10, arg11);
        let (v3, v4, v5) = pay<T0, T1, T2>(arg0, arg2, arg3, arg4, v0, v1, 0x2::clock::timestamp_ms(arg10), arg11);
        let v6 = v5;
        assert!(0x1::option::is_none<u64>(&v6), 513);
        (v3, v4, v2)
    }

    public fun sell_lent<T0, T1, T2, T3>(arg0: &mut 0xbe9a7d44698458aea5bcf0ebe57b04ca620362644c1572b256ca831896c488c5::market::Market<T1, T2>, arg1: &0xbe9a7d44698458aea5bcf0ebe57b04ca620362644c1572b256ca831896c488c5::config::Config, arg2: 0x2::coin::Coin<T1>, arg3: u64, arg4: bool, arg5: &mut 0x3ec740df8428aa9c93aaef7f8cc1542ac3194fd014826b51bfe245346d64efc7::account::Account<T2>, arg6: 0x3ec740df8428aa9c93aaef7f8cc1542ac3194fd014826b51bfe245346d64efc7::clearing_house::ClearingHouse<T2>, arg7: &0x3ec740df8428aa9c93aaef7f8cc1542ac3194fd014826b51bfe245346d64efc7::registry::Registry, arg8: &0x9237337d846fc90b0a7acbdee4ab91809298691873d28e1d64d91e6303ff6ba4::price_feed_storage::PriceFeedStorage, arg9: &0x9237337d846fc90b0a7acbdee4ab91809298691873d28e1d64d91e6303ff6ba4::price_feed_storage::PriceFeedStorage, arg10: &0xf95b06141ed4a174f239417323bde3f209b972f5930d8521ea38a52aff3a6ddf::lending_market::LendingMarket<T0>, arg11: &0x2::clock::Clock, arg12: &mut 0x2::tx_context::TxContext) : (0x2::coin::Coin<T2>, 0x2::coin::Coin<T3>, 0x2::coin::Coin<0xf95b06141ed4a174f239417323bde3f209b972f5930d8521ea38a52aff3a6ddf::reserve::CToken<T0, T3>>, 0x3ec740df8428aa9c93aaef7f8cc1542ac3194fd014826b51bfe245346d64efc7::clearing_house::ClearingHouse<T2>) {
        0xbe9a7d44698458aea5bcf0ebe57b04ca620362644c1572b256ca831896c488c5::market::assert_config<T1, T2>(arg0, arg1);
        let v0 = sale_price<T1, T2>(arg0, &arg6, arg8, arg11);
        refresh_lent<T0, T1, T2, T3>(arg0, arg10, arg11);
        let (v1, v2) = 0xbe9a7d44698458aea5bcf0ebe57b04ca620362644c1572b256ca831896c488c5::hedge::sale_hedge<T1, T2>(arg0, arg5, arg6, arg7, arg8, arg9, v0, 0x2::coin::value<T1>(&arg2), held_units<T1, T2, T3>(arg0) + lent_units<T1, T2, T3>(arg0), arg11, arg12);
        let (v3, v4, v5) = pay<T1, T2, T3>(arg0, arg2, arg3, arg4, v0, v1, 0x2::clock::timestamp_ms(arg11), arg12);
        (v3, v4, pay_receipts<T0, T1, T2, T3>(arg0, v5, arg10, arg11, arg12), v2)
    }

    public fun sell_venue_free<T0, T1, T2>(arg0: &mut 0xbe9a7d44698458aea5bcf0ebe57b04ca620362644c1572b256ca831896c488c5::market::Market<T0, T1>, arg1: &0xbe9a7d44698458aea5bcf0ebe57b04ca620362644c1572b256ca831896c488c5::config::Config, arg2: 0x2::coin::Coin<T0>, arg3: u64, arg4: bool, arg5: &0x3ec740df8428aa9c93aaef7f8cc1542ac3194fd014826b51bfe245346d64efc7::clearing_house::ClearingHouse<T1>, arg6: &0x9237337d846fc90b0a7acbdee4ab91809298691873d28e1d64d91e6303ff6ba4::price_feed_storage::PriceFeedStorage, arg7: &0x2::clock::Clock, arg8: &mut 0x2::tx_context::TxContext) : (0x2::coin::Coin<T1>, 0x2::coin::Coin<T2>) {
        0xbe9a7d44698458aea5bcf0ebe57b04ca620362644c1572b256ca831896c488c5::market::assert_config<T0, T1>(arg0, arg1);
        let v0 = sale_price<T0, T1>(arg0, arg5, arg6, arg7);
        let (v1, v2, v3) = pay<T0, T1, T2>(arg0, arg2, arg3, arg4, v0, 0, 0x2::clock::timestamp_ms(arg7), arg8);
        let v4 = v3;
        assert!(0x1::option::is_none<u64>(&v4), 513);
        (v1, v2)
    }

    public fun sell_venue_free_lent<T0, T1, T2, T3>(arg0: &mut 0xbe9a7d44698458aea5bcf0ebe57b04ca620362644c1572b256ca831896c488c5::market::Market<T1, T2>, arg1: &0xbe9a7d44698458aea5bcf0ebe57b04ca620362644c1572b256ca831896c488c5::config::Config, arg2: 0x2::coin::Coin<T1>, arg3: u64, arg4: bool, arg5: &0x3ec740df8428aa9c93aaef7f8cc1542ac3194fd014826b51bfe245346d64efc7::clearing_house::ClearingHouse<T2>, arg6: &0x9237337d846fc90b0a7acbdee4ab91809298691873d28e1d64d91e6303ff6ba4::price_feed_storage::PriceFeedStorage, arg7: &0xf95b06141ed4a174f239417323bde3f209b972f5930d8521ea38a52aff3a6ddf::lending_market::LendingMarket<T0>, arg8: &0x2::clock::Clock, arg9: &mut 0x2::tx_context::TxContext) : (0x2::coin::Coin<T2>, 0x2::coin::Coin<T3>, 0x2::coin::Coin<0xf95b06141ed4a174f239417323bde3f209b972f5930d8521ea38a52aff3a6ddf::reserve::CToken<T0, T3>>) {
        0xbe9a7d44698458aea5bcf0ebe57b04ca620362644c1572b256ca831896c488c5::market::assert_config<T1, T2>(arg0, arg1);
        let v0 = sale_price<T1, T2>(arg0, arg5, arg6, arg8);
        refresh_lent<T0, T1, T2, T3>(arg0, arg7, arg8);
        let (v1, v2, v3) = pay<T1, T2, T3>(arg0, arg2, arg3, arg4, v0, 0, 0x2::clock::timestamp_ms(arg8), arg9);
        (v1, v2, pay_receipts<T0, T1, T2, T3>(arg0, v3, arg7, arg8, arg9))
    }

    public fun send_or_destroy<T0>(arg0: 0x2::coin::Coin<T0>, arg1: address) {
        if (0x2::coin::value<T0>(&arg0) == 0) {
            0x2::coin::destroy_zero<T0>(arg0);
        } else {
            0x2::transfer::public_transfer<0x2::coin::Coin<T0>>(arg0, arg1);
        };
    }

    public fun set_settings<T0, T1, T2>(arg0: &0xbe9a7d44698458aea5bcf0ebe57b04ca620362644c1572b256ca831896c488c5::config::AdminCap, arg1: &mut 0xbe9a7d44698458aea5bcf0ebe57b04ca620362644c1572b256ca831896c488c5::market::Market<T0, T1>, arg2: &0xbe9a7d44698458aea5bcf0ebe57b04ca620362644c1572b256ca831896c488c5::config::Config, arg3: HoldSettings, arg4: 0x2::object::ID, arg5: &0x2::clock::Clock) {
        0xbe9a7d44698458aea5bcf0ebe57b04ca620362644c1572b256ca831896c488c5::market::assert_config<T0, T1>(arg1, arg2);
        validate<T0, T1>(arg1, &arg3);
        let v0 = 0x2::object::id<0xbe9a7d44698458aea5bcf0ebe57b04ca620362644c1572b256ca831896c488c5::market::Market<T0, T1>>(arg1);
        let v1 = hold_mut<T0, T1, T2>(arg1);
        if (loosens(&v1.settings, &arg3) || arg4 != v1.pool) {
            let v2 = 0x2::clock::timestamp_ms(arg5) + 0xbe9a7d44698458aea5bcf0ebe57b04ca620362644c1572b256ca831896c488c5::config::change_delay_ms(arg2);
            let v3 = PendingHold{
                settings     : arg3,
                pool         : arg4,
                effective_ms : v2,
            };
            v1.pending = 0x1::option::some<PendingHold>(v3);
            let v4 = HoldSettingsProposed{
                schema       : 0xbe9a7d44698458aea5bcf0ebe57b04ca620362644c1572b256ca831896c488c5::config::schema(),
                market       : v0,
                settings     : arg3,
                pool         : arg4,
                effective_ms : v2,
            };
            0x2::event::emit<HoldSettingsProposed>(v4);
        } else {
            v1.settings = arg3;
            v1.pending = 0x1::option::none<PendingHold>();
            let v5 = HoldSettingsChanged{
                schema   : 0xbe9a7d44698458aea5bcf0ebe57b04ca620362644c1572b256ca831896c488c5::config::schema(),
                market   : v0,
                settings : arg3,
                pool     : arg4,
            };
            0x2::event::emit<HoldSettingsChanged>(v5);
        };
    }

    fun slip_fits<T0, T1>(arg0: &0xbe9a7d44698458aea5bcf0ebe57b04ca620362644c1572b256ca831896c488c5::market::Market<T0, T1>, arg1: u64) : bool {
        let v0 = 0xbe9a7d44698458aea5bcf0ebe57b04ca620362644c1572b256ca831896c488c5::market::settings<T0, T1>(arg0);
        let (v1, v2) = 0xbe9a7d44698458aea5bcf0ebe57b04ca620362644c1572b256ca831896c488c5::market::fees(&v0);
        2 * arg1 <= v1 + v2
    }

    fun spend<T0>(arg0: &mut Hold<T0>, arg1: u64, arg2: u64, arg3: u64, arg4: bool) {
        if (arg3 >= arg0.cost_from_ms + 86400000) {
            arg0.cost_from_ms = arg3;
            arg0.cost_used = 0;
            arg0.cost_base = 0;
        };
        arg0.cost_used = arg0.cost_used + arg1;
        arg0.cost_base = 0x1::u64::max(arg0.cost_base, 0x1::u64::max(units_out<T0>(arg0) + arg0.in_flight, arg2));
        assert!(!arg4 || arg0.cost_used <= 0xbe9a7d44698458aea5bcf0ebe57b04ca620362644c1572b256ca831896c488c5::math::share_up(arg0.cost_base, arg0.settings.swap_slippage_bps), 509);
        arg0.totals.swap_cost = arg0.totals.swap_cost + (arg1 as u128);
    }

    fun store<T0, T1, T2>(arg0: &mut 0xbe9a7d44698458aea5bcf0ebe57b04ca620362644c1572b256ca831896c488c5::market::Market<T0, T1>) : u64 {
        let v0 = hold<T0, T1, T2>(arg0);
        let v1 = units_out<T2>(v0);
        let v2 = worth(v1, v0.rate) + v0.in_flight;
        let v3 = v1 + v0.in_flight;
        let v4 = v0.fresh_ms;
        0xbe9a7d44698458aea5bcf0ebe57b04ca620362644c1572b256ca831896c488c5::market::set_parked_mark<T0, T1>(arg0, v2, v3, v4);
        let v5 = HoldMarked{
            schema       : 0xbe9a7d44698458aea5bcf0ebe57b04ca620362644c1572b256ca831896c488c5::config::schema(),
            market       : 0x2::object::id<0xbe9a7d44698458aea5bcf0ebe57b04ca620362644c1572b256ca831896c488c5::market::Market<T0, T1>>(arg0),
            held         : 0x2::balance::value<T2>(&v0.held),
            lent         : v0.lent,
            rate         : v0.rate,
            read         : v0.read,
            value        : v2,
            par          : v3,
            timestamp_ms : v4,
        };
        0x2::event::emit<HoldMarked>(v5);
        v2
    }

    public fun swap_slippage_bps(arg0: &HoldSettings) : u64 {
        arg0.swap_slippage_bps
    }

    public fun totals<T0, T1, T2>(arg0: &0xbe9a7d44698458aea5bcf0ebe57b04ca620362644c1572b256ca831896c488c5::market::Market<T0, T1>) : (u128, u128, u128, u128, u128, u128) {
        let v0 = &hold<T0, T1, T2>(arg0).totals;
        (v0.parked, v0.unparked, v0.swap_cost, v0.paid_in_kind, v0.receipts_paid, v0.gifts)
    }

    fun units_out<T0>(arg0: &Hold<T0>) : u64 {
        0x2::balance::value<T0>(&arg0.held) + arg0.lent + arg0.out_units
    }

    public fun unlend<T0, T1, T2, T3>(arg0: &mut 0xbe9a7d44698458aea5bcf0ebe57b04ca620362644c1572b256ca831896c488c5::market::Market<T1, T2>, arg1: &0xbe9a7d44698458aea5bcf0ebe57b04ca620362644c1572b256ca831896c488c5::config::Config, arg2: &mut 0xf95b06141ed4a174f239417323bde3f209b972f5930d8521ea38a52aff3a6ddf::lending_market::LendingMarket<T0>, arg3: u64, arg4: &0x2::clock::Clock, arg5: &mut 0x2::tx_context::TxContext) : u64 {
        0xbe9a7d44698458aea5bcf0ebe57b04ca620362644c1572b256ca831896c488c5::market::assert_config<T1, T2>(arg0, arg1);
        let v0 = SleeveKey{dummy_field: false};
        assert!(0x2::dynamic_field::exists<SleeveKey>(0xbe9a7d44698458aea5bcf0ebe57b04ca620362644c1572b256ca831896c488c5::market::uid<T1, T2>(arg0), v0), 518);
        let v1 = 0x2::object::id<0xbe9a7d44698458aea5bcf0ebe57b04ca620362644c1572b256ca831896c488c5::market::Market<T1, T2>>(arg0);
        let v2 = SleeveKey{dummy_field: false};
        let v3 = 0x2::dynamic_field::borrow_mut<SleeveKey, 0xbe9a7d44698458aea5bcf0ebe57b04ca620362644c1572b256ca831896c488c5::lending::Sleeve<T0, T3>>(0xbe9a7d44698458aea5bcf0ebe57b04ca620362644c1572b256ca831896c488c5::market::uid_mut<T1, T2>(arg0), v2);
        let v4 = 0xbe9a7d44698458aea5bcf0ebe57b04ca620362644c1572b256ca831896c488c5::lending::withdraw<T0, T3>(v3, arg2, arg3, arg4, arg5);
        let v5 = 0xbe9a7d44698458aea5bcf0ebe57b04ca620362644c1572b256ca831896c488c5::lending::value<T0, T3>(v3, arg2, arg4);
        let v6 = 0x2::coin::value<T3>(&v4);
        let v7 = hold_mut<T1, T2, T3>(arg0);
        0x2::balance::join<T3>(&mut v7.held, 0x2::coin::into_balance<T3>(v4));
        v7.lent = v5;
        store<T1, T2, T3>(arg0);
        let v8 = HoldLent{
            schema : 0xbe9a7d44698458aea5bcf0ebe57b04ca620362644c1572b256ca831896c488c5::config::schema(),
            market : v1,
            out    : false,
            amount : v6,
            lent   : v5,
        };
        0x2::event::emit<HoldLent>(v8);
        v6
    }

    public fun unpark<T0, T1, T2>(arg0: &mut 0xbe9a7d44698458aea5bcf0ebe57b04ca620362644c1572b256ca831896c488c5::market::Market<T0, T1>, arg1: &0xbe9a7d44698458aea5bcf0ebe57b04ca620362644c1572b256ca831896c488c5::config::Config, arg2: u64, arg3: &0x2::clock::Clock, arg4: &mut 0x2::tx_context::TxContext) : (0x2::coin::Coin<T2>, UnparkTicket) {
        0xbe9a7d44698458aea5bcf0ebe57b04ca620362644c1572b256ca831896c488c5::market::assert_config<T0, T1>(arg0, arg1);
        0xbe9a7d44698458aea5bcf0ebe57b04ca620362644c1572b256ca831896c488c5::config::assert_keeper(arg1, arg4);
        let v0 = 0xbe9a7d44698458aea5bcf0ebe57b04ca620362644c1572b256ca831896c488c5::market::settings<T0, T1>(arg0);
        let (v1, _) = 0xbe9a7d44698458aea5bcf0ebe57b04ca620362644c1572b256ca831896c488c5::market::ages(&v0);
        let v3 = 0x2::object::id<0xbe9a7d44698458aea5bcf0ebe57b04ca620362644c1572b256ca831896c488c5::market::Market<T0, T1>>(arg0);
        let v4 = 0xbe9a7d44698458aea5bcf0ebe57b04ca620362644c1572b256ca831896c488c5::market::state<T0, T1>(arg0) == 0;
        let v5 = hold_mut<T0, T1, T2>(arg0);
        assert!(arg2 > 0 && arg2 <= 0x2::balance::value<T2>(&v5.held), 514);
        let v6 = 0x2::clock::timestamp_ms(arg3);
        let v7 = if (v6 <= v5.fresh_ms + v1) {
            0x1::u64::max(v5.rate, v5.read)
        } else if (v4) {
            (1000000000 as u64)
        } else {
            (((v5.rate as u128) - (v5.rate as u128) * 0x1::u128::min(((v6 - v5.fresh_ms) as u128) * (v5.settings.max_move_bps as u128) / (v5.settings.rate_window_ms as u128), 10000) / 10000) as u64)
        };
        v5.out_units = arg2;
        store<T0, T1, T2>(arg0);
        let v8 = UnparkTicket{
            market : v3,
            amount : arg2,
            rate   : v7,
        };
        (0x2::coin::from_balance<T2>(0x2::balance::split<T2>(&mut v5.held, arg2), arg4), v8)
    }

    fun validate<T0, T1>(arg0: &0xbe9a7d44698458aea5bcf0ebe57b04ca620362644c1572b256ca831896c488c5::market::Market<T0, T1>, arg1: &HoldSettings) {
        assert!(arg1.swap_slippage_bps > 0 && slip_fits<T0, T1>(arg0, arg1.swap_slippage_bps), 504);
        assert!(arg1.rate_window_ms >= 60000 && arg1.rate_window_ms <= 86400000, 504);
        assert!(arg1.max_move_bps > 0 && arg1.max_move_bps <= 10000, 504);
    }

    fun worth(arg0: u64, arg1: u64) : u64 {
        (((arg0 as u128) * (arg1 as u128) / 1000000000) as u64)
    }

    // decompiled from Move bytecode v7
}

