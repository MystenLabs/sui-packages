module 0x8f4c60a713f28c458e357e134d04d22057daa3f069b502e18aeb3592df68acbb::entry {
    entry fun accept_ownership<T0>(arg0: &mut 0x8f4c60a713f28c458e357e134d04d22057daa3f069b502e18aeb3592df68acbb::treasury::Treasury<T0>, arg1: &0x2::tx_context::TxContext) {
        0x8f4c60a713f28c458e357e134d04d22057daa3f069b502e18aeb3592df68acbb::treasury::assert_is_compatible<T0>(arg0);
        0x8f4c60a713f28c458e357e134d04d22057daa3f069b502e18aeb3592df68acbb::two_step_role::accept_role<0x8f4c60a713f28c458e357e134d04d22057daa3f069b502e18aeb3592df68acbb::roles::OwnerRole<T0>>(0x8f4c60a713f28c458e357e134d04d22057daa3f069b502e18aeb3592df68acbb::roles::owner_role_mut<T0>(0x8f4c60a713f28c458e357e134d04d22057daa3f069b502e18aeb3592df68acbb::treasury::roles_mut<T0>(arg0)), arg1);
    }

    entry fun transfer_ownership<T0>(arg0: &mut 0x8f4c60a713f28c458e357e134d04d22057daa3f069b502e18aeb3592df68acbb::treasury::Treasury<T0>, arg1: address, arg2: &0x2::tx_context::TxContext) {
        0x8f4c60a713f28c458e357e134d04d22057daa3f069b502e18aeb3592df68acbb::treasury::assert_is_compatible<T0>(arg0);
        0x8f4c60a713f28c458e357e134d04d22057daa3f069b502e18aeb3592df68acbb::two_step_role::begin_role_transfer<0x8f4c60a713f28c458e357e134d04d22057daa3f069b502e18aeb3592df68acbb::roles::OwnerRole<T0>>(0x8f4c60a713f28c458e357e134d04d22057daa3f069b502e18aeb3592df68acbb::roles::owner_role_mut<T0>(0x8f4c60a713f28c458e357e134d04d22057daa3f069b502e18aeb3592df68acbb::treasury::roles_mut<T0>(arg0)), arg1, arg2);
    }

    entry fun update_blocklister<T0>(arg0: &mut 0x8f4c60a713f28c458e357e134d04d22057daa3f069b502e18aeb3592df68acbb::treasury::Treasury<T0>, arg1: address, arg2: &0x2::tx_context::TxContext) {
        0x8f4c60a713f28c458e357e134d04d22057daa3f069b502e18aeb3592df68acbb::treasury::assert_is_compatible<T0>(arg0);
        0x8f4c60a713f28c458e357e134d04d22057daa3f069b502e18aeb3592df68acbb::roles::update_blocklister<T0>(0x8f4c60a713f28c458e357e134d04d22057daa3f069b502e18aeb3592df68acbb::treasury::roles_mut<T0>(arg0), arg1, arg2);
    }

    entry fun update_master_minter<T0>(arg0: &mut 0x8f4c60a713f28c458e357e134d04d22057daa3f069b502e18aeb3592df68acbb::treasury::Treasury<T0>, arg1: address, arg2: &0x2::tx_context::TxContext) {
        0x8f4c60a713f28c458e357e134d04d22057daa3f069b502e18aeb3592df68acbb::treasury::assert_is_compatible<T0>(arg0);
        0x8f4c60a713f28c458e357e134d04d22057daa3f069b502e18aeb3592df68acbb::roles::update_master_minter<T0>(0x8f4c60a713f28c458e357e134d04d22057daa3f069b502e18aeb3592df68acbb::treasury::roles_mut<T0>(arg0), arg1, arg2);
    }

    entry fun update_metadata_updater<T0>(arg0: &mut 0x8f4c60a713f28c458e357e134d04d22057daa3f069b502e18aeb3592df68acbb::treasury::Treasury<T0>, arg1: address, arg2: &0x2::tx_context::TxContext) {
        0x8f4c60a713f28c458e357e134d04d22057daa3f069b502e18aeb3592df68acbb::treasury::assert_is_compatible<T0>(arg0);
        0x8f4c60a713f28c458e357e134d04d22057daa3f069b502e18aeb3592df68acbb::roles::update_metadata_updater<T0>(0x8f4c60a713f28c458e357e134d04d22057daa3f069b502e18aeb3592df68acbb::treasury::roles_mut<T0>(arg0), arg1, arg2);
    }

    entry fun update_pauser<T0>(arg0: &mut 0x8f4c60a713f28c458e357e134d04d22057daa3f069b502e18aeb3592df68acbb::treasury::Treasury<T0>, arg1: address, arg2: &0x2::tx_context::TxContext) {
        0x8f4c60a713f28c458e357e134d04d22057daa3f069b502e18aeb3592df68acbb::treasury::assert_is_compatible<T0>(arg0);
        0x8f4c60a713f28c458e357e134d04d22057daa3f069b502e18aeb3592df68acbb::roles::update_pauser<T0>(0x8f4c60a713f28c458e357e134d04d22057daa3f069b502e18aeb3592df68acbb::treasury::roles_mut<T0>(arg0), arg1, arg2);
    }

    // decompiled from Move bytecode v7
}

