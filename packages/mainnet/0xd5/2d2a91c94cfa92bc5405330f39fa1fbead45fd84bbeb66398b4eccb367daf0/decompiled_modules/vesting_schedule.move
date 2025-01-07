module 0xd52d2a91c94cfa92bc5405330f39fa1fbead45fd84bbeb66398b4eccb367daf0::vesting_schedule {
    struct AdminCap has store, key {
        id: 0x2::object::UID,
    }

    struct VestingSchedule<phantom T0> has store, key {
        id: 0x2::object::UID,
        clift: u64,
        duration: u64,
        amounts: 0x2::table::Table<address, u64>,
        released: 0x2::table::Table<address, u64>,
        balance: 0x2::balance::Balance<T0>,
        version: u64,
    }

    struct Deposit has copy, drop, store {
        vesting_schedule_id: 0x2::object::ID,
        amount: u64,
    }

    struct Withdraw has copy, drop, store {
        vesting_schedule_id: 0x2::object::ID,
        amount: u64,
    }

    struct Release has copy, drop, store {
        vesting_schedule_id: 0x2::object::ID,
        sender: address,
        amount: u64,
    }

    struct VestingScheduleCreated has copy, drop, store {
        vesting_schedule_id: 0x2::object::ID,
        clift: u64,
        duration: u64,
    }

    struct Allocate has copy, drop, store {
        vesting_schedule_id: 0x2::object::ID,
        addresses: vector<address>,
        amounts: vector<u64>,
    }

    struct Deallocate has copy, drop, store {
        vesting_schedule_id: 0x2::object::ID,
        addresses: vector<address>,
    }

    public entry fun allocate<T0>(arg0: &AdminCap, arg1: &mut VestingSchedule<T0>, arg2: vector<address>, arg3: vector<u64>) {
        check_version<T0>(arg1);
        assert!(0x1::vector::length<address>(&arg2) == 0x1::vector::length<u64>(&arg3), 2);
        let v0 = 0;
        while (v0 < 0x1::vector::length<address>(&arg2)) {
            0x2::table::add<address, u64>(&mut arg1.amounts, *0x1::vector::borrow<address>(&arg2, v0), *0x1::vector::borrow<u64>(&arg3, v0));
            v0 = v0 + 1;
        };
        let v1 = Allocate{
            vesting_schedule_id : 0x2::object::id<VestingSchedule<T0>>(arg1),
            addresses           : arg2,
            amounts             : arg3,
        };
        0x2::event::emit<Allocate>(v1);
    }

    public fun check_version<T0>(arg0: &VestingSchedule<T0>) {
        assert!(arg0.version == 1, 999);
    }

    public entry fun create_vesting_schedule<T0>(arg0: &AdminCap, arg1: u64, arg2: u64, arg3: &0x2::clock::Clock, arg4: &mut 0x2::tx_context::TxContext) {
        assert!(arg1 > 0x2::clock::timestamp_ms(arg3) && arg2 > 0, 0);
        let v0 = VestingSchedule<T0>{
            id       : 0x2::object::new(arg4),
            clift    : arg1,
            duration : arg2,
            amounts  : 0x2::table::new<address, u64>(arg4),
            released : 0x2::table::new<address, u64>(arg4),
            balance  : 0x2::balance::zero<T0>(),
            version  : 1,
        };
        let v1 = VestingScheduleCreated{
            vesting_schedule_id : 0x2::object::id<VestingSchedule<T0>>(&v0),
            clift               : arg1,
            duration            : arg2,
        };
        0x2::event::emit<VestingScheduleCreated>(v1);
        0x2::transfer::share_object<VestingSchedule<T0>>(v0);
    }

    public entry fun deallocate<T0>(arg0: &AdminCap, arg1: &mut VestingSchedule<T0>, arg2: vector<address>) {
        check_version<T0>(arg1);
        let v0 = 0;
        while (v0 < 0x1::vector::length<address>(&arg2)) {
            0x2::table::remove<address, u64>(&mut arg1.amounts, *0x1::vector::borrow<address>(&arg2, v0));
            v0 = v0 + 1;
        };
        let v1 = Deallocate{
            vesting_schedule_id : 0x2::object::id<VestingSchedule<T0>>(arg1),
            addresses           : arg2,
        };
        0x2::event::emit<Deallocate>(v1);
    }

    public entry fun deposit<T0>(arg0: &AdminCap, arg1: &mut VestingSchedule<T0>, arg2: 0x2::coin::Coin<T0>) {
        check_version<T0>(arg1);
        0x2::balance::join<T0>(&mut arg1.balance, 0x2::coin::into_balance<T0>(arg2));
        let v0 = Deposit{
            vesting_schedule_id : 0x2::object::id<VestingSchedule<T0>>(arg1),
            amount              : 0x2::coin::value<T0>(&arg2),
        };
        0x2::event::emit<Deposit>(v0);
    }

    fun init(arg0: &mut 0x2::tx_context::TxContext) {
        let v0 = AdminCap{id: 0x2::object::new(arg0)};
        0x2::transfer::transfer<AdminCap>(v0, 0x2::tx_context::sender(arg0));
    }

    public entry fun release<T0>(arg0: &mut VestingSchedule<T0>, arg1: &0x2::clock::Clock, arg2: &mut 0x2::tx_context::TxContext) {
        check_version<T0>(arg0);
        let v0 = 0x2::clock::timestamp_ms(arg1);
        let v1 = 0x2::tx_context::sender(arg2);
        assert!(0x2::table::contains<address, u64>(&arg0.amounts, v1), 1);
        if (!0x2::table::contains<address, u64>(&arg0.released, v1)) {
            0x2::table::add<address, u64>(&mut arg0.released, v1, 0);
        };
        let v2 = 0x2::table::borrow_mut<address, u64>(&mut arg0.released, v1);
        let v3 = if (v0 <= arg0.clift) {
            0
        } else {
            (((*0x2::table::borrow<address, u64>(&arg0.amounts, v1) as u128) * (0x2::math::min(arg0.duration, v0 - arg0.clift) as u128) / (arg0.duration as u128)) as u64) - *v2
        };
        *v2 = *v2 + v3;
        0x2::transfer::public_transfer<0x2::coin::Coin<T0>>(0x2::coin::take<T0>(&mut arg0.balance, v3, arg2), v1);
        let v4 = Release{
            vesting_schedule_id : 0x2::object::id<VestingSchedule<T0>>(arg0),
            sender              : 0x2::tx_context::sender(arg2),
            amount              : v3,
        };
        0x2::event::emit<Release>(v4);
    }

    public entry fun upgrade<T0>(arg0: &AdminCap, arg1: &mut VestingSchedule<T0>) {
        assert!(arg1.version < 1, 1000);
        arg1.version = 1;
    }

    public entry fun withdraw<T0>(arg0: &AdminCap, arg1: &mut VestingSchedule<T0>, arg2: u64, arg3: &mut 0x2::tx_context::TxContext) {
        check_version<T0>(arg1);
        0x2::transfer::public_transfer<0x2::coin::Coin<T0>>(0x2::coin::take<T0>(&mut arg1.balance, arg2, arg3), 0x2::tx_context::sender(arg3));
        let v0 = Withdraw{
            vesting_schedule_id : 0x2::object::id<VestingSchedule<T0>>(arg1),
            amount              : arg2,
        };
        0x2::event::emit<Withdraw>(v0);
    }

    // decompiled from Move bytecode v6
}

