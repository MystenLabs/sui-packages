module 0x9f147826eca429064bcb3b4f58d291d8d9e1813b90a5dd397dc7d5fab2ac2d8d::vesting {
    struct VESTING has drop {
        dummy_field: bool,
    }

    struct VestingAdminCap has store, key {
        id: 0x2::object::UID,
    }

    struct VestingSchedule has copy, drop, store {
        user_address: address,
        total_amount: u64,
        start_time: u64,
        cliff_time: u64,
        end_time: u64,
        claimed_amount: u64,
    }

    struct VestingPool has key {
        id: 0x2::object::UID,
        coin_bag: 0x2::balance::Balance<0x4deb377c33bfced1ab81cde96918e2538fe78735777150b0064ccf7df5e1c81::tato::TATO>,
        vesting_schedules: 0x2::table::Table<address, VestingSchedule>,
        treasury_address: address,
        version: u64,
        paused: bool,
    }

    struct VestingInfo has copy, drop {
        total_amount: u64,
        start_time: u64,
        cliff_time: u64,
        end_time: u64,
        claimed_amount: u64,
        currently_vested: u64,
        claimable_now: u64,
        locked_amount: u64,
        unlockable_with_utato: u64,
    }

    public entry fun add_batch_vesting(arg0: &VestingAdminCap, arg1: &mut VestingPool, arg2: vector<address>, arg3: vector<u64>, arg4: u64, arg5: u64, arg6: u64) {
        check_version(arg1);
        assert!(0x1::vector::length<address>(&arg2) == 0x1::vector::length<u64>(&arg3), 8);
        assert!(arg4 < arg5 && arg5 < arg6, 3);
        let v0 = 0;
        while (v0 < 0x1::vector::length<address>(&arg2)) {
            let v1 = *0x1::vector::borrow<address>(&arg2, v0);
            assert!(!0x2::table::contains<address, VestingSchedule>(&arg1.vesting_schedules, v1), 6);
            let v2 = VestingSchedule{
                user_address   : v1,
                total_amount   : *0x1::vector::borrow<u64>(&arg3, v0),
                start_time     : arg4,
                cliff_time     : arg5,
                end_time       : arg6,
                claimed_amount : 0,
            };
            0x2::table::add<address, VestingSchedule>(&mut arg1.vesting_schedules, v1, v2);
            v0 = v0 + 1;
        };
    }

    public entry fun add_vesting_schedule(arg0: &VestingAdminCap, arg1: &mut VestingPool, arg2: address, arg3: u64, arg4: u64, arg5: u64, arg6: u64) {
        check_version(arg1);
        assert!(arg4 < arg5 && arg5 < arg6, 3);
        assert!(!0x2::table::contains<address, VestingSchedule>(&arg1.vesting_schedules, arg2), 6);
        let v0 = VestingSchedule{
            user_address   : arg2,
            total_amount   : arg3,
            start_time     : arg4,
            cliff_time     : arg5,
            end_time       : arg6,
            claimed_amount : 0,
        };
        0x2::table::add<address, VestingSchedule>(&mut arg1.vesting_schedules, arg2, v0);
    }

    fun calculate_vested_amount(arg0: &VestingSchedule, arg1: u64) : u64 {
        if (arg1 < arg0.cliff_time) {
            return 0
        };
        if (arg1 >= arg0.end_time) {
            return arg0.total_amount
        };
        (((arg0.total_amount as u128) * ((arg1 - arg0.cliff_time) as u128) / ((arg0.end_time - arg0.cliff_time) as u128)) as u64)
    }

    public(friend) fun check_not_paused(arg0: &VestingPool) {
        assert!(!arg0.paused, 11);
    }

    public(friend) fun check_version(arg0: &VestingPool) {
        assert!(arg0.version == 1, 10);
    }

    public entry fun claim_vested(arg0: &mut VestingPool, arg1: &0x2::clock::Clock, arg2: &mut 0x2::tx_context::TxContext) {
        check_version(arg0);
        check_not_paused(arg0);
        let v0 = 0x2::tx_context::sender(arg2);
        assert!(0x2::table::contains<address, VestingSchedule>(&arg0.vesting_schedules, v0), 2);
        let v1 = 0x2::table::borrow_mut<address, VestingSchedule>(&mut arg0.vesting_schedules, v0);
        let v2 = calculate_vested_amount(v1, 0x2::clock::timestamp_ms(arg1)) - v1.claimed_amount;
        assert!(v2 > 0, 4);
        assert!(0x2::balance::value<0x4deb377c33bfced1ab81cde96918e2538fe78735777150b0064ccf7df5e1c81::tato::TATO>(&arg0.coin_bag) >= v2, 7);
        v1.claimed_amount = v1.claimed_amount + v2;
        0x2::transfer::public_transfer<0x2::coin::Coin<0x4deb377c33bfced1ab81cde96918e2538fe78735777150b0064ccf7df5e1c81::tato::TATO>>(0x2::coin::from_balance<0x4deb377c33bfced1ab81cde96918e2538fe78735777150b0064ccf7df5e1c81::tato::TATO>(0x2::balance::split<0x4deb377c33bfced1ab81cde96918e2538fe78735777150b0064ccf7df5e1c81::tato::TATO>(&mut arg0.coin_bag, v2), arg2), v0);
    }

    public entry fun fund_pool(arg0: &mut VestingPool, arg1: 0x2::coin::Coin<0x4deb377c33bfced1ab81cde96918e2538fe78735777150b0064ccf7df5e1c81::tato::TATO>) {
        check_version(arg0);
        0x2::balance::join<0x4deb377c33bfced1ab81cde96918e2538fe78735777150b0064ccf7df5e1c81::tato::TATO>(&mut arg0.coin_bag, 0x2::coin::into_balance<0x4deb377c33bfced1ab81cde96918e2538fe78735777150b0064ccf7df5e1c81::tato::TATO>(arg1));
    }

    public fun get_pool_balance(arg0: &VestingPool) : u64 {
        0x2::balance::value<0x4deb377c33bfced1ab81cde96918e2538fe78735777150b0064ccf7df5e1c81::tato::TATO>(&arg0.coin_bag)
    }

    public fun get_version(arg0: &VestingPool) : u64 {
        arg0.version
    }

    public fun get_vesting_info(arg0: &VestingPool, arg1: &0x2::clock::Clock, arg2: address) : VestingInfo {
        assert!(0x2::table::contains<address, VestingSchedule>(&arg0.vesting_schedules, arg2), 2);
        let v0 = 0x2::table::borrow<address, VestingSchedule>(&arg0.vesting_schedules, arg2);
        let v1 = calculate_vested_amount(v0, 0x2::clock::timestamp_ms(arg1));
        let v2 = if (v1 > v0.claimed_amount) {
            v1 - v0.claimed_amount
        } else {
            0
        };
        let v3 = if (v0.claimed_amount > v1) {
            v0.claimed_amount
        } else {
            v1
        };
        VestingInfo{
            total_amount          : v0.total_amount,
            start_time            : v0.start_time,
            cliff_time            : v0.cliff_time,
            end_time              : v0.end_time,
            claimed_amount        : v0.claimed_amount,
            currently_vested      : v1,
            claimable_now         : v2,
            locked_amount         : v0.total_amount - v3,
            unlockable_with_utato : 0,
        }
    }

    public fun has_vesting_schedule(arg0: &VestingPool, arg1: address) : bool {
        0x2::table::contains<address, VestingSchedule>(&arg0.vesting_schedules, arg1)
    }

    fun init(arg0: VESTING, arg1: &mut 0x2::tx_context::TxContext) {
        let v0 = VestingAdminCap{id: 0x2::object::new(arg1)};
        let v1 = VestingPool{
            id                : 0x2::object::new(arg1),
            coin_bag          : 0x2::balance::zero<0x4deb377c33bfced1ab81cde96918e2538fe78735777150b0064ccf7df5e1c81::tato::TATO>(),
            vesting_schedules : 0x2::table::new<address, VestingSchedule>(arg1),
            treasury_address  : 0x2::tx_context::sender(arg1),
            version           : 1,
            paused            : false,
        };
        0x2::transfer::transfer<VestingAdminCap>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::share_object<VestingPool>(v1);
    }

    public fun is_paused(arg0: &VestingPool) : bool {
        arg0.paused
    }

    public entry fun remove_vesting_schedule(arg0: &VestingAdminCap, arg1: &mut VestingPool, arg2: address) {
        check_version(arg1);
        assert!(0x2::table::contains<address, VestingSchedule>(&arg1.vesting_schedules, arg2), 2);
        0x2::table::remove<address, VestingSchedule>(&mut arg1.vesting_schedules, arg2);
    }

    public entry fun set_paused(arg0: &VestingAdminCap, arg1: &mut VestingPool, arg2: bool) {
        arg1.paused = arg2;
    }

    public entry fun set_treasury_address(arg0: &VestingAdminCap, arg1: &mut VestingPool, arg2: address) {
        arg1.treasury_address = arg2;
    }

    public entry fun upgrade_version(arg0: &VestingAdminCap, arg1: &mut VestingPool) {
        assert!(arg1.version < 1, 10);
        arg1.version = 1;
    }

    // decompiled from Move bytecode v6
}

