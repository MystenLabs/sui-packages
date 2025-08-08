module 0xff4d76a5fd49bd6a9d6f8f8df5fb71bbf7b1ac38c2ffa781054a74a4624b2183::loop_strategy_vault {
    struct Vault<phantom T0> has store, key {
        id: 0x2::object::UID,
        cache_pool: 0x2::balance::Balance<T0>,
    }

    public(friend) fun new<T0>(arg0: &mut 0x2::tx_context::TxContext) : Vault<T0> {
        Vault<T0>{
            id         : 0x2::object::new(arg0),
            cache_pool : 0x2::balance::zero<T0>(),
        }
    }

    public(friend) fun deposit<T0>(arg0: &mut Vault<T0>, arg1: 0x2::balance::Balance<T0>) {
        0x2::balance::join<T0>(&mut arg0.cache_pool, arg1);
    }

    public fun vault_amount<T0>(arg0: &Vault<T0>) : u64 {
        0x2::balance::value<T0>(&arg0.cache_pool)
    }

    public(friend) fun withdraw<T0>(arg0: &mut Vault<T0>, arg1: u64) : 0x2::balance::Balance<T0> {
        0x2::balance::split<T0>(&mut arg0.cache_pool, arg1)
    }

    public(friend) fun withdraw_all<T0>(arg0: &mut Vault<T0>) : 0x2::balance::Balance<T0> {
        0x2::balance::split<T0>(&mut arg0.cache_pool, 0x2::balance::value<T0>(&arg0.cache_pool))
    }

    public(friend) fun withdraw_max<T0>(arg0: &mut Vault<T0>, arg1: u64) : (0x2::balance::Balance<T0>, u64) {
        let v0 = 0x2::balance::value<T0>(&arg0.cache_pool);
        if (v0 >= arg1) {
            (0x2::balance::split<T0>(&mut arg0.cache_pool, arg1), 0)
        } else {
            (0x2::balance::split<T0>(&mut arg0.cache_pool, v0), arg1 - v0)
        }
    }

    // decompiled from Move bytecode v6
}

