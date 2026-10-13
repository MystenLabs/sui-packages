module 0x12a03cef78d4a96916e7958f91d103ae4fee70169fce99539f843567f5426b74::market {
    struct XAuth has drop {
        dummy_field: bool,
    }

    struct Settings has copy, drop, store {
        buys_enabled: bool,
        buy_fee_bps: u64,
        sell_fee_bps: u64,
        custody_owner: address,
        custody_usdc: address,
        mint: address,
        report_max_age_ms: u64,
        grace_ms: u64,
        max_deadline_ms: u64,
        max_fill_bps: u64,
        gain_bps: u64,
    }

    struct Pending has copy, drop, store {
        settings: Settings,
        effective_ms: u64,
    }

    struct BuyOrder has drop, store {
        user: address,
        net: u64,
        fee: u64,
        min_shares: u64,
        deadline_ms: u64,
        created_ms: u64,
        state: u8,
        shares: u64,
    }

    struct Report has copy, drop, store {
        raw: u64,
        multiplier: u128,
        shares: u64,
        usdc: u64,
        received: u64,
        returned: u64,
        slot: u64,
        ms: u64,
    }

    struct Payout has drop, store {
        user: address,
        amount: u64,
        order: u64,
        sale: bool,
    }

    struct Market<phantom T0, phantom T1> has key {
        id: 0x2::object::UID,
        config: 0x2::object::ID,
        treasury: 0x2::coin::TreasuryCap<T0>,
        settings: Settings,
        pending: 0x1::option::Option<Pending>,
        blocked: bool,
        next_order: u64,
        buys: 0x2::table::Table<u64, BuyOrder>,
        sells: 0x2::table::Table<u64, SellBook<T0>>,
        locked: u64,
        pending_max: u64,
        report: Report,
        base: u64,
        gain_day: u64,
        gain_used: u64,
        fees: 0x2::balance::Balance<T1>,
        fees_pending: u64,
        fees_due: u64,
        cash: 0x2::balance::Balance<T1>,
        payouts: 0x2::table::Table<u64, Payout>,
        pay_head: u64,
        pay_tail: u64,
        due: u64,
        sent: u64,
    }

    struct SellBook<phantom T0> has store {
        user: address,
        coins: 0x2::balance::Balance<T0>,
        min_usdc: u64,
        deadline_ms: u64,
        created_ms: u64,
        state: u8,
    }

    struct MarketCreated has copy, drop {
        schema: u8,
        market: 0x2::object::ID,
        settings: Settings,
    }

    struct BuyOrdered has copy, drop {
        schema: u8,
        market: 0x2::object::ID,
        order: u64,
        user: address,
        paid: u64,
        fee: u64,
        net: u64,
        min_shares: u64,
        deadline_ms: u64,
        hook_data: vector<u8>,
    }

    struct BuyFilled has copy, drop {
        schema: u8,
        market: 0x2::object::ID,
        order: u64,
        user: address,
        shares: u64,
        min_shares: u64,
        solana_tx: vector<u8>,
        slot: u64,
    }

    struct BuyRefunded has copy, drop {
        schema: u8,
        market: 0x2::object::ID,
        order: u64,
        user: address,
        amount: u64,
        fee: u64,
        nonce: u256,
    }

    struct BuyStuck has copy, drop {
        schema: u8,
        market: 0x2::object::ID,
        order: u64,
        user: address,
    }

    struct SellOrdered has copy, drop {
        schema: u8,
        market: 0x2::object::ID,
        order: u64,
        user: address,
        coins: u64,
        min_usdc: u64,
        deadline_ms: u64,
    }

    struct SellCompleted has copy, drop {
        schema: u8,
        market: 0x2::object::ID,
        order: u64,
        user: address,
        coins: u64,
        proceeds: u64,
        fee: u64,
        paid: u64,
        below_min: bool,
        nonce: u256,
    }

    struct SellCancelled has copy, drop {
        schema: u8,
        market: 0x2::object::ID,
        order: u64,
        user: address,
        coins: u64,
        by_user: bool,
    }

    struct Reported has copy, drop {
        schema: u8,
        market: 0x2::object::ID,
        wallet: address,
        mint: address,
        report: Report,
        outstanding: u64,
        pending_max: u64,
    }

    struct Shortfall has copy, drop {
        schema: u8,
        market: 0x2::object::ID,
        shares: u64,
        outstanding: u64,
    }

    struct Paid has copy, drop {
        schema: u8,
        market: 0x2::object::ID,
        order: u64,
        user: address,
        amount: u64,
        sale: bool,
        left: u64,
    }

    struct Arrived has copy, drop {
        schema: u8,
        market: 0x2::object::ID,
        amount: u64,
        cash: u64,
        due: u64,
    }

    struct FeesCollected has copy, drop {
        schema: u8,
        market: 0x2::object::ID,
        amount: u64,
        to: address,
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

    struct Unblocked has copy, drop {
        schema: u8,
        market: 0x2::object::ID,
    }

    fun new<T0, T1>(arg0: &0x12a03cef78d4a96916e7958f91d103ae4fee70169fce99539f843567f5426b74::config::Config, arg1: 0x2::coin::TreasuryCap<T0>, arg2: u8, arg3: Settings, arg4: u64, arg5: &mut 0x2::tx_context::TxContext) : Market<T0, T1> {
        assert!(0x2::coin::total_supply<T0>(&arg1) == 0 && arg2 == 8, 19);
        validate(&arg3);
        let v0 = Report{
            raw        : 0,
            multiplier : (1000000000000000000 as u128),
            shares     : 0,
            usdc       : 0,
            received   : 0,
            returned   : 0,
            slot       : 0,
            ms         : arg4,
        };
        let v1 = Market<T0, T1>{
            id           : 0x2::object::new(arg5),
            config       : 0x12a03cef78d4a96916e7958f91d103ae4fee70169fce99539f843567f5426b74::config::id(arg0),
            treasury     : arg1,
            settings     : arg3,
            pending      : 0x1::option::none<Pending>(),
            blocked      : false,
            next_order   : 0,
            buys         : 0x2::table::new<u64, BuyOrder>(arg5),
            sells        : 0x2::table::new<u64, SellBook<T0>>(arg5),
            locked       : 0,
            pending_max  : 0,
            report       : v0,
            base         : 0,
            gain_day     : arg4 / 86400000,
            gain_used    : 0,
            fees         : 0x2::balance::zero<T1>(),
            fees_pending : 0,
            fees_due     : 0,
            cash         : 0x2::balance::zero<T1>(),
            payouts      : 0x2::table::new<u64, Payout>(arg5),
            pay_head     : 0,
            pay_tail     : 0,
            due          : 0,
            sent         : 0,
        };
        let v2 = MarketCreated{
            schema   : 0x12a03cef78d4a96916e7958f91d103ae4fee70169fce99539f843567f5426b74::config::schema(),
            market   : 0x2::object::id<Market<T0, T1>>(&v1),
            settings : arg3,
        };
        0x2::event::emit<MarketCreated>(v2);
        v1
    }

    public fun apply_settings<T0, T1>(arg0: &mut Market<T0, T1>, arg1: &0x12a03cef78d4a96916e7958f91d103ae4fee70169fce99539f843567f5426b74::config::Config, arg2: &0x2::clock::Clock) {
        check<T0, T1>(arg0, arg1);
        assert!(0x1::option::is_some<Pending>(&arg0.pending), 17);
        let Pending {
            settings     : v0,
            effective_ms : v1,
        } = 0x1::option::extract<Pending>(&mut arg0.pending);
        assert!(0x2::clock::timestamp_ms(arg2) >= v1, 18);
        arg0.settings = v0;
        let v2 = SettingsChanged{
            schema   : 0x12a03cef78d4a96916e7958f91d103ae4fee70169fce99539f843567f5426b74::config::schema(),
            market   : 0x2::object::id<Market<T0, T1>>(arg0),
            settings : v0,
        };
        0x2::event::emit<SettingsChanged>(v2);
    }

    public fun blocked<T0, T1>(arg0: &Market<T0, T1>) : bool {
        arg0.blocked
    }

    public fun buy_info<T0, T1>(arg0: &Market<T0, T1>, arg1: u64) : (address, u64, u64, u64, u64, u8, u64) {
        let v0 = 0x2::table::borrow<u64, BuyOrder>(&arg0.buys, arg1);
        (v0.user, v0.net, v0.fee, v0.min_shares, v0.deadline_ms, v0.state, v0.shares)
    }

    public fun buy_order<T0, T1: drop>(arg0: &mut Market<T0, T1>, arg1: &0x12a03cef78d4a96916e7958f91d103ae4fee70169fce99539f843567f5426b74::config::Config, arg2: 0x2::coin::Coin<T1>, arg3: u64, arg4: u64, arg5: &0x2::clock::Clock, arg6: &mut 0x2::tx_context::TxContext) : (0xeb14978abfe93a37c5d5bf86a0623b923553a5f0e794daac7724f1e2fdbfb830::deposit_for_burn::DepositForBurnWithPackageAuthTicket<T1, XAuth>, u64) {
        check<T0, T1>(arg0, arg1);
        let (v0, v1, v2, v3) = place_buy<T0, T1>(arg0, arg1, arg2, arg3, arg4, 0x2::clock::timestamp_ms(arg5), arg6);
        let v4 = XAuth{dummy_field: false};
        (0xeb14978abfe93a37c5d5bf86a0623b923553a5f0e794daac7724f1e2fdbfb830::deposit_for_burn::create_deposit_for_burn_with_package_auth_ticket<T1, XAuth>(v0, 5, v1, @0x0, 0, 2000, v2, v4), v3)
    }

    fun cancel<T0, T1>(arg0: &mut Market<T0, T1>, arg1: u64, arg2: bool, arg3: &mut 0x2::tx_context::TxContext) {
        assert!(0x2::table::contains<u64, SellBook<T0>>(&arg0.sells, arg1), 7);
        let v0 = 0x2::table::borrow_mut<u64, SellBook<T0>>(&mut arg0.sells, arg1);
        assert!(v0.state == 0, 8);
        v0.state = 2;
        let v1 = 0x2::balance::value<T0>(&v0.coins);
        let v2 = v0.user;
        let v3 = 0x2::coin::from_balance<T0>(0x2::balance::withdraw_all<T0>(&mut v0.coins), arg3);
        arg0.locked = arg0.locked - v1;
        let v4 = SellCancelled{
            schema  : 0x12a03cef78d4a96916e7958f91d103ae4fee70169fce99539f843567f5426b74::config::schema(),
            market  : 0x2::object::id<Market<T0, T1>>(arg0),
            order   : arg1,
            user    : v2,
            coins   : v1,
            by_user : arg2,
        };
        0x2::event::emit<SellCancelled>(v4);
        0x2::transfer::public_transfer<0x2::coin::Coin<T0>>(v3, v2);
    }

    public fun cancel_sell<T0, T1>(arg0: &mut Market<T0, T1>, arg1: &0x12a03cef78d4a96916e7958f91d103ae4fee70169fce99539f843567f5426b74::config::Config, arg2: u64, arg3: &mut 0x2::tx_context::TxContext) {
        check<T0, T1>(arg0, arg1);
        0x12a03cef78d4a96916e7958f91d103ae4fee70169fce99539f843567f5426b74::config::assert_keeper(arg1, arg3);
        cancel<T0, T1>(arg0, arg2, false, arg3);
        assert!(outstanding<T0, T1>(arg0) <= arg0.report.shares, 11);
    }

    public fun cancel_stuck_sell<T0, T1>(arg0: &mut Market<T0, T1>, arg1: u64, arg2: &0x2::clock::Clock, arg3: &mut 0x2::tx_context::TxContext) {
        assert!(0x2::table::contains<u64, SellBook<T0>>(&arg0.sells, arg1), 7);
        let v0 = 0x2::table::borrow<u64, SellBook<T0>>(&arg0.sells, arg1);
        assert!(v0.user == 0x2::tx_context::sender(arg3), 15);
        assert!(0x2::clock::timestamp_ms(arg2) > v0.deadline_ms + arg0.settings.grace_ms, 16);
        cancel<T0, T1>(arg0, arg1, true, arg3);
    }

    fun check<T0, T1>(arg0: &Market<T0, T1>, arg1: &0x12a03cef78d4a96916e7958f91d103ae4fee70169fce99539f843567f5426b74::config::Config) {
        0x12a03cef78d4a96916e7958f91d103ae4fee70169fce99539f843567f5426b74::config::assert_version(arg1);
        assert!(arg0.config == 0x12a03cef78d4a96916e7958f91d103ae4fee70169fce99539f843567f5426b74::config::id(arg1), 1);
    }

    public fun collect_fees<T0, T1>(arg0: &mut Market<T0, T1>, arg1: &0x12a03cef78d4a96916e7958f91d103ae4fee70169fce99539f843567f5426b74::config::Config, arg2: &mut 0x2::tx_context::TxContext) : u64 {
        check<T0, T1>(arg0, arg1);
        let v0 = sat_sub(0x2::balance::value<T1>(&arg0.fees), arg0.fees_pending);
        if (v0 > 0) {
            let v1 = 0x12a03cef78d4a96916e7958f91d103ae4fee70169fce99539f843567f5426b74::config::fee_recipient(arg1);
            0x2::transfer::public_transfer<0x2::coin::Coin<T1>>(0x2::coin::from_balance<T1>(0x2::balance::split<T1>(&mut arg0.fees, v0), arg2), v1);
            let v2 = FeesCollected{
                schema : 0x12a03cef78d4a96916e7958f91d103ae4fee70169fce99539f843567f5426b74::config::schema(),
                market : 0x2::object::id<Market<T0, T1>>(arg0),
                amount : v0,
                to     : v1,
            };
            0x2::event::emit<FeesCollected>(v2);
        };
        v0
    }

    public fun collect_surplus<T0, T1>(arg0: &0x12a03cef78d4a96916e7958f91d103ae4fee70169fce99539f843567f5426b74::config::AdminCap, arg1: &mut Market<T0, T1>, arg2: &0x12a03cef78d4a96916e7958f91d103ae4fee70169fce99539f843567f5426b74::config::Config, arg3: &mut 0x2::tx_context::TxContext) : u64 {
        check<T0, T1>(arg1, arg2);
        let v0 = sat_sub(0x2::balance::value<T1>(&arg1.cash), arg1.due);
        if (v0 > 0) {
            let v1 = 0x12a03cef78d4a96916e7958f91d103ae4fee70169fce99539f843567f5426b74::config::fee_recipient(arg2);
            0x2::transfer::public_transfer<0x2::coin::Coin<T1>>(0x2::coin::from_balance<T1>(0x2::balance::split<T1>(&mut arg1.cash, v0), arg3), v1);
            let v2 = FeesCollected{
                schema : 0x12a03cef78d4a96916e7958f91d103ae4fee70169fce99539f843567f5426b74::config::schema(),
                market : 0x2::object::id<Market<T0, T1>>(arg1),
                amount : v0,
                to     : v1,
            };
            0x2::event::emit<FeesCollected>(v2);
        };
        v0
    }

    public fun complete_sell<T0, T1>(arg0: &mut Market<T0, T1>, arg1: &0x12a03cef78d4a96916e7958f91d103ae4fee70169fce99539f843567f5426b74::config::Config, arg2: &0x16bcfcfc465f96281663a344641c017de84529370e11aa3879d0dce43ad6db87::receive_message::Receipt) {
        check<T0, T1>(arg0, arg1);
        complete_with<T0, T1>(arg0, 0x16bcfcfc465f96281663a344641c017de84529370e11aa3879d0dce43ad6db87::receive_message::source_domain(arg2), 0x16bcfcfc465f96281663a344641c017de84529370e11aa3879d0dce43ad6db87::receive_message::sender(arg2), *0x16bcfcfc465f96281663a344641c017de84529370e11aa3879d0dce43ad6db87::receive_message::message_body(arg2), 0x16bcfcfc465f96281663a344641c017de84529370e11aa3879d0dce43ad6db87::receive_message::nonce(arg2));
    }

    public(friend) fun complete_with<T0, T1>(arg0: &mut Market<T0, T1>, arg1: u32, arg2: address, arg3: vector<u8>, arg4: u256) {
        let (v0, v1, v2) = verify_home<T0, T1>(arg0, arg1, arg2, &arg3);
        assert!(v1 == 0x12a03cef78d4a96916e7958f91d103ae4fee70169fce99539f843567f5426b74::message::kind_sale(), 14);
        assert!(0x2::table::contains<u64, SellBook<T0>>(&arg0.sells, v2), 7);
        let v3 = 0x2::table::borrow_mut<u64, SellBook<T0>>(&mut arg0.sells, v2);
        assert!(v3.state == 0, 8);
        v3.state = 1;
        let v4 = 0x2::balance::value<T0>(&v3.coins);
        let v5 = v3.user;
        let v6 = v3.min_usdc;
        arg0.locked = arg0.locked - v4;
        0x2::balance::decrease_supply<T0>(0x2::coin::supply_mut<T0>(&mut arg0.treasury), 0x2::balance::withdraw_all<T0>(&mut v3.coins));
        let v7 = share_up(v0, arg0.settings.sell_fee_bps);
        let v8 = v0 - v7;
        arg0.fees_due = arg0.fees_due + v7;
        queue<T0, T1>(arg0, v5, v8, v2, true);
        let v9 = SellCompleted{
            schema    : 0x12a03cef78d4a96916e7958f91d103ae4fee70169fce99539f843567f5426b74::config::schema(),
            market    : 0x2::object::id<Market<T0, T1>>(arg0),
            order     : v2,
            user      : v5,
            coins     : v4,
            proceeds  : v0,
            fee       : v7,
            paid      : v8,
            below_min : v8 < v6,
            nonce     : arg4,
        };
        0x2::event::emit<SellCompleted>(v9);
    }

    public fun create<T0, T1>(arg0: &0x12a03cef78d4a96916e7958f91d103ae4fee70169fce99539f843567f5426b74::config::AdminCap, arg1: &0x12a03cef78d4a96916e7958f91d103ae4fee70169fce99539f843567f5426b74::config::Config, arg2: 0x2::coin::TreasuryCap<T0>, arg3: u8, arg4: Settings, arg5: &0x2::clock::Clock, arg6: &mut 0x2::tx_context::TxContext) : 0x2::object::ID {
        0x12a03cef78d4a96916e7958f91d103ae4fee70169fce99539f843567f5426b74::config::assert_version(arg1);
        let v0 = new<T0, T1>(arg1, arg2, arg3, arg4, 0x2::clock::timestamp_ms(arg5), arg6);
        0x2::transfer::share_object<Market<T0, T1>>(v0);
        0x2::object::id<Market<T0, T1>>(&v0)
    }

    public fun custody(arg0: &Settings) : (address, address, address) {
        (arg0.custody_owner, arg0.custody_usdc, arg0.mint)
    }

    public fun fees_bps(arg0: &Settings) : (u64, u64) {
        (arg0.buy_fee_bps, arg0.sell_fee_bps)
    }

    public(friend) fun fill<T0, T1>(arg0: &mut Market<T0, T1>, arg1: u64, arg2: u64, arg3: vector<u8>, arg4: u64, arg5: u64, arg6: &mut 0x2::tx_context::TxContext) {
        assert!(0x2::table::contains<u64, BuyOrder>(&arg0.buys, arg1), 7);
        assert!(arg5 <= arg0.report.ms + arg0.settings.report_max_age_ms, 4);
        let v0 = 0x2::table::borrow_mut<u64, BuyOrder>(&mut arg0.buys, arg1);
        assert!(v0.state == 0 || v0.state == 3, 8);
        assert!(arg2 >= v0.min_shares, 9);
        assert!((arg2 as u256) * (10000 as u256) <= (v0.min_shares as u256) * ((10000 + arg0.settings.max_fill_bps) as u256), 10);
        v0.state = 1;
        v0.shares = arg2;
        let v1 = v0.user;
        let v2 = v0.min_shares;
        arg0.fees_pending = arg0.fees_pending - v0.fee;
        arg0.pending_max = sat_sub(arg0.pending_max, max_fill<T0, T1>(arg0, v2));
        assert!(outstanding<T0, T1>(arg0) <= arg0.report.shares, 11);
        let v3 = BuyFilled{
            schema     : 0x12a03cef78d4a96916e7958f91d103ae4fee70169fce99539f843567f5426b74::config::schema(),
            market     : 0x2::object::id<Market<T0, T1>>(arg0),
            order      : arg1,
            user       : v1,
            shares     : arg2,
            min_shares : v2,
            solana_tx  : arg3,
            slot       : arg4,
        };
        0x2::event::emit<BuyFilled>(v3);
        0x2::transfer::public_transfer<0x2::coin::Coin<T0>>(0x2::coin::mint<T0>(&mut arg0.treasury, arg2, arg6), v1);
    }

    public fun fill_order<T0, T1>(arg0: &mut Market<T0, T1>, arg1: &0x12a03cef78d4a96916e7958f91d103ae4fee70169fce99539f843567f5426b74::config::Config, arg2: u64, arg3: u64, arg4: vector<u8>, arg5: u64, arg6: &0x2::clock::Clock, arg7: &mut 0x2::tx_context::TxContext) {
        check<T0, T1>(arg0, arg1);
        0x12a03cef78d4a96916e7958f91d103ae4fee70169fce99539f843567f5426b74::config::assert_keeper(arg1, arg7);
        fill<T0, T1>(arg0, arg2, arg3, arg4, arg5, 0x2::clock::timestamp_ms(arg6), arg7);
    }

    public fun last_report<T0, T1>(arg0: &Market<T0, T1>) : Report {
        arg0.report
    }

    public fun locked<T0, T1>(arg0: &Market<T0, T1>) : u64 {
        arg0.locked
    }

    public fun loosens(arg0: &Settings, arg1: &Settings) : bool {
        if (arg1.buy_fee_bps > arg0.buy_fee_bps) {
            true
        } else if (arg1.sell_fee_bps > arg0.sell_fee_bps) {
            true
        } else if (arg1.custody_owner != arg0.custody_owner) {
            true
        } else if (arg1.custody_usdc != arg0.custody_usdc) {
            true
        } else if (arg1.mint != arg0.mint) {
            true
        } else if (arg1.report_max_age_ms > arg0.report_max_age_ms) {
            true
        } else if (arg1.grace_ms > arg0.grace_ms) {
            true
        } else if (arg1.max_fill_bps > arg0.max_fill_bps) {
            true
        } else {
            arg1.gain_bps > arg0.gain_bps
        }
    }

    public fun mark_stuck<T0, T1>(arg0: &mut Market<T0, T1>, arg1: u64, arg2: &0x2::clock::Clock, arg3: &0x2::tx_context::TxContext) {
        assert!(0x2::table::contains<u64, BuyOrder>(&arg0.buys, arg1), 7);
        let v0 = 0x2::table::borrow_mut<u64, BuyOrder>(&mut arg0.buys, arg1);
        assert!(v0.user == 0x2::tx_context::sender(arg3), 15);
        assert!(v0.state == 0, 8);
        assert!(0x2::clock::timestamp_ms(arg2) > v0.deadline_ms + arg0.settings.grace_ms, 16);
        v0.state = 3;
        let v1 = BuyStuck{
            schema : 0x12a03cef78d4a96916e7958f91d103ae4fee70169fce99539f843567f5426b74::config::schema(),
            market : 0x2::object::id<Market<T0, T1>>(arg0),
            order  : arg1,
            user   : v0.user,
        };
        0x2::event::emit<BuyStuck>(v1);
    }

    fun max_fill<T0, T1>(arg0: &Market<T0, T1>, arg1: u64) : u64 {
        (((arg1 as u256) * ((10000 + arg0.settings.max_fill_bps) as u256) / (10000 as u256)) as u64)
    }

    public fun money<T0, T1>(arg0: &Market<T0, T1>) : (u64, u64, u64, u64, u64) {
        (0x2::balance::value<T1>(&arg0.fees), arg0.fees_pending, arg0.fees_due, 0x2::balance::value<T1>(&arg0.cash), arg0.due)
    }

    public fun new_settings(arg0: bool, arg1: u64, arg2: u64, arg3: address, arg4: address, arg5: address, arg6: u64, arg7: u64, arg8: u64, arg9: u64, arg10: u64) : Settings {
        let v0 = Settings{
            buys_enabled      : arg0,
            buy_fee_bps       : arg1,
            sell_fee_bps      : arg2,
            custody_owner     : arg3,
            custody_usdc      : arg4,
            mint              : arg5,
            report_max_age_ms : arg6,
            grace_ms          : arg7,
            max_deadline_ms   : arg8,
            max_fill_bps      : arg9,
            gain_bps          : arg10,
        };
        validate(&v0);
        v0
    }

    public fun outstanding<T0, T1>(arg0: &Market<T0, T1>) : u64 {
        0x2::coin::total_supply<T0>(&arg0.treasury) - arg0.locked
    }

    public fun pay<T0, T1>(arg0: &mut Market<T0, T1>, arg1: u64, arg2: &mut 0x2::tx_context::TxContext) : u64 {
        let v0 = 0;
        let v1 = 0;
        while (v1 < arg1 && arg0.pay_head < arg0.pay_tail) {
            let v2 = arg0.pay_head;
            let v3 = 0x2::balance::value<T1>(&arg0.cash);
            if (v3 == 0) {
                break
            };
            let v4 = 0x2::table::borrow_mut<u64, Payout>(&mut arg0.payouts, v2);
            let v5 = 0x1::u64::min(v4.amount, v3);
            v4.amount = v4.amount - v5;
            let v6 = v4.user;
            let v7 = v4.amount;
            if (v7 == 0) {
                0x2::table::remove<u64, Payout>(&mut arg0.payouts, v2);
                arg0.pay_head = v2 + 1;
            };
            arg0.due = arg0.due - v5;
            0x2::transfer::public_transfer<0x2::coin::Coin<T1>>(0x2::coin::from_balance<T1>(0x2::balance::split<T1>(&mut arg0.cash, v5), arg2), v6);
            v0 = v0 + v5;
            let v8 = Paid{
                schema : 0x12a03cef78d4a96916e7958f91d103ae4fee70169fce99539f843567f5426b74::config::schema(),
                market : 0x2::object::id<Market<T0, T1>>(arg0),
                order  : v4.order,
                user   : v6,
                amount : v5,
                sale   : v4.sale,
                left   : v7,
            };
            0x2::event::emit<Paid>(v8);
            if (v7 > 0) {
                break
            };
            v1 = v1 + 1;
        };
        v0
    }

    public fun pending_max<T0, T1>(arg0: &Market<T0, T1>) : u64 {
        arg0.pending_max
    }

    public(friend) fun place_buy<T0, T1>(arg0: &mut Market<T0, T1>, arg1: &0x12a03cef78d4a96916e7958f91d103ae4fee70169fce99539f843567f5426b74::config::Config, arg2: 0x2::coin::Coin<T1>, arg3: u64, arg4: u64, arg5: u64, arg6: &mut 0x2::tx_context::TxContext) : (0x2::coin::Coin<T1>, address, vector<u8>, u64) {
        let v0 = if (arg0.settings.buys_enabled) {
            if (!0x12a03cef78d4a96916e7958f91d103ae4fee70169fce99539f843567f5426b74::config::paused(arg1)) {
                !arg0.blocked
            } else {
                false
            }
        } else {
            false
        };
        assert!(v0, 3);
        assert!(arg5 <= arg0.report.ms + arg0.settings.report_max_age_ms, 4);
        assert!(arg4 > arg5 && arg4 <= arg5 + arg0.settings.max_deadline_ms, 5);
        assert!(arg3 > 0, 6);
        let v1 = 0x2::coin::value<T1>(&arg2);
        let v2 = share_up(v1, arg0.settings.buy_fee_bps);
        assert!(v1 > v2, 6);
        0x2::balance::join<T1>(&mut arg0.fees, 0x2::coin::into_balance<T1>(0x2::coin::split<T1>(&mut arg2, v2, arg6)));
        arg0.fees_pending = arg0.fees_pending + v2;
        let v3 = v1 - v2;
        let v4 = arg0.next_order;
        arg0.next_order = v4 + 1;
        let v5 = 0x2::tx_context::sender(arg6);
        let v6 = BuyOrder{
            user        : v5,
            net         : v3,
            fee         : v2,
            min_shares  : arg3,
            deadline_ms : arg4,
            created_ms  : arg5,
            state       : 0,
            shares      : 0,
        };
        0x2::table::add<u64, BuyOrder>(&mut arg0.buys, v4, v6);
        arg0.pending_max = arg0.pending_max + max_fill<T0, T1>(arg0, arg3);
        arg0.sent = arg0.sent + v3;
        let v7 = 0x2::object::id<Market<T0, T1>>(arg0);
        let v8 = 0x12a03cef78d4a96916e7958f91d103ae4fee70169fce99539f843567f5426b74::message::buy_hook(v4, 0x2::object::id_to_address(&v7), arg0.settings.mint, arg3, v5, arg4);
        let v9 = BuyOrdered{
            schema      : 0x12a03cef78d4a96916e7958f91d103ae4fee70169fce99539f843567f5426b74::config::schema(),
            market      : 0x2::object::id<Market<T0, T1>>(arg0),
            order       : v4,
            user        : v5,
            paid        : v1,
            fee         : v2,
            net         : v3,
            min_shares  : arg3,
            deadline_ms : arg4,
            hook_data   : v8,
        };
        0x2::event::emit<BuyOrdered>(v9);
        (arg2, arg0.settings.custody_usdc, v8, v4)
    }

    fun queue<T0, T1>(arg0: &mut Market<T0, T1>, arg1: address, arg2: u64, arg3: u64, arg4: bool) {
        let v0 = arg0.pay_tail;
        let v1 = Payout{
            user   : arg1,
            amount : arg2,
            order  : arg3,
            sale   : arg4,
        };
        0x2::table::add<u64, Payout>(&mut arg0.payouts, v0, v1);
        arg0.pay_tail = v0 + 1;
        arg0.due = arg0.due + arg2;
    }

    public fun refund_order<T0, T1>(arg0: &mut Market<T0, T1>, arg1: &0x12a03cef78d4a96916e7958f91d103ae4fee70169fce99539f843567f5426b74::config::Config, arg2: &0x16bcfcfc465f96281663a344641c017de84529370e11aa3879d0dce43ad6db87::receive_message::Receipt) {
        check<T0, T1>(arg0, arg1);
        refund_with<T0, T1>(arg0, 0x16bcfcfc465f96281663a344641c017de84529370e11aa3879d0dce43ad6db87::receive_message::source_domain(arg2), 0x16bcfcfc465f96281663a344641c017de84529370e11aa3879d0dce43ad6db87::receive_message::sender(arg2), *0x16bcfcfc465f96281663a344641c017de84529370e11aa3879d0dce43ad6db87::receive_message::message_body(arg2), 0x16bcfcfc465f96281663a344641c017de84529370e11aa3879d0dce43ad6db87::receive_message::nonce(arg2));
    }

    public(friend) fun refund_with<T0, T1>(arg0: &mut Market<T0, T1>, arg1: u32, arg2: address, arg3: vector<u8>, arg4: u256) {
        let (v0, v1, v2) = verify_home<T0, T1>(arg0, arg1, arg2, &arg3);
        assert!(v1 == 0x12a03cef78d4a96916e7958f91d103ae4fee70169fce99539f843567f5426b74::message::kind_refund(), 14);
        assert!(0x2::table::contains<u64, BuyOrder>(&arg0.buys, v2), 7);
        let v3 = 0x2::table::borrow_mut<u64, BuyOrder>(&mut arg0.buys, v2);
        assert!(v3.state == 0 || v3.state == 3, 8);
        v3.state = 2;
        let v4 = v3.user;
        let v5 = v3.fee;
        arg0.fees_pending = arg0.fees_pending - v5;
        arg0.pending_max = sat_sub(arg0.pending_max, max_fill<T0, T1>(arg0, v3.min_shares));
        0x2::balance::join<T1>(&mut arg0.cash, 0x2::balance::split<T1>(&mut arg0.fees, v5));
        queue<T0, T1>(arg0, v4, v0 + v5, v2, false);
        let v6 = BuyRefunded{
            schema : 0x12a03cef78d4a96916e7958f91d103ae4fee70169fce99539f843567f5426b74::config::schema(),
            market : 0x2::object::id<Market<T0, T1>>(arg0),
            order  : v2,
            user   : v4,
            amount : v0,
            fee    : v5,
            nonce  : arg4,
        };
        0x2::event::emit<BuyRefunded>(v6);
    }

    public fun report<T0, T1>(arg0: &mut Market<T0, T1>, arg1: &0x12a03cef78d4a96916e7958f91d103ae4fee70169fce99539f843567f5426b74::config::Config, arg2: u64, arg3: u128, arg4: u64, arg5: u64, arg6: u64, arg7: u64, arg8: &0x2::clock::Clock, arg9: &0x2::tx_context::TxContext) {
        check<T0, T1>(arg0, arg1);
        0x12a03cef78d4a96916e7958f91d103ae4fee70169fce99539f843567f5426b74::config::assert_keeper(arg1, arg9);
        report_at<T0, T1>(arg0, arg2, arg3, arg4, arg5, arg6, arg7, 0x2::clock::timestamp_ms(arg8));
    }

    public(friend) fun report_at<T0, T1>(arg0: &mut Market<T0, T1>, arg1: u64, arg2: u128, arg3: u64, arg4: u64, arg5: u64, arg6: u64, arg7: u64) {
        let v0 = &arg0.report;
        let v1 = if (arg2 > 0) {
            if (arg6 >= v0.slot) {
                if (arg4 >= v0.received) {
                    if (arg5 >= v0.returned) {
                        arg4 <= arg0.sent
                    } else {
                        false
                    }
                } else {
                    false
                }
            } else {
                false
            }
        } else {
            false
        };
        assert!(v1, 12);
        let v2 = (arg1 as u256) * (arg2 as u256) / 1000000000000000000;
        assert!(v2 <= 18446744073709551615, 12);
        let v3 = (v2 as u64);
        let v4 = outstanding<T0, T1>(arg0);
        let v5 = arg7 / 86400000;
        if (v5 != arg0.gain_day) {
            arg0.gain_day = v5;
            arg0.gain_used = 0;
        };
        let v6 = 0x1::u64::max(arg0.base, v4);
        let v7 = v6 + arg0.pending_max;
        if (v3 > v7) {
            let v8 = v3 - v7;
            assert!(arg0.gain_used + v8 <= share_down(0x1::u64::max(v6, 1), arg0.settings.gain_bps), 13);
            arg0.gain_used = arg0.gain_used + v8;
        };
        arg0.base = 0x1::u64::max(v4, sat_sub(v3, arg0.pending_max));
        let v9 = Report{
            raw        : arg1,
            multiplier : arg2,
            shares     : v3,
            usdc       : arg3,
            received   : arg4,
            returned   : arg5,
            slot       : arg6,
            ms         : arg7,
        };
        arg0.report = v9;
        let v10 = Reported{
            schema      : 0x12a03cef78d4a96916e7958f91d103ae4fee70169fce99539f843567f5426b74::config::schema(),
            market      : 0x2::object::id<Market<T0, T1>>(arg0),
            wallet      : arg0.settings.custody_owner,
            mint        : arg0.settings.mint,
            report      : arg0.report,
            outstanding : v4,
            pending_max : arg0.pending_max,
        };
        0x2::event::emit<Reported>(v10);
        if (v3 < v4) {
            arg0.blocked = true;
            let v11 = Shortfall{
                schema      : 0x12a03cef78d4a96916e7958f91d103ae4fee70169fce99539f843567f5426b74::config::schema(),
                market      : 0x2::object::id<Market<T0, T1>>(arg0),
                shares      : v3,
                outstanding : v4,
            };
            0x2::event::emit<Shortfall>(v11);
        };
    }

    public fun report_fields(arg0: &Report) : (u64, u128, u64, u64, u64, u64, u64, u64) {
        (arg0.raw, arg0.multiplier, arg0.shares, arg0.usdc, arg0.received, arg0.returned, arg0.slot, arg0.ms)
    }

    fun sat_sub(arg0: u64, arg1: u64) : u64 {
        if (arg0 > arg1) {
            arg0 - arg1
        } else {
            0
        }
    }

    public(friend) fun sell_at<T0, T1>(arg0: &mut Market<T0, T1>, arg1: 0x2::coin::Coin<T0>, arg2: u64, arg3: u64, arg4: u64, arg5: &0x2::tx_context::TxContext) : u64 {
        let v0 = 0x2::coin::value<T0>(&arg1);
        assert!(v0 > 0, 6);
        assert!(arg3 > arg4 && arg3 <= arg4 + arg0.settings.max_deadline_ms, 5);
        let v1 = arg0.next_order;
        arg0.next_order = v1 + 1;
        let v2 = 0x2::tx_context::sender(arg5);
        let v3 = SellBook<T0>{
            user        : v2,
            coins       : 0x2::coin::into_balance<T0>(arg1),
            min_usdc    : arg2,
            deadline_ms : arg3,
            created_ms  : arg4,
            state       : 0,
        };
        0x2::table::add<u64, SellBook<T0>>(&mut arg0.sells, v1, v3);
        arg0.locked = arg0.locked + v0;
        let v4 = SellOrdered{
            schema      : 0x12a03cef78d4a96916e7958f91d103ae4fee70169fce99539f843567f5426b74::config::schema(),
            market      : 0x2::object::id<Market<T0, T1>>(arg0),
            order       : v1,
            user        : v2,
            coins       : v0,
            min_usdc    : arg2,
            deadline_ms : arg3,
        };
        0x2::event::emit<SellOrdered>(v4);
        v1
    }

    public fun sell_info<T0, T1>(arg0: &Market<T0, T1>, arg1: u64) : (address, u64, u64, u64, u8) {
        let v0 = 0x2::table::borrow<u64, SellBook<T0>>(&arg0.sells, arg1);
        (v0.user, 0x2::balance::value<T0>(&v0.coins), v0.min_usdc, v0.deadline_ms, v0.state)
    }

    public fun sell_order<T0, T1>(arg0: &mut Market<T0, T1>, arg1: &0x12a03cef78d4a96916e7958f91d103ae4fee70169fce99539f843567f5426b74::config::Config, arg2: 0x2::coin::Coin<T0>, arg3: u64, arg4: u64, arg5: &0x2::clock::Clock, arg6: &mut 0x2::tx_context::TxContext) : u64 {
        check<T0, T1>(arg0, arg1);
        sell_at<T0, T1>(arg0, arg2, arg3, arg4, 0x2::clock::timestamp_ms(arg5), arg6)
    }

    public fun sent<T0, T1>(arg0: &Market<T0, T1>) : u64 {
        arg0.sent
    }

    public fun set_settings<T0, T1>(arg0: &0x12a03cef78d4a96916e7958f91d103ae4fee70169fce99539f843567f5426b74::config::AdminCap, arg1: &mut Market<T0, T1>, arg2: &0x12a03cef78d4a96916e7958f91d103ae4fee70169fce99539f843567f5426b74::config::Config, arg3: Settings, arg4: &0x2::clock::Clock) {
        check<T0, T1>(arg1, arg2);
        validate(&arg3);
        if (loosens(&arg1.settings, &arg3)) {
            let v0 = 0x2::clock::timestamp_ms(arg4) + 0x12a03cef78d4a96916e7958f91d103ae4fee70169fce99539f843567f5426b74::config::change_delay_ms(arg2);
            let v1 = Pending{
                settings     : arg3,
                effective_ms : v0,
            };
            arg1.pending = 0x1::option::some<Pending>(v1);
            let v2 = SettingsProposed{
                schema       : 0x12a03cef78d4a96916e7958f91d103ae4fee70169fce99539f843567f5426b74::config::schema(),
                market       : 0x2::object::id<Market<T0, T1>>(arg1),
                settings     : arg3,
                effective_ms : v0,
            };
            0x2::event::emit<SettingsProposed>(v2);
        } else {
            arg1.settings = arg3;
            arg1.pending = 0x1::option::none<Pending>();
            let v3 = SettingsChanged{
                schema   : 0x12a03cef78d4a96916e7958f91d103ae4fee70169fce99539f843567f5426b74::config::schema(),
                market   : 0x2::object::id<Market<T0, T1>>(arg1),
                settings : arg3,
            };
            0x2::event::emit<SettingsChanged>(v3);
        };
    }

    public fun settings<T0, T1>(arg0: &Market<T0, T1>) : Settings {
        arg0.settings
    }

    public fun settle<T0, T1>(arg0: &mut Market<T0, T1>, arg1: &0x12a03cef78d4a96916e7958f91d103ae4fee70169fce99539f843567f5426b74::config::Config, arg2: 0x2::transfer::Receiving<0x2::coin::Coin<T1>>, arg3: u64, arg4: &mut 0x2::tx_context::TxContext) : u64 {
        check<T0, T1>(arg0, arg1);
        let v0 = 0x2::transfer::public_receive<0x2::coin::Coin<T1>>(&mut arg0.id, arg2);
        take_in<T0, T1>(arg0, v0);
        pay<T0, T1>(arg0, arg3, arg4)
    }

    fun share_down(arg0: u64, arg1: u64) : u64 {
        (((arg0 as u128) * (arg1 as u128) / (10000 as u128)) as u64)
    }

    fun share_up(arg0: u64, arg1: u64) : u64 {
        ((((arg0 as u128) * (arg1 as u128) + (10000 as u128) - 1) / (10000 as u128)) as u64)
    }

    public fun supply<T0, T1>(arg0: &Market<T0, T1>) : u64 {
        0x2::coin::total_supply<T0>(&arg0.treasury)
    }

    public(friend) fun take_in<T0, T1>(arg0: &mut Market<T0, T1>, arg1: 0x2::coin::Coin<T1>) {
        0x2::balance::join<T1>(&mut arg0.cash, 0x2::coin::into_balance<T1>(arg1));
        let v0 = 0x1::u64::min(arg0.fees_due, sat_sub(0x2::balance::value<T1>(&arg0.cash), arg0.due));
        if (v0 > 0) {
            0x2::balance::join<T1>(&mut arg0.fees, 0x2::balance::split<T1>(&mut arg0.cash, v0));
            arg0.fees_due = arg0.fees_due - v0;
        };
        let v1 = Arrived{
            schema : 0x12a03cef78d4a96916e7958f91d103ae4fee70169fce99539f843567f5426b74::config::schema(),
            market : 0x2::object::id<Market<T0, T1>>(arg0),
            amount : 0x2::coin::value<T1>(&arg1),
            cash   : 0x2::balance::value<T1>(&arg0.cash),
            due    : arg0.due,
        };
        0x2::event::emit<Arrived>(v1);
    }

    public fun timing(arg0: &Settings) : (u64, u64, u64) {
        (arg0.report_max_age_ms, arg0.grace_ms, arg0.max_deadline_ms)
    }

    public fun unblock<T0, T1>(arg0: &0x12a03cef78d4a96916e7958f91d103ae4fee70169fce99539f843567f5426b74::config::AdminCap, arg1: &mut Market<T0, T1>, arg2: &0x12a03cef78d4a96916e7958f91d103ae4fee70169fce99539f843567f5426b74::config::Config) {
        check<T0, T1>(arg1, arg2);
        arg1.blocked = false;
        let v0 = Unblocked{
            schema : 0x12a03cef78d4a96916e7958f91d103ae4fee70169fce99539f843567f5426b74::config::schema(),
            market : 0x2::object::id<Market<T0, T1>>(arg1),
        };
        0x2::event::emit<Unblocked>(v0);
    }

    public fun validate(arg0: &Settings) {
        assert!(arg0.buy_fee_bps <= 200 && arg0.sell_fee_bps <= 200, 2);
        let v0 = if (arg0.custody_owner != @0x0) {
            if (arg0.custody_usdc != @0x0) {
                arg0.mint != @0x0
            } else {
                false
            }
        } else {
            false
        };
        assert!(v0, 2);
        assert!(arg0.report_max_age_ms >= 60000 && arg0.report_max_age_ms <= 86400000, 2);
        assert!(arg0.grace_ms >= 60000 && arg0.grace_ms <= 7 * 86400000, 2);
        assert!(arg0.max_deadline_ms >= 60000 && arg0.max_deadline_ms <= 7 * 86400000, 2);
        assert!(arg0.max_fill_bps <= 5000 && arg0.gain_bps <= 500, 2);
    }

    fun verify_home<T0, T1>(arg0: &Market<T0, T1>, arg1: u32, arg2: address, arg3: &vector<u8>) : (u64, u8, u64) {
        assert!(arg1 == 5 && arg2 == @0xa65fc81d0fefa8860cb3b83f089b0224be8a6687b7ae49f594c0b9b4d7e93893, 14);
        let (v0, v1, v2, v3, v4) = 0x12a03cef78d4a96916e7958f91d103ae4fee70169fce99539f843567f5426b74::message::burn_fields(arg3);
        let v5 = v4;
        let v6 = 0x2::object::id<Market<T0, T1>>(arg0);
        assert!(v0 == 0x2::object::id_to_address(&v6) && v2 == arg0.settings.custody_owner, 14);
        let (v7, v8, v9) = 0x12a03cef78d4a96916e7958f91d103ae4fee70169fce99539f843567f5426b74::message::home_hook(&v5);
        let v10 = 0x2::object::id<Market<T0, T1>>(arg0);
        assert!(v9 == 0x2::object::id_to_address(&v10), 14);
        (v1 - v3, v7, v8)
    }

    // decompiled from Move bytecode v7
}

