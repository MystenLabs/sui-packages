module 0xf57afc9e167795075a5708d1aeda6355ee8d47ee8f029e07aeeb500fa11f82a2::config {
    struct Config has key {
        id: 0x2::object::UID,
        admin: address,
        fee_bps: u16,
        treasury: address,
        paused: bool,
        pending_admin: 0x1::option::Option<address>,
        creator_fee_bps: u16,
        min_tree_balance: u64,
    }

    public fun accept_admin(arg0: &mut Config, arg1: &mut 0x2::tx_context::TxContext) {
        let v0 = 0x1::option::extract<address>(&mut arg0.pending_admin);
        assert!(0x2::tx_context::sender(arg1) == v0, 0xf57afc9e167795075a5708d1aeda6355ee8d47ee8f029e07aeeb500fa11f82a2::errors::e_not_admin());
        arg0.admin = v0;
    }

    public fun admin(arg0: &Config) : address {
        arg0.admin
    }

    public fun creator_fee_bps(arg0: &Config) : u16 {
        arg0.creator_fee_bps
    }

    public fun fee_bps(arg0: &Config) : u16 {
        arg0.fee_bps
    }

    fun init(arg0: &mut 0x2::tx_context::TxContext) {
        let v0 = 0x2::tx_context::sender(arg0);
        let v1 = Config{
            id               : 0x2::object::new(arg0),
            admin            : v0,
            fee_bps          : 0,
            treasury         : v0,
            paused           : false,
            pending_admin    : 0x1::option::none<address>(),
            creator_fee_bps  : 50,
            min_tree_balance : 100000000000,
        };
        0x2::transfer::share_object<Config>(v1);
    }

    public fun is_paused(arg0: &Config) : bool {
        arg0.paused
    }

    public fun min_tree_balance(arg0: &Config) : u64 {
        arg0.min_tree_balance
    }

    public fun pending_admin(arg0: &Config) : 0x1::option::Option<address> {
        arg0.pending_admin
    }

    public fun propose_admin(arg0: &mut Config, arg1: address, arg2: &mut 0x2::tx_context::TxContext) {
        assert!(0x2::tx_context::sender(arg2) == arg0.admin, 0xf57afc9e167795075a5708d1aeda6355ee8d47ee8f029e07aeeb500fa11f82a2::errors::e_not_admin());
        assert!(arg1 != @0x0, 0xf57afc9e167795075a5708d1aeda6355ee8d47ee8f029e07aeeb500fa11f82a2::errors::e_zero_address_not_allowed());
        arg0.pending_admin = 0x1::option::some<address>(arg1);
    }

    public fun set_paused(arg0: &mut Config, arg1: bool, arg2: &mut 0x2::tx_context::TxContext, arg3: &0x2::clock::Clock) {
        assert!(0x2::tx_context::sender(arg2) == arg0.admin, 0xf57afc9e167795075a5708d1aeda6355ee8d47ee8f029e07aeeb500fa11f82a2::errors::e_not_admin());
        arg0.paused = arg1;
        0xf57afc9e167795075a5708d1aeda6355ee8d47ee8f029e07aeeb500fa11f82a2::events::emit_paused(arg0.admin, arg1, 0x2::clock::timestamp_ms(arg3) / 1000);
    }

    public fun treasury(arg0: &Config) : address {
        arg0.treasury
    }

    public fun update_creator_fee(arg0: &mut Config, arg1: u16, arg2: &mut 0x2::tx_context::TxContext, arg3: &0x2::clock::Clock) {
        assert!(0x2::tx_context::sender(arg2) == arg0.admin, 0xf57afc9e167795075a5708d1aeda6355ee8d47ee8f029e07aeeb500fa11f82a2::errors::e_not_admin());
        assert!((arg1 as u64) <= 0xf57afc9e167795075a5708d1aeda6355ee8d47ee8f029e07aeeb500fa11f82a2::math::max_creator_fee_bps(), 0xf57afc9e167795075a5708d1aeda6355ee8d47ee8f029e07aeeb500fa11f82a2::errors::e_invalid_fee_bps());
        arg0.creator_fee_bps = arg1;
    }

    public fun update_fee(arg0: &mut Config, arg1: u16, arg2: &mut 0x2::tx_context::TxContext, arg3: &0x2::clock::Clock) {
        assert!(0x2::tx_context::sender(arg2) == arg0.admin, 0xf57afc9e167795075a5708d1aeda6355ee8d47ee8f029e07aeeb500fa11f82a2::errors::e_not_admin());
        assert!((arg1 as u64) <= 0xf57afc9e167795075a5708d1aeda6355ee8d47ee8f029e07aeeb500fa11f82a2::math::max_fee_bps(), 0xf57afc9e167795075a5708d1aeda6355ee8d47ee8f029e07aeeb500fa11f82a2::errors::e_invalid_fee_bps());
        arg0.fee_bps = arg1;
        0xf57afc9e167795075a5708d1aeda6355ee8d47ee8f029e07aeeb500fa11f82a2::events::emit_config_updated(arg0.admin, arg1, 0x2::clock::timestamp_ms(arg3) / 1000);
    }

    public fun update_min_tree_balance(arg0: &mut Config, arg1: u64, arg2: &mut 0x2::tx_context::TxContext, arg3: &0x2::clock::Clock) {
        assert!(0x2::tx_context::sender(arg2) == arg0.admin, 0xf57afc9e167795075a5708d1aeda6355ee8d47ee8f029e07aeeb500fa11f82a2::errors::e_not_admin());
        arg0.min_tree_balance = arg1;
    }

    public fun update_treasury(arg0: &mut Config, arg1: address, arg2: &mut 0x2::tx_context::TxContext, arg3: &0x2::clock::Clock) {
        assert!(0x2::tx_context::sender(arg2) == arg0.admin, 0xf57afc9e167795075a5708d1aeda6355ee8d47ee8f029e07aeeb500fa11f82a2::errors::e_not_admin());
        assert!(arg1 != @0x0, 0xf57afc9e167795075a5708d1aeda6355ee8d47ee8f029e07aeeb500fa11f82a2::errors::e_zero_address_not_allowed());
        arg0.treasury = arg1;
        0xf57afc9e167795075a5708d1aeda6355ee8d47ee8f029e07aeeb500fa11f82a2::events::emit_treasury_updated(arg0.treasury, arg1, arg0.admin, 0x2::clock::timestamp_ms(arg3) / 1000);
    }

    // decompiled from Move bytecode v7
}

