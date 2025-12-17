module 0xeb48ade947a21f00370bd3ef80a863dd165c360448e940afbd95ba5dcf86abc4::vesting {
    struct VESTING has drop {
        dummy_field: bool,
    }

    struct UnlockSchedule has copy, drop, store {
        timestamp: u64,
        amount: u64,
    }

    struct VestingConfig has key {
        id: 0x2::object::UID,
        min_version: u64,
        primary_owner: address,
        secondary_owner: address,
        start_time: u64,
        locked_amount: u64,
        withdrawn_amount: u64,
        unlock_schedules: vector<UnlockSchedule>,
    }

    struct UpgradeCapManager has key {
        id: 0x2::object::UID,
        upgrade_cap: 0x2::package::UpgradeCap,
    }

    struct VestingTokenHolder<phantom T0> has key {
        id: 0x2::object::UID,
        balance: 0x2::balance::Balance<T0>,
    }

    struct PrimaryOwnerChanged has copy, drop {
        old_owner: address,
        new_owner: address,
    }

    struct SecondaryOwnerChanged has copy, drop {
        old_owner: address,
        new_owner: address,
    }

    struct StartTimeChanged has copy, drop {
        old_start_time: u64,
        new_start_time: u64,
    }

    struct LockedAmountChanged has copy, drop {
        old_amount: u64,
        new_amount: u64,
    }

    struct UnlockSchedulesChanged has copy, drop {
        schedule_count: u64,
    }

    struct Withdraw has copy, drop {
        to: address,
        amount: u64,
    }

    struct EmergencyWithdraw has copy, drop {
        to: address,
        amount: u64,
    }

    struct UpgradeAuthorized has copy, drop {
        authorized_by: address,
        policy: u8,
    }

    struct MinVersionChanged has copy, drop {
        old_min_version: u64,
        new_min_version: u64,
    }

    struct UpgradeCapStored has copy, drop {
        manager_id: 0x2::object::ID,
    }

    struct InitCap has store, key {
        id: 0x2::object::UID,
    }

    public fun authorize_upgrade(arg0: &mut UpgradeCapManager, arg1: &VestingConfig, arg2: u8, arg3: vector<u8>, arg4: &0x2::clock::Clock, arg5: &0x2::tx_context::TxContext) : 0x2::package::UpgradeTicket {
        check_package_version(arg1);
        only_authorized(arg1, 0x2::tx_context::sender(arg5), arg4);
        let v0 = UpgradeAuthorized{
            authorized_by : 0x2::tx_context::sender(arg5),
            policy        : arg2,
        };
        0x2::event::emit<UpgradeAuthorized>(v0);
        0x2::package::authorize_upgrade(&mut arg0.upgrade_cap, arg2, arg3)
    }

    public fun commit_upgrade(arg0: &mut UpgradeCapManager, arg1: 0x2::package::UpgradeReceipt) {
        0x2::package::commit_upgrade(&mut arg0.upgrade_cap, arg1);
    }

    fun check_package_version(arg0: &VestingConfig) {
        assert!(arg0.min_version <= 1, 6);
    }

    public fun create_unlock_schedule(arg0: u64, arg1: u64) : UnlockSchedule {
        UnlockSchedule{
            timestamp : arg0,
            amount    : arg1,
        }
    }

    public fun deposit<T0>(arg0: &mut VestingTokenHolder<T0>, arg1: 0x2::coin::Coin<T0>) {
        0x2::balance::join<T0>(&mut arg0.balance, 0x2::coin::into_balance<T0>(arg1));
    }

    public fun emergency_pause(arg0: &mut VestingConfig, arg1: &0x2::clock::Clock, arg2: &0x2::tx_context::TxContext) {
        only_authorized(arg0, 0x2::tx_context::sender(arg2), arg1);
        arg0.min_version = 18446744073709551615;
    }

    public fun emergency_withdraw<T0>(arg0: &VestingConfig, arg1: &mut VestingTokenHolder<T0>, arg2: address, arg3: u64, arg4: &0x2::clock::Clock, arg5: &mut 0x2::tx_context::TxContext) {
        only_authorized(arg0, 0x2::tx_context::sender(arg5), arg4);
        assert!(arg2 != @0x0, 3);
        assert!(arg3 > 0, 4);
        assert!(0x2::balance::value<T0>(&arg1.balance) >= arg3, 5);
        0x2::transfer::public_transfer<0x2::coin::Coin<T0>>(0x2::coin::from_balance<T0>(0x2::balance::split<T0>(&mut arg1.balance, arg3), arg5), arg2);
        let v0 = EmergencyWithdraw{
            to     : arg2,
            amount : arg3,
        };
        0x2::event::emit<EmergencyWithdraw>(v0);
    }

    public fun extract_upgrade_cap(arg0: UpgradeCapManager, arg1: &VestingConfig, arg2: &0x2::clock::Clock, arg3: &0x2::tx_context::TxContext) : 0x2::package::UpgradeCap {
        only_authorized(arg1, 0x2::tx_context::sender(arg3), arg2);
        let UpgradeCapManager {
            id          : v0,
            upgrade_cap : v1,
        } = arg0;
        0x2::object::delete(v0);
        v1
    }

    public fun get_available_amount(arg0: &VestingConfig, arg1: &0x2::clock::Clock) : u64 {
        let v0 = 0x2::clock::timestamp_ms(arg1);
        if (v0 < arg0.start_time) {
            return 0
        };
        let v1 = 0;
        let v2 = 0;
        while (v2 < 0x1::vector::length<UnlockSchedule>(&arg0.unlock_schedules)) {
            let v3 = 0x1::vector::borrow<UnlockSchedule>(&arg0.unlock_schedules, v2);
            if (v0 >= v3.timestamp) {
                v1 = v3.amount;
            };
            v2 = v2 + 1;
        };
        if (v1 > arg0.withdrawn_amount) {
            v1 - arg0.withdrawn_amount
        } else {
            0
        }
    }

    public fun get_unlock_schedule(arg0: &VestingConfig, arg1: u64) : (u64, u64) {
        let v0 = 0x1::vector::borrow<UnlockSchedule>(&arg0.unlock_schedules, arg1);
        (v0.timestamp, v0.amount)
    }

    fun init(arg0: VESTING, arg1: &mut 0x2::tx_context::TxContext) {
        0x2::transfer::public_transfer<0x2::package::Publisher>(0x2::package::claim<VESTING>(arg0, arg1), 0x2::tx_context::sender(arg1));
        let v0 = InitCap{id: 0x2::object::new(arg1)};
        0x2::transfer::public_transfer<InitCap>(v0, 0x2::tx_context::sender(arg1));
    }

    public fun initialize<T0>(arg0: InitCap, arg1: address, arg2: address, arg3: u64, arg4: u64, arg5: vector<UnlockSchedule>, arg6: &mut 0x2::tx_context::TxContext) {
        let InitCap { id: v0 } = arg0;
        0x2::object::delete(v0);
        assert!(arg1 != @0x0, 3);
        assert!(arg3 > 0, 4);
        assert!(arg4 > 0, 4);
        assert!(0x1::vector::length<UnlockSchedule>(&arg5) > 0, 1);
        validate_unlock_schedules(arg3, arg4, &arg5);
        let v1 = VestingConfig{
            id               : 0x2::object::new(arg6),
            min_version      : 0,
            primary_owner    : arg1,
            secondary_owner  : arg2,
            start_time       : arg3,
            locked_amount    : arg4,
            withdrawn_amount : 0,
            unlock_schedules : arg5,
        };
        let v2 = VestingTokenHolder<T0>{
            id      : 0x2::object::new(arg6),
            balance : 0x2::balance::zero<T0>(),
        };
        0x2::transfer::share_object<VestingConfig>(v1);
        0x2::transfer::share_object<VestingTokenHolder<T0>>(v2);
    }

    public fun locked_amount(arg0: &VestingConfig) : u64 {
        arg0.locked_amount
    }

    public fun min_version(arg0: &VestingConfig) : u64 {
        arg0.min_version
    }

    fun only_authorized(arg0: &VestingConfig, arg1: address, arg2: &0x2::clock::Clock) {
        if (arg1 == arg0.primary_owner) {
            return
        };
        if (0x2::clock::timestamp_ms(arg2) < arg0.start_time + 15552000000) {
            assert!(arg1 == arg0.primary_owner, 2);
        } else {
            assert!(arg1 == arg0.secondary_owner, 2);
        };
    }

    fun only_primary_owner(arg0: &VestingConfig, arg1: address) {
        assert!(arg1 == arg0.primary_owner, 2);
    }

    fun only_secondary_owner(arg0: &VestingConfig, arg1: address) {
        assert!(arg1 == arg0.secondary_owner, 2);
    }

    public fun primary_owner(arg0: &VestingConfig) : address {
        arg0.primary_owner
    }

    public fun secondary_owner(arg0: &VestingConfig) : address {
        arg0.secondary_owner
    }

    public fun set_locked_amount(arg0: &mut VestingConfig, arg1: u64, arg2: vector<UnlockSchedule>, arg3: &0x2::clock::Clock, arg4: &0x2::tx_context::TxContext) {
        only_authorized(arg0, 0x2::tx_context::sender(arg4), arg3);
        check_package_version(arg0);
        assert!(arg1 > 0, 4);
        if (0x1::vector::length<UnlockSchedule>(&arg2) > 0) {
            validate_unlock_schedules(arg0.start_time, arg1, &arg2);
            arg0.unlock_schedules = arg2;
            let v0 = UnlockSchedulesChanged{schedule_count: 0x1::vector::length<UnlockSchedule>(&arg2)};
            0x2::event::emit<UnlockSchedulesChanged>(v0);
        } else if (0x1::vector::length<UnlockSchedule>(&arg0.unlock_schedules) > 0) {
            validate_unlock_schedules(arg0.start_time, arg1, &arg0.unlock_schedules);
        };
        arg0.locked_amount = arg1;
        let v1 = LockedAmountChanged{
            old_amount : arg0.locked_amount,
            new_amount : arg1,
        };
        0x2::event::emit<LockedAmountChanged>(v1);
    }

    public fun set_min_version(arg0: &mut VestingConfig, arg1: u64, arg2: &0x2::clock::Clock, arg3: &0x2::tx_context::TxContext) {
        only_authorized(arg0, 0x2::tx_context::sender(arg3), arg2);
        arg0.min_version = arg1;
        let v0 = MinVersionChanged{
            old_min_version : arg0.min_version,
            new_min_version : arg1,
        };
        0x2::event::emit<MinVersionChanged>(v0);
    }

    public fun set_primary_owner(arg0: &mut VestingConfig, arg1: address, arg2: &0x2::tx_context::TxContext) {
        only_primary_owner(arg0, 0x2::tx_context::sender(arg2));
        check_package_version(arg0);
        assert!(arg1 != @0x0, 3);
        arg0.primary_owner = arg1;
        let v0 = PrimaryOwnerChanged{
            old_owner : arg0.primary_owner,
            new_owner : arg1,
        };
        0x2::event::emit<PrimaryOwnerChanged>(v0);
    }

    public fun set_secondary_owner(arg0: &mut VestingConfig, arg1: address, arg2: &0x2::clock::Clock, arg3: &0x2::tx_context::TxContext) {
        only_authorized(arg0, 0x2::tx_context::sender(arg3), arg2);
        check_package_version(arg0);
        arg0.secondary_owner = arg1;
        let v0 = SecondaryOwnerChanged{
            old_owner : arg0.secondary_owner,
            new_owner : arg1,
        };
        0x2::event::emit<SecondaryOwnerChanged>(v0);
    }

    public fun set_start_time(arg0: &mut VestingConfig, arg1: u64, arg2: &0x2::clock::Clock, arg3: &0x2::tx_context::TxContext) {
        only_authorized(arg0, 0x2::tx_context::sender(arg3), arg2);
        check_package_version(arg0);
        assert!(arg1 > 0, 4);
        if (0x1::vector::length<UnlockSchedule>(&arg0.unlock_schedules) > 0) {
            validate_unlock_schedules(arg1, arg0.locked_amount, &arg0.unlock_schedules);
        };
        arg0.start_time = arg1;
        let v0 = StartTimeChanged{
            old_start_time : arg0.start_time,
            new_start_time : arg1,
        };
        0x2::event::emit<StartTimeChanged>(v0);
    }

    public fun set_unlock_schedules(arg0: &mut VestingConfig, arg1: vector<UnlockSchedule>, arg2: &0x2::clock::Clock, arg3: &0x2::tx_context::TxContext) {
        only_authorized(arg0, 0x2::tx_context::sender(arg3), arg2);
        check_package_version(arg0);
        validate_unlock_schedules(arg0.start_time, arg0.locked_amount, &arg1);
        arg0.unlock_schedules = arg1;
        let v0 = UnlockSchedulesChanged{schedule_count: 0x1::vector::length<UnlockSchedule>(&arg1)};
        0x2::event::emit<UnlockSchedulesChanged>(v0);
    }

    public fun start_time(arg0: &VestingConfig) : u64 {
        arg0.start_time
    }

    public fun store_upgrade_cap(arg0: 0x2::package::UpgradeCap, arg1: &mut 0x2::tx_context::TxContext) {
        let v0 = 0x2::object::new(arg1);
        let v1 = UpgradeCapManager{
            id          : v0,
            upgrade_cap : arg0,
        };
        let v2 = UpgradeCapStored{manager_id: 0x2::object::uid_to_inner(&v0)};
        0x2::event::emit<UpgradeCapStored>(v2);
        0x2::transfer::share_object<UpgradeCapManager>(v1);
    }

    public fun token_balance<T0>(arg0: &VestingTokenHolder<T0>) : u64 {
        0x2::balance::value<T0>(&arg0.balance)
    }

    public fun unlock_schedules_count(arg0: &VestingConfig) : u64 {
        0x1::vector::length<UnlockSchedule>(&arg0.unlock_schedules)
    }

    fun validate_unlock_schedules(arg0: u64, arg1: u64, arg2: &vector<UnlockSchedule>) {
        let v0 = 0x1::vector::length<UnlockSchedule>(arg2);
        assert!(v0 > 0, 1);
        assert!(0x1::vector::borrow<UnlockSchedule>(arg2, 0).timestamp > arg0, 1);
        let v1 = 1;
        while (v1 < v0) {
            let v2 = 0x1::vector::borrow<UnlockSchedule>(arg2, v1 - 1);
            let v3 = 0x1::vector::borrow<UnlockSchedule>(arg2, v1);
            assert!(v3.timestamp > v2.timestamp, 1);
            assert!(v3.amount > v2.amount, 1);
            v1 = v1 + 1;
        };
        assert!(0x1::vector::borrow<UnlockSchedule>(arg2, v0 - 1).amount == arg1, 1);
    }

    public fun withdraw<T0>(arg0: &mut VestingConfig, arg1: &mut VestingTokenHolder<T0>, arg2: &0x2::clock::Clock, arg3: &mut 0x2::tx_context::TxContext) {
        only_secondary_owner(arg0, 0x2::tx_context::sender(arg3));
        check_package_version(arg0);
        let v0 = get_available_amount(arg0, arg2);
        assert!(v0 > 0, 5);
        arg0.withdrawn_amount = arg0.withdrawn_amount + v0;
        0x2::transfer::public_transfer<0x2::coin::Coin<T0>>(0x2::coin::from_balance<T0>(0x2::balance::split<T0>(&mut arg1.balance, v0), arg3), arg0.secondary_owner);
        let v1 = Withdraw{
            to     : arg0.secondary_owner,
            amount : v0,
        };
        0x2::event::emit<Withdraw>(v1);
    }

    public fun withdrawn_amount(arg0: &VestingConfig) : u64 {
        arg0.withdrawn_amount
    }

    // decompiled from Move bytecode v6
}

