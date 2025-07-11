module 0x97c7571f4406cdd7a95f3027075ab80d3e9c937c2a567690d31e14ab1872ccee::entry {
    entry fun accept_ownership<T0>(arg0: &mut 0x97c7571f4406cdd7a95f3027075ab80d3e9c937c2a567690d31e14ab1872ccee::treasury::Treasury<T0>, arg1: &0x2::tx_context::TxContext) {
        0x97c7571f4406cdd7a95f3027075ab80d3e9c937c2a567690d31e14ab1872ccee::treasury::assert_is_compatible<T0>(arg0);
        0x97c7571f4406cdd7a95f3027075ab80d3e9c937c2a567690d31e14ab1872ccee::two_step_role::accept_role<0x97c7571f4406cdd7a95f3027075ab80d3e9c937c2a567690d31e14ab1872ccee::roles::OwnerRole<T0>>(0x97c7571f4406cdd7a95f3027075ab80d3e9c937c2a567690d31e14ab1872ccee::roles::owner_role_mut<T0>(0x97c7571f4406cdd7a95f3027075ab80d3e9c937c2a567690d31e14ab1872ccee::treasury::roles_mut<T0>(arg0)), arg1);
    }

    entry fun transfer_ownership<T0>(arg0: &mut 0x97c7571f4406cdd7a95f3027075ab80d3e9c937c2a567690d31e14ab1872ccee::treasury::Treasury<T0>, arg1: address, arg2: &0x2::tx_context::TxContext) {
        0x97c7571f4406cdd7a95f3027075ab80d3e9c937c2a567690d31e14ab1872ccee::treasury::assert_is_compatible<T0>(arg0);
        0x97c7571f4406cdd7a95f3027075ab80d3e9c937c2a567690d31e14ab1872ccee::two_step_role::begin_role_transfer<0x97c7571f4406cdd7a95f3027075ab80d3e9c937c2a567690d31e14ab1872ccee::roles::OwnerRole<T0>>(0x97c7571f4406cdd7a95f3027075ab80d3e9c937c2a567690d31e14ab1872ccee::roles::owner_role_mut<T0>(0x97c7571f4406cdd7a95f3027075ab80d3e9c937c2a567690d31e14ab1872ccee::treasury::roles_mut<T0>(arg0)), arg1, arg2);
    }

    entry fun update_blocklister<T0>(arg0: &mut 0x97c7571f4406cdd7a95f3027075ab80d3e9c937c2a567690d31e14ab1872ccee::treasury::Treasury<T0>, arg1: address, arg2: &0x2::tx_context::TxContext) {
        0x97c7571f4406cdd7a95f3027075ab80d3e9c937c2a567690d31e14ab1872ccee::treasury::assert_is_compatible<T0>(arg0);
        0x97c7571f4406cdd7a95f3027075ab80d3e9c937c2a567690d31e14ab1872ccee::roles::update_blocklister<T0>(0x97c7571f4406cdd7a95f3027075ab80d3e9c937c2a567690d31e14ab1872ccee::treasury::roles_mut<T0>(arg0), arg1, arg2);
    }

    entry fun update_master_minter<T0>(arg0: &mut 0x97c7571f4406cdd7a95f3027075ab80d3e9c937c2a567690d31e14ab1872ccee::treasury::Treasury<T0>, arg1: address, arg2: &0x2::tx_context::TxContext) {
        0x97c7571f4406cdd7a95f3027075ab80d3e9c937c2a567690d31e14ab1872ccee::treasury::assert_is_compatible<T0>(arg0);
        0x97c7571f4406cdd7a95f3027075ab80d3e9c937c2a567690d31e14ab1872ccee::roles::update_master_minter<T0>(0x97c7571f4406cdd7a95f3027075ab80d3e9c937c2a567690d31e14ab1872ccee::treasury::roles_mut<T0>(arg0), arg1, arg2);
    }

    entry fun update_metadata_updater<T0>(arg0: &mut 0x97c7571f4406cdd7a95f3027075ab80d3e9c937c2a567690d31e14ab1872ccee::treasury::Treasury<T0>, arg1: address, arg2: &0x2::tx_context::TxContext) {
        0x97c7571f4406cdd7a95f3027075ab80d3e9c937c2a567690d31e14ab1872ccee::treasury::assert_is_compatible<T0>(arg0);
        0x97c7571f4406cdd7a95f3027075ab80d3e9c937c2a567690d31e14ab1872ccee::roles::update_metadata_updater<T0>(0x97c7571f4406cdd7a95f3027075ab80d3e9c937c2a567690d31e14ab1872ccee::treasury::roles_mut<T0>(arg0), arg1, arg2);
    }

    entry fun update_pauser<T0>(arg0: &mut 0x97c7571f4406cdd7a95f3027075ab80d3e9c937c2a567690d31e14ab1872ccee::treasury::Treasury<T0>, arg1: address, arg2: &0x2::tx_context::TxContext) {
        0x97c7571f4406cdd7a95f3027075ab80d3e9c937c2a567690d31e14ab1872ccee::treasury::assert_is_compatible<T0>(arg0);
        0x97c7571f4406cdd7a95f3027075ab80d3e9c937c2a567690d31e14ab1872ccee::roles::update_pauser<T0>(0x97c7571f4406cdd7a95f3027075ab80d3e9c937c2a567690d31e14ab1872ccee::treasury::roles_mut<T0>(arg0), arg1, arg2);
    }

    // decompiled from Move bytecode v6
}

