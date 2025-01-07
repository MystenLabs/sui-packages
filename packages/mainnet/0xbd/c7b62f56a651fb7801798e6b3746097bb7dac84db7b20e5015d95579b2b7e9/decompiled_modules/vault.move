module 0xbdc7b62f56a651fb7801798e6b3746097bb7dac84db7b20e5015d95579b2b7e9::vault {
    struct Vault<phantom T0> {
        bc_id: 0x2::object::ID,
        target: u64,
        sui_balance: 0x2::balance::Balance<0x2::sui::SUI>,
        meme_balance: 0x2::balance::Balance<T0>,
        target_pool_id: 0x2::object::ID,
    }

    public fun bonding_curve_id<T0>(arg0: &Vault<T0>) : 0x2::object::ID {
        arg0.bc_id
    }

    public fun meme_balance<T0>(arg0: &Vault<T0>) : u64 {
        0x2::balance::value<T0>(&arg0.meme_balance)
    }

    public(friend) fun mint<T0>(arg0: 0x2::object::ID, arg1: 0x2::balance::Balance<0x2::sui::SUI>, arg2: 0x2::balance::Balance<T0>, arg3: u64) : Vault<T0> {
        assert!(0x2::balance::value<0x2::sui::SUI>(&arg1) > 0, 0);
        assert!(0x2::balance::value<T0>(&arg2) > 0, 1);
        Vault<T0>{
            bc_id          : arg0,
            target         : arg3,
            sui_balance    : arg1,
            meme_balance   : arg2,
            target_pool_id : 0x2::object::id_from_address(@0x0),
        }
    }

    public fun sui_balance<T0>(arg0: &Vault<T0>) : u64 {
        0x2::balance::value<0x2::sui::SUI>(&arg0.sui_balance)
    }

    public(friend) fun take<T0>(arg0: Vault<T0>) : (0x2::balance::Balance<0x2::sui::SUI>, 0x2::balance::Balance<T0>) {
        let Vault {
            bc_id          : _,
            target         : _,
            sui_balance    : v2,
            meme_balance   : v3,
            target_pool_id : _,
        } = arg0;
        (v2, v3)
    }

    // decompiled from Move bytecode v6
}

