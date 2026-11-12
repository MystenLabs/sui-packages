module 0x918d32f8a0b349584e96113ec425708374161d4798f8c28d63362602831b33ef::vested {
    struct VestKey has copy, drop, store {
        dummy_field: bool,
    }

    struct Vesting has copy, drop, store {
        duration_ms: u64,
        end_ms: u64,
    }

    struct PositionKey has copy, drop, store {
        owner: address,
    }

    struct Position<phantom T0> has store {
        locked: 0x2::balance::Balance<T0>,
        rate: u256,
    }

    struct VestingConfigured has copy, drop {
        curve_id: 0x2::object::ID,
        duration_ms: u64,
        end_ms: u64,
    }

    struct VestedBuy has copy, drop {
        curve_id: 0x2::object::ID,
        owner: address,
        amount: u64,
        start_ms: u64,
        end_ms: u64,
    }

    struct VestedClaimed has copy, drop {
        curve_id: 0x2::object::ID,
        owner: address,
        amount: u64,
        left: u64,
    }

    public(friend) fun add<T0>(arg0: &mut Position<T0>, arg1: 0x2::balance::Balance<T0>, arg2: u64, arg3: u64) {
        arg0.rate = arg0.rate + rate_of(0x2::balance::value<T0>(&arg1), arg2, arg3);
        0x2::balance::join<T0>(&mut arg0.locked, arg1);
    }

    public(friend) fun claim_at<T0>(arg0: &mut 0x2::object::UID, arg1: 0x2::object::ID, arg2: address, arg3: u64, arg4: &mut 0x2::tx_context::TxContext) : 0x2::coin::Coin<T0> {
        let v0 = PositionKey{owner: arg2};
        assert!(0x2::dynamic_field::exists_with_type<PositionKey, Position<T0>>(arg0, v0), 1302);
        let v1 = 0x2::dynamic_field::borrow_mut<PositionKey, Position<T0>>(arg0, v0);
        let v2 = take_vested<T0>(v1, end_at(arg0), arg3);
        let v3 = 0x2::balance::value<T0>(&v2);
        assert!(v3 > 0, 1301);
        let v4 = 0x2::balance::value<T0>(&v1.locked);
        if (v4 == 0) {
            let Position {
                locked : v5,
                rate   : _,
            } = 0x2::dynamic_field::remove<PositionKey, Position<T0>>(arg0, v0);
            0x2::balance::destroy_zero<T0>(v5);
        };
        let v7 = VestedClaimed{
            curve_id : arg1,
            owner    : arg2,
            amount   : v3,
            left     : v4,
        };
        0x2::event::emit<VestedClaimed>(v7);
        0x2::coin::from_balance<T0>(v2, arg4)
    }

    public(friend) fun claimable_at<T0>(arg0: &0x2::object::UID, arg1: address, arg2: u64) : u64 {
        let v0 = PositionKey{owner: arg1};
        if (!0x2::dynamic_field::exists_with_type<PositionKey, Position<T0>>(arg0, v0)) {
            return 0
        };
        claimable_of<T0>(0x2::dynamic_field::borrow<PositionKey, Position<T0>>(arg0, v0), end_at(arg0), arg2)
    }

    public(friend) fun claimable_of<T0>(arg0: &Position<T0>, arg1: u64, arg2: u64) : u64 {
        let v0 = 0x2::balance::value<T0>(&arg0.locked);
        v0 - unvested(v0, arg0.rate, arg1, arg2)
    }

    public(friend) fun configure_at(arg0: &mut 0x2::object::UID, arg1: 0x2::object::ID, arg2: u64, arg3: u64, arg4: u64) {
        let v0 = duration_ms_for_days(arg2);
        let v1 = arg3 + v0;
        assert!(arg4 == 0 || arg4 >= v1, 1303);
        let v2 = VestKey{dummy_field: false};
        let v3 = Vesting{
            duration_ms : v0,
            end_ms      : v1,
        };
        0x2::dynamic_field::add<VestKey, Vesting>(arg0, v2, v3);
        let v4 = VestingConfigured{
            curve_id    : arg1,
            duration_ms : v0,
            end_ms      : v1,
        };
        0x2::event::emit<VestingConfigured>(v4);
    }

    public(friend) fun duration_at(arg0: &0x2::object::UID) : u64 {
        if (!is_vested_at(arg0)) {
            return 0
        };
        let v0 = VestKey{dummy_field: false};
        0x2::dynamic_field::borrow<VestKey, Vesting>(arg0, v0).duration_ms
    }

    public fun duration_ms_for_days(arg0: u64) : u64 {
        let v0 = if (arg0 == 7) {
            true
        } else if (arg0 == 30) {
            true
        } else {
            arg0 == 90
        };
        assert!(v0, 1300);
        arg0 * 86400000
    }

    public(friend) fun end_at(arg0: &0x2::object::UID) : u64 {
        if (!is_vested_at(arg0)) {
            return 0
        };
        let v0 = VestKey{dummy_field: false};
        0x2::dynamic_field::borrow<VestKey, Vesting>(arg0, v0).end_ms
    }

    public(friend) fun is_locking_at(arg0: &0x2::object::UID, arg1: u64) : bool {
        is_vested_at(arg0) && arg1 < end_at(arg0)
    }

    public(friend) fun is_vested_at(arg0: &0x2::object::UID) : bool {
        let v0 = VestKey{dummy_field: false};
        0x2::dynamic_field::exists_with_type<VestKey, Vesting>(arg0, v0)
    }

    public(friend) fun lock_at<T0>(arg0: &mut 0x2::object::UID, arg1: 0x2::object::ID, arg2: address, arg3: 0x2::balance::Balance<T0>, arg4: u64) {
        let v0 = end_at(arg0);
        let v1 = PositionKey{owner: arg2};
        if (!0x2::dynamic_field::exists_with_type<PositionKey, Position<T0>>(arg0, v1)) {
            let v2 = Position<T0>{
                locked : 0x2::balance::zero<T0>(),
                rate   : 0,
            };
            0x2::dynamic_field::add<PositionKey, Position<T0>>(arg0, v1, v2);
        };
        let v3 = 0x2::dynamic_field::borrow_mut<PositionKey, Position<T0>>(arg0, v1);
        add<T0>(v3, arg3, v0, arg4);
        let v4 = VestedBuy{
            curve_id : arg1,
            owner    : arg2,
            amount   : 0x2::balance::value<T0>(&arg3),
            start_ms : arg4,
            end_ms   : v0,
        };
        0x2::event::emit<VestedBuy>(v4);
    }

    public(friend) fun locked_of_at<T0>(arg0: &0x2::object::UID, arg1: address) : u64 {
        let v0 = PositionKey{owner: arg1};
        if (!0x2::dynamic_field::exists_with_type<PositionKey, Position<T0>>(arg0, v0)) {
            return 0
        };
        0x2::balance::value<T0>(&0x2::dynamic_field::borrow<PositionKey, Position<T0>>(arg0, v0).locked)
    }

    public(friend) fun rate_of(arg0: u64, arg1: u64, arg2: u64) : u256 {
        if (arg2 >= arg1) {
            return 0
        };
        let v0 = ((arg1 - arg2) as u256);
        ((arg0 as u256) * 1000000000000000000 + v0 - 1) / v0
    }

    public(friend) fun take_vested<T0>(arg0: &mut Position<T0>, arg1: u64, arg2: u64) : 0x2::balance::Balance<T0> {
        0x2::balance::split<T0>(&mut arg0.locked, claimable_of<T0>(arg0, arg1, arg2))
    }

    public(friend) fun unvested(arg0: u64, arg1: u256, arg2: u64, arg3: u64) : u64 {
        if (arg3 >= arg2) {
            return 0
        };
        let v0 = (arg1 * ((arg2 - arg3) as u256) + 1000000000000000000 - 1) / 1000000000000000000;
        if (v0 >= (arg0 as u256)) {
            arg0
        } else {
            (v0 as u64)
        }
    }

    // decompiled from Move bytecode v7
}

