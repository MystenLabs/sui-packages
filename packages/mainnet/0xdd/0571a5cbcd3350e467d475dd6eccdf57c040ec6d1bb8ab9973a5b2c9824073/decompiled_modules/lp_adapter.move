module 0xdd0571a5cbcd3350e467d475dd6eccdf57c040ec6d1bb8ab9973a5b2c9824073::lp_adapter {
    struct LpAdapter has drop {
        dummy_field: bool,
    }

    public fun begin(arg0: &0x1122bb9f1fbd168cce4c2325c3da7d636081078d23e560472781816d8e1897e3::operator::OperatorHub, arg1: &0x1122bb9f1fbd168cce4c2325c3da7d636081078d23e560472781816d8e1897e3::registry::AdapterRegistry, arg2: &mut 0x1122bb9f1fbd168cce4c2325c3da7d636081078d23e560472781816d8e1897e3::vault::Vault, arg3: &0x2::tx_context::TxContext) : 0x1122bb9f1fbd168cce4c2325c3da7d636081078d23e560472781816d8e1897e3::vault::Loan {
        let v0 = LpAdapter{dummy_field: false};
        0x1122bb9f1fbd168cce4c2325c3da7d636081078d23e560472781816d8e1897e3::vault::session_new<LpAdapter>(v0, arg0, arg1, arg2, arg3)
    }

    // decompiled from Move bytecode v7
}

