module 0x4b0f4ee1a40ce37ec81c987cc4e76a665419e74b863319492fc7d26f708b835a::witness_lock {
    struct HotPotato<T0> {
        obj: T0,
        witness: 0x1::string::String,
    }

    fun invalid_witness() : u64 {
        abort 0
    }

    public fun unwrap<T0, T1: drop>(arg0: &0x4b0f4ee1a40ce37ec81c987cc4e76a665419e74b863319492fc7d26f708b835a::ecosystem::Version, arg1: HotPotato<T0>, arg2: T1) : T0 {
        0x4b0f4ee1a40ce37ec81c987cc4e76a665419e74b863319492fc7d26f708b835a::ecosystem::version_check(arg0);
        let HotPotato {
            obj     : v0,
            witness : v1,
        } = arg1;
        assert!(0x1::string::from_ascii(0x1::type_name::into_string(0x1::type_name::get<T1>())) == v1, invalid_witness());
        v0
    }

    public fun wrap<T0>(arg0: &0x4b0f4ee1a40ce37ec81c987cc4e76a665419e74b863319492fc7d26f708b835a::ecosystem::Version, arg1: T0, arg2: 0x1::string::String) : HotPotato<T0> {
        0x4b0f4ee1a40ce37ec81c987cc4e76a665419e74b863319492fc7d26f708b835a::ecosystem::version_check(arg0);
        HotPotato<T0>{
            obj     : arg1,
            witness : arg2,
        }
    }

    // decompiled from Move bytecode v6
}

