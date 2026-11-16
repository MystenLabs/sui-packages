module 0x46d2ff5170c0d2d82398410123b001274eb3abfa80679f892c7a1ec29864d1d6::curve {
    struct CurveKey has copy, drop, store {
        dummy_field: bool,
    }

    struct WalletDay has drop, store {
        day: u64,
        spent: u64,
        allowance: u64,
    }

    struct Curve has key {
        id: 0x2::object::UID,
        desk_id: 0x2::object::ID,
        treasury_id: 0x2::object::ID,
        pool_id: 0x2::object::ID,
        usdc_type: 0x1::type_name::TypeName,
        usdc_to: address,
        price_e9: u64,
        floor_e9: u64,
        ceiling_e9: u64,
        anchor_bps: u64,
        step_bps: u64,
        daily_move_bps: u64,
        wallet_day_cap: u64,
        total_day_cap: u64,
        min_buy: u64,
        budget: u64,
        sold: u64,
        usdc_in: u64,
        purchases: u64,
        day: u64,
        day_open_e9: u64,
        day_total: u64,
        day_override: u64,
        frozen: bool,
        wallets: 0x2::table::Table<address, WalletDay>,
    }

    struct CurveCreated has copy, drop {
        curve_id: 0x2::object::ID,
        pool_id: 0x2::object::ID,
        price_e9: u64,
        spot_e9: u64,
        floor_e9: u64,
        ceiling_e9: u64,
        budget: u64,
    }

    struct CurveBought has copy, drop {
        buyer: address,
        usdc: u64,
        soostone: u64,
        price_e9: u64,
        spot_e9: u64,
        next_price_e9: u64,
        to_btc: u64,
        to_strc: u64,
        usdc_to: address,
        day: u64,
        sold: u64,
    }

    struct CurveFrozen has copy, drop {
        frozen: bool,
    }

    struct CurveBoundsSet has copy, drop {
        floor_e9: u64,
        ceiling_e9: u64,
    }

    struct CurveCapsSet has copy, drop {
        wallet_day_cap: u64,
        total_day_cap: u64,
    }

    struct CurveOverride has copy, drop {
        wallet: address,
        extra: u64,
        day: u64,
    }

    fun assert_admin(arg0: &0x46d2ff5170c0d2d82398410123b001274eb3abfa80679f892c7a1ec29864d1d6::soostone::GuardianCap, arg1: &0x46d2ff5170c0d2d82398410123b001274eb3abfa80679f892c7a1ec29864d1d6::soostone::Desk, arg2: &Curve, arg3: &0x2::tx_context::TxContext) {
        0x46d2ff5170c0d2d82398410123b001274eb3abfa80679f892c7a1ec29864d1d6::soostone::pkg_assert_87e0(arg0, arg1, arg3);
        assert!(arg2.desk_id == 0x2::object::id<0x46d2ff5170c0d2d82398410123b001274eb3abfa80679f892c7a1ec29864d1d6::soostone::Desk>(arg1), 13);
    }

    public fun bounds(arg0: &Curve) : (u64, u64) {
        (arg0.floor_e9, arg0.ceiling_e9)
    }

    fun bps_of(arg0: u64, arg1: u64) : u64 {
        (((arg0 as u128) * (arg1 as u128) / 10000) as u64)
    }

    public fun buy<T0>(arg0: &mut Curve, arg1: &mut 0x46d2ff5170c0d2d82398410123b001274eb3abfa80679f892c7a1ec29864d1d6::soostone::Treasury, arg2: &0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool::Pool<T0, 0x46d2ff5170c0d2d82398410123b001274eb3abfa80679f892c7a1ec29864d1d6::soostone::SOOSTONE>, arg3: 0x2::coin::Coin<T0>, arg4: u64, arg5: &0x2::clock::Clock, arg6: &mut 0x2::tx_context::TxContext) : 0x2::coin::Coin<0x46d2ff5170c0d2d82398410123b001274eb3abfa80679f892c7a1ec29864d1d6::soostone::SOOSTONE> {
        assert!(0x2::object::id<0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool::Pool<T0, 0x46d2ff5170c0d2d82398410123b001274eb3abfa80679f892c7a1ec29864d1d6::soostone::SOOSTONE>>(arg2) == arg0.pool_id, 8);
        buy_internal<T0>(arg0, arg1, arg3, spot_e9_from_sqrt(0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool::current_sqrt_price<T0, 0x46d2ff5170c0d2d82398410123b001274eb3abfa80679f892c7a1ec29864d1d6::soostone::SOOSTONE>(arg2)), arg4, 0x2::clock::timestamp_ms(arg5), arg6)
    }

    fun buy_internal<T0>(arg0: &mut Curve, arg1: &mut 0x46d2ff5170c0d2d82398410123b001274eb3abfa80679f892c7a1ec29864d1d6::soostone::Treasury, arg2: 0x2::coin::Coin<T0>, arg3: u64, arg4: u64, arg5: u64, arg6: &mut 0x2::tx_context::TxContext) : 0x2::coin::Coin<0x46d2ff5170c0d2d82398410123b001274eb3abfa80679f892c7a1ec29864d1d6::soostone::SOOSTONE> {
        assert!(!arg0.frozen, 1);
        assert!(0x2::object::id<0x46d2ff5170c0d2d82398410123b001274eb3abfa80679f892c7a1ec29864d1d6::soostone::Treasury>(arg1) == arg0.treasury_id, 9);
        let v0 = 0x2::coin::value<T0>(&arg2);
        assert!(v0 >= arg0.min_buy, 7);
        roll_day(arg0, arg3, arg5);
        let (v1, v2) = quote_price(arg0.price_e9, arg3, arg0.day_open_e9, arg0.floor_e9, arg0.ceiling_e9, arg0.anchor_bps, arg0.daily_move_bps);
        assert!(v2, 3);
        assert!(v1 <= arg4, 2);
        let v3 = arg0.day;
        let v4 = arg0.wallet_day_cap;
        let v5 = arg0.total_day_cap;
        let v6 = 0x2::tx_context::sender(arg6);
        let v7 = wallet_mut(arg0, v6, v3);
        assert!(v7.spent + v0 <= v4 + v7.allowance, 4);
        v7.spent = v7.spent + v0;
        assert!(arg0.day_total + v0 <= v5 + arg0.day_override, 5);
        arg0.day_total = arg0.day_total + v0;
        let v8 = soostone_for(v0, v1);
        assert!(v8 > 0, 11);
        assert!(arg0.sold + v8 <= arg0.budget, 6);
        arg0.sold = arg0.sold + v8;
        arg0.usdc_in = arg0.usdc_in + v0;
        arg0.purchases = arg0.purchases + 1;
        arg0.price_e9 = min(min(max(bps_of(v1, 10000 + arg0.step_bps), arg0.price_e9), bps_of(arg0.day_open_e9, 10000 + arg0.daily_move_bps)), arg0.ceiling_e9);
        let (v9, v10) = split_usdc(v0);
        0x2::transfer::public_transfer<0x2::coin::Coin<T0>>(arg2, arg0.usdc_to);
        let v11 = CurveBought{
            buyer         : v6,
            usdc          : v0,
            soostone      : v8,
            price_e9      : v1,
            spot_e9       : arg3,
            next_price_e9 : arg0.price_e9,
            to_btc        : v9,
            to_strc       : v10,
            usdc_to       : arg0.usdc_to,
            day           : v3,
            sold          : arg0.sold,
        };
        0x2::event::emit<CurveBought>(v11);
        0x46d2ff5170c0d2d82398410123b001274eb3abfa80679f892c7a1ec29864d1d6::soostone::curve_mint(arg1, v8, arg6)
    }

    public fun caps(arg0: &Curve) : (u64, u64) {
        (arg0.wallet_day_cap, arg0.total_day_cap)
    }

    public fun create<T0>(arg0: &0x46d2ff5170c0d2d82398410123b001274eb3abfa80679f892c7a1ec29864d1d6::soostone::GuardianCap, arg1: &mut 0x46d2ff5170c0d2d82398410123b001274eb3abfa80679f892c7a1ec29864d1d6::soostone::Desk, arg2: &0x46d2ff5170c0d2d82398410123b001274eb3abfa80679f892c7a1ec29864d1d6::soostone::Treasury, arg3: &0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool::Pool<T0, 0x46d2ff5170c0d2d82398410123b001274eb3abfa80679f892c7a1ec29864d1d6::soostone::SOOSTONE>, arg4: &0x2::clock::Clock, arg5: &mut 0x2::tx_context::TxContext) {
        create_internal<T0>(arg0, arg1, arg2, 0x2::object::id<0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool::Pool<T0, 0x46d2ff5170c0d2d82398410123b001274eb3abfa80679f892c7a1ec29864d1d6::soostone::SOOSTONE>>(arg3), spot_e9_from_sqrt(0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool::current_sqrt_price<T0, 0x46d2ff5170c0d2d82398410123b001274eb3abfa80679f892c7a1ec29864d1d6::soostone::SOOSTONE>(arg3)), 0x2::clock::timestamp_ms(arg4), arg5);
    }

    fun create_internal<T0>(arg0: &0x46d2ff5170c0d2d82398410123b001274eb3abfa80679f892c7a1ec29864d1d6::soostone::GuardianCap, arg1: &mut 0x46d2ff5170c0d2d82398410123b001274eb3abfa80679f892c7a1ec29864d1d6::soostone::Desk, arg2: &0x46d2ff5170c0d2d82398410123b001274eb3abfa80679f892c7a1ec29864d1d6::soostone::Treasury, arg3: 0x2::object::ID, arg4: u64, arg5: u64, arg6: &mut 0x2::tx_context::TxContext) {
        0x46d2ff5170c0d2d82398410123b001274eb3abfa80679f892c7a1ec29864d1d6::soostone::pkg_assert_87e0(arg0, arg1, arg6);
        assert!(0x46d2ff5170c0d2d82398410123b001274eb3abfa80679f892c7a1ec29864d1d6::soostone::pkg_desk_treasury(arg1) == 0x2::object::id<0x46d2ff5170c0d2d82398410123b001274eb3abfa80679f892c7a1ec29864d1d6::soostone::Treasury>(arg2), 9);
        let v0 = CurveKey{dummy_field: false};
        assert!(!0x2::dynamic_field::exists<CurveKey>(0x46d2ff5170c0d2d82398410123b001274eb3abfa80679f892c7a1ec29864d1d6::soostone::desk_uid(arg1), v0), 12);
        let v1 = min(max(bps_of(arg4, 10300), 1000000), 10000000);
        let v2 = Curve{
            id             : 0x2::object::new(arg6),
            desk_id        : 0x2::object::id<0x46d2ff5170c0d2d82398410123b001274eb3abfa80679f892c7a1ec29864d1d6::soostone::Desk>(arg1),
            treasury_id    : 0x2::object::id<0x46d2ff5170c0d2d82398410123b001274eb3abfa80679f892c7a1ec29864d1d6::soostone::Treasury>(arg2),
            pool_id        : arg3,
            usdc_type      : 0x1::type_name::with_original_ids<T0>(),
            usdc_to        : 0x2::tx_context::sender(arg6),
            price_e9       : v1,
            floor_e9       : 1000000,
            ceiling_e9     : 10000000,
            anchor_bps     : 10300,
            step_bps       : 50,
            daily_move_bps : 300,
            wallet_day_cap : 250000000,
            total_day_cap  : 1000000000,
            min_buy        : 1000000,
            budget         : 10000000000000,
            sold           : 0,
            usdc_in        : 0,
            purchases      : 0,
            day            : seam_day(arg5),
            day_open_e9    : v1,
            day_total      : 0,
            day_override   : 0,
            frozen         : false,
            wallets        : 0x2::table::new<address, WalletDay>(arg6),
        };
        let v3 = 0x2::object::id<Curve>(&v2);
        let v4 = CurveKey{dummy_field: false};
        0x2::dynamic_field::add<CurveKey, 0x2::object::ID>(0x46d2ff5170c0d2d82398410123b001274eb3abfa80679f892c7a1ec29864d1d6::soostone::desk_uid_mut(arg1), v4, v3);
        let v5 = CurveCreated{
            curve_id   : v3,
            pool_id    : arg3,
            price_e9   : v1,
            spot_e9    : arg4,
            floor_e9   : 1000000,
            ceiling_e9 : 10000000,
            budget     : 10000000000000,
        };
        0x2::event::emit<CurveCreated>(v5);
        0x2::transfer::share_object<Curve>(v2);
    }

    public fun day_state(arg0: &Curve) : (u64, u64, u64, u64) {
        (arg0.day, arg0.day_open_e9, arg0.day_total, arg0.day_override)
    }

    fun days_from_civil(arg0: u64, arg1: u64, arg2: u64) : u64 {
        let v0 = if (arg1 <= 2) {
            arg0 - 1
        } else {
            arg0
        };
        let v1 = v0 / 400;
        let v2 = v0 - v1 * 400;
        let v3 = if (arg1 > 2) {
            arg1 - 3
        } else {
            arg1 + 9
        };
        v1 * 146097 + v2 * 365 + v2 / 4 - v2 / 100 + (153 * v3 + 2) / 5 + arg2 - 1 - 719468
    }

    public fun frozen(arg0: &Curve) : bool {
        arg0.frozen
    }

    public fun grant_override(arg0: &0x46d2ff5170c0d2d82398410123b001274eb3abfa80679f892c7a1ec29864d1d6::soostone::GuardianCap, arg1: &0x46d2ff5170c0d2d82398410123b001274eb3abfa80679f892c7a1ec29864d1d6::soostone::Desk, arg2: &mut Curve, arg3: address, arg4: u64, arg5: &0x2::clock::Clock, arg6: &0x2::tx_context::TxContext) {
        assert_admin(arg0, arg1, arg2, arg6);
        let v0 = arg2.price_e9;
        roll_day(arg2, v0, 0x2::clock::timestamp_ms(arg5));
        let v1 = arg2.day;
        let v2 = wallet_mut(arg2, arg3, v1);
        v2.allowance = v2.allowance + arg4;
        arg2.day_override = arg2.day_override + arg4;
        let v3 = CurveOverride{
            wallet : arg3,
            extra  : arg4,
            day    : v1,
        };
        0x2::event::emit<CurveOverride>(v3);
    }

    public fun la_offset_hours(arg0: u64) : u64 {
        let v0 = year_of_days(arg0 / 86400000);
        if (arg0 >= nth_sunday(v0, 3, 2) * 86400000 + 10 * 3600000 && arg0 < nth_sunday(v0, 11, 1) * 86400000 + 9 * 3600000) {
            7
        } else {
            8
        }
    }

    fun max(arg0: u64, arg1: u64) : u64 {
        if (arg0 > arg1) {
            arg0
        } else {
            arg1
        }
    }

    fun min(arg0: u64, arg1: u64) : u64 {
        if (arg0 < arg1) {
            arg0
        } else {
            arg1
        }
    }

    fun nth_sunday(arg0: u64, arg1: u64, arg2: u64) : u64 {
        let v0 = days_from_civil(arg0, arg1, 1);
        v0 + (7 - (v0 + 4) % 7) % 7 + (arg2 - 1) * 7
    }

    public fun pool_id(arg0: &Curve) : 0x2::object::ID {
        arg0.pool_id
    }

    public fun price_e9(arg0: &Curve) : u64 {
        arg0.price_e9
    }

    public fun purchases(arg0: &Curve) : u64 {
        arg0.purchases
    }

    public fun quote_price(arg0: u64, arg1: u64, arg2: u64, arg3: u64, arg4: u64, arg5: u64, arg6: u64) : (u64, bool) {
        let v0 = min(min(max(max(arg0, bps_of(arg1, arg5)), arg3), bps_of(arg2, 10000 + arg6)), arg4);
        (v0, v0 >= arg1)
    }

    fun roll_day(arg0: &mut Curve, arg1: u64, arg2: u64) {
        let v0 = seam_day(arg2);
        if (v0 != arg0.day) {
            arg0.day = v0;
            arg0.day_open_e9 = min(max(max(arg0.price_e9, arg1), arg0.floor_e9), arg0.ceiling_e9);
            arg0.day_total = 0;
            arg0.day_override = 0;
        };
    }

    public fun seam_day(arg0: u64) : u64 {
        let v0 = arg0 - 6 * 3600000;
        (v0 - la_offset_hours(v0) * 3600000) / 86400000
    }

    public fun set_bounds(arg0: &0x46d2ff5170c0d2d82398410123b001274eb3abfa80679f892c7a1ec29864d1d6::soostone::GuardianCap, arg1: &0x46d2ff5170c0d2d82398410123b001274eb3abfa80679f892c7a1ec29864d1d6::soostone::Desk, arg2: &mut Curve, arg3: u64, arg4: u64, arg5: &0x2::tx_context::TxContext) {
        assert_admin(arg0, arg1, arg2, arg5);
        assert!(arg3 > 0 && arg3 <= arg4, 10);
        arg2.floor_e9 = arg3;
        arg2.ceiling_e9 = arg4;
        let v0 = CurveBoundsSet{
            floor_e9   : arg3,
            ceiling_e9 : arg4,
        };
        0x2::event::emit<CurveBoundsSet>(v0);
    }

    public fun set_caps(arg0: &0x46d2ff5170c0d2d82398410123b001274eb3abfa80679f892c7a1ec29864d1d6::soostone::GuardianCap, arg1: &0x46d2ff5170c0d2d82398410123b001274eb3abfa80679f892c7a1ec29864d1d6::soostone::Desk, arg2: &mut Curve, arg3: u64, arg4: u64, arg5: &0x2::tx_context::TxContext) {
        assert_admin(arg0, arg1, arg2, arg5);
        assert!(arg3 > 0 && arg3 <= arg4, 14);
        arg2.wallet_day_cap = arg3;
        arg2.total_day_cap = arg4;
        let v0 = CurveCapsSet{
            wallet_day_cap : arg3,
            total_day_cap  : arg4,
        };
        0x2::event::emit<CurveCapsSet>(v0);
    }

    public fun set_frozen(arg0: &0x46d2ff5170c0d2d82398410123b001274eb3abfa80679f892c7a1ec29864d1d6::soostone::GuardianCap, arg1: &0x46d2ff5170c0d2d82398410123b001274eb3abfa80679f892c7a1ec29864d1d6::soostone::Desk, arg2: &mut Curve, arg3: bool, arg4: &0x2::tx_context::TxContext) {
        assert_admin(arg0, arg1, arg2, arg4);
        arg2.frozen = arg3;
        let v0 = CurveFrozen{frozen: arg3};
        0x2::event::emit<CurveFrozen>(v0);
    }

    public fun soostone_for(arg0: u64, arg1: u64) : u64 {
        (((arg0 as u128) * 1000000000 / (arg1 as u128)) as u64)
    }

    public fun split_usdc(arg0: u64) : (u64, u64) {
        let v0 = bps_of(arg0, 3820);
        (v0, arg0 - v0)
    }

    public fun spot_e9_from_sqrt(arg0: u128) : u64 {
        let v0 = (arg0 as u256) * (arg0 as u256);
        if (v0 == 0) {
            return 0
        };
        ((((1000000000 as u256) << 128) / v0) as u64)
    }

    public fun step_bps(arg0: &Curve) : u64 {
        if (arg0.frozen) {
            0
        } else {
            arg0.step_bps
        }
    }

    public fun supply(arg0: &Curve) : (u64, u64) {
        (arg0.sold, arg0.budget)
    }

    public fun usdc_in(arg0: &Curve) : u64 {
        arg0.usdc_in
    }

    public fun usdc_to(arg0: &Curve) : address {
        arg0.usdc_to
    }

    fun wallet_mut(arg0: &mut Curve, arg1: address, arg2: u64) : &mut WalletDay {
        if (!0x2::table::contains<address, WalletDay>(&arg0.wallets, arg1)) {
            let v0 = WalletDay{
                day       : arg2,
                spent     : 0,
                allowance : 0,
            };
            0x2::table::add<address, WalletDay>(&mut arg0.wallets, arg1, v0);
        };
        let v1 = 0x2::table::borrow_mut<address, WalletDay>(&mut arg0.wallets, arg1);
        if (v1.day != arg2) {
            v1.day = arg2;
            v1.spent = 0;
            v1.allowance = 0;
        };
        v1
    }

    public fun wallet_spent(arg0: &Curve, arg1: address, arg2: u64) : u64 {
        if (!0x2::table::contains<address, WalletDay>(&arg0.wallets, arg1)) {
            return 0
        };
        let v0 = 0x2::table::borrow<address, WalletDay>(&arg0.wallets, arg1);
        if (v0.day == seam_day(arg2)) {
            v0.spent
        } else {
            0
        }
    }

    fun year_of_days(arg0: u64) : u64 {
        let v0 = arg0 + 719468;
        let v1 = v0 / 146097;
        let v2 = v0 - v1 * 146097;
        let v3 = (v2 - v2 / 1460 + v2 / 36524 - v2 / 146096) / 365;
        let v4 = (5 * (v2 - 365 * v3 + v3 / 4 - v3 / 100) + 2) / 153;
        let v5 = if (v4 < 10) {
            v4 + 3
        } else {
            v4 - 9
        };
        let v6 = if (v5 <= 2) {
            1
        } else {
            0
        };
        v3 + v1 * 400 + v6
    }

    // decompiled from Move bytecode v7
}

