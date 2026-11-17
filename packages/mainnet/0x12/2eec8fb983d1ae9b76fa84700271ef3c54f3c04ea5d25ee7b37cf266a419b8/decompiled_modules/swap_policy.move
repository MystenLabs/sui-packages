module 0x3207a2c211b234f48757d2fe6e58898a0d1c9d1978708e71901faeac2faf4cb6::swap_policy {
    struct SwapPolicy<phantom T0, phantom T1> has drop, store {
        venues: vector<0x2::object::ID>,
        adapters: 0x2::vec_map::VecMap<0x1::type_name::TypeName, u64>,
        per_trade: u64,
        daily: u64,
        min_price: u64,
        meter: 0x3207a2c211b234f48757d2fe6e58898a0d1c9d1978708e71901faeac2faf4cb6::meter::Meter,
    }

    struct Pending<phantom T0, phantom T1> {
        amount_in: u64,
        venues: vector<0x2::object::ID>,
    }

    struct Swapped has copy, drop {
        controller: 0x2::object::ID,
        venues: vector<0x2::object::ID>,
        coin_in: 0x1::type_name::TypeName,
        coin_out: 0x1::type_name::TypeName,
        amount_in: u64,
        amount_out: u64,
    }

    public fun new<T0, T1>(arg0: vector<0x2::object::ID>, arg1: u64, arg2: u64, arg3: u64, arg4: &0x2::clock::Clock) : SwapPolicy<T0, T1> {
        assert!(0x1::type_name::with_defining_ids<T0>() != 0x1::type_name::with_defining_ids<T1>(), 6);
        assert!(arg1 > 0 && arg2 >= arg1, 5);
        assert!(arg3 > 0, 7);
        SwapPolicy<T0, T1>{
            venues    : arg0,
            adapters  : 0x2::vec_map::empty<0x1::type_name::TypeName, u64>(),
            per_trade : arg1,
            daily     : arg2,
            min_price : arg3,
            meter     : 0x3207a2c211b234f48757d2fe6e58898a0d1c9d1978708e71901faeac2faf4cb6::meter::new(arg4),
        }
    }

    public fun used_today<T0, T1>(arg0: &SwapPolicy<T0, T1>, arg1: &0x2::clock::Clock) : u64 {
        0x3207a2c211b234f48757d2fe6e58898a0d1c9d1978708e71901faeac2faf4cb6::meter::used_today(&arg0.meter, arg1)
    }

    public fun adapters<T0, T1>(arg0: &SwapPolicy<T0, T1>) : &0x2::vec_map::VecMap<0x1::type_name::TypeName, u64> {
        &arg0.adapters
    }

    public(friend) fun admit<T0, T1>(arg0: &SwapPolicy<T0, T1>, arg1: 0x1::type_name::TypeName, arg2: u64, arg3: 0x2::object::ID) {
        assert!(0x2::vec_map::contains<0x1::type_name::TypeName, u64>(&arg0.adapters, &arg1), 9);
        assert!(arg2 >= *0x2::vec_map::get<0x1::type_name::TypeName, u64>(&arg0.adapters, &arg1), 10);
        assert!(0x1::vector::is_empty<0x2::object::ID>(&arg0.venues) || 0x1::vector::contains<0x2::object::ID>(&arg0.venues, &arg3), 0);
    }

    public fun approve_adapter<T0, T1, T2: drop>(arg0: &mut SwapPolicy<T0, T1>, arg1: u64) {
        0x2::vec_map::insert<0x1::type_name::TypeName, u64>(&mut arg0.adapters, 0x1::type_name::with_defining_ids<T2>(), arg1);
    }

    public(friend) fun begin<T0, T1>(arg0: &mut SwapPolicy<T0, T1>, arg1: u64, arg2: &0x2::clock::Clock) : Pending<T0, T1> {
        assert!(arg1 > 0, 2);
        assert!(arg1 <= arg0.per_trade, 1);
        0x3207a2c211b234f48757d2fe6e58898a0d1c9d1978708e71901faeac2faf4cb6::meter::charge(&mut arg0.meter, arg1, arg0.daily, arg2);
        Pending<T0, T1>{
            amount_in : arg1,
            venues    : 0x1::vector::empty<0x2::object::ID>(),
        }
    }

    public fun daily<T0, T1>(arg0: &SwapPolicy<T0, T1>) : u64 {
        arg0.daily
    }

    public(friend) fun finish<T0, T1>(arg0: &mut SwapPolicy<T0, T1>, arg1: Pending<T0, T1>, arg2: 0x2::object::ID, arg3: u64, arg4: u64, arg5: u64) : u64 {
        let Pending {
            amount_in : v0,
            venues    : v1,
        } = arg1;
        let v2 = v0 - arg3;
        0x3207a2c211b234f48757d2fe6e58898a0d1c9d1978708e71901faeac2faf4cb6::meter::refund(&mut arg0.meter, v2);
        assert!(arg3 > 0, 8);
        assert!(arg4 >= arg5, 3);
        assert!((arg4 as u128) * 1000000000 >= (arg3 as u128) * (arg0.min_price as u128), 4);
        let v3 = Swapped{
            controller : arg2,
            venues     : v1,
            coin_in    : 0x1::type_name::with_defining_ids<T0>(),
            coin_out   : 0x1::type_name::with_defining_ids<T1>(),
            amount_in  : arg3,
            amount_out : arg4,
        };
        0x2::event::emit<Swapped>(v3);
        v2
    }

    public fun min_price<T0, T1>(arg0: &SwapPolicy<T0, T1>) : u64 {
        arg0.min_price
    }

    public fun per_trade<T0, T1>(arg0: &SwapPolicy<T0, T1>) : u64 {
        arg0.per_trade
    }

    public(friend) fun record<T0, T1>(arg0: &mut Pending<T0, T1>, arg1: 0x2::object::ID) {
        0x1::vector::push_back<0x2::object::ID>(&mut arg0.venues, arg1);
    }

    public fun venues<T0, T1>(arg0: &SwapPolicy<T0, T1>) : &vector<0x2::object::ID> {
        &arg0.venues
    }

    // decompiled from Move bytecode v7
}

