module 0x19d4b7bcf29257b4a372d2f8ea151359da960a1ca6984dcb80dfd895343f6353::swap {
    public fun add_swap_route<T0, T1, T2>(arg0: &0x19d4b7bcf29257b4a372d2f8ea151359da960a1ca6984dcb80dfd895343f6353::vault::VaultCap, arg1: &mut 0x19d4b7bcf29257b4a372d2f8ea151359da960a1ca6984dcb80dfd895343f6353::vault::Vault<T0, T1, T2>, arg2: vector<0x360802cb106b004205cd67a706e314eaeadd8590d5f4d1cee46137566232a627::bag_value::Value>, arg3: &0x19d4b7bcf29257b4a372d2f8ea151359da960a1ca6984dcb80dfd895343f6353::version::Version) {
        0x19d4b7bcf29257b4a372d2f8ea151359da960a1ca6984dcb80dfd895343f6353::version::assert_current_version(arg3);
        0x19d4b7bcf29257b4a372d2f8ea151359da960a1ca6984dcb80dfd895343f6353::vault::check_vault_cap_compatibility<T0, T1, T2>(arg0, arg1);
        0x19d4b7bcf29257b4a372d2f8ea151359da960a1ca6984dcb80dfd895343f6353::vault::add_swap_route<T0, T1, T2>(arg1, arg2);
    }

    public fun remove_swap_route<T0, T1, T2>(arg0: &0x19d4b7bcf29257b4a372d2f8ea151359da960a1ca6984dcb80dfd895343f6353::vault::VaultCap, arg1: &mut 0x19d4b7bcf29257b4a372d2f8ea151359da960a1ca6984dcb80dfd895343f6353::vault::Vault<T0, T1, T2>, arg2: &0x19d4b7bcf29257b4a372d2f8ea151359da960a1ca6984dcb80dfd895343f6353::version::Version) {
        0x19d4b7bcf29257b4a372d2f8ea151359da960a1ca6984dcb80dfd895343f6353::version::assert_current_version(arg2);
        0x19d4b7bcf29257b4a372d2f8ea151359da960a1ca6984dcb80dfd895343f6353::vault::check_vault_cap_compatibility<T0, T1, T2>(arg0, arg1);
        0x19d4b7bcf29257b4a372d2f8ea151359da960a1ca6984dcb80dfd895343f6353::vault::remove_swap_route<T0, T1, T2>(arg1);
    }

    // decompiled from Move bytecode v6
}

