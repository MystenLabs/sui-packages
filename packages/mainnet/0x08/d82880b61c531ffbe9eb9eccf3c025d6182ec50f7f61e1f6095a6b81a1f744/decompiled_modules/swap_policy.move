module 0x4c9010b0be6022e8a4bd91219d5174edc36d524b42d4790784035f424e01f403::swap_policy {
    struct SwapPolicy<phantom T0, phantom T1> has drop, store {
        venues: vector<0x2::object::ID>,
        per_trade: u64,
        daily: u64,
        min_price: u64,
        meter: 0x4c9010b0be6022e8a4bd91219d5174edc36d524b42d4790784035f424e01f403::meter::Meter,
    }

    struct Pending<phantom T0, phantom T1> {
        venue: 0x2::object::ID,
        amount_in: u64,
    }

    struct Swapped has copy, drop {
        controller: 0x2::object::ID,
        venue: 0x2::object::ID,
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
            per_trade : arg1,
            daily     : arg2,
            min_price : arg3,
            meter     : 0x4c9010b0be6022e8a4bd91219d5174edc36d524b42d4790784035f424e01f403::meter::new(arg4),
        }
    }

    public fun used_today<T0, T1>(arg0: &SwapPolicy<T0, T1>, arg1: &0x2::clock::Clock) : u64 {
        0x4c9010b0be6022e8a4bd91219d5174edc36d524b42d4790784035f424e01f403::meter::used_today(&arg0.meter, arg1)
    }

    public fun add_venue<T0, T1>(arg0: &mut SwapPolicy<T0, T1>, arg1: 0x2::object::ID) {
        if (!0x1::vector::contains<0x2::object::ID>(&arg0.venues, &arg1)) {
            0x1::vector::push_back<0x2::object::ID>(&mut arg0.venues, arg1);
        };
    }

    public(friend) fun begin<T0, T1>(arg0: &mut SwapPolicy<T0, T1>, arg1: 0x2::object::ID, arg2: u64, arg3: &0x2::clock::Clock) : Pending<T0, T1> {
        assert!(0x1::vector::contains<0x2::object::ID>(&arg0.venues, &arg1), 0);
        assert!(arg2 > 0, 2);
        assert!(arg2 <= arg0.per_trade, 1);
        0x4c9010b0be6022e8a4bd91219d5174edc36d524b42d4790784035f424e01f403::meter::charge(&mut arg0.meter, arg2, arg0.daily, arg3);
        Pending<T0, T1>{
            venue     : arg1,
            amount_in : arg2,
        }
    }

    public fun daily<T0, T1>(arg0: &SwapPolicy<T0, T1>) : u64 {
        arg0.daily
    }

    public(friend) fun finish<T0, T1>(arg0: &mut SwapPolicy<T0, T1>, arg1: Pending<T0, T1>, arg2: 0x2::object::ID, arg3: u64, arg4: u64, arg5: u64) {
        let Pending {
            venue     : v0,
            amount_in : v1,
        } = arg1;
        if (arg3 < v1) {
            0x4c9010b0be6022e8a4bd91219d5174edc36d524b42d4790784035f424e01f403::meter::refund(&mut arg0.meter, v1 - arg3);
        };
        assert!(arg3 > 0, 8);
        assert!(arg4 >= arg5, 3);
        assert!((arg4 as u128) * 1000000000 >= (arg3 as u128) * (arg0.min_price as u128), 4);
        let v2 = Swapped{
            controller : arg2,
            venue      : v0,
            coin_in    : 0x1::type_name::with_defining_ids<T0>(),
            coin_out   : 0x1::type_name::with_defining_ids<T1>(),
            amount_in  : arg3,
            amount_out : arg4,
        };
        0x2::event::emit<Swapped>(v2);
    }

    public fun min_price<T0, T1>(arg0: &SwapPolicy<T0, T1>) : u64 {
        arg0.min_price
    }

    public fun per_trade<T0, T1>(arg0: &SwapPolicy<T0, T1>) : u64 {
        arg0.per_trade
    }

    public fun remove_venue<T0, T1>(arg0: &mut SwapPolicy<T0, T1>, arg1: 0x2::object::ID) {
        let (v0, v1) = 0x1::vector::index_of<0x2::object::ID>(&arg0.venues, &arg1);
        assert!(v0, 0);
        0x1::vector::remove<0x2::object::ID>(&mut arg0.venues, v1);
    }

    public fun set_limits<T0, T1>(arg0: &mut SwapPolicy<T0, T1>, arg1: u64, arg2: u64, arg3: u64) {
        assert!(arg1 > 0 && arg2 >= arg1, 5);
        assert!(arg3 > 0, 7);
        arg0.per_trade = arg1;
        arg0.daily = arg2;
        arg0.min_price = arg3;
    }

    public fun venues<T0, T1>(arg0: &SwapPolicy<T0, T1>) : &vector<0x2::object::ID> {
        &arg0.venues
    }

    // decompiled from Move bytecode v7
}

