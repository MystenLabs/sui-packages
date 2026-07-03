module 0x1842956dd586c99010c3d2b3ac9f6a571a5e3ba6f6538bf0b3b7ec956f8a5f42::stoken_oracle_iface {
    public fun accept_price<T0, T1>(arg0: &mut 0x1842956dd586c99010c3d2b3ac9f6a571a5e3ba6f6538bf0b3b7ec956f8a5f42::stoken_vault::Vault<T0, T1>, arg1: &0x2::clock::Clock, arg2: &0x2::tx_context::TxContext) {
        0x1842956dd586c99010c3d2b3ac9f6a571a5e3ba6f6538bf0b3b7ec956f8a5f42::stoken_vault::accept_price<T0, T1>(arg0, arg1, arg2);
    }

    public fun get_price<T0, T1>(arg0: &0x1842956dd586c99010c3d2b3ac9f6a571a5e3ba6f6538bf0b3b7ec956f8a5f42::stoken_vault::Vault<T0, T1>) : u64 {
        0x1842956dd586c99010c3d2b3ac9f6a571a5e3ba6f6538bf0b3b7ec956f8a5f42::stoken_vault::get_price<T0, T1>(arg0)
    }

    public fun has_pending_price<T0, T1>(arg0: &0x1842956dd586c99010c3d2b3ac9f6a571a5e3ba6f6538bf0b3b7ec956f8a5f42::stoken_vault::Vault<T0, T1>) : bool {
        0x1842956dd586c99010c3d2b3ac9f6a571a5e3ba6f6538bf0b3b7ec956f8a5f42::stoken_vault::has_pending_price<T0, T1>(arg0)
    }

    public fun reject_price<T0, T1>(arg0: &mut 0x1842956dd586c99010c3d2b3ac9f6a571a5e3ba6f6538bf0b3b7ec956f8a5f42::stoken_vault::Vault<T0, T1>, arg1: &0x1842956dd586c99010c3d2b3ac9f6a571a5e3ba6f6538bf0b3b7ec956f8a5f42::stoken_vault::ManagerCap, arg2: &0x2::tx_context::TxContext) {
        0x1842956dd586c99010c3d2b3ac9f6a571a5e3ba6f6538bf0b3b7ec956f8a5f42::stoken_vault::reject_price<T0, T1>(arg0, arg1, arg2);
    }

    public fun update_price<T0, T1>(arg0: &mut 0x1842956dd586c99010c3d2b3ac9f6a571a5e3ba6f6538bf0b3b7ec956f8a5f42::stoken_vault::Vault<T0, T1>, arg1: u64, arg2: &0x2::clock::Clock, arg3: &0x2::tx_context::TxContext) {
        0x1842956dd586c99010c3d2b3ac9f6a571a5e3ba6f6538bf0b3b7ec956f8a5f42::stoken_vault::update_price<T0, T1>(arg0, arg1, arg2, arg3);
    }

    // decompiled from Move bytecode v7
}

