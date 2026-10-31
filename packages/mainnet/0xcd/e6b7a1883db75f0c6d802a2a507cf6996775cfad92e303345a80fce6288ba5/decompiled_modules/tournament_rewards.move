module 0x1fbcc2f95306b6db869466c8b2c1461d5102b158584cced9036ee758c4b8cfce::tournament_rewards {
    struct Funds<phantom T0> has store {
        balance: 0x2::balance::Balance<T0>,
        paid: u64,
        claimed: 0x2::vec_set::VecSet<0x2::object::ID>,
        refunded: bool,
    }

    public fun claim<T0>(arg0: &mut Funds<T0>, arg1: 0x2::object::ID, arg2: address, arg3: u64, arg4: &mut 0x2::tx_context::TxContext) {
        assert!(arg0.refunded, 0);
        assert!(!0x2::vec_set::contains<0x2::object::ID>(&arg0.claimed, &arg1), 1);
        0x2::vec_set::insert<0x2::object::ID>(&mut arg0.claimed, arg1);
        pay<T0>(arg0, arg3, arg2, arg4);
    }

    public fun deposit<T0>(arg0: &mut Funds<T0>, arg1: 0x2::coin::Coin<T0>) {
        assert!(!arg0.refunded, 0);
        0x2::balance::join<T0>(&mut arg0.balance, 0x2::coin::into_balance<T0>(arg1));
    }

    public fun new<T0>(arg0: 0x2::coin::Coin<T0>) : Funds<T0> {
        assert!(0x2::coin::value<T0>(&arg0) > 0, 2);
        Funds<T0>{
            balance  : 0x2::coin::into_balance<T0>(arg0),
            paid     : 0,
            claimed  : 0x2::vec_set::empty<0x2::object::ID>(),
            refunded : false,
        }
    }

    fun pay<T0>(arg0: &mut Funds<T0>, arg1: u64, arg2: address, arg3: &mut 0x2::tx_context::TxContext) {
        if (arg1 > 0) {
            arg0.paid = arg0.paid + arg1;
            0x2::transfer::public_transfer<0x2::coin::Coin<T0>>(0x2::coin::from_balance<T0>(0x2::balance::split<T0>(&mut arg0.balance, arg1), arg3), arg2);
        };
    }

    public fun pay_entry(arg0: &mut 0x2::balance::Balance<0x2::sui::SUI>, arg1: 0x2::coin::Coin<0x2::sui::SUI>, arg2: u64, arg3: address, arg4: &mut 0x2::tx_context::TxContext) {
        let v0 = 0x2::coin::value<0x2::sui::SUI>(&arg1);
        assert!(v0 == arg2, 3);
        0x2::balance::join<0x2::sui::SUI>(arg0, 0x2::coin::into_balance<0x2::sui::SUI>(arg1));
        let v1 = v0 / 2;
        if (v1 > 0) {
            0x2::transfer::public_transfer<0x2::coin::Coin<0x2::sui::SUI>>(0x2::coin::from_balance<0x2::sui::SUI>(0x2::balance::split<0x2::sui::SUI>(arg0, v1), arg4), arg3);
        };
    }

    public fun portion(arg0: u64, arg1: u64) : u64 {
        (((arg0 as u128) * (arg1 as u128) / 10000) as u64)
    }

    public fun refund<T0>(arg0: &mut Funds<T0>, arg1: u64, arg2: address, arg3: &mut 0x2::tx_context::TxContext) {
        if (arg0.refunded) {
            return
        };
        arg0.refunded = true;
        pay<T0>(arg0, arg1, arg2, arg3);
    }

    public fun share(arg0: u64, arg1: u64, arg2: u64) : u64 {
        let v0 = if (arg2 < arg0 % arg1) {
            1
        } else {
            0
        };
        arg0 / arg1 + v0
    }

    public fun total<T0>(arg0: &Funds<T0>) : u64 {
        0x2::balance::value<T0>(&arg0.balance) + arg0.paid
    }

    // decompiled from Move bytecode v7
}

