module 0xc13be20fcc7fd189c8894349761226222e973cb7c596aa9c4868d0ce152f2a46::entry {
    entry fun accept_ownership<T0>(arg0: &mut 0xc13be20fcc7fd189c8894349761226222e973cb7c596aa9c4868d0ce152f2a46::treasury::Treasury<T0>, arg1: &0x2::tx_context::TxContext) {
        0xc13be20fcc7fd189c8894349761226222e973cb7c596aa9c4868d0ce152f2a46::treasury::assert_is_compatible<T0>(arg0);
        0xc13be20fcc7fd189c8894349761226222e973cb7c596aa9c4868d0ce152f2a46::two_step_role::accept_role<0xc13be20fcc7fd189c8894349761226222e973cb7c596aa9c4868d0ce152f2a46::roles::OwnerRole<T0>>(0xc13be20fcc7fd189c8894349761226222e973cb7c596aa9c4868d0ce152f2a46::roles::owner_role_mut<T0>(0xc13be20fcc7fd189c8894349761226222e973cb7c596aa9c4868d0ce152f2a46::treasury::roles_mut<T0>(arg0)), arg1);
    }

    entry fun transfer_ownership<T0>(arg0: &mut 0xc13be20fcc7fd189c8894349761226222e973cb7c596aa9c4868d0ce152f2a46::treasury::Treasury<T0>, arg1: address, arg2: &0x2::tx_context::TxContext) {
        0xc13be20fcc7fd189c8894349761226222e973cb7c596aa9c4868d0ce152f2a46::treasury::assert_is_compatible<T0>(arg0);
        0xc13be20fcc7fd189c8894349761226222e973cb7c596aa9c4868d0ce152f2a46::two_step_role::begin_role_transfer<0xc13be20fcc7fd189c8894349761226222e973cb7c596aa9c4868d0ce152f2a46::roles::OwnerRole<T0>>(0xc13be20fcc7fd189c8894349761226222e973cb7c596aa9c4868d0ce152f2a46::roles::owner_role_mut<T0>(0xc13be20fcc7fd189c8894349761226222e973cb7c596aa9c4868d0ce152f2a46::treasury::roles_mut<T0>(arg0)), arg1, arg2);
    }

    entry fun update_blocklister<T0>(arg0: &mut 0xc13be20fcc7fd189c8894349761226222e973cb7c596aa9c4868d0ce152f2a46::treasury::Treasury<T0>, arg1: address, arg2: &0x2::tx_context::TxContext) {
        0xc13be20fcc7fd189c8894349761226222e973cb7c596aa9c4868d0ce152f2a46::treasury::assert_is_compatible<T0>(arg0);
        0xc13be20fcc7fd189c8894349761226222e973cb7c596aa9c4868d0ce152f2a46::roles::update_blocklister<T0>(0xc13be20fcc7fd189c8894349761226222e973cb7c596aa9c4868d0ce152f2a46::treasury::roles_mut<T0>(arg0), arg1, arg2);
    }

    entry fun update_master_minter<T0>(arg0: &mut 0xc13be20fcc7fd189c8894349761226222e973cb7c596aa9c4868d0ce152f2a46::treasury::Treasury<T0>, arg1: address, arg2: &0x2::tx_context::TxContext) {
        0xc13be20fcc7fd189c8894349761226222e973cb7c596aa9c4868d0ce152f2a46::treasury::assert_is_compatible<T0>(arg0);
        0xc13be20fcc7fd189c8894349761226222e973cb7c596aa9c4868d0ce152f2a46::roles::update_master_minter<T0>(0xc13be20fcc7fd189c8894349761226222e973cb7c596aa9c4868d0ce152f2a46::treasury::roles_mut<T0>(arg0), arg1, arg2);
    }

    entry fun update_metadata_updater<T0>(arg0: &mut 0xc13be20fcc7fd189c8894349761226222e973cb7c596aa9c4868d0ce152f2a46::treasury::Treasury<T0>, arg1: address, arg2: &0x2::tx_context::TxContext) {
        0xc13be20fcc7fd189c8894349761226222e973cb7c596aa9c4868d0ce152f2a46::treasury::assert_is_compatible<T0>(arg0);
        0xc13be20fcc7fd189c8894349761226222e973cb7c596aa9c4868d0ce152f2a46::roles::update_metadata_updater<T0>(0xc13be20fcc7fd189c8894349761226222e973cb7c596aa9c4868d0ce152f2a46::treasury::roles_mut<T0>(arg0), arg1, arg2);
    }

    entry fun update_pauser<T0>(arg0: &mut 0xc13be20fcc7fd189c8894349761226222e973cb7c596aa9c4868d0ce152f2a46::treasury::Treasury<T0>, arg1: address, arg2: &0x2::tx_context::TxContext) {
        0xc13be20fcc7fd189c8894349761226222e973cb7c596aa9c4868d0ce152f2a46::treasury::assert_is_compatible<T0>(arg0);
        0xc13be20fcc7fd189c8894349761226222e973cb7c596aa9c4868d0ce152f2a46::roles::update_pauser<T0>(0xc13be20fcc7fd189c8894349761226222e973cb7c596aa9c4868d0ce152f2a46::treasury::roles_mut<T0>(arg0), arg1, arg2);
    }

    // decompiled from Move bytecode v7
}

