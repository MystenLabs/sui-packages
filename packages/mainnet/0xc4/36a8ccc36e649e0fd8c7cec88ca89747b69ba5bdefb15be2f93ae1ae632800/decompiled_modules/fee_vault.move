module 0xc436a8ccc36e649e0fd8c7cec88ca89747b69ba5bdefb15be2f93ae1ae632800::fee_vault {
    struct FeeVault<phantom T0> has store, key {
        id: 0x2::object::UID,
        balance: 0x2::balance::Balance<T0>,
    }

    public(friend) fun create_fee_vault<T0>(arg0: &mut 0x2::tx_context::TxContext) : FeeVault<T0> {
        let v0 = FeeVault<T0>{
            id      : 0x2::object::new(arg0),
            balance : 0x2::balance::zero<T0>(),
        };
        0xc436a8ccc36e649e0fd8c7cec88ca89747b69ba5bdefb15be2f93ae1ae632800::events_v1::emit_fee_vault_event(0x2::object::id<FeeVault<T0>>(&v0), 0, 0);
        v0
    }

    public(friend) fun intern_fee_vault_add_balance<T0>(arg0: &mut FeeVault<T0>, arg1: 0x2::balance::Balance<T0>) {
        0x2::balance::join<T0>(&mut arg0.balance, arg1);
        0xc436a8ccc36e649e0fd8c7cec88ca89747b69ba5bdefb15be2f93ae1ae632800::events_v1::emit_fee_vault_event(0x2::object::id<FeeVault<T0>>(arg0), 0x2::balance::value<T0>(&arg0.balance), 0x2::balance::value<T0>(&arg0.balance));
    }

    public fun intern_get_fee_vault_balance<T0>(arg0: &FeeVault<T0>) : u64 {
        0x2::balance::value<T0>(&arg0.balance)
    }

    public fun intern_withdraw_fee_vault_balance<T0>(arg0: &mut 0xc436a8ccc36e649e0fd8c7cec88ca89747b69ba5bdefb15be2f93ae1ae632800::governance_admin::AdminCap, arg1: &mut FeeVault<T0>, arg2: u64) : 0x2::balance::Balance<T0> {
        0x2::balance::split<T0>(&mut arg1.balance, 0xc436a8ccc36e649e0fd8c7cec88ca89747b69ba5bdefb15be2f93ae1ae632800::wf_decimal::to_native_sui(0xc436a8ccc36e649e0fd8c7cec88ca89747b69ba5bdefb15be2f93ae1ae632800::wf_decimal::min(0xc436a8ccc36e649e0fd8c7cec88ca89747b69ba5bdefb15be2f93ae1ae632800::wf_decimal::from_native_sui(arg2), 0xc436a8ccc36e649e0fd8c7cec88ca89747b69ba5bdefb15be2f93ae1ae632800::wf_decimal::from_native_sui(0x2::balance::value<T0>(&arg1.balance)))))
    }

    // decompiled from Move bytecode v6
}

