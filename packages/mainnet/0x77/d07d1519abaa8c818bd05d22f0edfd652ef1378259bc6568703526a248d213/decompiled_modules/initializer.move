module 0xc436a8ccc36e649e0fd8c7cec88ca89747b69ba5bdefb15be2f93ae1ae632800::initializer {
    public entry fun init_create_global(arg0: &mut 0xc436a8ccc36e649e0fd8c7cec88ca89747b69ba5bdefb15be2f93ae1ae632800::governance_admin::AdminCap, arg1: 0x2::coin::TreasuryCap<0xc436a8ccc36e649e0fd8c7cec88ca89747b69ba5bdefb15be2f93ae1ae632800::dori::DORI>, arg2: 0x2::package::Publisher, arg3: &mut 0x2::tx_context::TxContext) {
        0xc436a8ccc36e649e0fd8c7cec88ca89747b69ba5bdefb15be2f93ae1ae632800::global::create_global(arg1, arg3);
        let (v0, v1) = 0xc436a8ccc36e649e0fd8c7cec88ca89747b69ba5bdefb15be2f93ae1ae632800::vault_admin::init_vault_admin_display(arg2, arg3);
        0x2::transfer::public_transfer<0x2::package::Publisher>(v0, 0x2::tx_context::sender(arg3));
        0x2::transfer::public_transfer<0x2::display::Display<0xc436a8ccc36e649e0fd8c7cec88ca89747b69ba5bdefb15be2f93ae1ae632800::vault_admin::VaultAdmin>>(v1, 0x2::tx_context::sender(arg3));
    }

    public fun init_create_pool<T0>(arg0: &mut 0xc436a8ccc36e649e0fd8c7cec88ca89747b69ba5bdefb15be2f93ae1ae632800::governance_admin::AdminCap, arg1: &mut 0xc436a8ccc36e649e0fd8c7cec88ca89747b69ba5bdefb15be2f93ae1ae632800::global::Global, arg2: 0x2::package::Publisher, arg3: vector<u8>, arg4: vector<vector<u8>>, arg5: &mut 0x2::tx_context::TxContext) {
        abort 0
    }

    public fun init_create_pool_v2<T0>(arg0: &mut 0xc436a8ccc36e649e0fd8c7cec88ca89747b69ba5bdefb15be2f93ae1ae632800::governance_admin::AdminCap, arg1: &mut 0xc436a8ccc36e649e0fd8c7cec88ca89747b69ba5bdefb15be2f93ae1ae632800::global::Global, arg2: 0x2::package::Publisher, arg3: vector<u8>, arg4: vector<vector<u8>>, arg5: u256, arg6: u64, arg7: &mut 0x2::tx_context::TxContext) {
        abort 0
    }

    public entry fun init_create_pool_v3<T0>(arg0: &mut 0xc436a8ccc36e649e0fd8c7cec88ca89747b69ba5bdefb15be2f93ae1ae632800::governance_admin::AdminCap, arg1: &mut 0xc436a8ccc36e649e0fd8c7cec88ca89747b69ba5bdefb15be2f93ae1ae632800::global::Global, arg2: 0x2::package::Publisher, arg3: vector<u8>, arg4: vector<vector<u8>>, arg5: u256, arg6: u64, arg7: u64, arg8: u64, arg9: u64, arg10: &mut 0x2::tx_context::TxContext) {
        let v0 = 0xc436a8ccc36e649e0fd8c7cec88ca89747b69ba5bdefb15be2f93ae1ae632800::vault_registry::create_vault_registry_v3<T0>(arg1, arg3, arg4, arg5, arg6, arg7, arg8, arg9, arg10);
        0xc436a8ccc36e649e0fd8c7cec88ca89747b69ba5bdefb15be2f93ae1ae632800::vault_store::create_vault_store<T0>(v0, arg10);
        0xc436a8ccc36e649e0fd8c7cec88ca89747b69ba5bdefb15be2f93ae1ae632800::surplus_pool::create_surplus_pool<T0>(v0, arg10);
        0xc436a8ccc36e649e0fd8c7cec88ca89747b69ba5bdefb15be2f93ae1ae632800::stability_pool::create_stability_pool<T0>(v0, arg10);
        let (v1, v2) = 0xc436a8ccc36e649e0fd8c7cec88ca89747b69ba5bdefb15be2f93ae1ae632800::stability_pool::init_staker_display<T0>(arg2, arg10);
        0x2::transfer::public_transfer<0x2::package::Publisher>(v1, 0x2::tx_context::sender(arg10));
        0x2::transfer::public_transfer<0x2::display::Display<0xc436a8ccc36e649e0fd8c7cec88ca89747b69ba5bdefb15be2f93ae1ae632800::stability_pool::Staker<T0>>>(v2, 0x2::tx_context::sender(arg10));
    }

    public fun init_guard_savings_vault(arg0: &mut 0xc436a8ccc36e649e0fd8c7cec88ca89747b69ba5bdefb15be2f93ae1ae632800::governance_admin::AdminCap, arg1: 0x2::coin::TreasuryCap<0x4875b5292bcd7f4718418fa7fdf86ba9aab1ca65d27cfa3fcabc0fe0122539b8::gdori::GDORI>, arg2: &mut 0x2::tx_context::TxContext) {
        0xc436a8ccc36e649e0fd8c7cec88ca89747b69ba5bdefb15be2f93ae1ae632800::guard_savings::init_guard_savings(arg1, arg2);
    }

    public fun init_new_psm<T0>(arg0: &mut 0xc436a8ccc36e649e0fd8c7cec88ca89747b69ba5bdefb15be2f93ae1ae632800::governance_admin::AdminCap, arg1: u64, arg2: u64, arg3: u64, arg4: u64, arg5: u64, arg6: u64, arg7: &mut 0x2::tx_context::TxContext) {
        abort 0
    }

    public fun init_new_psm_v2<T0>(arg0: &mut 0xc436a8ccc36e649e0fd8c7cec88ca89747b69ba5bdefb15be2f93ae1ae632800::governance_admin::AdminCap, arg1: u64, arg2: u64, arg3: u64, arg4: u64, arg5: u64, arg6: u64, arg7: u64, arg8: &mut 0x2::tx_context::TxContext) {
        0xc436a8ccc36e649e0fd8c7cec88ca89747b69ba5bdefb15be2f93ae1ae632800::psm_v2::create_psm_v2<T0>(arg1, arg2, arg3, arg4, arg5, arg6, arg7, arg8);
    }

    public fun init_svaings(arg0: &mut 0xc436a8ccc36e649e0fd8c7cec88ca89747b69ba5bdefb15be2f93ae1ae632800::governance_admin::AdminCap, arg1: 0x2::coin::TreasuryCap<0x1e881f5933f56d4db5ae61b35c87eb24d08ac370000c55a1124f836ab52ef058::sdori::SDORI>, arg2: &mut 0x2::tx_context::TxContext) {
        0xc436a8ccc36e649e0fd8c7cec88ca89747b69ba5bdefb15be2f93ae1ae632800::savings::init_savings(arg1, arg2);
    }

    // decompiled from Move bytecode v6
}

