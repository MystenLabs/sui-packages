module 0xd8dde43392dc9fc320e4bc43c5e2ebbf0ebfc1ebb819b3e8356e1404da5528dc::insurance_fund {
    struct InsuranceFund<phantom T0> has key {
        id: 0x2::object::UID,
        balance: 0x2::balance::Balance<T0>,
    }

    struct InsuranceFundAdminCap has key {
        id: 0x2::object::UID,
        fund_id: address,
    }

    public(friend) fun balance_value<T0>(arg0: &InsuranceFund<T0>) : u256 {
        (0x2::balance::value<T0>(&arg0.balance) as u256)
    }

    public fun create_insurance_fund<T0>(arg0: &mut 0x2::tx_context::TxContext) {
        let v0 = InsuranceFund<T0>{
            id      : 0x2::object::new(arg0),
            balance : 0x2::balance::zero<T0>(),
        };
        let v1 = InsuranceFundAdminCap{
            id      : 0x2::object::new(arg0),
            fund_id : 0x2::object::id_address<InsuranceFund<T0>>(&v0),
        };
        0x2::transfer::transfer<InsuranceFundAdminCap>(v1, 0x2::tx_context::sender(arg0));
        0x2::transfer::share_object<InsuranceFund<T0>>(v0);
    }

    public fun deposit<T0>(arg0: &mut InsuranceFund<T0>, arg1: 0x2::coin::Coin<T0>) {
        0x2::balance::join<T0>(&mut arg0.balance, 0x2::coin::into_balance<T0>(arg1));
    }

    public fun withdraw<T0>(arg0: &mut InsuranceFund<T0>, arg1: &InsuranceFundAdminCap, arg2: u64, arg3: &mut 0x2::tx_context::TxContext) {
        let v0 = 0x2::tx_context::sender(arg3);
        0x2::transfer::public_transfer<0x2::coin::Coin<T0>>(withdraw_ptb<T0>(arg0, arg1, arg2, arg3), v0);
    }

    public fun withdraw_ptb<T0>(arg0: &mut InsuranceFund<T0>, arg1: &InsuranceFundAdminCap, arg2: u64, arg3: &mut 0x2::tx_context::TxContext) : 0x2::coin::Coin<T0> {
        assert!(0x2::object::id_address<InsuranceFund<T0>>(arg0) == arg1.fund_id, 16001);
        0x2::coin::from_balance<T0>(0x2::balance::split<T0>(&mut arg0.balance, arg2), arg3)
    }

    // decompiled from Move bytecode v6
}

