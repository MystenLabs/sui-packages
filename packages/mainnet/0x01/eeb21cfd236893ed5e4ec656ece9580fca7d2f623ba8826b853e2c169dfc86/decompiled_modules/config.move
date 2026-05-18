module 0x1eeb21cfd236893ed5e4ec656ece9580fca7d2f623ba8826b853e2c169dfc86::config {
    struct Config has key {
        id: 0x2::object::UID,
        admin: address,
        fee_bps: u16,
        treasury: address,
        coin_treasuries: 0x2::table::Table<0x1::ascii::String, address>,
        paused: bool,
        pending_admin: 0x1::option::Option<address>,
    }

    public fun accept_admin(arg0: &mut Config, arg1: &mut 0x2::tx_context::TxContext) {
        let v0 = 0x1::option::extract<address>(&mut arg0.pending_admin);
        assert!(0x2::tx_context::sender(arg1) == v0, 0x1eeb21cfd236893ed5e4ec656ece9580fca7d2f623ba8826b853e2c169dfc86::errors::e_not_admin());
        arg0.admin = v0;
    }

    public fun admin(arg0: &Config) : address {
        arg0.admin
    }

    public fun coin_key<T0>() : 0x1::ascii::String {
        0x1::type_name::into_string(0x1::type_name::with_original_ids<T0>())
    }

    public fun coin_treasury<T0>(arg0: &Config) : address {
        let v0 = coin_key<T0>();
        assert!(0x2::table::contains<0x1::ascii::String, address>(&arg0.coin_treasuries, v0), 0x1eeb21cfd236893ed5e4ec656ece9580fca7d2f623ba8826b853e2c169dfc86::errors::e_coin_not_listed());
        *0x2::table::borrow<0x1::ascii::String, address>(&arg0.coin_treasuries, v0)
    }

    public fun fee_bps(arg0: &Config) : u16 {
        arg0.fee_bps
    }

    fun init(arg0: &mut 0x2::tx_context::TxContext) {
        let v0 = 0x2::tx_context::sender(arg0);
        let v1 = 0x2::table::new<0x1::ascii::String, address>(arg0);
        0x2::table::add<0x1::ascii::String, address>(&mut v1, coin_key<0x2::sui::SUI>(), v0);
        let v2 = Config{
            id              : 0x2::object::new(arg0),
            admin           : v0,
            fee_bps         : 1000,
            treasury        : v0,
            coin_treasuries : v1,
            paused          : false,
            pending_admin   : 0x1::option::none<address>(),
        };
        0x2::transfer::share_object<Config>(v2);
    }

    public fun is_coin_listed<T0>(arg0: &Config) : bool {
        0x2::table::contains<0x1::ascii::String, address>(&arg0.coin_treasuries, coin_key<T0>())
    }

    public fun is_paused(arg0: &Config) : bool {
        arg0.paused
    }

    public fun list_coin<T0>(arg0: &mut Config, arg1: address, arg2: &mut 0x2::tx_context::TxContext) {
        assert!(0x2::tx_context::sender(arg2) == arg0.admin, 0x1eeb21cfd236893ed5e4ec656ece9580fca7d2f623ba8826b853e2c169dfc86::errors::e_not_admin());
        assert!(arg1 != @0x0, 0x1eeb21cfd236893ed5e4ec656ece9580fca7d2f623ba8826b853e2c169dfc86::errors::e_zero_address_not_allowed());
        let v0 = coin_key<T0>();
        assert!(!0x2::table::contains<0x1::ascii::String, address>(&arg0.coin_treasuries, v0), 0x1eeb21cfd236893ed5e4ec656ece9580fca7d2f623ba8826b853e2c169dfc86::errors::e_coin_already_listed());
        0x2::table::add<0x1::ascii::String, address>(&mut arg0.coin_treasuries, v0, arg1);
    }

    public fun pending_admin(arg0: &Config) : 0x1::option::Option<address> {
        arg0.pending_admin
    }

    public fun propose_admin(arg0: &mut Config, arg1: address, arg2: &mut 0x2::tx_context::TxContext) {
        assert!(0x2::tx_context::sender(arg2) == arg0.admin, 0x1eeb21cfd236893ed5e4ec656ece9580fca7d2f623ba8826b853e2c169dfc86::errors::e_not_admin());
        assert!(arg1 != @0x0, 0x1eeb21cfd236893ed5e4ec656ece9580fca7d2f623ba8826b853e2c169dfc86::errors::e_zero_address_not_allowed());
        arg0.pending_admin = 0x1::option::some<address>(arg1);
    }

    public fun set_paused(arg0: &mut Config, arg1: bool, arg2: &mut 0x2::tx_context::TxContext, arg3: &0x2::clock::Clock) {
        assert!(0x2::tx_context::sender(arg2) == arg0.admin, 0x1eeb21cfd236893ed5e4ec656ece9580fca7d2f623ba8826b853e2c169dfc86::errors::e_not_admin());
        arg0.paused = arg1;
        0x1eeb21cfd236893ed5e4ec656ece9580fca7d2f623ba8826b853e2c169dfc86::events::emit_paused(arg0.admin, arg1, 0x2::clock::timestamp_ms(arg3) / 1000);
    }

    public fun treasury(arg0: &Config) : address {
        arg0.treasury
    }

    public fun update_coin_treasury<T0>(arg0: &mut Config, arg1: address, arg2: &mut 0x2::tx_context::TxContext) {
        assert!(0x2::tx_context::sender(arg2) == arg0.admin, 0x1eeb21cfd236893ed5e4ec656ece9580fca7d2f623ba8826b853e2c169dfc86::errors::e_not_admin());
        assert!(arg1 != @0x0, 0x1eeb21cfd236893ed5e4ec656ece9580fca7d2f623ba8826b853e2c169dfc86::errors::e_zero_address_not_allowed());
        let v0 = coin_key<T0>();
        assert!(0x2::table::contains<0x1::ascii::String, address>(&arg0.coin_treasuries, v0), 0x1eeb21cfd236893ed5e4ec656ece9580fca7d2f623ba8826b853e2c169dfc86::errors::e_coin_not_listed());
        *0x2::table::borrow_mut<0x1::ascii::String, address>(&mut arg0.coin_treasuries, v0) = arg1;
    }

    public fun update_fee(arg0: &mut Config, arg1: u16, arg2: &mut 0x2::tx_context::TxContext, arg3: &0x2::clock::Clock) {
        assert!(0x2::tx_context::sender(arg2) == arg0.admin, 0x1eeb21cfd236893ed5e4ec656ece9580fca7d2f623ba8826b853e2c169dfc86::errors::e_not_admin());
        assert!((arg1 as u64) <= 0x1eeb21cfd236893ed5e4ec656ece9580fca7d2f623ba8826b853e2c169dfc86::math::max_fee_bps(), 0x1eeb21cfd236893ed5e4ec656ece9580fca7d2f623ba8826b853e2c169dfc86::errors::e_invalid_fee_bps());
        arg0.fee_bps = arg1;
        0x1eeb21cfd236893ed5e4ec656ece9580fca7d2f623ba8826b853e2c169dfc86::events::emit_config_updated(arg0.admin, arg1, 0x2::clock::timestamp_ms(arg3) / 1000);
    }

    public fun update_treasury(arg0: &mut Config, arg1: address, arg2: &mut 0x2::tx_context::TxContext, arg3: &0x2::clock::Clock) {
        assert!(0x2::tx_context::sender(arg2) == arg0.admin, 0x1eeb21cfd236893ed5e4ec656ece9580fca7d2f623ba8826b853e2c169dfc86::errors::e_not_admin());
        assert!(arg1 != @0x0, 0x1eeb21cfd236893ed5e4ec656ece9580fca7d2f623ba8826b853e2c169dfc86::errors::e_zero_address_not_allowed());
        arg0.treasury = arg1;
        0x1eeb21cfd236893ed5e4ec656ece9580fca7d2f623ba8826b853e2c169dfc86::events::emit_treasury_updated(arg0.treasury, arg1, arg0.admin, 0x2::clock::timestamp_ms(arg3) / 1000);
    }

    // decompiled from Move bytecode v6
}

