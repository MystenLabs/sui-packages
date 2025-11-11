module 0x1a4e2f10ab05189d36fdef18ebefa0916fae6bfbe082acbc8ac09229d27dcff6::cache {
    public fun account_for_extension_liquidity_of_type<T0, T1, T2>(arg0: &0xdf50f53346c13cf97543268a9837c545c129153a4fbd7b0ad2d0c660e55920dc::vault::Vault<T0>, arg1: &mut 0xdf50f53346c13cf97543268a9837c545c129153a4fbd7b0ad2d0c660e55920dc::cache::UpdateLiquidityCacheCap<T0>, arg2: &0xdf50f53346c13cf97543268a9837c545c129153a4fbd7b0ad2d0c660e55920dc::config::Config, arg3: &mut 0x1a4e2f10ab05189d36fdef18ebefa0916fae6bfbe082acbc8ac09229d27dcff6::protected::ProtectedLendingMarket<T1>) {
        let v0 = 0x1a4e2f10ab05189d36fdef18ebefa0916fae6bfbe082acbc8ac09229d27dcff6::state::create_extension_key();
        0xdf50f53346c13cf97543268a9837c545c129153a4fbd7b0ad2d0c660e55920dc::cache::account_for_extension_liquidity_of_type<T0, T2, 0x1a4e2f10ab05189d36fdef18ebefa0916fae6bfbe082acbc8ac09229d27dcff6::state::ExtensionKey>(arg1, arg2, &v0, 0x1a4e2f10ab05189d36fdef18ebefa0916fae6bfbe082acbc8ac09229d27dcff6::state::total_active_liquidity<T1, T2>(0xdf50f53346c13cf97543268a9837c545c129153a4fbd7b0ad2d0c660e55920dc::vault::borrow_extension<T0, 0x1a4e2f10ab05189d36fdef18ebefa0916fae6bfbe082acbc8ac09229d27dcff6::state::ExtensionKey, 0x1a4e2f10ab05189d36fdef18ebefa0916fae6bfbe082acbc8ac09229d27dcff6::state::ExtensionStateV1<T1>>(arg0, v0), 0x1a4e2f10ab05189d36fdef18ebefa0916fae6bfbe082acbc8ac09229d27dcff6::protected::borrow_mut<T1>(arg3)));
    }

    // decompiled from Move bytecode v6
}

