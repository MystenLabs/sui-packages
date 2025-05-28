module 0xcfe2d87aa5712b67cad2732edb6a2201bfdf592377e5c0968b7cb02099bd8e21::treasury {
    struct VeScaTreasury has key {
        id: 0x2::object::UID,
        sca_balance: 0x2::balance::Balance<0x7016aae72cfc67f2fadf55769c0a7dd54291a583b63051a5ed71081cce836ac6::sca::SCA>,
        total_ve_sca_amount: u64,
        unlock_schedule: 0xcfe2d87aa5712b67cad2732edb6a2201bfdf592377e5c0968b7cb02099bd8e21::unlock_schedule::VeScaUnlockSchedule,
    }

    struct ExtendLockPeriodByAdminEvent has copy, drop, store {
        ve_sca_key_id: 0x2::object::ID,
        amount: u64,
        prev_unlock_at: u64,
        new_unlock_at: u64,
        timestamp: u64,
    }

    public(friend) fun extend_lock_period(arg0: &mut VeScaTreasury, arg1: u64, arg2: u64, arg3: u64, arg4: &0x2::clock::Clock) {
        refresh_internal(arg0, arg4);
        0xcfe2d87aa5712b67cad2732edb6a2201bfdf592377e5c0968b7cb02099bd8e21::unlock_schedule::extend_lock_period(&mut arg0.unlock_schedule, arg1, arg2, arg3, arg4);
        arg0.total_ve_sca_amount = arg0.total_ve_sca_amount + 0xcfe2d87aa5712b67cad2732edb6a2201bfdf592377e5c0968b7cb02099bd8e21::calculator::new_ve_sca_from_extending_lock(arg1, arg2, arg3, arg4);
    }

    public fun extend_lock_period_by_admin(arg0: &0xcfe2d87aa5712b67cad2732edb6a2201bfdf592377e5c0968b7cb02099bd8e21::config::VeScaProtocolAdminCap, arg1: &mut VeScaTreasury, arg2: 0x2::object::ID, arg3: u64, arg4: u64, arg5: u64, arg6: &0x2::clock::Clock) {
        let v0 = 0x2::clock::timestamp_ms(arg6) / 1000;
        assert!(arg5 > arg4, 0xcfe2d87aa5712b67cad2732edb6a2201bfdf592377e5c0968b7cb02099bd8e21::error_code::extend_to_shorter_duration());
        if (arg4 >= v0) {
            0xcfe2d87aa5712b67cad2732edb6a2201bfdf592377e5c0968b7cb02099bd8e21::ve_sca_rules::assert_new_unlock_at(arg4, arg6);
        };
        if (arg5 >= v0) {
            0xcfe2d87aa5712b67cad2732edb6a2201bfdf592377e5c0968b7cb02099bd8e21::ve_sca_rules::assert_new_unlock_at(arg5, arg6);
        };
        if (arg5 < v0) {
            return
        };
        refresh_internal(arg1, arg6);
        if (arg4 < v0) {
            0xcfe2d87aa5712b67cad2732edb6a2201bfdf592377e5c0968b7cb02099bd8e21::unlock_schedule::add_future_unlock_amount(&mut arg1.unlock_schedule, arg3, arg5, arg6);
            arg1.total_ve_sca_amount = arg1.total_ve_sca_amount + 0xcfe2d87aa5712b67cad2732edb6a2201bfdf592377e5c0968b7cb02099bd8e21::calculator::calc_ve_sca(arg3, arg5, arg6);
        } else {
            0xcfe2d87aa5712b67cad2732edb6a2201bfdf592377e5c0968b7cb02099bd8e21::unlock_schedule::extend_lock_period(&mut arg1.unlock_schedule, arg3, arg4, arg5, arg6);
            arg1.total_ve_sca_amount = arg1.total_ve_sca_amount + 0xcfe2d87aa5712b67cad2732edb6a2201bfdf592377e5c0968b7cb02099bd8e21::calculator::new_ve_sca_from_extending_lock(arg3, arg4, arg5, arg6);
        };
        let v1 = ExtendLockPeriodByAdminEvent{
            ve_sca_key_id  : arg2,
            amount         : arg3,
            prev_unlock_at : arg4,
            new_unlock_at  : arg5,
            timestamp      : v0,
        };
        0x2::event::emit<ExtendLockPeriodByAdminEvent>(v1);
    }

    fun init(arg0: &mut 0x2::tx_context::TxContext) {
        let v0 = VeScaTreasury{
            id                  : 0x2::object::new(arg0),
            sca_balance         : 0x2::balance::zero<0x7016aae72cfc67f2fadf55769c0a7dd54291a583b63051a5ed71081cce836ac6::sca::SCA>(),
            total_ve_sca_amount : 0,
            unlock_schedule     : 0xcfe2d87aa5712b67cad2732edb6a2201bfdf592377e5c0968b7cb02099bd8e21::unlock_schedule::new(),
        };
        0x2::transfer::share_object<VeScaTreasury>(v0);
    }

    public(friend) fun lock_sca(arg0: &mut VeScaTreasury, arg1: 0x2::coin::Coin<0x7016aae72cfc67f2fadf55769c0a7dd54291a583b63051a5ed71081cce836ac6::sca::SCA>, arg2: u64, arg3: &0x2::clock::Clock) {
        refresh_internal(arg0, arg3);
        let v0 = 0x2::coin::value<0x7016aae72cfc67f2fadf55769c0a7dd54291a583b63051a5ed71081cce836ac6::sca::SCA>(&arg1);
        0xcfe2d87aa5712b67cad2732edb6a2201bfdf592377e5c0968b7cb02099bd8e21::unlock_schedule::add_future_unlock_amount(&mut arg0.unlock_schedule, v0, arg2, arg3);
        arg0.total_ve_sca_amount = arg0.total_ve_sca_amount + 0xcfe2d87aa5712b67cad2732edb6a2201bfdf592377e5c0968b7cb02099bd8e21::calculator::calc_ve_sca(v0, arg2, arg3);
        0x2::balance::join<0x7016aae72cfc67f2fadf55769c0a7dd54291a583b63051a5ed71081cce836ac6::sca::SCA>(&mut arg0.sca_balance, 0x2::coin::into_balance<0x7016aae72cfc67f2fadf55769c0a7dd54291a583b63051a5ed71081cce836ac6::sca::SCA>(arg1));
    }

    public fun refresh(arg0: &0xcfe2d87aa5712b67cad2732edb6a2201bfdf592377e5c0968b7cb02099bd8e21::config::VeScaProtocolConfig, arg1: &mut VeScaTreasury, arg2: &0x2::clock::Clock) {
        0xcfe2d87aa5712b67cad2732edb6a2201bfdf592377e5c0968b7cb02099bd8e21::config::assert_protocol_version_and_status(arg0);
        refresh_internal(arg1, arg2);
    }

    fun refresh_internal(arg0: &mut VeScaTreasury, arg1: &0x2::clock::Clock) {
        let v0 = 0xcfe2d87aa5712b67cad2732edb6a2201bfdf592377e5c0968b7cb02099bd8e21::unlock_schedule::refresh_unlock_schedule_and_return_history_lock_snapshots(&mut arg0.unlock_schedule, arg1);
        let v1 = 0;
        while (v1 < 0x1::vector::length<0xcfe2d87aa5712b67cad2732edb6a2201bfdf592377e5c0968b7cb02099bd8e21::unlock_schedule::LockHistorySnapshot>(&v0)) {
            let v2 = 0x1::vector::borrow<0xcfe2d87aa5712b67cad2732edb6a2201bfdf592377e5c0968b7cb02099bd8e21::unlock_schedule::LockHistorySnapshot>(&v0, v1);
            arg0.total_ve_sca_amount = arg0.total_ve_sca_amount - 0xcfe2d87aa5712b67cad2732edb6a2201bfdf592377e5c0968b7cb02099bd8e21::util::mul_div(0xcfe2d87aa5712b67cad2732edb6a2201bfdf592377e5c0968b7cb02099bd8e21::unlock_schedule::snapshot_locked_sca_amount(v2), 0xcfe2d87aa5712b67cad2732edb6a2201bfdf592377e5c0968b7cb02099bd8e21::unlock_schedule::snapshot_locked_duration(v2), 0xcfe2d87aa5712b67cad2732edb6a2201bfdf592377e5c0968b7cb02099bd8e21::constants::max_lock_duration());
            v1 = v1 + 1;
        };
    }

    public fun refreshed_at(arg0: &VeScaTreasury) : u64 {
        0xcfe2d87aa5712b67cad2732edb6a2201bfdf592377e5c0968b7cb02099bd8e21::unlock_schedule::refreshed_at(&arg0.unlock_schedule)
    }

    public fun sca_balance_amount(arg0: &VeScaTreasury) : u64 {
        0x2::balance::value<0x7016aae72cfc67f2fadf55769c0a7dd54291a583b63051a5ed71081cce836ac6::sca::SCA>(&arg0.sca_balance)
    }

    public fun total_ve_sca_amount(arg0: &VeScaTreasury, arg1: &0x2::clock::Clock) : u64 {
        assert!(0x2::clock::timestamp_ms(arg1) / 1000 == refreshed_at(arg0), 0xcfe2d87aa5712b67cad2732edb6a2201bfdf592377e5c0968b7cb02099bd8e21::error_code::should_refresh_first());
        arg0.total_ve_sca_amount
    }

    public(friend) fun withdraw_sca(arg0: &mut VeScaTreasury, arg1: u64, arg2: &0x2::clock::Clock, arg3: &mut 0x2::tx_context::TxContext) : 0x2::coin::Coin<0x7016aae72cfc67f2fadf55769c0a7dd54291a583b63051a5ed71081cce836ac6::sca::SCA> {
        refresh_internal(arg0, arg2);
        0x2::coin::from_balance<0x7016aae72cfc67f2fadf55769c0a7dd54291a583b63051a5ed71081cce836ac6::sca::SCA>(0x2::balance::split<0x7016aae72cfc67f2fadf55769c0a7dd54291a583b63051a5ed71081cce836ac6::sca::SCA>(&mut arg0.sca_balance, arg1), arg3)
    }

    // decompiled from Move bytecode v6
}

