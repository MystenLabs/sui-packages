module 0xfd3bbac03bacaa09904bc4d1529a0032aaa8b1bc575d884ae7767571cc5be8c8::config {
    struct AdminCap has store, key {
        id: 0x2::object::UID,
    }

    struct Params has copy, drop, store {
        split: 0xfd3bbac03bacaa09904bc4d1529a0032aaa8b1bc575d884ae7767571cc5be8c8::fees::Split,
        band: 0xfd3bbac03bacaa09904bc4d1529a0032aaa8b1bc575d884ae7767571cc5be8c8::band::Params,
        virtual_shares: u64,
        launch_fee_sui: u64,
        max_dev_buy_bps: u64,
        snipe_min_ms: u64,
        snipe_max_ms: u64,
        snipe_start_fee_bps: u64,
        snipe_tx_cap_bps: u64,
        max_oracle_age_ms: u64,
        max_slippage_bps: u64,
        max_rebalance_notional: u64,
        danger_buffer_bps: u64,
        defend_reward: u64,
        defend_cooldown_ms: u64,
    }

    struct Config has key {
        id: 0x2::object::UID,
        version: u64,
        sell_only: bool,
        collateral: 0x1::type_name::TypeName,
        params: Params,
        pending: 0x1::option::Option<Params>,
        pending_ready_ms: u64,
    }

    struct Treasury<phantom T0> has key {
        id: 0x2::object::UID,
        platform: 0x2::balance::Balance<T0>,
        season: 0x2::balance::Balance<T0>,
        launch_fees: 0x2::balance::Balance<0x2::sui::SUI>,
        referral_balances: 0x2::table::Table<address, 0x2::balance::Balance<T0>>,
        referrers: 0x2::table::Table<address, address>,
    }

    struct ParamsProposed has copy, drop {
        ready_ms: u64,
    }

    struct ParamsApplied has copy, drop {
        dummy_field: bool,
    }

    struct SellOnlyChanged has copy, drop {
        sell_only: bool,
    }

    public fun default_params() : Params {
        Params{
            split                  : 0xfd3bbac03bacaa09904bc4d1529a0032aaa8b1bc575d884ae7767571cc5be8c8::fees::default_split(),
            band                   : 0xfd3bbac03bacaa09904bc4d1529a0032aaa8b1bc575d884ae7767571cc5be8c8::band::default_params(),
            virtual_shares         : 5000000000,
            launch_fee_sui         : 1000000000,
            max_dev_buy_bps        : 1000,
            snipe_min_ms           : 15000,
            snipe_max_ms           : 60000,
            snipe_start_fee_bps    : 9900,
            snipe_tx_cap_bps       : 100,
            max_oracle_age_ms      : 60000,
            max_slippage_bps       : 50,
            max_rebalance_notional : 50000000000,
            danger_buffer_bps      : 15000,
            defend_reward          : 200000,
            defend_cooldown_ms     : 600000,
        }
    }

    public fun apply_params(arg0: &mut Config, arg1: u64) {
        assert_version(arg0);
        assert!(0x1::option::is_some<Params>(&arg0.pending), 703);
        assert!(arg1 >= arg0.pending_ready_ms, 704);
        arg0.params = 0x1::option::extract<Params>(&mut arg0.pending);
        let v0 = ParamsApplied{dummy_field: false};
        0x2::event::emit<ParamsApplied>(v0);
    }

    public fun assert_can_buy(arg0: &Config) {
        assert_version(arg0);
        assert!(!arg0.sell_only, 702);
    }

    public fun assert_collateral<T0>(arg0: &Config) {
        assert!(arg0.collateral == 0x1::type_name::with_defining_ids<T0>(), 706);
    }

    public fun assert_version(arg0: &Config) {
        assert!(arg0.version == 1, 700);
    }

    public fun band_params(arg0: &Params) : &0xfd3bbac03bacaa09904bc4d1529a0032aaa8b1bc575d884ae7767571cc5be8c8::band::Params {
        &arg0.band
    }

    public(friend) fun bind_referrer<T0>(arg0: &mut Treasury<T0>, arg1: address, arg2: 0x1::option::Option<address>) : 0x1::option::Option<address> {
        if (0x2::table::contains<address, address>(&arg0.referrers, arg1)) {
            return 0x1::option::some<address>(*0x2::table::borrow<address, address>(&arg0.referrers, arg1))
        };
        if (0x1::option::is_none<address>(&arg2)) {
            return 0x1::option::none<address>()
        };
        let v0 = 0x1::option::destroy_some<address>(arg2);
        assert!(v0 != arg1, 707);
        0x2::table::add<address, address>(&mut arg0.referrers, arg1, v0);
        0x1::option::some<address>(v0)
    }

    public fun cancel_params(arg0: &mut Config, arg1: &AdminCap) {
        arg0.pending = 0x1::option::none<Params>();
    }

    public fun check_params(arg0: &Params) {
        0xfd3bbac03bacaa09904bc4d1529a0032aaa8b1bc575d884ae7767571cc5be8c8::fees::check(&arg0.split);
        0xfd3bbac03bacaa09904bc4d1529a0032aaa8b1bc575d884ae7767571cc5be8c8::band::check(&arg0.band);
        assert!(arg0.virtual_shares >= 100000000 && arg0.virtual_shares <= 1000000000000, 705);
        assert!(arg0.launch_fee_sui <= 100000000000, 705);
        assert!(arg0.max_dev_buy_bps <= 2000, 705);
        let v0 = if (arg0.snipe_min_ms > 0) {
            if (arg0.snipe_min_ms <= arg0.snipe_max_ms) {
                arg0.snipe_max_ms <= 120000
            } else {
                false
            }
        } else {
            false
        };
        assert!(v0, 705);
        assert!(arg0.snipe_start_fee_bps >= 0xfd3bbac03bacaa09904bc4d1529a0032aaa8b1bc575d884ae7767571cc5be8c8::fees::trade_fee_bps(&arg0.split) && arg0.snipe_start_fee_bps < 10000, 705);
        assert!(arg0.snipe_tx_cap_bps > 0 && arg0.snipe_tx_cap_bps <= 1000, 705);
        assert!(arg0.max_oracle_age_ms >= 5000 && arg0.max_oracle_age_ms <= 600000, 705);
        assert!(arg0.max_slippage_bps > 0 && arg0.max_slippage_bps <= 500, 705);
        assert!(arg0.max_rebalance_notional >= 1000000, 705);
        assert!(arg0.danger_buffer_bps > 10000 && arg0.danger_buffer_bps <= 30000, 705);
        assert!(arg0.defend_reward <= 5000000, 705);
        assert!(arg0.defend_cooldown_ms >= 60000, 705);
    }

    public fun claim_referral<T0>(arg0: &mut Treasury<T0>, arg1: &mut 0x2::tx_context::TxContext) : 0x2::coin::Coin<T0> {
        let v0 = 0x2::tx_context::sender(arg1);
        if (!0x2::table::contains<address, 0x2::balance::Balance<T0>>(&arg0.referral_balances, v0)) {
            return 0x2::coin::zero<T0>(arg1)
        };
        0x2::coin::from_balance<T0>(0x2::table::remove<address, 0x2::balance::Balance<T0>>(&mut arg0.referral_balances, v0), arg1)
    }

    public fun create<T0>(arg0: &mut 0x2::tx_context::TxContext) : AdminCap {
        let v0 = Config{
            id               : 0x2::object::new(arg0),
            version          : 1,
            sell_only        : false,
            collateral       : 0x1::type_name::with_defining_ids<T0>(),
            params           : default_params(),
            pending          : 0x1::option::none<Params>(),
            pending_ready_ms : 0,
        };
        0x2::transfer::share_object<Config>(v0);
        let v1 = Treasury<T0>{
            id                : 0x2::object::new(arg0),
            platform          : 0x2::balance::zero<T0>(),
            season            : 0x2::balance::zero<T0>(),
            launch_fees       : 0x2::balance::zero<0x2::sui::SUI>(),
            referral_balances : 0x2::table::new<address, 0x2::balance::Balance<T0>>(arg0),
            referrers         : 0x2::table::new<address, address>(arg0),
        };
        0x2::transfer::share_object<Treasury<T0>>(v1);
        AdminCap{id: 0x2::object::new(arg0)}
    }

    public(friend) fun credit<T0>(arg0: &mut Treasury<T0>, arg1: 0x2::balance::Balance<T0>, arg2: 0x2::balance::Balance<T0>, arg3: 0x2::balance::Balance<T0>, arg4: 0x1::option::Option<address>) {
        0x2::balance::join<T0>(&mut arg0.platform, arg1);
        0x2::balance::join<T0>(&mut arg0.season, arg2);
        if (0x1::option::is_some<address>(&arg4)) {
            let v0 = 0x1::option::destroy_some<address>(arg4);
            if (0x2::table::contains<address, 0x2::balance::Balance<T0>>(&arg0.referral_balances, v0)) {
                0x2::balance::join<T0>(0x2::table::borrow_mut<address, 0x2::balance::Balance<T0>>(&mut arg0.referral_balances, v0), arg3);
            } else {
                0x2::table::add<address, 0x2::balance::Balance<T0>>(&mut arg0.referral_balances, v0, arg3);
            };
        } else {
            0x2::balance::join<T0>(&mut arg0.platform, arg3);
        };
    }

    public fun defend(arg0: &Params) : (u64, u64, u64) {
        (arg0.danger_buffer_bps, arg0.defend_reward, arg0.defend_cooldown_ms)
    }

    public fun is_sell_only(arg0: &Config) : bool {
        arg0.sell_only
    }

    public fun launch_fee_sui(arg0: &Params) : u64 {
        arg0.launch_fee_sui
    }

    public fun max_dev_buy_bps(arg0: &Params) : u64 {
        arg0.max_dev_buy_bps
    }

    public fun max_oracle_age_ms(arg0: &Params) : u64 {
        arg0.max_oracle_age_ms
    }

    public fun max_rebalance_notional(arg0: &Params) : u64 {
        arg0.max_rebalance_notional
    }

    public fun max_slippage_bps(arg0: &Params) : u64 {
        arg0.max_slippage_bps
    }

    public fun migrate(arg0: &mut Config, arg1: &AdminCap) {
        assert!(arg0.version < 1, 701);
        arg0.version = 1;
    }

    public fun new_params(arg0: 0xfd3bbac03bacaa09904bc4d1529a0032aaa8b1bc575d884ae7767571cc5be8c8::fees::Split, arg1: 0xfd3bbac03bacaa09904bc4d1529a0032aaa8b1bc575d884ae7767571cc5be8c8::band::Params, arg2: u64, arg3: u64, arg4: u64, arg5: u64, arg6: u64, arg7: u64, arg8: u64, arg9: u64, arg10: u64, arg11: u64, arg12: u64, arg13: u64, arg14: u64) : Params {
        let v0 = Params{
            split                  : arg0,
            band                   : arg1,
            virtual_shares         : arg2,
            launch_fee_sui         : arg3,
            max_dev_buy_bps        : arg4,
            snipe_min_ms           : arg5,
            snipe_max_ms           : arg6,
            snipe_start_fee_bps    : arg7,
            snipe_tx_cap_bps       : arg8,
            max_oracle_age_ms      : arg9,
            max_slippage_bps       : arg10,
            max_rebalance_notional : arg11,
            danger_buffer_bps      : arg12,
            defend_reward          : arg13,
            defend_cooldown_ms     : arg14,
        };
        check_params(&v0);
        v0
    }

    public fun params(arg0: &Config) : &Params {
        &arg0.params
    }

    public fun propose_params(arg0: &mut Config, arg1: &AdminCap, arg2: Params, arg3: u64) {
        assert_version(arg0);
        check_params(&arg2);
        arg0.pending = 0x1::option::some<Params>(arg2);
        arg0.pending_ready_ms = arg3 + 172800000;
        let v0 = ParamsProposed{ready_ms: arg0.pending_ready_ms};
        0x2::event::emit<ParamsProposed>(v0);
    }

    public fun set_sell_only(arg0: &mut Config, arg1: &AdminCap, arg2: bool) {
        arg0.sell_only = arg2;
        let v0 = SellOnlyChanged{sell_only: arg2};
        0x2::event::emit<SellOnlyChanged>(v0);
    }

    public fun snipe(arg0: &Params) : (u64, u64, u64, u64) {
        (arg0.snipe_min_ms, arg0.snipe_max_ms, arg0.snipe_start_fee_bps, arg0.snipe_tx_cap_bps)
    }

    public fun split(arg0: &Params) : &0xfd3bbac03bacaa09904bc4d1529a0032aaa8b1bc575d884ae7767571cc5be8c8::fees::Split {
        &arg0.split
    }

    public(friend) fun take_launch_fee<T0>(arg0: &mut Treasury<T0>, arg1: 0x2::balance::Balance<0x2::sui::SUI>) {
        0x2::balance::join<0x2::sui::SUI>(&mut arg0.launch_fees, arg1);
    }

    public fun virtual_shares(arg0: &Params) : u64 {
        arg0.virtual_shares
    }

    public fun withdraw_launch_fees<T0>(arg0: &mut Treasury<T0>, arg1: &AdminCap, arg2: &mut 0x2::tx_context::TxContext) : 0x2::coin::Coin<0x2::sui::SUI> {
        0x2::coin::from_balance<0x2::sui::SUI>(0x2::balance::withdraw_all<0x2::sui::SUI>(&mut arg0.launch_fees), arg2)
    }

    public fun withdraw_platform<T0>(arg0: &mut Treasury<T0>, arg1: &AdminCap, arg2: &mut 0x2::tx_context::TxContext) : 0x2::coin::Coin<T0> {
        0x2::coin::from_balance<T0>(0x2::balance::withdraw_all<T0>(&mut arg0.platform), arg2)
    }

    // decompiled from Move bytecode v7
}

