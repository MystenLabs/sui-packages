module 0x1e8fac4d6408df49001a4a62d283e31f20f3272acbfe3813d0bf178bc9f1e8b2::config {
    struct FeeStructure has copy, drop, store {
        performance_fee_bps: u64,
        withdraw_fee_bps: u64,
    }

    struct VaultParams has copy, drop, store {
        max_total_deposit: u64,
        min_per_deposit: u64,
        min_per_redeem: u64,
        interest_rate_update_min_interval_ms: u64,
    }

    struct Governance has store {
        pause_deposit: bool,
        pause_redeem: bool,
        pause_withdraw: bool,
        circuit_break: bool,
        timelock: u64,
        manager: 0x2::object::ID,
        actuators: 0x2::vec_set::VecSet<0x2::object::ID>,
        custody_recipient: address,
    }

    struct VaultConfig has store {
        cap: VaultParams,
        fees: FeeStructure,
        governance: Governance,
    }

    public(friend) fun circuit_break(arg0: &VaultConfig) : bool {
        arg0.governance.circuit_break
    }

    public fun current_version() : u16 {
        0
    }

    public(friend) fun custody_recipient(arg0: &VaultConfig) : address {
        arg0.governance.custody_recipient
    }

    public(friend) fun ensure_not_circuit_breaked(arg0: &VaultConfig) {
        assert!(!arg0.governance.circuit_break, 0x1e8fac4d6408df49001a4a62d283e31f20f3272acbfe3813d0bf178bc9f1e8b2::error::circuit_breaked());
    }

    public(friend) fun ensure_valid_timelock(arg0: u64) {
        assert!(arg0 >= 86400000 && arg0 <= 864000000, 0x1e8fac4d6408df49001a4a62d283e31f20f3272acbfe3813d0bf178bc9f1e8b2::error::invalid_timelock());
    }

    public(friend) fun interest_rate_update_min_interval_ms(arg0: &VaultConfig) : u64 {
        arg0.cap.interest_rate_update_min_interval_ms
    }

    public(friend) fun is_actuator_allowed(arg0: &VaultConfig, arg1: 0x2::object::ID) : bool {
        0x2::vec_set::contains<0x2::object::ID>(&arg0.governance.actuators, &arg1)
    }

    public(friend) fun is_manager_allowed(arg0: &VaultConfig, arg1: 0x2::object::ID) : bool {
        arg0.governance.manager == arg1
    }

    public(friend) fun manager(arg0: &VaultConfig) : 0x2::object::ID {
        arg0.governance.manager
    }

    public(friend) fun max_total_deposit(arg0: &VaultConfig) : u64 {
        arg0.cap.max_total_deposit
    }

    public(friend) fun min_per_deposit(arg0: &VaultConfig) : u64 {
        arg0.cap.min_per_deposit
    }

    public(friend) fun min_per_redeem(arg0: &VaultConfig) : u64 {
        arg0.cap.min_per_redeem
    }

    public fun new_fee_structure(arg0: u64, arg1: u64) : FeeStructure {
        assert!(arg1 <= 0x1e8fac4d6408df49001a4a62d283e31f20f3272acbfe3813d0bf178bc9f1e8b2::math::max_bps(), 0x1e8fac4d6408df49001a4a62d283e31f20f3272acbfe3813d0bf178bc9f1e8b2::error::invalid_fee());
        assert!(arg0 <= 0x1e8fac4d6408df49001a4a62d283e31f20f3272acbfe3813d0bf178bc9f1e8b2::math::max_bps(), 0x1e8fac4d6408df49001a4a62d283e31f20f3272acbfe3813d0bf178bc9f1e8b2::error::invalid_fee());
        FeeStructure{
            performance_fee_bps : arg0,
            withdraw_fee_bps    : arg1,
        }
    }

    public(friend) fun new_vault_config(arg0: VaultParams, arg1: FeeStructure, arg2: address, arg3: 0x2::object::ID, arg4: u64) : VaultConfig {
        ensure_valid_timelock(arg4);
        let v0 = Governance{
            pause_deposit     : false,
            pause_redeem      : false,
            pause_withdraw    : false,
            circuit_break     : false,
            timelock          : arg4,
            manager           : arg3,
            actuators         : 0x2::vec_set::empty<0x2::object::ID>(),
            custody_recipient : arg2,
        };
        VaultConfig{
            cap        : arg0,
            fees       : arg1,
            governance : v0,
        }
    }

    public fun new_vault_params(arg0: u64, arg1: u64, arg2: u64, arg3: u64) : VaultParams {
        assert!(arg0 > 0, 0x1e8fac4d6408df49001a4a62d283e31f20f3272acbfe3813d0bf178bc9f1e8b2::error::invalid_vault_params());
        assert!(arg1 <= arg0, 0x1e8fac4d6408df49001a4a62d283e31f20f3272acbfe3813d0bf178bc9f1e8b2::error::invalid_vault_params());
        assert!(arg2 <= arg0, 0x1e8fac4d6408df49001a4a62d283e31f20f3272acbfe3813d0bf178bc9f1e8b2::error::invalid_vault_params());
        VaultParams{
            max_total_deposit                    : arg0,
            min_per_deposit                      : arg1,
            min_per_redeem                       : arg2,
            interest_rate_update_min_interval_ms : arg3,
        }
    }

    public(friend) fun pause_deposit(arg0: &VaultConfig) : bool {
        arg0.governance.pause_deposit
    }

    public(friend) fun pause_redeem(arg0: &VaultConfig) : bool {
        arg0.governance.pause_redeem
    }

    public(friend) fun pause_withdraw(arg0: &VaultConfig) : bool {
        arg0.governance.pause_withdraw
    }

    public(friend) fun performance_fee_bps(arg0: &VaultConfig) : u64 {
        arg0.fees.performance_fee_bps
    }

    public(friend) fun set_actuators(arg0: &mut VaultConfig, arg1: 0x2::object::ID, arg2: bool) {
        if (arg2) {
            0x2::vec_set::remove<0x2::object::ID>(&mut arg0.governance.actuators, &arg1);
        } else {
            0x2::vec_set::insert<0x2::object::ID>(&mut arg0.governance.actuators, arg1);
        };
    }

    public(friend) fun set_circuit_break(arg0: &mut VaultConfig, arg1: bool) {
        arg0.governance.circuit_break = arg1;
    }

    public(friend) fun set_custody_recipient(arg0: &mut VaultConfig, arg1: address) {
        arg0.governance.custody_recipient = arg1;
    }

    public(friend) fun set_fees(arg0: &mut VaultConfig, arg1: FeeStructure) {
        arg0.fees = arg1;
    }

    public(friend) fun set_manager(arg0: &mut VaultConfig, arg1: 0x2::object::ID) {
        arg0.governance.manager = arg1;
    }

    public(friend) fun set_pause_deposit(arg0: &mut VaultConfig, arg1: bool) {
        arg0.governance.pause_deposit = arg1;
    }

    public(friend) fun set_pause_redeem(arg0: &mut VaultConfig, arg1: bool) {
        arg0.governance.pause_redeem = arg1;
    }

    public(friend) fun set_pause_withdraw(arg0: &mut VaultConfig, arg1: bool) {
        arg0.governance.pause_withdraw = arg1;
    }

    public(friend) fun set_timelock(arg0: &mut VaultConfig, arg1: u64) {
        arg0.governance.timelock = arg1;
    }

    public(friend) fun set_vault_params(arg0: &mut VaultConfig, arg1: VaultParams) {
        arg0.cap = arg1;
    }

    public(friend) fun timelock(arg0: &VaultConfig) : u64 {
        arg0.governance.timelock
    }

    public(friend) fun withdraw_fee_bps(arg0: &VaultConfig) : u64 {
        arg0.fees.withdraw_fee_bps
    }

    // decompiled from Move bytecode v7
}

