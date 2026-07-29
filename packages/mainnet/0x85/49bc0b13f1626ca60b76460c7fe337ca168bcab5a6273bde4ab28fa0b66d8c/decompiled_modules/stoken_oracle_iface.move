module 0x8549bc0b13f1626ca60b76460c7fe337ca168bcab5a6273bde4ab28fa0b66d8c::stoken_oracle_iface {
    public fun accept_price<T0, T1>(arg0: &mut 0x8549bc0b13f1626ca60b76460c7fe337ca168bcab5a6273bde4ab28fa0b66d8c::stoken_vault::Vault<T0, T1>, arg1: &0x2::clock::Clock, arg2: &0x2::tx_context::TxContext) {
        0x8549bc0b13f1626ca60b76460c7fe337ca168bcab5a6273bde4ab28fa0b66d8c::stoken_vault::accept_price<T0, T1>(arg0, arg1, arg2);
    }

    public fun get_price<T0, T1>(arg0: &0x8549bc0b13f1626ca60b76460c7fe337ca168bcab5a6273bde4ab28fa0b66d8c::stoken_vault::Vault<T0, T1>) : u64 {
        0x8549bc0b13f1626ca60b76460c7fe337ca168bcab5a6273bde4ab28fa0b66d8c::stoken_vault::get_price<T0, T1>(arg0)
    }

    public fun has_pending_price<T0, T1>(arg0: &0x8549bc0b13f1626ca60b76460c7fe337ca168bcab5a6273bde4ab28fa0b66d8c::stoken_vault::Vault<T0, T1>) : bool {
        0x8549bc0b13f1626ca60b76460c7fe337ca168bcab5a6273bde4ab28fa0b66d8c::stoken_vault::has_pending_price<T0, T1>(arg0)
    }

    public fun reject_price<T0, T1>(arg0: &mut 0x8549bc0b13f1626ca60b76460c7fe337ca168bcab5a6273bde4ab28fa0b66d8c::stoken_vault::Vault<T0, T1>, arg1: &0x8549bc0b13f1626ca60b76460c7fe337ca168bcab5a6273bde4ab28fa0b66d8c::stoken_vault::ManagerCap, arg2: &0x2::tx_context::TxContext) {
        0x8549bc0b13f1626ca60b76460c7fe337ca168bcab5a6273bde4ab28fa0b66d8c::stoken_vault::reject_price<T0, T1>(arg0, arg1, arg2);
    }

    public fun update_price<T0, T1>(arg0: &mut 0x8549bc0b13f1626ca60b76460c7fe337ca168bcab5a6273bde4ab28fa0b66d8c::stoken_vault::Vault<T0, T1>, arg1: u64, arg2: &0x2::clock::Clock, arg3: &0x2::tx_context::TxContext) {
        0x8549bc0b13f1626ca60b76460c7fe337ca168bcab5a6273bde4ab28fa0b66d8c::stoken_vault::update_price<T0, T1>(arg0, arg1, arg2, arg3);
    }

    // decompiled from Move bytecode v7
}

