module 0xd00f9cae82c412dc8d928fe733b0033510194f33b956cc2e5ea7063f2776f222::auto_position {
    struct AutoPosition<T0: store + key> has store {
        owner: address,
        inner: 0x1::option::Option<T0>,
        vault: 0x2::vec_map::VecMap<0x1::type_name::TypeName, u64>,
        slippage_pips: u64,
    }

    struct Borrow {
        id: 0x2::object::ID,
    }

    public fun id<T0: store + key>(arg0: &AutoPosition<T0>) : 0x2::object::ID {
        0x2::object::id<T0>(0x1::option::borrow<T0>(&arg0.inner))
    }

    public fun assert_owner<T0: store + key>(arg0: &AutoPosition<T0>, arg1: address) {
        assert!(arg0.owner == arg1, 1);
    }

    public(friend) fun borrow_val_inner<T0: store + key>(arg0: &mut AutoPosition<T0>) : (T0, Borrow) {
        let v0 = 0x1::option::extract<T0>(&mut arg0.inner);
        let v1 = Borrow{id: 0x2::object::id<T0>(&v0)};
        (v0, v1)
    }

    public fun inner<T0: store + key>(arg0: &AutoPosition<T0>) : &T0 {
        0x1::option::borrow<T0>(&arg0.inner)
    }

    public fun inner_mut<T0: store + key>(arg0: &mut AutoPosition<T0>) : &mut T0 {
        0x1::option::borrow_mut<T0>(&mut arg0.inner)
    }

    public fun new<T0: store + key>(arg0: T0, arg1: 0x2::vec_map::VecMap<0x1::type_name::TypeName, u64>, arg2: address, arg3: u64, arg4: &0xd00f9cae82c412dc8d928fe733b0033510194f33b956cc2e5ea7063f2776f222::registry::ProxyCap) : AutoPosition<T0> {
        assert!(arg3 < 0xd00f9cae82c412dc8d928fe733b0033510194f33b956cc2e5ea7063f2776f222::constants::scaling_pips(), 2);
        AutoPosition<T0>{
            owner         : arg2,
            inner         : 0x1::option::some<T0>(arg0),
            vault         : arg1,
            slippage_pips : arg3,
        }
    }

    public fun owner<T0: store + key>(arg0: &AutoPosition<T0>) : address {
        arg0.owner
    }

    public(friend) fun return_val_inner<T0: store + key>(arg0: &mut AutoPosition<T0>, arg1: T0, arg2: Borrow) {
        let Borrow { id: v0 } = arg2;
        assert!(0x2::object::id<T0>(&arg1) == v0, 3);
        0x1::option::fill<T0>(&mut arg0.inner, arg1);
    }

    public(friend) fun set_slippage_pips<T0: store + key>(arg0: &mut AutoPosition<T0>, arg1: u64) {
        assert!(arg1 < 0xd00f9cae82c412dc8d928fe733b0033510194f33b956cc2e5ea7063f2776f222::constants::scaling_pips(), 2);
        arg0.slippage_pips = arg1;
    }

    public fun slippage_pips<T0: store + key>(arg0: &AutoPosition<T0>) : u64 {
        arg0.slippage_pips
    }

    public fun unwrap<T0: store + key>(arg0: AutoPosition<T0>, arg1: &0xd00f9cae82c412dc8d928fe733b0033510194f33b956cc2e5ea7063f2776f222::registry::ProxyCap) : (address, T0, 0x2::vec_map::VecMap<0x1::type_name::TypeName, u64>, u64) {
        let AutoPosition {
            owner         : v0,
            inner         : v1,
            vault         : v2,
            slippage_pips : v3,
        } = arg0;
        (v0, 0x1::option::destroy_some<T0>(v1), v2, v3)
    }

    public fun vault<T0: store + key>(arg0: &AutoPosition<T0>) : &0x2::vec_map::VecMap<0x1::type_name::TypeName, u64> {
        &arg0.vault
    }

    public(friend) fun vault_mut<T0: store + key>(arg0: &mut AutoPosition<T0>) : &mut 0x2::vec_map::VecMap<0x1::type_name::TypeName, u64> {
        &mut arg0.vault
    }

    // decompiled from Move bytecode v6
}

