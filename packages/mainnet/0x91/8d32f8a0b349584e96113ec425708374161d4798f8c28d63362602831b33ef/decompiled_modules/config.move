module 0x918d32f8a0b349584e96113ec425708374161d4798f8c28d63362602831b33ef::config {
    struct AdminCap has store, key {
        id: 0x2::object::UID,
    }

    struct BrakeCap has store, key {
        id: 0x2::object::UID,
    }

    struct Params has copy, drop, store {
        graduation_sui: u64,
        trade_fee_bps: u64,
        creator_bps: u64,
        platform_bps: u64,
        season_bps: u64,
        liquidity_bps: u64,
        referral_bps: u64,
        graduation_creator_bps: u64,
        graduation_platform_bps: u64,
        launch_fee: u64,
        max_dev_buy_bps: u64,
        snipe_min_ms: u64,
        snipe_max_ms: u64,
        snipe_start_fee_bps: u64,
        snipe_tx_cap_bps: u64,
    }

    struct Config has key {
        id: 0x2::object::UID,
        params: Params,
        pending: 0x1::option::Option<Params>,
        pending_ready_ms: u64,
        sell_only: bool,
        version: u64,
    }

    struct Treasury has key {
        id: 0x2::object::UID,
        platform: 0x2::balance::Balance<0x2::sui::SUI>,
        season: 0x2::balance::Balance<0x2::sui::SUI>,
    }

    struct ParamsProposed has copy, drop {
        params: Params,
        ready_ms: u64,
    }

    struct ParamsApplied has copy, drop {
        params: Params,
    }

    struct SellOnlyChanged has copy, drop {
        enabled: bool,
        reason: vector<u8>,
    }

    struct PlatformWithdrawn has copy, drop {
        amount: u64,
        recipient: address,
    }

    struct Migrated has copy, drop {
        from: u64,
        to: u64,
    }

    public fun apply_params(arg0: &mut Config, arg1: &0x2::clock::Clock) {
        assert_version(arg0);
        assert!(0x1::option::is_some<Params>(&arg0.pending), 101);
        assert!(0x2::clock::timestamp_ms(arg1) >= arg0.pending_ready_ms, 102);
        let v0 = 0x1::option::extract<Params>(&mut arg0.pending);
        arg0.params = v0;
        let v1 = ParamsApplied{params: v0};
        0x2::event::emit<ParamsApplied>(v1);
    }

    public fun assert_version(arg0: &Config) {
        assert!(arg0.version == 1, 104);
    }

    public fun cancel_params(arg0: &AdminCap, arg1: &mut Config) {
        assert_version(arg1);
        arg1.pending = 0x1::option::none<Params>();
    }

    fun check_bounds(arg0: &Params) {
        assert!(arg0.graduation_sui >= 2000000000000 && arg0.graduation_sui <= 60000000000000, 100);
        assert!(arg0.trade_fee_bps <= 200, 100);
        assert!(arg0.creator_bps + arg0.platform_bps + arg0.season_bps + arg0.liquidity_bps == arg0.trade_fee_bps, 103);
        let v0 = if (arg0.referral_bps % 2 == 0) {
            if (arg0.referral_bps / 2 <= arg0.platform_bps) {
                arg0.referral_bps / 2 <= arg0.season_bps
            } else {
                false
            }
        } else {
            false
        };
        assert!(v0, 103);
        assert!(arg0.platform_bps * 10 <= arg0.trade_fee_bps * 7, 100);
        assert!(arg0.graduation_creator_bps + arg0.graduation_platform_bps <= 500, 100);
        assert!(arg0.launch_fee <= 10000000000, 100);
        assert!(arg0.max_dev_buy_bps <= 1000, 100);
        let v1 = if (arg0.snipe_min_ms > 0) {
            if (arg0.snipe_min_ms <= arg0.snipe_max_ms) {
                arg0.snipe_max_ms <= 120000
            } else {
                false
            }
        } else {
            false
        };
        assert!(v1, 100);
        assert!(arg0.snipe_start_fee_bps >= arg0.trade_fee_bps && arg0.snipe_start_fee_bps < 10000, 100);
        assert!(arg0.snipe_tx_cap_bps > 0 && arg0.snipe_tx_cap_bps <= 1000, 100);
    }

    public fun creator_bps(arg0: &Params) : u64 {
        arg0.creator_bps
    }

    public fun default_params() : Params {
        Params{
            graduation_sui          : 12000 * 1000000000,
            trade_fee_bps           : 100,
            creator_bps             : 50,
            platform_bps            : 30,
            season_bps              : 10,
            liquidity_bps           : 10,
            referral_bps            : 10,
            graduation_creator_bps  : 60,
            graduation_platform_bps : 40,
            launch_fee              : 1 * 1000000000,
            max_dev_buy_bps         : 1000,
            snipe_min_ms            : 15000,
            snipe_max_ms            : 60000,
            snipe_start_fee_bps     : 9900,
            snipe_tx_cap_bps        : 100,
        }
    }

    public(friend) fun deposit_platform(arg0: &mut Treasury, arg1: 0x2::balance::Balance<0x2::sui::SUI>) {
        0x2::balance::join<0x2::sui::SUI>(&mut arg0.platform, arg1);
    }

    public(friend) fun deposit_season(arg0: &mut Treasury, arg1: 0x2::balance::Balance<0x2::sui::SUI>) {
        0x2::balance::join<0x2::sui::SUI>(&mut arg0.season, arg1);
    }

    public fun disable_sell_only(arg0: &AdminCap, arg1: &mut Config, arg2: vector<u8>) {
        assert_version(arg1);
        arg1.sell_only = false;
        let v0 = SellOnlyChanged{
            enabled : false,
            reason  : arg2,
        };
        0x2::event::emit<SellOnlyChanged>(v0);
    }

    public fun donate_season(arg0: &Config, arg1: &mut Treasury, arg2: 0x2::coin::Coin<0x2::sui::SUI>) {
        assert_version(arg0);
        0x2::balance::join<0x2::sui::SUI>(&mut arg1.season, 0x2::coin::into_balance<0x2::sui::SUI>(arg2));
    }

    public(friend) fun donate_season_balance(arg0: &mut Treasury, arg1: 0x2::balance::Balance<0x2::sui::SUI>) {
        0x2::balance::join<0x2::sui::SUI>(&mut arg0.season, arg1);
    }

    public fun enable_sell_only(arg0: &BrakeCap, arg1: &mut Config, arg2: vector<u8>) {
        assert_version(arg1);
        arg1.sell_only = true;
        let v0 = SellOnlyChanged{
            enabled : true,
            reason  : arg2,
        };
        0x2::event::emit<SellOnlyChanged>(v0);
    }

    public fun graduation_creator_bps(arg0: &Params) : u64 {
        arg0.graduation_creator_bps
    }

    public fun graduation_platform_bps(arg0: &Params) : u64 {
        arg0.graduation_platform_bps
    }

    public fun graduation_sui(arg0: &Params) : u64 {
        arg0.graduation_sui
    }

    fun init(arg0: &mut 0x2::tx_context::TxContext) {
        let v0 = default_params();
        check_bounds(&v0);
        let v1 = Config{
            id               : 0x2::object::new(arg0),
            params           : v0,
            pending          : 0x1::option::none<Params>(),
            pending_ready_ms : 0,
            sell_only        : false,
            version          : 1,
        };
        0x2::transfer::share_object<Config>(v1);
        let v2 = Treasury{
            id       : 0x2::object::new(arg0),
            platform : 0x2::balance::zero<0x2::sui::SUI>(),
            season   : 0x2::balance::zero<0x2::sui::SUI>(),
        };
        0x2::transfer::share_object<Treasury>(v2);
        let v3 = AdminCap{id: 0x2::object::new(arg0)};
        0x2::transfer::public_transfer<AdminCap>(v3, 0x2::tx_context::sender(arg0));
    }

    public fun is_sell_only(arg0: &Config) : bool {
        arg0.sell_only
    }

    public fun launch_fee(arg0: &Params) : u64 {
        arg0.launch_fee
    }

    public fun liquidity_bps(arg0: &Params) : u64 {
        arg0.liquidity_bps
    }

    public fun max_dev_buy_bps(arg0: &Params) : u64 {
        arg0.max_dev_buy_bps
    }

    public fun migrate(arg0: &AdminCap, arg1: &mut Config) {
        assert!(arg1.version < 1, 105);
        let v0 = Migrated{
            from : arg1.version,
            to   : 1,
        };
        0x2::event::emit<Migrated>(v0);
        arg1.version = 1;
    }

    public fun mint_brake_cap(arg0: &AdminCap, arg1: &Config, arg2: address, arg3: &mut 0x2::tx_context::TxContext) {
        assert_version(arg1);
        let v0 = BrakeCap{id: 0x2::object::new(arg3)};
        0x2::transfer::public_transfer<BrakeCap>(v0, arg2);
    }

    public fun new_params(arg0: u64, arg1: u64, arg2: u64, arg3: u64, arg4: u64, arg5: u64, arg6: u64, arg7: u64, arg8: u64, arg9: u64, arg10: u64, arg11: u64, arg12: u64, arg13: u64, arg14: u64) : Params {
        let v0 = Params{
            graduation_sui          : arg0,
            trade_fee_bps           : arg1,
            creator_bps             : arg2,
            platform_bps            : arg3,
            season_bps              : arg4,
            liquidity_bps           : arg5,
            referral_bps            : arg6,
            graduation_creator_bps  : arg7,
            graduation_platform_bps : arg8,
            launch_fee              : arg9,
            max_dev_buy_bps         : arg10,
            snipe_min_ms            : arg11,
            snipe_max_ms            : arg12,
            snipe_start_fee_bps     : arg13,
            snipe_tx_cap_bps        : arg14,
        };
        check_bounds(&v0);
        v0
    }

    public fun package_version() : u64 {
        1
    }

    public fun params(arg0: &Config) : Params {
        arg0.params
    }

    public fun platform_balance(arg0: &Treasury) : u64 {
        0x2::balance::value<0x2::sui::SUI>(&arg0.platform)
    }

    public fun platform_bps(arg0: &Params) : u64 {
        arg0.platform_bps
    }

    public fun propose_params(arg0: &AdminCap, arg1: &mut Config, arg2: Params, arg3: &0x2::clock::Clock) {
        assert_version(arg1);
        check_bounds(&arg2);
        let v0 = 0x2::clock::timestamp_ms(arg3) + 172800000;
        arg1.pending = 0x1::option::some<Params>(arg2);
        arg1.pending_ready_ms = v0;
        let v1 = ParamsProposed{
            params   : arg2,
            ready_ms : v0,
        };
        0x2::event::emit<ParamsProposed>(v1);
    }

    public fun referral_bps(arg0: &Params) : u64 {
        arg0.referral_bps
    }

    public fun season_balance(arg0: &Treasury) : u64 {
        0x2::balance::value<0x2::sui::SUI>(&arg0.season)
    }

    public fun season_bps(arg0: &Params) : u64 {
        arg0.season_bps
    }

    public fun snipe_max_ms(arg0: &Params) : u64 {
        arg0.snipe_max_ms
    }

    public fun snipe_min_ms(arg0: &Params) : u64 {
        arg0.snipe_min_ms
    }

    public fun snipe_start_fee_bps(arg0: &Params) : u64 {
        arg0.snipe_start_fee_bps
    }

    public fun snipe_tx_cap_bps(arg0: &Params) : u64 {
        arg0.snipe_tx_cap_bps
    }

    public(friend) fun take_season(arg0: &mut Treasury, arg1: u64) : 0x2::balance::Balance<0x2::sui::SUI> {
        0x2::balance::split<0x2::sui::SUI>(&mut arg0.season, arg1)
    }

    public fun trade_fee_bps(arg0: &Params) : u64 {
        arg0.trade_fee_bps
    }

    public fun version(arg0: &Config) : u64 {
        arg0.version
    }

    public fun withdraw_platform(arg0: &AdminCap, arg1: &Config, arg2: &mut Treasury, arg3: u64, arg4: address, arg5: &mut 0x2::tx_context::TxContext) {
        assert_version(arg1);
        0x2::transfer::public_transfer<0x2::coin::Coin<0x2::sui::SUI>>(0x2::coin::take<0x2::sui::SUI>(&mut arg2.platform, arg3, arg5), arg4);
        let v0 = PlatformWithdrawn{
            amount    : arg3,
            recipient : arg4,
        };
        0x2::event::emit<PlatformWithdrawn>(v0);
    }

    // decompiled from Move bytecode v7
}

