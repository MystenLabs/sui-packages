module 0x20610d4d1f037809b5ea9fd9fd6102fe9a649eb6d0f16903d8b14d5dfc9769c4::earners {
    struct EarnerSetEvent has copy, drop {
        earner: address,
        percentage: u64,
        previous_percentage: u64,
        total_percentage: u64,
        set_by: address,
        set_at: u64,
    }

    struct FeesDistributedEvent has copy, drop {
        total_fees: u64,
        distributed_fees: u64,
        remaining_fees: u64,
        num_earners: u64,
        distributed_at: u64,
    }

    struct Earners has key {
        id: 0x2::object::UID,
        earners: 0x2::vec_map::VecMap<address, u64>,
        total_percentage: u64,
        max_percentage: u64,
    }

    struct EARNERS has drop {
        dummy_field: bool,
    }

    public(friend) fun distribute_fees<T0>(arg0: &Earners, arg1: 0x2::coin::Coin<T0>, arg2: &0x2::clock::Clock, arg3: &mut 0x2::tx_context::TxContext) : 0x2::coin::Coin<T0> {
        let v0 = 0x2::coin::value<T0>(&arg1);
        let v1 = 0x2::coin::balance_mut<T0>(&mut arg1);
        let v2 = 0x2::vec_map::keys<address, u64>(&arg0.earners);
        let v3 = 0x1::vector::length<address>(&v2);
        let v4 = 0;
        let v5 = 0;
        while (v5 < v3) {
            let v6 = *0x1::vector::borrow<address>(&v2, v5);
            let v7 = *0x2::vec_map::get<address, u64>(&arg0.earners, &v6);
            if (v7 > 0) {
                let v8 = v0 * v7 / arg0.max_percentage;
                if (v8 > 0 && 0x2::balance::value<T0>(v1) >= v8) {
                    0x2::transfer::public_transfer<0x2::coin::Coin<T0>>(0x2::coin::from_balance<T0>(0x2::balance::split<T0>(v1, v8), arg3), v6);
                    v4 = v4 + v8;
                };
            };
            v5 = v5 + 1;
        };
        let v9 = FeesDistributedEvent{
            total_fees       : v0,
            distributed_fees : v4,
            remaining_fees   : v0 - v4,
            num_earners      : v3,
            distributed_at   : 0x2::clock::timestamp_ms(arg2),
        };
        0x2::event::emit<FeesDistributedEvent>(v9);
        arg1
    }

    public fun get_earners(arg0: &Earners) : 0x2::vec_map::VecMap<address, u64> {
        arg0.earners
    }

    public fun get_max_percentage(arg0: &Earners) : u64 {
        arg0.max_percentage
    }

    public fun get_total_percentage(arg0: &Earners) : u64 {
        arg0.total_percentage
    }

    fun init(arg0: EARNERS, arg1: &mut 0x2::tx_context::TxContext) {
        assert!(0x2::types::is_one_time_witness<EARNERS>(&arg0), 3);
        let v0 = 0x2::vec_map::empty<address, u64>();
        0x2::vec_map::insert<address, u64>(&mut v0, 0x2::tx_context::sender(arg1), 10000);
        let v1 = Earners{
            id               : 0x2::object::new(arg1),
            earners          : v0,
            total_percentage : 10000,
            max_percentage   : 10000,
        };
        0x2::transfer::share_object<Earners>(v1);
    }

    public(friend) entry fun set_earner(arg0: &0x20610d4d1f037809b5ea9fd9fd6102fe9a649eb6d0f16903d8b14d5dfc9769c4::admins::Owner, arg1: &mut Earners, arg2: address, arg3: u64, arg4: &0x2::clock::Clock, arg5: &0x2::tx_context::TxContext) {
        0x20610d4d1f037809b5ea9fd9fd6102fe9a649eb6d0f16903d8b14d5dfc9769c4::admins::assert_is_owner(arg0, 0x2::tx_context::sender(arg5));
        assert!(arg3 <= 10000, 1);
        let v0 = 0x2::vec_map::contains<address, u64>(&arg1.earners, &arg2);
        let v1 = if (v0) {
            *0x2::vec_map::get<address, u64>(&arg1.earners, &arg2)
        } else {
            0
        };
        let v2 = arg1.total_percentage + arg3 - v1;
        assert!(v2 <= 10000, 2);
        if (v0) {
            let (_, _) = 0x2::vec_map::remove<address, u64>(&mut arg1.earners, &arg2);
        };
        if (arg3 > 0) {
            0x2::vec_map::insert<address, u64>(&mut arg1.earners, arg2, arg3);
        };
        arg1.total_percentage = v2;
        let v5 = EarnerSetEvent{
            earner              : arg2,
            percentage          : arg3,
            previous_percentage : v1,
            total_percentage    : v2,
            set_by              : 0x2::tx_context::sender(arg5),
            set_at              : 0x2::clock::timestamp_ms(arg4),
        };
        0x2::event::emit<EarnerSetEvent>(v5);
    }

    // decompiled from Move bytecode v6
}

