module 0x294e0968e465d9e2e560b825c603a40d34a7ee72e5a9157ff796519d44f7df4a::config {
    struct AdminCap has store, key {
        id: 0x2::object::UID,
    }

    struct KeeperCap has key {
        id: 0x2::object::UID,
        config: 0x2::object::ID,
        epoch: u64,
    }

    struct Settings has copy, drop, store {
        mint_fee_bps: u64,
        redeem_fee_bps: u64,
        streaming_fee_bps: u64,
        ppx_bps: u64,
        referral_bps: u64,
        ppx_recipient: address,
        treasury: address,
        rebalance_slippage_bps: u64,
        emergency_slippage_bps: u64,
        entry_slippage_bps: u64,
        unwind_chunk: u64,
    }

    struct Pending has copy, drop, store {
        settings: Settings,
        after_ms: u64,
    }

    struct Config has key {
        id: 0x2::object::UID,
        version: u64,
        paused: bool,
        settings: Settings,
        pending: 0x1::option::Option<Pending>,
        fee_index: u128,
        fee_index_ms: u64,
        keeper_epoch: u64,
        pending_keeper: 0x1::option::Option<PendingKeeper>,
    }

    struct PendingKeeper has copy, drop, store {
        recipient: address,
        after_ms: u64,
    }

    struct SettingsChanged has copy, drop {
        config: 0x2::object::ID,
        settings: Settings,
    }

    struct SettingsProposed has copy, drop {
        config: 0x2::object::ID,
        settings: Settings,
        after_ms: u64,
    }

    struct SettingsCancelled has copy, drop {
        config: 0x2::object::ID,
    }

    struct PauseChanged has copy, drop {
        config: 0x2::object::ID,
        paused: bool,
    }

    struct KeepersChanged has copy, drop {
        config: 0x2::object::ID,
        epoch: u64,
    }

    struct KeeperProposed has copy, drop {
        config: 0x2::object::ID,
        recipient: address,
        after_ms: u64,
    }

    struct KeeperIssued has copy, drop {
        config: 0x2::object::ID,
        recipient: address,
        cap: 0x2::object::ID,
        epoch: u64,
    }

    struct KeeperCancelled has copy, drop {
        config: 0x2::object::ID,
    }

    struct Migrated has copy, drop {
        config: 0x2::object::ID,
        from: u64,
        to: u64,
    }

    struct Halted has copy, drop {
        config: 0x2::object::ID,
        from: u64,
    }

    public fun apply(arg0: &mut Config, arg1: &0x2::clock::Clock) {
        assert_version(arg0);
        assert!(0x1::option::is_some<Pending>(&arg0.pending), 6);
        let Pending {
            settings : v0,
            after_ms : v1,
        } = *0x1::option::borrow<Pending>(&arg0.pending);
        assert_window(v1, arg1);
        arg0.pending = 0x1::option::none<Pending>();
        let v2 = 0x2::clock::timestamp_ms(arg1);
        arg0.fee_index = streaming_fee_index(arg0, v2);
        arg0.fee_index_ms = 0x1::u64::max(v2, arg0.fee_index_ms);
        arg0.settings = v0;
        let v3 = SettingsChanged{
            config   : 0x2::object::id<Config>(arg0),
            settings : v0,
        };
        0x2::event::emit<SettingsChanged>(v3);
    }

    public(friend) fun assert_keeper(arg0: &Config, arg1: &KeeperCap) {
        assert_version(arg0);
        assert!(arg1.config == 0x2::object::id<Config>(arg0) && arg1.epoch == arg0.keeper_epoch, 8);
    }

    public fun assert_minting(arg0: &Config) {
        assert_version(arg0);
        assert!(!arg0.paused, 4);
    }

    public fun assert_version(arg0: &Config) {
        assert!(arg0.version == 1, 1);
    }

    public(friend) fun assert_window(arg0: u64, arg1: &0x2::clock::Clock) {
        let v0 = 0x2::clock::timestamp_ms(arg1);
        assert!(v0 >= arg0, 5);
        assert!(v0 < arg0 + 604800000, 7);
    }

    public fun cancel(arg0: &AdminCap, arg1: &mut Config) {
        assert_version(arg1);
        assert!(0x1::option::is_some<Pending>(&arg1.pending), 6);
        arg1.pending = 0x1::option::none<Pending>();
        let v0 = SettingsCancelled{config: 0x2::object::id<Config>(arg1)};
        0x2::event::emit<SettingsCancelled>(v0);
    }

    public fun cancel_keeper(arg0: &AdminCap, arg1: &mut Config) {
        assert_version(arg1);
        assert!(0x1::option::is_some<PendingKeeper>(&arg1.pending_keeper), 6);
        arg1.pending_keeper = 0x1::option::none<PendingKeeper>();
        let v0 = KeeperCancelled{config: 0x2::object::id<Config>(arg1)};
        0x2::event::emit<KeeperCancelled>(v0);
    }

    public fun destroy_keeper(arg0: KeeperCap) {
        let KeeperCap {
            id     : v0,
            config : _,
            epoch  : _,
        } = arg0;
        0x2::object::delete(v0);
    }

    public fun emergency_slippage_bps(arg0: &Config) : u64 {
        assert_version(arg0);
        arg0.settings.emergency_slippage_bps
    }

    public fun entry_slippage_bps(arg0: &Config) : u64 {
        assert_version(arg0);
        arg0.settings.entry_slippage_bps
    }

    public fun halt(arg0: &AdminCap, arg1: &mut Config) {
        assert_version(arg1);
        let v0 = Halted{
            config : 0x2::object::id<Config>(arg1),
            from   : arg1.version,
        };
        0x2::event::emit<Halted>(v0);
        arg1.version = 0;
    }

    fun init(arg0: &mut 0x2::tx_context::TxContext) {
        let v0 = Settings{
            mint_fee_bps           : 0,
            redeem_fee_bps         : 30,
            streaming_fee_bps      : 200,
            ppx_bps                : 5000,
            referral_bps           : 2000,
            ppx_recipient          : 0x2::tx_context::sender(arg0),
            treasury               : 0x2::tx_context::sender(arg0),
            rebalance_slippage_bps : 50,
            emergency_slippage_bps : 300,
            entry_slippage_bps     : 100,
            unwind_chunk           : 100000000000,
        };
        validate(&v0);
        let v1 = Config{
            id             : 0x2::object::new(arg0),
            version        : 1,
            paused         : false,
            settings       : v0,
            pending        : 0x1::option::none<Pending>(),
            fee_index      : 0,
            fee_index_ms   : 0,
            keeper_epoch   : 0,
            pending_keeper : 0x1::option::none<PendingKeeper>(),
        };
        let v2 = SettingsChanged{
            config   : 0x2::object::id<Config>(&v1),
            settings : v0,
        };
        0x2::event::emit<SettingsChanged>(v2);
        0x2::transfer::share_object<Config>(v1);
        let v3 = AdminCap{id: 0x2::object::new(arg0)};
        0x2::transfer::public_transfer<AdminCap>(v3, 0x2::tx_context::sender(arg0));
    }

    public fun issue_keeper(arg0: &mut Config, arg1: &0x2::clock::Clock, arg2: &mut 0x2::tx_context::TxContext) {
        assert_version(arg0);
        assert!(0x1::option::is_some<PendingKeeper>(&arg0.pending_keeper), 6);
        let PendingKeeper {
            recipient : v0,
            after_ms  : v1,
        } = *0x1::option::borrow<PendingKeeper>(&arg0.pending_keeper);
        assert_window(v1, arg1);
        arg0.pending_keeper = 0x1::option::none<PendingKeeper>();
        let v2 = KeeperCap{
            id     : 0x2::object::new(arg2),
            config : 0x2::object::id<Config>(arg0),
            epoch  : arg0.keeper_epoch,
        };
        let v3 = KeeperIssued{
            config    : 0x2::object::id<Config>(arg0),
            recipient : v0,
            cap       : 0x2::object::id<KeeperCap>(&v2),
            epoch     : arg0.keeper_epoch,
        };
        0x2::event::emit<KeeperIssued>(v3);
        0x2::transfer::transfer<KeeperCap>(v2, v0);
    }

    public fun keeper_epoch(arg0: &Config) : u64 {
        assert_version(arg0);
        arg0.keeper_epoch
    }

    public fun migrate(arg0: &AdminCap, arg1: &mut Config) {
        assert!(arg1.version < 1, 1);
        let v0 = Migrated{
            config : 0x2::object::id<Config>(arg1),
            from   : arg1.version,
            to     : 1,
        };
        0x2::event::emit<Migrated>(v0);
        arg1.version = 1;
    }

    public fun mint_fee_bps(arg0: &Config) : u64 {
        assert_version(arg0);
        arg0.settings.mint_fee_bps
    }

    public fun new_settings(arg0: u64, arg1: u64, arg2: u64, arg3: u64, arg4: u64, arg5: address, arg6: address, arg7: u64, arg8: u64, arg9: u64, arg10: u64) : Settings {
        let v0 = Settings{
            mint_fee_bps           : arg0,
            redeem_fee_bps         : arg1,
            streaming_fee_bps      : arg2,
            ppx_bps                : arg3,
            referral_bps           : arg4,
            ppx_recipient          : arg5,
            treasury               : arg6,
            rebalance_slippage_bps : arg7,
            emergency_slippage_bps : arg8,
            entry_slippage_bps     : arg9,
            unwind_chunk           : arg10,
        };
        validate(&v0);
        v0
    }

    public fun notice_ms() : u64 {
        0
    }

    public fun paused(arg0: &Config) : bool {
        assert_version(arg0);
        arg0.paused
    }

    public fun pending(arg0: &Config) : 0x1::option::Option<Pending> {
        assert_version(arg0);
        arg0.pending
    }

    public fun ppx_bps(arg0: &Config) : u64 {
        assert_version(arg0);
        arg0.settings.ppx_bps
    }

    public fun ppx_recipient(arg0: &Config) : address {
        assert_version(arg0);
        arg0.settings.ppx_recipient
    }

    public fun propose(arg0: &AdminCap, arg1: &mut Config, arg2: Settings, arg3: &0x2::clock::Clock) {
        assert_version(arg1);
        validate(&arg2);
        let v0 = 0x2::clock::timestamp_ms(arg3) + 0;
        let v1 = Pending{
            settings : arg2,
            after_ms : v0,
        };
        arg1.pending = 0x1::option::some<Pending>(v1);
        let v2 = SettingsProposed{
            config   : 0x2::object::id<Config>(arg1),
            settings : arg2,
            after_ms : v0,
        };
        0x2::event::emit<SettingsProposed>(v2);
    }

    public fun propose_keeper(arg0: &AdminCap, arg1: &mut Config, arg2: address, arg3: &0x2::clock::Clock) {
        assert_version(arg1);
        let v0 = 0x2::clock::timestamp_ms(arg3) + 0;
        let v1 = PendingKeeper{
            recipient : arg2,
            after_ms  : v0,
        };
        arg1.pending_keeper = 0x1::option::some<PendingKeeper>(v1);
        let v2 = KeeperProposed{
            config    : 0x2::object::id<Config>(arg1),
            recipient : arg2,
            after_ms  : v0,
        };
        0x2::event::emit<KeeperProposed>(v2);
    }

    public fun rebalance_slippage_bps(arg0: &Config) : u64 {
        assert_version(arg0);
        arg0.settings.rebalance_slippage_bps
    }

    public fun redeem_fee_bps(arg0: &Config) : u64 {
        assert_version(arg0);
        arg0.settings.redeem_fee_bps
    }

    public fun referral_bps(arg0: &Config) : u64 {
        assert_version(arg0);
        arg0.settings.referral_bps
    }

    public fun revoke_keepers(arg0: &AdminCap, arg1: &mut Config) {
        assert_version(arg1);
        arg1.pending_keeper = 0x1::option::none<PendingKeeper>();
        arg1.keeper_epoch = arg1.keeper_epoch + 1;
        let v0 = KeepersChanged{
            config : 0x2::object::id<Config>(arg1),
            epoch  : arg1.keeper_epoch,
        };
        0x2::event::emit<KeepersChanged>(v0);
    }

    public fun set_paused(arg0: &AdminCap, arg1: &mut Config, arg2: bool) {
        assert_version(arg1);
        assert!(arg1.paused != arg2, 10);
        arg1.paused = arg2;
        let v0 = PauseChanged{
            config : 0x2::object::id<Config>(arg1),
            paused : arg2,
        };
        0x2::event::emit<PauseChanged>(v0);
    }

    public fun settings(arg0: &Config) : Settings {
        assert_version(arg0);
        arg0.settings
    }

    public fun streaming_fee_bps(arg0: &Config) : u64 {
        assert_version(arg0);
        arg0.settings.streaming_fee_bps
    }

    public fun streaming_fee_index(arg0: &Config, arg1: u64) : u128 {
        assert_version(arg0);
        let v0 = if (arg1 > arg0.fee_index_ms) {
            arg1 - arg0.fee_index_ms
        } else {
            0
        };
        arg0.fee_index + (arg0.settings.streaming_fee_bps as u128) * (v0 as u128)
    }

    public fun treasury(arg0: &Config) : address {
        assert_version(arg0);
        arg0.settings.treasury
    }

    public fun unwind_chunk(arg0: &Config) : u64 {
        assert_version(arg0);
        arg0.settings.unwind_chunk
    }

    fun validate(arg0: &Settings) {
        let v0 = if (arg0.mint_fee_bps <= 100) {
            if (arg0.redeem_fee_bps <= 100) {
                arg0.streaming_fee_bps <= 500
            } else {
                false
            }
        } else {
            false
        };
        assert!(v0, 2);
        assert!(arg0.ppx_bps <= 10000 && arg0.referral_bps <= 2000, 3);
        assert!(arg0.ppx_recipient != @0x0 && arg0.treasury != @0x0, 9);
        let v1 = if (arg0.rebalance_slippage_bps > 0) {
            if (arg0.rebalance_slippage_bps <= 100) {
                if (arg0.emergency_slippage_bps >= arg0.rebalance_slippage_bps) {
                    if (arg0.emergency_slippage_bps <= 500) {
                        if (arg0.entry_slippage_bps > 0) {
                            if (arg0.entry_slippage_bps <= 500) {
                                arg0.unwind_chunk >= 1000000000
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
                }
            } else {
                false
            }
        } else {
            false
        };
        assert!(v1, 2);
    }

    public fun version() : u64 {
        1
    }

    public fun window_ms() : u64 {
        604800000
    }

    // decompiled from Move bytecode v7
}

