module 0xa3f96ab962aedd82296034914c9673c6711000b82ca6939dbac5079192e26c08::auto_position {
    struct AutoPosition<T0: store + key> has store {
        owner: address,
        inner: T0,
        vault: 0xa3f96ab962aedd82296034914c9673c6711000b82ca6939dbac5079192e26c08::vault::Vault,
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

    public fun new<T0: store + key>(arg0: T0, arg1: 0xa3f96ab962aedd82296034914c9673c6711000b82ca6939dbac5079192e26c08::vault::Vault, arg2: address, arg3: &0xa3f96ab962aedd82296034914c9673c6711000b82ca6939dbac5079192e26c08::registry::ProxyCap) : AutoPosition<T0> {
        AutoPosition<T0>{
            owner : arg2,
            inner : arg0,
            vault : arg1,
        }
    }

    public fun vault<T0: store + key>(arg0: &AutoPosition<T0>) : &0xa3f96ab962aedd82296034914c9673c6711000b82ca6939dbac5079192e26c08::vault::Vault {
        &arg0.vault
    }

    public fun owner<T0: store + key>(arg0: &AutoPosition<T0>) : address {
        arg0.owner
    }

    public(friend) fun unwrap<T0: store + key>(arg0: AutoPosition<T0>) : (address, T0, 0xa3f96ab962aedd82296034914c9673c6711000b82ca6939dbac5079192e26c08::vault::Vault) {
        let AutoPosition {
            owner : v0,
            inner : v1,
            vault : v2,
        } = arg0;
        (v0, v1, v2)
    }

    public fun vault_mut<T0: store + key>(arg0: &mut AutoPosition<T0>) : &mut 0xa3f96ab962aedd82296034914c9673c6711000b82ca6939dbac5079192e26c08::vault::Vault {
        &mut arg0.vault
    }

    // decompiled from Move bytecode v6
}

