module 0x19d4b7bcf29257b4a372d2f8ea151359da960a1ca6984dcb80dfd895343f6353::vault_state {
    public entry fun mark_state_as_ready_for_withdrawal_processing<T0, T1, T2>(arg0: &mut 0x19d4b7bcf29257b4a372d2f8ea151359da960a1ca6984dcb80dfd895343f6353::vault::Vault<T0, T1, T2>, arg1: &0x19d4b7bcf29257b4a372d2f8ea151359da960a1ca6984dcb80dfd895343f6353::version::Version, arg2: &mut 0x2::tx_context::TxContext) {
        0x19d4b7bcf29257b4a372d2f8ea151359da960a1ca6984dcb80dfd895343f6353::version::assert_current_version(arg1);
        0x19d4b7bcf29257b4a372d2f8ea151359da960a1ca6984dcb80dfd895343f6353::vault::assert_address_whitelisted<T0, T1, T2>(arg0, arg2);
        0x19d4b7bcf29257b4a372d2f8ea151359da960a1ca6984dcb80dfd895343f6353::vault::mark_state_as_ready_for_withdrawal_processing<T0, T1, T2>(arg0, arg2);
    }

    public entry fun start_strategy<T0, T1, T2>(arg0: &mut 0x19d4b7bcf29257b4a372d2f8ea151359da960a1ca6984dcb80dfd895343f6353::vault::Vault<T0, T1, T2>, arg1: &0x19d4b7bcf29257b4a372d2f8ea151359da960a1ca6984dcb80dfd895343f6353::version::Version, arg2: &0x2::clock::Clock, arg3: &mut 0x2::tx_context::TxContext) {
        0x19d4b7bcf29257b4a372d2f8ea151359da960a1ca6984dcb80dfd895343f6353::version::assert_current_version(arg1);
        0x19d4b7bcf29257b4a372d2f8ea151359da960a1ca6984dcb80dfd895343f6353::vault::assert_address_whitelisted<T0, T1, T2>(arg0, arg3);
        0x19d4b7bcf29257b4a372d2f8ea151359da960a1ca6984dcb80dfd895343f6353::vault::start_strategy<T0, T1, T2>(arg0, arg2, arg3);
    }

    // decompiled from Move bytecode v6
}

