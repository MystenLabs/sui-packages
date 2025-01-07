module 0xec46732fdaf2fdf21544dad677163ddc5eb2827213b55b4abb399eec2cb6f61::vault {
    struct Vault<phantom T0> {
        bc_id: 0x2::object::ID,
        sui_balance: 0x2::balance::Balance<0x2::sui::SUI>,
        meme_balance: 0x2::balance::Balance<T0>,
        fee_balance: 0x2::balance::Balance<0x2::sui::SUI>,
    }

    public fun bonding_curve_id<T0>(arg0: &Vault<T0>) : 0x2::object::ID {
        arg0.bc_id
    }

    public fun meme_balance<T0>(arg0: &Vault<T0>) : u64 {
        0x2::balance::value<T0>(&arg0.meme_balance)
    }

    public(friend) fun mint<T0>(arg0: 0x2::object::ID, arg1: 0x2::balance::Balance<0x2::sui::SUI>, arg2: 0x2::balance::Balance<T0>, arg3: 0x2::balance::Balance<0x2::sui::SUI>) : Vault<T0> {
        assert!(0x2::balance::value<0x2::sui::SUI>(&arg1) > 0, 0);
        assert!(0x2::balance::value<T0>(&arg2) > 0, 1);
        Vault<T0>{
            bc_id        : arg0,
            sui_balance  : arg1,
            meme_balance : arg2,
            fee_balance  : arg3,
        }
    }

    public fun sui_balance<T0>(arg0: &Vault<T0>) : u64 {
        0x2::balance::value<0x2::sui::SUI>(&arg0.sui_balance)
    }

    public(friend) fun take_balances<T0>(arg0: Vault<T0>) : (0x2::balance::Balance<0x2::sui::SUI>, 0x2::balance::Balance<T0>, 0x2::balance::Balance<0x2::sui::SUI>) {
        let Vault {
            bc_id        : _,
            sui_balance  : v1,
            meme_balance : v2,
            fee_balance  : v3,
        } = arg0;
        (v1, v2, v3)
    }

    // decompiled from Move bytecode v6
}

