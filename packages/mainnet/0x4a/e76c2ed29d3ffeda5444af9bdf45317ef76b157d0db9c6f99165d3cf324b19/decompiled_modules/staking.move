module 0x4ae76c2ed29d3ffeda5444af9bdf45317ef76b157d0db9c6f99165d3cf324b19::staking {
    struct Pool has key {
        id: 0x2::object::UID,
        staked: 0x2::object_bag::ObjectBag,
    }

    struct Receipt has key {
        id: 0x2::object::UID,
        toy_id: 0x2::object::ID,
        type_name: 0x1::type_name::TypeName,
        collected_at_ms: u64,
    }

    fun calculate_reward<T0: store + key>(arg0: &0x4ae76c2ed29d3ffeda5444af9bdf45317ef76b157d0db9c6f99165d3cf324b19::registry::Registry, arg1: &0x2::clock::Clock, arg2: 0x1::type_name::TypeName, arg3: u64) : u64 {
        assert!(arg2 == 0x1::type_name::with_defining_ids<T0>(), 1);
        let v0 = 0x2::clock::timestamp_ms(arg1);
        assert!(v0 > arg3, 0);
        0x4ae76c2ed29d3ffeda5444af9bdf45317ef76b157d0db9c6f99165d3cf324b19::points::stake_reward(0x4ae76c2ed29d3ffeda5444af9bdf45317ef76b157d0db9c6f99165d3cf324b19::toy::tier(0x4ae76c2ed29d3ffeda5444af9bdf45317ef76b157d0db9c6f99165d3cf324b19::registry::borrow_toy<T0>(arg0)), v0 - arg3)
    }

    public fun collect_reward<T0: store + key>(arg0: &mut Receipt, arg1: &0x4ae76c2ed29d3ffeda5444af9bdf45317ef76b157d0db9c6f99165d3cf324b19::registry::Registry, arg2: &mut 0x4ae76c2ed29d3ffeda5444af9bdf45317ef76b157d0db9c6f99165d3cf324b19::points::FutrPoint, arg3: &0x2::clock::Clock) {
        0x4ae76c2ed29d3ffeda5444af9bdf45317ef76b157d0db9c6f99165d3cf324b19::points::add_points(arg2, calculate_reward<T0>(arg1, arg3, arg0.type_name, arg0.collected_at_ms));
        arg0.collected_at_ms = 0x2::clock::timestamp_ms(arg3);
    }

    fun init(arg0: &mut 0x2::tx_context::TxContext) {
        let v0 = Pool{
            id     : 0x2::object::new(arg0),
            staked : 0x2::object_bag::new(arg0),
        };
        0x2::transfer::share_object<Pool>(v0);
    }

    public fun stake<T0: store + key>(arg0: &mut Pool, arg1: T0, arg2: &0x2::clock::Clock, arg3: &mut 0x2::tx_context::TxContext) {
        let v0 = 0x2::object::id<T0>(&arg1);
        0x2::object_bag::add<0x2::object::ID, T0>(&mut arg0.staked, v0, arg1);
        let v1 = Receipt{
            id              : 0x2::object::new(arg3),
            toy_id          : v0,
            type_name       : 0x1::type_name::with_defining_ids<T0>(),
            collected_at_ms : 0x2::clock::timestamp_ms(arg2),
        };
        0x2::transfer::transfer<Receipt>(v1, 0x2::tx_context::sender(arg3));
    }

    public fun unstake<T0: store + key>(arg0: &mut Pool, arg1: &0x4ae76c2ed29d3ffeda5444af9bdf45317ef76b157d0db9c6f99165d3cf324b19::registry::Registry, arg2: &mut 0x4ae76c2ed29d3ffeda5444af9bdf45317ef76b157d0db9c6f99165d3cf324b19::points::FutrPoint, arg3: Receipt, arg4: &0x2::clock::Clock, arg5: &mut 0x2::tx_context::TxContext) {
        let Receipt {
            id              : v0,
            toy_id          : v1,
            type_name       : v2,
            collected_at_ms : v3,
        } = arg3;
        0x2::object::delete(v0);
        0x4ae76c2ed29d3ffeda5444af9bdf45317ef76b157d0db9c6f99165d3cf324b19::points::add_points(arg2, calculate_reward<T0>(arg1, arg4, v2, v3));
        0x2::transfer::public_transfer<T0>(0x2::object_bag::remove<0x2::object::ID, T0>(&mut arg0.staked, v1), 0x2::tx_context::sender(arg5));
    }

    // decompiled from Move bytecode v7
}

