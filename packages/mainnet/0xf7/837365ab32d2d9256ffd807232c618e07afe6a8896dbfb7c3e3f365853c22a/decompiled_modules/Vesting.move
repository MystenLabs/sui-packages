module 0xf7837365ab32d2d9256ffd807232c618e07afe6a8896dbfb7c3e3f365853c22a::Vesting {
    struct VestingSchedule has store {
        total_amount: u64,
        claimed_amount: u64,
        start_time: u64,
        duration: u64,
        cliff_period: u64,
        revoked: bool,
    }

    struct VestingVault has key {
        id: 0x2::object::UID,
        admin: address,
        token_balance: 0x2::balance::Balance<0xf7837365ab32d2d9256ffd807232c618e07afe6a8896dbfb7c3e3f365853c22a::HetraCoin::HETRACOIN>,
        schedules: 0x2::table::Table<address, vector<VestingSchedule>>,
        in_execution: bool,
        total_allocated: u64,
    }

    struct VestingScheduleCreated has copy, drop {
        beneficiary: address,
        total_amount: u64,
        start_time: u64,
        duration: u64,
        cliff_period: u64,
    }

    struct TokensClaimed has copy, drop {
        beneficiary: address,
        amount: u64,
        schedule_index: u64,
        timestamp: u64,
    }

    public entry fun claim_vested_tokens(arg0: &mut VestingVault, arg1: u64, arg2: &mut 0x2::tx_context::TxContext) {
        assert!(!arg0.in_execution, 3);
        arg0.in_execution = true;
        let v0 = 0x2::tx_context::sender(arg2);
        assert!(0x2::table::contains<address, vector<VestingSchedule>>(&arg0.schedules, v0), 5);
        let v1 = 0x2::table::borrow_mut<address, vector<VestingSchedule>>(&mut arg0.schedules, v0);
        assert!(arg1 < 0x1::vector::length<VestingSchedule>(v1), 6);
        let v2 = 0x1::vector::borrow_mut<VestingSchedule>(v1, arg1);
        assert!(!v2.revoked, 6);
        let v3 = 0x2::tx_context::epoch(arg2);
        let v4 = v3 - v2.start_time;
        assert!(v4 >= v2.cliff_period, 4);
        let v5 = if (v4 >= v2.duration) {
            v2.total_amount
        } else {
            v2.total_amount * v4 / v2.duration
        };
        let v6 = v5 - v2.claimed_amount;
        assert!(v6 > 0, 7);
        v2.claimed_amount = v2.claimed_amount + v6;
        0x2::transfer::public_transfer<0x2::coin::Coin<0xf7837365ab32d2d9256ffd807232c618e07afe6a8896dbfb7c3e3f365853c22a::HetraCoin::HETRACOIN>>(0x2::coin::from_balance<0xf7837365ab32d2d9256ffd807232c618e07afe6a8896dbfb7c3e3f365853c22a::HetraCoin::HETRACOIN>(0x2::balance::split<0xf7837365ab32d2d9256ffd807232c618e07afe6a8896dbfb7c3e3f365853c22a::HetraCoin::HETRACOIN>(&mut arg0.token_balance, v6), arg2), v0);
        arg0.total_allocated = arg0.total_allocated - v6;
        let v7 = TokensClaimed{
            beneficiary    : v0,
            amount         : v6,
            schedule_index : arg1,
            timestamp      : v3,
        };
        0x2::event::emit<TokensClaimed>(v7);
        arg0.in_execution = false;
    }

    public entry fun create_vesting_schedule(arg0: &mut VestingVault, arg1: address, arg2: u64, arg3: u64, arg4: u64, arg5: &mut 0x2::tx_context::TxContext) {
        assert!(!arg0.in_execution, 3);
        arg0.in_execution = true;
        assert!(0x2::tx_context::sender(arg5) == arg0.admin, 1);
        assert!(arg2 > 0, 7);
        assert!(arg3 > 0, 6);
        assert!(arg4 <= arg3, 6);
        let v0 = 0x2::balance::value<0xf7837365ab32d2d9256ffd807232c618e07afe6a8896dbfb7c3e3f365853c22a::HetraCoin::HETRACOIN>(&arg0.token_balance);
        assert!(v0 >= arg0.total_allocated, 2);
        assert!(v0 - arg0.total_allocated >= arg2, 2);
        let v1 = VestingSchedule{
            total_amount   : arg2,
            claimed_amount : 0,
            start_time     : 0x2::tx_context::epoch(arg5),
            duration       : arg3,
            cliff_period   : arg4,
            revoked        : false,
        };
        if (!0x2::table::contains<address, vector<VestingSchedule>>(&arg0.schedules, arg1)) {
            0x2::table::add<address, vector<VestingSchedule>>(&mut arg0.schedules, arg1, 0x1::vector::empty<VestingSchedule>());
        };
        0x1::vector::push_back<VestingSchedule>(0x2::table::borrow_mut<address, vector<VestingSchedule>>(&mut arg0.schedules, arg1), v1);
        arg0.total_allocated = arg0.total_allocated + arg2;
        let v2 = VestingScheduleCreated{
            beneficiary  : arg1,
            total_amount : arg2,
            start_time   : 0x2::tx_context::epoch(arg5),
            duration     : arg3,
            cliff_period : arg4,
        };
        0x2::event::emit<VestingScheduleCreated>(v2);
        arg0.in_execution = false;
    }

    public entry fun fund_vault(arg0: &mut VestingVault, arg1: 0x2::coin::Coin<0xf7837365ab32d2d9256ffd807232c618e07afe6a8896dbfb7c3e3f365853c22a::HetraCoin::HETRACOIN>, arg2: &mut 0x2::tx_context::TxContext) {
        assert!(!arg0.in_execution, 3);
        arg0.in_execution = true;
        assert!(0x2::coin::value<0xf7837365ab32d2d9256ffd807232c618e07afe6a8896dbfb7c3e3f365853c22a::HetraCoin::HETRACOIN>(&arg1) > 0, 7);
        0x2::balance::join<0xf7837365ab32d2d9256ffd807232c618e07afe6a8896dbfb7c3e3f365853c22a::HetraCoin::HETRACOIN>(&mut arg0.token_balance, 0x2::coin::into_balance<0xf7837365ab32d2d9256ffd807232c618e07afe6a8896dbfb7c3e3f365853c22a::HetraCoin::HETRACOIN>(arg1));
        arg0.in_execution = false;
    }

    public entry fun init_vesting_vault(arg0: address, arg1: &mut 0x2::tx_context::TxContext) {
        let v0 = VestingVault{
            id              : 0x2::object::new(arg1),
            admin           : arg0,
            token_balance   : 0x2::balance::zero<0xf7837365ab32d2d9256ffd807232c618e07afe6a8896dbfb7c3e3f365853c22a::HetraCoin::HETRACOIN>(),
            schedules       : 0x2::table::new<address, vector<VestingSchedule>>(arg1),
            in_execution    : false,
            total_allocated : 0,
        };
        0x2::transfer::share_object<VestingVault>(v0);
    }

    public fun is_schedule_active(arg0: &VestingVault, arg1: address, arg2: u64) : bool {
        if (!0x2::table::contains<address, vector<VestingSchedule>>(&arg0.schedules, arg1)) {
            return false
        };
        let v0 = 0x2::table::borrow<address, vector<VestingSchedule>>(&arg0.schedules, arg1);
        if (arg2 >= 0x1::vector::length<VestingSchedule>(v0)) {
            return false
        };
        !0x1::vector::borrow<VestingSchedule>(v0, arg2).revoked
    }

    public entry fun revoke_vesting_schedule(arg0: &mut VestingVault, arg1: address, arg2: u64, arg3: &mut 0x2::tx_context::TxContext) {
        assert!(!arg0.in_execution, 3);
        arg0.in_execution = true;
        assert!(0x2::tx_context::sender(arg3) == arg0.admin, 1);
        assert!(0x2::table::contains<address, vector<VestingSchedule>>(&arg0.schedules, arg1), 5);
        let v0 = 0x2::table::borrow_mut<address, vector<VestingSchedule>>(&mut arg0.schedules, arg1);
        assert!(arg2 < 0x1::vector::length<VestingSchedule>(v0), 6);
        let v1 = 0x1::vector::borrow_mut<VestingSchedule>(v0, arg2);
        assert!(!v1.revoked, 6);
        v1.revoked = true;
        arg0.total_allocated = arg0.total_allocated - v1.total_amount - v1.claimed_amount;
        arg0.in_execution = false;
    }

    public entry fun withdraw_unused(arg0: &mut VestingVault, arg1: u64, arg2: &mut 0x2::tx_context::TxContext) {
        assert!(!arg0.in_execution, 3);
        arg0.in_execution = true;
        assert!(0x2::tx_context::sender(arg2) == arg0.admin, 1);
        let v0 = 0x2::balance::value<0xf7837365ab32d2d9256ffd807232c618e07afe6a8896dbfb7c3e3f365853c22a::HetraCoin::HETRACOIN>(&arg0.token_balance);
        assert!(v0 >= arg0.total_allocated, 2);
        assert!(arg1 <= v0 - arg0.total_allocated, 2);
        0x2::transfer::public_transfer<0x2::coin::Coin<0xf7837365ab32d2d9256ffd807232c618e07afe6a8896dbfb7c3e3f365853c22a::HetraCoin::HETRACOIN>>(0x2::coin::from_balance<0xf7837365ab32d2d9256ffd807232c618e07afe6a8896dbfb7c3e3f365853c22a::HetraCoin::HETRACOIN>(0x2::balance::split<0xf7837365ab32d2d9256ffd807232c618e07afe6a8896dbfb7c3e3f365853c22a::HetraCoin::HETRACOIN>(&mut arg0.token_balance, arg1), arg2), arg0.admin);
        arg0.in_execution = false;
    }

    // decompiled from Move bytecode v6
}

