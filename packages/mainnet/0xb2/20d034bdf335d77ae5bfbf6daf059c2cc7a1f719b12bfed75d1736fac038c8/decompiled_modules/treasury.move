module 0xb220d034bdf335d77ae5bfbf6daf059c2cc7a1f719b12bfed75d1736fac038c8::treasury {
    struct VeScaTreasury has key {
        id: 0x2::object::UID,
        sca_balance: 0x2::balance::Balance<0x6cd813061a3adf3602b76545f076205f0c8e7ec1d3b1eab9a1da7992c18c0524::sca::SCA>,
        total_ve_sca_amount: u64,
        unlock_schedule: 0xb220d034bdf335d77ae5bfbf6daf059c2cc7a1f719b12bfed75d1736fac038c8::unlock_schedule::VeScaUnlockSchedule,
    }

    public(friend) fun extend_lock_period(arg0: &mut VeScaTreasury, arg1: u64, arg2: u64, arg3: u64, arg4: &0x2::clock::Clock) {
        refresh_internal(arg0, arg4);
        0xb220d034bdf335d77ae5bfbf6daf059c2cc7a1f719b12bfed75d1736fac038c8::unlock_schedule::extend_lock_period(&mut arg0.unlock_schedule, arg1, arg2, arg3, arg4);
        arg0.total_ve_sca_amount = arg0.total_ve_sca_amount + 0xb220d034bdf335d77ae5bfbf6daf059c2cc7a1f719b12bfed75d1736fac038c8::calculator::new_ve_sca_from_extending_lock(arg1, arg2, arg3, arg4);
    }

    fun init(arg0: &mut 0x2::tx_context::TxContext) {
        let v0 = VeScaTreasury{
            id                  : 0x2::object::new(arg0),
            sca_balance         : 0x2::balance::zero<0x6cd813061a3adf3602b76545f076205f0c8e7ec1d3b1eab9a1da7992c18c0524::sca::SCA>(),
            total_ve_sca_amount : 0,
            unlock_schedule     : 0xb220d034bdf335d77ae5bfbf6daf059c2cc7a1f719b12bfed75d1736fac038c8::unlock_schedule::new(),
        };
        0x2::transfer::share_object<VeScaTreasury>(v0);
    }

    public(friend) fun lock_sca(arg0: &mut VeScaTreasury, arg1: 0x2::coin::Coin<0x6cd813061a3adf3602b76545f076205f0c8e7ec1d3b1eab9a1da7992c18c0524::sca::SCA>, arg2: u64, arg3: &0x2::clock::Clock) {
        refresh_internal(arg0, arg3);
        let v0 = 0x2::coin::value<0x6cd813061a3adf3602b76545f076205f0c8e7ec1d3b1eab9a1da7992c18c0524::sca::SCA>(&arg1);
        0xb220d034bdf335d77ae5bfbf6daf059c2cc7a1f719b12bfed75d1736fac038c8::unlock_schedule::add_future_unlock_amount(&mut arg0.unlock_schedule, v0, arg2, arg3);
        arg0.total_ve_sca_amount = arg0.total_ve_sca_amount + 0xb220d034bdf335d77ae5bfbf6daf059c2cc7a1f719b12bfed75d1736fac038c8::calculator::calc_ve_sca(v0, arg2, arg3);
        0x2::balance::join<0x6cd813061a3adf3602b76545f076205f0c8e7ec1d3b1eab9a1da7992c18c0524::sca::SCA>(&mut arg0.sca_balance, 0x2::coin::into_balance<0x6cd813061a3adf3602b76545f076205f0c8e7ec1d3b1eab9a1da7992c18c0524::sca::SCA>(arg1));
    }

    public fun refresh(arg0: &0xb220d034bdf335d77ae5bfbf6daf059c2cc7a1f719b12bfed75d1736fac038c8::config::VeScaProtocolConfig, arg1: &mut VeScaTreasury, arg2: &0x2::clock::Clock) {
        0xb220d034bdf335d77ae5bfbf6daf059c2cc7a1f719b12bfed75d1736fac038c8::config::assert_protocol_version_and_status(arg0);
        refresh_internal(arg1, arg2);
    }

    fun refresh_internal(arg0: &mut VeScaTreasury, arg1: &0x2::clock::Clock) {
        let v0 = 0xb220d034bdf335d77ae5bfbf6daf059c2cc7a1f719b12bfed75d1736fac038c8::unlock_schedule::refresh_unlock_schedule_and_return_history_lock_snapshots(&mut arg0.unlock_schedule, arg1);
        let v1 = 0;
        while (v1 < 0x1::vector::length<0xb220d034bdf335d77ae5bfbf6daf059c2cc7a1f719b12bfed75d1736fac038c8::unlock_schedule::LockHistorySnapshot>(&v0)) {
            let v2 = 0x1::vector::borrow<0xb220d034bdf335d77ae5bfbf6daf059c2cc7a1f719b12bfed75d1736fac038c8::unlock_schedule::LockHistorySnapshot>(&v0, v1);
            arg0.total_ve_sca_amount = arg0.total_ve_sca_amount - 0xb220d034bdf335d77ae5bfbf6daf059c2cc7a1f719b12bfed75d1736fac038c8::util::mul_div(0xb220d034bdf335d77ae5bfbf6daf059c2cc7a1f719b12bfed75d1736fac038c8::unlock_schedule::snapshot_locked_sca_amount(v2), 0xb220d034bdf335d77ae5bfbf6daf059c2cc7a1f719b12bfed75d1736fac038c8::unlock_schedule::snapshot_locked_duration(v2), 0xb220d034bdf335d77ae5bfbf6daf059c2cc7a1f719b12bfed75d1736fac038c8::constants::max_lock_duration());
            v1 = v1 + 1;
        };
    }

    public fun refreshed_at(arg0: &VeScaTreasury) : u64 {
        0xb220d034bdf335d77ae5bfbf6daf059c2cc7a1f719b12bfed75d1736fac038c8::unlock_schedule::refreshed_at(&arg0.unlock_schedule)
    }

    public fun sca_balance_amount(arg0: &VeScaTreasury) : u64 {
        0x2::balance::value<0x6cd813061a3adf3602b76545f076205f0c8e7ec1d3b1eab9a1da7992c18c0524::sca::SCA>(&arg0.sca_balance)
    }

    public fun total_ve_sca_amount(arg0: &VeScaTreasury, arg1: &0x2::clock::Clock) : u64 {
        assert!(0x2::clock::timestamp_ms(arg1) / 1000 == refreshed_at(arg0), 0xb220d034bdf335d77ae5bfbf6daf059c2cc7a1f719b12bfed75d1736fac038c8::error_code::should_refresh_first());
        arg0.total_ve_sca_amount
    }

    public(friend) fun withdraw_sca(arg0: &mut VeScaTreasury, arg1: u64, arg2: &0x2::clock::Clock, arg3: &mut 0x2::tx_context::TxContext) : 0x2::coin::Coin<0x6cd813061a3adf3602b76545f076205f0c8e7ec1d3b1eab9a1da7992c18c0524::sca::SCA> {
        refresh_internal(arg0, arg2);
        0x2::coin::from_balance<0x6cd813061a3adf3602b76545f076205f0c8e7ec1d3b1eab9a1da7992c18c0524::sca::SCA>(0x2::balance::split<0x6cd813061a3adf3602b76545f076205f0c8e7ec1d3b1eab9a1da7992c18c0524::sca::SCA>(&mut arg0.sca_balance, arg1), arg3)
    }

    // decompiled from Move bytecode v6
}

