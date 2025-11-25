module 0x3a93d96ca9f2cf20317667cdef73dbf74d4fbaf9cd6e09cba54bf8fbd6116455::vault {
    public fun add_sub_vault<T0, T1, T2>(arg0: &mut 0xdf50f53346c13cf97543268a9837c545c129153a4fbd7b0ad2d0c660e55920dc::vault::Vault<T0>, arg1: &0xdf50f53346c13cf97543268a9837c545c129153a4fbd7b0ad2d0c660e55920dc::authority::AuthorityCap<0xdf50f53346c13cf97543268a9837c545c129153a4fbd7b0ad2d0c660e55920dc::authority::VAULT, T1>, arg2: &0xdf50f53346c13cf97543268a9837c545c129153a4fbd7b0ad2d0c660e55920dc::vault::Vault<T2>, arg3: &0xdf50f53346c13cf97543268a9837c545c129153a4fbd7b0ad2d0c660e55920dc::config::Config, arg4: &mut 0x2::tx_context::TxContext) {
        0xdf50f53346c13cf97543268a9837c545c129153a4fbd7b0ad2d0c660e55920dc::config::assert_package_version(arg3);
        0xdf50f53346c13cf97543268a9837c545c129153a4fbd7b0ad2d0c660e55920dc::vault::assert_can_be_mutated_by<T0, T1>(arg0, arg1);
        assert!(!0xdf50f53346c13cf97543268a9837c545c129153a4fbd7b0ad2d0c660e55920dc::vault::supports_extension<T2, 0x3a93d96ca9f2cf20317667cdef73dbf74d4fbaf9cd6e09cba54bf8fbd6116455::state::ExtensionKey>(arg2, 0x3a93d96ca9f2cf20317667cdef73dbf74d4fbaf9cd6e09cba54bf8fbd6116455::state::create_extension_key()), 0);
        0x3a93d96ca9f2cf20317667cdef73dbf74d4fbaf9cd6e09cba54bf8fbd6116455::state::add_sub_vault<T2>(0xdf50f53346c13cf97543268a9837c545c129153a4fbd7b0ad2d0c660e55920dc::vault::borrow_mut_extension<T0, 0x3a93d96ca9f2cf20317667cdef73dbf74d4fbaf9cd6e09cba54bf8fbd6116455::state::ExtensionKey, 0x3a93d96ca9f2cf20317667cdef73dbf74d4fbaf9cd6e09cba54bf8fbd6116455::state::ExtensionMetadataV1>(arg0, 0x3a93d96ca9f2cf20317667cdef73dbf74d4fbaf9cd6e09cba54bf8fbd6116455::state::create_extension_key()), arg2, arg4);
    }

    public fun crank_unlocks<T0, T1>(arg0: &mut 0xdf50f53346c13cf97543268a9837c545c129153a4fbd7b0ad2d0c660e55920dc::vault::Vault<T0>, arg1: &0x2::clock::Clock) {
        0x3a93d96ca9f2cf20317667cdef73dbf74d4fbaf9cd6e09cba54bf8fbd6116455::state::crank_unlocks<T1>(0xdf50f53346c13cf97543268a9837c545c129153a4fbd7b0ad2d0c660e55920dc::vault::borrow_mut_extension<T0, 0x3a93d96ca9f2cf20317667cdef73dbf74d4fbaf9cd6e09cba54bf8fbd6116455::state::ExtensionKey, 0x3a93d96ca9f2cf20317667cdef73dbf74d4fbaf9cd6e09cba54bf8fbd6116455::state::ExtensionMetadataV1>(arg0, 0x3a93d96ca9f2cf20317667cdef73dbf74d4fbaf9cd6e09cba54bf8fbd6116455::state::create_extension_key()), arg1);
    }

    public fun add_extension<T0, T1>(arg0: &mut 0xdf50f53346c13cf97543268a9837c545c129153a4fbd7b0ad2d0c660e55920dc::vault::Vault<T0>, arg1: &0xdf50f53346c13cf97543268a9837c545c129153a4fbd7b0ad2d0c660e55920dc::authority::AuthorityCap<0xdf50f53346c13cf97543268a9837c545c129153a4fbd7b0ad2d0c660e55920dc::authority::VAULT, T1>, arg2: &0xdf50f53346c13cf97543268a9837c545c129153a4fbd7b0ad2d0c660e55920dc::config::Config, arg3: &mut 0x2::tx_context::TxContext) {
        0xdf50f53346c13cf97543268a9837c545c129153a4fbd7b0ad2d0c660e55920dc::vault::add_extension<T0, T1, 0x3a93d96ca9f2cf20317667cdef73dbf74d4fbaf9cd6e09cba54bf8fbd6116455::state::ExtensionKey, 0x3a93d96ca9f2cf20317667cdef73dbf74d4fbaf9cd6e09cba54bf8fbd6116455::state::ExtensionMetadataV1>(arg0, arg1, arg2, 0x3a93d96ca9f2cf20317667cdef73dbf74d4fbaf9cd6e09cba54bf8fbd6116455::state::create_extension_key(), 0x3a93d96ca9f2cf20317667cdef73dbf74d4fbaf9cd6e09cba54bf8fbd6116455::state::new(arg3));
    }

    public fun admin_deposit_into_extension<T0, T1, T2, T3>(arg0: &mut 0xdf50f53346c13cf97543268a9837c545c129153a4fbd7b0ad2d0c660e55920dc::vault::Vault<T0>, arg1: &0xdf50f53346c13cf97543268a9837c545c129153a4fbd7b0ad2d0c660e55920dc::authority::AuthorityCap<0xdf50f53346c13cf97543268a9837c545c129153a4fbd7b0ad2d0c660e55920dc::authority::VAULT, T1>, arg2: &mut 0xdf50f53346c13cf97543268a9837c545c129153a4fbd7b0ad2d0c660e55920dc::session::SessionCap<T2>, arg3: &0xdf50f53346c13cf97543268a9837c545c129153a4fbd7b0ad2d0c660e55920dc::config::Config, arg4: u64, arg5: &0x2::clock::Clock, arg6: &mut 0x2::tx_context::TxContext) {
        0xdf50f53346c13cf97543268a9837c545c129153a4fbd7b0ad2d0c660e55920dc::vault::assert_can_be_mutated_by<T0, T1>(arg0, arg1);
        let v0 = 0x3a93d96ca9f2cf20317667cdef73dbf74d4fbaf9cd6e09cba54bf8fbd6116455::state::create_extension_key();
        let v1 = 0xdf50f53346c13cf97543268a9837c545c129153a4fbd7b0ad2d0c660e55920dc::vault::admin_withdraw<T0, T3, 0x3a93d96ca9f2cf20317667cdef73dbf74d4fbaf9cd6e09cba54bf8fbd6116455::state::ExtensionKey>(arg0, arg3, v0, arg4, arg6);
        let v2 = 0xdf50f53346c13cf97543268a9837c545c129153a4fbd7b0ad2d0c660e55920dc::vault::borrow_mut_extension<T0, 0x3a93d96ca9f2cf20317667cdef73dbf74d4fbaf9cd6e09cba54bf8fbd6116455::state::ExtensionKey, 0x3a93d96ca9f2cf20317667cdef73dbf74d4fbaf9cd6e09cba54bf8fbd6116455::state::ExtensionMetadataV1>(arg0, v0);
        0x3a93d96ca9f2cf20317667cdef73dbf74d4fbaf9cd6e09cba54bf8fbd6116455::state::crank_unlocks<T2>(v2, arg5);
        0x3a93d96ca9f2cf20317667cdef73dbf74d4fbaf9cd6e09cba54bf8fbd6116455::state::join<T2>(v2, 0xdf50f53346c13cf97543268a9837c545c129153a4fbd7b0ad2d0c660e55920dc::session::deposit<T2, T3>(arg2, arg3, v1, arg5, arg6), 0x2::coin::value<T3>(&v1), arg5);
    }

    public fun admin_withdraw_from_extension<T0, T1, T2, T3>(arg0: &mut 0xdf50f53346c13cf97543268a9837c545c129153a4fbd7b0ad2d0c660e55920dc::vault::Vault<T0>, arg1: &0xdf50f53346c13cf97543268a9837c545c129153a4fbd7b0ad2d0c660e55920dc::authority::AuthorityCap<0xdf50f53346c13cf97543268a9837c545c129153a4fbd7b0ad2d0c660e55920dc::authority::VAULT, T1>, arg2: &mut 0xdf50f53346c13cf97543268a9837c545c129153a4fbd7b0ad2d0c660e55920dc::session::SessionCap<T2>, arg3: &0xdf50f53346c13cf97543268a9837c545c129153a4fbd7b0ad2d0c660e55920dc::config::Config, arg4: u64, arg5: &0x2::clock::Clock, arg6: &mut 0x2::tx_context::TxContext) {
        0xdf50f53346c13cf97543268a9837c545c129153a4fbd7b0ad2d0c660e55920dc::vault::assert_can_be_mutated_by<T0, T1>(arg0, arg1);
        let v0 = 0x3a93d96ca9f2cf20317667cdef73dbf74d4fbaf9cd6e09cba54bf8fbd6116455::state::create_extension_key();
        let v1 = 0xdf50f53346c13cf97543268a9837c545c129153a4fbd7b0ad2d0c660e55920dc::vault::borrow_mut_extension<T0, 0x3a93d96ca9f2cf20317667cdef73dbf74d4fbaf9cd6e09cba54bf8fbd6116455::state::ExtensionKey, 0x3a93d96ca9f2cf20317667cdef73dbf74d4fbaf9cd6e09cba54bf8fbd6116455::state::ExtensionMetadataV1>(arg0, v0);
        0x3a93d96ca9f2cf20317667cdef73dbf74d4fbaf9cd6e09cba54bf8fbd6116455::state::crank_unlocks<T2>(v1, arg5);
        0xdf50f53346c13cf97543268a9837c545c129153a4fbd7b0ad2d0c660e55920dc::vault::admin_deposit<T0, T3, 0x3a93d96ca9f2cf20317667cdef73dbf74d4fbaf9cd6e09cba54bf8fbd6116455::state::ExtensionKey>(arg0, arg3, v0, 0xdf50f53346c13cf97543268a9837c545c129153a4fbd7b0ad2d0c660e55920dc::session::withdraw<T2, T3>(arg2, arg3, 0x3a93d96ca9f2cf20317667cdef73dbf74d4fbaf9cd6e09cba54bf8fbd6116455::state::split<T2>(v1, arg4, arg6), arg5, arg6));
    }

    public fun remove_extension<T0, T1, T2>(arg0: &mut 0xdf50f53346c13cf97543268a9837c545c129153a4fbd7b0ad2d0c660e55920dc::vault::Vault<T0>, arg1: &0xdf50f53346c13cf97543268a9837c545c129153a4fbd7b0ad2d0c660e55920dc::authority::AuthorityCap<0xdf50f53346c13cf97543268a9837c545c129153a4fbd7b0ad2d0c660e55920dc::authority::VAULT, T1>, arg2: &0xdf50f53346c13cf97543268a9837c545c129153a4fbd7b0ad2d0c660e55920dc::vault::Vault<T2>, arg3: &0xdf50f53346c13cf97543268a9837c545c129153a4fbd7b0ad2d0c660e55920dc::config::Config) {
        0x3a93d96ca9f2cf20317667cdef73dbf74d4fbaf9cd6e09cba54bf8fbd6116455::state::destroy(0xdf50f53346c13cf97543268a9837c545c129153a4fbd7b0ad2d0c660e55920dc::vault::remove_extension<T0, T1, 0x3a93d96ca9f2cf20317667cdef73dbf74d4fbaf9cd6e09cba54bf8fbd6116455::state::ExtensionKey, 0x3a93d96ca9f2cf20317667cdef73dbf74d4fbaf9cd6e09cba54bf8fbd6116455::state::ExtensionMetadataV1>(arg0, arg1, arg3, 0x3a93d96ca9f2cf20317667cdef73dbf74d4fbaf9cd6e09cba54bf8fbd6116455::state::create_extension_key()));
    }

    // decompiled from Move bytecode v6
}

