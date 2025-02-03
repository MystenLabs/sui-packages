module 0xa5e7af50df270daf0917be0c6919bcbeb322b6cb43b04aae5a1e9d4113024502::obligation_debts {
    struct Debt has copy, drop, store {
        amount: u64,
        borrow_index: u64,
    }

    struct ObligationDebts has drop {
        dummy_field: bool,
    }

    public(friend) fun accrue_interest(arg0: &mut 0xfd1248585e5fcc31620aeab61fa030e73ea385a98bb8c0f0068f427d9ddfde5c::wit_table::WitTable<ObligationDebts, 0x1::type_name::TypeName, Debt>, arg1: 0x1::type_name::TypeName, arg2: u64) : u64 {
        let v0 = ObligationDebts{dummy_field: false};
        let v1 = 0xfd1248585e5fcc31620aeab61fa030e73ea385a98bb8c0f0068f427d9ddfde5c::wit_table::borrow_mut<ObligationDebts, 0x1::type_name::TypeName, Debt>(v0, arg0, arg1);
        v1.amount = 0x1::fixed_point32::multiply_u64(v1.amount, 0x1::fixed_point32::create_from_rational(arg2, v1.borrow_index));
        v1.borrow_index = arg2;
        v1.amount - v1.amount
    }

    public fun debt(arg0: &0xfd1248585e5fcc31620aeab61fa030e73ea385a98bb8c0f0068f427d9ddfde5c::wit_table::WitTable<ObligationDebts, 0x1::type_name::TypeName, Debt>, arg1: 0x1::type_name::TypeName) : (u64, u64) {
        let v0 = 0xfd1248585e5fcc31620aeab61fa030e73ea385a98bb8c0f0068f427d9ddfde5c::wit_table::borrow<ObligationDebts, 0x1::type_name::TypeName, Debt>(arg0, arg1);
        (v0.amount, v0.borrow_index)
    }

    public(friend) fun decrease(arg0: &mut 0xfd1248585e5fcc31620aeab61fa030e73ea385a98bb8c0f0068f427d9ddfde5c::wit_table::WitTable<ObligationDebts, 0x1::type_name::TypeName, Debt>, arg1: 0x1::type_name::TypeName, arg2: u64) {
        let v0 = ObligationDebts{dummy_field: false};
        let v1 = 0xfd1248585e5fcc31620aeab61fa030e73ea385a98bb8c0f0068f427d9ddfde5c::wit_table::borrow_mut<ObligationDebts, 0x1::type_name::TypeName, Debt>(v0, arg0, arg1);
        v1.amount = v1.amount - arg2;
        if (v1.amount == 0) {
            let v2 = ObligationDebts{dummy_field: false};
            0xfd1248585e5fcc31620aeab61fa030e73ea385a98bb8c0f0068f427d9ddfde5c::wit_table::remove<ObligationDebts, 0x1::type_name::TypeName, Debt>(v2, arg0, arg1);
        };
    }

    public(friend) fun increase(arg0: &mut 0xfd1248585e5fcc31620aeab61fa030e73ea385a98bb8c0f0068f427d9ddfde5c::wit_table::WitTable<ObligationDebts, 0x1::type_name::TypeName, Debt>, arg1: 0x1::type_name::TypeName, arg2: u64) {
        let v0 = ObligationDebts{dummy_field: false};
        let v1 = 0xfd1248585e5fcc31620aeab61fa030e73ea385a98bb8c0f0068f427d9ddfde5c::wit_table::borrow_mut<ObligationDebts, 0x1::type_name::TypeName, Debt>(v0, arg0, arg1);
        v1.amount = v1.amount + arg2;
    }

    public(friend) fun init_debt(arg0: &mut 0xfd1248585e5fcc31620aeab61fa030e73ea385a98bb8c0f0068f427d9ddfde5c::wit_table::WitTable<ObligationDebts, 0x1::type_name::TypeName, Debt>, arg1: 0x1::type_name::TypeName, arg2: u64) {
        if (0xfd1248585e5fcc31620aeab61fa030e73ea385a98bb8c0f0068f427d9ddfde5c::wit_table::contains<ObligationDebts, 0x1::type_name::TypeName, Debt>(arg0, arg1)) {
            return
        };
        let v0 = Debt{
            amount       : 0,
            borrow_index : arg2,
        };
        let v1 = ObligationDebts{dummy_field: false};
        0xfd1248585e5fcc31620aeab61fa030e73ea385a98bb8c0f0068f427d9ddfde5c::wit_table::add<ObligationDebts, 0x1::type_name::TypeName, Debt>(v1, arg0, arg1, v0);
    }

    public(friend) fun new(arg0: &mut 0x2::tx_context::TxContext) : 0xfd1248585e5fcc31620aeab61fa030e73ea385a98bb8c0f0068f427d9ddfde5c::wit_table::WitTable<ObligationDebts, 0x1::type_name::TypeName, Debt> {
        let v0 = ObligationDebts{dummy_field: false};
        0xfd1248585e5fcc31620aeab61fa030e73ea385a98bb8c0f0068f427d9ddfde5c::wit_table::new<ObligationDebts, 0x1::type_name::TypeName, Debt>(v0, true, arg0)
    }

    // decompiled from Move bytecode v6
}

