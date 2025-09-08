module 0x514aafdf5b3e6968c1bcdec00e64e3362181f43e47217132f665b95e0ae8e3ca::auto_position {
    struct AutoPosition<T0: store + key> has store {
        owner: address,
        inner: T0,
        vault: 0x2::vec_map::VecMap<0x1::type_name::TypeName, u64>,
    }

    public fun id<T0: store + key>(arg0: &AutoPosition<T0>) : 0x2::object::ID {
        0x2::object::id<T0>(&arg0.inner)
    }

    public fun assert_owner<T0: store + key>(arg0: &AutoPosition<T0>, arg1: address) {
        assert!(arg0.owner == arg1, 1);
    }

    public fun inner<T0: store + key>(arg0: &AutoPosition<T0>) : &T0 {
        &arg0.inner
    }

    public fun inner_mut<T0: store + key>(arg0: &mut AutoPosition<T0>) : &mut T0 {
        &mut arg0.inner
    }

    public fun new<T0: store + key>(arg0: T0, arg1: 0x2::vec_map::VecMap<0x1::type_name::TypeName, u64>, arg2: address, arg3: &0x514aafdf5b3e6968c1bcdec00e64e3362181f43e47217132f665b95e0ae8e3ca::registry::ProxyCap) : AutoPosition<T0> {
        AutoPosition<T0>{
            owner : arg2,
            inner : arg0,
            vault : arg1,
        }
    }

    public fun owner<T0: store + key>(arg0: &AutoPosition<T0>) : address {
        arg0.owner
    }

    public fun unwrap<T0: store + key>(arg0: AutoPosition<T0>, arg1: &0x514aafdf5b3e6968c1bcdec00e64e3362181f43e47217132f665b95e0ae8e3ca::registry::ProxyCap) : (address, T0, 0x2::vec_map::VecMap<0x1::type_name::TypeName, u64>) {
        let AutoPosition {
            owner : v0,
            inner : v1,
            vault : v2,
        } = arg0;
        (v0, v1, v2)
    }

    public fun vault<T0: store + key>(arg0: &AutoPosition<T0>) : &0x2::vec_map::VecMap<0x1::type_name::TypeName, u64> {
        &arg0.vault
    }

    public(friend) fun vault_mut<T0: store + key>(arg0: &mut AutoPosition<T0>) : &mut 0x2::vec_map::VecMap<0x1::type_name::TypeName, u64> {
        &mut arg0.vault
    }

    // decompiled from Move bytecode v6
}

