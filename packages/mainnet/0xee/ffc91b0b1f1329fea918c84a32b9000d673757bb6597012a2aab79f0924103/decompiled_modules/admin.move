module 0xba0b81fdf50cba87ac4a95686dfed7baf21323adea809b41875b040fff6c072a::admin {
    struct AdminCapBurnedEvent has copy, drop {
        burned_by: address,
    }

    public fun bootstrap_register_harvest_protocol(arg0: &mut 0xba0b81fdf50cba87ac4a95686dfed7baf21323adea809b41875b040fff6c072a::harvest::HarvestConfig, arg1: &0xc8b07577c7390e9f8749d031f980676d060e22d819c3577b02573018959e68dd::vault::AdminCap, arg2: u8, arg3: u64) {
        0xba0b81fdf50cba87ac4a95686dfed7baf21323adea809b41875b040fff6c072a::harvest::register_harvest_protocol(arg0, arg1, arg2, arg3);
    }

    public fun bootstrap_register_protocol(arg0: &mut 0xba0b81fdf50cba87ac4a95686dfed7baf21323adea809b41875b040fff6c072a::strategy::StrategyRegistry, arg1: &0xc8b07577c7390e9f8749d031f980676d060e22d819c3577b02573018959e68dd::vault::AdminCap, arg2: u8, arg3: vector<u8>, arg4: bool) {
        assert!(0xba0b81fdf50cba87ac4a95686dfed7baf21323adea809b41875b040fff6c072a::strategy::count_available(arg0) < 14, 903);
        0xba0b81fdf50cba87ac4a95686dfed7baf21323adea809b41875b040fff6c072a::strategy::register_protocol(arg0, arg1, arg2, 0x1::string::utf8(arg3), arg4);
    }

    public fun bootstrap_register_tvl_object(arg0: &mut 0xba0b81fdf50cba87ac4a95686dfed7baf21323adea809b41875b040fff6c072a::tvl::TvlRegistry, arg1: &0xc8b07577c7390e9f8749d031f980676d060e22d819c3577b02573018959e68dd::vault::AdminCap, arg2: u8, arg3: address) {
        assert!(!0xba0b81fdf50cba87ac4a95686dfed7baf21323adea809b41875b040fff6c072a::tvl::has_registered_object(arg0, arg2), 903);
        0xba0b81fdf50cba87ac4a95686dfed7baf21323adea809b41875b040fff6c072a::tvl::register_protocol_object(arg0, arg1, arg2, arg3);
    }

    public fun burn_admin_cap(arg0: 0xc8b07577c7390e9f8749d031f980676d060e22d819c3577b02573018959e68dd::vault::AdminCap, arg1: &0x2::tx_context::TxContext) {
        let v0 = AdminCapBurnedEvent{burned_by: 0x2::tx_context::sender(arg1)};
        0x2::event::emit<AdminCapBurnedEvent>(v0);
        0xc8b07577c7390e9f8749d031f980676d060e22d819c3577b02573018959e68dd::vault::burn_admin_cap(arg0);
    }

    public fun execute_increase_tvl_cap(arg0: &mut 0xc8b07577c7390e9f8749d031f980676d060e22d819c3577b02573018959e68dd::timelock::TimelockRegistry, arg1: &mut 0xc8b07577c7390e9f8749d031f980676d060e22d819c3577b02573018959e68dd::vault::Vault, arg2: &0xc8b07577c7390e9f8749d031f980676d060e22d819c3577b02573018959e68dd::vault::AdminCap, arg3: u64, arg4: &0x2::clock::Clock) {
        let (v0, v1) = 0xc8b07577c7390e9f8749d031f980676d060e22d819c3577b02573018959e68dd::timelock::execute(arg0, arg3, arg4);
        assert!(v0 == 0xc8b07577c7390e9f8749d031f980676d060e22d819c3577b02573018959e68dd::timelock::action_update_tvl_cap(), 901);
        let v2 = 0x2::bcs::new(v1);
        0xc8b07577c7390e9f8749d031f980676d060e22d819c3577b02573018959e68dd::vault::update_tvl_cap(arg1, arg2, 0x2::bcs::peel_u64(&mut v2));
    }

    public fun execute_register_harvest_protocol(arg0: &mut 0xc8b07577c7390e9f8749d031f980676d060e22d819c3577b02573018959e68dd::timelock::TimelockRegistry, arg1: &mut 0xba0b81fdf50cba87ac4a95686dfed7baf21323adea809b41875b040fff6c072a::harvest::HarvestConfig, arg2: &0xc8b07577c7390e9f8749d031f980676d060e22d819c3577b02573018959e68dd::vault::AdminCap, arg3: u64, arg4: &0x2::clock::Clock) {
        let (v0, v1) = 0xc8b07577c7390e9f8749d031f980676d060e22d819c3577b02573018959e68dd::timelock::execute(arg0, arg3, arg4);
        assert!(v0 == 11, 901);
        let v2 = 0x2::bcs::new(v1);
        0xba0b81fdf50cba87ac4a95686dfed7baf21323adea809b41875b040fff6c072a::harvest::register_harvest_protocol(arg1, arg2, 0x2::bcs::peel_u8(&mut v2), 0x2::bcs::peel_u64(&mut v2));
    }

    public fun execute_register_protocol(arg0: &mut 0xc8b07577c7390e9f8749d031f980676d060e22d819c3577b02573018959e68dd::timelock::TimelockRegistry, arg1: &mut 0xba0b81fdf50cba87ac4a95686dfed7baf21323adea809b41875b040fff6c072a::strategy::StrategyRegistry, arg2: &0xc8b07577c7390e9f8749d031f980676d060e22d819c3577b02573018959e68dd::vault::AdminCap, arg3: u64, arg4: &0x2::clock::Clock) {
        let (v0, v1) = 0xc8b07577c7390e9f8749d031f980676d060e22d819c3577b02573018959e68dd::timelock::execute(arg0, arg3, arg4);
        assert!(v0 == 0xc8b07577c7390e9f8749d031f980676d060e22d819c3577b02573018959e68dd::timelock::action_register_protocol(), 901);
        let v2 = 0x2::bcs::new(v1);
        0xba0b81fdf50cba87ac4a95686dfed7baf21323adea809b41875b040fff6c072a::strategy::register_protocol(arg1, arg2, 0x2::bcs::peel_u8(&mut v2), 0x1::string::utf8(0x2::bcs::peel_vec_u8(&mut v2)), 0x2::bcs::peel_bool(&mut v2));
    }

    public fun execute_register_tvl_object(arg0: &mut 0xc8b07577c7390e9f8749d031f980676d060e22d819c3577b02573018959e68dd::timelock::TimelockRegistry, arg1: &mut 0xba0b81fdf50cba87ac4a95686dfed7baf21323adea809b41875b040fff6c072a::tvl::TvlRegistry, arg2: &0xc8b07577c7390e9f8749d031f980676d060e22d819c3577b02573018959e68dd::vault::AdminCap, arg3: u64, arg4: &0x2::clock::Clock) {
        let (v0, v1) = 0xc8b07577c7390e9f8749d031f980676d060e22d819c3577b02573018959e68dd::timelock::execute(arg0, arg3, arg4);
        assert!(v0 == 10, 901);
        let v2 = 0x2::bcs::new(v1);
        0xba0b81fdf50cba87ac4a95686dfed7baf21323adea809b41875b040fff6c072a::tvl::register_protocol_object(arg1, arg2, 0x2::bcs::peel_u8(&mut v2), 0x2::bcs::peel_address(&mut v2));
    }

    public fun execute_set_ema_alpha(arg0: &mut 0xba0b81fdf50cba87ac4a95686dfed7baf21323adea809b41875b040fff6c072a::apy::ApyRegistry, arg1: &0xc8b07577c7390e9f8749d031f980676d060e22d819c3577b02573018959e68dd::vault::AdminCap, arg2: &mut 0xc8b07577c7390e9f8749d031f980676d060e22d819c3577b02573018959e68dd::timelock::TimelockRegistry, arg3: u64, arg4: &0x2::clock::Clock) {
        let (v0, v1) = 0xc8b07577c7390e9f8749d031f980676d060e22d819c3577b02573018959e68dd::timelock::execute(arg2, arg3, arg4);
        assert!(v0 == 6, 901);
        let v2 = 0x2::bcs::new(v1);
        0xba0b81fdf50cba87ac4a95686dfed7baf21323adea809b41875b040fff6c072a::apy::set_ema_alpha(arg0, arg1, 0x2::bcs::peel_u64(&mut v2));
    }

    public fun execute_set_fee_recipient(arg0: &mut 0xc8b07577c7390e9f8749d031f980676d060e22d819c3577b02573018959e68dd::timelock::TimelockRegistry, arg1: &mut 0xc8b07577c7390e9f8749d031f980676d060e22d819c3577b02573018959e68dd::vault::Vault, arg2: &0xc8b07577c7390e9f8749d031f980676d060e22d819c3577b02573018959e68dd::vault::AdminCap, arg3: u64, arg4: &0x2::clock::Clock) {
        let (v0, v1) = 0xc8b07577c7390e9f8749d031f980676d060e22d819c3577b02573018959e68dd::timelock::execute(arg0, arg3, arg4);
        assert!(v0 == 0xc8b07577c7390e9f8749d031f980676d060e22d819c3577b02573018959e68dd::timelock::action_set_fee_recipient(), 901);
        let v2 = 0x2::bcs::new(v1);
        0xc8b07577c7390e9f8749d031f980676d060e22d819c3577b02573018959e68dd::vault::update_fee_recipient(arg1, arg2, 0x2::bcs::peel_address(&mut v2));
    }

    public fun execute_set_harvest_cooldown(arg0: &mut 0xc8b07577c7390e9f8749d031f980676d060e22d819c3577b02573018959e68dd::timelock::TimelockRegistry, arg1: &mut 0xba0b81fdf50cba87ac4a95686dfed7baf21323adea809b41875b040fff6c072a::harvest::HarvestConfig, arg2: &0xc8b07577c7390e9f8749d031f980676d060e22d819c3577b02573018959e68dd::vault::AdminCap, arg3: u64, arg4: &0x2::clock::Clock) {
        let (v0, v1) = 0xc8b07577c7390e9f8749d031f980676d060e22d819c3577b02573018959e68dd::timelock::execute(arg0, arg3, arg4);
        assert!(v0 == 7, 901);
        let v2 = 0x2::bcs::new(v1);
        0xba0b81fdf50cba87ac4a95686dfed7baf21323adea809b41875b040fff6c072a::harvest::set_cooldown_ms(arg1, arg2, 0x2::bcs::peel_u64(&mut v2));
    }

    public fun execute_set_harvest_slippage(arg0: &mut 0xc8b07577c7390e9f8749d031f980676d060e22d819c3577b02573018959e68dd::timelock::TimelockRegistry, arg1: &mut 0xba0b81fdf50cba87ac4a95686dfed7baf21323adea809b41875b040fff6c072a::harvest::HarvestConfig, arg2: &0xc8b07577c7390e9f8749d031f980676d060e22d819c3577b02573018959e68dd::vault::AdminCap, arg3: u64, arg4: &0x2::clock::Clock) {
        let (v0, v1) = 0xc8b07577c7390e9f8749d031f980676d060e22d819c3577b02573018959e68dd::timelock::execute(arg0, arg3, arg4);
        assert!(v0 == 9, 901);
        let v2 = 0x2::bcs::new(v1);
        0xba0b81fdf50cba87ac4a95686dfed7baf21323adea809b41875b040fff6c072a::harvest::set_harvest_slippage_bps(arg1, arg2, 0x2::bcs::peel_u64(&mut v2));
    }

    public fun execute_set_harvest_threshold(arg0: &mut 0xc8b07577c7390e9f8749d031f980676d060e22d819c3577b02573018959e68dd::timelock::TimelockRegistry, arg1: &mut 0xba0b81fdf50cba87ac4a95686dfed7baf21323adea809b41875b040fff6c072a::harvest::HarvestConfig, arg2: &0xc8b07577c7390e9f8749d031f980676d060e22d819c3577b02573018959e68dd::vault::AdminCap, arg3: u64, arg4: &0x2::clock::Clock) {
        let (v0, v1) = 0xc8b07577c7390e9f8749d031f980676d060e22d819c3577b02573018959e68dd::timelock::execute(arg0, arg3, arg4);
        assert!(v0 == 8, 901);
        let v2 = 0x2::bcs::new(v1);
        0xba0b81fdf50cba87ac4a95686dfed7baf21323adea809b41875b040fff6c072a::harvest::set_min_threshold(arg1, arg2, 0x2::bcs::peel_u8(&mut v2), 0x2::bcs::peel_u64(&mut v2));
    }

    public fun execute_update_config(arg0: &mut 0xc8b07577c7390e9f8749d031f980676d060e22d819c3577b02573018959e68dd::timelock::TimelockRegistry, arg1: &mut 0xba0b81fdf50cba87ac4a95686dfed7baf21323adea809b41875b040fff6c072a::crank::CrankConfig, arg2: &0xc8b07577c7390e9f8749d031f980676d060e22d819c3577b02573018959e68dd::vault::AdminCap, arg3: u64, arg4: &0x2::clock::Clock) {
        let (v0, v1) = 0xc8b07577c7390e9f8749d031f980676d060e22d819c3577b02573018959e68dd::timelock::execute(arg0, arg3, arg4);
        assert!(v0 == 0xc8b07577c7390e9f8749d031f980676d060e22d819c3577b02573018959e68dd::timelock::action_update_crank_config(), 901);
        let v2 = 0x2::bcs::new(v1);
        0xba0b81fdf50cba87ac4a95686dfed7baf21323adea809b41875b040fff6c072a::crank::update_config(arg1, arg2, 0x2::bcs::peel_u64(&mut v2), 0x2::bcs::peel_u64(&mut v2), 0x2::bcs::peel_u64(&mut v2), 0x2::bcs::peel_u64(&mut v2), 0x2::bcs::peel_u64(&mut v2), 0x2::bcs::peel_u64(&mut v2), 0x2::bcs::peel_u64(&mut v2));
    }

    public fun execute_update_fee(arg0: &mut 0xc8b07577c7390e9f8749d031f980676d060e22d819c3577b02573018959e68dd::timelock::TimelockRegistry, arg1: &mut 0xc8b07577c7390e9f8749d031f980676d060e22d819c3577b02573018959e68dd::vault::Vault, arg2: &0xc8b07577c7390e9f8749d031f980676d060e22d819c3577b02573018959e68dd::vault::AdminCap, arg3: u64, arg4: &0x2::clock::Clock) {
        let (v0, v1) = 0xc8b07577c7390e9f8749d031f980676d060e22d819c3577b02573018959e68dd::timelock::execute(arg0, arg3, arg4);
        assert!(v0 == 0xc8b07577c7390e9f8749d031f980676d060e22d819c3577b02573018959e68dd::timelock::action_update_fee(), 901);
        let v2 = 0x2::bcs::new(v1);
        0xc8b07577c7390e9f8749d031f980676d060e22d819c3577b02573018959e68dd::vault::update_performance_fee(arg1, arg2, 0x2::bcs::peel_u64(&mut v2));
    }

    public fun propose_increase_tvl_cap(arg0: &0xc8b07577c7390e9f8749d031f980676d060e22d819c3577b02573018959e68dd::vault::AdminCap, arg1: &mut 0xc8b07577c7390e9f8749d031f980676d060e22d819c3577b02573018959e68dd::timelock::TimelockRegistry, arg2: u64, arg3: &0x2::clock::Clock, arg4: &0x2::tx_context::TxContext) : u64 {
        0xc8b07577c7390e9f8749d031f980676d060e22d819c3577b02573018959e68dd::timelock::propose(arg1, arg0, 0xc8b07577c7390e9f8749d031f980676d060e22d819c3577b02573018959e68dd::timelock::action_update_tvl_cap(), 0x2::bcs::to_bytes<u64>(&arg2), arg3, arg4)
    }

    public fun propose_register_harvest_protocol(arg0: &0xc8b07577c7390e9f8749d031f980676d060e22d819c3577b02573018959e68dd::vault::AdminCap, arg1: &mut 0xc8b07577c7390e9f8749d031f980676d060e22d819c3577b02573018959e68dd::timelock::TimelockRegistry, arg2: u8, arg3: u64, arg4: &0x2::clock::Clock, arg5: &0x2::tx_context::TxContext) : u64 {
        let v0 = 0x1::vector::empty<u8>();
        0x1::vector::append<u8>(&mut v0, 0x2::bcs::to_bytes<u8>(&arg2));
        0x1::vector::append<u8>(&mut v0, 0x2::bcs::to_bytes<u64>(&arg3));
        0xc8b07577c7390e9f8749d031f980676d060e22d819c3577b02573018959e68dd::timelock::propose(arg1, arg0, 11, v0, arg4, arg5)
    }

    public fun propose_register_protocol(arg0: &0xc8b07577c7390e9f8749d031f980676d060e22d819c3577b02573018959e68dd::vault::AdminCap, arg1: &mut 0xc8b07577c7390e9f8749d031f980676d060e22d819c3577b02573018959e68dd::timelock::TimelockRegistry, arg2: u8, arg3: vector<u8>, arg4: bool, arg5: &0x2::clock::Clock, arg6: &0x2::tx_context::TxContext) : u64 {
        let v0 = 0x1::vector::empty<u8>();
        0x1::vector::append<u8>(&mut v0, 0x2::bcs::to_bytes<u8>(&arg2));
        0x1::vector::append<u8>(&mut v0, 0x2::bcs::to_bytes<vector<u8>>(&arg3));
        0x1::vector::append<u8>(&mut v0, 0x2::bcs::to_bytes<bool>(&arg4));
        0xc8b07577c7390e9f8749d031f980676d060e22d819c3577b02573018959e68dd::timelock::propose(arg1, arg0, 0xc8b07577c7390e9f8749d031f980676d060e22d819c3577b02573018959e68dd::timelock::action_register_protocol(), v0, arg5, arg6)
    }

    public fun propose_register_tvl_object(arg0: &0xc8b07577c7390e9f8749d031f980676d060e22d819c3577b02573018959e68dd::vault::AdminCap, arg1: &mut 0xc8b07577c7390e9f8749d031f980676d060e22d819c3577b02573018959e68dd::timelock::TimelockRegistry, arg2: u8, arg3: address, arg4: &0x2::clock::Clock, arg5: &0x2::tx_context::TxContext) : u64 {
        let v0 = 0x1::vector::empty<u8>();
        0x1::vector::append<u8>(&mut v0, 0x2::bcs::to_bytes<u8>(&arg2));
        0x1::vector::append<u8>(&mut v0, 0x2::bcs::to_bytes<address>(&arg3));
        0xc8b07577c7390e9f8749d031f980676d060e22d819c3577b02573018959e68dd::timelock::propose(arg1, arg0, 10, v0, arg4, arg5)
    }

    public fun propose_set_ema_alpha(arg0: &0xc8b07577c7390e9f8749d031f980676d060e22d819c3577b02573018959e68dd::vault::AdminCap, arg1: &mut 0xc8b07577c7390e9f8749d031f980676d060e22d819c3577b02573018959e68dd::timelock::TimelockRegistry, arg2: u64, arg3: &0x2::clock::Clock, arg4: &0x2::tx_context::TxContext) : u64 {
        0xc8b07577c7390e9f8749d031f980676d060e22d819c3577b02573018959e68dd::timelock::propose(arg1, arg0, 6, 0x2::bcs::to_bytes<u64>(&arg2), arg3, arg4)
    }

    public fun propose_set_fee_recipient(arg0: &0xc8b07577c7390e9f8749d031f980676d060e22d819c3577b02573018959e68dd::vault::AdminCap, arg1: &mut 0xc8b07577c7390e9f8749d031f980676d060e22d819c3577b02573018959e68dd::timelock::TimelockRegistry, arg2: address, arg3: &0x2::clock::Clock, arg4: &0x2::tx_context::TxContext) : u64 {
        0xc8b07577c7390e9f8749d031f980676d060e22d819c3577b02573018959e68dd::timelock::propose(arg1, arg0, 0xc8b07577c7390e9f8749d031f980676d060e22d819c3577b02573018959e68dd::timelock::action_set_fee_recipient(), 0x2::bcs::to_bytes<address>(&arg2), arg3, arg4)
    }

    public fun propose_set_harvest_cooldown(arg0: &0xc8b07577c7390e9f8749d031f980676d060e22d819c3577b02573018959e68dd::vault::AdminCap, arg1: &mut 0xc8b07577c7390e9f8749d031f980676d060e22d819c3577b02573018959e68dd::timelock::TimelockRegistry, arg2: u64, arg3: &0x2::clock::Clock, arg4: &0x2::tx_context::TxContext) : u64 {
        assert!(arg2 >= 3600000, 902);
        0xc8b07577c7390e9f8749d031f980676d060e22d819c3577b02573018959e68dd::timelock::propose(arg1, arg0, 7, 0x2::bcs::to_bytes<u64>(&arg2), arg3, arg4)
    }

    public fun propose_set_harvest_slippage(arg0: &0xc8b07577c7390e9f8749d031f980676d060e22d819c3577b02573018959e68dd::vault::AdminCap, arg1: &mut 0xc8b07577c7390e9f8749d031f980676d060e22d819c3577b02573018959e68dd::timelock::TimelockRegistry, arg2: u64, arg3: &0x2::clock::Clock, arg4: &0x2::tx_context::TxContext) : u64 {
        0xc8b07577c7390e9f8749d031f980676d060e22d819c3577b02573018959e68dd::floors::assert_slippage(arg2);
        0xc8b07577c7390e9f8749d031f980676d060e22d819c3577b02573018959e68dd::timelock::propose(arg1, arg0, 9, 0x2::bcs::to_bytes<u64>(&arg2), arg3, arg4)
    }

    public fun propose_set_harvest_threshold(arg0: &0xc8b07577c7390e9f8749d031f980676d060e22d819c3577b02573018959e68dd::vault::AdminCap, arg1: &mut 0xc8b07577c7390e9f8749d031f980676d060e22d819c3577b02573018959e68dd::timelock::TimelockRegistry, arg2: u8, arg3: u64, arg4: &0x2::clock::Clock, arg5: &0x2::tx_context::TxContext) : u64 {
        let v0 = 0x1::vector::empty<u8>();
        0x1::vector::append<u8>(&mut v0, 0x2::bcs::to_bytes<u8>(&arg2));
        0x1::vector::append<u8>(&mut v0, 0x2::bcs::to_bytes<u64>(&arg3));
        0xc8b07577c7390e9f8749d031f980676d060e22d819c3577b02573018959e68dd::timelock::propose(arg1, arg0, 8, v0, arg4, arg5)
    }

    public fun propose_update_config(arg0: &0xc8b07577c7390e9f8749d031f980676d060e22d819c3577b02573018959e68dd::vault::AdminCap, arg1: &mut 0xc8b07577c7390e9f8749d031f980676d060e22d819c3577b02573018959e68dd::timelock::TimelockRegistry, arg2: u64, arg3: u64, arg4: u64, arg5: u64, arg6: u64, arg7: u64, arg8: u64, arg9: &0x2::clock::Clock, arg10: &0x2::tx_context::TxContext) : u64 {
        0xc8b07577c7390e9f8749d031f980676d060e22d819c3577b02573018959e68dd::floors::assert_spread(arg2);
        0xc8b07577c7390e9f8749d031f980676d060e22d819c3577b02573018959e68dd::floors::assert_min_apy(arg3);
        0xc8b07577c7390e9f8749d031f980676d060e22d819c3577b02573018959e68dd::floors::assert_cooldown(arg4);
        0xc8b07577c7390e9f8749d031f980676d060e22d819c3577b02573018959e68dd::floors::assert_slippage(arg5);
        let v0 = 0x1::vector::empty<u8>();
        0x1::vector::append<u8>(&mut v0, 0x2::bcs::to_bytes<u64>(&arg2));
        0x1::vector::append<u8>(&mut v0, 0x2::bcs::to_bytes<u64>(&arg3));
        0x1::vector::append<u8>(&mut v0, 0x2::bcs::to_bytes<u64>(&arg4));
        0x1::vector::append<u8>(&mut v0, 0x2::bcs::to_bytes<u64>(&arg5));
        0x1::vector::append<u8>(&mut v0, 0x2::bcs::to_bytes<u64>(&arg6));
        0x1::vector::append<u8>(&mut v0, 0x2::bcs::to_bytes<u64>(&arg7));
        0x1::vector::append<u8>(&mut v0, 0x2::bcs::to_bytes<u64>(&arg8));
        0xc8b07577c7390e9f8749d031f980676d060e22d819c3577b02573018959e68dd::timelock::propose(arg1, arg0, 0xc8b07577c7390e9f8749d031f980676d060e22d819c3577b02573018959e68dd::timelock::action_update_crank_config(), v0, arg9, arg10)
    }

    public fun propose_update_fee(arg0: &0xc8b07577c7390e9f8749d031f980676d060e22d819c3577b02573018959e68dd::vault::AdminCap, arg1: &mut 0xc8b07577c7390e9f8749d031f980676d060e22d819c3577b02573018959e68dd::timelock::TimelockRegistry, arg2: u64, arg3: &0x2::clock::Clock, arg4: &0x2::tx_context::TxContext) : u64 {
        0xc8b07577c7390e9f8749d031f980676d060e22d819c3577b02573018959e68dd::floors::assert_rewards_fee(arg2);
        0xc8b07577c7390e9f8749d031f980676d060e22d819c3577b02573018959e68dd::timelock::propose(arg1, arg0, 0xc8b07577c7390e9f8749d031f980676d060e22d819c3577b02573018959e68dd::timelock::action_update_fee(), 0x2::bcs::to_bytes<u64>(&arg2), arg3, arg4)
    }

    // decompiled from Move bytecode v6
}

