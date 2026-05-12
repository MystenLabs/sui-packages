module 0x9308ba5ea180f0192f85184e36507b0e3e0e17bd60f71df978221c09f21ecf35::adapter_navi {
    struct NaviVault<phantom T0, phantom T1> has key {
        id: 0x2::object::UID,
        receipts: 0x2::balance::Balance<T1>,
        supplied_principal_reference: u64,
    }

    public fun create_vault<T0, T1>(arg0: &0x9308ba5ea180f0192f85184e36507b0e3e0e17bd60f71df978221c09f21ecf35::admin::AdminCap, arg1: &mut 0x2::tx_context::TxContext) {
        let v0 = NaviVault<T0, T1>{
            id                           : 0x2::object::new(arg1),
            receipts                     : 0x2::balance::zero<T1>(),
            supplied_principal_reference : 0,
        };
        0x2::transfer::share_object<NaviVault<T0, T1>>(v0);
    }

    public fun receipt_balance<T0, T1>(arg0: &NaviVault<T0, T1>) : u64 {
        0x2::balance::value<T1>(&arg0.receipts)
    }

    public fun supplied_principal<T0, T1>(arg0: &NaviVault<T0, T1>) : u64 {
        arg0.supplied_principal_reference
    }

    // decompiled from Move bytecode v7
}

