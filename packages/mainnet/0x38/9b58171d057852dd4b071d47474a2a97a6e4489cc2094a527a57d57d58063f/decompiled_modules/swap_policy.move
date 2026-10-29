module 0x389b58171d057852dd4b071d47474a2a97a6e4489cc2094a527a57d57d58063f::swap_policy {
    struct SwapPolicy<phantom T0, phantom T1> has drop, store {
        venues: vector<0x2::object::ID>,
        per_trade: u64,
        daily: u64,
        min_price: u64,
        meter: 0x389b58171d057852dd4b071d47474a2a97a6e4489cc2094a527a57d57d58063f::meter::Meter,
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
            per_trade : arg1,
            daily     : arg2,
            min_price : arg3,
            meter     : 0x389b58171d057852dd4b071d47474a2a97a6e4489cc2094a527a57d57d58063f::meter::new(arg4),
        }
    }

    public fun used_today<T0, T1>(arg0: &SwapPolicy<T0, T1>, arg1: &0x2::clock::Clock) : u64 {
        0x389b58171d057852dd4b071d47474a2a97a6e4489cc2094a527a57d57d58063f::meter::used_today(&arg0.meter, arg1)
    }

    public(friend) fun begin<T0, T1>(arg0: &mut SwapPolicy<T0, T1>, arg1: u64, arg2: &0x2::clock::Clock) : Pending<T0, T1> {
        assert!(arg1 > 0, 2);
        assert!(arg1 <= arg0.per_trade, 1);
        0x389b58171d057852dd4b071d47474a2a97a6e4489cc2094a527a57d57d58063f::meter::charge(&mut arg0.meter, arg1, arg0.daily, arg2);
        Pending<T0, T1>{
            amount_in : arg1,
            venues    : 0x1::vector::empty<0x2::object::ID>(),
        }
    }

    public fun daily<T0, T1>(arg0: &SwapPolicy<T0, T1>) : u64 {
        arg0.daily
    }

    public(friend) fun finish<T0, T1>(arg0: &mut SwapPolicy<T0, T1>, arg1: Pending<T0, T1>, arg2: 0x2::object::ID, arg3: u64, arg4: u64, arg5: u64) {
        let Pending {
            amount_in : v0,
            venues    : v1,
        } = arg1;
        if (arg3 < v0) {
            0x389b58171d057852dd4b071d47474a2a97a6e4489cc2094a527a57d57d58063f::meter::refund(&mut arg0.meter, v0 - arg3);
        };
        assert!(arg3 > 0, 8);
        assert!(arg4 >= arg5, 3);
        assert!((arg4 as u128) * 1000000000 >= (arg3 as u128) * (arg0.min_price as u128), 4);
        let v2 = Swapped{
            controller : arg2,
            venues     : v1,
            coin_in    : 0x1::type_name::with_defining_ids<T0>(),
            coin_out   : 0x1::type_name::with_defining_ids<T1>(),
            amount_in  : arg3,
            amount_out : arg4,
        };
        0x2::event::emit<Swapped>(v2);
    }

    public(friend) fun hop<T0, T1>(arg0: &SwapPolicy<T0, T1>, arg1: &mut Pending<T0, T1>, arg2: 0x2::object::ID) {
        assert!(0x1::vector::contains<0x2::object::ID>(&arg0.venues, &arg2), 0);
        0x1::vector::push_back<0x2::object::ID>(&mut arg1.venues, arg2);
    }

    public fun min_price<T0, T1>(arg0: &SwapPolicy<T0, T1>) : u64 {
        arg0.min_price
    }

    public fun per_trade<T0, T1>(arg0: &SwapPolicy<T0, T1>) : u64 {
        arg0.per_trade
    }

    public fun venues<T0, T1>(arg0: &SwapPolicy<T0, T1>) : &vector<0x2::object::ID> {
        &arg0.venues
    }

    // decompiled from Move bytecode v7
}

