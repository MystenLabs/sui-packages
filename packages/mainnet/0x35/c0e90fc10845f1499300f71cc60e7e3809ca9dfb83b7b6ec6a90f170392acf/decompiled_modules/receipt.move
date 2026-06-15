module 0x35c0e90fc10845f1499300f71cc60e7e3809ca9dfb83b7b6ec6a90f170392acf::receipt {
    struct ShieldReceipt<phantom T0> has store, key {
        id: 0x2::object::UID,
        vault_id: 0x2::object::ID,
        shares: u64,
    }

    public(friend) fun delete<T0>(arg0: ShieldReceipt<T0>) {
        let ShieldReceipt {
            id       : v0,
            vault_id : _,
            shares   : _,
        } = arg0;
        0x2::object::delete(v0);
    }

    public(friend) fun add_shares<T0>(arg0: &mut ShieldReceipt<T0>, arg1: u64) {
        arg0.shares = arg0.shares + arg1;
    }

    public(friend) fun mint<T0>(arg0: 0x2::object::ID, arg1: u64, arg2: &mut 0x2::tx_context::TxContext) : ShieldReceipt<T0> {
        ShieldReceipt<T0>{
            id       : 0x2::object::new(arg2),
            vault_id : arg0,
            shares   : arg1,
        }
    }

    public(friend) fun shares<T0>(arg0: &ShieldReceipt<T0>) : u64 {
        arg0.shares
    }

    public(friend) fun subtract_shares<T0>(arg0: &mut ShieldReceipt<T0>, arg1: u64) {
        arg0.shares = arg0.shares - arg1;
    }

    public(friend) fun vault_id<T0>(arg0: &ShieldReceipt<T0>) : 0x2::object::ID {
        arg0.vault_id
    }

    // decompiled from Move bytecode v7
}

