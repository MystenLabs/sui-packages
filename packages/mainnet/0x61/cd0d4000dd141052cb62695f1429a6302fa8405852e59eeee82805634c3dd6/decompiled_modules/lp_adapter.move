module 0x61cd0d4000dd141052cb62695f1429a6302fa8405852e59eeee82805634c3dd6::lp_adapter {
    struct LpAdapter has drop {
        dummy_field: bool,
    }

    public fun begin_spot<T0, T1>(arg0: &0xb7506e6a8dd75bbddeae3b47645d064cc4ba4775c3aedf94ae15376b471c5a5d::operator::OperatorHub, arg1: &0xb7506e6a8dd75bbddeae3b47645d064cc4ba4775c3aedf94ae15376b471c5a5d::registry::AdapterRegistry, arg2: &mut 0xb7506e6a8dd75bbddeae3b47645d064cc4ba4775c3aedf94ae15376b471c5a5d::vault::Vault, arg3: &0xb7506e6a8dd75bbddeae3b47645d064cc4ba4775c3aedf94ae15376b471c5a5d::price::Price, arg4: &0xb7506e6a8dd75bbddeae3b47645d064cc4ba4775c3aedf94ae15376b471c5a5d::price::Price, arg5: u8, arg6: u8, arg7: &0x2::clock::Clock, arg8: &0x2::tx_context::TxContext) : 0xb7506e6a8dd75bbddeae3b47645d064cc4ba4775c3aedf94ae15376b471c5a5d::vault::PricedLoan {
        let v0 = LpAdapter{dummy_field: false};
        0xb7506e6a8dd75bbddeae3b47645d064cc4ba4775c3aedf94ae15376b471c5a5d::vault::session_open<T0, T1, LpAdapter>(v0, arg0, arg1, arg2, arg3, arg4, arg5, arg6, arg7, arg8)
    }

    // decompiled from Move bytecode v7
}

