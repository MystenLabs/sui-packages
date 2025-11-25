module 0x3a93d96ca9f2cf20317667cdef73dbf74d4fbaf9cd6e09cba54bf8fbd6116455::session {
    public fun crank_unlocks<T0, T1>(arg0: &mut 0xdf50f53346c13cf97543268a9837c545c129153a4fbd7b0ad2d0c660e55920dc::session::SessionCap<T0>, arg1: &0x2::clock::Clock) {
        0x3a93d96ca9f2cf20317667cdef73dbf74d4fbaf9cd6e09cba54bf8fbd6116455::state::crank_unlocks<T1>(0xdf50f53346c13cf97543268a9837c545c129153a4fbd7b0ad2d0c660e55920dc::session::borrow_mut_extension<T0, 0x3a93d96ca9f2cf20317667cdef73dbf74d4fbaf9cd6e09cba54bf8fbd6116455::state::ExtensionKey, 0x3a93d96ca9f2cf20317667cdef73dbf74d4fbaf9cd6e09cba54bf8fbd6116455::state::ExtensionMetadataV1>(arg0, 0x3a93d96ca9f2cf20317667cdef73dbf74d4fbaf9cd6e09cba54bf8fbd6116455::state::create_extension_key()), arg1);
    }

    public fun deposit_into_extension<T0, T1, T2>(arg0: &mut 0xdf50f53346c13cf97543268a9837c545c129153a4fbd7b0ad2d0c660e55920dc::session::SessionCap<T0>, arg1: &mut 0xdf50f53346c13cf97543268a9837c545c129153a4fbd7b0ad2d0c660e55920dc::session::SessionCap<T1>, arg2: &0xdf50f53346c13cf97543268a9837c545c129153a4fbd7b0ad2d0c660e55920dc::config::Config, arg3: 0x2::coin::Coin<T2>, arg4: &0x2::clock::Clock, arg5: &mut 0x2::tx_context::TxContext) : 0x9c688ea952547e8d3ebfe13e97668659dd3aebd6c5a854048655ba8f253e7a26::locked::Locked<0x2::coin::Coin<T0>> {
        let v0 = 0x3a93d96ca9f2cf20317667cdef73dbf74d4fbaf9cd6e09cba54bf8fbd6116455::state::create_extension_key();
        let v1 = 0xdf50f53346c13cf97543268a9837c545c129153a4fbd7b0ad2d0c660e55920dc::session::deposit<T1, T2>(arg1, arg2, arg3, arg4, arg5);
        let v2 = 0xdf50f53346c13cf97543268a9837c545c129153a4fbd7b0ad2d0c660e55920dc::session::borrow_mut_extension<T0, 0x3a93d96ca9f2cf20317667cdef73dbf74d4fbaf9cd6e09cba54bf8fbd6116455::state::ExtensionKey, 0x3a93d96ca9f2cf20317667cdef73dbf74d4fbaf9cd6e09cba54bf8fbd6116455::state::ExtensionMetadataV1>(arg0, v0);
        0x3a93d96ca9f2cf20317667cdef73dbf74d4fbaf9cd6e09cba54bf8fbd6116455::state::crank_unlocks<T1>(v2, arg4);
        0x3a93d96ca9f2cf20317667cdef73dbf74d4fbaf9cd6e09cba54bf8fbd6116455::state::join<T1>(v2, v1, 0x2::coin::value<T1>(0x9c688ea952547e8d3ebfe13e97668659dd3aebd6c5a854048655ba8f253e7a26::locked::borrow<0x2::coin::Coin<T1>>(&v1)), arg4);
        0xdf50f53346c13cf97543268a9837c545c129153a4fbd7b0ad2d0c660e55920dc::session::deposit_into_extension<T0, T2, 0x3a93d96ca9f2cf20317667cdef73dbf74d4fbaf9cd6e09cba54bf8fbd6116455::state::ExtensionKey>(arg0, arg2, &v0, &arg3, arg4, arg5)
    }

    public fun withdraw_from_extension<T0, T1, T2>(arg0: &mut 0xdf50f53346c13cf97543268a9837c545c129153a4fbd7b0ad2d0c660e55920dc::session::SessionCap<T0>, arg1: &mut 0xdf50f53346c13cf97543268a9837c545c129153a4fbd7b0ad2d0c660e55920dc::session::ForceWithdrawCap<T0, T2>, arg2: &mut 0xdf50f53346c13cf97543268a9837c545c129153a4fbd7b0ad2d0c660e55920dc::session::SessionCap<T1>, arg3: &0xdf50f53346c13cf97543268a9837c545c129153a4fbd7b0ad2d0c660e55920dc::config::Config, arg4: u64, arg5: &0x2::clock::Clock, arg6: &mut 0x2::tx_context::TxContext) {
        let v0 = 0x3a93d96ca9f2cf20317667cdef73dbf74d4fbaf9cd6e09cba54bf8fbd6116455::state::create_extension_key();
        let v1 = 0xdf50f53346c13cf97543268a9837c545c129153a4fbd7b0ad2d0c660e55920dc::session::borrow_mut_extension<T0, 0x3a93d96ca9f2cf20317667cdef73dbf74d4fbaf9cd6e09cba54bf8fbd6116455::state::ExtensionKey, 0x3a93d96ca9f2cf20317667cdef73dbf74d4fbaf9cd6e09cba54bf8fbd6116455::state::ExtensionMetadataV1>(arg0, v0);
        0x3a93d96ca9f2cf20317667cdef73dbf74d4fbaf9cd6e09cba54bf8fbd6116455::state::crank_unlocks<T1>(v1, arg5);
        0xdf50f53346c13cf97543268a9837c545c129153a4fbd7b0ad2d0c660e55920dc::session::force_withdraw<T0, T2, 0x3a93d96ca9f2cf20317667cdef73dbf74d4fbaf9cd6e09cba54bf8fbd6116455::state::ExtensionKey>(arg0, arg1, arg3, v0, 0xdf50f53346c13cf97543268a9837c545c129153a4fbd7b0ad2d0c660e55920dc::session::withdraw<T1, T2>(arg2, arg3, 0x3a93d96ca9f2cf20317667cdef73dbf74d4fbaf9cd6e09cba54bf8fbd6116455::state::split<T1>(v1, arg4, arg6), arg5, arg6));
    }

    // decompiled from Move bytecode v6
}

