module 0x8cae88c175da6d280daf294da44d0c3733ae8fefff0334b81aebe2bd99fd3ffe::config {
    struct SetupCap has key {
        id: 0x2::object::UID,
    }

    struct AdminCap has store, key {
        id: 0x2::object::UID,
        config: 0x2::object::ID,
        treasury: 0x2::object::ID,
    }

    struct BrakeCap has store, key {
        id: 0x2::object::UID,
        config: 0x2::object::ID,
    }

    struct RevokedBrakeKey has copy, drop, store {
        cap_id: 0x2::object::ID,
    }

    struct Params has copy, drop, store {
        split: 0x8cae88c175da6d280daf294da44d0c3733ae8fefff0334b81aebe2bd99fd3ffe::fees::Split,
        band: 0x8cae88c175da6d280daf294da44d0c3733ae8fefff0334b81aebe2bd99fd3ffe::band::Params,
        virtual_shares: u64,
        launch_fee_sui: u64,
        max_dev_buy_bps: u64,
        snipe_min_ms: u64,
        snipe_max_ms: u64,
        snipe_start_fee_bps: u64,
        snipe_tx_cap_bps: u64,
        max_oracle_age_ms: u64,
        max_slippage_bps: u64,
        max_sell_slippage_bps: u64,
        arb_move_bps: u64,
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
    }

    struct ParamsProposed has copy, drop {
        params: Params,
        ready_ms: u64,
    }

    struct ParamsApplied has copy, drop {
        params: Params,
    }

    struct ParamsCancelled has copy, drop {
        dummy_field: bool,
    }

    struct SellOnlyChanged has copy, drop {
        sell_only: bool,
        by_brake: bool,
    }

    struct BrakeIssued has copy, drop {
        cap_id: 0x2::object::ID,
        recipient: address,
    }

    struct BrakeRevoked has copy, drop {
        cap_id: 0x2::object::ID,
    }

    struct Migrated has copy, drop {
        version: u64,
    }

    struct Withdrawn has copy, drop {
        bucket: u8,
        amount: u64,
    }

    public fun default_params() : Params {
        Params{
            split                  : 0x8cae88c175da6d280daf294da44d0c3733ae8fefff0334b81aebe2bd99fd3ffe::fees::default_split(),
            band                   : 0x8cae88c175da6d280daf294da44d0c3733ae8fefff0334b81aebe2bd99fd3ffe::band::default_params(),
            virtual_shares         : 5000000000,
            launch_fee_sui         : 1000000000,
            max_dev_buy_bps        : 1000,
            snipe_min_ms           : 15000,
            snipe_max_ms           : 60000,
            snipe_start_fee_bps    : 9900,
            snipe_tx_cap_bps       : 100,
            max_oracle_age_ms      : 10000,
            max_slippage_bps       : 25,
            max_sell_slippage_bps  : 50,
            arb_move_bps           : 20,
            max_rebalance_notional : 10000000000,
            danger_buffer_bps      : 15000,
            defend_reward          : 200000,
            defend_cooldown_ms     : 600000,
        }
    }

    public fun admin_cap_ids(arg0: &AdminCap) : (0x2::object::ID, 0x2::object::ID) {
        (arg0.config, arg0.treasury)
    }

    public fun apply_params(arg0: &mut Config, arg1: &0x2::clock::Clock) {
        assert_version(arg0);
        assert!(0x1::option::is_some<Params>(&arg0.pending), 703);
        assert!(0x2::clock::timestamp_ms(arg1) >= arg0.pending_ready_ms, 704);
        let v0 = 0x1::option::extract<Params>(&mut arg0.pending);
        check_params(&v0);
        arg0.params = v0;
        let v1 = ParamsApplied{params: v0};
        0x2::event::emit<ParamsApplied>(v1);
    }

    public fun arb_move_bps(arg0: &Params) : u64 {
        arg0.arb_move_bps
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

    public fun band_params(arg0: &Params) : &0x8cae88c175da6d280daf294da44d0c3733ae8fefff0334b81aebe2bd99fd3ffe::band::Params {
        &arg0.band
    }

    public fun brake(arg0: &mut Config, arg1: &BrakeCap) {
        assert!(arg1.config == 0x2::object::id<Config>(arg0), 708);
        let v0 = RevokedBrakeKey{cap_id: 0x2::object::id<BrakeCap>(arg1)};
        assert!(!0x2::dynamic_field::exists<RevokedBrakeKey>(&arg0.id, v0), 709);
        arg0.sell_only = true;
        let v1 = SellOnlyChanged{
            sell_only : true,
            by_brake  : true,
        };
        0x2::event::emit<SellOnlyChanged>(v1);
    }

    public fun cancel_params(arg0: &mut Config, arg1: &AdminCap) {
        check_admin(arg1, arg0);
        assert!(0x1::option::is_some<Params>(&arg0.pending), 703);
        arg0.pending = 0x1::option::none<Params>();
        let v0 = ParamsCancelled{dummy_field: false};
        0x2::event::emit<ParamsCancelled>(v0);
    }

    fun check_admin(arg0: &AdminCap, arg1: &Config) {
        assert!(arg0.config == 0x2::object::id<Config>(arg1), 708);
    }

    fun check_admin_treasury<T0>(arg0: &AdminCap, arg1: &Treasury<T0>) {
        assert!(arg0.treasury == 0x2::object::id<Treasury<T0>>(arg1), 708);
    }

    public fun check_params(arg0: &Params) {
        0x8cae88c175da6d280daf294da44d0c3733ae8fefff0334b81aebe2bd99fd3ffe::fees::check(&arg0.split);
        0x8cae88c175da6d280daf294da44d0c3733ae8fefff0334b81aebe2bd99fd3ffe::band::check(&arg0.band);
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
        assert!(arg0.snipe_start_fee_bps >= 0x8cae88c175da6d280daf294da44d0c3733ae8fefff0334b81aebe2bd99fd3ffe::fees::trade_fee_bps(&arg0.split) && arg0.snipe_start_fee_bps < 10000, 705);
        assert!(arg0.snipe_tx_cap_bps > 0 && arg0.snipe_tx_cap_bps <= 1000, 705);
        assert!(arg0.max_oracle_age_ms >= 5000 && arg0.max_oracle_age_ms <= 60000, 705);
        assert!(arg0.max_slippage_bps > 0 && arg0.max_slippage_bps <= 100, 705);
        assert!(arg0.max_sell_slippage_bps > 0 && arg0.max_sell_slippage_bps <= 100, 705);
        assert!(arg0.arb_move_bps <= 200, 705);
        assert!(arg0.max_rebalance_notional >= 1000000, 705);
        assert!(arg0.danger_buffer_bps > 10000 && arg0.danger_buffer_bps <= 30000, 705);
        assert!(arg0.defend_reward <= 5000000, 705);
        assert!(arg0.defend_cooldown_ms >= 60000, 705);
    }

    public fun create<T0>(arg0: SetupCap, arg1: &mut 0x2::tx_context::TxContext) : AdminCap {
        let SetupCap { id: v0 } = arg0;
        0x2::object::delete(v0);
        new_platform<T0>(arg1)
    }

    public(friend) fun credit<T0>(arg0: &mut Treasury<T0>, arg1: &mut 0x5bb7750b5bd6bdd7babb22a8e38aa4789cf4624f7e87e9ca53802c72e33141ef::referral::Registry, arg2: 0x2::balance::Balance<T0>, arg3: 0x2::balance::Balance<T0>, arg4: 0x2::balance::Balance<T0>, arg5: 0x1::option::Option<address>) {
        0x2::balance::join<T0>(&mut arg0.platform, arg2);
        0x2::balance::join<T0>(&mut arg0.season, arg3);
        if (0x1::option::is_some<address>(&arg5)) {
            0x5bb7750b5bd6bdd7babb22a8e38aa4789cf4624f7e87e9ca53802c72e33141ef::referral::credit_quote<T0>(arg1, 0x1::option::destroy_some<address>(arg5), arg4);
        } else {
            0x2::balance::join<T0>(&mut arg0.platform, arg4);
        };
    }

    public fun defend(arg0: &Params) : (u64, u64, u64) {
        (arg0.danger_buffer_bps, arg0.defend_reward, arg0.defend_cooldown_ms)
    }

    fun init(arg0: &mut 0x2::tx_context::TxContext) {
        let v0 = SetupCap{id: 0x2::object::new(arg0)};
        0x2::transfer::transfer<SetupCap>(v0, 0x2::tx_context::sender(arg0));
    }

    public fun is_sell_only(arg0: &Config) : bool {
        arg0.sell_only
    }

    public fun issue_brake_cap(arg0: &Config, arg1: &AdminCap, arg2: address, arg3: &mut 0x2::tx_context::TxContext) {
        check_admin(arg1, arg0);
        let v0 = BrakeCap{
            id     : 0x2::object::new(arg3),
            config : 0x2::object::id<Config>(arg0),
        };
        let v1 = BrakeIssued{
            cap_id    : 0x2::object::id<BrakeCap>(&v0),
            recipient : arg2,
        };
        0x2::event::emit<BrakeIssued>(v1);
        0x2::transfer::public_transfer<BrakeCap>(v0, arg2);
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

    public fun max_sell_slippage_bps(arg0: &Params) : u64 {
        arg0.max_sell_slippage_bps
    }

    public fun max_slippage_bps(arg0: &Params) : u64 {
        arg0.max_slippage_bps
    }

    public fun migrate(arg0: &mut Config, arg1: &AdminCap) {
        check_admin(arg1, arg0);
        assert!(arg0.version < 1, 701);
        arg0.version = 1;
        let v0 = Migrated{version: 1};
        0x2::event::emit<Migrated>(v0);
    }

    public fun new_params(arg0: 0x8cae88c175da6d280daf294da44d0c3733ae8fefff0334b81aebe2bd99fd3ffe::fees::Split, arg1: 0x8cae88c175da6d280daf294da44d0c3733ae8fefff0334b81aebe2bd99fd3ffe::band::Params, arg2: u64, arg3: u64, arg4: u64, arg5: u64, arg6: u64, arg7: u64, arg8: u64, arg9: u64, arg10: u64, arg11: u64, arg12: u64, arg13: u64, arg14: u64, arg15: u64, arg16: u64) : Params {
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
            max_sell_slippage_bps  : arg11,
            arb_move_bps           : arg12,
            max_rebalance_notional : arg13,
            danger_buffer_bps      : arg14,
            defend_reward          : arg15,
            defend_cooldown_ms     : arg16,
        };
        check_params(&v0);
        v0
    }

    fun new_platform<T0>(arg0: &mut 0x2::tx_context::TxContext) : AdminCap {
        let v0 = Config{
            id               : 0x2::object::new(arg0),
            version          : 1,
            sell_only        : false,
            collateral       : 0x1::type_name::with_defining_ids<T0>(),
            params           : default_params(),
            pending          : 0x1::option::none<Params>(),
            pending_ready_ms : 0,
        };
        let v1 = Treasury<T0>{
            id          : 0x2::object::new(arg0),
            platform    : 0x2::balance::zero<T0>(),
            season      : 0x2::balance::zero<T0>(),
            launch_fees : 0x2::balance::zero<0x2::sui::SUI>(),
        };
        let v2 = AdminCap{
            id       : 0x2::object::new(arg0),
            config   : 0x2::object::id<Config>(&v0),
            treasury : 0x2::object::id<Treasury<T0>>(&v1),
        };
        0x2::transfer::share_object<Config>(v0);
        0x2::transfer::share_object<Treasury<T0>>(v1);
        v2
    }

    public fun params(arg0: &Config) : &Params {
        &arg0.params
    }

    public fun pending_params(arg0: &Config) : (0x1::option::Option<Params>, u64) {
        (arg0.pending, arg0.pending_ready_ms)
    }

    public fun propose_params(arg0: &mut Config, arg1: &AdminCap, arg2: Params, arg3: &0x2::clock::Clock) {
        check_admin(arg1, arg0);
        assert_version(arg0);
        check_params(&arg2);
        arg0.pending = 0x1::option::some<Params>(arg2);
        arg0.pending_ready_ms = 0x2::clock::timestamp_ms(arg3) + 172800000;
        let v0 = ParamsProposed{
            params   : arg2,
            ready_ms : arg0.pending_ready_ms,
        };
        0x2::event::emit<ParamsProposed>(v0);
    }

    public fun revoke_brake_cap(arg0: &mut Config, arg1: &AdminCap, arg2: 0x2::object::ID) {
        check_admin(arg1, arg0);
        let v0 = RevokedBrakeKey{cap_id: arg2};
        if (!0x2::dynamic_field::exists<RevokedBrakeKey>(&arg0.id, v0)) {
            let v1 = RevokedBrakeKey{cap_id: arg2};
            0x2::dynamic_field::add<RevokedBrakeKey, bool>(&mut arg0.id, v1, true);
        };
        let v2 = BrakeRevoked{cap_id: arg2};
        0x2::event::emit<BrakeRevoked>(v2);
    }

    public fun set_sell_only(arg0: &mut Config, arg1: &AdminCap, arg2: bool) {
        check_admin(arg1, arg0);
        arg0.sell_only = arg2;
        let v0 = SellOnlyChanged{
            sell_only : arg2,
            by_brake  : false,
        };
        0x2::event::emit<SellOnlyChanged>(v0);
    }

    public fun snipe(arg0: &Params) : (u64, u64, u64, u64) {
        (arg0.snipe_min_ms, arg0.snipe_max_ms, arg0.snipe_start_fee_bps, arg0.snipe_tx_cap_bps)
    }

    public fun split(arg0: &Params) : &0x8cae88c175da6d280daf294da44d0c3733ae8fefff0334b81aebe2bd99fd3ffe::fees::Split {
        &arg0.split
    }

    public(friend) fun take_launch_fee<T0>(arg0: &mut Treasury<T0>, arg1: 0x2::balance::Balance<0x2::sui::SUI>) {
        0x2::balance::join<0x2::sui::SUI>(&mut arg0.launch_fees, arg1);
    }

    public fun treasury_balances<T0>(arg0: &Treasury<T0>) : (u64, u64, u64) {
        (0x2::balance::value<T0>(&arg0.platform), 0x2::balance::value<T0>(&arg0.season), 0x2::balance::value<0x2::sui::SUI>(&arg0.launch_fees))
    }

    public fun virtual_shares(arg0: &Params) : u64 {
        arg0.virtual_shares
    }

    public fun withdraw_launch_fees<T0>(arg0: &mut Treasury<T0>, arg1: &AdminCap, arg2: &mut 0x2::tx_context::TxContext) : 0x2::coin::Coin<0x2::sui::SUI> {
        check_admin_treasury<T0>(arg1, arg0);
        let v0 = 0x2::balance::withdraw_all<0x2::sui::SUI>(&mut arg0.launch_fees);
        let v1 = Withdrawn{
            bucket : 1,
            amount : 0x2::balance::value<0x2::sui::SUI>(&v0),
        };
        0x2::event::emit<Withdrawn>(v1);
        0x2::coin::from_balance<0x2::sui::SUI>(v0, arg2)
    }

    public fun withdraw_platform<T0>(arg0: &mut Treasury<T0>, arg1: &AdminCap, arg2: &mut 0x2::tx_context::TxContext) : 0x2::coin::Coin<T0> {
        check_admin_treasury<T0>(arg1, arg0);
        let v0 = 0x2::balance::withdraw_all<T0>(&mut arg0.platform);
        let v1 = Withdrawn{
            bucket : 0,
            amount : 0x2::balance::value<T0>(&v0),
        };
        0x2::event::emit<Withdrawn>(v1);
        0x2::coin::from_balance<T0>(v0, arg2)
    }

    public fun withdraw_season<T0>(arg0: &mut Treasury<T0>, arg1: &AdminCap, arg2: &mut 0x2::tx_context::TxContext) : 0x2::coin::Coin<T0> {
        check_admin_treasury<T0>(arg1, arg0);
        let v0 = 0x2::balance::withdraw_all<T0>(&mut arg0.season);
        let v1 = Withdrawn{
            bucket : 2,
            amount : 0x2::balance::value<T0>(&v0),
        };
        0x2::event::emit<Withdrawn>(v1);
        0x2::coin::from_balance<T0>(v0, arg2)
    }

    // decompiled from Move bytecode v7
}

