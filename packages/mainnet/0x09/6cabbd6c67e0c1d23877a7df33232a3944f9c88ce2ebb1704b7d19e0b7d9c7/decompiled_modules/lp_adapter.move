module 0x96cabbd6c67e0c1d23877a7df33232a3944f9c88ce2ebb1704b7d19e0b7d9c7::lp_adapter {
    struct LpAdapter has drop {
        dummy_field: bool,
    }

    public fun begin_spot<T0, T1>(arg0: &0xbd1b45833f406826977dacc7d68881e4931add49bbcb4384f3ef5d1d82914328::operator::OperatorHub, arg1: &0xbd1b45833f406826977dacc7d68881e4931add49bbcb4384f3ef5d1d82914328::registry::AdapterRegistry, arg2: &mut 0xbd1b45833f406826977dacc7d68881e4931add49bbcb4384f3ef5d1d82914328::vault::Vault, arg3: &0xbd1b45833f406826977dacc7d68881e4931add49bbcb4384f3ef5d1d82914328::price::Price, arg4: &0xbd1b45833f406826977dacc7d68881e4931add49bbcb4384f3ef5d1d82914328::price::Price, arg5: u8, arg6: u8, arg7: &0x2::clock::Clock, arg8: &0x2::tx_context::TxContext) : 0xbd1b45833f406826977dacc7d68881e4931add49bbcb4384f3ef5d1d82914328::vault::PricedLoan {
        let v0 = LpAdapter{dummy_field: false};
        0xbd1b45833f406826977dacc7d68881e4931add49bbcb4384f3ef5d1d82914328::vault::session_open<T0, T1, LpAdapter>(v0, arg0, arg1, arg2, arg3, arg4, arg5, arg6, arg7, arg8)
    }

    // decompiled from Move bytecode v7
}

