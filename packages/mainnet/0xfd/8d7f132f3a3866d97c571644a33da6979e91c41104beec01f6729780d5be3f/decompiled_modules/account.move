module 0xfd8d7f132f3a3866d97c571644a33da6979e91c41104beec01f6729780d5be3f::account {
    struct ProbeFired has copy, drop {
        route: u8,
        direction: bool,
        debt: u64,
        repayment: u64,
        surplus: u64,
        profit_coin_type: 0x1::type_name::TypeName,
        quote_count: u8,
    }

    public(friend) fun finish<T0>(arg0: u8, arg1: bool, arg2: u64, arg3: 0x2::balance::Balance<T0>, arg4: u8, arg5: &mut 0x2::tx_context::TxContext) {
        let v0 = ProbeFired{
            route            : arg0,
            direction        : arg1,
            debt             : arg2,
            repayment        : arg2,
            surplus          : 0x2::balance::value<T0>(&arg3),
            profit_coin_type : 0x1::type_name::with_original_ids<T0>(),
            quote_count      : arg4,
        };
        0x2::event::emit<ProbeFired>(v0);
        payout<T0>(arg3, arg5);
    }

    public(friend) fun floors(arg0: u64, arg1: u64) {
        assert!(arg0 > 0 && arg1 > 0, 1);
    }

    public(friend) fun payout<T0>(arg0: 0x2::balance::Balance<T0>, arg1: &mut 0x2::tx_context::TxContext) {
        if (0x2::balance::value<T0>(&arg0) == 0) {
            0x2::balance::destroy_zero<T0>(arg0);
        } else {
            0x2::transfer::public_transfer<0x2::coin::Coin<T0>>(0x2::coin::from_balance<T0>(arg0, arg1), 0x2::tx_context::sender(arg1));
        };
    }

    public(friend) fun repayment<T0>(arg0: &mut 0x2::balance::Balance<T0>, arg1: u64, arg2: u64) : 0x2::balance::Balance<T0> {
        assert!(0xfd8d7f132f3a3866d97c571644a33da6979e91c41104beec01f6729780d5be3f::math::clears(0x2::balance::value<T0>(arg0), arg1, arg2), 2);
        0x2::balance::split<T0>(arg0, arg1)
    }

    // decompiled from Move bytecode v7
}

