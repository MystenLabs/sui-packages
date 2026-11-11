module 0x1f75c33b9dde9d4614133dcdcb6116e49fc5d77bfa54cee8d4c8f5a5091bc4b3::global {
    struct AdminCap has key {
        id: 0x2::object::UID,
    }

    struct Config has key {
        id: 0x2::object::UID,
        team_wallet: address,
        paused: bool,
        version: u64,
        admin_cap_id: 0x2::object::ID,
        pending_admin: 0x1::option::Option<address>,
    }

    struct TeamWalletUpdated has copy, drop {
        old: address,
        new_wallet: address,
    }

    struct PauseToggled has copy, drop {
        paused: bool,
    }

    struct AdminProposed has copy, drop {
        proposed: address,
    }

    struct AdminProposalCancelled has copy, drop {
        cancelled: address,
    }

    struct AdminChanged has copy, drop {
        old_cap_id: 0x2::object::ID,
        new_cap_id: 0x2::object::ID,
        new_admin: address,
    }

    struct Migrated has copy, drop {
        from_version: u64,
        to_version: u64,
    }

    public entry fun accept_admin(arg0: &mut Config, arg1: &mut 0x2::tx_context::TxContext) {
        assert!(0x1::option::is_some<address>(&arg0.pending_admin), 2);
        assert!(*0x1::option::borrow<address>(&arg0.pending_admin) == 0x2::tx_context::sender(arg1), 2);
        let v0 = AdminCap{id: 0x2::object::new(arg1)};
        let v1 = 0x2::object::id<AdminCap>(&v0);
        arg0.admin_cap_id = v1;
        arg0.pending_admin = 0x1::option::none<address>();
        0x2::transfer::transfer<AdminCap>(v0, 0x2::tx_context::sender(arg1));
        let v2 = AdminChanged{
            old_cap_id : arg0.admin_cap_id,
            new_cap_id : v1,
            new_admin  : 0x2::tx_context::sender(arg1),
        };
        0x2::event::emit<AdminChanged>(v2);
    }

    public fun admin_cap_id(arg0: &Config) : 0x2::object::ID {
        arg0.admin_cap_id
    }

    fun assert_admin(arg0: &AdminCap, arg1: &Config) {
        assert!(0x2::object::id<AdminCap>(arg0) == arg1.admin_cap_id, 0);
    }

    public fun assert_version(arg0: &Config) {
        assert!(arg0.version == 1, 1);
    }

    public entry fun cancel_admin_proposal(arg0: &AdminCap, arg1: &mut Config) {
        assert_admin(arg0, arg1);
        assert!(0x1::option::is_some<address>(&arg1.pending_admin), 2);
        let v0 = AdminProposalCancelled{cancelled: 0x1::option::extract<address>(&mut arg1.pending_admin)};
        0x2::event::emit<AdminProposalCancelled>(v0);
    }

    public fun creator_fee_bps() : u64 {
        50
    }

    public fun creator_lock_ms() : u64 {
        600000
    }

    public fun curve_slope_mist() : u128 {
        100000
    }

    public fun fee_denom() : u64 {
        10000
    }

    public fun graduation_reserve_mist() : u128 {
        1000000000
    }

    fun init(arg0: &mut 0x2::tx_context::TxContext) {
        let v0 = AdminCap{id: 0x2::object::new(arg0)};
        0x2::transfer::transfer<AdminCap>(v0, 0x2::tx_context::sender(arg0));
        let v1 = Config{
            id            : 0x2::object::new(arg0),
            team_wallet   : 0x2::tx_context::sender(arg0),
            paused        : false,
            version       : 1,
            admin_cap_id  : 0x2::object::id<AdminCap>(&v0),
            pending_admin : 0x1::option::none<address>(),
        };
        0x2::transfer::share_object<Config>(v1);
    }

    public fun is_paused(arg0: &Config) : bool {
        arg0.paused
    }

    public fun launch_fee_mist() : u64 {
        100000000
    }

    public entry fun migrate(arg0: &AdminCap, arg1: &mut Config) {
        assert_admin(arg0, arg1);
        assert!(arg1.version < 1, 3);
        arg1.version = 1;
        let v0 = Migrated{
            from_version : arg1.version,
            to_version   : 1,
        };
        0x2::event::emit<Migrated>(v0);
    }

    public fun package_version() : u64 {
        1
    }

    public fun pending_admin(arg0: &Config) : 0x1::option::Option<address> {
        arg0.pending_admin
    }

    public entry fun propose_admin(arg0: &AdminCap, arg1: &mut Config, arg2: address) {
        assert_admin(arg0, arg1);
        arg1.pending_admin = 0x1::option::some<address>(arg2);
        let v0 = AdminProposed{proposed: arg2};
        0x2::event::emit<AdminProposed>(v0);
    }

    public entry fun set_paused(arg0: &AdminCap, arg1: &mut Config, arg2: bool) {
        assert_admin(arg0, arg1);
        arg1.paused = arg2;
        let v0 = PauseToggled{paused: arg2};
        0x2::event::emit<PauseToggled>(v0);
    }

    public entry fun set_team_wallet(arg0: &AdminCap, arg1: &mut Config, arg2: address) {
        assert_admin(arg0, arg1);
        arg1.team_wallet = arg2;
        let v0 = TeamWalletUpdated{
            old        : arg1.team_wallet,
            new_wallet : arg2,
        };
        0x2::event::emit<TeamWalletUpdated>(v0);
    }

    public fun team_fee_bps() : u64 {
        50
    }

    public fun team_wallet(arg0: &Config) : address {
        arg0.team_wallet
    }

    public fun total_fee_bps() : u64 {
        100
    }

    public fun trade_cooldown_ms() : u64 {
        5000
    }

    public fun unwind_delay_ms() : u64 {
        300000
    }

    public fun version(arg0: &Config) : u64 {
        arg0.version
    }

    // decompiled from Move bytecode v7
}

