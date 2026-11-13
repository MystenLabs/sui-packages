module 0xe90b6ae1efb63a69264aa16e91f4a6f842047afcf3af3928d31fccdb8c4af5aa::migrate {
    struct Migrated has copy, drop {
        user: address,
        amount: u64,
    }

    public fun grid_cash<T0>(arg0: &0xe90b6ae1efb63a69264aa16e91f4a6f842047afcf3af3928d31fccdb8c4af5aa::exchange::OperatorCap, arg1: &mut 0xe90b6ae1efb63a69264aa16e91f4a6f842047afcf3af3928d31fccdb8c4af5aa::exchange::Exchange<T0>, arg2: address, arg3: 0x2::balance::Balance<T0>, arg4: &mut 0x2::tx_context::TxContext) {
        0xe90b6ae1efb63a69264aa16e91f4a6f842047afcf3af3928d31fccdb8c4af5aa::exchange::check_operator<T0>(arg1, arg0);
        0xe90b6ae1efb63a69264aa16e91f4a6f842047afcf3af3928d31fccdb8c4af5aa::exchange::deposit_for<T0, T0>(arg1, arg2, 0x2::coin::from_balance<T0>(arg3, arg4), arg4);
        let v0 = Migrated{
            user   : arg2,
            amount : 0x2::balance::value<T0>(&arg3),
        };
        0x2::event::emit<Migrated>(v0);
    }

    // decompiled from Move bytecode v7
}

