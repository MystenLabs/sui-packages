module 0x6a2ae5bf6b23cfde16a826a63cf930af6db2508f412a14462b872a2bc22a2092::entry {
    entry fun accept_ownership<T0>(arg0: &mut 0x6a2ae5bf6b23cfde16a826a63cf930af6db2508f412a14462b872a2bc22a2092::treasury::Treasury<T0>, arg1: &0x2::tx_context::TxContext) {
        0x6a2ae5bf6b23cfde16a826a63cf930af6db2508f412a14462b872a2bc22a2092::treasury::assert_is_compatible<T0>(arg0);
        0x7e262a680b092cb43aa5851b591495ebc4646f11892748e8694d4b5e3e9a374d::two_step_role::accept_role<0x6a2ae5bf6b23cfde16a826a63cf930af6db2508f412a14462b872a2bc22a2092::roles::OwnerRole<T0>>(0x6a2ae5bf6b23cfde16a826a63cf930af6db2508f412a14462b872a2bc22a2092::roles::owner_role_mut<T0>(0x6a2ae5bf6b23cfde16a826a63cf930af6db2508f412a14462b872a2bc22a2092::treasury::roles_mut<T0>(arg0)), arg1);
    }

    entry fun transfer_ownership<T0>(arg0: &mut 0x6a2ae5bf6b23cfde16a826a63cf930af6db2508f412a14462b872a2bc22a2092::treasury::Treasury<T0>, arg1: address, arg2: &0x2::tx_context::TxContext) {
        0x6a2ae5bf6b23cfde16a826a63cf930af6db2508f412a14462b872a2bc22a2092::treasury::assert_is_compatible<T0>(arg0);
        0x7e262a680b092cb43aa5851b591495ebc4646f11892748e8694d4b5e3e9a374d::two_step_role::begin_role_transfer<0x6a2ae5bf6b23cfde16a826a63cf930af6db2508f412a14462b872a2bc22a2092::roles::OwnerRole<T0>>(0x6a2ae5bf6b23cfde16a826a63cf930af6db2508f412a14462b872a2bc22a2092::roles::owner_role_mut<T0>(0x6a2ae5bf6b23cfde16a826a63cf930af6db2508f412a14462b872a2bc22a2092::treasury::roles_mut<T0>(arg0)), arg1, arg2);
    }

    entry fun update_blocklister<T0>(arg0: &mut 0x6a2ae5bf6b23cfde16a826a63cf930af6db2508f412a14462b872a2bc22a2092::treasury::Treasury<T0>, arg1: address, arg2: &0x2::tx_context::TxContext) {
        0x6a2ae5bf6b23cfde16a826a63cf930af6db2508f412a14462b872a2bc22a2092::treasury::assert_is_compatible<T0>(arg0);
        0x6a2ae5bf6b23cfde16a826a63cf930af6db2508f412a14462b872a2bc22a2092::roles::update_blocklister<T0>(0x6a2ae5bf6b23cfde16a826a63cf930af6db2508f412a14462b872a2bc22a2092::treasury::roles_mut<T0>(arg0), arg1, arg2);
    }

    entry fun update_master_minter<T0>(arg0: &mut 0x6a2ae5bf6b23cfde16a826a63cf930af6db2508f412a14462b872a2bc22a2092::treasury::Treasury<T0>, arg1: address, arg2: &0x2::tx_context::TxContext) {
        0x6a2ae5bf6b23cfde16a826a63cf930af6db2508f412a14462b872a2bc22a2092::treasury::assert_is_compatible<T0>(arg0);
        0x6a2ae5bf6b23cfde16a826a63cf930af6db2508f412a14462b872a2bc22a2092::roles::update_master_minter<T0>(0x6a2ae5bf6b23cfde16a826a63cf930af6db2508f412a14462b872a2bc22a2092::treasury::roles_mut<T0>(arg0), arg1, arg2);
    }

    entry fun update_metadata_updater<T0>(arg0: &mut 0x6a2ae5bf6b23cfde16a826a63cf930af6db2508f412a14462b872a2bc22a2092::treasury::Treasury<T0>, arg1: address, arg2: &0x2::tx_context::TxContext) {
        0x6a2ae5bf6b23cfde16a826a63cf930af6db2508f412a14462b872a2bc22a2092::treasury::assert_is_compatible<T0>(arg0);
        0x6a2ae5bf6b23cfde16a826a63cf930af6db2508f412a14462b872a2bc22a2092::roles::update_metadata_updater<T0>(0x6a2ae5bf6b23cfde16a826a63cf930af6db2508f412a14462b872a2bc22a2092::treasury::roles_mut<T0>(arg0), arg1, arg2);
    }

    entry fun update_pauser<T0>(arg0: &mut 0x6a2ae5bf6b23cfde16a826a63cf930af6db2508f412a14462b872a2bc22a2092::treasury::Treasury<T0>, arg1: address, arg2: &0x2::tx_context::TxContext) {
        0x6a2ae5bf6b23cfde16a826a63cf930af6db2508f412a14462b872a2bc22a2092::treasury::assert_is_compatible<T0>(arg0);
        0x6a2ae5bf6b23cfde16a826a63cf930af6db2508f412a14462b872a2bc22a2092::roles::update_pauser<T0>(0x6a2ae5bf6b23cfde16a826a63cf930af6db2508f412a14462b872a2bc22a2092::treasury::roles_mut<T0>(arg0), arg1, arg2);
    }

    // decompiled from Move bytecode v6
}

