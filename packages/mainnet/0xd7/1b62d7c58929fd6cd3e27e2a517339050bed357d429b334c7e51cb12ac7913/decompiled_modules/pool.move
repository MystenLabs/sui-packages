module 0xd71b62d7c58929fd6cd3e27e2a517339050bed357d429b334c7e51cb12ac7913::pool {
    struct Vault<phantom T0> has store {
        enabled: bool,
        last_update: u64,
        liquidity: 0x2::balance::Balance<T0>,
    }

    public(friend) fun new_vault<T0>() : Vault<T0> {
        Vault<T0>{
            enabled     : true,
            last_update : 0,
            liquidity   : 0x2::balance::zero<T0>(),
        }
    }

    public(friend) fun unwrap<T0>(arg0: &mut Vault<T0>, arg1: u64, arg2: u64, arg3: u64) : 0x2::balance::Balance<T0> {
        assert!(arg0.enabled, 1);
        assert!(arg1 > 0, 5);
        assert!(arg1 <= arg3, 2);
        assert!(arg1 <= 0x2::balance::value<T0>(&arg0.liquidity), 3);
        let v0 = 0x2::balance::split<T0>(&mut arg0.liquidity, arg1);
        assert!(0x2::balance::value<T0>(&v0) >= arg2, 6);
        v0
    }

    public(friend) fun wrap<T0>(arg0: &mut Vault<T0>, arg1: 0x2::balance::Balance<T0>, arg2: u64, arg3: u64) : u64 {
        assert!(arg0.enabled, 1);
        let v0 = 0x2::balance::value<T0>(&arg1);
        assert!(v0 > 0, 4);
        0x2::balance::join<T0>(&mut arg0.liquidity, arg1);
        assert!(v0 >= arg2, 6);
        v0
    }

    // decompiled from Move bytecode v6
}

