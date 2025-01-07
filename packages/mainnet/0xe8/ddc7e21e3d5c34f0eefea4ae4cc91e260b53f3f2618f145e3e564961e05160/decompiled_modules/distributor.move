module 0xe8ddc7e21e3d5c34f0eefea4ae4cc91e260b53f3f2618f145e3e564961e05160::distributor {
    struct Schedule has store {
        alloc_point: u64,
        clift: u64,
        duration: u64,
    }

    struct VestingSchedule has store, key {
        id: 0x2::object::UID,
        total_alloc_point: u64,
        schedules: vector<Schedule>,
        amounts: 0x2::table::Table<address, u64>,
        released: 0x2::table::Table<address, u64>,
    }

    struct Distribute has copy, drop {
        amount: u64,
        recipient: address,
    }

    public(friend) fun new<T0>(arg0: vector<u64>, arg1: vector<u64>, arg2: vector<u64>, arg3: 0x2::coin::Coin<T0>, arg4: &0x2::clock::Clock, arg5: &mut 0x2::tx_context::TxContext) : VestingSchedule {
        assert!(0x1::vector::length<u64>(&arg0) == 0x1::vector::length<u64>(&arg1) && 0x1::vector::length<u64>(&arg0) == 0x1::vector::length<u64>(&arg2), 0);
        let v0 = VestingSchedule{
            id                : 0x2::object::new(arg5),
            total_alloc_point : 0,
            schedules         : 0x1::vector::empty<Schedule>(),
            amounts           : 0x2::table::new<address, u64>(arg5),
            released          : 0x2::table::new<address, u64>(arg5),
        };
        0x2::dynamic_field::add<0xe8ddc7e21e3d5c34f0eefea4ae4cc91e260b53f3f2618f145e3e564961e05160::utils::Marker<T0>, 0x2::balance::Balance<T0>>(&mut v0.id, 0xe8ddc7e21e3d5c34f0eefea4ae4cc91e260b53f3f2618f145e3e564961e05160::utils::marker<T0>(), 0x2::coin::into_balance<T0>(arg3));
        let v1 = 0;
        let v2 = 0x2::clock::timestamp_ms(arg4);
        while (v1 < 0x1::vector::length<u64>(&arg0)) {
            let v3 = *0x1::vector::borrow<u64>(&arg0, v1);
            v2 = *0x1::vector::borrow<u64>(&arg1, v1);
            let v4 = *0x1::vector::borrow<u64>(&arg2, v1);
            assert!(v3 > 0, 1);
            assert!(v2 > v2 && v4 > 0, 2);
            let v5 = Schedule{
                alloc_point : v3,
                clift       : v2,
                duration    : v4,
            };
            0x1::vector::push_back<Schedule>(&mut v0.schedules, v5);
            v1 = v1 + 1;
        };
        v0
    }

    public fun amount_of(arg0: &VestingSchedule, arg1: address) : u64 {
        *0x2::table::borrow<address, u64>(&arg0.amounts, arg1)
    }

    public(friend) fun deposit<T0>(arg0: &mut VestingSchedule, arg1: 0x2::coin::Coin<T0>) {
        0x2::balance::join<T0>(0x2::dynamic_field::borrow_mut<0xe8ddc7e21e3d5c34f0eefea4ae4cc91e260b53f3f2618f145e3e564961e05160::utils::Marker<T0>, 0x2::balance::Balance<T0>>(&mut arg0.id, 0xe8ddc7e21e3d5c34f0eefea4ae4cc91e260b53f3f2618f145e3e564961e05160::utils::marker<T0>()), 0x2::coin::into_balance<T0>(arg1));
    }

    public(friend) fun distribute(arg0: &mut VestingSchedule, arg1: address, arg2: u64) {
        assert!(!0x2::table::contains<address, u64>(&arg0.amounts, arg1), 4);
        0x2::table::add<address, u64>(&mut arg0.amounts, arg1, arg2);
        let v0 = Distribute{
            amount    : arg2,
            recipient : arg1,
        };
        0x2::event::emit<Distribute>(v0);
    }

    public fun releasable_amount(arg0: &VestingSchedule, arg1: address, arg2: &0x2::clock::Clock) : u64 {
        let v0 = if (!0x2::table::contains<address, u64>(&arg0.released, arg1)) {
            0
        } else {
            *0x2::table::borrow<address, u64>(&arg0.released, arg1)
        };
        vested_amount(arg0, arg1, arg2) - v0
    }

    public(friend) fun release<T0>(arg0: &mut VestingSchedule, arg1: &0x2::clock::Clock, arg2: &0x2::tx_context::TxContext) : 0x2::balance::Balance<T0> {
        let v0 = 0x2::tx_context::sender(arg2);
        let v1 = releasable_amount(arg0, v0, arg1);
        assert!(v1 > 0, 3);
        released(arg0, v0, v1);
        0x2::balance::split<T0>(0x2::dynamic_field::borrow_mut<0xe8ddc7e21e3d5c34f0eefea4ae4cc91e260b53f3f2618f145e3e564961e05160::utils::Marker<T0>, 0x2::balance::Balance<T0>>(&mut arg0.id, 0xe8ddc7e21e3d5c34f0eefea4ae4cc91e260b53f3f2618f145e3e564961e05160::utils::marker<T0>()), v1)
    }

    fun released(arg0: &mut VestingSchedule, arg1: address, arg2: u64) {
        if (!0x2::table::contains<address, u64>(&arg0.released, arg1)) {
            0x2::table::add<address, u64>(&mut arg0.released, arg1, arg2);
        } else {
            let v0 = 0x2::table::borrow_mut<address, u64>(&mut arg0.released, arg1);
            *v0 = *v0 + arg2;
        };
    }

    fun unsafe_vested_amount_at(arg0: &VestingSchedule, arg1: u64, arg2: address, arg3: &0x2::clock::Clock) : u64 {
        let v0 = 0x1::vector::borrow<Schedule>(&arg0.schedules, arg1);
        let v1 = 0x2::clock::timestamp_ms(arg3);
        if (v1 < v0.clift) {
            0
        } else if (v1 >= v0.clift + v0.duration) {
            0xe8ddc7e21e3d5c34f0eefea4ae4cc91e260b53f3f2618f145e3e564961e05160::math::mul_div(*0x2::table::borrow<address, u64>(&arg0.amounts, arg2), v0.alloc_point, arg0.total_alloc_point)
        } else {
            (((0xe8ddc7e21e3d5c34f0eefea4ae4cc91e260b53f3f2618f145e3e564961e05160::math::mul_div(*0x2::table::borrow<address, u64>(&arg0.amounts, arg2), v0.alloc_point, arg0.total_alloc_point) as u256) * ((v1 - v0.clift) as u256) / (v0.duration as u256)) as u64)
        }
    }

    public fun vested_amount(arg0: &VestingSchedule, arg1: address, arg2: &0x2::clock::Clock) : u64 {
        let v0 = 0;
        let v1 = 0;
        while (v0 < 0x1::vector::length<Schedule>(&arg0.schedules)) {
            v1 = v1 + unsafe_vested_amount_at(arg0, v0, arg1, arg2);
            v0 = v0 + 1;
        };
        v1
    }

    public fun vested_amount_at(arg0: &VestingSchedule, arg1: u64, arg2: address, arg3: &0x2::clock::Clock) : u64 {
        assert!(arg1 < 0x1::vector::length<Schedule>(&arg0.schedules), 0);
        unsafe_vested_amount_at(arg0, arg1, arg2, arg3)
    }

    // decompiled from Move bytecode v6
}

