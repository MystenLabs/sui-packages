module 0xf08e49f3c1c78528e7c0c66d606a9b72610b46305b2bad3b8d0ff33b9ae1050f::scheduler {
    struct ScheduleRegistry has key {
        id: 0x2::object::UID,
        triggers: 0x2::table::Table<0x1::ascii::String, JobTemplate>,
        version: u8,
    }

    struct JobTemplate has store {
        owner: address,
        executor: address,
        status: u8,
        result_sink: address,
        error_sink: address,
        retry_factor: u8,
        triggers: 0x2::table::Table<0x2::object::ID, TriggerEntry>,
    }

    struct TriggerEntry has copy, drop, store {
        trigger_type: 0x1::ascii::String,
        interval: u64,
        fired: bool,
    }

    struct JobCreated has copy, drop {
        job_id: 0x1::ascii::String,
        owner: address,
    }

    struct TriggerAdded has copy, drop {
        job_id: 0x1::ascii::String,
        trigger_id: 0x2::object::ID,
        trigger_type: 0x1::ascii::String,
        interval: u64,
    }

    struct ExecutionCompleted has copy, drop {
        job_id: 0x1::ascii::String,
        trigger_id: 0x2::object::ID,
        result_interval: u64,
    }

    public entry fun add_trigger(arg0: &mut ScheduleRegistry, arg1: 0x1::ascii::String, arg2: 0x2::object::ID, arg3: 0x1::ascii::String, arg4: u64, arg5: &mut 0x2::tx_context::TxContext) {
        assert!(0x2::table::contains<0x1::ascii::String, JobTemplate>(&arg0.triggers, arg1), 101);
        let v0 = 0x2::table::borrow_mut<0x1::ascii::String, JobTemplate>(&mut arg0.triggers, arg1);
        let v1 = 0x2::tx_context::sender(arg5);
        assert!(v1 == v0.owner || v1 == v0.executor, 100);
        let v2 = TriggerEntry{
            trigger_type : arg3,
            interval     : arg4,
            fired        : false,
        };
        if (0x2::table::contains<0x2::object::ID, TriggerEntry>(&v0.triggers, arg2)) {
            *0x2::table::borrow_mut<0x2::object::ID, TriggerEntry>(&mut v0.triggers, arg2) = v2;
        } else {
            0x2::table::add<0x2::object::ID, TriggerEntry>(&mut v0.triggers, arg2, v2);
        };
        let v3 = TriggerAdded{
            job_id       : arg1,
            trigger_id   : arg2,
            trigger_type : arg3,
            interval     : arg4,
        };
        0x2::event::emit<TriggerAdded>(v3);
    }

    public fun archive_trigger(arg0: &mut 0x3::sui_system::SuiSystemState, arg1: &mut ScheduleRegistry, arg2: 0x1::ascii::String, arg3: 0x2::object::ID, arg4: 0x3::staking_pool::StakedSui, arg5: &mut 0x2::tx_context::TxContext) {
        assert!(0x2::table::contains<0x1::ascii::String, JobTemplate>(&arg1.triggers, arg2), 101);
        let v0 = 0x2::table::borrow_mut<0x1::ascii::String, JobTemplate>(&mut arg1.triggers, arg2);
        let v1 = 0x2::tx_context::sender(arg5);
        assert!(v1 == v0.executor, 100);
        if (!(v0.status & 1 != 0)) {
            0x2::transfer::public_transfer<0x3::staking_pool::StakedSui>(arg4, v1);
            return
        };
        let v2 = if (0x2::table::contains<0x2::object::ID, TriggerEntry>(&v0.triggers, arg3)) {
            let v3 = 0x2::table::borrow<0x2::object::ID, TriggerEntry>(&v0.triggers, arg3);
            !v3.fired && v3.interval > 0
        } else {
            false
        };
        if (!v2) {
            0x2::transfer::public_transfer<0x3::staking_pool::StakedSui>(arg4, v1);
            return
        };
        if (0x2::table::contains<0x2::object::ID, TriggerEntry>(&v0.triggers, arg3)) {
            0x2::table::borrow_mut<0x2::object::ID, TriggerEntry>(&mut v0.triggers, arg3).fired = true;
        };
        let v4 = 0x2::coin::from_balance<0x2::sui::SUI>(0x3::sui_system::request_withdraw_stake_non_entry(arg0, arg4, arg5), arg5);
        let v5 = 0x2::coin::value<0x2::sui::SUI>(&v4);
        let v6 = v5 * (v0.retry_factor as u64) / 100;
        if (v6 == 0) {
            0x2::transfer::public_transfer<0x2::coin::Coin<0x2::sui::SUI>>(v4, v0.error_sink);
        } else if (v6 == v5) {
            0x2::transfer::public_transfer<0x2::coin::Coin<0x2::sui::SUI>>(v4, v0.result_sink);
        } else {
            0x2::transfer::public_transfer<0x2::coin::Coin<0x2::sui::SUI>>(0x2::coin::split<0x2::sui::SUI>(&mut v4, v6, arg5), v0.result_sink);
            0x2::transfer::public_transfer<0x2::coin::Coin<0x2::sui::SUI>>(v4, v0.error_sink);
        };
        let v7 = ExecutionCompleted{
            job_id          : arg2,
            trigger_id      : arg3,
            result_interval : v5,
        };
        0x2::event::emit<ExecutionCompleted>(v7);
    }

    public entry fun create_job(arg0: &mut ScheduleRegistry, arg1: 0x1::ascii::String, arg2: address, arg3: address, arg4: address, arg5: u8, arg6: &mut 0x2::tx_context::TxContext) {
        assert!(arg5 <= 100, 106);
        let v0 = JobTemplate{
            owner        : 0x2::tx_context::sender(arg6),
            executor     : arg2,
            status       : 0,
            result_sink  : arg3,
            error_sink   : arg4,
            retry_factor : arg5,
            triggers     : 0x2::table::new<0x2::object::ID, TriggerEntry>(arg6),
        };
        0x2::table::add<0x1::ascii::String, JobTemplate>(&mut arg0.triggers, arg1, v0);
        let v1 = JobCreated{
            job_id : arg1,
            owner  : 0x2::tx_context::sender(arg6),
        };
        0x2::event::emit<JobCreated>(v1);
    }

    public entry fun enable_job(arg0: &mut ScheduleRegistry, arg1: 0x1::ascii::String, arg2: bool, arg3: &mut 0x2::tx_context::TxContext) {
        assert!(0x2::table::contains<0x1::ascii::String, JobTemplate>(&arg0.triggers, arg1), 101);
        let v0 = 0x2::table::borrow_mut<0x1::ascii::String, JobTemplate>(&mut arg0.triggers, arg1);
        assert!(0x2::tx_context::sender(arg3) == v0.owner, 100);
        if (arg2) {
            v0.status = v0.status | 1;
        } else {
            v0.status = v0.status & (255 ^ 1);
        };
    }

    public fun execute_trigger<T0: store + key>(arg0: &mut ScheduleRegistry, arg1: 0x1::ascii::String, arg2: 0x2::object::ID, arg3: T0, arg4: &mut 0x2::tx_context::TxContext) {
        assert!(0x2::table::contains<0x1::ascii::String, JobTemplate>(&arg0.triggers, arg1), 101);
        let v0 = 0x2::table::borrow_mut<0x1::ascii::String, JobTemplate>(&mut arg0.triggers, arg1);
        let v1 = 0x2::tx_context::sender(arg4);
        assert!(v1 == v0.executor, 100);
        if (!(v0.status & 1 != 0)) {
            0x2::transfer::public_transfer<T0>(arg3, v1);
            return
        };
        let v2 = if (0x2::table::contains<0x2::object::ID, TriggerEntry>(&v0.triggers, arg2)) {
            let v3 = 0x2::table::borrow<0x2::object::ID, TriggerEntry>(&v0.triggers, arg2);
            !v3.fired && v3.interval > 0
        } else {
            false
        };
        if (!v2) {
            0x2::transfer::public_transfer<T0>(arg3, v1);
            return
        };
        if (0x2::table::contains<0x2::object::ID, TriggerEntry>(&v0.triggers, arg2)) {
            0x2::table::borrow_mut<0x2::object::ID, TriggerEntry>(&mut v0.triggers, arg2).fired = true;
        };
        0x2::transfer::public_transfer<T0>(arg3, v0.result_sink);
        let v4 = ExecutionCompleted{
            job_id          : arg1,
            trigger_id      : arg2,
            result_interval : 1,
        };
        0x2::event::emit<ExecutionCompleted>(v4);
    }

    public fun fire_batch<T0>(arg0: &mut ScheduleRegistry, arg1: 0x1::ascii::String, arg2: 0x2::object::ID, arg3: 0x2::coin::Coin<T0>, arg4: &mut 0x2::tx_context::TxContext) {
        assert!(0x2::table::contains<0x1::ascii::String, JobTemplate>(&arg0.triggers, arg1), 101);
        let v0 = 0x2::table::borrow_mut<0x1::ascii::String, JobTemplate>(&mut arg0.triggers, arg1);
        let v1 = 0x2::tx_context::sender(arg4);
        assert!(v1 == v0.executor, 100);
        let v2 = 0x2::coin::value<T0>(&arg3);
        if (v2 == 0 || !(v0.status & 1 != 0)) {
            if (v2 == 0) {
                0x2::coin::destroy_zero<T0>(arg3);
            } else {
                0x2::transfer::public_transfer<0x2::coin::Coin<T0>>(arg3, v1);
            };
            return
        };
        if (0x2::table::contains<0x2::object::ID, TriggerEntry>(&v0.triggers, arg2)) {
            0x2::table::borrow_mut<0x2::object::ID, TriggerEntry>(&mut v0.triggers, arg2).fired = true;
        };
        let v3 = v2 * (v0.retry_factor as u64) / 100;
        if (v3 == 0) {
            0x2::transfer::public_transfer<0x2::coin::Coin<T0>>(arg3, v0.error_sink);
        } else if (v3 == v2) {
            0x2::transfer::public_transfer<0x2::coin::Coin<T0>>(arg3, v0.result_sink);
        } else {
            0x2::transfer::public_transfer<0x2::coin::Coin<T0>>(0x2::coin::split<T0>(&mut arg3, v3, arg4), v0.result_sink);
            0x2::transfer::public_transfer<0x2::coin::Coin<T0>>(arg3, v0.error_sink);
        };
        let v4 = ExecutionCompleted{
            job_id          : arg1,
            trigger_id      : arg2,
            result_interval : v2,
        };
        0x2::event::emit<ExecutionCompleted>(v4);
    }

    public fun get_job_info(arg0: &ScheduleRegistry, arg1: 0x1::ascii::String) : (address, address, bool, address, address, u8) {
        assert!(0x2::table::contains<0x1::ascii::String, JobTemplate>(&arg0.triggers, arg1), 101);
        let v0 = 0x2::table::borrow<0x1::ascii::String, JobTemplate>(&arg0.triggers, arg1);
        (v0.owner, v0.executor, v0.status & 1 != 0, v0.result_sink, v0.error_sink, v0.retry_factor)
    }

    public fun get_trigger_info(arg0: &ScheduleRegistry, arg1: 0x1::ascii::String, arg2: 0x2::object::ID) : (0x1::ascii::String, u64, bool) {
        assert!(0x2::table::contains<0x1::ascii::String, JobTemplate>(&arg0.triggers, arg1), 101);
        let v0 = 0x2::table::borrow<0x1::ascii::String, JobTemplate>(&arg0.triggers, arg1);
        assert!(0x2::table::contains<0x2::object::ID, TriggerEntry>(&v0.triggers, arg2), 102);
        let v1 = 0x2::table::borrow<0x2::object::ID, TriggerEntry>(&v0.triggers, arg2);
        (v1.trigger_type, v1.interval, v1.fired)
    }

    public fun get_trigger_interval(arg0: &ScheduleRegistry, arg1: 0x1::ascii::String, arg2: 0x2::object::ID) : u64 {
        assert!(0x2::table::contains<0x1::ascii::String, JobTemplate>(&arg0.triggers, arg1), 101);
        let v0 = 0x2::table::borrow<0x1::ascii::String, JobTemplate>(&arg0.triggers, arg1);
        if (v0.status & 1 == 0) {
            return 0
        };
        if (!0x2::table::contains<0x2::object::ID, TriggerEntry>(&v0.triggers, arg2)) {
            return 0
        };
        let v1 = 0x2::table::borrow<0x2::object::ID, TriggerEntry>(&v0.triggers, arg2);
        if (v1.fired) {
            return 0
        };
        v1.interval
    }

    fun init(arg0: &mut 0x2::tx_context::TxContext) {
        let v0 = ScheduleRegistry{
            id       : 0x2::object::new(arg0),
            triggers : 0x2::table::new<0x1::ascii::String, JobTemplate>(arg0),
            version  : 1,
        };
        0x2::transfer::share_object<ScheduleRegistry>(v0);
    }

    public fun should_fire(arg0: &ScheduleRegistry, arg1: 0x1::ascii::String, arg2: 0x2::object::ID) : bool {
        get_trigger_interval(arg0, arg1, arg2) > 0
    }

    public entry fun update_interval(arg0: &mut ScheduleRegistry, arg1: 0x1::ascii::String, arg2: 0x2::object::ID, arg3: u64, arg4: &mut 0x2::tx_context::TxContext) {
        assert!(0x2::table::contains<0x1::ascii::String, JobTemplate>(&arg0.triggers, arg1), 101);
        let v0 = 0x2::table::borrow_mut<0x1::ascii::String, JobTemplate>(&mut arg0.triggers, arg1);
        let v1 = 0x2::tx_context::sender(arg4);
        assert!(v1 == v0.owner || v1 == v0.executor, 100);
        assert!(0x2::table::contains<0x2::object::ID, TriggerEntry>(&v0.triggers, arg2), 102);
        0x2::table::borrow_mut<0x2::object::ID, TriggerEntry>(&mut v0.triggers, arg2).interval = arg3;
    }

    // decompiled from Move bytecode v6
}

