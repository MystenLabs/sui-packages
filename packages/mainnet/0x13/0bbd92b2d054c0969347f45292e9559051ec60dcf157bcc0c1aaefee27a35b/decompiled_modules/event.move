module 0x130bbd92b2d054c0969347f45292e9559051ec60dcf157bcc0c1aaefee27a35b::event {
    struct VaultCreated has copy, drop {
        vault_id: 0x2::object::ID,
        vault_type: 0x1::type_name::TypeName,
        coin_type: 0x1::type_name::TypeName,
        manager_cap_id: 0x2::object::ID,
        manager: address,
        custody_recipient: address,
        fees: 0x130bbd92b2d054c0969347f45292e9559051ec60dcf157bcc0c1aaefee27a35b::config::FeeStructure,
        params: 0x130bbd92b2d054c0969347f45292e9559051ec60dcf157bcc0c1aaefee27a35b::config::VaultParams,
        timelock_ms: u64,
        miner_id: 0x2::object::ID,
        timestamp_ms: u64,
    }

    struct Deposit has copy, drop {
        vault_id: 0x2::object::ID,
        depositor: address,
        assets: u64,
        shares: u64,
        timestamp_ms: u64,
    }

    struct RedeemRequested has copy, drop {
        vault_id: 0x2::object::ID,
        who: address,
        request_id: u64,
        shares: u64,
        timestamp_ms: u64,
    }

    struct RedeemFulfilled has copy, drop {
        vault_id: 0x2::object::ID,
        caller: address,
        request_id: u64,
        recipient: address,
        assets: u64,
        timestamp_ms: u64,
    }

    struct LiquidityWithdrawn has copy, drop {
        vault_id: 0x2::object::ID,
        caller: address,
        custody_recipient: address,
        amount: u64,
        timestamp_ms: u64,
    }

    struct CircuitBreak has copy, drop {
        vault_id: 0x2::object::ID,
        caller: address,
        active: bool,
        timestamp_ms: u64,
    }

    struct Paused has copy, drop {
        vault_id: 0x2::object::ID,
        caller: address,
        what: u8,
        paused: bool,
        timestamp_ms: u64,
    }

    struct WishSubmitted has copy, drop {
        vault_id: 0x2::object::ID,
        wish_type: 0x1::type_name::TypeName,
        is_super_admin: bool,
        activation_time_ms: u64,
        expiration_time_ms: u64,
        timestamp_ms: u64,
    }

    struct WishExecuted has copy, drop {
        vault_id: 0x2::object::ID,
        wish_type: 0x1::type_name::TypeName,
        is_super_admin: bool,
        timestamp_ms: u64,
    }

    struct WishCancelled has copy, drop {
        vault_id: 0x2::object::ID,
        wish_type: 0x1::type_name::TypeName,
        is_super_admin: bool,
        timestamp_ms: u64,
    }

    struct ActuatorUpdated has copy, drop {
        vault_id: 0x2::object::ID,
        caller: address,
        actuator_id: 0x2::object::ID,
        added: bool,
        timestamp_ms: u64,
    }

    struct InterestAccrued has copy, drop {
        vault_id: 0x2::object::ID,
        old_total_deposit: u64,
        new_total_deposit: u64,
        performance_fee_shares: u64,
        timestamp_ms: u64,
    }

    struct FeeEarned has copy, drop {
        vault_id: 0x2::object::ID,
        coin_type: 0x1::type_name::TypeName,
        amount: u64,
        total_earned_across_all_vaults: u64,
    }

    struct InterestRateUpdated has copy, drop {
        vault_id: 0x2::object::ID,
        old_rate_ms: u64,
        new_rate_ms: u64,
        timestamp_ms: u64,
    }

    struct VaultCapTransferred has copy, drop {
        vault_id: 0x2::object::ID,
        who: address,
        what: 0x1::type_name::TypeName,
        recipient: address,
        timestamp_ms: u64,
    }

    public(friend) fun emit_actuator_updated(arg0: 0x2::object::ID, arg1: address, arg2: 0x2::object::ID, arg3: bool, arg4: u64) {
        let v0 = ActuatorUpdated{
            vault_id     : arg0,
            caller       : arg1,
            actuator_id  : arg2,
            added        : arg3,
            timestamp_ms : arg4,
        };
        0x2::event::emit<ActuatorUpdated>(v0);
    }

    public(friend) fun emit_circuit_break(arg0: 0x2::object::ID, arg1: address, arg2: bool, arg3: u64) {
        let v0 = CircuitBreak{
            vault_id     : arg0,
            caller       : arg1,
            active       : arg2,
            timestamp_ms : arg3,
        };
        0x2::event::emit<CircuitBreak>(v0);
    }

    public(friend) fun emit_deposit(arg0: 0x2::object::ID, arg1: address, arg2: u64, arg3: u64, arg4: u64) {
        let v0 = Deposit{
            vault_id     : arg0,
            depositor    : arg1,
            assets       : arg2,
            shares       : arg3,
            timestamp_ms : arg4,
        };
        0x2::event::emit<Deposit>(v0);
    }

    public(friend) fun emit_fee_earned(arg0: 0x2::object::ID, arg1: 0x1::type_name::TypeName, arg2: u64, arg3: u64) {
        let v0 = FeeEarned{
            vault_id                       : arg0,
            coin_type                      : arg1,
            amount                         : arg2,
            total_earned_across_all_vaults : arg3,
        };
        0x2::event::emit<FeeEarned>(v0);
    }

    public(friend) fun emit_interest_accrued(arg0: 0x2::object::ID, arg1: u64, arg2: u64, arg3: u64, arg4: u64) {
        let v0 = InterestAccrued{
            vault_id               : arg0,
            old_total_deposit      : arg1,
            new_total_deposit      : arg2,
            performance_fee_shares : arg3,
            timestamp_ms           : arg4,
        };
        0x2::event::emit<InterestAccrued>(v0);
    }

    public(friend) fun emit_interest_rate_updated(arg0: 0x2::object::ID, arg1: u64, arg2: u64, arg3: u64) {
        let v0 = InterestRateUpdated{
            vault_id     : arg0,
            old_rate_ms  : arg1,
            new_rate_ms  : arg2,
            timestamp_ms : arg3,
        };
        0x2::event::emit<InterestRateUpdated>(v0);
    }

    public(friend) fun emit_liquidity_withdrawn(arg0: 0x2::object::ID, arg1: address, arg2: address, arg3: u64, arg4: u64) {
        let v0 = LiquidityWithdrawn{
            vault_id          : arg0,
            caller            : arg1,
            custody_recipient : arg2,
            amount            : arg3,
            timestamp_ms      : arg4,
        };
        0x2::event::emit<LiquidityWithdrawn>(v0);
    }

    public(friend) fun emit_paused(arg0: 0x2::object::ID, arg1: address, arg2: u8, arg3: bool, arg4: u64) {
        let v0 = Paused{
            vault_id     : arg0,
            caller       : arg1,
            what         : arg2,
            paused       : arg3,
            timestamp_ms : arg4,
        };
        0x2::event::emit<Paused>(v0);
    }

    public(friend) fun emit_redeem_fulfilled(arg0: 0x2::object::ID, arg1: address, arg2: u64, arg3: address, arg4: u64, arg5: u64) {
        let v0 = RedeemFulfilled{
            vault_id     : arg0,
            caller       : arg1,
            request_id   : arg2,
            recipient    : arg3,
            assets       : arg4,
            timestamp_ms : arg5,
        };
        0x2::event::emit<RedeemFulfilled>(v0);
    }

    public(friend) fun emit_redeem_requested(arg0: 0x2::object::ID, arg1: address, arg2: u64, arg3: u64, arg4: u64) {
        let v0 = RedeemRequested{
            vault_id     : arg0,
            who          : arg1,
            request_id   : arg2,
            shares       : arg3,
            timestamp_ms : arg4,
        };
        0x2::event::emit<RedeemRequested>(v0);
    }

    public(friend) fun emit_vault_cap_transferred(arg0: 0x2::object::ID, arg1: address, arg2: 0x1::type_name::TypeName, arg3: address, arg4: u64) {
        let v0 = VaultCapTransferred{
            vault_id     : arg0,
            who          : arg1,
            what         : arg2,
            recipient    : arg3,
            timestamp_ms : arg4,
        };
        0x2::event::emit<VaultCapTransferred>(v0);
    }

    public(friend) fun emit_vault_created(arg0: 0x2::object::ID, arg1: 0x1::type_name::TypeName, arg2: 0x1::type_name::TypeName, arg3: 0x2::object::ID, arg4: address, arg5: address, arg6: 0x130bbd92b2d054c0969347f45292e9559051ec60dcf157bcc0c1aaefee27a35b::config::FeeStructure, arg7: 0x130bbd92b2d054c0969347f45292e9559051ec60dcf157bcc0c1aaefee27a35b::config::VaultParams, arg8: u64, arg9: 0x2::object::ID, arg10: u64) {
        let v0 = VaultCreated{
            vault_id          : arg0,
            vault_type        : arg1,
            coin_type         : arg2,
            manager_cap_id    : arg3,
            manager           : arg4,
            custody_recipient : arg5,
            fees              : arg6,
            params            : arg7,
            timelock_ms       : arg8,
            miner_id          : arg9,
            timestamp_ms      : arg10,
        };
        0x2::event::emit<VaultCreated>(v0);
    }

    public(friend) fun emit_wish_cancelled(arg0: 0x2::object::ID, arg1: 0x1::type_name::TypeName, arg2: bool, arg3: u64) {
        let v0 = WishCancelled{
            vault_id       : arg0,
            wish_type      : arg1,
            is_super_admin : arg2,
            timestamp_ms   : arg3,
        };
        0x2::event::emit<WishCancelled>(v0);
    }

    public(friend) fun emit_wish_executed(arg0: 0x2::object::ID, arg1: 0x1::type_name::TypeName, arg2: bool, arg3: u64) {
        let v0 = WishExecuted{
            vault_id       : arg0,
            wish_type      : arg1,
            is_super_admin : arg2,
            timestamp_ms   : arg3,
        };
        0x2::event::emit<WishExecuted>(v0);
    }

    public(friend) fun emit_wish_submitted(arg0: 0x2::object::ID, arg1: 0x1::type_name::TypeName, arg2: bool, arg3: u64, arg4: u64, arg5: u64) {
        let v0 = WishSubmitted{
            vault_id           : arg0,
            wish_type          : arg1,
            is_super_admin     : arg2,
            activation_time_ms : arg3,
            expiration_time_ms : arg4,
            timestamp_ms       : arg5,
        };
        0x2::event::emit<WishSubmitted>(v0);
    }

    // decompiled from Move bytecode v7
}

